Return-Path: <linux-pci+bounces-34443-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D1DB2F467
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 11:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 290DD1CE1B34
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 09:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB942F49F9;
	Thu, 21 Aug 2025 09:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UTZQF6JW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D762F1FC6
	for <linux-pci@vger.kernel.org>; Thu, 21 Aug 2025 09:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755769497; cv=none; b=o7XcFl5mkGMXc9mJ8dX7ncbLZMUj3otG5sU2QrxEQumyj8l6JRCOcDRgSu7EKkcN607XizltExTSJrrOX4LB907tfMAkq7Nw+bG91vIEtKTXSxi5aGKCJLwhOcTUqUYoNJcxPoaPM5s2QN+25BUm0okODNl2E6m+lbFs5IS2EWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755769497; c=relaxed/simple;
	bh=ekdA9CVOTz1DmJofPhYI0+HcBHPnLV+Txm+2ENdkrHs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FnHk3iAT9nT5RTDdKDIVIgEh/NSyaiPlQFFQVPSp3W3Q/A2/+zprgrJEEd92NpKKcbx9kv05B7hZHU7LkizgMC88n2LCJdC1clv/WGkuF6HcyjsEOSiYZCAmyzgXLn79H+MIzaslZj9lYPErFts4kCjzdcAv04q+voS33+NI43A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UTZQF6JW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L9bEuQ003729
	for <linux-pci@vger.kernel.org>; Thu, 21 Aug 2025 09:44:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x/mJfVjavIoqW9T/ceCVgzgHEhxIAMs4Ha+bWe4V2mM=; b=UTZQF6JWyKAbbNAO
	CEckhQ8WUH5jUPHMkOrnvg0Kb7HHZni+BbQNcdgkrXctZMn3aN9iou480xEw9wVc
	frbMySBIRbYIZK+aiMs9RTQn/l16HSwXoyB2dVFIFmxTymj/SDWzlb8HbZYktwMG
	sloO9nJnQIT5ju+mJGEWWY2AuEz81LXyeC14CPF6WWeJIZ8uyPV5E4MG7KYlF/1s
	RI8GfoD9LS2CD+HfsSEaudSs1pCqkfMURPD5/jUVfcjXPRxZ4c3oiyQmR2zfzjdS
	FRt1NMrLPp4ZqxWMMpQrZ5HT6bt45f+p4Av4gSbRBHBM+zVWFLu1vqQxSe1V1XT5
	+WLHtg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ngtdjsx9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 21 Aug 2025 09:44:54 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b47173ae6easo1458715a12.1
        for <linux-pci@vger.kernel.org>; Thu, 21 Aug 2025 02:44:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755769494; x=1756374294;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x/mJfVjavIoqW9T/ceCVgzgHEhxIAMs4Ha+bWe4V2mM=;
        b=tZowEIrWS+Sv7BrhEUBAPivknzfbnOs9Dq4anFklZ0zr5Fh6WwukBRjrnLT26Y4cck
         r9zoGaySf0P8N2/fxIBLN3jLs4j1RiA6TTmGiALg+gQ/mKPacAokaajpoft1Dmz0Ianj
         pIqGFZohpmqSxXIXtVF+PU5XIjMqL2LompokatibBEbYVPrX4tt7Ykp4+tIBt42FnZpV
         b8/RZMbkmrZfF5yQ1WgbA0S6JkD+qYn3Poe9GgnLESmYHvrzC+Ze3pWjq6Az1Woi4upV
         NOcHyCVBxQcbkvc7kNlGbR0NXMzrodhzRyqOjTAS2h79Lh4wraStaIp48AsDPz0iNG8y
         2U4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWXVCxz5o5ufdvqOzh5+hUCr6FvapwgwT1gRYAyULnZR4NvZK1ogBavEf/9SM2tKE7jD7J+Ed2sqS0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6xScW8oFM8DEZds7IBJ9pTgOHn+eN6SihX8YZ+q5JGJjJhG0P
	nHHehAhWkKP9GUPipGPKO6OvzZGQR0LFObH5LOkqGDa7rMshBT9LCiFJmUhDFk55HR01LsDrBMc
	JLJ9w3VoTmg1k51QQ9vNiWh3n1mxpoGqsMus9hD/D/X/Kw5MtJU0N08LXxs4UyBk=
X-Gm-Gg: ASbGnculpHcoLyLfulLCpf8IhhWhtN79moL5KnthT9xwSNv1jo1h30OwZHtDDcvxq6Z
	zafv0g5pJoEE2T74mpk8V/Jt5jEBoZVgIlsLG54fHDmLA0spo0pTNwKCi+d8CRn0B99WVOLFhe2
	GFVeVV1r+k4o+1ENy2mc7wHP0Z6dG+gcNldW1DEkj6nb6bjOd5QQ5GBQETvg0+ycOVk+GNyk0ZR
	wXL7WHomycrja9LvTNr3DqBMa8zoIvutFnIFjIIqIBGIJTd8tRdQ/zMvwmkMypNM005IDcR/7JQ
	uxmk6H9IG8t1ve4oqN1nhU0/z1keuw2dW8fMAgCZq1+0hYRCzJwY7mTNASUkhn4Fw1f72Q5Hjfy
	QmPTui/N5DHiY8B0=
X-Received: by 2002:a17:90b:3d08:b0:321:c2fb:bcca with SMTP id 98e67ed59e1d1-324ed0681cbmr2515841a91.3.1755769493911;
        Thu, 21 Aug 2025 02:44:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGN4QGoSOSkyHCDquqO4K7cRbMNAnFqN11llAdnPwRvafPdrmBPndjXdBnrgoZqS9H+rmNwvg==
X-Received: by 2002:a17:90b:3d08:b0:321:c2fb:bcca with SMTP id 98e67ed59e1d1-324ed0681cbmr2515809a91.3.1755769493384;
        Thu, 21 Aug 2025 02:44:53 -0700 (PDT)
Received: from hu-wenbyao-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-324f23d853esm1426078a91.6.2025.08.21.02.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 02:44:52 -0700 (PDT)
From: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
Date: Thu, 21 Aug 2025 02:44:29 -0700
Subject: [PATCH v2 2/4] dt-bindings: PCI: qcom: Document the Glymur PCIe
 Controller
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-glymur_pcie5-v2-2-cd516784ef20@oss.qualcomm.com>
References: <20250821-glymur_pcie5-v2-0-cd516784ef20@oss.qualcomm.com>
In-Reply-To: <20250821-glymur_pcie5-v2-0-cd516784ef20@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Wenbin Yao <wenbin.yao@oss.qualcomm.com>,
        konrad.dybcio@oss.qualcomm.com, qiang.yu@oss.qualcomm.com,
        Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755769489; l=1172;
 i=wenbin.yao@oss.qualcomm.com; s=20250806; h=from:subject:message-id;
 bh=jt6UG6eiIFzDb1oeF0pFhVGf3jfLG0hsOnnZ5HuEIJI=;
 b=iVAV8bG9k+1C7FYvQNu0ndV0BZQ3x7EFjTeiL0LohmKaBaK6d5AHjlrw1HUjekakwVBfWMLUH
 8CIuZ2ivKYeDQCdzm1zrXjBWXEQgZcZrjChM6VspFo0bMv8qJlyFeMk
X-Developer-Key: i=wenbin.yao@oss.qualcomm.com; a=ed25519;
 pk=nBPq+51QejLSupTaJoOMvgFbXSyRVCJexMZ+bUTG5KU=
X-Authority-Analysis: v=2.4 cv=LexlKjfi c=1 sm=1 tr=0 ts=68a6ea96 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=WgZgizuZlwTqGGW0kXsA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: GPnkH2V_RNufegbvMI7MVlcAg-V8jeX7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDEzNSBTYWx0ZWRfX4qr8ZMaEFKce
 ib8d7E4hJLgzyFsns3Mh77LTBFLGQBbVLGSsqQUlijpCW5CSPRqEZbh2b+azYK5SHkUqojIKHqt
 r4o9qbVt/xX87fG3HGIzp9bPFOMnOHavNRKQaRHcxdTrjjYhkt/GXefyWWVIJuizQJeNX+Z0G0F
 xUejLayGjJOrF2d7svaYGZ4bwSFhfTh6ectY6aJt09jkJSs1OAEHsEvWYRKKT9irLSTeOlYKiAB
 ZTPm7JUWgK1I8R0Be5phB4OTFVCXN3sQkhLFhhyZ8epoKRCVmKweXOhdldzN+fQqjlSlFdz0Oja
 W5YKq/EI10evZ4epPZGveJG+VxYSCoVKhhXfAhamaVMwAUlLHRTrK+cu5zLqvHhSjEIbY70Mepq
 pp5ijMgGPucECp33EYtdbpsMX120Tw==
X-Proofpoint-ORIG-GUID: GPnkH2V_RNufegbvMI7MVlcAg-V8jeX7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_02,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200135

From: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>

On the Qualcomm Glymur platform the PCIe host is compatible with the DWC
controller present on the X1E80100 platform. So document the PCIe
controllers found on Glymur and use the X1E80100 compatible string as a
fallback in the schema.

Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
Signed-off-by: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
index 257068a1826492a7071600d03ca0c99babb75bd9..8600f2c74cb81bcb924fa2035d992c3bd147db31 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
@@ -16,7 +16,12 @@ description:
 
 properties:
   compatible:
-    const: qcom,pcie-x1e80100
+    oneOf:
+      - const: qcom,pcie-x1e80100
+      - items:
+          - enum:
+              - qcom,glymur-pcie
+          - const: qcom,pcie-x1e80100
 
   reg:
     minItems: 6

-- 
2.34.1


