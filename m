Return-Path: <linux-pci+bounces-36509-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C56BBB89E63
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 16:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04F9D1CC2717
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 14:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBEF30E0C2;
	Fri, 19 Sep 2025 14:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CUjREkX7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A856E220F34
	for <linux-pci@vger.kernel.org>; Fri, 19 Sep 2025 14:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758291828; cv=none; b=t/li/TIyjtl5NBa1Ww7Uf4wGEcRpbNqcD6yuUBJnsewqlySSs5v7kbxOzVlt6NB1VmOU9Z1NikslC4r2l0bDCwFGU7kwVswrtH8d/ZTHRxlObKGOlP8jAEpuC4eB64vY+4ktxD1Q/T3LthLIyBAc3UohjvknpYkcnl/9F/wJG8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758291828; c=relaxed/simple;
	bh=WrctqBG5yal8gLgqGrzL6aanaaRl0HBq6tsGt6dAVGE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fPKM7LQ2xEKxhYzc3TNnpUnerAidYbB5vf03PiM8w9gwyAiapgjoBHYZSgA/odhpJ5UVw4iUAPPkcqbgDNTs2mRJewt2w/hEoQfTIkerGdr45twbymkzZgJbxF7mndEKMJ/5GXYmVXF8SqKqX9t9uEq4ovBmTAnzy5rVvMDTr1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CUjREkX7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58J6x2qn018235
	for <linux-pci@vger.kernel.org>; Fri, 19 Sep 2025 14:23:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=H0MOngd9nnOaMlhiVp3d7MqH4YoWgLyveqG
	b+3qi4Vc=; b=CUjREkX7e+91P4hZSHghPs8G3g49mWfx+bJA8NQAcxe5eKd0wmP
	G8dFbKIhCur0NciKhFAQMaPN5ry1OeyuvUZFqt6DqQxqACQjK5Oly2zW9LuHH2OD
	kJOIbySvNFsxAMol1MGiHnGoeA4PPk/vtGKQ1wqlOnQ4ySE2IFNtAejJzyYHdmtM
	+bu8HMH10Wv+JG2jux7sDsW53Sk/kKlXbTJUeNxUB3VxQTY1tmdbuxZmj5KTxwXV
	yrlrYvKmEXHwxak3PN8c4vtLa5LLisL7+W11gQowbqqIBsz66YT3i/U37/nXMUxW
	f5thC3XPz8Ugv+PE9VLq7p7BIWWLN3SAblQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxwjpbk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 19 Sep 2025 14:23:45 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-77ec1f25fedso846066b3a.0
        for <linux-pci@vger.kernel.org>; Fri, 19 Sep 2025 07:23:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758291825; x=1758896625;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H0MOngd9nnOaMlhiVp3d7MqH4YoWgLyveqGb+3qi4Vc=;
        b=ZwpFn3woIKtRdqXUXVeUQUkjsaFZSO+hqpSguO8MzODf0rhbJ4VEIPNPBo1HJkK3Ii
         xLDfAC+FeS/0Cd9IFZVkoIWGP57fMa9Fl56AVFPCvG1PXuZE0ClWL6EAB1JOR+fSoFvh
         jCFaHwgvQgoeR5m5X/oKZpkLfPR0cqRPKKFRD9DFBdPPV1laNS6wOd/YVu20OVek2dVU
         0Heyaa9wJIlXJUElhMH0dl9mwVwIO9zH6yN5WryEFkma/ZuGR4P/kP4iTWD147wNb027
         KtMdeGP/wXv64lRysxspaRvXhxIrthK7IBjC6eWdrTMvBvAsjOUCxCKKrcjlqUXGGgZg
         Xftg==
X-Forwarded-Encrypted: i=1; AJvYcCVZSt7zFl6wTOoQmLaORGiCBqRpn0p3B5uQNfW1zKS8Aoq0Kl5ly0OI9faVpjNdZhzz6rreUSjRyxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5aUy1OKv/cfaPIInxpuqsRg6xfftkQPGd74nBuHo66ecHQ/nF
	ncvqCvb6kwpBbQyLLsQlvI5Ca2aTVjNquDWF9QQIDeKQ38k/Vk6rZ78Wbg9v8bLFO3+AP5G5AvE
	SzGHYpaCtg7MxNeRPOOPyOIEGr4ZwV7RNtK9iGuIVke6NYhVA0xmjpEP7Vf08GC8=
X-Gm-Gg: ASbGnctyX+PH7ErhidJKlBDmAROuGLEBrVKxQKHqLil5zyWJzBVg+LVuHeNVgz0lVYn
	rMcHiHN0s3vyxc7/ct6PYV0QDvaPyQVyZ8XcuoVCpXNaxWnEb6+ENilJxsagncUrOII8iJEuigg
	WX1phcizVsEvz1pq/4StxG0cDyAXFAvCF4s406oF1nPfVOe5w22RMd1NO4KVe2hlLR1Aq+XnQCG
	Wx+RdlYaR5sYIKahpcU71+yHBgniXLeX2ly80dbqt3BuxlUibp/EJbdokpXUFZBI/D8Y6zBcMQB
	2h+nwFEYd6KSlPicLfnbQ71EdhvKKtT5wXFkfAqxVpdxp7qltupPxaXiHdJCLaBm09CHth9tizI
	ZGf7pJPJmfSdZRLYMGCjz7hbbtqqaihUpdvLiE03gl4pUUncFcStfsiPi22J/
X-Received: by 2002:a05:6a20:7485:b0:262:23dd:2e93 with SMTP id adf61e73a8af0-2923a323a25mr5577755637.0.1758291824899;
        Fri, 19 Sep 2025 07:23:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsFVhcjm0X3oNhORINQVqZ5ZFstDem6nqXS91CKPxgvJ43nQqgJn2edyW48rEB6IkCNBZ2ng==
X-Received: by 2002:a05:6a20:7485:b0:262:23dd:2e93 with SMTP id adf61e73a8af0-2923a323a25mr5577720637.0.1758291824430;
        Fri, 19 Sep 2025 07:23:44 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f097b60e7sm1335147b3a.1.2025.09.19.07.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 07:23:44 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
To: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
        mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: PCI: qcom,pcie-x1e80100: Set clocks minItems for the fifth Glymur PCIe Controller
Date: Fri, 19 Sep 2025 19:53:25 +0530
Message-Id: <20250919142325.1090059-1-pankaj.patil@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=HbIUTjE8 c=1 sm=1 tr=0 ts=68cd6771 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=UB6fr0ZYtwJW8fNbdQgA:9
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX92hAvvor+V/E
 pCBa/ajamJyRN7TvbzfAzP8+F5EyWnJw7OIs7xaCMyCVp1spEwfMMw20+sKn6sVsLj0aoK7Okoh
 g7i4E8/KKkXwloo96uuyk/7Nk/Dp6mi7nS+5KUjZWu5ZbVCGxg+5v09PTxNFJZVZWVeWU1o6Y1z
 //iK+doRoITMTRW9xvLCp3eGA95zi8kPQvEw/OlPEnnYQ5xxGEyiEi+oiz95VLycYPGJeMLuTt/
 6VJPUxiCGu2uvSG0CBMzSyWgjL0oj2vsWK9dULR2umS6LmT01a2E6Q6NvujCQxhOSaQ/INH2bp8
 0fEQS1R7YIS8L5IVGlD2R13cUgQrcpWOfSZZUop3GCbZO3BO8vk4WjOWlim1LaE3aILidGKIeCp
 wAwJ+TOO
X-Proofpoint-GUID: fdVcy3vjJpsFhpJraYJ7yv1NONb9D_mL
X-Proofpoint-ORIG-GUID: fdVcy3vjJpsFhpJraYJ7yv1NONb9D_mL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1011
 adultscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202

From: Qiang Yu <qiang.yu@oss.qualcomm.com>

On the Qualcomm Glymur platform, the fifth PCIe host is compatible with
the DWC controller present on the X1E80100 platform, but does not have
cnoc_sf_axi clock. Hence, set minItems of clocks and clock-names to six.

Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
index 257068a18264..61581ffbfb24 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
@@ -32,10 +32,11 @@ properties:
       - const: mhi # MHI registers
 
   clocks:
-    minItems: 7
+    minItems: 6
     maxItems: 7
 
   clock-names:
+    minItems: 6
     items:
       - const: aux # Auxiliary clock
       - const: cfg # Configuration clock
-- 
2.34.1


