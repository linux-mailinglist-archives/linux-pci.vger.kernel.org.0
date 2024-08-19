Return-Path: <linux-pci+bounces-11805-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DCB95664C
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2024 11:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 277851C21647
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2024 09:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DB115ECC1;
	Mon, 19 Aug 2024 09:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PprDPzzL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2784F15C125;
	Mon, 19 Aug 2024 09:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724058279; cv=none; b=ladVCd+xnN5r8/a+N/TLuWSSPk3e0J3qVlaTkNw7DbsgIIjFFk12UTxOJOX75d39tWrRQVxl9kg+Zuj8ahx8kQscFcDK7vzZwA+x9tVynS0V8TahPQKdd8aHiW7jY1tnZUNk9+PSMMZOyyEvy0F0CZGo8YllLRSI/9c4jd6aeo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724058279; c=relaxed/simple;
	bh=k0kc+QTAqBx5aRP9ejxkGxkgN/n6bbv6rD4rzOSvbiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J/Quk3K5bs/7myP6Yd8uKRIgD3mAFFFbxPQ81tmZEiwhWKBzPIve+Sr8qlmj00R4imfr60FGXT8tFvrWSHn7h86nOcj7vwmMDQH8Ykh/DC6/g3jTY5sCXWu08QuCyxmPdmtwGRxU0uMH5Tr7qxsdMMU/UVAC2L4O7MD7fY7yM2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PprDPzzL; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4281ca54fd3so32334195e9.2;
        Mon, 19 Aug 2024 02:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724058276; x=1724663076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zR4Ofv19bSC63uSv19yH+Zec5wT7Br2CN3wzGxETKgc=;
        b=PprDPzzLxkbTok9EGMHFB3aPhCflcz9gdKT+evFd3teAQWrIOSnsW22VlCjL7Gv3jM
         Uv3fqo7KkI8namMjVscV9wtlpysF4pJKNaCvEzHL0KsibWZ8DtCGA9cu+0Yr+OvFPGgM
         YzS3BSeN5mTNea7/sA7jDVLpNqejP/LlGmu6nAXqjO+nHh3hC9bC6OqE+OWbPpYiu2+M
         ryUoRHqPAVmGOmkWvPxMIfozACbS+Dz+3Jx9hnofIFVMGEO5D401qbAmh4VOqgUcTLaS
         1ND++K8xd8QrNUVDSQ7+gYhs56JfFdrQP/Zop+rN+/QA8Pvg/9wtBo6J6pFLJvN9zM+1
         XhVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724058276; x=1724663076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zR4Ofv19bSC63uSv19yH+Zec5wT7Br2CN3wzGxETKgc=;
        b=bSwNxN75mVb7Lfg6vp/cd4Hy74NsIUFtYBXrfGEBRwzgMhFNkou4ys46FFtUYOOoYr
         os6BTWGlsz3zIw/eIwYLryVr4NBEvhgKC5NB/eMCuJ8GtUo8XqKslwtBAZ7Sdbkjnvuc
         rj/NPwb/V3dvesAE54jVs28jLcLzvfp09KaMZLpbCOMXaRMhVNRGcse1DmaWoYHw45pT
         0NiqTcijnzUX17OuCXCelrmOsOikb3t4S9+kXeGrPPmeBEYykhUilYo9ZbAWSSW5uhiq
         R4iZH1RrqT8fjYhFA4GouaNzCRfH1R4HeGMR0velNb8MPG0b0pCv1YzemmWQel9XgtrZ
         Rk7g==
X-Forwarded-Encrypted: i=1; AJvYcCWkrp5EwQLzg2C2lReq3EgpaNvnU3sahdOCop5K3hwH8JxvqfSbBywmDWtuDjo/Bhjy/ZWYJdBochjuc4omhU1ZMLyNT0OsGItiwts0
X-Gm-Message-State: AOJu0YywMu1MFelPAclsVyyCNEaDIOCl6VwgMhFaaMLfxPp3pKy4mVJM
	EbqLpKUuGUwz1VM6ABJC2rKnn6zQ8m3QuWkBUSoW7EIbCkv/HgmL
X-Google-Smtp-Source: AGHT+IH7JYzrD4WQ2IczOX6U7P1voHwlgUZmPc1foVjQrG13R7Z0iK1/sLxIgbdwHptG5vYiK5hczA==
X-Received: by 2002:a05:600c:4712:b0:426:5fbe:bf75 with SMTP id 5b1f17b1804b1-429ed7d1eccmr71255425e9.23.1724058276061;
        Mon, 19 Aug 2024 02:04:36 -0700 (PDT)
Received: from eichest-laptop.toradex.int ([2a02:168:af72:0:a64c:8731:e4fb:38f1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded19627sm154672095e9.5.2024.08.19.02.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 02:04:35 -0700 (PDT)
From: Stefan Eichenberger <eichest@gmail.com>
To: hongxing.zhu@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	francesco.dolcini@toradex.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: [PATCH v1 3/3] PCI: imx6: reset link on resume
Date: Mon, 19 Aug 2024 11:03:19 +0200
Message-ID: <20240819090428.17349-4-eichest@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240819090428.17349-1-eichest@gmail.com>
References: <20240819090428.17349-1-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

According to the https://www.nxp.com/docs/en/errata/IMX6DQCE.pdf errata,
the i.MX6Q PCIe controller does not support suspend/resume. So suspend
and resume was omitted. However, this does not seem to work because it
looks like the PCIe link is still expecting a reset. If we do not reset
the link, we end up with a frozen system after resume. The last message
we see is:
ath10k_pci 0000:01:00.0: Unable to change power state from D3hot to D0,
device inaccessible

Besides resetting the link, we also need to enable msi again, otherwise
DMA access will not work and we can still end up with a frozen system.
With these changes we can suspend and resume the system properly with a
PCIe device attached. This was tested with a Compex WLE900VX miniPCIe
Wifi module.

Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 45 ++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index f17561791e35a..751243f4c519e 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1213,14 +1213,57 @@ static int imx6_pcie_suspend_noirq(struct device *dev)
 	return 0;
 }
 
+static int imx6_pcie_reset_link(struct imx6_pcie *imx6_pcie)
+{
+	int ret;
+
+	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
+			   IMX6Q_GPR1_PCIE_TEST_PD, 1 << 18);
+	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
+			   IMX6Q_GPR1_PCIE_REF_CLK_EN, 0 << 16);
+
+	/* Reset the PCIe device */
+	gpiod_set_value_cansleep(imx6_pcie->reset_gpiod, 1);
+
+	ret = imx6_pcie_enable_ref_clk(imx6_pcie);
+	if (ret) {
+		dev_err(imx6_pcie->pci->dev, "unable to enable pcie ref clock\n");
+		return ret;
+	}
+
+	imx6_pcie_deassert_reset_gpio(imx6_pcie);
+
+	/*
+	 * Setup the root complex again and enable msi. Without this PCIe will
+	 * not work in msi mode and drivers will crash if they try to access
+	 * the device memory area
+	 */
+	dw_pcie_setup_rc(&imx6_pcie->pci->pp);
+	if (pci_msi_enabled()) {
+		u32 val;
+		u8 offset = dw_pcie_find_capability(imx6_pcie->pci, PCI_CAP_ID_MSI);
+
+		val = dw_pcie_readw_dbi(imx6_pcie->pci, offset + PCI_MSI_FLAGS);
+		val |= PCI_MSI_FLAGS_ENABLE;
+		dw_pcie_writew_dbi(imx6_pcie->pci, offset + PCI_MSI_FLAGS, val);
+	}
+
+	return 0;
+}
+
 static int imx6_pcie_resume_noirq(struct device *dev)
 {
 	int ret;
 	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
 	struct dw_pcie_rp *pp = &imx6_pcie->pci->pp;
 
+	/*
+	 * Even though the i.MX6Q does not support suspend/resume, we need to
+	 * reset the link after resume or the memory mapped PCIe I/O space will
+	 * be inaccessible. This will cause the system to freeze.
+	 */
 	if (!(imx6_pcie->drvdata->flags & IMX6_PCIE_FLAG_SUPPORTS_SUSPEND))
-		return 0;
+		return imx6_pcie_reset_link(imx6_pcie);
 
 	ret = imx6_pcie_host_init(pp);
 	if (ret)
-- 
2.43.0


