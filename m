Return-Path: <linux-pci+bounces-936-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9418127FD
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 07:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38EEC1F21A9E
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 06:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B7ED261;
	Thu, 14 Dec 2023 06:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XHJ8N0TL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE775B9;
	Wed, 13 Dec 2023 22:29:25 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BE6O3lW004599;
	Thu, 14 Dec 2023 06:29:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=B8DEEb6RlwnVITJEQM5PUFk9W/h80Pp8iAtLBC8Gsoo=; b=XH
	J8N0TLetrE18Ii2O6fxXN/KCeL2AsBbIkysZoOElc5gQRWSUFFQ74b+7VSd/wt6z
	Jnkcv8ScnnYFPRK+MGqgMRDcSqm7a0Ih46cuCZ98fACbFoMD4vzgdhzYvk4laKoG
	xrF1YPxVbsvHTEDxYtnb+Gnxf4BJs24xGLe417Fidnb5czD+yFb8/XR2wAv6mfjc
	dNDvl1fm2oEig8GaOyCnSpbARBRxqsNQKFQ4UkGNWFQ0KnBpIWs847JfmcwGQJtR
	+H5xWz5w1QC4Pk0EkKEA3jvPPWGOfZZ9xe9OZDJ8k+MW58Cg8x1fR9xQLp2I8PAw
	CTkHal/uveOqx/uc5K6g==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uyp4xgqef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Dec 2023 06:29:17 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BE6TGhc016097
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Dec 2023 06:29:16 GMT
Received: from hu-ipkumar-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 22:29:08 -0800
From: Praveenkumar I <quic_ipkumar@quicinc.com>
To: <agross@kernel.org>, <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <vkoul@kernel.org>, <kishon@kernel.org>, <mani@kernel.org>,
        <quic_nsekar@quicinc.com>, <quic_srichara@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-phy@lists.infradead.org>
CC: <quic_varada@quicinc.com>, <quic_devipriy@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_anusha@quicinc.com>
Subject: [PATCH 01/10] dt-bindings: clock: Add separate clocks for PCIe and USB for Combo PHY
Date: Thu, 14 Dec 2023 11:58:38 +0530
Message-ID: <20231214062847.2215542-2-quic_ipkumar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214062847.2215542-1-quic_ipkumar@quicinc.com>
References: <20231214062847.2215542-1-quic_ipkumar@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jtjZ0YZrLMdW4_sZYz0WxqrTZio88GSu
X-Proofpoint-ORIG-GUID: jtjZ0YZrLMdW4_sZYz0WxqrTZio88GSu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 spamscore=0 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2312140039

Qualcomm IPQ5332 has a combo PHY for PCIe and USB. Either one of the
interface (PCIe/USB) can use this combo PHY and the PHY drivers are
different for PCIe and USB. Hence separate the PCIe and USB pipe clock
source from DT, and individual driver node can be used as a clock source
separately in the gcc. Change the dt-bindings accordingly.

Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
---
 .../devicetree/bindings/clock/qcom,ipq5332-gcc.yaml         | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,ipq5332-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,ipq5332-gcc.yaml
index 718fe0625424..b22643037119 100644
--- a/Documentation/devicetree/bindings/clock/qcom,ipq5332-gcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,ipq5332-gcc.yaml
@@ -28,7 +28,8 @@ properties:
       - description: Sleep clock source
       - description: PCIE 2lane PHY pipe clock source
       - description: PCIE 2lane x1 PHY pipe clock source (For second lane)
-      - description: USB PCIE wrapper pipe clock source
+      - description: PCIE wrapper pipe clock source
+      - description: USB wrapper pipe clock source
 
 required:
   - compatible
@@ -45,7 +46,8 @@ examples:
                <&sleep_clk>,
                <&pcie_2lane_phy_pipe_clk>,
                <&pcie_2lane_phy_pipe_clk_x1>,
-               <&usb_pcie_wrapper_pipe_clk>;
+               <&pcie_wrapper_pipe_clk>,
+               <&usb_wrapper_pipe_clk>;
       #clock-cells = <1>;
       #power-domain-cells = <1>;
       #reset-cells = <1>;
-- 
2.34.1


