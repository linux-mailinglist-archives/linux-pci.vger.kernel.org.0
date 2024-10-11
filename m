Return-Path: <linux-pci+bounces-14276-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D886A99A1C4
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 12:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87E441F2181D
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 10:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF00218592;
	Fri, 11 Oct 2024 10:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gf0b1P6J"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE68216A3B;
	Fri, 11 Oct 2024 10:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728643334; cv=none; b=uwLBbWmLuf9vb3hpXppEzOQJMWykvej4LoxyXcWc9YE2zPKdEZ6+XbrYlEPWD304oxfjpK6gkUwIawecWNY1JAuoxxWqPY4iJ2aYrphskDWkaJVOmFxv+ZEisnv/5xr1EkJtThSdJXYV/IPsb96nMPc60pDHCLbYautWVUVGLJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728643334; c=relaxed/simple;
	bh=/OaIJUJeHXvqj7GHi0yUpTwn/e5H7FN2Mh8iuqxIYFI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QMgWcjkD2ttDOzEIqshsZZhWr0LEovIBTTXLFQv+Po0PPsNIfWr+9zZHWgImtomoMCFiFc/WykYqJd2/legdlERR0EZfdXYT4/Kb4b4GcB0c3wzNepdqQYW9PCQ4/RgY8EPIqVzJASk7uhMPq0YdrxlvC+l6+voZCa6rVyQCobo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gf0b1P6J; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49BAJx6O022616;
	Fri, 11 Oct 2024 10:41:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ZVvER7EKYdp
	jeO0na97gVqB32JSVRkCRFXsP1e7yaf4=; b=gf0b1P6JQZqqSPwOETuBT/2h3l+
	vpAoawOJHVncNIvlbDTic7+MeBVkoDew6VqYPmfkJEqEpQN3ecU7TX/vQCVdZSmA
	kU6fsmbR7j/sJYHujZN3WNX9nZJTlUFhIfy0mfTCKnPa6/2mq7T20MGPtJtT5giF
	ZYW/1V2fpQ04n/upL4w9XUGcLcgdGUgwn3tf8dqk779VFaFCOMo8wEW+Mr9H/xvd
	NK94GKFtFo8qi+WLUyU4kBnsBv0ktwtY/8osmmd4DuLICarugYAZhy5kY2J62tEn
	n/rMRLo3iKBALsUzzcKr4yjfHtjWHIsl1Bce1n5tfb+kQXYPcHhlTtiIjsg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 426db7kfnh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Oct 2024 10:41:46 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA04.qualcomm.com [127.0.0.1])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 49BAUB8v006873;
	Fri, 11 Oct 2024 10:41:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 426s8y488n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Oct 2024 10:41:46 +0000
Received: from NALASPPMTA04.qualcomm.com (NALASPPMTA04.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49BAbDGc015180;
	Fri, 11 Oct 2024 10:41:46 GMT
Received: from hu-devc-lv-u22-c.qualcomm.com (hu-qianyu-lv.qualcomm.com [10.81.25.114])
	by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 49BAfjrW022417
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Oct 2024 10:41:45 +0000
Received: by hu-devc-lv-u22-c.qualcomm.com (Postfix, from userid 4098150)
	id 9AD02651; Fri, 11 Oct 2024 03:41:45 -0700 (PDT)
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
        linux-clk@vger.kernel.org, Qiang Yu <quic_qianyu@quicinc.com>
Subject: [PATCH v6 3/8] dt-bindings: PCI: qcom,pcie-x1e80100: Add 'global' interrupt
Date: Fri, 11 Oct 2024 03:41:37 -0700
Message-Id: <20241011104142.1181773-4-quic_qianyu@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241011104142.1181773-1-quic_qianyu@quicinc.com>
References: <20241011104142.1181773-1-quic_qianyu@quicinc.com>
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
X-Proofpoint-ORIG-GUID: f8uoAnd4mtInaiCenSKSbvqwnx4jF_kj
X-Proofpoint-GUID: f8uoAnd4mtInaiCenSKSbvqwnx4jF_kj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 mlxscore=0 phishscore=0 clxscore=1015 spamscore=0
 adultscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410110073

Document 'global' SPI interrupt along with the existing MSI interrupts so
that QCOM PCIe RC driver can make use of it to get events such as PCIe
link specific events, safety events, etc.

Though adding a new interrupt will break the ABI, it is required to
accurately describe the hardware.

Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
---
 .../devicetree/bindings/pci/qcom,pcie-x1e80100.yaml    | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
index a9db0a231563..2c0e01fc0ab8 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
@@ -46,8 +46,8 @@ properties:
       - const: cnoc_sf_axi # Config NoC PCIe1 AXI clock
 
   interrupts:
-    minItems: 8
-    maxItems: 8
+    minItems: 9
+    maxItems: 9
 
   interrupt-names:
     items:
@@ -59,6 +59,7 @@ properties:
       - const: msi5
       - const: msi6
       - const: msi7
+      - const: global
 
   resets:
     minItems: 1
@@ -130,9 +131,10 @@ examples:
                          <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
                          <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
                          <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
+                         <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
             interrupt-names = "msi0", "msi1", "msi2", "msi3",
-                              "msi4", "msi5", "msi6", "msi7";
+                              "msi4", "msi5", "msi6", "msi7", "global";
             #interrupt-cells = <1>;
             interrupt-map-mask = <0 0 0 0x7>;
             interrupt-map = <0 0 0 1 &intc 0 0 0 149 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
-- 
2.34.1


