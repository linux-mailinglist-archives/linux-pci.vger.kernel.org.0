Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7CC8BFC3E
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2019 02:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbfI0AY7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Sep 2019 20:24:59 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44994 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbfI0AY6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Sep 2019 20:24:58 -0400
Received: by mail-ot1-f67.google.com with SMTP id 21so755165otj.11;
        Thu, 26 Sep 2019 17:24:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MDoHopVetDd/ID0m+/zdRqZFxmnQtClQZalMwkfcSrM=;
        b=esP6iMYGDGzhd2yr3ZB5vGuLw1YMlsVq+M+KKOE/U00vUN1z6C647D+txTVmJ8m6Tl
         +Cz9tZWKUt6Qd1+2bW4FTsk7khk9a5UjnyE1n/Dju3U06iaSUfMUahy2NgJfpb/fRC+k
         kpyfGIZw8eiYdI25RuFUwEJn+bn/TLpRVovCLbcwfqRV3I3uT9A5Ch0o4Vm+eqMFEcSv
         yxfDBGvJFirA6iGM9TspT4+9FeFYbIXVb40EiDgPZJf6C2mrzhEAvqD5fQSQ0Pg8rdnI
         h8mO53yppJoWUpLr+JnSV79JRkCoZsNbLQPmLtD44JhL/267OrDg9XgZVg0x4Xlz4PHk
         f32Q==
X-Gm-Message-State: APjAAAWL0bHNftWvPDv0Orl5A9XpvfIy2xYC0O2OvIIan4jbu4kReVEP
        iUlxH36dgO1wbAsnrXai0VJlu5Y=
X-Google-Smtp-Source: APXvYqzH15vdHiGFUOLjLKdgsmpn5XMUNzTaDYTgGKc/l7EtTHCuYhD8i0suwTNWM2dQUMH+HskLHw==
X-Received: by 2002:a9d:3e52:: with SMTP id h18mr1048250otg.275.1569543897338;
        Thu, 26 Sep 2019 17:24:57 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id j11sm339866otk.80.2019.09.26.17.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 17:24:56 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Stefan Wahren <wahrenst@gmx.net>,
        Frank Rowand <frowand.list@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Marek Vasut <marek.vasut@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Oza Pawandeep <oza.oza@broadcom.com>
Subject: [PATCH 00/11] of: dma-ranges fixes and improvements
Date:   Thu, 26 Sep 2019 19:24:44 -0500
Message-Id: <20190927002455.13169-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series fixes several issues related to 'dma-ranges'. Primarily,
'dma-ranges' in a PCI bridge node does correctly set dma masks for PCI
devices not described in the DT. A common case needing dma-ranges is a
32-bit PCIe bridge on a 64-bit system. This affects several platforms
including Broadcom, NXP, Renesas, and Arm Juno. There's been several
attempts to fix these issues, most recently earlier this week[1].

In the process, I found several bugs in the address translation. It
appears that things have happened to work as various DTs happen to use
1:1 addresses.

First 3 patches are just some clean-up. The 4th patch adds a unittest
exhibiting the issues. Patches 5-9 rework how of_dma_configure() works
making it work on either a struct device child node or a struct
device_node parent node so that it works on bus leaf nodes like PCI
bridges. Patches 10 and 11 fix 2 issues with address translation for
dma-ranges.

My testing on this has been with QEMU virt machine hacked up to set PCI
dma-ranges and the unittest. Nicolas reports this series resolves the
issues on Rpi4 and NXP Layerscape platforms.

Rob

[1] https://lore.kernel.org/linux-arm-kernel/20190924181244.7159-1-nsaenzjulienne@suse.de/

Rob Herring (5):
  of: Remove unused of_find_matching_node_by_address()
  of: Make of_dma_get_range() private
  of/unittest: Add dma-ranges address translation tests
  of/address: Translate 'dma-ranges' for parent nodes missing
    'dma-ranges'
  of/address: Fix of_pci_range_parser_one translation of DMA addresses

Robin Murphy (6):
  of: address: Report of_dma_get_range() errors meaningfully
  of: Ratify of_dma_configure() interface
  of/address: Introduce of_get_next_dma_parent() helper
  of: address: Follow DMA parent for "dma-coherent"
  of: Factor out #{addr,size}-cells parsing
  of: Make of_dma_get_range() work on bus nodes

 drivers/of/address.c                        | 83 +++++++++----------
 drivers/of/base.c                           | 32 ++++---
 drivers/of/device.c                         | 12 ++-
 drivers/of/of_private.h                     | 14 ++++
 drivers/of/unittest-data/testcases.dts      |  1 +
 drivers/of/unittest-data/tests-address.dtsi | 48 +++++++++++
 drivers/of/unittest.c                       | 92 +++++++++++++++++++++
 include/linux/of_address.h                  | 21 +----
 include/linux/of_device.h                   |  4 +-
 9 files changed, 227 insertions(+), 80 deletions(-)
 create mode 100644 drivers/of/unittest-data/tests-address.dtsi

--
2.20.1
