Return-Path: <linux-pci+bounces-21994-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 818EFA3F9A1
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 16:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAE4C1657CA
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 15:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386FF21171C;
	Fri, 21 Feb 2025 15:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YCn26tSX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B12210F6A
	for <linux-pci@vger.kernel.org>; Fri, 21 Feb 2025 15:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740153138; cv=none; b=k9mHZRxlfvQEucZLyhDEteXk37Tmj76pvgjp/NKeCcOpEDqHSmeNpSpEItFOOKMBhA3SF+OcVfGRqa9nHAB0P1hl+6YauciDlgu8//I04ZTbP6eHl5ugTWNkQ2MQypcFy+eMk8h9efgMOwrpXOmHKZwjGtCtjRAvMnpcGR9zaik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740153138; c=relaxed/simple;
	bh=b6PLMBw7yyw15o3VEzosQAWxFJYLV5zXvl5ZUGHocbU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tv9jI44ak5KUppeUW0YwTRc9JFsgVrcaUS9wGv9n6E8UHnpJNSOuhplxtN/yJ6awPt7V1ifyEI4EoBTl9X8mQq+y8tR24Qr6DFAxlO1ik/jY3DtLcNjjPSrPFRzads6K2mjVnf3IcXaMBBVdalZP+JKZmAfp5qC88PF8cqIAKL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YCn26tSX; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-543cc81ddebso2665683e87.1
        for <linux-pci@vger.kernel.org>; Fri, 21 Feb 2025 07:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740153133; x=1740757933; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hf+01lWdYqM6cH2pf9TEQebVcTlfAkpm0nesnJVjo8c=;
        b=YCn26tSXCcwF6annzF5tNuwe1dCHTDxDmuGKB9btWOkBwM/wmqFbtJTdmDzAQsyDa2
         RSnOTW2md5sE03r0wl96TmPoGYH8iDmi9FvbAOWLKx9aL9NunCeWPMcuG0ZnDhAYrHVr
         xEubhfUWnc7jvPjbQlAkTn888vuGxsatnJSLGDNACXb4IG5zm7RU3I5xuOIDc7ge0JMm
         GUycSvv8ASAWoMDLJxSwBjghQm6uo8GkLJgkV7H+ig+l0QreQro05oFw+qMH5zOUuguz
         MtArvEeQiVFr7Wi+XJdQpFmeQ46PmT0O2xRJlQg3yxlaraivCJzEx9I3Eg7z+2qrTets
         1Z2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740153133; x=1740757933;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hf+01lWdYqM6cH2pf9TEQebVcTlfAkpm0nesnJVjo8c=;
        b=DV4xq2jWugui3535OJn3C2Qt6d2WUhu1U3ClaKRYstIS0eV01HohhdYVedA+yETigD
         wr1QJWlZIJH9x+kEVc8ZJIECCNux0JmlgD3q1rDfe8KWEtywXzTcQGA9x5sMgKWWuUgL
         lfbikJK29fAxtlNnZbQEoU7k0gw+TiVSG7H8F2OHMkvrz4vSBiw0IRpHChJTZABMzTQu
         0QpugZbOOqmMCwA2n3yBKAA47+2y0ufzBpETsvDRgsEWE2tTNm8EUCleOTVwPXLdRz6j
         cb6KpLOm6abJnIYBM71FWjeSr3l5V/bbDAgOIErwrrWoL9EDTKOe2YIjcNb1v2qHzINr
         iouA==
X-Forwarded-Encrypted: i=1; AJvYcCXUeZFu1ZSQF1QtS2Bo327PgUzhrAu8D/Vz21uFvUbbyrOm76Xkq9pyMiZiyYTW9tK2r0GwnBU2Vug=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi9wyR9zHQ9FzXrQLiBa9JymNVqbOUcXY2MzAMgWO4LHcOgZY7
	sPrG8qa0QhVH26P7JlTYk2iAYtC0JMFykUScVw1t/YX2KYm628Q+8NP9psKkwSw=
X-Gm-Gg: ASbGncsCR4R6qdOO+ikoWJ41IgqhzArUGT8NgLUJSp5fEaU17G+Mbua4M0/Q7+oT3s6
	cuNo4M7ZOLgraftKQ8Wfaq3g67x4JoHHc0FSqDZj7XJdI08qXkZdeIVlJWQeOct+DBBT5BNiAoO
	9kaTG8+moqzzniqnIQr0QVQNoSRpEjQthCsp4uet/nAPFvV2IRc45RWwRt/MhX29N6VHiUi17Ha
	2T0IgcyNet3KEp32oK2zV2aOLvZGfPlZfRxIRQzVI0cf/6KOsiw5eAdS/e6WaxQW7c3PM2O3D9E
	ju3cJDcuiVVl+/YxS+y0WQShSclYVktRnuxGl1VAg5u6fC/JopgBP+4CHjBV4ojV4+KZ0g==
X-Google-Smtp-Source: AGHT+IFK/BW6WRfk5AFZvJoLcO2PKHdti1399J++2O52dSFTn5Nhq5RV0d2Y2l04B0b9I6MXTb11ag==
X-Received: by 2002:a05:6512:2354:b0:544:ca1:da41 with SMTP id 2adb3069b0e04-54838f78dbemr1431389e87.44.1740153133477;
        Fri, 21 Feb 2025 07:52:13 -0800 (PST)
Received: from [127.0.1.1] (2001-14ba-a0c3-3a00--782.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::782])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54816a55851sm287643e87.27.2025.02.21.07.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 07:52:13 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 21 Feb 2025 17:52:05 +0200
Subject: [PATCH v3 7/8] arm64: dts: qcom: sar2130p: add PCIe EP device
 nodes
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-sar2130p-pci-v3-7-61a0fdfb75b4@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2669;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=b6PLMBw7yyw15o3VEzosQAWxFJYLV5zXvl5ZUGHocbU=;
 b=owEBbQKS/ZANAwAKARTbcu2+gGW4AcsmYgBnuKEiLu4pfIYUZYk2R0MP9UobeotuKgNJ4Vvhf
 444qj3IgI6JAjMEAAEKAB0WIQRdB85SOKWMgfgVe+4U23LtvoBluAUCZ7ihIgAKCRAU23LtvoBl
 uOVzD/4wumWgTSyYzm8guT77vJxWxEvDxLtib6B0StQvn1OelUa5kd2rD9mt7iDV+uuxqVEcu5J
 QhjoQl99UqfezKsMhYiHN15aeVKVzP4c+ZDss+vog1iokW87cyNooH1Uk3uWoEA0mKeY0pXh8EJ
 1Ouf5D16bMD/KaanyXnQzLLy9uvx4hA7cIQIgrvyG6calt+vBYuZhzZ40Z6wzcsVMYQ1rthHEk5
 j5mNBXQb5eDQBdNSHJKB2pGMGxGQ5GsKlEodn2d092CeJop68Uni6wkmeycN5z8xLKZQjddi8Fa
 POLMzqLshMH5iHi477NCBWq4xmi/2xCxRUSmvCHTrQs/dgmQcb/jUTOSHicGmANOPXF9Oz4Mtjs
 QQwjryHC+bm8MkZOeR0JuP2TDL98czDcyqbsKs6GM7wZVEMOXgl3d1NjwpxuRGi0H3ZNcADhAtL
 SxpzxUrQ8rm/G0DZEOM+jKDaYecYlTbtrB8auPz1PweNuwpnfCkSoa7yuDltN3nyjU8zvoUm3O+
 iprtfdKlHMgK50sk7Tj1WxRvS2pyjn5bZfDNsB3ued59hZV6LKRIMwcFwP0I4s2KKoiDpPN5sHs
 0CKDHCzGjo7AeniTpfUqYKbMYvEFbmdmF2Uv5fDTi2slzoSbq4pxOMnR5i7oa4xwfAjD7b6UhZo
 Af2oEnk+Vto7skg==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

On the Qualcomm AR2 Gen1 platform the second PCIe host can be used
either as an RC or as an EP device. Add device node for the PCIe EP.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sar2130p.dtsi | 61 ++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sar2130p.dtsi b/arch/arm64/boot/dts/qcom/sar2130p.dtsi
index dd832e6816be85817fd1ecc853f8d4c800826bc4..b45e9e2ae0357bd0c7d719eaf4fc1faa1cf913f2 100644
--- a/arch/arm64/boot/dts/qcom/sar2130p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sar2130p.dtsi
@@ -1474,6 +1474,67 @@ pcie@0 {
 			};
 		};
 
+		pcie1_ep: pcie-ep@1c08000 {
+			compatible = "qcom,sar2130p-pcie-ep";
+			reg = <0x0 0x01c08000 0x0 0x3000>,
+			      <0x0 0x40000000 0x0 0xf1d>,
+			      <0x0 0x40000f20 0x0 0xa8>,
+			      <0x0 0x40001000 0x0 0x1000>,
+			      <0x0 0x40200000 0x0 0x1000000>,
+			      <0x0 0x01c0b000 0x0 0x1000>,
+			      <0x0 0x40002000 0x0 0x2000>;
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
+				 <&gcc GCC_DDRSS_PCIE_SF_CLK>,
+				 <&gcc GCC_AGGRE_NOC_PCIE_1_AXI_CLK>,
+				 <&gcc GCC_CFG_NOC_PCIE_ANOC_AHB_CLK>,
+				 <&gcc GCC_QMIP_PCIE_AHB_CLK>;
+			clock-names = "aux",
+				      "cfg",
+				      "bus_master",
+				      "bus_slave",
+				      "slave_q2a",
+				      "ddrss_sf_tbu",
+				      "aggre_noc_axi",
+				      "cnoc_sf_axi",
+				      "qmip_pcie_ahb";
+
+			interrupts = <GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 440 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH>;
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
+			iommus = <&apps_smmu 0x1e00 0x1>;
+			resets = <&gcc GCC_PCIE_1_BCR>;
+			reset-names = "core";
+			power-domains = <&gcc PCIE_1_GDSC>;
+			phys = <&pcie1_phy>;
+			phy-names = "pciephy";
+
+			num-lanes = <2>;
+
+			status = "disabled";
+		};
+
 		pcie1_phy: phy@1c0e000 {
 			compatible = "qcom,sar2130p-qmp-gen3x2-pcie-phy";
 			reg = <0x0 0x01c0e000 0x0 0x2000>;

-- 
2.39.5


