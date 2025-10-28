Return-Path: <linux-pci+bounces-39545-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5E4C1595A
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 16:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25C003AADD0
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 15:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A334341AC3;
	Tue, 28 Oct 2025 15:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LxJjBx8r"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D092C22A4F8
	for <linux-pci@vger.kernel.org>; Tue, 28 Oct 2025 15:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761666167; cv=none; b=q1FooC7iPEpI4PI/o8UyamEgr4GCqkhM76A/s7DFwZsInx9rusBJLg1L2LE9NsuIrpuiToYB3oipgXP6rDaza7W3meo0Tk+/mBxFShMHVtOBK0ky44A98euDaO1p7eQd/fPnDCFL/PkA3dO7EJYwUZiNA83F8i5GnVsoh3dzFl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761666167; c=relaxed/simple;
	bh=SRGxbsGV3MJee1qdQ/T8atB44Y+1gaZj7JGcpj8g8m4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SvnjLNf0IyacVjtB1wm4/UmpajiySf6nMlILE672gAxFQj4WlZ8VsfVKCZGQHe3TaQpAvB/gwWtmnbtl1J6PcF9uEO+PCzxi5G1UBAIWMGI6MYxlp1rkG7Jo0qKFf2D7Hx4ag/G/au681vAVtSgzXpw3pPmUHju/PBgVOouIbUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LxJjBx8r; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b4fb8d3a2dbso4128421a12.3
        for <linux-pci@vger.kernel.org>; Tue, 28 Oct 2025 08:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761666165; x=1762270965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ATRw3tFFmEK1zPWNKP140zh9kBKwr+zrf40M6SOBpU=;
        b=LxJjBx8r/n5BnwpBeOrRrd+RdhA8sFNosGaPFphB/B7SMf92Cgxp6v2ck3MicJUhIW
         mR8YFkF+doM7kJmKEKfM8ggJR1pGe5d2SFWsYUKZUpnWx9o6H25EGhCOWzaUOtpTh3lA
         Uy5uEpohIrprib3l2KtYCNQuHMhdmmUDHVoAnLFbuFVDgVYAwHrA1sKtD7rptACXRzMA
         iwCOj+I4AgG8sQU/ql68sqvSXPXr+AH9LwnXwDkdU4UaeYaoh4+gU/REmwSxhIue7fWD
         Puyq4FyEk5bPIK7GXmuRCAR1BmwclZFKvUvPLxPFtfuCLzRIgEJ6sBEMsqD/m0/1axmS
         ODaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761666165; x=1762270965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ATRw3tFFmEK1zPWNKP140zh9kBKwr+zrf40M6SOBpU=;
        b=TzKOOttSHgcEAjxLRUudK9CrbBvtEfsvZxohxcgSjLKDB4XhAcp2xkztZ4O2d/+NH4
         zJTu7kixD5kNQuOFQjokUL+kN6EzaKPpTRJPvniTC0xYAafu68bdrxmW4YCunX/QtVWD
         aPhLBXNPkUn2TFb2RUNj0+8nP1+gl5U7PeLR2s/vhXY3UgehJNQCjMzLXzDnG53DCftl
         ol2GZRY587sgHZA5fmJJ8fkI3a3uKsJ2bIzaS6vTQK9njZJ+LKLCjlh983vzyegEhDJK
         CtLNCN3i7NxVb/b96HO53orSwj8a/1Gbm1N0cYIFlYHhnmqXCbZyBiuvEWWSnYwcFi5L
         y+Wg==
X-Forwarded-Encrypted: i=1; AJvYcCWyXvi+eDVK0sq0hpEmaZ8Sz6sHDiOFB2PenCjoJ6eGhFw0SgSfhSg2WwQa4oMlFOkzSxkQLFRMbVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCVmZnt9UlKfqgHbnzJSPV+MB0IIRCP6mTfFgkjB71dG/sXHjh
	augDdnLRkWoaNO+pFUbq8T1xRVB8D1OsQkSdUeHhrHjH6ej1+cV3+V4U
X-Gm-Gg: ASbGncsLYu3hYh/bWwHwlTh8UQ8rAy7p8NcfKwn1j3bR7N/MbGgP6YwU+PBD6z09IcI
	R9q9T3eg0B+gwgQfYodIbwPgtXbudTIB2+ufwIU5PVKr3JTKfQ8wdpq3N8dNT8BZyJKNRSprdcQ
	9T/+NT5SUF25/O2RXpBEmWGcXUJRlB720i0Albwsf+mVp3v8PJsNXXBxCjnRmpBOVMR/5dwOJNG
	9FTvcKTKQvgopQR6mG9AnQrb8XruUXM6Ak0nkJkZw/TsZwB8OH14dd1J5iR9/K0s8a5Iw/dEhWu
	YxAT5VvQWaHc6ft5qs4tacI8EGGTR8NM4w8/5OVuGjrrjWJsf+ZrhO4am3WW9tlQT+3yNPKJ6DR
	C338Y0lGLc4Y95aiNpUR9GY9nJNJXLr3SVN22tgj1IX92xZwqKrRlMT7lCPraHRM5Q8wx9lm0Jw
	==
X-Google-Smtp-Source: AGHT+IFX1XKPhnz3Nfvrc+6BGz+aJT/D7E5JuxSlko5PpiJVk9W0Dbe0cl4ODkgGZEnXaVBp1Weykg==
X-Received: by 2002:a17:903:2348:b0:24c:cca1:7cfc with SMTP id d9443c01a7336-294cb6756bdmr53895455ad.59.1761666164805;
        Tue, 28 Oct 2025 08:42:44 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.108])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d0a4d9sm119815145ad.37.2025.10.28.08.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 08:42:44 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-omap@vger.kernel.org (open list:PCI DRIVER FOR TI DRA7XX/J721E),
	linux-pci@vger.kernel.org (open list:PCI DRIVER FOR TI DRA7XX/J721E),
	linux-arm-kernel@lists.infradead.org (moderated list:PCI DRIVER FOR TI DRA7XX/J721E),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>,
	Markus Elfring <Markus.Elfring@web.de>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v3 1/2] PCI: j721e: Use devm_clk_get_optional_enabled() to get the clock
Date: Tue, 28 Oct 2025 21:12:23 +0530
Message-ID: <20251028154229.6774-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251028154229.6774-1-linux.amoon@gmail.com>
References: <20251028154229.6774-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use devm_clk_get_optional_enabled() helper instead of calling
devm_clk_get_optional() and then clk_prepare_enable(). It simplifies
the clk_prepare_enable() and clk_disable_unprepare() with proper error
handling and makes the code more compact.
The result of devm_clk_get_optional_enabled() is now assigned directly
to pcie->refclk. This removes a superfluous local clk variable,
improving code readability and compactness. The functionality
remains unchanged, but the code is now more streamlined.

Cc: Siddharth Vadapalli <s-vadapalli@ti.com>
Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v4: Add Rb Siddharth
---
 drivers/pci/controller/cadence/pci-j721e.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index 5bc5ab20aa6d..a88b2e52fd78 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -479,7 +479,6 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 	struct cdns_pcie_ep *ep = NULL;
 	struct gpio_desc *gpiod;
 	void __iomem *base;
-	struct clk *clk;
 	u32 num_lanes;
 	u32 mode;
 	int ret;
@@ -603,19 +602,13 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 			goto err_get_sync;
 		}
 
-		clk = devm_clk_get_optional(dev, "pcie_refclk");
-		if (IS_ERR(clk)) {
-			ret = dev_err_probe(dev, PTR_ERR(clk), "failed to get pcie_refclk\n");
+		pcie->refclk = devm_clk_get_optional_enabled(dev, "pcie_refclk");
+		if (IS_ERR(pcie->refclk)) {
+			ret = dev_err_probe(dev, PTR_ERR(pcie->refclk),
+					    "failed to enable pcie_refclk\n");
 			goto err_pcie_setup;
 		}
 
-		ret = clk_prepare_enable(clk);
-		if (ret) {
-			dev_err_probe(dev, ret, "failed to enable pcie_refclk\n");
-			goto err_pcie_setup;
-		}
-		pcie->refclk = clk;
-
 		/*
 		 * Section 2.2 of the PCI Express Card Electromechanical
 		 * Specification (Revision 5.1) mandates that the deassertion
@@ -629,10 +622,8 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 		}
 
 		ret = cdns_pcie_host_setup(rc);
-		if (ret < 0) {
-			clk_disable_unprepare(pcie->refclk);
+		if (ret < 0)
 			goto err_pcie_setup;
-		}
 
 		break;
 	case PCI_MODE_EP:
@@ -679,7 +670,6 @@ static void j721e_pcie_remove(struct platform_device *pdev)
 
 	gpiod_set_value_cansleep(pcie->reset_gpio, 0);
 
-	clk_disable_unprepare(pcie->refclk);
 	cdns_pcie_disable_phy(cdns_pcie);
 	j721e_pcie_disable_link_irq(pcie);
 	pm_runtime_put(dev);
-- 
2.50.1


