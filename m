Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7911A8CC1
	for <lists+linux-pci@lfdr.de>; Tue, 14 Apr 2020 22:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633347AbgDNUpG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Apr 2020 16:45:06 -0400
Received: from mga17.intel.com ([192.55.52.151]:48105 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2633342AbgDNUpE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Apr 2020 16:45:04 -0400
IronPort-SDR: 0wWp5cjQMRr7K7WGChe0XhW2lOOh3QTT2VEoMrS0RZqhSUdySWi8ZE4jxgVtz8eDoBpp1RaFXW
 WFOEsyvXevsA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 13:45:03 -0700
IronPort-SDR: HbbEdAZnqKqCflw4iQLF1+jlpDSHXr8gOk99pDkc9eQRzCwJ7s8LN6CmGNvRuKjph5T+pekOsU
 vKnENqsT4Y0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,384,1580803200"; 
   d="scan'208";a="288336372"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.116.40])
  by fmsmga002.fm.intel.com with ESMTP; 14 Apr 2020 13:45:03 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     <linux-pci@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH 2/5] PCI: pci-bridge-emul: Fix Root Cap/Status comment
Date:   Tue, 14 Apr 2020 16:30:02 -0400
Message-Id: <20200414203005.5166-3-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20200414203005.5166-1-jonathan.derrick@intel.com>
References: <20200414203005.5166-1-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The upper 16-bits of Root Control contain the Root Capabilities
register. The code instead describes the Root Status register in the
upper 16-bits, although it uses the correct bit definition for Root
Capabilities, and for Root Status in the next definition.

Fix this comment and add a comment describing the Root Status register.

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

