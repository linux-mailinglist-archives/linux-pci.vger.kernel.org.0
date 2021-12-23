Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5477547DCA2
	for <lists+linux-pci@lfdr.de>; Thu, 23 Dec 2021 02:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345715AbhLWBLf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Dec 2021 20:11:35 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:57816 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345711AbhLWBLf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Dec 2021 20:11:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7E461CE1F02;
        Thu, 23 Dec 2021 01:11:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F11C36AEB;
        Thu, 23 Dec 2021 01:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640221891;
        bh=f04xaSCWCbCEFfwG/HFC1grHJ9t6oRK/Bi24pKjCZyI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nvMXfI+W4QtXhYQ0wlO4ZGP5oRI/bDTLIiZQCZnxqDYqFZHNNnvNRAJgUP/uHpaFI
         Rn9nowg/KHh9eBZDc4XPV4b069qKgcgPjfIA56aihCYeI4vpGn1krWcUf+B9HwT/8f
         cs88HTW+jpYAcDiX0IZ9ewhy0+kTetN/aimbDjRNsCaxvXtwjjRo+e48zsZJLV//nb
         eXxp3z8Yo6XzfIEbH6RVTJDc0/GyPVgFJce7STlxmkrxaIh+c33YHrHPtYLWol9c0V
         R6weAMgfvq+8wnxzxkHdsGsul/2lD09fHFT/az/+xOiphMyohTyTI5RB5W36StJ512
         yzvjwvNWecxFw==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org, Fan Fei <ffclaire1224@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 12/23] PCI: iproc: Rename iproc_pcie_pltfm_ to iproc_pltfm_pcie_
Date:   Wed, 22 Dec 2021 19:10:43 -0600
Message-Id: <20211223011054.1227810-13-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211223011054.1227810-1-helgaas@kernel.org>
References: <20211223011054.1227810-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Rename iproc_pcie_pltfm_* to iproc_pltfm_pcie_* for consistency with other
drivers.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/pci/controller/pcie-iproc-platform.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/pcie-iproc-platform.c b/drivers/pci/controller/pcie-iproc-platform.c
index b93e7bda101b..538115246c79 100644
--- a/drivers/pci/controller/pcie-iproc-platform.c
+++ b/drivers/pci/controller/pcie-iproc-platform.c
@@ -37,7 +37,7 @@ static const struct of_device_id iproc_pcie_of_match_table[] = {
 };
 MODULE_DEVICE_TABLE(of, iproc_pcie_of_match_table);
 
-static int iproc_pcie_pltfm_probe(struct platform_device *pdev)
+static int iproc_pltfm_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct iproc_pcie *pcie;
@@ -115,30 +115,30 @@ static int iproc_pcie_pltfm_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int iproc_pcie_pltfm_remove(struct platform_device *pdev)
+static int iproc_pltfm_pcie_remove(struct platform_device *pdev)
 {
 	struct iproc_pcie *pcie = platform_get_drvdata(pdev);
 
 	return iproc_pcie_remove(pcie);
 }
 
-static void iproc_pcie_pltfm_shutdown(struct platform_device *pdev)
+static void iproc_pltfm_pcie_shutdown(struct platform_device *pdev)
 {
 	struct iproc_pcie *pcie = platform_get_drvdata(pdev);
 
 	iproc_pcie_shutdown(pcie);
 }
 
-static struct platform_driver iproc_pcie_pltfm_driver = {
+static struct platform_driver iproc_pltfm_pcie_driver = {
 	.driver = {
 		.name = "iproc-pcie",
 		.of_match_table = of_match_ptr(iproc_pcie_of_match_table),
 	},
-	.probe = iproc_pcie_pltfm_probe,
-	.remove = iproc_pcie_pltfm_remove,
-	.shutdown = iproc_pcie_pltfm_shutdown,
+	.probe = iproc_pltfm_pcie_probe,
+	.remove = iproc_pltfm_pcie_remove,
+	.shutdown = iproc_pltfm_pcie_shutdown,
 };
-module_platform_driver(iproc_pcie_pltfm_driver);
+module_platform_driver(iproc_pltfm_pcie_driver);
 
 MODULE_AUTHOR("Ray Jui <rjui@broadcom.com>");
 MODULE_DESCRIPTION("Broadcom iPROC PCIe platform driver");
-- 
2.25.1

