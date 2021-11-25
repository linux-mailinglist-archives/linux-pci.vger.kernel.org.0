Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4922245DA53
	for <lists+linux-pci@lfdr.de>; Thu, 25 Nov 2021 13:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354849AbhKYMv4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Nov 2021 07:51:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:45606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354657AbhKYMvr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Nov 2021 07:51:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EC7A06113A;
        Thu, 25 Nov 2021 12:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637844404;
        bh=KCtYPffRqVHBtYw7sAB0t28qNlEFwS3xDyAknC6AO+8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d95IwIRJOHxQXlTYX3JKRREc2fJIC8ojDIZpx5lM3rcShz1ijwt9y79ybml0xmgmQ
         q0EgPt15+6aWA0dV/+eESEPlRXwjUSwkCxwfLgI7lwyDjqtCnqzi5aYx4bd77+ipdK
         Oz//kqL/R5UNQSUTUoLsmDFcdGtpoq56ShnGIC513NW6Rs93Kjq2kap+LpxSCQ2M6n
         o3Tsa9Rgp6EuAABJpazN8rUv7gQRz2WZjO2wLHJGWonvactjiodkP3dEq6iyw5AeyP
         L1nZ3OyekGhszZKL/4sJRYFYo5d/5MvtimRkgPyq0PliCvtl+lg3MBjOHcXgM05jtJ
         1IWnX8IH1J0Jw==
Received: by pali.im (Postfix)
        id AD86167E; Thu, 25 Nov 2021 13:46:43 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 13/15] PCI: mvebu: Fix support for PCI_EXP_DEVCTL on emulated bridge
Date:   Thu, 25 Nov 2021 13:46:03 +0100
Message-Id: <20211125124605.25915-14-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211125124605.25915-1-pali@kernel.org>
References: <20211125124605.25915-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Comment in Armada 370 functional specification is misleading.
PCI_EXP_DEVCTL_*RE bits are supported and configures receiving of error
interrupts.

Signed-off-by: Pali Rohár <pali@kernel.org>
Fixes: 1f08673eef12 ("PCI: mvebu: Convert to PCI emulated bridge config space")
Cc: stable@vger.kernel.org
---
 drivers/pci/controller/pci-mvebu.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 3075ea98c131..c9b736344b56 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -545,9 +545,7 @@ mvebu_pci_bridge_emul_pcie_conf_read(struct pci_bridge_emul *bridge,
 		break;
 
 	case PCI_EXP_DEVCTL:
-		*value = mvebu_readl(port, PCIE_CAP_PCIEXP + PCI_EXP_DEVCTL) &
-				 ~(PCI_EXP_DEVCTL_URRE | PCI_EXP_DEVCTL_FERE |
-				   PCI_EXP_DEVCTL_NFERE | PCI_EXP_DEVCTL_CERE);
+		*value = mvebu_readl(port, PCIE_CAP_PCIEXP + PCI_EXP_DEVCTL);
 		break;
 
 	case PCI_EXP_LNKCAP:
@@ -658,13 +656,6 @@ mvebu_pci_bridge_emul_pcie_conf_write(struct pci_bridge_emul *bridge,
 
 	switch (reg) {
 	case PCI_EXP_DEVCTL:
-		/*
-		 * Armada370 data says these bits must always
-		 * be zero when in root complex mode.
-		 */
-		new &= ~(PCI_EXP_DEVCTL_URRE | PCI_EXP_DEVCTL_FERE |
-			 PCI_EXP_DEVCTL_NFERE | PCI_EXP_DEVCTL_CERE);
-
 		mvebu_writel(port, new, PCIE_CAP_PCIEXP + PCI_EXP_DEVCTL);
 		break;
 
-- 
2.20.1

