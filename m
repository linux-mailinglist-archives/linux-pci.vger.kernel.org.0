Return-Path: <linux-pci+bounces-26704-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC78A9B375
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 18:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAEEC925863
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 16:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC3D28466A;
	Thu, 24 Apr 2025 16:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eUEisMAs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A10B2820DA
	for <linux-pci@vger.kernel.org>; Thu, 24 Apr 2025 16:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745510863; cv=none; b=JIoZkdwpsBNDFqrs94FHHVZ+PUAj1/ThuoHx81YmA87zUaxl36uxKI41A6WZTSCTYwcyB5AUffYnLCJ+W7BOoqOv/56mHBU3h4B/od3BEOR848UbRSMECVoSCu8aOW6Lp47Rbl5sw9+8uWU7JL1xLijre90zoTvfRwDLwnj/xXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745510863; c=relaxed/simple;
	bh=N5J19eQwsI9N0oojRK/p72EsuotjYnmFc0R0kOVGaCE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dOJC0ePkz3r6hdCw2dRMr7TSJYqiqaaJ721orWO6jA+KQ1QTn9lc+BH12Tg2aloK19JDzviorqb1+Re5++TjhokrZUQP7xEgDgDwHnRSWjAPkcjA1BbQurLwB5cMRalEeMKH4x0r8KDa4d8ldgA9U3A3N101qq0mb2lp0/g49e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eUEisMAs; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2255003f4c6so14177805ad.0
        for <linux-pci@vger.kernel.org>; Thu, 24 Apr 2025 09:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745510861; x=1746115661; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rjm4rrPzndbAXX2820p6MuAcYvaNMSb291xd9DnKbBM=;
        b=eUEisMAs6vq3ZjxNXKQC723f13uRlCpGMj+9taolrug5TQHNRHmzuHmIv/ylxx1nNq
         qyIcetqU0/HIk0w79UV1VCf50WGBaf6Q0TwFZwvFizoh3TvRe554C2JzvDYkGLutBRp8
         +eN7o/hMC2HN8X5EzJPhdeOo4YItAbNq+dZKoozMw0eZadsjTN6eFIBwwEf0xIOllBK/
         NbTSXuGMBjOJAN+6yYreokHkmO+lk1GEhf3zZ/F/mAQvow8tUivuP5Nco89y5tDT/fNW
         +Gm9POrmvKqTBEFxfCNM0sfNl7XIL/9h9R979wHwI+8zmpxyEQPNd5LLHbNTtCzwkyJm
         HY0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745510861; x=1746115661;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rjm4rrPzndbAXX2820p6MuAcYvaNMSb291xd9DnKbBM=;
        b=InOVZiqoD1L9rjQccWiWooneSNFCDOmSWRX8hXzjI8/ghM2tj7BGp+XsYaRgIde16o
         SDRgykmXQ28+0y6sfGyTJr1TgTL7TxpN7cZC2AZe0ezhI4dlhnEOyqETzan+bMRW7+uH
         YURcH0jPk5Zw72o+WpACvZfe1+wdVt95A0lZVwVxcVZpKsYeWaEQ0saw3MtJO1Y7fGw3
         opn891Gj6natqOc5jS2Reg+1jSV9+yWhYEdsTzZH79BkhFxSDUV4HPp4SCzGVsKPhTrM
         C0kwLioo1dua3sSCAHJkehL7uO7Wo2xhfsa/VQMinK1mXKKFMKwOMJDTgwUiFTH7Jbqu
         dJrQ==
X-Gm-Message-State: AOJu0YzLrRoBOV4xPsd19xek839lyoFhw1MfhStE7XlLnY7ArEQ45xEX
	MW3iYxIzR259fqSyC1SIRf5o23hUwzTmV649vfwh+xTUmpP98CQBkF9W2GbTBw==
X-Gm-Gg: ASbGncsXG63zhJ2syy1JWSZsp+NygdByDiZfdl0G3lGQZqk0cJcLNFhi9BTDZ1Gnp25
	iKM59XQr9Z+xzoA7P9mpYlM7MgFqBXCJY+OkLuEB3KITlJ8z8izOJijBqYiYYvu3Cmtc/GR2fKh
	YzhwkPUIeK1dmZPmdGKy9TB8o6uv6eMc5Y/WEmlXlWkcfA+Yq3hOOutl1eG9+EoTtarhV3n+hYj
	+KAIcbt3w+0rkkdppc6zscKtKnw4la41bkoZcIz/EGqFmSielkBTQrGEfVWzA1Lwr/wX9XIyl6Y
	1sWYQnHYKs/2wqT1Sk1UUDTvtU8tnSWT5XJy/JBekZ4QxCw5LC9R30U=
X-Google-Smtp-Source: AGHT+IHGVjiui8P3BFtNxc/KsmX1+wx8Ty+qQEqIyyTcj4oiYd7B8d3CfecHzDKuRthWNltJvJyQDQ==
X-Received: by 2002:a17:902:d48a:b0:221:78a1:27fb with SMTP id d9443c01a7336-22db3bd1a15mr41938685ad.11.1745510861310;
        Thu, 24 Apr 2025 09:07:41 -0700 (PDT)
Received: from [127.0.1.1] ([120.60.77.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db5221656sm15262275ad.252.2025.04.24.09.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 09:07:40 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Thu, 24 Apr 2025 21:37:18 +0530
Subject: [PATCH v3 3/4] PCI: dwc: Add debugfs support for PTM context
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-pcie-ptm-v3-3-c929ebd2821c@linaro.org>
References: <20250424-pcie-ptm-v3-0-c929ebd2821c@linaro.org>
In-Reply-To: <20250424-pcie-ptm-v3-0-c929ebd2821c@linaro.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Jingoo Han <jingoohan1@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=12030;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=N5J19eQwsI9N0oojRK/p72EsuotjYnmFc0R0kOVGaCE=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBoCmG/fRXBAnWI3HIPUONH7gRa2wmElh34pOpUL
 tX7UeD89JyJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaAphvwAKCRBVnxHm/pHO
 9bN2B/9xACgdEokupIkfCLveS4DylsArME3tUHCO44XW4ZEdbMGV7GLqf96fu1FWvCCa6OPtZdK
 VQE1Qii+DRHJ96egf7bh1oWdxs6+akLK15g9bmYdJ915Dkq7c1ENvi5y2ptx5tq1VWIIzFYYWzK
 K6S9rlePZ+LtXRXVHw8O4O70+RJkRMgQOxag47L87hW9RNd1ZnJJEsG+pRWYaj5VD6kvSruKNSE
 GGsJ9/TGucZg0xk/rpJahayysFmHlwrCi6dhQZV6POCSnTtUF34MOOaoOCJyIBZZyBwjcs+Z/tE
 EWf7H+Y2w90KCAPGJ9+2iFntAAvOVpfX4aTx3GEZ825/5mdJ
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

Synopsys Designware PCIe IPs support PTM capability as defined in the PCIe
spec r6.0, sec 6.21. The PTM context information is exposed through Vendor
Specific Extended Capability (VSEC) registers on supported controller
implementation.

Hence, add support for exposing these context information to userspace
through the debugfs interface for the DWC controllers (both RC and EP).
Currently, only Qcom controllers are supported. For adding support for
other DWC vendor controllers, dwc_pcie_ptm_vsec_ids[] needs to be extended.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../pci/controller/dwc/pcie-designware-debugfs.c   | 248 +++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.c       |   6 +
 drivers/pci/controller/dwc/pcie-designware.h       |  18 ++
 include/linux/pcie-dwc.h                           |   8 +
 4 files changed, 280 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.c b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
index 896c387450ca45d979f6baa04e6b3ae3e4be167e..c67601096c4827b144d624dbaf18091eea2a0d5b 100644
--- a/drivers/pci/controller/dwc/pcie-designware-debugfs.c
+++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
@@ -642,11 +642,257 @@ static void dwc_pcie_ltssm_debugfs_init(struct dw_pcie *pci, struct dentry *dir)
 			    &dwc_pcie_ltssm_status_ops);
 }
 
+static int dw_pcie_ptm_check_capability(void *drvdata)
+{
+	struct dw_pcie *pci = drvdata;
+
+	pci->ptm_vsec_offset = dw_pcie_find_ptm_capability(pci);
+
+	return pci->ptm_vsec_offset;
+}
+
+static int dw_pcie_ptm_context_update_write(void *drvdata, u8 mode)
+{
+	struct dw_pcie *pci = drvdata;
+	u32 val;
+
+	if (mode == PCIE_PTM_CONTEXT_UPDATE_AUTO) {
+		val = dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_RES_REQ_CTRL);
+		val |= PTM_REQ_AUTO_UPDATE_ENABLED;
+		dw_pcie_writel_dbi(pci, pci->ptm_vsec_offset + PTM_RES_REQ_CTRL, val);
+	} else if (mode == PCIE_PTM_CONTEXT_UPDATE_MANUAL) {
+		val = dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_RES_REQ_CTRL);
+		val &= ~PTM_REQ_AUTO_UPDATE_ENABLED;
+		val |= PTM_REQ_START_UPDATE;
+		dw_pcie_writel_dbi(pci, pci->ptm_vsec_offset + PTM_RES_REQ_CTRL, val);
+	} else {
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int dw_pcie_ptm_context_update_read(void *drvdata, u8 *mode)
+{
+	struct dw_pcie *pci = drvdata;
+	u32 val;
+
+	val = dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_RES_REQ_CTRL);
+	if (FIELD_GET(PTM_REQ_AUTO_UPDATE_ENABLED, val))
+		*mode = PCIE_PTM_CONTEXT_UPDATE_AUTO;
+	else
+		/*
+		 * PTM_REQ_START_UPDATE is a self clearing register bit. So if
+		 * PTM_REQ_AUTO_UPDATE_ENABLED is not set, then it implies that
+		 * manual update is used.
+		 */
+		*mode = PCIE_PTM_CONTEXT_UPDATE_MANUAL;
+
+	return 0;
+}
+
+static int dw_pcie_ptm_context_valid_write(void *drvdata, bool valid)
+{
+	struct dw_pcie *pci = drvdata;
+	u32 val;
+
+	if (valid) {
+		val = dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_RES_REQ_CTRL);
+		val |= PTM_RES_CCONTEXT_VALID;
+		dw_pcie_writel_dbi(pci, pci->ptm_vsec_offset + PTM_RES_REQ_CTRL, val);
+	} else {
+		val = dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_RES_REQ_CTRL);
+		val &= ~PTM_RES_CCONTEXT_VALID;
+		dw_pcie_writel_dbi(pci, pci->ptm_vsec_offset + PTM_RES_REQ_CTRL, val);
+	}
+
+	return 0;
+}
+
+static int dw_pcie_ptm_context_valid_read(void *drvdata, bool *valid)
+{
+	struct dw_pcie *pci = drvdata;
+	u32 val;
+
+	val = dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_RES_REQ_CTRL);
+	*valid = !!FIELD_GET(PTM_RES_CCONTEXT_VALID, val);
+
+	return 0;
+}
+
+static int dw_pcie_ptm_local_clock_read(void *drvdata, u64 *clock)
+{
+	struct dw_pcie *pci = drvdata;
+	u32 msb, lsb;
+
+	do {
+		msb = dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_LOCAL_MSB);
+		lsb = dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_LOCAL_LSB);
+	} while (msb != dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_LOCAL_MSB));
+
+	*clock = ((u64) msb) << 32 | lsb;
+
+	return 0;
+}
+
+static int dw_pcie_ptm_master_clock_read(void *drvdata, u64 *clock)
+{
+	struct dw_pcie *pci = drvdata;
+	u32 msb, lsb;
+
+	do {
+		msb = dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_MASTER_MSB);
+		lsb = dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_MASTER_LSB);
+	} while (msb != dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_MASTER_MSB));
+
+	*clock = ((u64) msb) << 32 | lsb;
+
+	return 0;
+}
+
+static int dw_pcie_ptm_t1_read(void *drvdata, u64 *clock)
+{
+	struct dw_pcie *pci = drvdata;
+	u32 msb, lsb;
+
+	do {
+		msb = dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_T1_T2_MSB);
+		lsb = dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_T1_T2_LSB);
+	} while (msb != dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_T1_T2_MSB));
+
+	*clock = ((u64) msb) << 32 | lsb;
+
+	return 0;
+}
+
+static int dw_pcie_ptm_t2_read(void *drvdata, u64 *clock)
+{
+	struct dw_pcie *pci = drvdata;
+	u32 msb, lsb;
+
+	do {
+		msb = dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_T1_T2_MSB);
+		lsb = dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_T1_T2_LSB);
+	} while (msb != dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_T1_T2_MSB));
+
+	*clock = ((u64) msb) << 32 | lsb;
+
+	return 0;
+}
+
+static int dw_pcie_ptm_t3_read(void *drvdata, u64 *clock)
+{
+	struct dw_pcie *pci = drvdata;
+	u32 msb, lsb;
+
+	do {
+		msb = dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_T3_T4_MSB);
+		lsb = dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_T3_T4_LSB);
+	} while (msb != dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_T3_T4_MSB));
+
+	*clock = ((u64) msb) << 32 | lsb;
+
+	return 0;
+}
+
+static int dw_pcie_ptm_t4_read(void *drvdata, u64 *clock)
+{
+	struct dw_pcie *pci = drvdata;
+	u32 msb, lsb;
+
+	do {
+		msb = dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_T3_T4_MSB);
+		lsb = dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_T3_T4_LSB);
+	} while (msb != dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_T3_T4_MSB));
+
+	*clock = ((u64) msb) << 32 | lsb;
+
+	return 0;
+}
+
+static bool dw_pcie_ptm_context_update_visible(void *drvdata)
+{
+	struct dw_pcie *pci = drvdata;
+
+	return (pci->mode == DW_PCIE_EP_TYPE) ? true : false;
+}
+
+static bool dw_pcie_ptm_context_valid_visible(void *drvdata)
+{
+	struct dw_pcie *pci = drvdata;
+
+	return (pci->mode == DW_PCIE_RC_TYPE) ? true : false;
+}
+
+static bool dw_pcie_ptm_local_clock_visible(void *drvdata)
+{
+	/* PTM local clock is always visible */
+	return true;
+}
+
+static bool dw_pcie_ptm_master_clock_visible(void *drvdata)
+{
+	struct dw_pcie *pci = drvdata;
+
+	return (pci->mode == DW_PCIE_EP_TYPE) ? true : false;
+}
+
+static bool dw_pcie_ptm_t1_visible(void *drvdata)
+{
+	struct dw_pcie *pci = drvdata;
+
+	return (pci->mode == DW_PCIE_EP_TYPE) ? true : false;
+}
+
+static bool dw_pcie_ptm_t2_visible(void *drvdata)
+{
+	struct dw_pcie *pci = drvdata;
+
+	return (pci->mode == DW_PCIE_RC_TYPE) ? true : false;
+}
+
+static bool dw_pcie_ptm_t3_visible(void *drvdata)
+{
+	struct dw_pcie *pci = drvdata;
+
+	return (pci->mode == DW_PCIE_RC_TYPE) ? true : false;
+}
+
+static bool dw_pcie_ptm_t4_visible(void *drvdata)
+{
+	struct dw_pcie *pci = drvdata;
+
+	return (pci->mode == DW_PCIE_EP_TYPE) ? true : false;
+}
+
+const struct pcie_ptm_ops dw_pcie_ptm_ops = {
+	.check_capability = dw_pcie_ptm_check_capability,
+	.context_update_write = dw_pcie_ptm_context_update_write,
+	.context_update_read = dw_pcie_ptm_context_update_read,
+	.context_valid_write = dw_pcie_ptm_context_valid_write,
+	.context_valid_read = dw_pcie_ptm_context_valid_read,
+	.local_clock_read = dw_pcie_ptm_local_clock_read,
+	.master_clock_read = dw_pcie_ptm_master_clock_read,
+	.t1_read = dw_pcie_ptm_t1_read,
+	.t2_read = dw_pcie_ptm_t2_read,
+	.t3_read = dw_pcie_ptm_t3_read,
+	.t4_read = dw_pcie_ptm_t4_read,
+	.context_update_visible = dw_pcie_ptm_context_update_visible,
+	.context_valid_visible = dw_pcie_ptm_context_valid_visible,
+	.local_clock_visible = dw_pcie_ptm_local_clock_visible,
+	.master_clock_visible = dw_pcie_ptm_master_clock_visible,
+	.t1_visible = dw_pcie_ptm_t1_visible,
+	.t2_visible = dw_pcie_ptm_t2_visible,
+	.t3_visible = dw_pcie_ptm_t3_visible,
+	.t4_visible = dw_pcie_ptm_t4_visible,
+};
+
 void dwc_pcie_debugfs_deinit(struct dw_pcie *pci)
 {
 	if (!pci->debugfs)
 		return;
 
+	pcie_ptm_destroy_debugfs(pci->ptm_debugfs);
 	dwc_pcie_rasdes_debugfs_deinit(pci);
 	debugfs_remove_recursive(pci->debugfs->debug_dir);
 }
@@ -676,4 +922,6 @@ void dwc_pcie_debugfs_init(struct dw_pcie *pci, enum dw_pcie_device_mode mode)
 	dwc_pcie_ltssm_debugfs_init(pci, dir);
 
 	pci->mode = mode;
+	pci->ptm_debugfs = pcie_ptm_create_debugfs(pci->dev, pci,
+						   &dw_pcie_ptm_ops);
 }
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 97d76d3dc066efeff093de28dcac64411dad51aa..a850d4aea5e8bd5d17a034ba5c6913b5d26ed9a6 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -330,6 +330,12 @@ u16 dw_pcie_find_rasdes_capability(struct dw_pcie *pci)
 }
 EXPORT_SYMBOL_GPL(dw_pcie_find_rasdes_capability);
 
+u16 dw_pcie_find_ptm_capability(struct dw_pcie *pci)
+{
+	return dw_pcie_find_vsec_capability(pci, dwc_pcie_ptm_vsec_ids);
+}
+EXPORT_SYMBOL_GPL(dw_pcie_find_ptm_capability);
+
 int dw_pcie_read(void __iomem *addr, int size, u32 *val)
 {
 	if (!IS_ALIGNED((uintptr_t)addr, size)) {
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 7f58c94b5b1e9a590692474d5efa80c5b5ed9b8d..4d41274a69379f2c563e509df6a8c169c17f9f3c 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -260,6 +260,21 @@
 
 #define PCIE_RAS_DES_EVENT_COUNTER_DATA		0xc
 
+/* PTM register definitions */
+#define PTM_RES_REQ_CTRL		0x8
+#define PTM_RES_CCONTEXT_VALID		BIT(0)
+#define PTM_REQ_AUTO_UPDATE_ENABLED	BIT(0)
+#define PTM_REQ_START_UPDATE		BIT(1)
+
+#define PTM_LOCAL_LSB			0x10
+#define PTM_LOCAL_MSB			0x14
+#define PTM_T1_T2_LSB			0x18
+#define PTM_T1_T2_MSB			0x1c
+#define PTM_T3_T4_LSB			0x28
+#define PTM_T3_T4_MSB			0x2c
+#define PTM_MASTER_LSB			0x38
+#define PTM_MASTER_MSB			0x3c
+
 /*
  * The default address offset between dbi_base and atu_base. Root controller
  * drivers are not required to initialize atu_base if the offset matches this
@@ -504,6 +519,8 @@ struct dw_pcie {
 	bool			suspended;
 	struct debugfs_info	*debugfs;
 	enum			dw_pcie_device_mode mode;
+	u16			ptm_vsec_offset;
+	struct pci_ptm_debugfs	*ptm_debugfs;
 
 	/*
 	 * If iATU input addresses are offset from CPU physical addresses,
@@ -531,6 +548,7 @@ void dw_pcie_version_detect(struct dw_pcie *pci);
 u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap);
 u16 dw_pcie_find_ext_capability(struct dw_pcie *pci, u8 cap);
 u16 dw_pcie_find_rasdes_capability(struct dw_pcie *pci);
+u16 dw_pcie_find_ptm_capability(struct dw_pcie *pci);
 
 int dw_pcie_read(void __iomem *addr, int size, u32 *val);
 int dw_pcie_write(void __iomem *addr, int size, u32 val);
diff --git a/include/linux/pcie-dwc.h b/include/linux/pcie-dwc.h
index 8ff778e7aec0ef60462ea69245c76a91c81b76b9..b15057fa6c0ef1794b72c9279b49787fe56302c4 100644
--- a/include/linux/pcie-dwc.h
+++ b/include/linux/pcie-dwc.h
@@ -35,4 +35,12 @@ static const struct dwc_pcie_vsec_id dwc_pcie_rasdes_vsec_ids[] = {
 	{}
 };
 
+static const struct dwc_pcie_vsec_id dwc_pcie_ptm_vsec_ids[] = {
+	{ .vendor_id = PCI_VENDOR_ID_QCOM, /* EP */
+	  .vsec_id = 0x03, .vsec_rev = 0x1 },
+	{ .vendor_id = PCI_VENDOR_ID_QCOM, /* RC */
+	  .vsec_id = 0x04, .vsec_rev = 0x1 },
+	{ }
+};
+
 #endif /* LINUX_PCIE_DWC_H */

-- 
2.43.0


