Return-Path: <linux-pci+bounces-28538-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7D5AC76E5
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 05:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CBE816C791
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 03:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2285254AFF;
	Thu, 29 May 2025 03:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XjM7ZZ4/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1422522B6;
	Thu, 29 May 2025 03:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748491015; cv=none; b=t5d4vVgXk3ICQZCCGX81JLK52YLhHRGsx4sqhfzUN9wrpE6oaT9AFeLkyOOIp6zNXKU/LF0PYz1JD5LS9blos4x4YIP0Ge1aoftpl/Bad0JZMFWSsArTKlhVv9qnajij0OjDXu9yrrm7drT67W2GwCLzjCXNwJG2uUtFN7Pd/JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748491015; c=relaxed/simple;
	bh=G7CJjdxtGS3nWPsemQZmkMbpenE3w3op9heV9+kV+Ys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e9Pcr9U5A4+n13aPmHGvNQqSdKqKKaiU0Mv5/7jb/dszX9Ebvbeffq1LAdmn7JprouPgUcytSLIdjkPVrMJWNIdHDW0eTssruB65B4/AVlptI2Y+WAFuQaZ9lQCu0EXYuGreaQ5Ct8p15hBeEkN8p6xoz2BV/XK3gfnDftYYdr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XjM7ZZ4/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54T34iDL028920;
	Thu, 29 May 2025 03:56:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=vu1QTheACGP
	0cBhsjQgBRlv97ahOvRg5J9+zaSdIoLI=; b=XjM7ZZ4/BtZmoogkVxlVAkncxhM
	MCGz2gqIc872v2hCcEA2KRgUCTZZOt0+1JfDhHxbzJV0Luvz3zzxLCycmk3QIWOa
	I+wBfIPXkza7d77Ir8WvN7JkuEhAqi3PDH6BuunYywo82TaW9N3zPxyxxcI2cOVh
	MiurhwwXPfW8mjqZrRI0k/BxJF4c8OkrE8xlOH+98Af/pg5H6kCaIKv5JwissQZm
	RZCR9Vr9OXLW14IfO2qyYJHT5B0uW8P/A6PJdWUfn2H4ehb0DI22NlfqsFAAvNAh
	tUUf6SYVG6JEoEdARKf7FxMUVefaQYsfkNQ8IMdUKTWfey6Tu0gtWQvRcsg==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46whuf4ra8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 May 2025 03:56:41 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 54T3ud9w032151;
	Thu, 29 May 2025 03:56:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 46u76mdp0u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 May 2025 03:56:39 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54T3udhV032138;
	Thu, 29 May 2025 03:56:39 GMT
Received: from cse-cd02-lnx.ap.qualcomm.com (cse-cd02-lnx.qualcomm.com [10.64.75.246])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 54T3ucig032134
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 May 2025 03:56:39 +0000
Received: by cse-cd02-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id 79DE33158; Thu, 29 May 2025 11:56:37 +0800 (CST)
From: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
To: lpieralisi@kernel.org, kwilczynski@kernel.org,
        manivannan.sadhasivam@linaro.org, robh@kernel.org, bhelgaas@google.com,
        krzk+dt@kernel.org, neil.armstrong@linaro.org, abel.vesa@linaro.org,
        kw@linux.com, conor+dt@kernel.org, vkoul@kernel.org, kishon@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_qianyu@quicinc.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Subject: [PATCH v6 1/6] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Update pcie phy bindings for qcs8300
Date: Thu, 29 May 2025 11:56:30 +0800
Message-Id: <20250529035635.4162149-2-quic_ziyuzhan@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250529035635.4162149-1-quic_ziyuzhan@quicinc.com>
References: <20250529035635.4162149-1-quic_ziyuzhan@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=OslPyz/t c=1 sm=1 tr=0 ts=6837daf9 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=pixhw7HmqKTquG-jXeMA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: CFhq0dnvjtWJsXYY-7Iq98rSye8FxX_I
X-Proofpoint-GUID: CFhq0dnvjtWJsXYY-7Iq98rSye8FxX_I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDAzNSBTYWx0ZWRfXzyY+vi7yuCTf
 JjGLYwabxM/JabdJXd9hFhwIeumkAVKgDcx8qnFb/aFWZb5uRy41ipfKR3kbW7nDPFTf8NDkULm
 82iZry5blnGSYLUY8XAawIfHoHu3Lsncrr8KFGR8BDdB0POaOiHixauLw5Cv0TJq0GPTqQZlLjm
 RDdqC7eSk9Uq2Tnj8+lC4xgPta5xj8FzxrgvXE6whte+HOgWQqRatlPQ8MzRbLi3VSeV+d9HTkY
 fqJNWRdf+ruaV4A5KHAsLG8FenxLwXywhloHu3cWxSSZVtOdb75YyKl3P23or9tKYkbxOuKqZ5S
 DuDvwj503lU4rLtnrvkLNNQmuYbl6m+sY+QAMZt6BSqwo448n0A3Wre3lvPYIZ0ZMeeT+Sze9j9
 4uc1fjRFw8+1d0y74fdk4LCmN5uy8ESNIWKowx58jcGZXmYqH4p4KZ895pR5BYmrxRAuzs+H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_01,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 mlxscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505290035

The gcc_aux_clk is not required by the PCIe PHY on qcs8300 and is not
specified in the device tree node. Hence, move the qcs8300 phy
compatibility entry into the list of PHYs that require six clocks.

As no compatible need the entry which require seven clocks, delete it.

Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
---
 .../bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml   | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
index 17fd6547d3b4..808d29da99f4 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
@@ -176,6 +176,7 @@ allOf:
           contains:
             enum:
               - qcom,qcs615-qmp-gen3x1-pcie-phy
+              - qcom,qcs8300-qmp-gen4x2-pcie-phy
               - qcom,sa8775p-qmp-gen4x2-pcie-phy
               - qcom,sa8775p-qmp-gen4x4-pcie-phy
               - qcom,sc8280xp-qmp-gen3x1-pcie-phy
@@ -193,19 +194,6 @@ allOf:
         clock-names:
           minItems: 6
 
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,qcs8300-qmp-gen4x2-pcie-phy
-    then:
-      properties:
-        clocks:
-          minItems: 7
-        clock-names:
-          minItems: 7
-
   - if:
       properties:
         compatible:
-- 
2.34.1


