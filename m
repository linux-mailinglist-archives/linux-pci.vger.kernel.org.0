Return-Path: <linux-pci+bounces-13155-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E28977B3A
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 10:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B323B22995
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 08:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C933E1D6C57;
	Fri, 13 Sep 2024 08:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IrAab1Yl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C451BC07E;
	Fri, 13 Sep 2024 08:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726216673; cv=none; b=ZL7RhVzvwpYXdku8DcVdHSDrbY72jKhvbNpZwDpQSfAi5vE20ShBiFXlB+xjAj7XVU9YEUusYVPOJryMzLsZz13Q44+DZEn9/MTcpdHWoyCxQKf6VI0EavPmcb1+rvxbxB7J9+tpFnA9eK1r9JwakXD1jjcG+NW9eBNi1gUUkjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726216673; c=relaxed/simple;
	bh=lrQjYx4+FMHCpYBQr+sdDUctFw4nUUlE8ur1EvL+nRE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lloCrklt1VV5B6xg8zLcqiysfbJrlrywrZjBJ+LMhBG4YCkzcHOIvTOg5Wz6U3BJRQ4wZdFH8Npk4UPhnZZ4pvLV8aPjVJHu2j61uujtQyc//FrCSfyGOy80kvn1qp8ZwQK4cJS+nipf9t996H2IKB2bo9UaWBlCTOqsduNYvEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IrAab1Yl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48CMBNi1025957;
	Fri, 13 Sep 2024 08:37:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ySFDvOWx6bn
	oC8M4HiNhC6v9DvafTD/OqgmgZYdikLE=; b=IrAab1YlopPKUZsWSlw55D+62lZ
	ZSxlTGmcyMsKbhjThjQcs00Q+2f14WX8DXqukigiY3a22m7kjPwNsAP/6eM2K4RW
	rnZDxemMrMDbuonVRMDagXm7o12Xu2lWJBVc16+YB3qNetW7U23fE6YzcTeSJkB1
	7tLk0GWawM7ubrIISrzovo+Gvg09hiS2YFMIWatFnx3mKEh6OF+R03UP9x2aPHDG
	yHba+4P9VcY1SCHov+YzZMwJSc+HfbrvDiHShtA5emrDomJgo/BR0Ey74ZBUrOGl
	UfBfKeCYCzt5g2nLQkE6+bmPkUNQez8Q4NPMy5cO4Az7o5EexV7Pl/vkwQA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41gy8p84x4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Sep 2024 08:37:30 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA05.qualcomm.com [127.0.0.1])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 48D8WZMd007733;
	Fri, 13 Sep 2024 08:37:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 41kufwspkv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Sep 2024 08:37:29 +0000
Received: from NALASPPMTA05.qualcomm.com (NALASPPMTA05.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48D8b2dW013615;
	Fri, 13 Sep 2024 08:37:29 GMT
Received: from hu-devc-lv-u22-c.qualcomm.com (hu-qianyu-lv.qualcomm.com [10.81.25.114])
	by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 48D8bSSS013827
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Sep 2024 08:37:28 +0000
Received: by hu-devc-lv-u22-c.qualcomm.com (Postfix, from userid 4098150)
	id 966B654F; Fri, 13 Sep 2024 01:37:28 -0700 (PDT)
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
Subject: [PATCH v2 2/5] dt-bindings: PCI: qcom: Add OPP table for X1E80100
Date: Fri, 13 Sep 2024 01:37:21 -0700
Message-Id: <20240913083724.1217691-3-quic_qianyu@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240913083724.1217691-1-quic_qianyu@quicinc.com>
References: <20240913083724.1217691-1-quic_qianyu@quicinc.com>
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
X-Proofpoint-GUID: FZPNW10Rzr_-6wz16rW0flUtr6QP0MMA
X-Proofpoint-ORIG-GUID: FZPNW10Rzr_-6wz16rW0flUtr6QP0MMA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409130059

Add OPP table so that PCIe is able to adjust power domain performance
state and ICC peak bw according to PCIe gen speed and link width.

Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
index a9db0a231563..e2d6719ca54d 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
@@ -70,6 +70,10 @@ properties:
       - const: pci # PCIe core reset
       - const: link_down # PCIe link down reset
 
+  operating-points-v2: true
+  opp-table:
+    type: object
+
 allOf:
   - $ref: qcom,pcie-common.yaml#
 
-- 
2.34.1


