Return-Path: <linux-pci+bounces-12498-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0AF9659C4
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 10:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75BCEB22C19
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 08:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5363E170A31;
	Fri, 30 Aug 2024 08:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EiJLWKyQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E4116726E;
	Fri, 30 Aug 2024 08:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725005561; cv=none; b=mzx7+E+WjaD37Mb09/U+jS6jBafY1UKYggDqXnrxNp2W9DT9Et36VmY+HPXB1CmFI3K/agacDrCcPGRCgS3Bm8V2f9H4m495zbNWPXNGmYif7JQF3YKTpfEnY97n206c+8ONoQde2D4tP7vgN/RtjlkG+72ZKq47wtpUO4RyWk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725005561; c=relaxed/simple;
	bh=3OEqrF+KKb85NkRQMqEk9mXqKxQ8RCwfOQ9wLKZDlsc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GnAjzpJxhL6H2V9G1oiasihiy2hjut6uMV5ywBWL3QK1nmpQMFdCYhFJJvRo8MKvQiAwsvOL0GXedgPmkdy499yIOkxwZ03L2rT0iHQ39uZzOBacPHFg+eEVoHSfM7WLR7QjAuroJwLXoLI6uk3pPjUINVVpp1PYlIgz6Lo4QSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EiJLWKyQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47TIDShT002723;
	Fri, 30 Aug 2024 08:12:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BxTJOckSy8MBX3mNLc9nmcxTFS29BNnOSCdb0krWG1w=; b=EiJLWKyQWC3pt7w0
	iILpojxD+O/r4g1H5pJWfLRfj5ys5+lUa/nD0tLpoS+MQuUWTJoUC1Mdqf1ER9qw
	TzfSGxttlB0c/FNfCmgvvn8pdcJ/pnuqZgl9b9nrsdVwTtw0jY0xyu0tAvZgMN25
	wc28jlKqurMWJEGdX+5sUfjwKc9iXLfDCzykF3sAJrWdxlC9rGYqXopiR3zNu8jz
	nWhuTzrAZ4b6fivstkNZz5bqDnz+u59j1V5Yy5uqflXtbAjneEoEDwvwXP9mLMWa
	/tIXKIpMPE2JM+zEJbnCIR/Vxa69KpGea3rvq0Ab2mRpF49F6WNqVMpiv9/Mvbd1
	ilfpdQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 419putyyw9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 08:12:24 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47U8CNWm002385
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 08:12:23 GMT
Received: from hu-srichara-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 30 Aug 2024 01:12:17 -0700
From: Sricharan R <quic_srichara@quicinc.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <andersson@kernel.org>, <konradybcio@kernel.org>,
        <p.zabel@pengutronix.de>, <dmitry.baryshkov@linaro.org>,
        <quic_nsekar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <robimarko@gmail.com>, <quic_srichara@quicinc.com>
Subject: [PATCH V3 5/6] arm64: dts: qcom: ipq5018: Add PCIe related nodes
Date: Fri, 30 Aug 2024 13:41:31 +0530
Message-ID: <20240830081132.4016860-6-quic_srichara@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240830081132.4016860-1-quic_srichara@quicinc.com>
References: <20240830081132.4016860-1-quic_srichara@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: S3Mi8iN2CCi01Pr0m5j4YBaPxCET-Q6N
X-Proofpoint-GUID: S3Mi8iN2CCi01Pr0m5j4YBaPxCET-Q6N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_04,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0
 clxscore=1015 mlxscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408300060

From: Nitheesh Sekar <quic_nsekar@quicinc.com>

Add phy and controller nodes for a 2-lane Gen2 and
1-lane Gen2 PCIe buses.

Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
Signed-off-by: Sricharan R <quic_srichara@quicinc.com>
---
 [V3] No change

 arch/arm64/boot/dts/qcom/ipq5018.dtsi | 168 +++++++++++++++++++++++++-
 1 file changed, 166 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
index 7e6e2c121979..dd5d6b7ff094 100644
--- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
@@ -9,6 +9,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/qcom,gcc-ipq5018.h>
 #include <dt-bindings/reset/qcom,gcc-ipq5018.h>
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	interrupt-parent = <&intc>;
@@ -143,7 +144,33 @@ usbphy0: phy@5b000 {
 			resets = <&gcc GCC_QUSB2_0_PHY_BCR>;
 
 			#phy-cells = <0>;
+		};
+
+		pcie_x1phy: phy@7e000{
+			compatible = "qcom,ipq5018-uniphy-pcie-gen2x1";
+			reg = <0x0007e000 0x800>;
+			#phy-cells = <0>;
+			#clock-cells = <0>;
+			clocks = <&gcc GCC_PCIE1_PIPE_CLK>;
+			clock-names = "pipe";
+			assigned-clocks = <&gcc GCC_PCIE1_PIPE_CLK>;
+			resets = <&gcc GCC_PCIE1_PHY_BCR>,
+				 <&gcc GCC_PCIE1PHY_PHY_BCR>;
+			reset-names = "phy", "common";
+			status = "disabled";
+		};
 
+		pcie_x2phy: phy@86000{
+			compatible = "qcom,ipq5018-uniphy-pcie-gen2x2";
+			reg = <0x00086000 0x1000>;
+			#phy-cells = <0>;
+			#clock-cells = <0>;
+			clocks = <&gcc GCC_PCIE0_PIPE_CLK>;
+			clock-names = "pipe";
+			assigned-clocks = <&gcc GCC_PCIE0_PIPE_CLK>;
+			resets = <&gcc GCC_PCIE0_PHY_BCR>,
+				 <&gcc GCC_PCIE0PHY_PHY_BCR>;
+			reset-names = "phy", "common";
 			status = "disabled";
 		};
 
@@ -170,8 +197,8 @@ gcc: clock-controller@1800000 {
 			reg = <0x01800000 0x80000>;
 			clocks = <&xo_board_clk>,
 				 <&sleep_clk>,
-				 <0>,
-				 <0>,
+				 <&pcie_x2phy>,
+				 <&pcie_x1phy>,
 				 <0>,
 				 <0>,
 				 <0>,
@@ -387,6 +414,143 @@ frame@b128000 {
 				status = "disabled";
 			};
 		};
+
+		pcie0: pci@80000000 {
+			compatible = "qcom,pcie-ipq5018";
+			reg =  <0x80000000 0xf1d>,
+			       <0x80000f20 0xa8>,
+			       <0x80001000 0x1000>,
+			       <0x00078000 0x3000>,
+			       <0x80100000 0x1000>;
+			reg-names = "dbi", "elbi", "atu", "parf", "config";
+			device_type = "pci";
+			linux,pci-domain = <0>;
+			bus-range = <0x00 0xff>;
+			num-lanes = <1>;
+			max-link-speed = <2>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			phys = <&pcie_x1phy>;
+			phy-names ="pciephy";
+
+			ranges = <0x01000000 0 0x80200000 0x80200000 0 0x00100000
+				  0x02000000 0 0x80300000 0x80300000 0 0x10000000>;
+
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &intc 0 0 142 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 2 &intc 0 0 143 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 3 &intc 0 0 144 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 4 &intc 0 0 145 IRQ_TYPE_LEVEL_HIGH>;
+
+			interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "global_irq";
+
+			clocks = <&gcc GCC_SYS_NOC_PCIE1_AXI_CLK>,
+				 <&gcc GCC_PCIE1_AXI_M_CLK>,
+				 <&gcc GCC_PCIE1_AXI_S_CLK>,
+				 <&gcc GCC_PCIE1_AHB_CLK>,
+				 <&gcc GCC_PCIE1_AUX_CLK>,
+				 <&gcc GCC_PCIE1_AXI_S_BRIDGE_CLK>;
+
+			clock-names = "iface",
+				      "axi_m",
+				      "axi_s",
+				      "ahb",
+				      "aux",
+				      "axi_bridge";
+
+			resets = <&gcc GCC_PCIE1_PIPE_ARES>,
+				 <&gcc GCC_PCIE1_SLEEP_ARES>,
+				 <&gcc GCC_PCIE1_CORE_STICKY_ARES>,
+				 <&gcc GCC_PCIE1_AXI_MASTER_ARES>,
+				 <&gcc GCC_PCIE1_AXI_SLAVE_ARES>,
+				 <&gcc GCC_PCIE1_AHB_ARES>,
+				 <&gcc GCC_PCIE1_AXI_MASTER_STICKY_ARES>,
+				 <&gcc GCC_PCIE1_AXI_SLAVE_STICKY_ARES>;
+
+			reset-names = "pipe",
+				      "sleep",
+				      "sticky",
+				      "axi_m",
+				      "axi_s",
+				      "ahb",
+				      "axi_m_sticky",
+				      "axi_s_sticky";
+
+			msi-map = <0x0 &v2m0 0x0 0xff8>;
+			status = "disabled";
+		};
+
+		pcie1: pci@a0000000 {
+			compatible = "qcom,pcie-ipq5018";
+			reg =  <0xa0000000 0xf1d>,
+			       <0xa0000f20 0xa8>,
+			       <0xa0001000 0x1000>,
+			       <0x00080000 0x3000>,
+			       <0xa0100000 0x1000>;
+			reg-names = "dbi", "elbi", "atu", "parf", "config";
+			device_type = "pci";
+			linux,pci-domain = <1>;
+			bus-range = <0x00 0xff>;
+			num-lanes = <2>;
+			max-link-speed = <2>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			phys = <&pcie_x2phy>;
+			phy-names ="pciephy";
+
+			ranges = <0x01000000 0 0xa0200000 0xa0200000 0 0x00100000
+				  0x02000000 0 0xa0300000 0xa0300000 0 0x10000000>;
+
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &intc 0 0 75 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 2 &intc 0 0 78 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 3 &intc 0 0 79 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 4 &intc 0 0 83 IRQ_TYPE_LEVEL_HIGH>;
+
+			interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "global_irq";
+
+			clocks = <&gcc GCC_SYS_NOC_PCIE0_AXI_CLK>,
+				 <&gcc GCC_PCIE0_AXI_M_CLK>,
+				 <&gcc GCC_PCIE0_AXI_S_CLK>,
+				 <&gcc GCC_PCIE0_AHB_CLK>,
+				 <&gcc GCC_PCIE0_AUX_CLK>,
+				 <&gcc GCC_PCIE0_AXI_S_BRIDGE_CLK>;
+
+			clock-names = "iface",
+				      "axi_m",
+				      "axi_s",
+				      "ahb",
+				      "aux",
+				      "axi_bridge";
+
+			resets = <&gcc GCC_PCIE0_PIPE_ARES>,
+				 <&gcc GCC_PCIE0_SLEEP_ARES>,
+				 <&gcc GCC_PCIE0_CORE_STICKY_ARES>,
+				 <&gcc GCC_PCIE0_AXI_MASTER_ARES>,
+				 <&gcc GCC_PCIE0_AXI_SLAVE_ARES>,
+				 <&gcc GCC_PCIE0_AHB_ARES>,
+				 <&gcc GCC_PCIE0_AXI_MASTER_STICKY_ARES>,
+				 <&gcc GCC_PCIE0_AXI_SLAVE_STICKY_ARES>;
+
+			reset-names = "pipe",
+				      "sleep",
+				      "sticky",
+				      "axi_m",
+				      "axi_s",
+				      "ahb",
+				      "axi_m_sticky",
+				      "axi_s_sticky";
+
+			msi-map = <0x0 &v2m0 0x0 0xff8>;
+			status = "disabled";
+		};
+
 	};
 
 	timer {
-- 
2.34.1


