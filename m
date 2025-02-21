Return-Path: <linux-pci+bounces-21995-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D497A3F9AF
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 16:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A9C41665BA
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 15:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12E721322C;
	Fri, 21 Feb 2025 15:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QhnuiKTi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383C0211470
	for <linux-pci@vger.kernel.org>; Fri, 21 Feb 2025 15:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740153139; cv=none; b=QTeaxch1+rD2kWxYGIevBXqx9eWv/aRm3sExPJdem5CjNXXo9ikylwJ3kIiyH2ogn5FhBZ/1D6L1EIlBhIG52Y0lnk24iWS52G0BvuFth81ChuIJVTGKs41nUeVVJSAimXr9qfXgLNL6alRUBII35FQSfSowkDdH96Lz1sLWP8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740153139; c=relaxed/simple;
	bh=itIH8UmE28DLal026/vQWt51OaBADCkRmt6MMWb6ec0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DXp0QShz9apsxavG4N375srr7HifO03N2JwHlMBNiWANdtWEkRXPw3S8IrwdDAk/vfu72d/lvdcA0VH3H9Vj7aJVXqWsPvZ5KAaNDm4CIyLsLYUCiuZsLUA1lbzAhOkEv9u7JGjqMsN0quDHVxqQwyqPF3BagWBT2FAaQUyEPkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QhnuiKTi; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5461a485a72so2326292e87.0
        for <linux-pci@vger.kernel.org>; Fri, 21 Feb 2025 07:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740153134; x=1740757934; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VcBk8LX8RGiFV095rZ/v8IBisxh6FvmuEC9JHwGym/o=;
        b=QhnuiKTixEqncOBSyU/e8BRYtX4GoPwKQSFigZZUTyJgHJ7i4kVl2CKQbriFM9mz2V
         NsgYlKFeo5NWbZxHXRedxaB2ibmgsd4+bcVK06fyV+uOdIfD2tb5+guRwSUpK//bnFY3
         kXwsRUPDsh3oHlpuyoq/OeV+ZJw2N56lXtf+oWs6yFTJIEaUc92YSy7fs77uB8sI/T0v
         wNlgNpZDrYcFsOBVDICmza7PxjwDZ6M3YVL8Eakm3KrdstwnuqFj1KjTDYzNZdr+I7Pq
         QMvwKdnFNk4vMlM0cpzWa7hyGydCc/PRq+fyeXIpI9XRV+bHN/GwZ9yfxqfwKriMO9+o
         /veg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740153134; x=1740757934;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VcBk8LX8RGiFV095rZ/v8IBisxh6FvmuEC9JHwGym/o=;
        b=OsxFPhSuspXcWntiZjQlLVfF5CT/oyLzksHbacISIE20iC6Zf8kL5D9A6r0+9Otj4O
         7ZuueAdAFFvTaorCHvK7zBnDKjeXOwBWpLfqUghAMU7fo9B2ttP9SDnubpR3oyy7PabX
         7tXR0m1oDLHzkJLC5ius0lDQ92GDK/LvEUXFd9jQZ2np5P9vSqAEBHZoYTpwBwwMftui
         JHusTIt0GMqq3TPaTLYef1QcG2tMql+2LbAnefu1jXgXlX87yHBqlKGLHEDvi42sBKsW
         9SKeX/hk+q3twnCjaop1+0HrL2JnqiJEwkKCiktkzB2zNJmkY9DWm4QRkOmRqR/W/XWy
         /YTw==
X-Forwarded-Encrypted: i=1; AJvYcCWAmaIDCwYTXlQyR/0kpRYBS7jcwRoB3XThZJI1GcTQXGFHRV/zQMVoUqv+gWwQ1tLEqWcPLG/T+0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YypHZcdWiuF74X7W9BKVdsyQ0hOS5IdDMrQcS8Rf/kSzsYuTQlP
	g+UOBjbG7Mm2X6N+UMuAZAFbNl/ZQ+dvjaYawUmUyGm38LQoubqISa6QN6xPqjg=
X-Gm-Gg: ASbGncs4pVY9Tl7EJcsqHgMvhBQy0QVMu47BZAeoYQ5phPjt5DW1v8JlHg1FIGUT3/k
	v6qE9kpjhN/ROi5CRUYYUw4fk6dY9OsGugMBay9uBNlNbqDPYtKzJTiO5W4JWfLW5fUCKyCpOgq
	nFB9guxBOiMXuAnPrxvTPCcneBnDN+ge4p2S+jpjLSOaaCbwUjVx1E0F8Df/G5H+Lu8SDehlRlH
	26+mXWc0VEvaGulz3OYlpF0Z2bgN1Ul9Ed1FCKnPbj23YKIfXxxzYVCX0wExJMxjz9uqGMIH2Kp
	43y7wHYfU+NvtQ7HDqXfXrK4gXgTg701Cgf+wYktu8U7IKhjogWyla/h/qEmZc3knh3TnQ==
X-Google-Smtp-Source: AGHT+IGXwDQ6KvAlUvgVLHl9BpLcdHtn4LDHMCX5t2NTi/kJuJKg0cz/4viQPsv+yDPDkIHr723vVA==
X-Received: by 2002:a05:6512:3503:b0:545:95b:a335 with SMTP id 2adb3069b0e04-54838ee79abmr1182590e87.14.1740153134346;
        Fri, 21 Feb 2025 07:52:14 -0800 (PST)
Received: from [127.0.1.1] (2001-14ba-a0c3-3a00--782.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::782])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54816a55851sm287643e87.27.2025.02.21.07.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 07:52:13 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 21 Feb 2025 17:52:06 +0200
Subject: [PATCH v3 8/8] arm64: dts: qcom: sm8450: add PCIe EP device nodes
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-sar2130p-pci-v3-8-61a0fdfb75b4@linaro.org>
References: <20250221-sar2130p-pci-v3-0-61a0fdfb75b4@linaro.org>
In-Reply-To: <20250221-sar2130p-pci-v3-0-61a0fdfb75b4@linaro.org>
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
 b=owEBbQKS/ZANAwAKARTbcu2+gGW4AcsmYgBnuKEjzP90Rsi8wZFwY1H7vj6P3ZzTAfBsi5R7u
 f090X2czsuJAjMEAAEKAB0WIQRdB85SOKWMgfgVe+4U23LtvoBluAUCZ7ihIwAKCRAU23LtvoBl
 uN75D/9s5F14U18NUkgIuUc/tS92qDUirdg/CqgymIIjiZr4UzLk1AapcRVsrtNLfgzaZT1H5Rl
 Kk0Gs1lchiauAdklqFB0V5kYqPoCUro26yAjssr7B+GoRy/VLyawcnQNceRA4QTThknZn81CfdZ
 h4Ynu1kt15nXjFWoCrrZH3SvcxS9z1Xga3Hkng1nCnBFXGL8eoC1GJqf+6D2zbDCv2OVKnJDGBb
 X3Fo2m4fjIlmr+7MDHcuOWr9GXkFOyiH1zzU+JFL7ljVP4YIjMo0DFlkaH3ahsQTZ6j5JhEhWUe
 9j9zwHyvOJ+Kcz3WA9M26htXbYneF1Diwu9WplGL8C5lRQpYB9uxAtvDXILo1QsM60lBP12sF4Z
 vVIcoOZyBa5iL8MGtM7zI9qyjr8Re2wincJ2m82pkW6nt9HSssnuBsAL9Dn+VDuJ6j4VMe1cjqx
 S77og6Shhpoc9JunjDxl3iClfK1yMpCLgVABuepNWurpa1BfoVwKnnpXOVFTmUqM7/KO4xXYygI
 2TzXh9NzainkP2rEQbmg4deUYPRGAQ3qyqnTwuUcfzahligFTmus9FUR/TJGf8/OMbSN5+tGS2E
 YvO+XTBAEE3cP4teEP33Jtm528bE/5NvlgI9Ld4WKDowjd/eX/KqduOyyccCntQhvb/XTosLVwl
 pDMcjIcbPgZnE8w==
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


