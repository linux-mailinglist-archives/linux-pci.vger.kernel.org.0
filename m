Return-Path: <linux-pci+bounces-4005-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFACC867371
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 12:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 039CE1C2439B
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 11:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034711EA7C;
	Mon, 26 Feb 2024 11:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gFgYjNmV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEB54CDE0
	for <linux-pci@vger.kernel.org>; Mon, 26 Feb 2024 11:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708947488; cv=none; b=ZeY6vn1Mu3j+XIZ/lzrNIuXQNTCCgG+YHCqh+Faz3n3p3VscAVn/2jfAOLqnkjgagQX7opItW3B9ip3/Op5QT2mkxlLxQQ4mACGOhU1n1HjC+F52RbY7zZ1GFyXScBX0zyv4u2bbEgQ0MdoPzXAnuIoWXh1JuN93cJpzlI03u/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708947488; c=relaxed/simple;
	bh=Wy7LJuC8h0Gs3GX5VCOt1uxpsY9Nepi+sgqSN6HRB18=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EWf+9vUtimdF+xSo3i0H+bY/pprfwdbTtjXUO9UvjEKiaLuDrVhrIP7lDotGNq6yrCDOKATgLINB+mKDXbhdmCV3q0LWjxvW2PR8GTPYnZMvv12HDMDf6S4G9Hot/+Akk5sVdDGOvbePAco8lVoW/ErvtQu5khZhzLquSZt4V0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gFgYjNmV; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-608e0b87594so13635277b3.1
        for <linux-pci@vger.kernel.org>; Mon, 26 Feb 2024 03:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708947486; x=1709552286; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4KNkTka0JljgsliYTECP2ewGRxvpOhNGNlugq+4lG+k=;
        b=gFgYjNmVfvkMsanBL7iuEBa9MJPmzzTOQHT/Kzar1HFeJdZmOFhNS9m80B8ncrONwh
         Pf6VkZIilEYSNkB7gIhUNUelrdIROPl5pwnysHlZTd0Ci1mptvsEAz72oPZ8+f7VmNuJ
         CPLX1pmC+O0B24ItFVSROZMJu+81m19qqEvwJt6t3JdtTjTy61PH9i1+OhzcwWUG6OvR
         iZvdsAb4KtW/Vwewcv4UlyOrWK3mGzaKGsq4MDQohak/c6k3VzwWw2FsFlt5L+dq76Zv
         PAPoTm4NcwXLhNcAdkRtWVWicU252LdRT8JV/J0qAj0sS5mVLv+Fy93GrZ7mH2e5FMd2
         8LjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708947486; x=1709552286;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4KNkTka0JljgsliYTECP2ewGRxvpOhNGNlugq+4lG+k=;
        b=sBeHz7kMy4fRUwx6niVPd5FrUWmYFHWzj7o10CbHTuggEYLKyXJpGQGpkc8pddiENa
         GASeYo4LyxqIhfFC3E17NF9pMFpBlFs1rf+AEBfU28y7NlS3BIHXF4mpC/pHK4he7D6t
         S0uaneg47xu3pFkJZSsRYSQpmvxvYwKBExCuqY5xqjIMCsucR+T31zFFsJhb0JiHoLDa
         ffntoQcpKcrSNQx/5fhYw/04q8YlhlXUy0by44/PrG4bOqKuy5na4aDXsOk/r3o4yczN
         2u1rReXn6hnquF0JwY8kkO9sQ1ec15Gg4vda5grfOrExdDZ5j60KYnuBJqHUgXU0QhwN
         nWOw==
X-Forwarded-Encrypted: i=1; AJvYcCX9oWeh9PqGCRKZUsQ7GIDL3XwCu2aH/2gXFNCUNR36x92J++X0lVfbTdpO8PncjBuxrcSkCuRAmx0kyu1b4uEb9C+GfRSadtEB
X-Gm-Message-State: AOJu0Ywf2csnczGqFG4c20p7Jqvwgsmn3+fWsKh+Qa2KFLEa1Vn4iiMf
	nedoIqwubERP5kxMbORbJnzJp0atkByjCmZ3rR/5t1PmszlozyEcFh4uW7hLjA==
X-Google-Smtp-Source: AGHT+IE/mGz3ZyjgFiK3TAv9t858cL7lgsk+HTGLU6NfD9LcJe1EXPU7mYQwsS9Im3n/GqJXakNHNw==
X-Received: by 2002:a81:4005:0:b0:608:d6d3:33fc with SMTP id l5-20020a814005000000b00608d6d333fcmr3975142ywn.34.1708947486073;
        Mon, 26 Feb 2024 03:38:06 -0800 (PST)
Received: from [127.0.1.1] ([117.202.184.81])
        by smtp.gmail.com with ESMTPSA id q15-20020a05620a0c8f00b007878babb96asm2341842qki.94.2024.02.26.03.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 03:38:05 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Mon, 26 Feb 2024 17:07:28 +0530
Subject: [PATCH v3 3/5] PCI: dwc: Pass the eDMA mapping format flag
 directly from glue drivers
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-dw-hdma-v3-3-cfcb8171fc24@linaro.org>
References: <20240226-dw-hdma-v3-0-cfcb8171fc24@linaro.org>
In-Reply-To: <20240226-dw-hdma-v3-0-cfcb8171fc24@linaro.org>
To: Jingoo Han <jingoohan1@gmail.com>, 
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Marek Vasut <marek.vasut+renesas@gmail.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3372;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=Wy7LJuC8h0Gs3GX5VCOt1uxpsY9Nepi+sgqSN6HRB18=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBl3HgFbG62OQCkQ3VnNidmAAH0htQtC/tS8ex+O
 2uHD4sYRe6JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZdx4BQAKCRBVnxHm/pHO
 9S9CB/9MAYdgUSAUy/h0KZWWs19lAViTLux8j83QIpS/MERsfZXcfZQZ2sie4X4OgQttZjsEcMB
 P5NDfstxgjCk42dJuDOo2CcGMQ7lv1Kh8E4yX4+LufhRqXLlJUd6D+jSdcrmnvRfcxScvRkuQl5
 +OjGmE/s6+i+bj9dWW7TrMv9FVceabxGEQCTx1ntGvkdc7taVTzoG9U6xvVuT8NwrGX8PELSJM8
 h61+cg5x13hJe3Jp9TQrilsBuV/8HGm+OCI0orbl00Pz69HUF6vU73ikdJKISsluBi2hD2qDsCN
 fUWOIR7V0B+Ob2lxFgH5J7jNltgC6ZMa69CX7k84SFn1TgQ+
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

Instead of maintaining a separate capability for glue drivers that cannot
support auto detection of the eDMA mapping format, let's pass the mapping
format directly from them.

This will simplify the code and also allow adding HDMA support that also
doesn't support auto detection of mapping format.

Suggested-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-designware.c | 16 +++++++++-------
 drivers/pci/controller/dwc/pcie-designware.h |  5 ++---
 drivers/pci/controller/dwc/pcie-rcar-gen4.c  |  2 +-
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index ce273c3c5421..3e90b9947a13 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -894,18 +894,20 @@ static int dw_pcie_edma_find_mf(struct dw_pcie *pci)
 {
 	u32 val;
 
+	/*
+	 * Bail out finding the mapping format if it is already set by the glue
+	 * driver. Also ensure that the edma.reg_base is pointing to a valid
+	 * memory region.
+	 */
+	if (pci->edma.mf != EDMA_MF_EDMA_LEGACY)
+		return pci->edma.reg_base ? 0 : -ENODEV;
+
 	/*
 	 * Indirect eDMA CSRs access has been completely removed since v5.40a
 	 * thus no space is now reserved for the eDMA channels viewport and
 	 * former DMA CTRL register is no longer fixed to FFs.
-	 *
-	 * Note that Renesas R-Car S4-8's PCIe controllers for unknown reason
-	 * have zeros in the eDMA CTRL register even though the HW-manual
-	 * explicitly states there must FFs if the unrolled mapping is enabled.
-	 * For such cases the low-level drivers are supposed to manually
-	 * activate the unrolled mapping to bypass the auto-detection procedure.
 	 */
-	if (dw_pcie_ver_is_ge(pci, 540A) || dw_pcie_cap_is(pci, EDMA_UNROLL))
+	if (dw_pcie_ver_is_ge(pci, 540A))
 		val = 0xFFFFFFFF;
 	else
 		val = dw_pcie_readl_dbi(pci, PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTRL);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 26dae4837462..995805279021 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -51,9 +51,8 @@
 
 /* DWC PCIe controller capabilities */
 #define DW_PCIE_CAP_REQ_RES		0
-#define DW_PCIE_CAP_EDMA_UNROLL		1
-#define DW_PCIE_CAP_IATU_UNROLL		2
-#define DW_PCIE_CAP_CDM_CHECK		3
+#define DW_PCIE_CAP_IATU_UNROLL		1
+#define DW_PCIE_CAP_CDM_CHECK		2
 
 #define dw_pcie_cap_is(_pci, _cap) \
 	test_bit(DW_PCIE_CAP_ ## _cap, &(_pci)->caps)
diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index e9166619b1f9..3c535ef5ea91 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -255,7 +255,7 @@ static struct rcar_gen4_pcie *rcar_gen4_pcie_alloc(struct platform_device *pdev)
 	rcar->dw.ops = &dw_pcie_ops;
 	rcar->dw.dev = dev;
 	rcar->pdev = pdev;
-	dw_pcie_cap_set(&rcar->dw, EDMA_UNROLL);
+	rcar->dw.edma.mf = EDMA_MF_EDMA_UNROLL;
 	dw_pcie_cap_set(&rcar->dw, REQ_RES);
 	platform_set_drvdata(pdev, rcar);
 

-- 
2.25.1


