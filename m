Return-Path: <linux-pci+bounces-34744-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32CDDB35A9C
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 13:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F7981B66CBD
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 11:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87C5319858;
	Tue, 26 Aug 2025 11:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C0vDLJwN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F131A23A6
	for <linux-pci@vger.kernel.org>; Tue, 26 Aug 2025 11:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756206196; cv=none; b=NMrxojFsxOSbvMuVTQyPn/KFQJMs7o+1fK5gyjKoOUpKlFIdmX6szM1Hk3kfFQVfOTh9H65eMibLVR03HuW4qSJG2V3+90rBQLbr8dlHt4w4aphJQpVJ3yzJbD7sTu9wimAWMss7LNyXPjQesJVIchOfzxCjHjlOxwWXmn1CLzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756206196; c=relaxed/simple;
	bh=uCwKakbnHqxRUEDYJHDENZK4dZF8AH52XyIcvvLd2js=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GY2uV4tsVkm7tVERNJL2u6jVc3oajOGuKvkCHcry6g9XI+QUOBhDBoJub3TyiwJKrubIGQGGXLmuvaFer9pIA/H0AN8XzV/AJDEbSxSE9iZW+b8iXg1JbfoknoDCpkYccgcCnVuiGQ5tQNN3efXunpVaBq/n3YMMTIY+2X3L0W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C0vDLJwN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q8Yc0n019757
	for <linux-pci@vger.kernel.org>; Tue, 26 Aug 2025 11:03:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IxIQhQomQAS30o8yPqwEl7kh8ZQDR41lcq928axCQDI=; b=C0vDLJwN/4T0rras
	OreYYqwPrknQKoR2LAWQJw8Hott8QWoE+DLoqvzxxH7YFqo3Wdibxbu3olk9I0Fh
	jsN2r7CPxLT9QMglrAtAk6lH8WsBtvkv7aBvdEqBz4HHmO9tNv5PLy2GydSWnZmo
	/VqoEPsIfrFlIV6XzJxu1K8d8Sh6JWtFbSfRLHPl+Qi/9ySAU3oiqIHe1laLjDLC
	OXVWy8AQg2duxEwS6y/mGJRzjwiHajID5kjy9UO5TBWP24mYmkLNJ+Dxc5wX7KB7
	45U8+monzwAMXJjR52oA70jkmDuK0WNsrhhCgS7pPsuhtY4yMWUqQP/YBltYqb9a
	Cf6YUg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5unre0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 26 Aug 2025 11:03:13 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2465bc6da05so48377895ad.0
        for <linux-pci@vger.kernel.org>; Tue, 26 Aug 2025 04:03:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756206191; x=1756810991;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IxIQhQomQAS30o8yPqwEl7kh8ZQDR41lcq928axCQDI=;
        b=nkRk7BqSR71Dbfd5RStksvo346DQR1ViaXzzLnZAFs0IMb2xHPWtl/9bWJcl6DkXR3
         eLp1OSGy9X5NEi750NNyxhQwwi1ySRG2GRT7+gbFNAMEM8+mxtHHB+KYXBADMIHPbHYw
         J84iShhdGJgOLMIC/xII1aPisyheuwdFVbecfMecksO5K9QWkziBJHc3OVmZvpBTv3Uy
         3TYfOb6uHoN1yTVxDwlilYmaE1eSIAYpnTiD25En2DTsGjmXllmcvnMwqt4x82Q5xt3L
         a87OlwFhJRyLNxS4paE14BDH7cQYYSaClAGQHtoyG0gs+IIHTt070ps4NLl/gAbf5Xyb
         ynOg==
X-Forwarded-Encrypted: i=1; AJvYcCVEoApY1E93k21rMshU+DrzYSvt7vn2qeblqoTfKCLEBD0eJx66iAQ5P/k/M8TrLjPg4KbcSnwbOVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUxqi/HZfFxsIZfNe5Seg62agLJIYK02JwsYfEPKhdWDa0b1Eu
	we7GO4z6mAUhKEnAw7tAEvnocbfI4GPnB55IXU5UdyrSX1H0KKcS4i7HPRAMLwtkrYqmQYkU/Gh
	L+ZDwalw1N0IaFy28BuckJyFVXpCSWSh+C2QrnLp3rewiKAuFsXu7SYR8WT0lAY4=
X-Gm-Gg: ASbGnctKJVm3mw9gdbSfljaMjueXW9KLWx0yQBBLZzzjC10dowla02coMPKdJtKRnuA
	io4zV493fuYEixYZU0scfZ7l79kQRQ/cSBpxoZ1L/zAVnwCEr40Df4K7PMu1Vwc+Wnw/1Mp8YOc
	ebqlXgkHO9p/Qdd6/g5n0BJFnrKLl5Wz1rkf8Q9Nfgon6Ig+Jqn/b5+xmYfPoi+7ZHbGurR17Vi
	Ndcisx8C6VHcmYsDUB8jwXLhXoK6VBM/ySQ3j89qeTXNWgSGrdeZ4ftaL7CdwdIJERdoZQfIYWN
	aBp5c9NMXbLnJn5jVnbWR1tCUHaK+YYxRWhX7Vjf7FKvfvti5i6QO7sqnRZgBNEf9d7qXWt9SyE
	=
X-Received: by 2002:a17:902:d590:b0:246:4eb3:9c08 with SMTP id d9443c01a7336-2464eb39dd3mr203060075ad.5.1756206191003;
        Tue, 26 Aug 2025 04:03:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1CF33K3fWdBghsmS2QyUSIaQzXtwbG3/eEzLG5/hoS5JLEsJ7o+CuX0kLqFRMxvZ8k/RUgA==
X-Received: by 2002:a17:902:d590:b0:246:4eb3:9c08 with SMTP id d9443c01a7336-2464eb39dd3mr203059295ad.5.1756206190440;
        Tue, 26 Aug 2025 04:03:10 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246688a5e5esm93207955ad.161.2025.08.26.04.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 04:03:10 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Tue, 26 Aug 2025 16:32:54 +0530
Subject: [PATCH v3 2/3] arm64: dts: qcom: sm8750: Add PCIe PHY and
 controller node
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250826-pakala-v3-2-721627bd5bb0@oss.qualcomm.com>
References: <20250826-pakala-v3-0-721627bd5bb0@oss.qualcomm.com>
In-Reply-To: <20250826-pakala-v3-0-721627bd5bb0@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_mrana@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756206175; l=5880;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=uCwKakbnHqxRUEDYJHDENZK4dZF8AH52XyIcvvLd2js=;
 b=7Lftqag6gsk/C0b3geRf3rBbSEpw4AicKs2GdUMMCVp8RN986hP2sjxRZf2O+zGtjezyCRnNX
 wUfGPR2bx+oAlqDU1zHMJRL48l3eJGbL+DgHl7KpcjUrGzhZWSQMx73
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: H-HeRzMg-ZI7Z2YSgv5rn38_ICa1mkeh
X-Proofpoint-ORIG-GUID: H-HeRzMg-ZI7Z2YSgv5rn38_ICa1mkeh
X-Authority-Analysis: v=2.4 cv=JJo7s9Kb c=1 sm=1 tr=0 ts=68ad9471 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=hNZP5i6h11z2s_4BSHIA:9
 a=3hQ7FE4IOERBLyhA:21 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMSBTYWx0ZWRfX9c58x/s+6cHM
 0mlQt71u6GTlCcfBTj8xqKOQDlu537/6c7dYWQXW8M4UVK0ahcaErTbdTX5APe0Z09VMvMl0wUT
 azDPMntR49ACRmZPWJC3fuLti0CfE7WP78HShYqD2Ejeohx4uIl+1KlTCzBPyF8bt+hYF44pfco
 f5X9WTCTy3txxFjHkw85kBrlRsDuM72EpRJ4RtqG9sOohNt2ndwHJJr1jPf15RUf0XH5iY7F/FN
 Cwav0UVqK53QebCv9nrNtSLBJc53C/edGXbm5jVVIQBgzWRAiLMnccbPMIYP5Y5Dg9Shomw3g2k
 M3cHCih+wn1wZG5P3Gb6arktx5oitR9aIgY4Cy9OdutV7XcPrGwve+vQSqv125SyY9UlAm3/w5J
 74a47Jtz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230031

Add PCIe controller and PHY nodes which supports data rates of 8GT/s
and x2 lane.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8750.dtsi | 180 ++++++++++++++++++++++++++++++++++-
 1 file changed, 179 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8750.dtsi b/arch/arm64/boot/dts/qcom/sm8750.dtsi
index 4643705021c6ca095a16d8d7cc3adac920b21e82..b47668a64bcead3e48f58eeb2e41c04660493cb7 100644
--- a/arch/arm64/boot/dts/qcom/sm8750.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8750.dtsi
@@ -631,7 +631,7 @@ gcc: clock-controller@100000 {
 			clocks = <&bi_tcxo_div2>,
 				 <0>,
 				 <&sleep_clk>,
-				 <0>,
+				 <&pcie0_phy>,
 				 <0>,
 				 <0>,
 				 <0>,
@@ -3304,6 +3304,184 @@ gic_its: msi-controller@16040000 {
 			};
 		};
 
+		pcie0: pcie@1c00000 {
+			device_type = "pci";
+			compatible = "qcom,pcie-sm8750", "qcom,pcie-sm8550";
+			reg = <0x0 0x01c00000 0x0 0x3000>,
+			      <0x0 0x40000000 0x0 0xf1d>,
+			      <0x0 0x40000f20 0x0 0xa8>,
+			      <0x0 0x40001000 0x0 0x1000>,
+			      <0x0 0x40100000 0x0 0x100000>,
+			      <0x0 0x01C03000 0x0 0x1000>;
+			reg-names = "parf",
+				    "dbi",
+				    "elbi",
+				    "atu",
+				    "config",
+				    "mhi";
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges = <0x01000000 0x0 0x00000000 0x0 0x40200000 0x0 0x100000>,
+				 <0x02000000 0x0 0x40300000 0x0 0x40300000 0x0 0x23d00000>,
+				 <0x03000000 0x4 0x00000000 0x4 0x00000000 0x3 0x00000000>;
+			bus-range = <0x00 0xff>;
+
+			dma-coherent;
+
+			linux,pci-domain = <0>;
+
+			msi-map = <0x0 &gic_its 0x1400 0x1>,
+				  <0x100 &gic_its 0x1401 0x1>;
+			msi-map-mask = <0xff00>;
+
+			num-lanes = <2>;
+
+			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
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
+			interrupt-map = <0 0 0 1 &intc 0 0 0 149 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 2 &intc 0 0 0 150 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 3 &intc 0 0 0 151 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 4 &intc 0 0 0 152 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_PCIE_0_AUX_CLK>,
+				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
+				 <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
+				 <&gcc GCC_PCIE_0_SLV_AXI_CLK>,
+				 <&gcc GCC_PCIE_0_SLV_Q2A_AXI_CLK>,
+				 <&gcc GCC_DDRSS_PCIE_SF_QTB_CLK>,
+				 <&gcc GCC_AGGRE_NOC_PCIE_AXI_CLK>,
+				 <&gcc GCC_CNOC_PCIE_SF_AXI_CLK>;
+			clock-names = "aux",
+				      "cfg",
+				      "bus_master",
+				      "bus_slave",
+				      "slave_q2a",
+				      "ddrss_sf_tbu",
+				      "noc_aggr",
+				      "cnoc_sf_axi";
+
+			interconnects = <&pcie_noc MASTER_PCIE_0 QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
+					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
+					 &cnoc_main SLAVE_PCIE_0 QCOM_ICC_TAG_ALWAYS>;
+			interconnect-names = "pcie-mem",
+					     "cpu-pcie";
+
+			iommu-map = <0x0   &apps_smmu 0x1400 0x1>,
+				    <0x100 &apps_smmu 0x1401 0x1>;
+
+			resets = <&gcc GCC_PCIE_0_BCR>;
+			reset-names = "pci";
+
+			power-domains = <&gcc GCC_PCIE_0_GDSC>;
+
+			operating-points-v2 = <&pcie0_opp_table>;
+
+			status = "disabled";
+
+			pcie0_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				/* GEN 1 x1 */
+				opp-2500000 {
+					opp-hz = /bits/ 64 <2500000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+					opp-peak-kBps = <250000 1>;
+				};
+
+				/* GEN 1 x2 and GEN 2 x1 */
+				opp-5000000 {
+					opp-hz = /bits/ 64 <5000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+					opp-peak-kBps = <500000 1>;
+				};
+
+				/* GEN 2 x2 */
+				opp-10000000 {
+					opp-hz = /bits/ 64 <10000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+					opp-peak-kBps = <1000000 1>;
+				};
+
+				/* GEN 3 x1 */
+				opp-8000000 {
+					opp-hz = /bits/ 64 <8000000>;
+					required-opps = <&rpmhpd_opp_nom>;
+					opp-peak-kBps = <984500 1>;
+				};
+
+				/* GEN 3 x2 */
+				opp-16000000 {
+					opp-hz = /bits/ 64 <16000000>;
+					required-opps = <&rpmhpd_opp_nom>;
+					opp-peak-kBps = <1969000 1>;
+				};
+
+			};
+
+			pcieport0: pcie@0 {
+				device_type = "pci";
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+				bus-range = <0x01 0xff>;
+
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+				phys = <&pcie0_phy>;
+			};
+		};
+
+		pcie0_phy: phy@1c06000 {
+			compatible = "qcom,sm8750-qmp-gen3x2-pcie-phy";
+			reg = <0 0x01c06000 0 0x2000>;
+
+			clocks = <&gcc GCC_PCIE_0_AUX_CLK>,
+				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
+				 <&tcsrcc TCSR_PCIE_0_CLKREF_EN>,
+				 <&gcc GCC_PCIE_0_PHY_RCHNG_CLK>,
+				 <&gcc GCC_PCIE_0_PIPE_CLK>;
+			clock-names = "aux",
+				      "cfg_ahb",
+				      "ref",
+				      "rchng",
+				      "pipe";
+
+			assigned-clocks = <&gcc GCC_PCIE_0_PHY_RCHNG_CLK>;
+			assigned-clock-rates = <100000000>;
+
+			resets = <&gcc GCC_PCIE_0_PHY_BCR>;
+			reset-names = "phy";
+
+			power-domains = <&gcc GCC_PCIE_0_PHY_GDSC>;
+
+			#clock-cells = <0>;
+			clock-output-names = "pcie0_pipe_clk";
+
+			#phy-cells = <0>;
+
+			status = "disabled";
+		};
+
 		ufs_mem_phy: phy@1d80000 {
 			compatible = "qcom,sm8750-qmp-ufs-phy";
 			reg = <0x0 0x01d80000 0x0 0x2000>;

-- 
2.34.1


