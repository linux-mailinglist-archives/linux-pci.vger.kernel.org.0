Return-Path: <linux-pci+bounces-19650-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60893A0A9B0
	for <lists+linux-pci@lfdr.de>; Sun, 12 Jan 2025 14:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4480B1885DC1
	for <lists+linux-pci@lfdr.de>; Sun, 12 Jan 2025 13:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1C11B85D3;
	Sun, 12 Jan 2025 13:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LLg2OqoW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0A51B6D02
	for <linux-pci@vger.kernel.org>; Sun, 12 Jan 2025 13:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736689155; cv=none; b=bkIMEWhvUHmD97YDC0OUh38W54GwgLWf/Lx9eQdWZCHvHw8e7SiEVAZSWyvQ6jLsh4cbydgUI+8uS5X1CnkOONkaFK75M7exkNXxrTOadlL6dY0da8B2Hvd3qMdeoWSrEyYchS6dk7wARq3kVNty/apVwJFbohERnB2LBthbkio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736689155; c=relaxed/simple;
	bh=O/NOpD3CQ/1x8q7Y6t4lRJsHtiSHlvyOKne/i9Zp+mw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P8DlduIgyP2txOAzrj25nZVSkVpw2My+Y/g4eqCs9xQFZZqMh9cXb4Owfp1Vfaee1VYMdNG8h5e5OKu6QFevTN65MCwo9r0sw69/xIpqPVw6hCBbCRc6aWLrhB5HhKB7kK8zP2L4PmTgGZ+LEMnHWX1F8/Z0ezsepwf9kZ+K7rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LLg2OqoW; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-436381876e2so2936975e9.1
        for <linux-pci@vger.kernel.org>; Sun, 12 Jan 2025 05:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736689151; x=1737293951; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nQ3Whnc9k1Q+1OLPMm8+x6IOLTpBlsEtmK8zovMkXoM=;
        b=LLg2OqoWo331EgOB/4golxzlFLg90rauHU/W6xHlKbTNLq26bMQFU9d7JzUSSFIjUT
         18UKCIojpzCo7txOInWhsEq5nRRj+QIQoyasUw8I9Pv+aIyXoEKT7CK2v5s4F1shv+4u
         IfSOO2gRRsSaM+4HPwHZaFFO/MUHkaZ2sOE3g+ciIUOhj7z3PzFx/aRC69KVYBMzcPuO
         LNwIivb/QouNvhxjN0sieX/YEKgBWEL0x6G6W2Zc0CgrB8UdLnjKUW0R1YVN8AC+sCdI
         9CGedP1oqu25zoXfLCDAQ6wn6T7lkB+NM2vV0NtC6GrOE4sKpfSMc7CzNwtFAxGqIDaw
         EKfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736689151; x=1737293951;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nQ3Whnc9k1Q+1OLPMm8+x6IOLTpBlsEtmK8zovMkXoM=;
        b=LE9H1e2TzEVRrvFfnlEOKt+qQB/ekVNSMvp05/qREXpSZfiSqkAVJXPYdyVHJNfGcG
         7XS9GKQATWmZhETlgLlpLxiQ3JuuoJVkOxo4Son7nrCqwLEHb2GGj4mlRKo3LZe1sKUj
         CwLbj7mVQ3MALZTdPdadGMvLj0aHJsABoLt0bJ6HnD8JEt63u2zbbGRm/9jI4Sy9O2TW
         BdDsjFvTaBo3S/v9/UHdpfki4MzQI41xrlTqfDgMGNXzCkRdFQ3OihK24ZEElmiyk21z
         7EbLLus/3WgIWk+LZvwlDq2ijrcDDxU3gbmU5x+gs0j/rh0SHX0RIU8k3UBDMZWIEQXP
         oebQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHDCA8xGsfQyZnm2AJNQl8paeHMK+MKDjPpvAFyNHMnRwCA+m1z8BoPOxWKe3uao0eOGcLeqy91u0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5dv7oSreQHAdYvft2oefmBZkeGe0K4BEzcDLk3HK+3zlklcKt
	F7mTNFUbJK2Z6l+PBeEazXjxE6E0jJmwOW8V4P1eTrtQhCcMoE/I7vnrcszDCNE=
X-Gm-Gg: ASbGncvg1DNYWakcFb77NlUkjJyqcST2i1OLMpfYTCIlbfYeUTkwlXn5gArMvVRBTS2
	we/K+sJhDGPbs8xJiEV97CBGYR0skTv1vAgFGxaAGWf63RekiBSd0B/ue8ty28352BdTqYm+Bka
	MlWn+VUv+81L6iqw4oNpy7J/CLSEqTEmXUK7cGsHwanKbeAR+eRW060DiRJClLdEa/n+VLt/wU4
	HmJ17FryBmQhZf7ZmjCkStKt8X/I6e/2gaAURjZYXXtQ2QsKT9Pq2h29mlggU+AtcXNDh3Z
X-Google-Smtp-Source: AGHT+IHlqQUT4nJ5SQNBM6sybXZwL+bzxz0Y9M1+BN250gX4iG9BJx5WOU34PwgsHmMccXztrJhIFg==
X-Received: by 2002:a05:600c:35c2:b0:434:941c:9df2 with SMTP id 5b1f17b1804b1-436e272c89cmr62461175e9.8.1736689151481;
        Sun, 12 Jan 2025 05:39:11 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e38c006sm9581924f8f.46.2025.01.12.05.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 05:39:10 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 12 Jan 2025 14:39:02 +0100
Subject: [PATCH 1/2] PCI: dwc: dra7xx: Use
 syscon_regmap_lookup_by_phandle_args
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250112-syscon-phandle-args-pci-v1-1-fcb6ebcc0afc@linaro.org>
References: <20250112-syscon-phandle-args-pci-v1-0-fcb6ebcc0afc@linaro.org>
In-Reply-To: <20250112-syscon-phandle-args-pci-v1-0-fcb6ebcc0afc@linaro.org>
To: Vignesh Raghavendra <vigneshr@ti.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Minghuan Lian <minghuan.Lian@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>, 
 Roy Zang <roy.zang@nxp.com>
Cc: linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, imx@lists.linux.dev, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2790;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=O/NOpD3CQ/1x8q7Y6t4lRJsHtiSHlvyOKne/i9Zp+mw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBng8X4L014og7m5GFccNS9Q1a7ef8G6dskIt37N
 AtuFjYZz3GJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ4PF+AAKCRDBN2bmhouD
 1zdhD/9GJ5EK0dF1XS8FiJAKuNvLC2/kqb5mlabJRSMHZdEJCZ/GL7iydkfU9R1IKDjA66xKDmm
 hlNvjnRKN/hieQdFKqBKkIaX7u1J8XN81DlqeApDDVAvXODx9YSIhO9ohNVyS2TKVr8ijveqHRV
 xf1hkYIqg3PI+4hoBI19dAtKTe5fMuYqNGAef1GQif0M7Ft7R4pwIy8GOzXcwEwN/w2sxCihHI0
 dFdgfMR8fpJlfVyXIzExgvbuAQHETHiDkWsEMuFk026YaBiYaNFUUySyGVGlkMOA9W6sDHzBTVd
 dMq7AR+B+9ieQF6+urHXKTHdEulrR6e5GzgbtB/HP6Lg7moaY3WQWo55ApZSRtX3pIKxpkCCR5a
 sVwl4OKXXouOWzWCjNZJtSHMln7mbZL0AtDRu3woJlZLn3gfL+EPeSBbJUnzgUcOIfZ9eo8GAsG
 ntmiIBueXybLz+sA/pd+O1rFk5mWLdE9/SO4XfQmTTAcUSw7ZgxdlM1gGc3f7BNNSZZSBSRunX0
 2YlqC5NDhKq0MCNb9E3HwtK5DDgD0VRrfxyjd7wpqx/nWmLxq0+A1CtnkXo5AKgDBofZrafaiPD
 BFSuFhJASUudUf8dUahKZZsyJMXG063citE9ertMgorxFBCJvwmvganrycsTWi47bthL/d4KAxB
 REoi4dl1sllDW8g==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Use syscon_regmap_lookup_by_phandle_args() which is a wrapper over
syscon_regmap_lookup_by_phandle() combined with getting the syscon
argument.  Except simpler code this annotates within one line that given
phandle has arguments, so grepping for code would be easier.

There is also no real benefit in printing errors on missing syscon
argument, because this is done just too late: runtime check on
static/build-time data.  Dtschema and Devicetree bindings offer the
static/build-time check for this already.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/pci/controller/dwc/pci-dra7xx.c | 27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index 5c62e1a3ba52919afe96fbcbc6edaf70775a69cb..33d6bf460ffe5bb724a061558dd93ec7bdadc336 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -635,30 +635,20 @@ static int dra7xx_pcie_unaligned_memaccess(struct device *dev)
 {
 	int ret;
 	struct device_node *np = dev->of_node;
-	struct of_phandle_args args;
+	unsigned int args[2];
 	struct regmap *regmap;
 
-	regmap = syscon_regmap_lookup_by_phandle(np,
-						 "ti,syscon-unaligned-access");
+	regmap = syscon_regmap_lookup_by_phandle_args(np, "ti,syscon-unaligned-access",
+						      2, args);
 	if (IS_ERR(regmap)) {
 		dev_dbg(dev, "can't get ti,syscon-unaligned-access\n");
 		return -EINVAL;
 	}
 
-	ret = of_parse_phandle_with_fixed_args(np, "ti,syscon-unaligned-access",
-					       2, 0, &args);
-	if (ret) {
-		dev_err(dev, "failed to parse ti,syscon-unaligned-access\n");
-		return ret;
-	}
-
-	ret = regmap_update_bits(regmap, args.args[0], args.args[1],
-				 args.args[1]);
+	ret = regmap_update_bits(regmap, args[0], args[1], args[1]);
 	if (ret)
 		dev_err(dev, "failed to enable unaligned access\n");
 
-	of_node_put(args.np);
-
 	return ret;
 }
 
@@ -671,18 +661,13 @@ static int dra7xx_pcie_configure_two_lane(struct device *dev,
 	u32 mask;
 	u32 val;
 
-	pcie_syscon = syscon_regmap_lookup_by_phandle(np, "ti,syscon-lane-sel");
+	pcie_syscon = syscon_regmap_lookup_by_phandle_args(np, "ti,syscon-lane-sel",
+							   1, &pcie_reg);
 	if (IS_ERR(pcie_syscon)) {
 		dev_err(dev, "unable to get ti,syscon-lane-sel\n");
 		return -EINVAL;
 	}
 
-	if (of_property_read_u32_index(np, "ti,syscon-lane-sel", 1,
-				       &pcie_reg)) {
-		dev_err(dev, "couldn't get lane selection reg offset\n");
-		return -EINVAL;
-	}
-
 	mask = b1co_mode_sel_mask | PCIE_B0_B1_TSYNCEN;
 	val = PCIE_B1C0_MODE_SEL | PCIE_B0_B1_TSYNCEN;
 	regmap_update_bits(pcie_syscon, pcie_reg, mask, val);

-- 
2.43.0


