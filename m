Return-Path: <linux-pci+bounces-15768-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D547B9B899E
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 04:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07FD01C214C0
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 03:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B8914265F;
	Fri,  1 Nov 2024 03:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="V5TCw+1l"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7E713D619;
	Fri,  1 Nov 2024 03:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730430562; cv=none; b=JerDqoVidZTVmcShP2Yd4MXaTnDMrBrEyHdZ2C4mSeXidv1b06amnLfJZJrtGRwFbiCg6gVlF9twYFx8QzFRb9Bj7V9991bVstha6JwQiubgZhklJsUUXmNtreMCb17LhchFcDQajjW8uceCRkZ2KKK4IjbDnasB5Vfz6EXQFFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730430562; c=relaxed/simple;
	bh=zcGKhRwtAIC+breTr6Wv+Z+uPIDhmlPbuzk2ybHRr1g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eb1As0Ho7SVgxuL4kksS0cmpVjxrWWDuEFm79eDcid/KM6nyQ9+pJGYpzbXfd6vVkMihUNGasHuLO2gxKuTAOYlwmPD+8YoJx7YbQjbdteuVGjrF01JU+6qW8SzTakqM7ySQeBX4M+ht32N5W6f9yZxqp5oKCCI0EUap3+t0XsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=V5TCw+1l; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A12rSE5013825;
	Fri, 1 Nov 2024 03:09:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=RMq3cIC9Z4t
	ToNp78GhtCFKKNgTSZKyD8ivVuzzAgcs=; b=V5TCw+1lWLHRD+K3aaFvqHiUFeZ
	2chutbDT1R1bZVMj2OiV3KZhdKtdm+Rnh9Diau7/9nQ8idkXgpaIK1qpIMxGHeW0
	/pNXH10e/IKFOsjOWxNstbSpFzcKm1ir6YfPvkc1DdyxyfjtV4++FWXEfHCsbtC1
	2PqA/aSugPGMQJfZG2o4yETwj8MVVeI5WA23gay/tZcoXyRzueo78m8xVj5gG6WI
	sJj9tMj/LNfv3g+D/QyKL6xTbmPduekH1tlb8HT0tQZpssAlmWsdVJ+B041g8Xzr
	KbTeQaXTaZLrY+snSdn39AirNJCZNyJaX7A9E1t2h1nEfL1Rsi89vvC8sqw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42ky6rbv7u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Nov 2024 03:09:07 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA02.qualcomm.com [127.0.0.1])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A138go9009550;
	Fri, 1 Nov 2024 03:09:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 42kwa1taug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Nov 2024 03:09:06 +0000
Received: from NALASPPMTA02.qualcomm.com (NALASPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4A1396gm010305;
	Fri, 1 Nov 2024 03:09:06 GMT
Received: from hu-devc-lv-u22-c.qualcomm.com (hu-qianyu-lv.qualcomm.com [10.81.25.114])
	by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 4A1395wq010300
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Nov 2024 03:09:06 +0000
Received: by hu-devc-lv-u22-c.qualcomm.com (Postfix, from userid 4098150)
	id DCDCC65D; Thu, 31 Oct 2024 20:09:05 -0700 (PDT)
From: Qiang Yu <quic_qianyu@quicinc.com>
To: manivannan.sadhasivam@linaro.org, vkoul@kernel.org, kishon@kernel.org,
        robh@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, abel.vesa@linaro.org, quic_msarkar@quicinc.com,
        quic_devipriy@quicinc.com
Cc: dmitry.baryshkov@linaro.org, kw@linux.com, lpieralisi@kernel.org,
        neil.armstrong@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, johan+linaro@kernel.org,
        Qiang Yu <quic_qianyu@quicinc.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v8 1/5] dt-bindings: PCI: qcom: Move OPP table to qcom,pcie-common.yaml
Date: Thu, 31 Oct 2024 20:08:58 -0700
Message-Id: <20241101030902.579789-2-quic_qianyu@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241101030902.579789-1-quic_qianyu@quicinc.com>
References: <20241101030902.579789-1-quic_qianyu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Ib5ml7N8xZ595oc3ljWUXtJPMtfkuPbI
X-Proofpoint-ORIG-GUID: Ib5ml7N8xZ595oc3ljWUXtJPMtfkuPbI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 clxscore=1015 phishscore=0 mlxscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411010021

OPP table is a generic property that is also required by other qcom
platforms. Hence move this property to qcom,pcie-common.yaml so that PCIe
on other qcom platforms is able to adjust power domain performance state
and ICC peak bw according to PCIe gen speed and link width.

Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml | 4 ++++
 Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml | 4 ----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml
index e18900c41576..0480c58f7d99 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml
@@ -81,6 +81,10 @@ properties:
   vddpe-3v3-supply:
     description: PCIe endpoint power supply
 
+  operating-points-v2: true
+  opp-table:
+    type: object
+
 required:
   - reg
   - reg-names
diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml
index 46bd59eefadb..6e0a6d8f0ed0 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml
@@ -70,10 +70,6 @@ properties:
       - const: msi7
       - const: global
 
-  operating-points-v2: true
-  opp-table:
-    type: object
-
   resets:
     maxItems: 1
 
-- 
2.34.1


