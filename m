Return-Path: <linux-pci+bounces-9616-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CA0924E16
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 05:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDCB1B272FA
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 03:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C7EBE65;
	Wed,  3 Jul 2024 03:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Vt2muhpo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468DC5228;
	Wed,  3 Jul 2024 03:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719975668; cv=none; b=PnO4M/uH0THYiCAE6mZWMeYEjMqGpe8QdbpFi6jdQIaiQ+EkjDL6Q5dIP6v957aupuq1MDHgXfmWcccDZmeFQexyVh2tq2qVh6IDFOd2YpW2VF5lcme37tHYaHragNXiffOPK+OVnNKr1C0nRGdRmMvol4cbo+FRUESX1OvWhkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719975668; c=relaxed/simple;
	bh=4JVBcuJhyhce3LWOP9sFABTTKWXp3nVevz4PSML4GOM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XRQJJE4de8XNoEjSbHjuE0r6WtPTZFXQk2oXyHASlyz969oef3kagFBvsuN3f27+ktWhL4D4QxK7oPb/qSNwkgxOiv31mba8XNnf9bIKcDdVkT/Lx0WRyUnm9E7gfQqZsVlOf79p96jEL0pnYCfGlJeYBC1WxjaKOY2DBkQbwKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Vt2muhpo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 462HA2Yn030501;
	Wed, 3 Jul 2024 03:00:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kZVxsCU22bRw6LnhoMywcvJcevbJPBGciG7zvdQOJuc=; b=Vt2muhpoafzgVDpp
	c9lMPLgNoJhD75x/0Ul8umGI8RDJfsrs9wZgx14+QOS4hF2iblytmaw71hu3Nfch
	kILpS4T3ljBYqOVFIA7pw4Re1E4yCFt1eeGGtDodN1IKNAfFp58bWezM1f69YBxW
	W5w5UTzJmm9JiiYcz+ZGh2tZNEgZxFVAXk7g6tfrEwN4IsA7PKvLoN+TYr/oLURt
	bAiaCEjxctSD4O8yvnh4rJrNiZSVq8cYqIc5mGjPDouqgUApPfP9RhDMKFrxiVSA
	LqQ/g6Tgy72EHPsi308mBMagXnDb1UzIxJxkbnV9ImVgfntZfJYi0DMCvUCPsNVp
	xUlFzQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4029uxfg07-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jul 2024 03:00:15 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46330DXJ016792
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Jul 2024 03:00:13 GMT
Received: from tengfan-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 2 Jul 2024 19:59:50 -0700
From: Tengfei Fan <quic_tengfan@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <djakov@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <jassisinghbrar@gmail.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <manivannan.sadhasivam@linaro.org>,
        <will@kernel.org>, <joro@8bytes.org>, <conor@kernel.org>,
        <tglx@linutronix.de>, <amitk@kernel.org>, <thara.gopinath@gmail.com>,
        <linus.walleij@linaro.org>, <wim@linux-watchdog.org>,
        <linux@roeck-us.net>, <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <vkoul@kernel.org>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <mcoquelin.stm32@gmail.com>
CC: <robimarko@gmail.com>, <quic_gurus@quicinc.com>,
        <bartosz.golaszewski@linaro.org>, <kishon@kernel.org>,
        <quic_wcheng@quicinc.com>, <alim.akhtar@samsung.com>,
        <avri.altman@wdc.com>, <bvanassche@acm.org>, <agross@kernel.org>,
        <gregkh@linuxfoundation.org>, <quic_tdas@quicinc.com>,
        <robin.murphy@arm.com>, <daniel.lezcano@linaro.org>,
        <rui.zhang@intel.com>, <lukasz.luba@arm.com>,
        <quic_rjendra@quicinc.com>, <ulf.hansson@linaro.org>,
        <quic_sibis@quicinc.com>, <otto.pflueger@abscue.de>,
        <quic_rohiagar@quicinc.com>, <luca@z3ntu.xyz>,
        <neil.armstrong@linaro.org>, <abel.vesa@linaro.org>,
        <bhupesh.sharma@linaro.org>, <alexandre.torgue@foss.st.com>,
        <peppe.cavallaro@st.com>, <joabreu@synopsys.com>,
        <netdev@vger.kernel.org>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>, <ahalaney@redhat.com>,
        <krzysztof.kozlowski@linaro.org>, <u.kleine-koenig@pengutronix.de>,
        <dmitry.baryshkov@linaro.org>, <quic_cang@quicinc.com>,
        <danila@jiaxyga.com>, <quic_nitirawa@quicinc.com>,
        <mantas@8devices.com>, <athierry@redhat.com>,
        <quic_kbajaj@quicinc.com>, <quic_bjorande@quicinc.com>,
        <quic_msarkar@quicinc.com>, <quic_devipriy@quicinc.com>,
        <quic_tsoni@quicinc.com>, <quic_rgottimu@quicinc.com>,
        <quic_shashim@quicinc.com>, <quic_kaushalk@quicinc.com>,
        <quic_tingweiz@quicinc.com>, <quic_aiquny@quicinc.com>,
        <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-crypto@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-riscv@lists.infradead.org>, <linux-gpio@vger.kernel.org>,
        <linux-watchdog@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>, <kernel@quicinc.com>,
        Tengfei Fan <quic_tengfan@quicinc.com>
Subject: [PATCH 02/47] arm64: dts: qcom: qcs9100: Introduce QCS9100 SoC dtsi
Date: Wed, 3 Jul 2024 10:58:05 +0800
Message-ID: <20240703025850.2172008-3-quic_tengfan@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240703025850.2172008-1-quic_tengfan@quicinc.com>
References: <20240703025850.2172008-1-quic_tengfan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8pfBHCKK8j0m2rGHcShDIKolxk-vgJZV
X-Proofpoint-ORIG-GUID: 8pfBHCKK8j0m2rGHcShDIKolxk-vgJZV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-02_18,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 mlxscore=0
 clxscore=1015 phishscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407030021

Introduce QCS9100 SoC dtsi, QCS9100 is mainly used in IoT products.
QCS9100 is drived from SA8775p.
The current QCS9100 SoC dtsi is directly renamed from the SA8775p SoC
dtsi.
The QCS9100 platform is currently in the early design stage. Currently,
Both the QCS9100 platform and SA8775p platform use non-SCMI resources,
In the future, the SA8775p platform will transition to using SCMI
resources and it will have new sa8775p-related device tree.
This QCS9100 SoC dtsi remains consistent with the current SA8775p SoC
dtsi, except for updating the following sa8775p-related compatible names
to the qcs9100-related compatible name:
  - qcom,sa8775p-clk-virt
  - qcom,sa8775p-mc-virt
  - qcom,sa8775p-adsp-pas
  - qcom,sa8775p-cdsp-pas
  - qcom,sa8775p-cdsp1-pas
  - qcom,sa8775p-gpdsp0-pas
  - qcom,sa8775p-gpdsp1-pas
  - qcom,sa8775p-gcc
  - qcom,sa8775p-ipcc
  - qcom,sa8775p-config-noc
  - qcom,sa8775p-system-noc
  - qcom,sa8775p-aggre1-noc
  - qcom,sa8775p-aggre2-noc
  - qcom,sa8775p-pcie-anoc
  - qcom,sa8775p-gpdsp-anoc
  - qcom,sa8775p-mmss-noc
  - qcom,sa8775p-trng
  - qcom,sa8775p-ufshc
  - qcom,sa8775p-qmp-ufs-phy
  - qcom,sa8775p-qce
  - qcom,sa8775p-lpass-ag-noc
  - qcom,sa8775p-usb-hs-phy
  - qcom,sa8775p-dc-noc
  - qcom,sa8775p-gem-noc
  - qcom,sa8775p-dwc3
  - qcom,sa8775p-qmp-usb3-uni-phy
  - qcom,sa8775p-gpucc
  - qcom,sa8775p-smmu-500
  - qcom,sa8775p-dwmac-sgmii-phy
  - qcom,sa8775p-llcc-bwmon
  - qcom,sa8775p-cpu-bwmon
  - qcom,sa8775p-llcc
  - qcom,sa8775p-videocc
  - qcom,sa8775p-camcc
  - qcom,sa8775p-dispcc0
  - qcom,sa8775p-pdc
  - qcom,sa8775p-aoss-qmp
  - qcom,sa8775p-tlmm
  - qcom,sa8775p-imem
  - qcom,sa8775p-smmu-500
  - qcom,sa8775p-rpmh-clk
  - qcom,sa8775p-rpmhpd
  - qcom,sa8775p-cpufreq-epss
  - qcom,sa8775p-dispcc1
  - qcom,sa8775p-ethqos
  - qcom,sa8775p-nspa-noc
  - qcom,sa8775p-nspb-noc
  - qcom,sa8775p-qmp-gen4x2-pcie-phy
  - qcom,sa8775p-qmp-gen4x4-pcie-phy

Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
---
 .../dts/qcom/{sa8775p.dtsi => qcs9100.dtsi}   | 112 +++++++++---------
 1 file changed, 56 insertions(+), 56 deletions(-)
 rename arch/arm64/boot/dts/qcom/{sa8775p.dtsi => qcs9100.dtsi} (97%)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/qcs9100.dtsi
similarity index 97%
rename from arch/arm64/boot/dts/qcom/sa8775p.dtsi
rename to arch/arm64/boot/dts/qcom/qcs9100.dtsi
index 23f1b2e5e624..1c257287af0c 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs9100.dtsi
@@ -220,91 +220,91 @@ eud_in: endpoint {
 
 	firmware {
 		scm {
-			compatible = "qcom,scm-sa8775p", "qcom,scm";
+			compatible = "qcom,scm-qcs9100", "qcom,scm";
 			memory-region = <&tz_ffi_mem>;
 		};
 	};
 
 	aggre1_noc: interconnect-aggre1-noc {
-		compatible = "qcom,sa8775p-aggre1-noc";
+		compatible = "qcom,qcs9100-aggre1-noc";
 		#interconnect-cells = <2>;
 		qcom,bcm-voters = <&apps_bcm_voter>;
 	};
 
 	aggre2_noc: interconnect-aggre2-noc {
-		compatible = "qcom,sa8775p-aggre2-noc";
+		compatible = "qcom,qcs9100-aggre2-noc";
 		#interconnect-cells = <2>;
 		qcom,bcm-voters = <&apps_bcm_voter>;
 	};
 
 	clk_virt: interconnect-clk-virt {
-		compatible = "qcom,sa8775p-clk-virt";
+		compatible = "qcom,qcs9100-clk-virt";
 		#interconnect-cells = <2>;
 		qcom,bcm-voters = <&apps_bcm_voter>;
 	};
 
 	config_noc: interconnect-config-noc {
-		compatible = "qcom,sa8775p-config-noc";
+		compatible = "qcom,qcs9100-config-noc";
 		#interconnect-cells = <2>;
 		qcom,bcm-voters = <&apps_bcm_voter>;
 	};
 
 	dc_noc: interconnect-dc-noc {
-		compatible = "qcom,sa8775p-dc-noc";
+		compatible = "qcom,qcs9100-dc-noc";
 		#interconnect-cells = <2>;
 		qcom,bcm-voters = <&apps_bcm_voter>;
 	};
 
 	gem_noc: interconnect-gem-noc {
-		compatible = "qcom,sa8775p-gem-noc";
+		compatible = "qcom,qcs9100-gem-noc";
 		#interconnect-cells = <2>;
 		qcom,bcm-voters = <&apps_bcm_voter>;
 	};
 
 	gpdsp_anoc: interconnect-gpdsp-anoc {
-		compatible = "qcom,sa8775p-gpdsp-anoc";
+		compatible = "qcom,qcs9100-gpdsp-anoc";
 		#interconnect-cells = <2>;
 		qcom,bcm-voters = <&apps_bcm_voter>;
 	};
 
 	lpass_ag_noc: interconnect-lpass-ag-noc {
-		compatible = "qcom,sa8775p-lpass-ag-noc";
+		compatible = "qcom,qcs9100-lpass-ag-noc";
 		#interconnect-cells = <2>;
 		qcom,bcm-voters = <&apps_bcm_voter>;
 	};
 
 	mc_virt: interconnect-mc-virt {
-		compatible = "qcom,sa8775p-mc-virt";
+		compatible = "qcom,qcs9100-mc-virt";
 		#interconnect-cells = <2>;
 		qcom,bcm-voters = <&apps_bcm_voter>;
 	};
 
 	mmss_noc: interconnect-mmss-noc {
-		compatible = "qcom,sa8775p-mmss-noc";
+		compatible = "qcom,qcs9100-mmss-noc";
 		#interconnect-cells = <2>;
 		qcom,bcm-voters = <&apps_bcm_voter>;
 	};
 
 	nspa_noc: interconnect-nspa-noc {
-		compatible = "qcom,sa8775p-nspa-noc";
+		compatible = "qcom,qcs9100-nspa-noc";
 		#interconnect-cells = <2>;
 		qcom,bcm-voters = <&apps_bcm_voter>;
 	};
 
 	nspb_noc: interconnect-nspb-noc {
-		compatible = "qcom,sa8775p-nspb-noc";
+		compatible = "qcom,qcs9100-nspb-noc";
 		#interconnect-cells = <2>;
 		qcom,bcm-voters = <&apps_bcm_voter>;
 	};
 
 	pcie_anoc: interconnect-pcie-anoc {
-		compatible = "qcom,sa8775p-pcie-anoc";
+		compatible = "qcom,qcs9100-pcie-anoc";
 		#interconnect-cells = <2>;
 		qcom,bcm-voters = <&apps_bcm_voter>;
 	};
 
 	system_noc: interconnect-system-noc {
-		compatible = "qcom,sa8775p-system-noc";
+		compatible = "qcom,qcs9100-system-noc";
 		#interconnect-cells = <2>;
 		qcom,bcm-voters = <&apps_bcm_voter>;
 	};
@@ -571,7 +571,7 @@ soc: soc@0 {
 		ranges = <0 0 0 0 0x10 0>;
 
 		gcc: clock-controller@100000 {
-			compatible = "qcom,sa8775p-gcc";
+			compatible = "qcom,qcs9100-gcc";
 			reg = <0x0 0x00100000 0x0 0xc7018>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
@@ -595,7 +595,7 @@ gcc: clock-controller@100000 {
 		};
 
 		ipcc: mailbox@408000 {
-			compatible = "qcom,sa8775p-ipcc", "qcom,ipcc";
+			compatible = "qcom,qcs9100-ipcc", "qcom,ipcc";
 			reg = <0x0 0x00408000 0x0 0x1000>;
 			interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-controller;
@@ -1593,12 +1593,12 @@ &config_noc SLAVE_QUP_3 QCOM_ICC_TAG_ALWAYS>,
 		};
 
 		rng: rng@10d2000 {
-			compatible = "qcom,sa8775p-trng", "qcom,trng";
+			compatible = "qcom,qcs9100-trng", "qcom,trng";
 			reg = <0 0x010d2000 0 0x1000>;
 		};
 
 		ufs_mem_hc: ufs@1d84000 {
-			compatible = "qcom,sa8775p-ufshc", "qcom,ufshc", "jedec,ufs-2.0";
+			compatible = "qcom,qcs9100-ufshc", "qcom,ufshc", "jedec,ufs-2.0";
 			reg = <0x0 0x01d84000 0x0 0x3000>;
 			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
 			phys = <&ufs_mem_phy>;
@@ -1640,7 +1640,7 @@ ufs_mem_hc: ufs@1d84000 {
 		};
 
 		ufs_mem_phy: phy@1d87000 {
-			compatible = "qcom,sa8775p-qmp-ufs-phy";
+			compatible = "qcom,qcs9100-qmp-ufs-phy";
 			reg = <0x0 0x01d87000 0x0 0xe10>;
 			/*
 			 * Yes, GCC_EDP_REF_CLKREF_EN is correct in qref. It
@@ -1658,7 +1658,7 @@ ufs_mem_phy: phy@1d87000 {
 		};
 
 		ice: crypto@1d88000 {
-			compatible = "qcom,sa8775p-inline-crypto-engine",
+			compatible = "qcom,qcs9100-inline-crypto-engine",
 				     "qcom,inline-crypto-engine";
 			reg = <0x0 0x01d88000 0x0 0x8000>;
 			clocks = <&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
@@ -2578,7 +2578,7 @@ apss_tpdm2_out: endpoint {
 		};
 
 		usb_0_hsphy: phy@88e4000 {
-			compatible = "qcom,sa8775p-usb-hs-phy",
+			compatible = "qcom,qcs9100-usb-hs-phy",
 				     "qcom,usb-snps-hs-5nm-phy";
 			reg = <0 0x088e4000 0 0x120>;
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
@@ -2591,7 +2591,7 @@ usb_0_hsphy: phy@88e4000 {
 		};
 
 		usb_0_qmpphy: phy@88e8000 {
-			compatible = "qcom,sa8775p-qmp-usb3-uni-phy";
+			compatible = "qcom,qcs9100-qmp-usb3-uni-phy";
 			reg = <0 0x088e8000 0 0x2000>;
 
 			clocks = <&gcc GCC_USB3_PRIM_PHY_AUX_CLK>,
@@ -2615,7 +2615,7 @@ usb_0_qmpphy: phy@88e8000 {
 		};
 
 		usb_0: usb@a6f8800 {
-			compatible = "qcom,sa8775p-dwc3", "qcom,dwc3";
+			compatible = "qcom,qcs9100-dwc3", "qcom,dwc3";
 			reg = <0 0x0a6f8800 0 0x400>;
 			#address-cells = <2>;
 			#size-cells = <2>;
@@ -2667,7 +2667,7 @@ usb_0_dwc3: usb@a600000 {
 		};
 
 		usb_1_hsphy: phy@88e6000 {
-			compatible = "qcom,sa8775p-usb-hs-phy",
+			compatible = "qcom,qcs9100-usb-hs-phy",
 				     "qcom,usb-snps-hs-5nm-phy";
 			reg = <0 0x088e6000 0 0x120>;
 			clocks = <&gcc GCC_USB_CLKREF_EN>;
@@ -2680,7 +2680,7 @@ usb_1_hsphy: phy@88e6000 {
 		};
 
 		usb_1_qmpphy: phy@88ea000 {
-			compatible = "qcom,sa8775p-qmp-usb3-uni-phy";
+			compatible = "qcom,qcs9100-qmp-usb3-uni-phy";
 			reg = <0 0x088ea000 0 0x2000>;
 
 			clocks = <&gcc GCC_USB3_SEC_PHY_AUX_CLK>,
@@ -2704,7 +2704,7 @@ usb_1_qmpphy: phy@88ea000 {
 		};
 
 		usb_1: usb@a8f8800 {
-			compatible = "qcom,sa8775p-dwc3", "qcom,dwc3";
+			compatible = "qcom,qcs9100-dwc3", "qcom,dwc3";
 			reg = <0 0x0a8f8800 0 0x400>;
 			#address-cells = <2>;
 			#size-cells = <2>;
@@ -2756,7 +2756,7 @@ usb_1_dwc3: usb@a800000 {
 		};
 
 		usb_2_hsphy: phy@88e7000 {
-			compatible = "qcom,sa8775p-usb-hs-phy",
+			compatible = "qcom,qcs9100-usb-hs-phy",
 				     "qcom,usb-snps-hs-5nm-phy";
 			reg = <0 0x088e7000 0 0x120>;
 			clocks = <&gcc GCC_USB_CLKREF_EN>;
@@ -2769,7 +2769,7 @@ usb_2_hsphy: phy@88e7000 {
 		};
 
 		usb_2: usb@a4f8800 {
-			compatible = "qcom,sa8775p-dwc3", "qcom,dwc3";
+			compatible = "qcom,qcs9100-dwc3", "qcom,dwc3";
 			reg = <0 0x0a4f8800 0 0x400>;
 			#address-cells = <2>;
 			#size-cells = <2>;
@@ -2825,7 +2825,7 @@ tcsr_mutex: hwlock@1f40000 {
 		};
 
 		gpucc: clock-controller@3d90000 {
-			compatible = "qcom,sa8775p-gpucc";
+			compatible = "qcom,qcs9100-gpucc";
 			reg = <0x0 0x03d90000 0x0 0xa000>;
 			clocks = <&rpmhcc RPMH_CXO_CLK>,
 				 <&gcc GCC_GPU_GPLL0_CLK_SRC>,
@@ -2839,7 +2839,7 @@ gpucc: clock-controller@3d90000 {
 		};
 
 		adreno_smmu: iommu@3da0000 {
-			compatible = "qcom,sa8775p-smmu-500", "qcom,adreno-smmu",
+			compatible = "qcom,qcs9100-smmu-500", "qcom,adreno-smmu",
 				     "qcom,smmu-500", "arm,mmu-500";
 			reg = <0x0 0x03da0000 0x0 0x20000>;
 			#iommu-cells = <2>;
@@ -2875,7 +2875,7 @@ adreno_smmu: iommu@3da0000 {
 		};
 
 		serdes0: phy@8901000 {
-			compatible = "qcom,sa8775p-dwmac-sgmii-phy";
+			compatible = "qcom,qcs9100-dwmac-sgmii-phy";
 			reg = <0x0 0x08901000 0x0 0xe10>;
 			clocks = <&gcc GCC_SGMI_CLKREF_EN>;
 			clock-names = "sgmi_ref";
@@ -2884,7 +2884,7 @@ serdes0: phy@8901000 {
 		};
 
 		serdes1: phy@8902000 {
-			compatible = "qcom,sa8775p-dwmac-sgmii-phy";
+			compatible = "qcom,qcs9100-dwmac-sgmii-phy";
 			reg = <0x0 0x08902000 0x0 0xe10>;
 			clocks = <&gcc GCC_SGMI_CLKREF_EN>;
 			clock-names = "sgmi_ref";
@@ -2893,7 +2893,7 @@ serdes1: phy@8902000 {
 		};
 
 		llcc: system-cache-controller@9200000 {
-			compatible = "qcom,sa8775p-llcc";
+			compatible = "qcom,qcs9100-llcc";
 			reg = <0x0 0x09200000 0x0 0x80000>,
 			      <0x0 0x09300000 0x0 0x80000>,
 			      <0x0 0x09400000 0x0 0x80000>,
@@ -2912,7 +2912,7 @@ llcc: system-cache-controller@9200000 {
 		};
 
 		pdc: interrupt-controller@b220000 {
-			compatible = "qcom,sa8775p-pdc", "qcom,pdc";
+			compatible = "qcom,qcs9100-pdc", "qcom,pdc";
 			reg = <0x0 0x0b220000 0x0 0x30000>,
 			      <0x0 0x17c000f0 0x0 0x64>;
 			qcom,pdc-ranges = <0 480 40>,
@@ -2959,7 +2959,7 @@ pdc: interrupt-controller@b220000 {
 		};
 
 		tsens2: thermal-sensor@c251000 {
-			compatible = "qcom,sa8775p-tsens", "qcom,tsens-v2";
+			compatible = "qcom,qcs9100-tsens", "qcom,tsens-v2";
 			reg = <0x0 0x0c251000 0x0 0x1ff>,
 			      <0x0 0x0c224000 0x0 0x8>;
 			interrupts = <GIC_SPI 572 IRQ_TYPE_LEVEL_HIGH>,
@@ -2970,7 +2970,7 @@ tsens2: thermal-sensor@c251000 {
 		};
 
 		tsens3: thermal-sensor@c252000 {
-			compatible = "qcom,sa8775p-tsens", "qcom,tsens-v2";
+			compatible = "qcom,qcs9100-tsens", "qcom,tsens-v2";
 			reg = <0x0 0x0c252000 0x0 0x1ff>,
 			      <0x0 0x0c225000 0x0 0x8>;
 			interrupts = <GIC_SPI 573 IRQ_TYPE_LEVEL_HIGH>,
@@ -2981,7 +2981,7 @@ tsens3: thermal-sensor@c252000 {
 		};
 
 		tsens0: thermal-sensor@c263000 {
-			compatible = "qcom,sa8775p-tsens", "qcom,tsens-v2";
+			compatible = "qcom,qcs9100-tsens", "qcom,tsens-v2";
 			reg = <0x0 0x0c263000 0x0 0x1ff>,
 			      <0x0 0x0c222000 0x0 0x8>;
 			interrupts = <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH>,
@@ -2992,7 +2992,7 @@ tsens0: thermal-sensor@c263000 {
 		};
 
 		tsens1: thermal-sensor@c265000 {
-			compatible = "qcom,sa8775p-tsens", "qcom,tsens-v2";
+			compatible = "qcom,qcs9100-tsens", "qcom,tsens-v2";
 			reg = <0x0 0x0c265000 0x0 0x1ff>,
 			      <0x0 0x0c223000 0x0 0x8>;
 			interrupts = <GIC_SPI 507 IRQ_TYPE_LEVEL_HIGH>,
@@ -3003,7 +3003,7 @@ tsens1: thermal-sensor@c265000 {
 		};
 
 		aoss_qmp: power-management@c300000 {
-			compatible = "qcom,sa8775p-aoss-qmp", "qcom,aoss-qmp";
+			compatible = "qcom,qcs9100-aoss-qmp", "qcom,aoss-qmp";
 			reg = <0x0 0x0c300000 0x0 0x400>;
 			interrupts-extended = <&ipcc IPCC_CLIENT_AOP
 					       IPCC_MPROC_SIGNAL_GLINK_QMP
@@ -3040,7 +3040,7 @@ spmi_bus: spmi@c440000 {
 		};
 
 		tlmm: pinctrl@f000000 {
-			compatible = "qcom,sa8775p-tlmm";
+			compatible = "qcom,qcs9100-tlmm";
 			reg = <0x0 0x0f000000 0x0 0x1000000>;
 			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
 			gpio-controller;
@@ -3052,7 +3052,7 @@ tlmm: pinctrl@f000000 {
 		};
 
 		sram: sram@146d8000 {
-			compatible = "qcom,sa8775p-imem", "syscon", "simple-mfd";
+			compatible = "qcom,qcs9100-imem", "syscon", "simple-mfd";
 			reg = <0x0 0x146d8000 0x0 0x1000>;
 			ranges = <0x0 0x0 0x146d8000 0x1000>;
 
@@ -3066,7 +3066,7 @@ pil-reloc@94c {
 		};
 
 		apps_smmu: iommu@15000000 {
-			compatible = "qcom,sa8775p-smmu-500", "qcom,smmu-500", "arm,mmu-500";
+			compatible = "qcom,qcs9100-smmu-500", "qcom,smmu-500", "arm,mmu-500";
 			reg = <0x0 0x15000000 0x0 0x100000>;
 			#iommu-cells = <2>;
 			#global-interrupts = <2>;
@@ -3204,7 +3204,7 @@ apps_smmu: iommu@15000000 {
 		};
 
 		pcie_smmu: iommu@15200000 {
-			compatible = "qcom,sa8775p-smmu-500", "qcom,smmu-500", "arm,mmu-500";
+			compatible = "qcom,qcs9100-smmu-500", "qcom,smmu-500", "arm,mmu-500";
 			reg = <0x0 0x15200000 0x0 0x80000>;
 			#iommu-cells = <2>;
 			#global-interrupts = <2>;
@@ -3289,7 +3289,7 @@ intc: interrupt-controller@17a00000 {
 		};
 
 		watchdog@17c10000 {
-			compatible = "qcom,apss-wdt-sa8775p", "qcom,kpss-wdt";
+			compatible = "qcom,apss-wdt-qcs9100", "qcom,kpss-wdt";
 			reg = <0x0 0x17c10000 0x0 0x1000>;
 			clocks = <&sleep_clk>;
 			interrupts = <GIC_SPI 0 IRQ_TYPE_EDGE_RISING>;
@@ -3375,14 +3375,14 @@ apps_bcm_voter: bcm-voter {
 			};
 
 			rpmhcc: clock-controller {
-				compatible = "qcom,sa8775p-rpmh-clk";
+				compatible = "qcom,qcs9100-rpmh-clk";
 				#clock-cells = <1>;
 				clock-names = "xo";
 				clocks = <&xo_board_clk>;
 			};
 
 			rpmhpd: power-controller {
-				compatible = "qcom,sa8775p-rpmhpd";
+				compatible = "qcom,qcs9100-rpmhpd";
 				#power-domain-cells = <1>;
 				operating-points-v2 = <&rpmhpd_opp_table>;
 
@@ -3433,7 +3433,7 @@ rpmhpd_opp_turbo_l1: opp-9 {
 		};
 
 		cpufreq_hw: cpufreq@18591000 {
-			compatible = "qcom,sa8775p-cpufreq-epss",
+			compatible = "qcom,qcs9100-cpufreq-epss",
 				     "qcom,cpufreq-epss";
 			reg = <0x0 0x18591000 0x0 0x1000>,
 			      <0x0 0x18593000 0x0 0x1000>;
@@ -3446,7 +3446,7 @@ cpufreq_hw: cpufreq@18591000 {
 		};
 
 		ethernet1: ethernet@23000000 {
-			compatible = "qcom,sa8775p-ethqos";
+			compatible = "qcom,qcs9100-ethqos";
 			reg = <0x0 0x23000000 0x0 0x10000>,
 			      <0x0 0x23016000 0x0 0x100>;
 			reg-names = "stmmaceth", "rgmii";
@@ -3481,7 +3481,7 @@ ethernet1: ethernet@23000000 {
 		};
 
 		ethernet0: ethernet@23040000 {
-			compatible = "qcom,sa8775p-ethqos";
+			compatible = "qcom,qcs9100-ethqos";
 			reg = <0x0 0x23040000 0x0 0x10000>,
 			      <0x0 0x23056000 0x0 0x100>;
 			reg-names = "stmmaceth", "rgmii";
@@ -4495,7 +4495,7 @@ arch_timer: timer {
 	};
 
 	pcie0: pcie@1c00000 {
-		compatible = "qcom,pcie-sa8775p";
+		compatible = "qcom,pcie-qcs9100";
 		reg = <0x0 0x01c00000 0x0 0x3000>,
 		      <0x0 0x40000000 0x0 0xf20>,
 		      <0x0 0x40000f20 0x0 0xa8>,
@@ -4576,7 +4576,7 @@ pcie@0 {
 	};
 
 	pcie0_ep: pcie-ep@1c00000 {
-		compatible = "qcom,sa8775p-pcie-ep";
+		compatible = "qcom,qcs9100-pcie-ep";
 		reg = <0x0 0x01c00000 0x0 0x3000>,
 		      <0x0 0x40000000 0x0 0xf20>,
 		      <0x0 0x40000f20 0x0 0xa8>,
@@ -4623,7 +4623,7 @@ pcie0_ep: pcie-ep@1c00000 {
 	};
 
 	pcie0_phy: phy@1c04000 {
-		compatible = "qcom,sa8775p-qmp-gen4x2-pcie-phy";
+		compatible = "qcom,qcs9100-qmp-gen4x2-pcie-phy";
 		reg = <0x0 0x1c04000 0x0 0x2000>;
 
 		clocks = <&gcc GCC_PCIE_0_AUX_CLK>,
@@ -4652,7 +4652,7 @@ pcie0_phy: phy@1c04000 {
 	};
 
 	pcie1: pcie@1c10000 {
-		compatible = "qcom,pcie-sa8775p";
+		compatible = "qcom,pcie-qcs9100";
 		reg = <0x0 0x01c10000 0x0 0x3000>,
 		      <0x0 0x60000000 0x0 0xf20>,
 		      <0x0 0x60000f20 0x0 0xa8>,
@@ -4733,7 +4733,7 @@ pcie@0 {
 	};
 
 	pcie1_ep: pcie-ep@1c10000 {
-		compatible = "qcom,sa8775p-pcie-ep";
+		compatible = "qcom,qcs9100-pcie-ep";
 		reg = <0x0 0x01c10000 0x0 0x3000>,
 		      <0x0 0x60000000 0x0 0xf20>,
 		      <0x0 0x60000f20 0x0 0xa8>,
@@ -4780,7 +4780,7 @@ pcie1_ep: pcie-ep@1c10000 {
 	};
 
 	pcie1_phy: phy@1c14000 {
-		compatible = "qcom,sa8775p-qmp-gen4x4-pcie-phy";
+		compatible = "qcom,qcs9100-qmp-gen4x4-pcie-phy";
 		reg = <0x0 0x1c14000 0x0 0x4000>;
 
 		clocks = <&gcc GCC_PCIE_1_AUX_CLK>,
-- 
2.25.1


