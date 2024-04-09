Return-Path: <linux-pci+bounces-5968-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3632489E2F9
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 21:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E05B31F2288D
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 19:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA70157E61;
	Tue,  9 Apr 2024 19:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJm/ZN6l"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D99157A5F;
	Tue,  9 Apr 2024 19:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712689727; cv=none; b=uVGUegO8lIz+lgZEMOEANbAHxXFahwnLpL9MJKgK9N25hI+KCd3URb/86Q71VH84/PPPLELxmhsv/mmCqiupelZR1RgIt//0ye7why//jsOu/zmMu22nTwLNKbMW3BDeg4z39OFLVun+z+wLL1fRk73wgrsMYnpWB8H/iG6rfTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712689727; c=relaxed/simple;
	bh=TF34Kiq3IULPX0vZLKg5UujAr20o/F0a7repIuGYPOs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BYcVFtCcUMUxTRJFAKjWls6GrSIAxcLpQc2/BKIwpEbvDKvQeJTErKUs+Ot7hlrLCPDRYluLL0j4a3pgN+dOyRkBytKoEPz+tF1j9gn/hdFZ2vNfqyIN3f8UKh1MpFYRkMHbH09+8+qogJGFe8ebC/vLeVJ4qZHQDS740w6zo2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJm/ZN6l; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5aa1fe2ad39so2064493eaf.2;
        Tue, 09 Apr 2024 12:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712689724; x=1713294524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r7AD4q8JSZ6BP9Ctt3D7xQmOd/l0E0VUTJ6hrw2gcfc=;
        b=EJm/ZN6laHXIj+J/WMRVMVpNLfTkz3xwAK2eEEAvDRLQ+iPu7cxHoTCeN23LqsN4FW
         cVEcbBmIYypA4Rr3aLxg8s8Bna0peMWOYQQFlAZZ4aCTZlXW0PVZAHWn+SO++GuvV5m1
         xDUOw5YGRkRn0EezdWO1SXjvlmqq4uzNRe+9ivcSIV/2y6Ro6S6vXQcGGpoYKCVvneQZ
         oZ5q7N4Li66zeRjhx4JOYj04JHKe/WKLCF1WJvCokpNf52Eucxpm7v2c/d8rUJsHLHX4
         XeM0misdgJPQuG9ssah8GiwyhpDOQC7nGlSd1l9RDWa7QydVZJeyRwrt2KFwQKQeA+bC
         WQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712689724; x=1713294524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r7AD4q8JSZ6BP9Ctt3D7xQmOd/l0E0VUTJ6hrw2gcfc=;
        b=CqoCmcqxL8btxYH6vf3KIvU7ZdNvVHVkfLlmQNkU0X7D9xjmKZUILl/z/jOhkYdcpj
         hRzmvrToW1GpxRgAW9LrNYXDfGz5fmQt6kzm1pBDITth4Ji6uMe+FJuOZjsXBF8pRNCc
         X40+q4GrLPZTPdJZ5yX/n0pN+lBK+A97dm6Y93lJAgIZ5UPI2KhnRiMdGBIl3mf6FURV
         f1tupBOrVMOFNhU9VrpYBeUU2lA23K6g17x1DSRUrFIaUOoxGJUf8/ugleAsHZxqd1L2
         lJ43kRTycQ0xHhvDkT3Iftp1ONvIawTbAJNJuKXGVax3yp+Q9t0udPAJMxIAyMHBrMP9
         Febw==
X-Forwarded-Encrypted: i=1; AJvYcCVzcYwsBegeGvhI11aZHsNV0nek5XAsMELiDpgUj64KVQVkC/gvc9/ASAu1YT+7zOdq3JIdnsGEVf6AVjVLP79Mo8/utjxD76xKKyXBSGCVblMnffR/cpSOIqk1GjXkqiyFEgvMs5EOQ98De+Vx01FjJVvM8GlBSW/znJ+9uvtPAeQLmVjZKg==
X-Gm-Message-State: AOJu0YzwZdQjnUDDgznDZx8PT3dAEC76U+xWCz+GwsHBImDd8xWBc80H
	NitZ19sBb3gSN5lNqribHlIQhMEiKT0Qtb3QGarEUQ7vJD4V+YLf
X-Google-Smtp-Source: AGHT+IEp6pqikQ+dKpBJfShL46ppdQkFdslYVen1TbCPJt9rJq3/rmmJsLo2FExk5FWOsuBQCNzs3A==
X-Received: by 2002:a05:6820:2d49:b0:5aa:53ea:ffd0 with SMTP id dz9-20020a0568202d4900b005aa53eaffd0mr897099oob.1.1712689724695;
        Tue, 09 Apr 2024 12:08:44 -0700 (PDT)
Received: from nukework.lan (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id f11-20020a9d7b4b000000b006ea1cf91a8dsm674920oto.40.2024.04.09.12.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 12:08:44 -0700 (PDT)
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/7] PCI: qcom: Add support for IPQ9574
Date: Tue,  9 Apr 2024 14:08:30 -0500
Message-Id: <20240409190833.3485824-5-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240409190833.3485824-1-mr.nuke.me@gmail.com>
References: <20240409190833.3485824-1-mr.nuke.me@gmail.com>
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
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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


