Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D42445DE42
	for <lists+linux-pci@lfdr.de>; Thu, 25 Nov 2021 17:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355456AbhKYQHJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Nov 2021 11:07:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:35136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356143AbhKYQFI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Nov 2021 11:05:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 567FA61107;
        Thu, 25 Nov 2021 16:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637856117;
        bh=75XCS9ViPTB0ozl2yTxz4Nm2qCRVNf5SvAMpC1qHWzg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e2YjADnvF2c+gxMTEJ4UAXYPW7EJMpxSlbSuSaxER+K9FTgYl0n2JHnyY0Os8dssK
         z/88CuJYnCoxZdx9bO44CZ17c4+kdYpLlrX0wiSr3rSTdvA7KGsF9aMV0emZM+zMH8
         uuzMQRl6F9SJdTWKYEDG5hzsaNBIldKfMpC6vAvxzWEP+P4SBTB+6eLIKdmmh+4DpE
         H/qAITLxvd1+2Z94HtvU0qiLxoHcC00cIVvFlm4VMYjBMuX3DrSxWsHppGs7DCYB3e
         c1Ld/8njj4UzIF6jbZaxj7QY8sAfkpEXDtsU5ATZWI94kQvOJ305eB03sAeAF7T8em
         IWl84MmZ195Ag==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, pali@kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH pci-fixes 1/2] PCI: aardvark: Fix checking for MEM resource type
Date:   Thu, 25 Nov 2021 17:01:47 +0100
Message-Id: <20211125160148.26029-2-kabel@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211125160148.26029-1-kabel@kernel.org>
References: <20211125160148.26029-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

IORESOURCE_MEM_64 is not type but type flag. Remove incorrect check for
type IORESOURCE_MEM_64.

Fixes: 64f160e19e92 ("PCI: aardvark: Configure PCIe resources from 'ranges' DT property")
Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index c5300d49807a..baa62cdcaab4 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1544,8 +1544,7 @@ static int advk_pcie_probe(struct platform_device *pdev)
 		 * only PIO for issuing configuration transfers which does
 		 * not use PCIe window configuration.
 		 */
-		if (type != IORESOURCE_MEM && type != IORESOURCE_MEM_64 &&
-		    type != IORESOURCE_IO)
+		if (type != IORESOURCE_MEM && type != IORESOURCE_IO)
 			continue;
 
 		/*
@@ -1553,8 +1552,7 @@ static int advk_pcie_probe(struct platform_device *pdev)
 		 * configuration is set to transparent memory access so it
 		 * does not need window configuration.
 		 */
-		if ((type == IORESOURCE_MEM || type == IORESOURCE_MEM_64) &&
-		    entry->offset == 0)
+		if (type == IORESOURCE_MEM && entry->offset == 0)
 			continue;
 
 		/*
-- 
2.32.0

