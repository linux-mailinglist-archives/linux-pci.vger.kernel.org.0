Return-Path: <linux-pci+bounces-21958-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFFEA3EB0A
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 04:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E3FF19C5D11
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 03:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC11C1D8DEE;
	Fri, 21 Feb 2025 03:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x0Eivf1X"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE341EDA22
	for <linux-pci@vger.kernel.org>; Fri, 21 Feb 2025 03:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740107183; cv=none; b=l33PV8o/lxSkQMdTdorrDIqB1gp799RUyFLJDGkTQfH76KqsMYbS6+NLzWvvHAotZd/7+tyeYFfh4uspklUHBZYOu57DAe5PMtoLcxLFD+29IgzaIg80ChjS/rX/SY3ZK3ZDrDjRGaLqpWuZKlo9f1t5TDGXdl0FkziDE/RkGBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740107183; c=relaxed/simple;
	bh=itIH8UmE28DLal026/vQWt51OaBADCkRmt6MMWb6ec0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K6osx+BdqNOqm5dGkAYE1Tm7heoQvF0MsBPyo01kp8nMXB3XJEn1xfFk7Hb5OwK5yd7gl2VsVDEyef/nHKeZsRMm6zyV/yIS6YE5xiuXqqOwKCtjxOkEgD6rGq2YOJjwfmNfhtEBZ4G8zd/jn6XliqODe5NaeyYqfWTGmXPieo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x0Eivf1X; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-543e47e93a3so1891350e87.2
        for <linux-pci@vger.kernel.org>; Thu, 20 Feb 2025 19:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740107180; x=1740711980; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VcBk8LX8RGiFV095rZ/v8IBisxh6FvmuEC9JHwGym/o=;
        b=x0Eivf1XeU0MdkW++41XJ4fDWFeZk67LQXPAgRB8SM3pNza4SfLpsxKKmAPdLcD0Y3
         c7Co4aLGd4uausz9zJiLj3WugV+mGzZ5zkbKP5vgcRsxz0zLIayfCAUsPw/VBrwzGxIz
         X2RODNXVF8jlj7sXvRALP81b/Be4cGS85iIvK87FCRyoMh5G4/wClmC2axruvNseIi5y
         0foRcIbb43vBKh/7ZRV0Vep7E0DCreNl0CyqyheRA8/PLv4Mw535dndCerEzx10zpwsJ
         +oAm1raTyIqejByjH6/DMIz+YSYg14RZsBmLFDnoerWpQ6huznC+ngD/XKqVuExHLXnM
         H0+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740107180; x=1740711980;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VcBk8LX8RGiFV095rZ/v8IBisxh6FvmuEC9JHwGym/o=;
        b=o7umqyHxi8Tld6NTwZ7rTtdVWZzy2W+HMHQxEu6GBti0d08ZjYYYhDlfAeW7b4KU+B
         qYYpiSkqcvcB4OHfgRhiyzlorTzF6kLGD5zXls93egHhBx9gllCZNfk4IuIgQU7PvHlI
         IjRjHO34qaTUDJIU4H8gPdmE3MG16e3a5Lo4UzxkXiwrGGVp8vbiALwXzNeDCZUrpRl1
         YiyJROfDxuOqMYho5jSNCTLyc0K71MTL2SRl8gv4mxpVsfoLt2dUKIRGanOk9hpRnXBA
         oRhBc+kwd8j4ioGzgZ/3yDPn25ABPGBOHNKi4TSHXkKOWXBeUm03D7QhXKOLC2v16lsQ
         QzqA==
X-Forwarded-Encrypted: i=1; AJvYcCU6EYSRfDE+DHEXUzYwfvlKM2WB5E3J09nws/AGX1lTTIEdNZ/4IHb32tKg43EoWV+XYbMLx48tlGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwflLj4mygHkmDCTBpbC1Eo6KT9Z93Iwli4ogTfD9CK3kKN6cJX
	7BRUFoF9VkPD94BfCttew/szlh5MPDHxhZz+GmrJA38PD8q0aoxZJXtnW/EYH/k=
X-Gm-Gg: ASbGncurCwSqXOaFhYsfV/nos/6xqbwkJRkWXM5tPDv2bC3aLxA0kE7gTtv8cb3zlXl
	HEfwAxNtkOns89tvyk2nHPxBqniZHXp/qACNW7uK1b0cNczPn6ebBcBEaxJI60KHF92ZqMxN0mQ
	SRAvm3Vug5g2qhyH1tU2f23lm7Mnj6W0ONkyox4DTNRJ1WI0aYtBmFEKI9V78QpejNf47ihyOmR
	cC/y/2Jt01+Ajz5OwY6841IDVRPhnBtxNgJQ4y3ya8Rl0QZCHGG+bqV+09xylyYg6OmVPrlW+bv
	+j7Hr4v4UhUpxKssdtFIxsAEvyB7MheH23/gsEDPGlEDOL6PHrjebtQ++yK6Z3L+oA5llw==
X-Google-Smtp-Source: AGHT+IFXvdc2fyi/lO5TeWjQg2BckbeLJtxtIh4LjuQ+/7pWa0B56pUmkwGIizEjWYjzFlrCAPv5xQ==
X-Received: by 2002:a05:6512:3053:b0:545:b28:2f94 with SMTP id 2adb3069b0e04-54839144fe8mr354503e87.25.1740107180172;
        Thu, 20 Feb 2025 19:06:20 -0800 (PST)
Received: from [127.0.1.1] (2001-14ba-a0c3-3a00--782.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::782])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a2be45876sm16021071fa.68.2025.02.20.19.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 19:06:18 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 21 Feb 2025 05:06:05 +0200
Subject: [PATCH v2 6/6] arm64: dts: qcom: sm8450: add PCIe EP device nodes
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-sar2130p-pci-v2-6-cc87590ffbeb@linaro.org>
References: <20250221-sar2130p-pci-v2-0-cc87590ffbeb@linaro.org>
In-Reply-To: <20250221-sar2130p-pci-v2-0-cc87590ffbeb@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2643;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=itIH8UmE28DLal026/vQWt51OaBADCkRmt6MMWb6ec0=;
 b=owEBbQKS/ZANAwAKARTbcu2+gGW4AcsmYgBnt+2bRGfqizSlKdB8tdyZiV1VxNhZGs2adFF6Q
 ur6WJ32FfSJAjMEAAEKAB0WIQRdB85SOKWMgfgVe+4U23LtvoBluAUCZ7ftmwAKCRAU23LtvoBl
 uIuzEACbi9w3d7ZvRKbNhxJBhT/FFx65l6Q3qqCPHdUy0xu8P27eHy4CEE+HUKOdryYpUAX7PN+
 F2DOuhUd16MznS4jqU8J3f0TUKZQGygL/ywiCs73mWFHdbBXe2c/WUiuvtkwzVu5v4eYcUEYLv1
 SxF5W9gILOOHxxWAn63F2DJBHYjQ9pUrUdIlQdfSG1cr3SH1mOsJFEqaIYOQ7nNj8PEn1gQjMj4
 b3JaDSvjfQglIvYCefHMgFuapvnEQkKqK7U+JnIrTCkMyY2N4vWLfZHBfsseBHyFADSrWcKXmAB
 XsLL5mT9hpKnGQ3l8hiLXLvgdpMf7IqGR3zAOf/BbWny2PgXcu/9kWVj7k4LEFl/J5Lu4HOHftP
 QMm8B9EEIIjHMLjCxT2a45mKVkgV2U9cM+hGbmKY9uxdJP1qReRQ8vnIGWRC3zp5vsgys8oxYp8
 XKAbPH7NB74VTjheIGFQkPqNS7qJqDw3pSo45anzlfED8U51oqjzIAZkOJZHcdWJEO2JsSFnFkh
 Vd1vI8i9mLAEDl1jlEd9pjyT5pEmLUXfNsbEYYNq1GDlaDQmafRGkDmCAjO5AZOUAFM62BUTED5
 rY09HCjSKqVtJMby7JsVMyThE7X8LAOxJhtp3qnd4gFbUzwfCp1iNtRF1Leq4E3xUmCvjyCHgQV
 NbXKbg4/8LoBT3w==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

On the Qualcomm SM8450 platform the second PCIe host can be used
either as an RC or as an EP device. Add device node for the PCIe EP.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 62 ++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 9c809fc5fa45a98ff5441a0b6809931588897243..3783930d63a73158addc44d00d9da2efa0986a25 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -2262,6 +2262,68 @@ pcie@0 {
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
+			reg-names = "parf",
+				    "dbi",
+				    "elbi",
+				    "atu",
+				    "addr_space",
+				    "mmio",
+				    "dma";
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
+			interrupt-names = "global",
+					  "doorbell",
+					  "dma";
+
+			interconnects = <&pcie_noc MASTER_PCIE_1 QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
+					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &config_noc SLAVE_PCIE_1 QCOM_ICC_TAG_ACTIVE_ONLY>;
+			interconnect-names = "pcie-mem",
+					     "cpu-pcie";
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


