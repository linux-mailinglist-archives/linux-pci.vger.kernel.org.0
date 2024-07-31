Return-Path: <linux-pci+bounces-11078-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABA19438E1
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2024 00:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5953B23862
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 22:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83A816E868;
	Wed, 31 Jul 2024 22:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hruA2eJ+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3129416DC2E
	for <linux-pci@vger.kernel.org>; Wed, 31 Jul 2024 22:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722464921; cv=none; b=IdEoc98sLbVymVIqPEXq+P0aERR7EfA8yVu536IXiZwhRrCvlNGikqS+9FT8PSQDxRrCnPJovM11o1knKmfIkZYDJfxBsRiO586Vwl53EK/sfRz9MRsezDrpmY7HjQL+Kf2s3RzBR4Xl6LLHz47fdjI5Fq4l58PosTU1VOxcg9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722464921; c=relaxed/simple;
	bh=tXTAjZtcWhewtsJ5mnN9e2cBSHCNX3dQ2tHxYaPUuhA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Z1/Gyfs6deYvnMk+NSizRW4v8IHVgaYNlRy62XzkXYLGXdEhOuSqjWosIIneTOuGOsEIJNoRgqZ45uY1p9i5RZrssmscM13lAY3gzz22KjWjOllTDvq2jIQ19KX3B91a3Lj/KXZopBXc4pNw8iOg3Hkz5KhEziCTvm4J6D0bBuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hruA2eJ+; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7093b53f315so2306087a34.2
        for <linux-pci@vger.kernel.org>; Wed, 31 Jul 2024 15:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722464919; x=1723069719; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J83Zv5BEREvIAUqofWicGKSSTCWUlV2zoywp7ximAEQ=;
        b=hruA2eJ+kRepZRi+HwCoZdNH6HaXyhU+vNCyXqnWvpQ5cT1C3a1OtG6BjgeRblHmjL
         Hw8PSNAKBIm4emrjNcMKw/kHY6qv6eE6xJ174TWfy+4NWQjHADrxHYJCczEQ5nV7O7fp
         X7ILbI6rqPp4u7A+le2dh+JqvryGxO1t4ObBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722464919; x=1723069719;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J83Zv5BEREvIAUqofWicGKSSTCWUlV2zoywp7ximAEQ=;
        b=FMFODrqfof+Sq2cYUgZUhFlSaYl0Y9bSa3+15ZVQs+PQ5z69bejDvmno0ul9PIQAH8
         0hoTSMn8cdQ96nsAWndj1bKpyVWFwkWnIfA/RlnZv3KFN+FKV63yUulMQivs7RNtlNd5
         6qycNZDG8PLBCiJV8d8hni17pxBbRmBE5qKHs15ClsVT3ToLENIugZG74qAZY3wBdp0o
         jg2KRekyBOh8x9HyqjwNCT+Xfps9JCa9QFN9gIVmUitQ2KCc0O/PKYczG801XrRyBnjp
         c8nXkO+rCtZPbQaBxrnVxUeFMRuBc2td1xR0djnTkde9pcrB8A7xkCkyLbcRS+dj3sv7
         ZmIw==
X-Gm-Message-State: AOJu0YwjgFfToN+RYsR9N49+OXWtc2+TuRliwWYdp77Y0x3p4iCdaq95
	Wohb5XEJ0KXkRSQalvPzyEES9Zqp0owFR++cUSJDVPBkvEOrPzLJW/Gf33Vqlgy+pHFjALgkAi9
	9Bh1CTWeOLudIDkgzVPWLfrCDPIb+EVgIPqetLhYLkVdCvA5q3NWI3sGwfzyuu8++LMr9oELePM
	etpyxzG9SE5Jwo+GPRC37f94BO4ZEuVXDPVmpC+r8EHKZBYA==
X-Google-Smtp-Source: AGHT+IHIP5WdHy/ihYegTa0DgMvLcOxm3pAjIV58KNh8m6EZyfzcAcqiHesM2kvbR33Jn8f0UeLyNA==
X-Received: by 2002:a05:6830:6c0e:b0:709:44dc:dde7 with SMTP id 46e09a7af769-7096b8054afmr717661a34.9.1722464918795;
        Wed, 31 Jul 2024 15:28:38 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44fe8416c80sm62359181cf.96.2024.07.31.15.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 15:28:38 -0700 (PDT)
From: Jim Quinlan <james.quinlan@broadcom.com>
To: linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com,
	jim2101024@gmail.com,
	james.quinlan@broadcom.com
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 03/12] PCI: brcmstb: Use common error handling code in brcm_pcie_probe()
Date: Wed, 31 Jul 2024 18:28:17 -0400
Message-Id: <20240731222831.14895-4-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240731222831.14895-1-james.quinlan@broadcom.com>
References: <20240731222831.14895-1-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

o Move the clk_prepare_enable() below the resource allocations.
o Move the clk_prepare_enable() out of __brcm_pcie_remove() but
  add it to the end of brcm_pcie_remove().
o Add a jump target (clk_disable_unprepare) so that a bit of exception
  handling can be better reused at the end of this function implementation.
o Use dev_err_probe() where it makes sense.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 34 ++++++++++++---------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index c08683febdd4..7595e7009192 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -1473,7 +1473,6 @@ static void __brcm_pcie_remove(struct brcm_pcie *pcie)
 		dev_err(pcie->dev, "Could not stop phy\n");
 	if (reset_control_rearm(pcie->rescal))
 		dev_err(pcie->dev, "Could not rearm rescal reset\n");
-	clk_disable_unprepare(pcie->clk);
 }
 
 static void brcm_pcie_remove(struct platform_device *pdev)
@@ -1484,6 +1483,7 @@ static void brcm_pcie_remove(struct platform_device *pdev)
 	pci_stop_root_bus(bridge->bus);
 	pci_remove_root_bus(bridge->bus);
 	__brcm_pcie_remove(pcie);
+	clk_disable_unprepare(pcie->clk);
 }
 
 static const int pcie_offsets[] = {
@@ -1613,31 +1613,26 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 
 	pcie->ssc = of_property_read_bool(np, "brcm,enable-ssc");
 
-	ret = clk_prepare_enable(pcie->clk);
-	if (ret) {
-		dev_err(&pdev->dev, "could not enable clock\n");
-		return ret;
-	}
 	pcie->rescal = devm_reset_control_get_optional_shared(&pdev->dev, "rescal");
-	if (IS_ERR(pcie->rescal)) {
-		clk_disable_unprepare(pcie->clk);
+	if (IS_ERR(pcie->rescal))
 		return PTR_ERR(pcie->rescal);
-	}
+
 	pcie->perst_reset = devm_reset_control_get_optional_exclusive(&pdev->dev, "perst");
-	if (IS_ERR(pcie->perst_reset)) {
-		clk_disable_unprepare(pcie->clk);
+	if (IS_ERR(pcie->perst_reset))
 		return PTR_ERR(pcie->perst_reset);
-	}
 
-	ret = reset_control_reset(pcie->rescal);
+	ret = clk_prepare_enable(pcie->clk);
 	if (ret)
-		dev_err(&pdev->dev, "failed to deassert 'rescal'\n");
+		return dev_err_probe(&pdev->dev, ret, "could not enable clock\n");
+
+	ret = reset_control_reset(pcie->rescal);
+	if (dev_err_probe(&pdev->dev, ret, "failed to deassert 'rescal'\n"))
+		goto clk_disable_unprepare;
 
 	ret = brcm_phy_start(pcie);
 	if (ret) {
 		reset_control_rearm(pcie->rescal);
-		clk_disable_unprepare(pcie->clk);
-		return ret;
+		goto clk_disable_unprepare;
 	}
 
 	ret = brcm_pcie_setup(pcie);
@@ -1654,10 +1649,8 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 	msi_np = of_parse_phandle(pcie->np, "msi-parent", 0);
 	if (pci_msi_enabled() && msi_np == pcie->np) {
 		ret = brcm_pcie_enable_msi(pcie);
-		if (ret) {
-			dev_err(pcie->dev, "probe of internal MSI failed");
+		if (dev_err_probe(pcie->dev, ret, "probe of internal MSI failed"))
 			goto fail;
-		}
 	}
 
 	bridge->ops = pcie->type == BCM7425 ? &brcm7425_pcie_ops : &brcm_pcie_ops;
@@ -1678,6 +1671,9 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 
 fail:
 	__brcm_pcie_remove(pcie);
+clk_disable_unprepare:
+	clk_disable_unprepare(pcie->clk);
+
 	return ret;
 }
 
-- 
2.17.1


