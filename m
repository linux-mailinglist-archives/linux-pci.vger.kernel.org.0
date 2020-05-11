Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 141A91CE0A2
	for <lists+linux-pci@lfdr.de>; Mon, 11 May 2020 18:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729956AbgEKQh3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 May 2020 12:37:29 -0400
Received: from mga04.intel.com ([192.55.52.120]:7552 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729698AbgEKQh3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 May 2020 12:37:29 -0400
IronPort-SDR: +qZF21WUvXRpszjtVyML2UVp4MlhIvuAjh3T42R97kqW0kFDnMYsFmwHQsXpEjH8aPZ02v9ztN
 YftUoQfjEEOw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2020 09:37:28 -0700
IronPort-SDR: AZc2hY4dxXTb7qjFXV8I9k2QGf8NXz8ajbhTHCiWnMUKA3IHkiRA1w6aixz+yRjesa/DS1hgzb
 RUHsoMgxZJrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,380,1583222400"; 
   d="scan'208";a="286334380"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.116.74])
  by fmsmga004.fm.intel.com with ESMTP; 11 May 2020 09:37:09 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     <linux-pci@vger.kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Rob Herring <robh@kernel.org>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH v2 2/4] PCI: pci-bridge-emul: Fix Root Cap/Status comment
Date:   Mon, 11 May 2020 12:21:15 -0400
Message-Id: <20200511162117.6674-3-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20200511162117.6674-1-jonathan.derrick@intel.com>
References: <20200511162117.6674-1-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The upper 16-bits of Root Control contain the Root Capabilities
register. The code instead describes the Root Status register in the
upper 16-bits, although it uses the correct bit definition for Root
Capabilities, and for Root Status in the next definition.

Fix this comment and add a comment describing the Root Status register.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/pci-bridge-emul.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-bridge-emul.c b/drivers/pci/pci-bridge-emul.c
index faa414655f33..c00c30ffb198 100644
--- a/drivers/pci/pci-bridge-emul.c
+++ b/drivers/pci/pci-bridge-emul.c
@@ -234,7 +234,7 @@ static const struct pci_bridge_reg_behavior pcie_cap_regs_behavior[] = {
 		 * Root control has bits [4:0] RW, the rest is
 		 * reserved.
 		 *
-		 * Root status has bit 0 RO, the rest is reserved.
+		 * Root capabilities has bit 0 RO, the rest is reserved.
 		 */
 		.rw = (PCI_EXP_RTCTL_SECEE | PCI_EXP_RTCTL_SENFEE |
 		       PCI_EXP_RTCTL_SEFEE | PCI_EXP_RTCTL_PMEIE |
@@ -244,6 +244,10 @@ static const struct pci_bridge_reg_behavior pcie_cap_regs_behavior[] = {
 	},
 
 	[PCI_EXP_RTSTA / 4] = {
+		/*
+		 * Root status has bits 17 and [15:0] RO, bit 16 W1C, the rest
+		 * is reserved.
+		 */
 		.ro = GENMASK(15, 0) | PCI_EXP_RTSTA_PENDING,
 		.w1c = PCI_EXP_RTSTA_PME,
 		.rsvd = GENMASK(31, 18),
-- 
2.18.1

