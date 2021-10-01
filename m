Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 437CA41F603
	for <lists+linux-pci@lfdr.de>; Fri,  1 Oct 2021 21:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241606AbhJAUAu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Oct 2021 16:00:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:42964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229916AbhJAUAt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Oct 2021 16:00:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0ED12619EE;
        Fri,  1 Oct 2021 19:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633118345;
        bh=gTcUVASfth1kANfGr+Kwpo9faIRmuN1V6YiKH10nP0o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t8c8Ugi/JF2MTfTPU6zchK5N71RewQQ5EN60YYEPlghxHMv3J5RyLZWOHOrdR8RpT
         IA4z2MDQpm5pr4IJQzRFNqES7qsx+WZXg8Oadi64NdHHtA0TtjZJTTwTWvYxZaJd9c
         KWJZYiE78/0OlHD+fdZp8NrVUyxs0CoY4OgVRlXnScuf80HwMF200C3Y8+KivnbtZ8
         RLkfB3s+RUJkh4az6uo9n4UyHO4dcrBChkj66aoIxH0gmUxn06JMpSg9VN3vpav/oG
         gZLMvLGFR4axqSfmfC9tWYAGEInImdXR2DJfhEIiAzAtqCVJLohDxU8D+VHOCeOURg
         C44LWEXAIPb6g==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        pali@kernel.org, =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 03/13] PCI: aardvark: Don't spam about PIO Response Status
Date:   Fri,  1 Oct 2021 21:58:46 +0200
Message-Id: <20211001195856.10081-4-kabel@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211001195856.10081-1-kabel@kernel.org>
References: <20211001195856.10081-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use dev_dbg() instead of dev_err() in advk_pcie_check_pio_status().

For example CRS is not an error status, it just says that the request
should be retried.

Fixes: 8c39d710363c1 ("PCI: aardvark: Add Aardvark PCI host controller driver")
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 884510630bae..a7903c531aa3 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -683,7 +683,7 @@ static int advk_pcie_check_pio_status(struct advk_pcie *pcie, bool allow_crs, u3
 	else
 		str_posted = "Posted";
 
-	dev_err(dev, "%s PIO Response Status: %s, %#x @ %#x\n",
+	dev_dbg(dev, "%s PIO Response Status: %s, %#x @ %#x\n",
 		str_posted, strcomp_status, reg, advk_readl(pcie, PIO_ADDR_LS));
 
 	return -EFAULT;
-- 
2.32.0

