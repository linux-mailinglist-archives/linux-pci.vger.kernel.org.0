Return-Path: <linux-pci+bounces-20798-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E6EA2A859
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2025 13:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B4651688B2
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2025 12:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A436722FDEA;
	Thu,  6 Feb 2025 12:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="asiNq98F"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EE122DFAD;
	Thu,  6 Feb 2025 12:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738844346; cv=none; b=UEL823eRyHm7B/0t5CITODZxXw2WJweQPGfMADtS6VsveqV8yLAqTuMc59XqVjC3ZAdaTohU230xuCe2v239kPxy57ev4o/5KKHQoQYUjnMp5g5QQ2ZMVJ1qXv8n6VqZkOpAA2yuNVZGlj9NW50ffhM3EtWbz05h9Q/McUdtKFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738844346; c=relaxed/simple;
	bh=zXoavuWGxHIoXjceMgr1+MPL/5pJBcagy60qcR3K+F4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nGCIFN6wDMZskkjIraVEFMRdrC5vyyhWL8ygweJdAvIIDIkfbXgt6R7WjhzrWH4F+7SinjvUPdbXcel7x+nXji1wCsnS6oPnV/TTgfbdF9aVHUxsxzzGzokHQ1EfwMAf+OKW4CCfHsM9aoXE2jb6Uhk7agn2tOtvLGg3P8Eg8ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=asiNq98F; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5169CRMf014659;
	Thu, 6 Feb 2025 12:18:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	liM90EaSFkWz5fvN8fV9sCOz9l6VJFMwSOb3OnAq/jY=; b=asiNq98F1/CM40xf
	F9RAdBk9Sly4kvajfseypYyqnXnAI6vW8QPUvkDh7v/jmL/J3d9LIyjXeASv/4CB
	rsEENdyYK6mh9cRH09XbHTMV2D/4fdr9zdzryPWsC0cXgFrgI/WJrSBeOiLPcdBx
	jJYXdArT589/gFCN/UUaickRO3KwunqIIXQb9NJlmXpcDPCd/HpXoMaVKOLeBd1U
	3ZBWzGl9bzDp1DOLZ9aOfGuRB5sK/QCVCZIo6fvQ8qRiWy2fazR6LS5fXx9uxzHk
	KjKDTCr05bDtcfA18mDTxXs1FLsxSX5eFEskpc1bZVsU9lPV5oZ9I79LmI6YbWFx
	zZposw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44mt8e0fjm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Feb 2025 12:18:54 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 516CIsMN019091
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 6 Feb 2025 12:18:54 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 6 Feb 2025 04:18:48 -0800
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <vkoul@kernel.org>, <kishon@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <p.zabel@pengutronix.de>,
        <quic_nsekar@quicinc.com>, <dmitry.baryshkov@linaro.org>,
        <quic_varada@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>
CC: Praveenkumar I <quic_ipkumar@quicinc.com>,
        Konrad Dybcio
	<konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH v10 6/7] arm64: dts: qcom: ipq5332: Add PCIe related nodes
Date: Thu, 6 Feb 2025 17:48:02 +0530
Message-ID: <20250206121803.1128216-7-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250206121803.1128216-1-quic_varada@quicinc.com>
References: <20250206121803.1128216-1-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 0AjJS8bSeIbmYzGT2yf3kcwCUUVHw7Dd
X-Proofpoint-GUID: 0AjJS8bSeIbmYzGT2yf3kcwCUUVHw7Dd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-06_03,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502060102

From: Praveenkumar I <quic_ipkumar@quicinc.com>

Add phy and controller nodes for pcie0_x1 and pcie1_x2.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v10: Trim down the list of assigned clocks
     Fix arch/arm64/boot/dts/qcom/ipq5332.dtsi:627.24-729.5: Warning (simple_bus_reg): /soc@0/pcie@20000000: simple-bus unit address format error, expected "80000"
     Rearrange nodes w.r.t. address sort order

v7: * Fix IO 'ranges' entry
    * Add root port definitions
    * Not adding 'dma-coherent' as the controller doesn't have that support
    * Remove 'bus-range' as it has default values
    * Group root complex related entries and root port related entries
      separately

v6: * Add 'num-lanes' to "pcie0_phy: phy@4b0000"
    * Earlier, some related clock rates were set in U-Boot. In
      recent versions of U-Boot this has been removed resulting
      in the phy link not coming up. To remove boot loader
      dependency add assigned-clocks and assigned-clock-rates to
      the controller nodes.
    * Not sure if 'Reviewed-by' should be dropped.

v5: Add 'num-lanes' to "pcie1_phy: phy@4b1000"
    Make ipq5332 as main and ipq9574 as fallback compatible
    Move controller nodes per address
    Having Konrad's Reviewed-By

v4: Remove 'reset-names' as driver uses bulk APIs
    Remove 'clock-output-names' as driver uses bulk APIs
    Add missing reset for pcie1_phy
    Convert 'reg-names' to a vertical list
    Move 'msi-map' before interrupts

v3: Fix compatible string for phy nodes
    Use ipq9574 as backup compatible instead of new compatible for ipq5332
    Fix mixed case hex addresses
    Add "mhi" space
    Removed unnecessary comments and stray blank lines

v2: Fix nodes' location per address
---
 arch/arm64/boot/dts/qcom/ipq5332.dtsi | 252 +++++++++++++++++++++++++-
 1 file changed, 250 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
index ca3da95730bd..1115d8388ef9 100644
--- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
@@ -167,6 +167,214 @@ usbphy0: phy@7b000 {
 			status = "disabled";
 		};
 
+		pcie0: pcie@80000 {
+			compatible = "qcom,pcie-ipq5332", "qcom,pcie-ipq9574";
+			reg = <0x00080000 0x3000>,
+			      <0x20000000 0xf1d>,
+			      <0x20000f20 0xa8>,
+			      <0x20001000 0x1000>,
+			      <0x20100000 0x1000>,
+			      <0x00083000 0x1000>;
+			reg-names = "parf",
+				    "dbi",
+				    "elbi",
+				    "atu",
+				    "config",
+				    "mhi";
+			device_type = "pci";
+			linux,pci-domain = <0>;
+			num-lanes = <1>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			ranges = <0x01000000 0x0 0x00000000 0x20200000 0x0 0x00100000>,
+				 <0x02000000 0x0 0x20300000 0x20300000 0x0 0x0fd00000>;
+
+			msi-map = <0x0 &v2m0 0x0 0xffd>;
+
+			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi0",
+					  "msi1",
+					  "msi2",
+					  "msi3",
+					  "msi4",
+					  "msi5",
+					  "msi6",
+					  "msi7",
+					  "global";
+
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &intc 0 0 35 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 2 &intc 0 0 36 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 3 &intc 0 0 37 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 4 &intc 0 0 38 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_PCIE3X1_0_AXI_M_CLK>,
+				 <&gcc GCC_PCIE3X1_0_AXI_S_CLK>,
+				 <&gcc GCC_PCIE3X1_0_AXI_S_BRIDGE_CLK>,
+				 <&gcc GCC_PCIE3X1_0_RCHG_CLK>,
+				 <&gcc GCC_PCIE3X1_0_AHB_CLK>,
+				 <&gcc GCC_PCIE3X1_0_AUX_CLK>;
+			clock-names = "axi_m",
+				      "axi_s",
+				      "axi_bridge",
+				      "rchng",
+				      "ahb",
+				      "aux";
+
+			assigned-clocks = <&gcc GCC_PCIE3X1_0_AUX_CLK>;
+
+			assigned-clock-rates = <2000000>;
+
+			resets = <&gcc GCC_PCIE3X1_0_PIPE_ARES>,
+				 <&gcc GCC_PCIE3X1_0_CORE_STICKY_ARES>,
+				 <&gcc GCC_PCIE3X1_0_AXI_S_STICKY_ARES>,
+				 <&gcc GCC_PCIE3X1_0_AXI_S_CLK_ARES>,
+				 <&gcc GCC_PCIE3X1_0_AXI_M_STICKY_ARES>,
+				 <&gcc GCC_PCIE3X1_0_AXI_M_CLK_ARES>,
+				 <&gcc GCC_PCIE3X1_0_AUX_CLK_ARES>,
+				 <&gcc GCC_PCIE3X1_0_AHB_CLK_ARES>;
+			reset-names = "pipe",
+				      "sticky",
+				      "axi_s_sticky",
+				      "axi_s",
+				      "axi_m_sticky",
+				      "axi_m",
+				      "aux",
+				      "ahb";
+
+			phys = <&pcie0_phy>;
+			phy-names = "pciephy";
+
+			interconnects = <&gcc MASTER_SNOC_PCIE3_1_M &gcc SLAVE_SNOC_PCIE3_1_M>,
+					<&gcc MASTER_ANOC_PCIE3_1_S &gcc SLAVE_ANOC_PCIE3_1_S>;
+			interconnect-names = "pcie-mem", "cpu-pcie";
+
+			status = "disabled";
+
+			pcie@0 {
+				device_type = "pci";
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+			};
+		};
+
+		pcie1: pcie@88000 {
+			compatible = "qcom,pcie-ipq5332", "qcom,pcie-ipq9574";
+			reg = <0x00088000 0x3000>,
+			      <0x18000000 0xf1d>,
+			      <0x18000f20 0xa8>,
+			      <0x18001000 0x1000>,
+			      <0x18100000 0x1000>,
+			      <0x0008b000 0x1000>;
+			reg-names = "parf",
+				    "dbi",
+				    "elbi",
+				    "atu",
+				    "config",
+				    "mhi";
+			device_type = "pci";
+			linux,pci-domain = <1>;
+			num-lanes = <2>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			ranges = <0x01000000 0x0 0x00000000 0x18200000 0x0 0x00100000>,
+				 <0x02000000 0x0 0x18300000 0x18300000 0x0 0x07d00000>;
+
+			msi-map = <0x0 &v2m0 0x0 0xffd>;
+
+			interrupts = <GIC_SPI 403 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 410 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 411 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi0",
+					  "msi1",
+					  "msi2",
+					  "msi3",
+					  "msi4",
+					  "msi5",
+					  "msi6",
+					  "msi7",
+					  "global";
+
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &intc 0 0 412 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 2 &intc 0 0 413 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 3 &intc 0 0 414 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 4 &intc 0 0 415 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_PCIE3X2_AXI_M_CLK>,
+				 <&gcc GCC_PCIE3X2_AXI_S_CLK>,
+				 <&gcc GCC_PCIE3X2_AXI_S_BRIDGE_CLK>,
+				 <&gcc GCC_PCIE3X2_RCHG_CLK>,
+				 <&gcc GCC_PCIE3X2_AHB_CLK>,
+				 <&gcc GCC_PCIE3X2_AUX_CLK>;
+			clock-names = "axi_m",
+				      "axi_s",
+				      "axi_bridge",
+				      "rchng",
+				      "ahb",
+				      "aux";
+
+			assigned-clocks = <&gcc GCC_PCIE3X2_AUX_CLK>;
+
+			assigned-clock-rates = <2000000>;
+
+			resets = <&gcc GCC_PCIE3X2_PIPE_ARES>,
+				 <&gcc GCC_PCIE3X2_CORE_STICKY_ARES>,
+				 <&gcc GCC_PCIE3X2_AXI_S_STICKY_ARES>,
+				 <&gcc GCC_PCIE3X2_AXI_S_CLK_ARES>,
+				 <&gcc GCC_PCIE3X2_AXI_M_STICKY_ARES>,
+				 <&gcc GCC_PCIE3X2_AXI_M_CLK_ARES>,
+				 <&gcc GCC_PCIE3X2_AUX_CLK_ARES>,
+				 <&gcc GCC_PCIE3X2_AHB_CLK_ARES>;
+			reset-names = "pipe",
+				      "sticky",
+				      "axi_s_sticky",
+				      "axi_s",
+				      "axi_m_sticky",
+				      "axi_m",
+				      "aux",
+				      "ahb";
+
+			phys = <&pcie1_phy>;
+			phy-names = "pciephy";
+
+			interconnects = <&gcc MASTER_SNOC_PCIE3_2_M &gcc SLAVE_SNOC_PCIE3_2_M>,
+					<&gcc MASTER_ANOC_PCIE3_2_S &gcc SLAVE_ANOC_PCIE3_2_S>;
+			interconnect-names = "pcie-mem", "cpu-pcie";
+
+			status = "disabled";
+
+			pcie@0 {
+				device_type = "pci";
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+			};
+		};
+
 		qfprom: efuse@a4000 {
 			compatible = "qcom,ipq5332-qfprom", "qcom,qfprom";
 			reg = <0x000a4000 0x721>;
@@ -186,6 +394,46 @@ rng: rng@e3000 {
 			clock-names = "core";
 		};
 
+		pcie0_phy: phy@4b0000 {
+			compatible = "qcom,ipq5332-uniphy-pcie-phy";
+			reg = <0x004b0000 0x800>;
+
+			clocks = <&gcc GCC_PCIE3X1_0_PIPE_CLK>,
+				 <&gcc GCC_PCIE3X1_PHY_AHB_CLK>;
+
+			resets = <&gcc GCC_PCIE3X1_0_PHY_BCR>,
+				 <&gcc GCC_PCIE3X1_PHY_AHB_CLK_ARES>,
+				 <&gcc GCC_PCIE3X1_0_PHY_PHY_BCR>;
+
+			#clock-cells = <0>;
+
+			#phy-cells = <0>;
+
+			num-lanes = <1>;
+
+			status = "disabled";
+		};
+
+		pcie1_phy: phy@4b1000 {
+			compatible = "qcom,ipq5332-uniphy-pcie-phy";
+			reg = <0x004b1000 0x1000>;
+
+			clocks = <&gcc GCC_PCIE3X2_PIPE_CLK>,
+				 <&gcc GCC_PCIE3X2_PHY_AHB_CLK>;
+
+			resets = <&gcc GCC_PCIE3X2_PHY_BCR>,
+				 <&gcc GCC_PCIE3X2_PHY_AHB_CLK_ARES>,
+				 <&gcc GCC_PCIE3X2PHY_PHY_BCR>;
+
+			#clock-cells = <0>;
+
+			#phy-cells = <0>;
+
+			num-lanes = <2>;
+
+			status = "disabled";
+		};
+
 		tlmm: pinctrl@1000000 {
 			compatible = "qcom,ipq5332-tlmm";
 			reg = <0x01000000 0x300000>;
@@ -212,8 +460,8 @@ gcc: clock-controller@1800000 {
 			#interconnect-cells = <1>;
 			clocks = <&xo_board>,
 				 <&sleep_clk>,
-				 <0>,
-				 <0>,
+				 <&pcie1_phy>,
+				 <&pcie0_phy>,
 				 <0>;
 		};
 
-- 
2.34.1


