Return-Path: <linux-pci+bounces-21556-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA0AA371A6
	for <lists+linux-pci@lfdr.de>; Sun, 16 Feb 2025 02:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1BFC16E7A1
	for <lists+linux-pci@lfdr.de>; Sun, 16 Feb 2025 01:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7295ACA6B;
	Sun, 16 Feb 2025 01:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lLGV0P/i"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFBFBA50
	for <linux-pci@vger.kernel.org>; Sun, 16 Feb 2025 01:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739670348; cv=none; b=Xdxta/6nF2gNYlFUNd6JLR0f54UQ61yZfbhjgzjEnnIdEWIMNpxVt2iAgnueXzab579ZgrRFHL3JnzdBQs0qPCB1Fqzi3OyXPsj5ui0PkRvFjoICOCS8ODe0kx57aMKKvz5m8d5VV005kxKO6YLBYUULpakQ/UkSdA8mnBy0QU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739670348; c=relaxed/simple;
	bh=BGcJQ3Ll6glAfMQXdp/lUcU5Vrse7Olu5opVqRzh+DE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=du8MPPrnLdT7gZMQWwLaKkRBdyXA79Fa6mLpG3Oca7UxCQU3h/Q2P5PRhf1xyWT0VnHDTSzAIc26QudUMXK4QI/8X18TjdEXQBTE5rD1qud1mVEA6kMW7c4dmOuLzC42i4oGv6tCe0mVKLV8g93dyzZVGFaMuxxB0qvDAwixxUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lLGV0P/i; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51G1Km74008341
	for <linux-pci@vger.kernel.org>; Sun, 16 Feb 2025 01:45:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=jPVONscn72E
	ctMrzq7jWfE2rC2sdmlOx+fZ773e4rMw=; b=lLGV0P/iKQys++M8x2cRh1fr0F+
	DT8hJ4pTVDTP7qL0hD+mHtNxFYiCla0zGqXc9Vn9e6eleDlTTw39JIX6NfhR+MBL
	m8K/eqypNXRtXJSibsSPu+AzYiCl0GyHMR+/Wb72LfKH1fn/ItDbAbH/n7wdhOpi
	K+NnjK84Rt13viM2rGlgedAM5c1HQLWi3suDnRkIikD8sRLkImarbVSd0h+cmIw1
	PYA1WFZgbjTH2J7Yugxx34v1xznI1s9mDFVGhNneTYAHqxmt3KmCAABzLAth7jom
	m3bBIWsKt4zMi/2bbzBeEzdjTMOzVSn+8mcKBnO54EfkX2IVXODcChXgiLw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44u46hr52n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sun, 16 Feb 2025 01:45:45 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-221063a808dso13011505ad.1
        for <linux-pci@vger.kernel.org>; Sat, 15 Feb 2025 17:45:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739670344; x=1740275144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jPVONscn72EctMrzq7jWfE2rC2sdmlOx+fZ773e4rMw=;
        b=q8x8oqWfFzA+rphkQpRNVWKdI8h/9/A/yRxLKSHFH6KbQqvn22kDfX33rHLp9VExyv
         Ra0d49uKqZtdO/jTELFwBGRR/QOWLLK3jzWlICzM69Dm8esLf+z1K+zspUA3yFuPtOj/
         VhhI39LO/47WZJ7rU+yVdbvzKK1+Cds6ykJKlafAQ3cvQjPbEPGHyOhIEIlriTNzp67O
         aV3mbBTvHLggOJD6jVhN+0BbxF6Sj2uyLnIwqFibOwGIv6ztvlhZNQaP9Pxy+tmqewgA
         KW3aqUQ9UFsEDou4JhaZNTUG0sxzR3zostLhvA3f6tVVqKGo3SVf9Q0zArNe1eX5rHDN
         Skog==
X-Forwarded-Encrypted: i=1; AJvYcCUDwgSFM/IE6wq2ERb5VrwOQcFACVuqZNL3wqh1x4d1UEB6cqBsGqHTOtdgtt5rns/KHx/X6Z0s0tc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkKTRNDGIo7PrqIJAzLC5EoHv9i/VXE7Z1mg/tquVPauyfJNbz
	LEfKBR7mLXks+2CnATrPkVvtaNh3Jz8MdJ2ar6hRYmG7CYVMzilp527xzxg30zIwtww9xxIn+Ix
	nFd/2tQ+69xtyFQ/L2rmb1h/FRgGQUswpNXPUp24T3rG4zQSpsUd57v38Jz0=
X-Gm-Gg: ASbGnctTz9nwvk5WFBv6ptWb1sGy+FN3pq6OvV0kt3UdrRcocH6030PhW1nKm05G86X
	NBMBmbx5K2NnBhHqtVWi5SbMeSXOJng4Udkbmk44bFoCpOTd/A5Wd8LLVmD1qbRVz9CgG+xA1Em
	7x95AUPNCA0KugZnmQm9mDyvVU/p3tw6jFHhwHtge3AJuA/D6jFkaaYzroG8SBT53ohzdM/sa6z
	ul0rIqlM9/bnHDLvyTVDPu0cxlNyvsA6O6CtGNFoz2hzeuNrqj4q3Taf1HXWdq8p/HIWvMOfM+v
	1imikhUQ9D82iTuTDraU7RCnHT2pwWn4KoCJVuX0
X-Received: by 2002:a17:902:e5d0:b0:215:89a0:416f with SMTP id d9443c01a7336-22104058b35mr58608925ad.30.1739670343814;
        Sat, 15 Feb 2025 17:45:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOZ+s1hML65+t/oMtnG25500NghTCO06Dip85+ffWni6ZFpcXj+VIoxImhNSiQ1ejvbPABEw==
X-Received: by 2002:a17:902:e5d0:b0:215:89a0:416f with SMTP id d9443c01a7336-22104058b35mr58608675ad.30.1739670343430;
        Sat, 15 Feb 2025 17:45:43 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d536455esm49896955ad.74.2025.02.15.17.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 17:45:42 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
To: andersson@kernel.org, robh@kernel.org, dmitry.baryshkov@linaro.org,
        manivannan.sadhasivam@linaro.org, krzk@kernel.org, helgaas@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        lpieralisi@kernel.org, kw@linux.com, conor+dt@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree-spec@vger.kernel.org, quic_vbadigan@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH V3 2/2] schemas: pci: bridge: Document PCIe N_FTS
Date: Sun, 16 Feb 2025 07:15:10 +0530
Message-Id: <20250216014510.3990613-3-krishna.chundru@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250216014510.3990613-1-krishna.chundru@oss.qualcomm.com>
References: <20250216014510.3990613-1-krishna.chundru@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: qq0pBwoo9EcVjv12rJbJDBLYyudRciFc
X-Proofpoint-GUID: qq0pBwoo9EcVjv12rJbJDBLYyudRciFc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-15_09,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 mlxlogscore=950 lowpriorityscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502160014

Per PCIe r6.0, sec 4.2.5.1, during Link training, a PCIe component
captures the N_FTS value it receives.  Per 4.2.5.6, when
transitioning the Link from L0s to L0, it must transmit N_FTS Fast
Training Sequences to enable the receiver to obtain bit and Symbol
lock.

Components may have device-specific ways to configure N_FTS values
to advertise during Link training.  Define an n_fts array with an
entry for each supported data rate.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 dtschema/schemas/pci/pci-bus-common.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/dtschema/schemas/pci/pci-bus-common.yaml b/dtschema/schemas/pci/pci-bus-common.yaml
index a9309af..ca97a00 100644
--- a/dtschema/schemas/pci/pci-bus-common.yaml
+++ b/dtschema/schemas/pci/pci-bus-common.yaml
@@ -128,6 +128,16 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     enum: [ 1, 2, 4, 8, 16, 32 ]
 
+  n-fts:
+    description:
+      The number of Fast Training Sequences (N_FTS) required by the
+      Receiver (this component) when transitioning the Link from L0s
+      to L0; advertised during initial Link training. Each entry in
+      the array specifies a PCIe data rate
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    minItems: 1
+    maxItems: 5
+
   reset-gpios:
     description: GPIO controlled connection to PERST# signal
     maxItems: 1
-- 
2.34.1


