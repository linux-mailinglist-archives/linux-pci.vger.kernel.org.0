Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFB449D2B6
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jan 2022 20:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244525AbiAZTu7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Jan 2022 14:50:59 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:46865 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231611AbiAZTu7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Jan 2022 14:50:59 -0500
X-IronPort-AV: E=Sophos;i="5.88,319,1635174000"; 
   d="scan'208";a="107765993"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 27 Jan 2022 04:50:57 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 7F9404008541;
        Thu, 27 Jan 2022 04:50:54 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [RFC PATCH 0/5] PCIe EPF support for internal DMAC handling and driver update for R-Car PCIe EP to support DMAC
Date:   Wed, 26 Jan 2022 19:50:38 +0000
Message-Id: <20220126195043.28376-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi All,

The current PCIe EPF framework supports DMA data transfers using external
DMA only, this patch series aims to add support for platforms supporting
internal DMAC on PCIe for data transfers.

R-Car PCIe supports internal DMAC to transfer data between Internal Bus to
PCI Express and vice versa. Last patch fills up the required flags and ops
to support internal DMAC.

Patches 1-3 are for PCIe EPF core to support internal DMAC handling, patch
4/5 is to fix test cases based on the conversation [1].

Patches are based on top of [1] next branch.

[0] https://www.spinics.net/lists/linux-pci/msg92385.html
[1] https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git

Cheers,
Prabhakar

Lad Prabhakar (5):
  PCI: endpoint: Add ops and flag to support internal DMAC
  PCI: endpoint: Add support to data transfer using internal dmac
  misc: pci_endpoint_test: Add driver data for Renesas RZ/G2{EHMN}
  misc: pci_endpoint_test: Add support to pass flags for buffer
    allocation
  PCI: rcar-ep: Add support for DMAC

 drivers/misc/pci_endpoint_test.c              |  56 ++++-
 drivers/pci/controller/pcie-rcar-ep.c         | 227 ++++++++++++++++++
 drivers/pci/controller/pcie-rcar.h            |  23 ++
 drivers/pci/endpoint/functions/pci-epf-test.c | 184 ++++++++++----
 drivers/pci/endpoint/pci-epf-core.c           |  32 +++
 include/linux/pci-epc.h                       |   8 +
 include/linux/pci-epf.h                       |   7 +
 7 files changed, 483 insertions(+), 54 deletions(-)

-- 
2.25.1

