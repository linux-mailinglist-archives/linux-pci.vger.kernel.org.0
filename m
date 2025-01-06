Return-Path: <linux-pci+bounces-19327-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3EEA021EC
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2025 10:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5B0F7A1C5E
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2025 09:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1537D1D9598;
	Mon,  6 Jan 2025 09:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IJpz3M34"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805891D8A08
	for <linux-pci@vger.kernel.org>; Mon,  6 Jan 2025 09:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736156016; cv=none; b=IsA56W1Y+qGOhHDF8dy4F/Kq+l/FY4p9Scx333WSj7QnD0QQGwmGOlpZ/wf5rMnb8D8mhcR8ehM0txBX7PD1Zb3NWz+mPPdIGjKeUy7JGPz0ulS6lfCrNXsSj7eBYkksJBbX1Ov6FEY5G3i+BFPPDErMBA+C92DqKrnAQ7W6g9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736156016; c=relaxed/simple;
	bh=u6ITWZK6Pnui8R/rp+fW3eZGVRboaltac30M06+tTJY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hj1Zi0SEsbcEwQjgLDV+pY5nBgCtkMim9z60bmab6MHn3I05BdO2zcmtIROzYpl9e/CCp9ydGuM42p7CLX10vDUPPArD8xlUxZjP/l/TaLNN/qbUypc7m7GRTXeEXxq8niDPcrspEV5pI20JJzOKn47K7Bqsr3ker45Kav/09fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IJpz3M34; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5063XiMH016536
	for <linux-pci@vger.kernel.org>; Mon, 6 Jan 2025 09:33:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Ooc8CaBX+hRHDY5DeK/hHvsWjudmqQEAdI9
	cWCPXiSU=; b=IJpz3M34yCiwp5zx/LTp3uU6muWxlExxrA73fpDOmFtdnnfKxZH
	ujwFw4wA7tbbuN/HcU9KO/j0Bian2erDSOh7uHcqa/FexMvDzTcnfPWQmwVj1YQG
	egmpeGb2kwhuhUdt0t12tQzxh1CGJPOl4qwfhLK9DPq2wxyYaNTY5lVUCGmpP2h2
	DekO4nXZrtWXQWYkWzu+DDOa5IIgf/X8MPPQ+04D8UFbCiwGBcL0j+hpBiDWgMED
	FJYlGTluvt+/4Sa9LIfuZ4wN4WgGX8rvIoLE/C9OHlnmNZOdK5BnQZ6A/tSFdvGV
	ppcEFvhwCeci6TkfD7z1qDy4SE+nzI6paWQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4407ck0pe3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 06 Jan 2025 09:33:33 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2163dc0f5dbso177142365ad.2
        for <linux-pci@vger.kernel.org>; Mon, 06 Jan 2025 01:33:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736156012; x=1736760812;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ooc8CaBX+hRHDY5DeK/hHvsWjudmqQEAdI9cWCPXiSU=;
        b=amquCWhvoqh9bdEkGdBicuvot39DFlDVwDg8GDpNcDZ34ny/kIEKRNL2yVpGR9Fm9z
         CQip8iPwuzGqCMAQp8UaVg30rMs53QgtlMYxzUil56Py6D9xzL259t9OOja6y7gt3Hwj
         8VJn3SsnzLshCB8WqSh51k95vAeepTepsSvNt41q4gE8Xk4OFrDZIBMkBM947pY6H+iu
         GrEhU5hNQmTNr0HSp+wL8qNNoh9pR5MryxN2lBx0HjUSK1vnMBm509IR1c2D/bBVB2RQ
         Xhb+1A5bdkE+s36buz4NMcALLlvMWK1/ujd++kV9yq7PHGTC1S3+MBPpqcPOROcF0ydY
         bloA==
X-Forwarded-Encrypted: i=1; AJvYcCXEcJdc1MqadIxGQ76P735kLM3sNLaXNAmYtdHJS+LxSZ1qZ3n3wnjBlOgZ8DkUci/jUxFKujkp0FU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn0UbV/087YHRWt2J+hgfjYeZBWXGWbsFT++LfRm90Oz8ZfbSi
	dcfVun66NKSag0YCONs46vjECiZGiN0pXPn6+vJvF4497Ee2SiM9oStDJlCqA0Am0YsXpRCxqxf
	SLYpM9NByb/+6umsgfrm7HutUBfVDNDZKAQdb5vHaBM0W7uYey4XQ02cTCJeOjONFj5o=
X-Gm-Gg: ASbGncvmPeSnMM231rjSL/FMAsZnAnjKcECR2ro6Y3hTHf/KRsPcS/pdHHx3kf3cfJd
	ooHORowHU/6DVef+9nGGpMA0zoCfKRanE13LVVsS61gRdiXkBneV25vLM/qIM30IjL74haFzrVc
	cHrI5zhcFkk7Vz+IsJVKabSv1E1bHj0zlo9i74FMtksLwovdXebdDXFXTIAkSN/UiTcRGTRsm0b
	Aaw0Y82Q/28pLZwMlY4FJF7M/s8e1xNq7x9pcs9Zq4kJ6lGnFJL/TC8rwzCeN0RCU0pz4DbuxV4
	sMqhbceAntl08dCn
X-Received: by 2002:a17:902:f685:b0:219:e4b0:4286 with SMTP id d9443c01a7336-219e6ebcabdmr705471555ad.29.1736156012421;
        Mon, 06 Jan 2025 01:33:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFgBkTe3UZfkvpcZzMY3x0JbZEG0gq0kNqGGbjEBJ5gyLmgAR+ikmyKbTEvWQACPEWxprKFPw==
X-Received: by 2002:a17:902:f685:b0:219:e4b0:4286 with SMTP id d9443c01a7336-219e6ebcabdmr705471305ad.29.1736156012068;
        Mon, 06 Jan 2025 01:33:32 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9f625csm281079085ad.208.2025.01.06.01.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 01:33:31 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
To: andersson@kernel.org, robh@kernel.org, dmitry.baryshkov@linaro.org,
        manivannan.sadhasivam@linaro.org, krzk@kernel.org, helgaas@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        lpieralisi@kernel.org, kw@linux.com, conor+dt@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree-spec@vger.kernel.org, quic_vbadigan@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH V1] schemas: pci: bridge: Document PCI L0s & L1 entry delay and nfts
Date: Mon,  6 Jan 2025 15:03:04 +0530
Message-Id: <20250106093304.604829-1-krishna.chundru@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: To8DfdXFIOUohEkTIA0Nhf98FQfJSL0m
X-Proofpoint-ORIG-GUID: To8DfdXFIOUohEkTIA0Nhf98FQfJSL0m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501060084

Some controllers and endpoints provide provision to program the entry
delays of L0s & L1 which will allow the link to enter L0s & L1 more
aggressively to save power.

As per PCIe spec 6 sec 4.2.5.6, the number of Fast Training Sequence (FTS)
can be programmed by the controllers or endpoints that is used for bit and
Symbol lock when transitioning from L0s to L0 based upon the PCIe data rate
FTS value can vary. So define a array for each data rate for nfts.

These values needs to be programmed before link training.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
- This change was suggested in this patch: https://lore.kernel.org/all/20241211060000.3vn3iumouggjcbva@thinkpad/
---
 dtschema/schemas/pci/pci-bus-common.yaml | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/dtschema/schemas/pci/pci-bus-common.yaml b/dtschema/schemas/pci/pci-bus-common.yaml
index 94b648f..f0655ba 100644
--- a/dtschema/schemas/pci/pci-bus-common.yaml
+++ b/dtschema/schemas/pci/pci-bus-common.yaml
@@ -128,6 +128,16 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     enum: [ 1, 2, 4, 8, 16, 32 ]
 
+  nfts:
+    description:
+      Number of Fast Training Sequence (FTS) used during L0s to L0 exit for bit
+      and Symbol lock.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 5
+    items:
+      maximum: 255
+
   reset-gpios:
     description: GPIO controlled connection to PERST# signal
     maxItems: 1
@@ -150,6 +160,12 @@ properties:
     description: Disables ASPM L0s capability
     type: boolean
 
+  aspm-l0s-entry-delay-ns:
+    description: Aspm l0s entry delay.
+
+  aspm-l1-entry-delay-ns:
+    description: Aspm l1 entry delay.
+
   vpcie12v-supply:
     description: 12v regulator phandle for the slot
 
-- 
2.34.1


