Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFFB7CF713
	for <lists+linux-pci@lfdr.de>; Thu, 19 Oct 2023 13:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345434AbjJSLhj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Oct 2023 07:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233155AbjJSLhg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Oct 2023 07:37:36 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3AA813E;
        Thu, 19 Oct 2023 04:37:33 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39JAjt9V014928;
        Thu, 19 Oct 2023 11:37:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=9WSebA+wxvflAFy7chHmr6lERim/LgmFmXjnP3ZZp3Y=;
 b=nUHPVvJM0PRhy0wT5jXpmAGls5hRVOIrUWGzkjRz/TWWS260jOAz8wsDsRtMC4ot6HbF
 jaFAZEVeuIKtosOT2OVwS9AfSBdhQceWCsnwRBuZesuvh9x/HhZTc08+LtjZSzBsj/03
 MCj0Bx0EAmQq5qgMSYtqCvKm5vW487hlNEgpy3nOrWCIa9T5LUjTMMRQu6NvuDU3qa9Y
 Dw8SfQnHUdXHzyMhKoqu722Ldyv8NHOrE2VGIJvm3PTvJa2ouHoREkh462lG3clDCSQ5
 jUPe5JlhOhmwaxIiJvDCkOOEUgGR/8PjNBJ/jMSavEZd2qGZ0bMun+O5qKlD02U20qgB aw== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ttfeuapbg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 11:37:24 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 39JBbGNh000827;
        Thu, 19 Oct 2023 11:37:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3tqm2mcs3w-1;
        Thu, 19 Oct 2023 11:37:21 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39JBbKjJ000894;
        Thu, 19 Oct 2023 11:37:20 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-msarkar-hyd.qualcomm.com [10.213.111.194])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 39JBbKt5000885;
        Thu, 19 Oct 2023 11:37:20 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3891782)
        id 09C76441C; Thu, 19 Oct 2023 17:07:20 +0530 (+0530)
From:   Mrinmay Sarkar <quic_msarkar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        konrad.dybcio@linaro.org, mani@kernel.org
Cc:     quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        dmitry.baryshkov@linaro.org, robh@kernel.org,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        quic_parass@quicinc.com, Mrinmay Sarkar <quic_msarkar@quicinc.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
        linux-phy@lists.infradead.org
Subject: [PATCH v3 5/5] arm64: dts: qcom: sa8775p: Add ep pcie0 controller node
Date:   Thu, 19 Oct 2023 17:07:10 +0530
Message-Id: <1697715430-30820-6-git-send-email-quic_msarkar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1697715430-30820-1-git-send-email-quic_msarkar@quicinc.com>
References: <1697715430-30820-1-git-send-email-quic_msarkar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: houZrgXEPQbdaH4WRiran116wJpoCU8E
X-Proofpoint-GUID: houZrgXEPQbdaH4WRiran116wJpoCU8E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_09,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 spamscore=0 impostorscore=0 bulkscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310190099
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add ep pcie dtsi node for pcie0 controller found on sa8775p platform.
It supports gen4 and x2 link width. Due to some stability issue in
gen4 enabling gen3 as of now.

Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 48 +++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index 13dd44d..2aa7383 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -3714,4 +3714,52 @@
 
 		status = "disabled";
 	};
+
+	pcie0_ep: pcie-ep@1c00000 {
+		compatible = "qcom,sa8775p-pcie-ep";
+		reg = <0x0 0x01c00000 0x0 0x3000>,
+		      <0x0 0x40000000 0x0 0xf20>,
+		      <0x0 0x40000f20 0x0 0xa8>,
+		      <0x0 0x40001000 0x0 0x4000>,
+		      <0x0 0x40200000 0x0 0x100000>,
+		      <0x0 0x01c03000 0x0 0x1000>,
+		      <0x0 0x40005000 0x0 0x2000>;
+		reg-names = "parf", "dbi", "elbi", "atu", "addr_space",
+			    "mmio", "dma";
+
+		clocks = <&gcc GCC_PCIE_0_AUX_CLK>,
+			<&gcc GCC_PCIE_0_CFG_AHB_CLK>,
+			<&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
+			<&gcc GCC_PCIE_0_SLV_AXI_CLK>,
+			<&gcc GCC_PCIE_0_SLV_Q2A_AXI_CLK>;
+
+		clock-names = "aux",
+			      "cfg",
+			      "bus_master",
+			      "bus_slave",
+			      "slave_q2a";
+
+		interrupts = <GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 630 IRQ_TYPE_LEVEL_HIGH>;
+
+		interrupt-names = "global", "doorbell", "dma";
+
+		interconnects = <&pcie_anoc MASTER_PCIE_0 0 &mc_virt SLAVE_EBI1 0>,
+				<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_PCIE_0 0>;
+		interconnect-names = "pcie-mem", "cpu-pcie";
+
+		iommu-map = <0x0 &pcie_smmu 0x0000 0x1>,
+			    <0x100 &pcie_smmu 0x0001 0x1>;
+
+		resets = <&gcc GCC_PCIE_0_BCR>;
+		reset-names = "core";
+		power-domains = <&gcc PCIE_0_GDSC>;
+		phys = <&pcie0_phy>;
+		phy-names = "pciephy";
+		max-link-speed = <3>;
+		num-lanes = <2>;
+
+		status = "disabled";
+	};
 };
-- 
2.7.4

