Return-Path: <linux-pci+bounces-6283-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 316E38A59C1
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 20:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 541651C20F28
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 18:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266B513C3C9;
	Mon, 15 Apr 2024 18:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVLu2y9P"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F54613AA48;
	Mon, 15 Apr 2024 18:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713205283; cv=none; b=EjmthONO9HnLgUPaBun8AUzyNzC6kuzZzMWZEjBiT4aqCOr0/DLL870qBFfMQCkwnm/RhzFFw+VGZHlWnPgfAfjrhAIrAItsUzwTQkp+3rCof4O1YoBjwlqW6Ga1xpZMpFBVSvAQUODhLtEGHHaBM+X0ZFE+vzECHhRkGCWMglo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713205283; c=relaxed/simple;
	bh=Y3sQe52k1yICnNk6VsdMH27lecC3GY2DlpewVQmBUI0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lcrfwvrUcypGNagHDwmgjINQBBNiqxexaUCTUqerWpxWCWsLx6ZkwARRmg7kzAKrDUzhtKY6wzWc8PQy3RBpgGRs+OOxIWrnkN42W1Eo/wGKTGP0FqZoo+orYwmuldZnzobaPZjSI9xOkmIhfzS9cgwPeUrxPC7yQbJCo5Ee1fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WVLu2y9P; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-22edbb5dd40so1375385fac.1;
        Mon, 15 Apr 2024 11:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713205281; x=1713810081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u509fpdTL3x8h0sKnxRrMd2Q/Sm/IRVlvPpLmK46sCY=;
        b=WVLu2y9PWr7IT5mHJ5TO6wVGVWXM+Mp52aYTMbd8s9FKg8R1hBLRAmkagCCbLM5zbm
         WDuoE09nRBtsRNoY2aO22MxpaxNysl6aZ52kO5vCzIrWLmbDOqN0aBY7WIV7RqfyUyEl
         8sn5QQI+PoYY7YJbpzK3rDzuEp/Zj27p2vyAHGh47C6BDPU9j1hPUmsd5c3rkYBB60GV
         ipPXI/pYsEv4wgM842XCn80TGTe3LhEL8xZMASTHzAKiFJ3OI4epcDjPBQwgZSpTaXzt
         UCz/CnbA+nUvgIzzsviPPMHKs4awZ+PkhpT2jlQb4gXCs6tLevtZ6WfRhOUD7HwnhQMX
         qgeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713205281; x=1713810081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u509fpdTL3x8h0sKnxRrMd2Q/Sm/IRVlvPpLmK46sCY=;
        b=WDr24KAUU0LsYvvdSHbziQ8bjzSpCD6hVaBIFr6ppvTPjx/Dln1Y5UYme7c1FMYnZ5
         HjT9Pnj1ERlt9OKlkbyPkh0J/o68zjvfjcCs0apthAp9sKiWNzQRTZn72dG5ulHyvyS2
         UpQGE47ekb1gMrvmA6J2isAj8eu1C/tlMi0ns6s7wiWGBL+5knIB3iykl9FEkWnjpRMu
         E184ITh70Mb9xnWHqcvfidxnqF/+e5io9ZvPxGQ01uvnZ1X8f8lndGptlqKmdc5Q8PxV
         i5K8ijixxYGybfZh7YjM8DF13KV2zx3bOrwJBO5NmQFD7mU82WbrDBIQLqOR1T61QEnA
         A4kQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoDC3U5ETV0zgsWbFQ7Uj7tQHOIuEBNnA5+kcOCunxljs6ce/ob8gXSXdJFB1V5aqYUaEohXoYKqSL+ZBKNkP0LLA782FazF+H2GhZMVfTZ70pNklmXlnam0WcuMBVKYJ4ma3yIm2HF/w2keNnVU34FMsi8rf6Bc2sKddWAe8mNblRfejhKKXh64/6sqSmS/ejTEpzFj70LrSq7xAkc37cngGflDJCCEJFn4OH2WpkN1YT5u5QFc6QrpvNAuU=
X-Gm-Message-State: AOJu0YwdO5TRR9x2iTlMtzK9y8mpVkY63nQ+3P3QdLOEZOYGLP1LZdgw
	ycjX/Hf296TQfJDKD7yQ9NuSpYl42A8kYWn6kjqSlCXtoQqoaS6H
X-Google-Smtp-Source: AGHT+IH/8B0e9NM5WliOP9w/PF1ZRgCApTZi+SCJC4O7CiUjYmCpNmOGWSyNpvTqihZDA+VKDZbWTg==
X-Received: by 2002:a05:6870:f694:b0:233:6e01:69b8 with SMTP id el20-20020a056870f69400b002336e0169b8mr159816oab.3.1713205280834;
        Mon, 15 Apr 2024 11:21:20 -0700 (PDT)
Received: from nukework.lan (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id x4-20020a056820104400b005a4dc7abc01sm2177494oot.11.2024.04.15.11.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 11:21:20 -0700 (PDT)
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-clk@vger.kernel.org
Cc: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Subject: [PATCH v3 4/7] PCI: qcom: Add support for IPQ9574
Date: Mon, 15 Apr 2024 13:20:49 -0500
Message-Id: <20240415182052.374494-5-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240415182052.374494-1-mr.nuke.me@gmail.com>
References: <20240415182052.374494-1-mr.nuke.me@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the PCIe on IPQ9574. The main difference from ipq6018
is that the "iface" clock is not necessarry. Add a special case in
qcom_pcie_get_resources_2_9_0() to handle this.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 14772edcf0d3..10560d6d6336 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1101,15 +1101,19 @@ static int qcom_pcie_get_resources_2_9_0(struct qcom_pcie *pcie)
 	struct qcom_pcie_resources_2_9_0 *res = &pcie->res.v2_9_0;
 	struct dw_pcie *pci = pcie->pci;
 	struct device *dev = pci->dev;
-	int ret;
+	int ret, num_clks = ARRAY_SIZE(res->clks) - 1;
 
-	res->clks[0].id = "iface";
+	res->clks[0].id = "rchng";
 	res->clks[1].id = "axi_m";
 	res->clks[2].id = "axi_s";
 	res->clks[3].id = "axi_bridge";
-	res->clks[4].id = "rchng";
 
-	ret = devm_clk_bulk_get(dev, ARRAY_SIZE(res->clks), res->clks);
+	if (!of_device_is_compatible(dev->of_node, "qcom,pcie-ipq9574")) {
+		res->clks[4].id = "iface";
+		num_clks++;
+	}
+
+	ret = devm_clk_bulk_get(dev, num_clks, res->clks);
 	if (ret < 0)
 		return ret;
 
@@ -1664,6 +1668,7 @@ static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-ipq8064-v2", .data = &cfg_2_1_0 },
 	{ .compatible = "qcom,pcie-ipq8074", .data = &cfg_2_3_3 },
 	{ .compatible = "qcom,pcie-ipq8074-gen3", .data = &cfg_2_9_0 },
+	{ .compatible = "qcom,pcie-ipq9574", .data = &cfg_2_9_0 },
 	{ .compatible = "qcom,pcie-msm8996", .data = &cfg_2_3_2 },
 	{ .compatible = "qcom,pcie-qcs404", .data = &cfg_2_4_0 },
 	{ .compatible = "qcom,pcie-sa8540p", .data = &cfg_sc8280xp },
-- 
2.40.1


