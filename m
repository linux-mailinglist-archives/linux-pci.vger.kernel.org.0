Return-Path: <linux-pci+bounces-34749-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 337B6B35DF4
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 13:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACBAD1BA762E
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 11:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26CDD29D292;
	Tue, 26 Aug 2025 11:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PIijaHyQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C602BE7DD;
	Tue, 26 Aug 2025 11:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756208585; cv=none; b=BXpqwx/DFEL4Jp/tvKCLhdFsapybKH03vgXIZ3eOGowv88AaYwoEuI86eDMvcAai3SR+hYNDsroycN9ENTzBGMuo0ujDvjs1qlAdGkipTj8x4NZwR46n2HRlpxv3noTJ30xmz4IWwlOYV6OF85yg8xznQ8LkgUlTjVa72nSlW9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756208585; c=relaxed/simple;
	bh=I6geVZMLLNErI2kLFIfyX//bdSFEL67i0C/QuGTWIsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m7jcZVGHecsMEXEc/bO4vU1mghehIgG+3oqKPRJZVB01kGNxznTrl3BOrN54Ujkl0YXzItEs9jqZko+cHc+nZGzbjJ7Zm002TFxxU7AMLd4MWsD3AGptDkvb/Yvp9LrTO/w7AUZKitlroRvEOfurqPx5Fh/8m0owHz4RtltCkcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PIijaHyQ; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b471756592cso3444418a12.3;
        Tue, 26 Aug 2025 04:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756208583; x=1756813383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5PcgNgrMsWVflwnjgRLXT4uRdSZdm1rxyhY2Rmz1oPc=;
        b=PIijaHyQ2wKBwnrD8Ttyn3ZQqimnBCEzutNrG15IhHVyn1htYUxgWN/wkOFpjPYGtp
         8ED4+G+XMFXwT0xhRw2djcIuL5qJ4+cNOLMGmCbi0qHt9cJAT1TjRDQQ/DlOU8nb1rL2
         92qHUjaJnTEcP/Bm1n+ApVe+ouOPGoX2obShXAtyTLwx48+lJA+Xrpoex3izG8GRcOu+
         ruxw8mEdyvFdo+1N6EBNGlh/nbJYX7XC4LppytKLXMi4QdENLTLM2k09+dXxrqutZoyp
         wJvBKHcYGSoxOhPen301FaIaEpZfAeoOC+xd5GKU3D7YbZdNk8sY5Ym7pKHJtEcHla/h
         bWcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756208583; x=1756813383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5PcgNgrMsWVflwnjgRLXT4uRdSZdm1rxyhY2Rmz1oPc=;
        b=CiwDFzaVT+cftzPyXjRVsjrTkVfgKmdV7gRy3VWNknJn40AjZVBrMBx1q8f8dT/M/u
         xpqe7HmWTh1dlceJGTQNiIQeqlJrXZC/chrPo1d4t9+V//8j9qBiyDc1cqr3PJFPukAU
         uS2shhWx9urGmp/zVk+gzlY6uqKnrwb6O8mVnt5XBwC83SBYfoVUpceZBbQ45A3SNQI0
         8tWnz0EaSoSFUozO8+XQZUPhQC0s6vWeaDP9Ef7ih25FP2g7aFw8Wfr51WIb55zSKPEy
         mtHb9DQJ54QISFQCAA8IHK+1XwR4TdI1dpmRjrWcZn/wB7VXlYdVVEO9FXzK5nC8/2s1
         W2lQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuzfVeeoqQEzE7dAg3L77fBPnDKf1U/vh6nJEvEUw1N8Mc2/mQwd0cWX758msgWEl0x7u6LHo7wY9xX+c=@vger.kernel.org, AJvYcCXGLD/7NQAUMXk++79Oh0qXeQe5XbmXDlE8c9Rt0PXph3pD+IZd95yLryiPEWU1ndJgHl0T2DiOUxIy@vger.kernel.org
X-Gm-Message-State: AOJu0YzPGyW87wjaRhSihjZHckWhJJ6DonfFYdc5SjeqdVsPN0XmbCZt
	Z1ya1314o7ljJsZGQyFWkFx7dw0GFbxJPTJjSBIR82WDJRti6z5zO9v1
X-Gm-Gg: ASbGnctW5jNk+NdDJPLfjS3wnAf/T7j6rfWo9GmZQARmN56BpAyf+9xM1GtTtiMHBL5
	cQW9R9dqLw82vzCllLOrCA5fLxTqkZKJ09Ff9vmwoUZ0usyX1YxglJ4PIC6YD/Txuu2Jjy5Hj6f
	0g0RRGSUl8Bh6m2Nq1PsP2bRVUU7CMtO4i0lFZ9nusfOinGM6ld9OSo0TnOOFT7VDz8MAIn4H97
	eu2skc3FFSlCPL1YP88h2WwZt8BCZXFZSvLEcM8TijwLnXZoq33F+08taAjmndQSmsviUE7M9fu
	2OLvOWyM/6XLUUH4B2vBG1nvXJHZYTqfzayhbsfyBDSIUPzMQ6tHgRjcMxa3BeVBXk+GL1e8+Wc
	rZFTE5fwuuMiOGEtQlK6l
X-Google-Smtp-Source: AGHT+IFAI2khfWzDmxFZB6CPMyetALuCiYuk57bfcB4CFzHZAsTItiOxMyzymn/DObmbH8FEZiQ1OQ==
X-Received: by 2002:a17:90b:388b:b0:325:40a8:56e0 with SMTP id 98e67ed59e1d1-32540a8583amr14217338a91.30.1756208582552;
        Tue, 26 Aug 2025 04:43:02 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.216])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4a8b7b301csm5612958a12.35.2025.08.26.04.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 04:43:01 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Shawn Guo <shawn.guo@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-pci@vger.kernel.org (open list:PCIE DRIVER FOR HISILICON STB),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v1 2/2] PCI: dwc: histb: Simplify reset control handling by using reset_control_bulk*() function
Date: Tue, 26 Aug 2025 17:12:41 +0530
Message-ID: <20250826114245.112472-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826114245.112472-1-linux.amoon@gmail.com>
References: <20250826114245.112472-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the driver acquires and asserts/deasserts the resets
individually thereby making the driver complex to read.

This can be simplified by using the reset_control_bulk() APIs.

Use devm_reset_control_bulk_get_exclusive() API to acquire all the resets
and use reset_control_bulk_{assert/deassert}() APIs to assert/deassert them
in bulk.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/pci/controller/dwc/pcie-histb.c | 57 ++++++++++++-------------
 1 file changed, 28 insertions(+), 29 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-histb.c b/drivers/pci/controller/dwc/pcie-histb.c
index 4022349e85d2..4ba5c9af63a0 100644
--- a/drivers/pci/controller/dwc/pcie-histb.c
+++ b/drivers/pci/controller/dwc/pcie-histb.c
@@ -49,14 +49,20 @@
 #define PCIE_LTSSM_STATE_MASK		GENMASK(5, 0)
 #define PCIE_LTSSM_STATE_ACTIVE		0x11
 
+#define PCIE_HISTB_NUM_RESETS   ARRAY_SIZE(histb_pci_rsts)
+
+static const char * const histb_pci_rsts[] = {
+	"soft",
+	"sys",
+	"bus",
+};
+
 struct histb_pcie {
 	struct dw_pcie *pci;
 	struct  clk_bulk_data *clks;
 	int     num_clks;
 	struct phy *phy;
-	struct reset_control *soft_reset;
-	struct reset_control *sys_reset;
-	struct reset_control *bus_reset;
+	struct  reset_control_bulk_data reset[PCIE_HISTB_NUM_RESETS];
 	void __iomem *ctrl;
 	struct gpio_desc *reset_gpio;
 	struct regulator *vpcie;
@@ -198,9 +204,8 @@ static const struct dw_pcie_host_ops histb_pcie_host_ops = {
 
 static void histb_pcie_host_disable(struct histb_pcie *hipcie)
 {
-	reset_control_assert(hipcie->soft_reset);
-	reset_control_assert(hipcie->sys_reset);
-	reset_control_assert(hipcie->bus_reset);
+	reset_control_bulk_assert(PCIE_HISTB_NUM_RESETS,
+				  hipcie->reset);
 
 	clk_bulk_disable_unprepare(hipcie->num_clks, hipcie->clks);
 
@@ -236,14 +241,19 @@ static int histb_pcie_host_enable(struct dw_pcie_rp *pp)
 		goto reg_dis;
 	}
 
-	reset_control_assert(hipcie->soft_reset);
-	reset_control_deassert(hipcie->soft_reset);
-
-	reset_control_assert(hipcie->sys_reset);
-	reset_control_deassert(hipcie->sys_reset);
+	ret = reset_control_bulk_assert(PCIE_HISTB_NUM_RESETS,
+					hipcie->reset);
+	if (ret) {
+		dev_err(dev, "Couldn't assert reset %d\n", ret);
+		goto reg_dis;
+	}
 
-	reset_control_assert(hipcie->bus_reset);
-	reset_control_deassert(hipcie->bus_reset);
+	ret = reset_control_bulk_deassert(PCIE_HISTB_NUM_RESETS,
+					  hipcie->reset);
+	if (ret) {
+		dev_err(dev, "Couldn't dessert reset %d\n", ret);
+		goto reg_dis;
+	}
 
 	return 0;
 
@@ -321,23 +331,12 @@ static int histb_pcie_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, hipcie->num_clks,
 				     "failed to get clocks\n");
 
-	hipcie->soft_reset = devm_reset_control_get(dev, "soft");
-	if (IS_ERR(hipcie->soft_reset)) {
-		dev_err(dev, "couldn't get soft reset\n");
-		return PTR_ERR(hipcie->soft_reset);
-	}
+	ret = devm_reset_control_bulk_get_exclusive(dev,
+						    PCIE_HISTB_NUM_RESETS,
+						    hipcie->reset);
+	if (ret)
+		return dev_err_probe(dev, ret, "Cannot get the Core resets\n");
 
-	hipcie->sys_reset = devm_reset_control_get(dev, "sys");
-	if (IS_ERR(hipcie->sys_reset)) {
-		dev_err(dev, "couldn't get sys reset\n");
-		return PTR_ERR(hipcie->sys_reset);
-	}
-
-	hipcie->bus_reset = devm_reset_control_get(dev, "bus");
-	if (IS_ERR(hipcie->bus_reset)) {
-		dev_err(dev, "couldn't get bus reset\n");
-		return PTR_ERR(hipcie->bus_reset);
-	}
 
 	hipcie->phy = devm_phy_get(dev, "phy");
 	if (IS_ERR(hipcie->phy)) {
-- 
2.50.1


