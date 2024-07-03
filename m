Return-Path: <linux-pci+bounces-9659-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 949A29250A1
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 06:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15A811F230B4
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 04:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369C412DDB8;
	Wed,  3 Jul 2024 04:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CSUOgfn3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6711B977;
	Wed,  3 Jul 2024 04:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719979226; cv=none; b=uvpETx/SwBrEAPRCcVr/hi+uMZM4yJ5phofE9euRnQxWFP+zx0A+aQt+pYKcRdCS9RJBibNuGL3fLq2KMsu2XZCAO+/NdV57erkXxEFs0uCgnA1nseJN3nU+rdNquFkddipFLYqBWN4kE26r01skcvcBoa+WsI7h8NSjKXf58aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719979226; c=relaxed/simple;
	bh=KSSlOH0xqUSEcdk3D5AAbABk7tJOOY5aXvwPP4l6PUg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YVx1v4O9j4hYyctxpiFjZG/mkaWVWbWprde6QEmI+AtJyKwBQF5ujXMO8kP18TP3/MIw8RA/o+K1VaEC/PzxrX4Kh0pYxa1qnRWInubdh2EAJyjN2nY7aIv2e1zsBfXByUH6ntuNXSO1F+ERRuIqVbW/5jzfn99ROjrxWxtlXsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CSUOgfn3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 462G8iCZ012191;
	Wed, 3 Jul 2024 03:58:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	O92o6x8MI3tbjaQRL6XDQcqlyifVOQWVm1bVLaysjDA=; b=CSUOgfn3UU7u2M1l
	chsTGu/jsah5go3Hbd1aaM1+GM6f+t8KVQuufu0bly/xs0SFBCts6EvQriy+eslv
	rJSKsa5I7+1rLJRIIqNoUZoa4WmGhFsHgRs5md6XCl3CF6irXGTDYsdxAwR0RIUD
	UTbiwbC9AHkiJ2m2bwsJXn2dOcBUylzqX0sRmWqJCqhZJk3RpQueEM/mLEd8dLie
	oOSimPU2tTeq3nFYsr7WJkUcPD84rga+oc78soWR+7q2FQzkR5VoRzq2j+A319SS
	4zQ5coIn0wlCRNVBI5fdwO4kyaI9ge003BQaB2OedPcGxsYjQTkFLT3ghIK+Wkbp
	H+KcWA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 402bj8a5pg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jul 2024 03:58:38 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4633wblq002460
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Jul 2024 03:58:37 GMT
Received: from tengfan-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 2 Jul 2024 20:58:15 -0700
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
Subject: [PATCH 00/47] arm64: qcom: dts: add QCS9100 support
Date: Wed, 3 Jul 2024 11:56:48 +0800
Message-ID: <20240703035735.2182165-1-quic_tengfan@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240703025850.2172008-1-quic_tengfan@quicinc.com>
References: <20240703025850.2172008-1-quic_tengfan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 9RhCK4Q8DM0Uv2lm9JNJpT0KE-G6pcCq
X-Proofpoint-GUID: 9RhCK4Q8DM0Uv2lm9JNJpT0KE-G6pcCq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-02_18,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407030027

Introduce support for the QCS9100 SoC device tree (DTSI) and the
QCS9100 RIDE board DTS. The QCS9100 is a variant of the SA8775p.
While the QCS9100 platform is still in the early design stage, the
QCS9100 RIDE board is identical to the SA8775p RIDE board, except it
mounts the QCS9100 SoC instead of the SA8775p SoC.

The QCS9100 SoC DTSI was directly renamed from the SA8775p SoC DTSI. In
the upcoming weeks, Nikunj Kela will develop a new device tree related
to SA8775p, specifically supporting the SCMI resource firmware solution
for the SA8775p platform. If you're already familiar with the
background, feel free to skip part[2], which provides a detailed
explanation.

All compatible strings have been updated from “SA8775P” to “QCS9100.”
If you’re already aware of the context, feel free to skip part[3], which
provides a detailed explanation of various other options.

Here’s the reason and background: Bjorn Andersson, Nikunj Kela,
Srinivas Kandagatla, and other Qualcomm engineers contributed to the
current design, and we’ve finalized this series for broader audience
review.

*This patch series aligns with upstream efforts toward a new design
solution: “Using logical performance and power domains to achieve
resource abstraction over SCMI.” For more details, refer to [1]:
[1]https://resources.linaro.org/en/resource/wfnfEwBhRjLV1PEAJoDDte

*The SA8775p-RIDE will transition to using SCMI resources. This involves
migrating to SCMI power and performance protocols for requesting and
configuring peripheral resources such as clocks, regulators,
interconnects, and PHYs. Consequently, most devices in the SA8775p-RIDE
will require updates to drivers, bindings, and device trees.

*The QCS9100-RIDE project will continue using the existing resources.
It will rely on the current kernel infrastructure for clocks, regulators,
interconnects, PHYs, and APIs.

[2] The reason of qcs9100.dtsi renamed from sa8775.dtsi:
The proposal is to maintain two separate platform.dtsi files.
qcs9100.dtsi for non-scmi resources and sa8775p.dtsi for SCMI resources.
Currently, the upstream sa8775p.dtsi contains 176 nodes with specified
“compatible” strings. Among these, 142 nodes require distinct properties
for SCMI and non-SCMI. As the IoT target is being upstreamed, both node
counts are expected to increase for the IoT/QCS platform.

If we do not implement platform separation, any modifications to the
base sa8775p.dtsi-whether for automotive or IoT purposes-must consider
the other platform. Each node(e.g., remoteproc, multimedia) added should
be countered with an overlay that disables it in the automotive context.
Care must be taken to avoid introducing changes that inferfere with the
automotive system design, This structure poses challenges for human
reasioning, leading to issues during development, code review, and
maintenance.

Furthermore, we are addressing the complexity of resuing marketing names
accross both the IoT(QCS9100) and automotive(SA8775p) platforms. This
decision has significations throughout DeviceTree and the kernel.
Consequently, renameing the QCS9100 device tree files from the SA8775p
device files is our definitive choice.

[3] The reason of All Compatible Strings Changed from “SA8775P” to
“QCS9100”:
During discussions, three options were considered. Ultimately, Option
B was chosen as the best approach for separating QCS projects from SA
projects. This decision simplifies the reviewer’s task by focusing on
each platform independently. Developers only need to verify the
affected platform.

*Option A: “And” (qcs9100+sa8775):

Add all qcs9100-compatible strings alongside the current
sa8775p-compatible strings in each binding file. For example:
aggre1_noc: interconnect-aggre1-noc {
-    compatible = "qcom,sa8775p-aggre1-noc";
+    compatible = "qcom,qcs9100-aggre1-noc", "qcom,sa8775p-aggre1-noc";
    #interconnect-cells = <2>;
    qcom,bcm-voters = <&apps_bcm_voter>; };

Some device tree (DT) nodes may share common compatibles. For instance:
firmware {
    scm {
-        compatible = "qcom,scm-sa8775p", "qcom,scm";
+        compatible = "qcom,scm-qcs9100", "qcom,scm";
    };
};

Approximately 50+ sa8775p-related compatible names need to be changed
to qcs9100-compatible names in the binding files and DT nodes.
When the SCMI resource driver owner adds SCMI support, they need to
update both the qcs9100 DT (non-SCMI resource) and the sa8775 DT (SCMI
resource) simultaneously.
For this option:

DT and binding changes are needed.
No driver C file changes are required at this time.
Technical driver owners must handle both the qcs DT and sa DT.

*Option B: “Or” (qcs9100 or sa8775):

Replace all qcs9100-compatible strings with the current
sa8775p-compatible strings in the qcs9100 DT. For example:
aggre1_noc: interconnect-aggre1-noc {
-    compatible = "qcom,sa8775p-aggre1-noc";
+    compatible = "qcom,qcs9100-aggre1-noc";
    #interconnect-cells = <2>;
    qcom,bcm-voters = <&apps_bcm_voter>; };

Add the necessary “qcs9100” compatible strings to the C driver. In
drivers/interconnect/qcom/sa8775p.c:
static const struct of_device_id qnoc_of_match[] = {
    { .compatible = "qcom,sa8775p-aggre1-noc", .data = &sa8775p_aggre1_noc },
+   { .compatible = "qcom,qcs9100-aggre1-noc", .data =
&sa8775p_aggre1_noc },
    { .compatible = "qcom,sa8775p-aggre2-noc", .data = &sa8775p_aggre2_noc },
+   { .compatible = "qcom,qcs9100-aggre2-noc", .data =
&sa8775p_aggre2_noc },
    // ...
};

Some DT nodes may share common compatibles, similar to the example above.
Approximately 50+ sa8775p-related compatible names need to be changed to
qcs9100-compatible names in the binding files and DT nodes.
When the SCMI resource driver owner adds SCMI support, they only need to
update the sa8775 DT (SCMI resource).
For this option:
DT, binding, and C driver changes are needed.
Technical driver owners only need to handle the sa DT.

*Option C: “Depends” (sa8775 in qcs9100, depends on driver to change
necessary driver + DT later):
This option depends on the SCMI resource solution and requires minimal
driver changes.

Change common compatibles to “qcs9100,” as shown in the example:
firmware {
    scm {
-        compatible = "qcom,scm-sa8775p", "qcom,scm";
+        compatible = "qcom,scm-qcs9100", "qcom,scm";
    };
};

Approximately 30+ sa8775p-related compatible names need to be changed
to qcs9100-compatible names in the binding files and DT nodes.
When the SCMI resource driver owner adds SCMI support, they must
update both the qcs9100 DT and the sa8775 DT (SCMI resource)
simultaneously.
For example:

{ .compatible = "qcom,sa8775p-aggre1-noc", .data = &sa8775p_aggre1_noc },
+ { .compatible = "qcom,qcs9100-aggre1-noc", .data = &qcs9100_aggre1_noc
+ },
{ .compatible = "qcom,sa8775p-aggre2-noc", .data = &sa8775p_aggre2_noc },
+ { .compatible = "qcom,qcs9100-aggre2-noc", .data = &qcs9100_aggre2_noc
+ },
// ...

For this option:
DT changes are needed.
Technical driver owners are responsible for making the final different
driver changes and ensuring the exact binding of qcs9100 and sa8775
with different compatibles.

In summary, the current solution primarily targets SCMI-based resource
transactions. However, both the qcs project and the SA project, which
are in the development stage, require independent development processes.

Co-developed-by: Maria Yu <quic_aiquny@quicinc.com>
Signed-off-by: Maria Yu <quic_aiquny@quicinc.com>
Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
---

Tengfei Fan (47):
  dt-bindings: arm: qcom: Document QCS9100 SoC and RIDE board
  arm64: dts: qcom: qcs9100: Introduce QCS9100 SoC dtsi
  arm64: dts: qcom: qcs9100: Introduce QCS9100 PMIC dtsi
  arm64: dts: qcom: qcs9100: Add QCS9100 RIDE board dts
  dt-bindings: firmware: qcom,scm: document SCM on QCS9100 SoC
  dt-bindings: interconnect: qcom: document the interconnect compatibles
    for QCS9100
  dt-bindings: clock: document QCS9100 GCC compatible
  dt-bindings: mailbox: qcom-ipcc: Document the QCS9100 IPCC
  dt-bindings: phy: Add QMP UFS PHY comptible for QCS9100
  dt-bindings: crypto: ice: Document QCS9100 inline crypto engine
  dt-bindings: crypto: qcom,prng: document QCS9100
  dt-bindings: phy: qcom,usb-snps-femto-v2: Add bindings for QCS9100
  dt-bindings: ufs: qcom: document QCS9100 UFS
  dt-bindings: phy: qcom,qmp-usb: Add QCS9100 USB3 PHY
  dt-bindings: usb: dwc3: Add QCS9100 compatible
  dt-bindings: clock: qcom: describe the GPUCC clock for QCS9100
  dt-bindings: arm-smmu: Document QCS9100 GPU SMMU
  dt-bindings: phy: describe the Qualcomm SGMII PHY for QCS9100
  dt-bindings: cache: qcom,llcc: Add QCS9100 description
  dt-bindings: interrupt-controller: qcom,pdc: document pdc on QCS9100
  dt-bindings: thermal: qcom-tsens: document the QCS9100 Temperature
    Sensor
  dt-bindings: soc: qcom,aoss-qmp: Document the QCS9100 AOSS channel
  dt-bindings: pinctrl: add qcs9100-tlmm compatible
  dt-bindings: soc: qcom: add qcom,qcs9100-imem compatible
  dt-bindings: watchdog: qcom-wdt: document QCS9100
  dt-bindings: clock: qcom-rpmhcc: Add RPMHCC bindings for QCS9100
  dt-bindings: cpufreq: cpufreq-qcom-hw: Add QCS9100 compatibles
  dt-bindings: power: qcom,rpmpd: document the QCS9100 RPMh Power
    Domains
  dt-bindings: net: qcom,ethqos: add description for qcs9100
  dt-bindings: PCI: Document compatible for QCS9100
  dt-bindings: PCI: qcom-ep: Add support for QCS9100 SoC
  dt-bindings: phy: qcom,qmp: Add qcs9100 QMP PCIe PHY
  interconnect: qcom: add driver support for qcs9100
  clk: qcom: add the GCC driver support for QCS9100
  phy: qcom-qmp-ufs: Add QCS9100 support
  phy: qcpm-qmp-usb: Add support for QCS9100
  clk: qcom: add the GPUCC driver support for QCS9100
  phy: qcom: add the SGMII SerDes PHY driver support
  soc: qcom: llcc: Add llcc configuration support for the QCS9100
    platform
  pinctrl: qcom: add the tlmm driver support for qcs9100 platform
  clk: qcom: rpmh: Add support for QCS9100 rpmh clocks
  soc: qcom: rmphpd: add power domains for QCS9100
  net: stmmac: dwmac-qcom-ethqos: add support for emac4 on qcs9100
    platforms
  PCI: qcom: Add support for QCS9100 SoC
  PCI: qcom-ep: Add HDMA support for QCS9100 SoC
  cpufreq: qcom-nvmem: add support for QCS9100
  phy: qcom-qmp-pcie: add x4 lane EP support for QCS9100

 .../devicetree/bindings/arm/qcom.yaml         |   3 +
 .../devicetree/bindings/cache/qcom,llcc.yaml  |   2 +
 .../devicetree/bindings/clock/qcom,gpucc.yaml |   1 +
 .../bindings/clock/qcom,rpmhcc.yaml           |   1 +
 .../bindings/clock/qcom,sa8775p-gcc.yaml      |   5 +-
 .../bindings/cpufreq/cpufreq-qcom-hw.yaml     |   1 +
 .../crypto/qcom,inline-crypto-engine.yaml     |   1 +
 .../devicetree/bindings/crypto/qcom,prng.yaml |   1 +
 .../bindings/firmware/qcom,scm.yaml           |   1 +
 .../interconnect/qcom,sa8775p-rpmh.yaml       |  14 +++
 .../interrupt-controller/qcom,pdc.yaml        |   1 +
 .../devicetree/bindings/iommu/arm,smmu.yaml   |   3 +
 .../bindings/mailbox/qcom-ipcc.yaml           |   1 +
 .../devicetree/bindings/net/qcom,ethqos.yaml  |   1 +
 .../devicetree/bindings/net/snps,dwmac.yaml   |   3 +
 .../devicetree/bindings/pci/qcom,pcie-ep.yaml |   2 +
 .../bindings/pci/qcom,pcie-sa8775p.yaml       |   5 +-
 .../phy/qcom,sa8775p-dwmac-sgmii-phy.yaml     |   5 +-
 .../phy/qcom,sc8280xp-qmp-pcie-phy.yaml       |   4 +
 .../phy/qcom,sc8280xp-qmp-ufs-phy.yaml        |   2 +
 .../phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml   |   3 +
 .../bindings/phy/qcom,usb-snps-femto-v2.yaml  |   1 +
 .../bindings/pinctrl/qcom,sa8775p-tlmm.yaml   |   5 +-
 .../devicetree/bindings/power/qcom,rpmpd.yaml |   1 +
 .../bindings/soc/qcom/qcom,aoss-qmp.yaml      |   1 +
 .../devicetree/bindings/sram/qcom,imem.yaml   |   1 +
 .../bindings/thermal/qcom-tsens.yaml          |   1 +
 .../devicetree/bindings/ufs/qcom,ufs.yaml     |   2 +
 .../devicetree/bindings/usb/qcom,dwc3.yaml    |   3 +
 .../bindings/watchdog/qcom-wdt.yaml           |   1 +
 arch/arm64/boot/dts/qcom/Makefile             |   2 +-
 ...{sa8775p-pmics.dtsi => qcs9100-pmics.dtsi} |   0
 .../{sa8775p-ride.dts => qcs9100-ride.dts}    |   8 +-
 .../dts/qcom/{sa8775p.dtsi => qcs9100.dtsi}   | 112 +++++++++---------
 drivers/clk/qcom/clk-rpmh.c                   |   1 +
 drivers/clk/qcom/gcc-sa8775p.c                |   1 +
 drivers/clk/qcom/gpucc-sa8775p.c              |   1 +
 drivers/cpufreq/cpufreq-dt-platdev.c          |   1 +
 drivers/interconnect/qcom/sa8775p.c           |  14 +++
 .../stmicro/stmmac/dwmac-qcom-ethqos.c        |   1 +
 drivers/pci/controller/dwc/pcie-qcom-ep.c     |   1 +
 drivers/pci/controller/dwc/pcie-qcom.c        |   1 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      |   6 +
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c       |   3 +
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c       |   3 +
 drivers/phy/qualcomm/phy-qcom-sgmii-eth.c     |   1 +
 drivers/pinctrl/qcom/pinctrl-sa8775p.c        |   1 +
 drivers/pmdomain/qcom/rpmhpd.c                |   1 +
 drivers/soc/qcom/llcc-qcom.c                  |   1 +
 49 files changed, 170 insertions(+), 65 deletions(-)
 rename arch/arm64/boot/dts/qcom/{sa8775p-pmics.dtsi => qcs9100-pmics.dtsi} (100%)
 rename arch/arm64/boot/dts/qcom/{sa8775p-ride.dts => qcs9100-ride.dts} (99%)
 rename arch/arm64/boot/dts/qcom/{sa8775p.dtsi => qcs9100.dtsi} (97%)


base-commit: 82e4255305c554b0bb18b7ccf2db86041b4c8b6e
-- 
2.25.1


