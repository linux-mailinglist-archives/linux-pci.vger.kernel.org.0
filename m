Return-Path: <linux-pci+bounces-28441-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 234C4AC4943
	for <lists+linux-pci@lfdr.de>; Tue, 27 May 2025 09:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B40AD173D6A
	for <lists+linux-pci@lfdr.de>; Tue, 27 May 2025 07:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DBB22618F;
	Tue, 27 May 2025 07:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="N2y3YyBO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8018225401;
	Tue, 27 May 2025 07:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748330457; cv=none; b=T0jYwKDtnoki6avZnAcE3R0hFOhHOr7zssR+Aln6e7EiDHdQVeSQGpTtLYoPmHLoryJTkcZePzp20jW0sTv3kbX7AwRcfXHM0u7H2QpmM1wcsGG74S7DyPKEfZIFVQCwIj+jtzQvJeLywa4bau64K82zwVpqkwgors+jfhSZ0XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748330457; c=relaxed/simple;
	bh=fRKEajYsrjEETd0CV9CF87Nd+bCIvmN7rl+y4Q2rXBw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mdrQVM3mh/vUiuJadOmqNcDo837wAVYUhnFpqUHe2LhWVIoOc0sT9D5hmQqGyaxmLzeAsyJulHQRqx8Rj2J+BJ9bu/6hK3OQtG8vxyHVVszJAQNWgMgu7JcSN+uLgkUbFWg/Dbf628Y/e+qs1u+64AiCexpYPQArjfCiLoSlGSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=N2y3YyBO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54QJLlDL024094;
	Tue, 27 May 2025 07:20:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Ko96WMYCjhf
	nkHlSLv3qudWFvcVqQt11yvW1BUhMEyg=; b=N2y3YyBOR7pA3z8cJ7kpgwh9k+6
	T13z6PGvYkGCkjwr+bLgrzH0jcCldtnqRPw6p0CRm8pf9/oI52SryIRCKxBwLm8J
	lnBi9ZnWDQeSZXvNshmDKGQS2oVyg9TA7rtflqwd3JLIDtpeLIZMmAULPzZ15R7c
	fqTGxy7LzdGqEh9vrD3oXI5URPvAD9hdJd5NC9FOrWf0Kdu8Bmb0bPed+Nq/F2wz
	aOeOJMhZSmfkcB96jyngWGjyH07q2pfJO9GeKsz+LTjbl1FIdtq5mHnxF1+iGwuI
	xZyC0l3J7ByD3ePMxSbQJBoEcU7WSsmnBqWojhyrj6cbAqdXtTjJLr1LEQQ==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46u5ejx066-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 May 2025 07:20:44 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 54R7HYCi006548;
	Tue, 27 May 2025 07:20:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 46u76kypeg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 May 2025 07:20:41 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54R7KfA9009571;
	Tue, 27 May 2025 07:20:41 GMT
Received: from cse-cd02-lnx.ap.qualcomm.com (cse-cd02-lnx.qualcomm.com [10.64.75.246])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 54R7KeZD009562
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 May 2025 07:20:41 +0000
Received: by cse-cd02-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id 6C97E34FE; Tue, 27 May 2025 15:20:39 +0800 (CST)
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
Subject: [PATCH v5 1/4] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Update pcie phy bindings for QCS615
Date: Tue, 27 May 2025 15:20:33 +0800
Message-Id: <20250527072036.3599076-2-quic_ziyuzhan@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250527072036.3599076-1-quic_ziyuzhan@quicinc.com>
References: <20250527072036.3599076-1-quic_ziyuzhan@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=GIgIEvNK c=1 sm=1 tr=0 ts=683567cd cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=oxzBFytuHnZbSq-PjLoA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: DAmQUjb8nCjNDyv7E_d6MHmk3jdmS8Ow
X-Proofpoint-GUID: DAmQUjb8nCjNDyv7E_d6MHmk3jdmS8Ow
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDA1OCBTYWx0ZWRfX2Vw67/31L07S
 O/jisUkQK7HjrS27fKcF4Xkq0M/ygjVbCGCmym6uFxD045OQtC0c7cI4rLylhp2rMwtbKF4B5Vp
 SgCCMK7WSMcK6AHIET3hohYFvmyWukm36/5lT6cm3Z2ld/ZLN53IQWUp4IF51VcpHQDysYCPxja
 zMBGMq3giKKikyhi1H0MI9HCHOSaKv8zwsR0OfupbSLencp8gImH6372gNr21RbWLkH2kTgJDQR
 uUV9rgVaAJi+1PNE1E3fcAB/b5kRmPg+J0ZmJBrmoR1CGdNkUq00WPFCDOMk1WUyPB+nGdBFW7f
 1eWtovFn5fJabFQRUfcDNwPdpWWlKaU+nxIqVStxHMoKR/krZ+eJRu8CfxsvJYbM9CGN2ku+Ghk
 Jd/qOnm/2DczePZVd+mnCg0tzzLOJaquMk/kyLW293rYfXCpwefNYQutLgtbvIO/pw5wknUb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_03,2025-05-26_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1011 lowpriorityscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 phishscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505270058

QCS615 pcie phy only use 5 clocks, which are aux, cfg_ahb, ref,
ref_gen, pipe. So move "qcom,qcs615-qmp-gen3x1-pcie-phy" compatible
from 6 clocks' list to 5 clocks' list.

Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
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


