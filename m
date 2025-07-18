Return-Path: <linux-pci+bounces-32498-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C2BB09C0E
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 09:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B7803BE16B
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 07:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F75C21A436;
	Fri, 18 Jul 2025 07:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LH/dj1xr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D66A215773;
	Fri, 18 Jul 2025 07:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752822747; cv=none; b=gnf/8/Lr04lAMgWWb5gT6wjP5oHHtozko9jhnV+2Az07y71dDUMWKTDiIlX45lsieu+m6cCFUDztOOfoBkbm39BrVQFhpZYcaXps1fUrBKXPH1r9LiilUBS7q6Ao+agi+pkAUOoArH+D6rWDKVgczJzgpoFercnzWmNb1twHl0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752822747; c=relaxed/simple;
	bh=0K4SPuuIcngGAFPRvbGGNcGdo9ZYodG/HB4xyll+vhg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oD6jR9v/d/GOV363bxzBSwpvZpTz6aXIQFrquA68CKZQK9Btjz94JOwlZmH6D810heIzVu+mEm+MUcFJ/CfrY3QGBu+IdgyY2i22LMvuKLjzee1/9rdzj3xmiwPJj0yOdDnNssCjbjDZmtRaW3EJZ53mvG8RsvARUSir8Kkh2Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LH/dj1xr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I669X2022240;
	Fri, 18 Jul 2025 07:12:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=zVcXn+xouwm
	9M08R+gXXqzI0UC+BcJoS5cp4Pak5RCg=; b=LH/dj1xrEt38k7RrIWwclrbklPu
	Dh+hCfBGof3RDjcEb4O7eBy0c6LtS1kjaranW9rv1+DWs+J/MnczEvtfkyl7Qdx/
	nGcsKFkIbvzfNsKXcpZmGsyF54T3nAJoFVw4CM+JnH2Z0m5moYIFSTx4S26YFjN5
	j+GShp4kcGIlMOBhrGMqcRE8m9Tk3Zmxp/Xv9lUyijo8/vfqM9XCJ+jTS8wTwYv2
	hAqib8hv16zq2bAnYezEmxuX+/bv839BlAZtMJn8v8ANxrC9bBJ7xCS5e3oY282M
	/gBZBbPdI+OCX6kxybao7K1rb/d2xVi2dAALSVznoxLpSZornzdWzWydyWA==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wqsyagj3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Jul 2025 07:12:14 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 56I7CC3v023132;
	Fri, 18 Jul 2025 07:12:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 47ugsn0pq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Jul 2025 07:12:12 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56I7CCVV023123;
	Fri, 18 Jul 2025 07:12:12 GMT
Received: from cse-cd01-lnx.ap.qualcomm.com (cse-cd01-lnx.qualcomm.com [10.64.75.209])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 56I7CBb4023115
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Jul 2025 07:12:12 +0000
Received: by cse-cd01-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id 0035020F1D; Fri, 18 Jul 2025 15:12:09 +0800 (CST)
From: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, jingoohan1@gmail.com,
        mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
        bhelgaas@google.com, johan+linaro@kernel.org, vkoul@kernel.org,
        kishon@kernel.org, neil.armstrong@linaro.org, abel.vesa@linaro.org,
        kw@linux.com
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, qiang.yu@oss.qualcomm.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
Subject: [PATCH v4 2/4] dt-bindings: PCI: qcom,pcie-sa8775p: document link_down reset
Date: Fri, 18 Jul 2025 15:12:05 +0800
Message-Id: <20250718071207.160988-3-ziyue.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250718071207.160988-1-ziyue.zhang@oss.qualcomm.com>
References: <20250718071207.160988-1-ziyue.zhang@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDA1NSBTYWx0ZWRfX9ICvh5VfJcgM
 7gJRT/ZaSHPUvNsxiNrGD0Nm8ky6+52l18noIws6SB9aTBYbXDG1C+1ysxEnJKoUqSXq/sE/14g
 SV3qvzw/eMXd1lTNnzCmmaQnuh7qUn+n44qGWrYxnI8nOv/sa9uVq8jI1MCrBiCWG3odOiRsW99
 /lkhdXX8p5i0FDaq0YiUncl1q1KUgQ6i9eux5i1gwKsxWuE8GTDFo44gzlzxJmp+R5hUhrW6xaL
 KrCFmtvuCV3rza0iZpwdVQmS7TL73csZI6X4i1wHVkHvXaJ+fHmIni91ftNeelA0JTEO+nJz34b
 BEVSU7eKemhvnnM/d8Ha7hNx4xBp3wM5JB6XkPaHjtgusVRkk67XI1ZNJt+xw5CDEoWPXTexgYc
 HsUTXsF7gX549v1oFdicllxm2v5CaUKjXqlZVbxWUoAT3ugUEzBdOFJ6ooOePYVchWgwMxto
X-Proofpoint-GUID: VVjllUy0HmZqRksZg4edSU1KiWeF0kZC
X-Proofpoint-ORIG-GUID: VVjllUy0HmZqRksZg4edSU1KiWeF0kZC
X-Authority-Analysis: v=2.4 cv=McZsu4/f c=1 sm=1 tr=0 ts=6879f3ce cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=pGOvZgHL2iAvQvMqjSkA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 mlxscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180055

Each PCIe controller on SA8775P includes a 'link_down' reset line in
hardware. This patch documents the reset in the device tree binding.

The 'link_down' reset is used to forcefully bring down the PCIe link
layer, which is useful in scenarios such as link recovery after errors,
power management transitions, and hotplug events. Including this reset
line improves robustness and provides finer control over PCIe controller
behavior.

As the 'link_down' reset was omitted in the initial submission, it is now
being documented. While this reset is not required for most of the block's
basic functionality, and device trees lacking it will continue to function
correctly in most cases, it is necessary to ensure maximum robustness when
shutting down or recovering the PCIe core. Therefore, its inclusion is
justified despite the minor ABI change.

Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
---
 .../devicetree/bindings/pci/qcom,pcie-sa8775p.yaml    | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
index 4b91b5608013..19afe2a03409 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
@@ -66,11 +66,14 @@ properties:
       - const: global
 
   resets:
-    maxItems: 1
+    items:
+      - description: PCIe controller reset
+      - description: PCIe link down reset
 
   reset-names:
     items:
       - const: pci
+      - const: link_down
 
 required:
   - interconnects
@@ -166,8 +169,10 @@ examples:
 
             power-domains = <&gcc PCIE_0_GDSC>;
 
-            resets = <&gcc GCC_PCIE_0_BCR>;
-            reset-names = "pci";
+            resets = <&gcc GCC_PCIE_0_BCR>,
+                     <&gcc GCC_PCIE_0_LINK_DOWN_BCR>;
+            reset-names = "pci",
+                          "link_down";
 
             perst-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
             wake-gpios = <&tlmm 0 GPIO_ACTIVE_HIGH>;
-- 
2.34.1


