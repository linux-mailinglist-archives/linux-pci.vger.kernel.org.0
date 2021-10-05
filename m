Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE7CE422FAE
	for <lists+linux-pci@lfdr.de>; Tue,  5 Oct 2021 20:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbhJESLv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Oct 2021 14:11:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:39100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233821AbhJESLu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Oct 2021 14:11:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D95F613E6;
        Tue,  5 Oct 2021 18:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633457400;
        bh=gTcUVASfth1kANfGr+Kwpo9faIRmuN1V6YiKH10nP0o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=omyI9ya5Q6ystMVcUP6piF3dajQfCgZwKfNUphYch3wZQzq7qcyWTbsVRGys+8PLA
         FyGKmE24OpADdoGsWL2tUYVqco7jOI7rVee1Bs9wk04QA3j0WjxU/rdhC2lnxOxrot
         /Uh3QAIaINekaTqqTKVMAsq0S1H/nQt8Psaf1lQBa6D82YbCcFzRnB6q62aky441Me
         5ClCAMwOD0ikRfslcAiRKq8Dmds++hs72bZuk8vANz7Ew0/owI4MdjK/iWzNiDm19C
         9QmTqqnPjqvPnzDQ1FpcIrXpC6tlWwSJABJWYbvdmldYPUxLKLxHINYJlwaV6TuYUD
         xUs4q5cx1h9WA==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        pali@kernel.org, =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v2 03/13] PCI: aardvark: Don't spam about PIO Response Status
Date:   Tue,  5 Oct 2021 20:09:42 +0200
Message-Id: <20211005180952.6812-4-kabel@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211005180952.6812-1-kabel@kernel.org>
References: <20211005180952.6812-1-kabel@kernel.org>
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

