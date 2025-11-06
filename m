Return-Path: <linux-pci+bounces-40495-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDC7C3AA15
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 12:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 087341A4794A
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 11:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD520308F18;
	Thu,  6 Nov 2025 11:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cWTKpl7u";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NXNvkOsV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5B430EF6B
	for <linux-pci@vger.kernel.org>; Thu,  6 Nov 2025 11:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762429211; cv=none; b=Ac+OOZjY3FQJPiwkpE9AVPnuACF+SQYRE7TRbZ4dgTa8f0P/c3BC4jcLYWWtE7VygcI3o54od3uOxdzfhyx9FXfb65duaDwYB0O87ZQggsDSSZgC9puM2bnaV60kC1zWQMmXfublNHdJWtYrCbMq6ctp21vJRr19lH5APE2jI1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762429211; c=relaxed/simple;
	bh=IATc/BWe25FDjleFlTjelCzWKgHVZ0FKWD/Y6NACOW4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eAWY53swMz7YTsTKtc+CrgI0X8i5iE7y+0Bye7PxBKkNFU18eX5vqPscJNo6eLKAPdZf0XxP4b/jcJo6yqlhOTI5ixbyaIXjmbJ/fNWF6t6LY5yK3hJuC2H9mBbEKTGEpyuO6QyOQM/F4r6lf3T+c+1WbB5SYwIC8YXMOxlT3jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cWTKpl7u; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NXNvkOsV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A66OHLK1739040
	for <linux-pci@vger.kernel.org>; Thu, 6 Nov 2025 11:40:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=tplQaWj0LuJZs5gP92aThpV6BCVGBwjEo2F
	RoetI/a8=; b=cWTKpl7uylAE8ZSH5FJ6mBudAt0nW7lIfwlu+/eq9Jl3Kx70dXK
	5eQ73Ft+MOj029II1odW+3dgDdvD4MNQoLUK3vIbGNKutb/OuR8qY5e42ZUWXVq9
	QbCNJrKY/DfXLgN9jhAgqW1TOPQYaOQZvK46KOLFjMqKms1QGTUspJCXPyKxSD81
	hZ2NpHmiIg/zNshlr5VsCSQ0A1LghJCSL6McpT28ec4bTraP60Ixx2XkelArVOB7
	O3ujdxHZ+Tm6FoSceP/5PnvxMykV5aMP793EyCRTFm+MqqaC1RkgMBGOQSzDYMva
	zM86jigHaLh4DCDG7nRUWDPsq1HIqA+Dpgw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8an3twsa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 06 Nov 2025 11:40:09 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7aff2f41d18so1618792b3a.1
        for <linux-pci@vger.kernel.org>; Thu, 06 Nov 2025 03:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762429209; x=1763034009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tplQaWj0LuJZs5gP92aThpV6BCVGBwjEo2FRoetI/a8=;
        b=NXNvkOsVcdaob3HO5ImMNb9zm1poy4IUR2dcQBvh13pH3AqHyEwSPkOCNDX8gyLqDv
         QSEEq5+bDbkoA+O3QSiWzKKfdEg0v3eCqhYXzJQRoQLCIqm+b6FNj69VTtIyiT5jYWgy
         6AnEamsWrPFPCuRo1wwe+d4S8XNTGHmBdihVcUf1fgSMLLuWL5Q0BeQ0n50NaRHkUE68
         eAr13vMRJMxaOkxa8NkX3qJA1lfiFi4VtzbPeiEsdA+VWJAdUQ3EAUveiBxF63UXxYPD
         7rrv9pyt3RFSsrZDNzwAKIup5ednd5MenWQ69n5VPRbZP0KkxQeOUQDSemNmbYk92oP1
         N2Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762429209; x=1763034009;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tplQaWj0LuJZs5gP92aThpV6BCVGBwjEo2FRoetI/a8=;
        b=a1E0y2Otx8QzrlQgkjNdJeSj5csNPG3Wytm4vPIPo/O/jQHf2AMtwdQP6xnQC7Wlo2
         6bCn/Ef1oyf8vH9kqaMpWyF2R6+oWEB7cccy8dh4UC/vjaCspJPvpKUjNNxZIWpKjzDo
         V8eayMhov7iZEeXQ+QhahZVvWalIwy2YUMocDan8ovUKoFSJNez6ZYN6FLyjttoENmGR
         EqipLYzv0JTziB+c+ZjnozZ02N1E0CHUzf/yuZHu2JLyyUbGVzvoMcCcRI/daVSnwVJi
         blXS5rd5V2b9bczBwLnE2Kzg+xJPicMq2XQZSEUXHD9nuSnD8VlyeGwZc9ZE9nCIrXPg
         mNZQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6er7ue4JLyQXbvObRoTqQ6N28ZrMPiWB8QsFDcL1SLdkIoYn1QoN7votkDFMpeU9m27BV72Y/G9g=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt6s5+lGudUsLs18RjMA4c0a057F2w7Q/qMWTNahBaXLkoLR7g
	OT0gqgi10S+LQ3qPjgYLcOcUbyzyAlZ42D8+WCqFDqKAPEc84ybebANG+ngmy7Up+M0u8tFqznk
	rY6KM9AyuhMknFgFCU3RpVoeFlAF+gxa9cP+lo94CvRsSXvjAfh+EglDLSrwezX0=
X-Gm-Gg: ASbGncs02M9FnxHrlGp1UnEv1tP8iJ1rgvjTs6L0eZDJflboIOJX4MFIj+Lt1jkRqK+
	lGc5ppR9j3YwzkLf6QxAOU3nuSyV/xVlkSJA89JMN168NIDGCYpAJN4gUeUwryPVvpvonDUG/Wu
	+pOxt5EG05mruW0XmGWhfIvykeyTmEmUDSlTK0vjlK/zCh37tE+wbGgYdUe+PlLDrj6dWeplzKE
	prb1rsUe4/BU/heIo3EzpzNptt3wyOS1v5l1OZ1/I5/8udxFOR4++jX3+DVOpAA51dIbPeUxOF9
	9tojYerbHQFmGFccrfAFLl7hExCegnYV5T7Czi02hoNLToVOYOh4IZH1OEmpUotTErB0CJ0SNRq
	o2gWK/F3bhYMBzG7BKubz19pio54YSBMwAA==
X-Received: by 2002:a05:6a00:2d16:b0:7aa:4f1d:c458 with SMTP id d2e1a72fcca58-7ae1eda0230mr8572489b3a.19.1762429208688;
        Thu, 06 Nov 2025 03:40:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEVUotlLDMkntNYYi4mBj3e7/x6lXZl4DxAaQeDTqWGqpoOiGkfaB2MP1zjb/rE3tBpq3DVJA==
X-Received: by 2002:a05:6a00:2d16:b0:7aa:4f1d:c458 with SMTP id d2e1a72fcca58-7ae1eda0230mr8572448b3a.19.1762429208107;
        Thu, 06 Nov 2025 03:40:08 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7af822041d1sm2480040b3a.37.2025.11.06.03.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 03:40:07 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
To: andersson@kernel.org, robh@kernel.org, manivannan.sadhasivam@linaro.org,
        krzk@kernel.org, helgaas@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        lpieralisi@kernel.org, kw@linux.com, conor+dt@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree-spec@vger.kernel.org, quic_vbadigan@quicinc.com,
        krishna.chundru@oss.qualcomm.com
Subject: [PATCH] schemas: pci: Document PCIe T_POWER_ON
Date: Thu,  6 Nov 2025 17:09:51 +0530
Message-Id: <20251106113951.844312-1-krishna.chundru@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=W981lBWk c=1 sm=1 tr=0 ts=690c8919 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=fqsP0TYi9zmme8frg18A:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: HTBLELICuIE6H3r43rRWpGU6x_O5-Iem
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDA5MSBTYWx0ZWRfXzSIQwqVorpBy
 RuvvJNUOuVXYazpsA68J8z7KaJViz1VZHjuQyiEdCkP8EE3oBIkIxndrVC0uAQqFYvFpcFPRIRR
 1p5FWv7fPre2vZwhWu3i4TBWeSMAh72qkAHJs4vftH/fIlZa+OCFlyNft6cQIQM12NhVAX6RaQS
 XpFTng95dDcrAbSC3SV5B96v32NTXzSX0aJRI7VLTa/ASSI93ZD70DvOk5WpuPktJmwuzXVDwnl
 Bzeg73t1yAhO4dtCzCW2PpZra5kmaE7h92NZhQ5mGox0pHUcVAD2rD/pV0IA8CrvLfbW38mIdFN
 wmFkbaPT2sx8kY0EUgwngt4M9qoTax1uw6M5Z0PRnLl/K49ptIVi18iLE5uLLTdO9g/ZhMh8RAm
 jiWJfRBKq07i4H67c+6ik5ZnCik1Qg==
X-Proofpoint-ORIG-GUID: HTBLELICuIE6H3r43rRWpGU6x_O5-Iem
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 impostorscore=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511060091

From PCIe r6, sec 5.5.4 & sec 5.5.5 T POWER_ON is the minimum amount
of time that each component must wait in L1.2.Exit after sampling CLKREQ#
asserted before actively driving the interface to ensure no device is ever
actively driving into an unpowered component and these values are based on
the components and AC coupling capacitors used in the connection linking
the two components.

Certain controllers may need to program this before enumeration, such
controllers can use this property to program it.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 dtschema/schemas/pci/pci-bus-common.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/dtschema/schemas/pci/pci-bus-common.yaml b/dtschema/schemas/pci/pci-bus-common.yaml
index 5257339..bbe5510 100644
--- a/dtschema/schemas/pci/pci-bus-common.yaml
+++ b/dtschema/schemas/pci/pci-bus-common.yaml
@@ -152,6 +152,15 @@ properties:
       This property is invalid in host bridge nodes.
     maxItems: 1
 
+  t-power-on-us:
+    description:
+      The minimum amount of time that each component must wait in
+      L1.2.Exit after sampling CLKREQ# asserted before actively driving
+      the interface to ensure no device is ever actively driving into an
+      unpowered component. This value is based on the components and AC
+      coupling capacitors used in the connection linking the two
+      components(PCIe r6.0, sec 5.5.4).
+
   supports-clkreq:
     description:
       If present this property specifies that CLKREQ signal routing exists from
-- 
2.34.1


