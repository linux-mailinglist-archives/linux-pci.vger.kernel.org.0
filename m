Return-Path: <linux-pci+bounces-31237-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 985FCAF1217
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 12:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02AF23B0B7A
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 10:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835232620E8;
	Wed,  2 Jul 2025 10:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YAxhc/1L"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FAC25E827;
	Wed,  2 Jul 2025 10:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751452583; cv=none; b=Qg5DKmr25+93nlyIYbWYgoFTSA+2JPYj9yTxe7v4fqp62uVOjskGDvhpXmBFIEJuuqkj7+2fd/wlXlW6GQCZLK5gQx+Z3tJjQ1ECNyNEjB5Zw1hpe7oGcTvkHLBTJJgiIa8csARWnuzSoyDnuny4QYVZEB7nIPh9bobEtWZ2GQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751452583; c=relaxed/simple;
	bh=khidGApjcJ8Xiu3uCZ7p7c2a4xDg0ZVGOaMRzpCHpq4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HR4BIkIdhMQP2eqbPFdDLIyYufvgqX95d8Eu85N0I21GHiAxMsfMKl5zkuaxXhO+pNB9ldS368WKlHm7v3H5PEX9dSzbt+KD2YwRrCuaOTGIEl272PsQpkw2xCVWRydEMmh4hMEAzWsM7i9nhwaOfwaohMPpfyYppVjUcODaT5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YAxhc/1L; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56299JtG017317;
	Wed, 2 Jul 2025 10:36:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=o7utUeczvK0
	iTyiz28D4DBzZsY7OZcPEf0WmYvXyA3s=; b=YAxhc/1Lrb8edf2k/7KJ0ZfwkGq
	d55nW2M7Y4jBpgN7J25JFtBCugBVqSk40sd5uZ1ds1iNFwXgUPOIMGBt/+vQeu3C
	Alz4b67M7AY3URj5QFp9QgGzuU4ANPxrjiWBrGTLUkubiU4ewS+pPqavs1CSPCU0
	T4itU4Fi/o/2c59Mo6vT+j09r76RSdaHTS79lsIvkH9gWL/tYIZJ11/ne+trDfca
	bV8eFd57f3d9YC3l996rMqE4pELjPpnEQ58w6GyG67kxst0lpirmxLVXb4rVVpUA
	fBQM0O4HJK0AelPh7Ne7KMGi3kUnJV3rRphH2PR2ZJIjuY0SqEP8FeTRlYQ==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j7bvv87m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Jul 2025 10:36:08 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 562Aa6kk012331;
	Wed, 2 Jul 2025 10:36:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 47j9fmbe7k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Jul 2025 10:36:06 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 562Aa5sU012320;
	Wed, 2 Jul 2025 10:36:05 GMT
Received: from cse-cd02-lnx.ap.qualcomm.com (cse-cd02-lnx.qualcomm.com [10.64.75.246])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 562Aa4nR012314
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Jul 2025 10:36:05 +0000
Received: by cse-cd02-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id B69993925; Wed,  2 Jul 2025 18:36:03 +0800 (CST)
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
Subject: [PATCH v7 1/3] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Update pcie phy bindings for QCS615
Date: Wed,  2 Jul 2025 18:35:47 +0800
Message-Id: <20250702103549.712039-2-ziyue.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250702103549.712039-1-ziyue.zhang@oss.qualcomm.com>
References: <20250702103549.712039-1-ziyue.zhang@oss.qualcomm.com>
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
X-Proofpoint-GUID: HfhnfzPp9ps_BxzUoknrwg8tJku2oj03
X-Authority-Analysis: v=2.4 cv=RJCzH5i+ c=1 sm=1 tr=0 ts=68650b98 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=XqIMY1A3X6HU7J4rX2wA:9
X-Proofpoint-ORIG-GUID: HfhnfzPp9ps_BxzUoknrwg8tJku2oj03
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDA4NiBTYWx0ZWRfX4yU3o7M+A1fM
 aWTR2AyWyxt5lNVBKxd48Q0WU7hbf7MRboTwCij6G1FQkZGcoOIqN2e5qrb/4hYB+jXXETRRE6m
 ZvfIAC7L1wBGTiLm1aDBjBtSNgVcHZfjWLrMvygwKobdOeXCXdcv7o9Rk8dM7XHsXe+58x+2OtP
 Wi60ZmnbpqQFBYqahurAg7p2WIYZEDIQQCWL8cBe3iBaL1LKbTjkEJT6ku1AIBHAgLcTottjjhc
 uRXzDH2IIu4C7k6SAN1XVaA3gK1ZzvNejJBRTIf7k1bWZ645pAMoUVydnuyvvp6ulBl0bYFYqpf
 sk4hm4QrIhvEeoW/ZLaKh9uoVFxAuqUc/yJrBkmcvCRVgRMuDhqo+EfKxQH/vfXZJazhQvDB5Zn
 M2MoPfifpjV3TX0vBG13aEmj1W1klDzD6TT44Hng5v/o/m5ix0LECMqFZcYm8akXjiAp6lio
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=999 adultscore=0
 malwarescore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507020086

QCS615 pcie phy only use 5 clocks, which are aux, cfg_ahb, ref,
ref_gen, pipe. So move "qcom,qcs615-qmp-gen3x1-pcie-phy" compatible
from 6 clocks' list to 5 clocks' list.

Fixes: 1e889f2bd837 (dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Document the QCS615 QMP PCIe PHY Gen3 x1)
Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
---
 .../devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml     | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
index 2c6c9296e4c0..a1ae8c7988c8 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
@@ -145,6 +145,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,qcs615-qmp-gen3x1-pcie-phy
               - qcom,sar2130p-qmp-gen3x2-pcie-phy
               - qcom,sc8180x-qmp-pcie-phy
               - qcom,sdm845-qhp-pcie-phy
@@ -175,7 +176,6 @@ allOf:
         compatible:
           contains:
             enum:
-              - qcom,qcs615-qmp-gen3x1-pcie-phy
               - qcom,sc8280xp-qmp-gen3x1-pcie-phy
               - qcom,sc8280xp-qmp-gen3x2-pcie-phy
               - qcom,sc8280xp-qmp-gen3x4-pcie-phy
-- 
2.34.1


