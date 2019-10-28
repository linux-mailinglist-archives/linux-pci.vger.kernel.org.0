Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3403AE7636
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2019 17:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730794AbfJ1QdA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Oct 2019 12:33:00 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34811 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730772AbfJ1QdA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Oct 2019 12:33:00 -0400
Received: by mail-oi1-f193.google.com with SMTP id 83so6431464oii.1;
        Mon, 28 Oct 2019 09:32:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S4uLFulX8TejWtV4ZtyYdW8FASYgTH1zgpN3OAUfA44=;
        b=tudsZo7CwHXEDIVvgFupALH2xUYk9k/FHjDZ3Xi6YNa8TZiYMvEZj6gssv227fk42D
         bbaLHHmxg6aidH+RvqWDmqP9wVBKOCNNr1bZf8mbyqpfY0V5D3+uQ19dwU2AkQlGrd5c
         hpHvJDQGZk7fQdEeOM8KMfCTZuTrphDDS1HndeCmIuCXY+EjQhusKYw2k3S8ZUFEuCMO
         OSQVg6565BwfqboHkCJ7Na2eCt5hDmmBUVVQuJkrjShQ5df2eZLM6AR0gVo4aXHRblYb
         wlFpSG4TTJycqeoWv2GTRiN/LwkUKKfnXHHfL6r6KBVGZahYEF5Cu03BnkY23mQpO698
         HUTA==
X-Gm-Message-State: APjAAAUlSEzwtVTJIipI64smUZxIx+56augXE33CYkqCNPx1c9/ExkZX
        gwq88XQQeGHefClzULeUfg==
X-Google-Smtp-Source: APXvYqyCyIe7/lBj2r50NZZKCcouW4Wf/nGhcgVbzzr1X9sEHMnBAu+xzJCM7OskSMNAePIBybe/OA==
X-Received: by 2002:aca:5015:: with SMTP id e21mr137789oib.174.1572280379222;
        Mon, 28 Oct 2019 09:32:59 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id e186sm354991oia.47.2019.10.28.09.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 09:32:58 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        Christoph Hellwig <hch@infradead.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
        Ley Foon Tan <lftan@altera.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Ray Jui <rjui@broadcom.com>, rfi@lists.rocketboards.org,
        Ryder Lee <ryder.lee@mediatek.com>,
        Scott Branden <sbranden@broadcom.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Horman <horms@verge.net.au>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Toan Le <toan@os.amperecomputing.com>,
        Tom Joseph <tjoseph@cadence.com>, Will Deacon <will@kernel.org>
Subject: [PATCH v3 00/25] PCI host resource consolidation
Date:   Mon, 28 Oct 2019 11:32:31 -0500
Message-Id: <20191028163256.8004-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This started with just dma-ranges parsing consolidation, but has expanded
to converting all host drivers to use pci_parse_request_of_pci_ranges()
rather than devm_of_pci_get_host_bridge_resources(). This series moves
the DT 'dma-ranges' parsing into common helpers utilizing a resource list.
There's no (intended) functional change in this series though I'm also
working on a separate series now in dt/next to improve the handling of
'dma-ranges' and dma masks.

The last patch may need to wait if there's any new users of
devm_of_pci_get_host_bridge_resources.

Only versatile has been tested (on QEMU). The rest is compiled only. A git
branch is here[1].

v3:
- Fix >80 char lines
- Rename resource_list_get_entry_of_type to resource_list_first_type

Rob

[1] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git pci-ranges-cleanup-v3


Rob Herring (25):
  resource: Add a resource_list_first_type helper
  PCI: Export pci_parse_request_of_pci_ranges()
  PCI: aardvark: Use pci_parse_request_of_pci_ranges()
  PCI: altera: Use pci_parse_request_of_pci_ranges()
  PCI: dwc: Use pci_parse_request_of_pci_ranges()
  PCI: faraday: Use pci_parse_request_of_pci_ranges()
  PCI: iproc: Use pci_parse_request_of_pci_ranges()
  PCI: mediatek: Use pci_parse_request_of_pci_ranges()
  PCI: mobiveil: Use pci_parse_request_of_pci_ranges()
  PCI: rockchip: Use pci_parse_request_of_pci_ranges()
  PCI: rockchip: Drop storing driver private outbound resource data
  PCI: v3-semi: Use pci_parse_request_of_pci_ranges()
  PCI: xgene: Use pci_parse_request_of_pci_ranges()
  PCI: xilinx: Use pci_parse_request_of_pci_ranges()
  PCI: xilinx-nwl: Use pci_parse_request_of_pci_ranges()
  PCI: versatile: Use pci_parse_request_of_pci_ranges()
  PCI: versatile: Remove usage of PHYS_OFFSET
  PCI: versatile: Enable COMPILE_TEST
  PCI: of: Add inbound resource parsing to helpers
  PCI: ftpci100: Use inbound resources for setup
  PCI: v3-semi: Use inbound resources for setup
  PCI: xgene: Use inbound resources for setup
  PCI: iproc: Use inbound resources for setup
  PCI: rcar: Use inbound resources for setup
  PCI: Make devm_of_pci_get_host_bridge_resources() static

 drivers/pci/controller/Kconfig                |  2 +-
 .../pci/controller/dwc/pcie-designware-host.c | 29 ++----
 drivers/pci/controller/pci-aardvark.c         | 60 +------------
 drivers/pci/controller/pci-ftpci100.c         | 79 +++++-----------
 drivers/pci/controller/pci-host-common.c      |  2 +-
 drivers/pci/controller/pci-v3-semi.c          | 74 +++++----------
 drivers/pci/controller/pci-versatile.c        | 71 ++++-----------
 drivers/pci/controller/pci-xgene.c            | 73 +++++----------
 drivers/pci/controller/pcie-altera.c          | 41 +--------
 drivers/pci/controller/pcie-cadence-host.c    |  2 +-
 drivers/pci/controller/pcie-iproc-platform.c  |  9 +-
 drivers/pci/controller/pcie-iproc.c           | 82 ++++-------------
 drivers/pci/controller/pcie-mediatek.c        | 43 +++------
 drivers/pci/controller/pcie-mobiveil.c        | 27 ++----
 drivers/pci/controller/pcie-rcar.c            | 48 ++++------
 drivers/pci/controller/pcie-rockchip-host.c   | 89 +++++++------------
 drivers/pci/controller/pcie-rockchip.h        |  5 --
 drivers/pci/controller/pcie-xilinx-nwl.c      | 21 ++---
 drivers/pci/controller/pcie-xilinx.c          | 18 +---
 drivers/pci/of.c                              | 51 +++++++++--
 drivers/pci/pci.h                             | 13 ---
 include/linux/pci.h                           |  9 +-
 include/linux/resource_ext.h                  | 12 +++
 23 files changed, 261 insertions(+), 599 deletions(-)

--
2.20.1
