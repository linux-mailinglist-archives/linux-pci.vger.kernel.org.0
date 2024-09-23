Return-Path: <linux-pci+bounces-13367-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EE797EBCA
	for <lists+linux-pci@lfdr.de>; Mon, 23 Sep 2024 14:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F1DF1F21ECF
	for <lists+linux-pci@lfdr.de>; Mon, 23 Sep 2024 12:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0617119924A;
	Mon, 23 Sep 2024 12:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="d8o5iZfT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DC980C0C;
	Mon, 23 Sep 2024 12:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727096259; cv=none; b=NpIdagBXnAKQGTGXj3+jfBrk4bdXT0x9VIlVbfG19kaCVLLcH0WZ3fb9B/xIoMpUpb8kDG2PjGty1AQKr433o5BDyd4wfJKLUO6eH4Q42f9YdlXltKY4arYGyGcNN9Ilyxv2om2ZlMg2jRRLc7OwfTEiUH5Ztlby1552wAEhfDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727096259; c=relaxed/simple;
	bh=YQM9aJ0gvjGWqUZvamoBA8pN6Un7ptWRrnsNZJkF9/4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C7lX4W4g4HGF8YFWj7GSK3DlOsIcjLQWLQr5bkdLi4HVilYOBq9e19Jzq4CIfswSbsRr4b9DBmkshgHhVIrEXESJi7WrYvlD2A9Ak4MjYr63c30Naz7E6paWbpLaPucKq9MQwOjBUZm/Xp8+LmC74ypOpvpQCmtqF5fGOcjhFmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=d8o5iZfT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48NB0Ila001351;
	Mon, 23 Sep 2024 12:57:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=fU1ljihyn/b
	Wb5BE9A3hbhtbiWjroef5/cEiofHz7LA=; b=d8o5iZfTUVe3XUH4N90L+5y0bVj
	reonr/Lllp7N4X0hzidIiu8ILOnrJZFyBlCYa0MdKVrh7ty8IoXxeCeZ5O9MQpOP
	EScIcdDKBpncScfaKBcT0NF+Gxqytr8BsrPBpLR7xLpTRcsIFRsNL0hlUd6HySw9
	BVqjs3Jg5JtKZQoht0Ixi+D9Jel9LGMPAendnLKt3Xh873XMEJ6bbz5zj9ILKovj
	moe4wLkRqlTfbbTJ4znXdE1G/eGCEwF1xoNfif2WIM/1MGy2HgWj+qhtA/owPXE/
	YMmMkxmizqrgHXc7LutKzUs8Rm9Jf+iNNyTMJ67hEL2V9Coaxdvf0qYsvQA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41sqakcmh8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Sep 2024 12:57:18 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA01.qualcomm.com [127.0.0.1])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 48NCrTAg028339;
	Mon, 23 Sep 2024 12:57:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 41sq7ktnb1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Sep 2024 12:57:17 +0000
Received: from NALASPPMTA01.qualcomm.com (NALASPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48NCvG5e001794;
	Mon, 23 Sep 2024 12:57:16 GMT
Received: from hu-devc-lv-u22-c.qualcomm.com (hu-qianyu-lv.qualcomm.com [10.81.25.114])
	by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 48NCvGwU001791
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Sep 2024 12:57:16 +0000
Received: by hu-devc-lv-u22-c.qualcomm.com (Postfix, from userid 4098150)
	id 7212865F; Mon, 23 Sep 2024 05:57:16 -0700 (PDT)
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
Subject: [PATCH v3 2/6] dt-bindings: PCI: qcom: Add OPP table for X1E80100
Date: Mon, 23 Sep 2024 05:57:09 -0700
Message-Id: <20240923125713.3411487-3-quic_qianyu@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240923125713.3411487-1-quic_qianyu@quicinc.com>
References: <20240923125713.3411487-1-quic_qianyu@quicinc.com>
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
X-Proofpoint-ORIG-GUID: TlkPX4tWXIndkgqDoxkDYI0AOnWBiM6m
X-Proofpoint-GUID: TlkPX4tWXIndkgqDoxkDYI0AOnWBiM6m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 suspectscore=0 phishscore=0 adultscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 mlxlogscore=970
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409230095

Add OPP table so that PCIe is able to adjust power domain performance
state and ICC peak bw according to PCIe gen speed and link width.

Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml
index 704c0f58eea5..3c6430fe9331 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml
@@ -78,6 +78,10 @@ properties:
     description: GPIO controlled connection to WAKE# signal
     maxItems: 1
 
+  operating-points-v2: true
+  opp-table:
+    type: object
+
 required:
   - reg
   - reg-names
-- 
2.34.1


