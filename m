Return-Path: <linux-pci+bounces-21667-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB7FA38BB9
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 19:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 564A21642F7
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 18:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69301239591;
	Mon, 17 Feb 2025 18:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WFx7V8wd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B7E23909C
	for <linux-pci@vger.kernel.org>; Mon, 17 Feb 2025 18:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739818594; cv=none; b=lvTC/wi3juF9JgIavqs4dbgOKBCgTwSjCSnpU1oDAPZWn1N4qVtGdXL/v4g3VFzGFXs2xxdiaK69pBRL6amvBvSisfTDerTmpE7qdJbO/6JA/ZDNrlfdC17TqW3RRwzQE/mzNw1JQ5kb6/BOaDDn0Ak+JNIcSzNtHCMeRtIcirg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739818594; c=relaxed/simple;
	bh=wGbtSkOIS1Iuz5fKGeWZ2NubL56j96GS5DJQPjfqTcs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FekVVQMq+9NxRAxqWFDrs/vH4VS3HoOi44HykCdAq3KkVRd6ieEvJK7o+aj7wxWsbfVe059lWw91/0WMBDOunEHqfBZ2ojmBLKXp9hXZOrzCfdjX1wqCGz3/F187H6z5oq+NGbVcHEzf4b0+/mkIXXHCYF6t1zAbjyqzb04XpiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WFx7V8wd; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-54298ec925bso6331803e87.3
        for <linux-pci@vger.kernel.org>; Mon, 17 Feb 2025 10:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739818590; x=1740423390; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dnx+499wAlgTr/GDMFSoZHiBNBSDytj9kmR+kriab8A=;
        b=WFx7V8wdU3wRDxu+75UAyXflR3Mh6pYmDMyknGqwMhZxpcqT3AiesAihjhwC/Hp09s
         ZlYN073yhl0d1YkpKEA5JHI0Xs+sU/xiv7Z5E165gnOFSjY82oc5fsR9yVJ3EEf7byl5
         vg//QTRmy4YI7ormIsYsD4LHXL5/n1RgfwGwbJGz8HArkkULWCIbFrkv3hr4pYqr6Q7M
         n/1V1DsatK4M99dBvFp3bI97rrD27fkG4UuXbGNzcHyOhfjVoIL8yBd38VYvgLNNU+iK
         1vdrWNl1yP37jrO+Yek+XAOHoXgqpMov6mhElk+MoomeUec1lehk2vaiTuIgCGl0sFbj
         yBaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739818590; x=1740423390;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dnx+499wAlgTr/GDMFSoZHiBNBSDytj9kmR+kriab8A=;
        b=kp8+aE4KnSZ3Dkj7ZmR/0Tx+pL04zxAiIFlN3Sg0VnPg6DCpJ56U4uNL/unEHPntVr
         AQ8ypqxwSlK1d/TnroXpsArZuQ2vr7Df4YincRnIFBfmGkHJLmTzd+unioZ6cwDooS8d
         tov2sLwb8fxLTIQ8wQ7FQyd4ZdLYTSuBG8mGR/yRknvlN2g0l2tKSmQRwYXYgFg+AzO2
         tdDKxB2Y5wdMKbAeIcrjcMHQ50cyiLEeH/Y6e+yuRwJPTyUWNbzba+jNFg/uk0aJr5lj
         a5N/Wz1S+mJ3jzSKEUx9JM+kxHNw1/VryvRDBpnEvfegvMWQVeK6pY7tocwOwGPHuLpF
         he6g==
X-Forwarded-Encrypted: i=1; AJvYcCUrIYF8bRlfr++6DapD96/0fyCur2E3v+xjBTX1v9sDOcc1B2EC7nNmds1xav7H5ENkpAXT5tsDyLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZWCAicvXvx/uFDbSPFlr1JTYL3OUTeyBfdo9VCZJ4L+Zq0HlA
	4/GS1xuMC0SDhFwj5897iSROgj69asm6hdMh/Wv8ruJ8v7YaD8EOYLREjaqejmY=
X-Gm-Gg: ASbGncs3j942pFqcL8a8LqmTWHyV0xy7z7S3WwMbJ3XpSv0YG/zqrrXLcLlJ1EzaDb2
	yP+mbzZxPQEsHz4c19sdNruShDAL3KQaVXiSv95XxkJQTFU0dgmDAmjFrgabb3LIFtxAZ0jYJZC
	e5ZXkxDTZwN1LtsiplFpi1mnZB2xxGdJoH0U+dM+aJMrQfY6RRk8CykZsltXM3f2ydCVq6DNEJx
	I7SmKzSUXV8a5C2atorR61mrHOvptTegrLbBnXG/20z30dFy10JGw3AFzN76W0CiyguD3NJIMhV
	L+U5w61/4bvxGuU5JFdRZbO2uheb9txywC5Y0INSHO8UtcPUbuaQRzx3Kn8=
X-Google-Smtp-Source: AGHT+IGf3rVWNVV+36hZnGW0EwqdzAP8muTOp8By250+zpjC9dwfkje1qvbCXHnaazRikB/2Kmm6Nw==
X-Received: by 2002:a05:6512:2342:b0:545:b89:3098 with SMTP id 2adb3069b0e04-5452fe5b894mr4340777e87.24.1739818590361;
        Mon, 17 Feb 2025 10:56:30 -0800 (PST)
Received: from [127.0.1.1] (2001-14ba-a0c3-3a00--782.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::782])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5462006b0ecsm559806e87.160.2025.02.17.10.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 10:56:30 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 17 Feb 2025 20:56:18 +0200
Subject: [PATCH 6/6] arm64: dts: qcom: sm8450: add PCIe EP device nodes
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-sar2130p-pci-v1-6-94b20ec70a14@linaro.org>
References: <20250217-sar2130p-pci-v1-0-94b20ec70a14@linaro.org>
In-Reply-To: <20250217-sar2130p-pci-v1-0-94b20ec70a14@linaro.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Mrinmay Sarkar <quic_msarkar@quicinc.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2465;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=wGbtSkOIS1Iuz5fKGeWZ2NubL56j96GS5DJQPjfqTcs=;
 b=owEBbQKS/ZANAwAKARTbcu2+gGW4AcsmYgBns4ZRQ1ZvySgAhYD1KDi7cz3C9ivFGjEY5yrGW
 Ehcf77vIl+JAjMEAAEKAB0WIQRdB85SOKWMgfgVe+4U23LtvoBluAUCZ7OGUQAKCRAU23LtvoBl
 uAJhEAC5LysuEh/QhR3cUh7kBUZT3oqYIzwz+D4AJ+7MaA4Ka2jXkkpIQOVErp5f5IjpTeubszO
 shxhAEo5lJy1eh2syxCXIUrPk9kvPnSAioSlT3PyF743yN+EBO3Id8PvQCTcXssiYlTBk9PCHLG
 4zZlrwlDumADnEDd0ZbUN974FFcv/DivnpRHVqM3gaRprW2LmHHUqmBoeUV7g/4TjzT113EaUXU
 cb/wDNWv3oUMQnkXuZ4+Z9l0OOot/cxVJGtNIIDQEhNNw2n8oESIPG1H0QcDORGVixojUoSAP5/
 z4p4YzLFm4SUnSs0eogO9QyscnoaHNUgg2TxTZGPi5jatvqLRRIBS746XXGwiNyoi2VOEz3lFmS
 w2GJ5+QLTZaiRAHC2DHLVoAL9iYbi+Jo1vojd/xOyK5knoVCPlk4+9U/vyKSC+vMuxomrv2LAUH
 xpByNEC+SVr4p9pnV78P4cP8PFR5Nkd+OoagaZ5j+iDR4SNPzlTPFUkwcrgIsdjXVOx1kYsaM/N
 074gyWJR0B3bfycpQTKisXYT3+GkXig3ksg3NqfSzDd7fFQW1GJ5pRFqjbyz7G/nbZKaaVGLeHq
 awaDck+c4eAGJV/772HPHc6izLPpRF9uLR37R+VQ3C2zGqkAyswo1RIJq1AKtxUDjIQo/XDez6z
 WC0uNSsTw0z89sQ==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

On the Qualcomm SM8450 platform the second PCIe host can be used
either as an RC or as an EP device. Add device node for the PCIe EP.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 52 ++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 9c809fc5fa45a98ff5441a0b6809931588897243..ad0ec15b18e5ca7bea196be1564152f7faf51d9f 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -2262,6 +2262,58 @@ pcie@0 {
 			};
 		};
 
+		pcie1_ep: pcie-ep@1c08000 {
+			compatible = "qcom,sm8450-pcie-ep";
+			reg = <0x0 0x01c08000 0x0 0x3000>,
+			      <0x0 0x40000000 0x0 0xf1d>,
+			      <0x0 0x40000f20 0x0 0xa8>,
+			      <0x0 0x40001000 0x0 0x1000>,
+			      <0x0 0x40200000 0x0 0x1000000>,
+			      <0x0 0x01c0b000 0x0 0x1000>,
+			      <0x0 0x40002000 0x0 0x1000>;
+			reg-names = "parf", "dbi", "elbi", "atu", "addr_space",
+				    "mmio", "dma";
+
+			clocks = <&gcc GCC_PCIE_1_AUX_CLK>,
+				 <&gcc GCC_PCIE_1_CFG_AHB_CLK>,
+				 <&gcc GCC_PCIE_1_MSTR_AXI_CLK>,
+				 <&gcc GCC_PCIE_1_SLV_AXI_CLK>,
+				 <&gcc GCC_PCIE_1_SLV_Q2A_AXI_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK>,
+				 <&gcc GCC_DDRSS_PCIE_SF_TBU_CLK>,
+				 <&gcc GCC_AGGRE_NOC_PCIE_1_AXI_CLK>;
+			clock-names = "aux",
+				      "cfg",
+				      "bus_master",
+				      "bus_slave",
+				      "slave_q2a",
+				      "ref",
+				      "ddrss_sf_tbu",
+				      "aggre_noc_axi";
+
+			interrupts = <GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 440 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "global", "doorbell", "dma";
+
+			interconnects = <&pcie_noc MASTER_PCIE_1 0 &mc_virt SLAVE_EBI1 0>,
+					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_PCIE_1 0>;
+			interconnect-names = "pcie-mem", "cpu-pcie";
+
+			iommus = <&apps_smmu 0x1c80 0x7f>;
+			resets = <&gcc GCC_PCIE_1_BCR>;
+			reset-names = "core";
+			power-domains = <&gcc PCIE_1_GDSC>;
+			phys = <&pcie1_phy>;
+			phy-names = "pciephy";
+			num-lanes = <2>;
+
+			pinctrl-names = "default";
+			pinctrl-0 = <&pcie1_default_state>;
+
+			status = "disabled";
+		};
+
 		pcie1_phy: phy@1c0e000 {
 			compatible = "qcom,sm8450-qmp-gen4x2-pcie-phy";
 			reg = <0 0x01c0e000 0 0x2000>;

-- 
2.39.5


