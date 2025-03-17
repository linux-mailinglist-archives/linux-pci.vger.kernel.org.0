Return-Path: <linux-pci+bounces-23915-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2BEA648A1
	for <lists+linux-pci@lfdr.de>; Mon, 17 Mar 2025 11:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6900E169747
	for <lists+linux-pci@lfdr.de>; Mon, 17 Mar 2025 10:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67847231C8D;
	Mon, 17 Mar 2025 10:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bTZGWN8U"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82910235BE2;
	Mon, 17 Mar 2025 10:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742205696; cv=none; b=rAkihwlXWsC8n8xCzd1dsmD5yJpZKy/yUkcCdSKJmAP+0vXqOGyrDGhNPnxL/wG4TIMNDNHxy3vBoblaCLyZAyaej+EIgIhQnrlgH7gbRZAGFoTK2F+VJZkcJnV2bdFGZcy3hbI1Hq08OACuI5tPHlakQkiqCLx7KgGfyABt9Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742205696; c=relaxed/simple;
	bh=qRbZBPovWtZ9UjcGT0L3DjNIauKOCoeYfUl+kvtmOb8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bG5WEYSHdwdkfwgF/RtNmW+kPTvhBu/RCLjWzojvCqqz5w8b8Do1lXJTgngQLTFNlyyVQAQrpXpyq8xMGcKhufNJZ28j3fVLlLCt2Ar9at9/RCAboOoF+jRmoqa1WsOd9oT6e+iI9l9cbErBhb8Yub1qQNO6dr4yhxfYHuUfle0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bTZGWN8U; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52H00gRX008255;
	Mon, 17 Mar 2025 10:01:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	31Tdpk0vGa3aCQX9M2Il1C5vQIsaHazzJnXRGN+S26c=; b=bTZGWN8UUy+ke13Q
	RWRwGRgSwHSzva5DFWyr5AF+5qTgKU3Ku6bNUkg+6C7mb5qynXI+hZJqsEi4+iEt
	38JduE7baKbLJ/vo6k6JpU6gVgHge/mwXqHt6rg6uuO4adzlDcgYCEEigzKXlt/V
	wqXkimJT2vEkMGhCI8oxjukzoJS1OJVXbJzytLk83RmeLNzUaVUKq5ffmYUsMWH1
	SEp+aq3gdD7NkiEKYouh8BG5UnXarDpT4utC2HLpJixGyov/uxx7rzGCrDMRQ/U1
	DDtm8aB7GU2aox8+u8oHGzoL3i5iNDOzR79b2FdyH9DZTjq6Vx89afrYMNAyFYPL
	agVvWw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45d2u9v68n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 10:01:24 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52HA1Nmu029430
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 10:01:23 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 17 Mar 2025 03:01:19 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Praveenkumar I <quic_ipkumar@quicinc.com>,
        Varadarajan Narayanan
	<quic_varada@quicinc.com>
Subject: [PATCH v14 3/4] arm64: dts: qcom: ipq5332: Add PCIe related nodes
Date: Mon, 17 Mar 2025 15:30:28 +0530
Message-ID: <20250317100029.881286-4-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250317100029.881286-1-quic_varada@quicinc.com>
References: <20250317100029.881286-1-quic_varada@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=JsfxrN4C c=1 sm=1 tr=0 ts=67d7f2f4 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=aRNweXWdZvHjrTpnWWQA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 5bB45o5DTH5fd5VxsNuwZq_pO4Hchwzk
X-Proofpoint-ORIG-GUID: 5bB45o5DTH5fd5VxsNuwZq_pO4Hchwzk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_03,2025-03-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 mlxlogscore=999 impostorscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503170072

From: Praveenkumar I <quic_ipkumar@quicinc.com>

Add phy and controller nodes for pcie0_x1 and pcie1_x2.

Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v11: Drop Reviewed-by per feedback
     Use ipq9574 reg-names order and accordingly update the address in pcie@xxx
     Fix dbi reg size 0xf1d -> 0xf1c

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
index 69dda757925d..bd28c490415f 100644
--- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
@@ -252,6 +252,46 @@ tsens: thermal-sensor@4a9000 {
 			#thermal-sensor-cells = <1>;
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
@@ -278,8 +318,8 @@ gcc: clock-controller@1800000 {
 			#interconnect-cells = <1>;
 			clocks = <&xo_board>,
 				 <&sleep_clk>,
-				 <0>,
-				 <0>,
+				 <&pcie1_phy>,
+				 <&pcie0_phy>,
 				 <0>;
 		};
 
@@ -545,6 +585,214 @@ frame@b128000 {
 				status = "disabled";
 			};
 		};
+
+		pcie1: pcie@18000000 {
+			compatible = "qcom,pcie-ipq5332", "qcom,pcie-ipq9574";
+			reg = <0x18000000 0xf1c>,
+			      <0x18000f20 0xa8>,
+			      <0x18001000 0x1000>,
+			      <0x00088000 0x3000>,
+			      <0x18100000 0x1000>,
+			      <0x0008b000 0x1000>;
+			reg-names = "dbi",
+				    "elbi",
+				    "atu",
+				    "parf",
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
+		pcie0: pcie@20000000 {
+			compatible = "qcom,pcie-ipq5332", "qcom,pcie-ipq9574";
+			reg = <0x20000000 0xf1c>,
+			      <0x20000f20 0xa8>,
+			      <0x20001000 0x1000>,
+			      <0x00080000 0x3000>,
+			      <0x20100000 0x1000>,
+			      <0x00083000 0x1000>;
+			reg-names = "dbi",
+				    "elbi",
+				    "atu",
+				    "parf",
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
 	};
 
 	thermal-zones {
-- 
2.34.1


