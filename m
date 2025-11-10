Return-Path: <linux-pci+bounces-40697-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80743C46463
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 12:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E59E1882878
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 11:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9E5308F0B;
	Mon, 10 Nov 2025 11:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ixtN1FZQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q5ucjBIy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB283090CD
	for <linux-pci@vger.kernel.org>; Mon, 10 Nov 2025 11:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762774199; cv=none; b=gKEgx0mCJIOMMG/dE+KmTHx4ETejWWMMsa/cWWoT/T2AfRj7tpXQoeF8smhLgARFoanngr7NgNPskXPP8aYhxnOPFBgfP5fa5GnTcq7ariQVJi5xdq5MRFloUSWReVT8wkW7l6Mp6LH2KwzdKnjCqLv2GNPsV/b+kQxEJowZ1hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762774199; c=relaxed/simple;
	bh=8xKXl25wfM0C8tmYM1yA2iBxK4BxYLRIBEfMfi+Dy30=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AJ07dHjFlaSs+VFOF8neH9ILYVelcK255cANgggUJtsY4rWR9bPTIgCglPnp3HgG0xGe5QmfVjuVFYVeAXWc/xPT5DoIqHKETxYN896ZCCOV4HZV8vVX6fGJf6t04eD4GY2/KCxQ7U+8EUgqkt0U2K326NUt7s0fjMZ+NplDPIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ixtN1FZQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q5ucjBIy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AA8smLW1811815
	for <linux-pci@vger.kernel.org>; Mon, 10 Nov 2025 11:29:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=RK0d/o3bcwg5PXWQDXV02fF9ZPl8toqvLuR
	sMtlyQo4=; b=ixtN1FZQAJHMPwAc01uqs4wXs0H2NPrIvY8jgwBT1IC/MI42zrS
	EySPF4VfV6VvnuppZoDvn8SYj/CLHOQEHdGikP3LILH2YVd+iGwH5jBdi1LNbJa4
	R8qSDGVn2gJGEXIZvHmXl7YEjOhi91C/kLbR07mbURjADZ4oHZE6GJJgGBlb5RAP
	40nEj/HtdFo5eAHLMACGAd2m57BZAX4wL84mOMRWSSPq68NRFJBL0RjC4SM01kAp
	a03rlmhiFwDjjuYesreFBdKMKEmRHIhivLkW7roFtS5Ia2SaDevJbmvjrK+FQwG7
	HPKm/dbu023TDPNthfwZJCeFADyt8Hr0Cdg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ab5m1hp5f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 10 Nov 2025 11:29:55 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-29555415c09so37223245ad.0
        for <linux-pci@vger.kernel.org>; Mon, 10 Nov 2025 03:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762774195; x=1763378995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RK0d/o3bcwg5PXWQDXV02fF9ZPl8toqvLuRsMtlyQo4=;
        b=Q5ucjBIyfj9KTXNZDDKgUS3eYU6eQSG9pRJLHfqr+24K4TgsUXxPbxsXa/xst69zcA
         AuI7QSFOYYpuDixTtA+RCNsCy3U/Cr7M6jl1nIrsSpW2k0btNnS18TsFv2WP99aR4hxV
         uReC/7v5hmRvsFuNulkWbJmQgEuNUsdTJEaejZGqbS4ERe2GpF4IOVBFeWmi30rjk0rV
         q9JCAl9zYsDQmISLn2JatCkjizpvaDMx1OfAwYyIiwA7bPeWifGldOpBQTGkCwOrm0dq
         DmDQQHcj4gRrZ5HmxqNXBpDxPEOdFVhsTfaN0w02T+lBf03Rnyt+n20mCy/UrzH2QaqZ
         iYtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762774195; x=1763378995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RK0d/o3bcwg5PXWQDXV02fF9ZPl8toqvLuRsMtlyQo4=;
        b=TFIZDK0rvNUvOYgFwb8Gc1EYDsdT8qeLhr/xqhMsteTeCu8r2rTTrn31gNcHnP4aaV
         ZlOb1teb3Myvmw+aFln+BIfaNz5ZzxdiDo/D+W+yE4I9Ctk2rv5iU/QeNF5SQXpafo48
         wv8xYbXwG46r/+T34gIkD/IMNRQTjVavjGitrH45H7X+nBKkk6sqpakN8uUFB0/YgW0L
         D7JCVxHfWcj/oxuteuUrxNbuluHSAmRRS9PwEo/8oAeiERE8eNjduECR+BYy+g4IMLc0
         aSWNQEt73iX8EMIxJjl+WmOtzyAY+V1ezxsT6VYRGKZx7xa5ZFKG2NHKDwX4cdeus1Pv
         sXKw==
X-Forwarded-Encrypted: i=1; AJvYcCUCQv3e3ydxTtslqlK1yVobx967BdklIsxivQo+DNbEPyjrUuiJLDyXwG4hdODgy/0uHPvI0/Pkq7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHWNjZXsbo3a70Yd0KgN2XsRJxpK4gaFWVtk7S7ASBW78XtgjS
	o0fZMQhvAkbhg+Ricgh4S6UR7i3fpksFMAcvqIOc56z2VnTC73kqzQ1kv5ibsc5taE9e0sNR5zv
	f/jJO8HDgJLtrpTnol0UYk8F713Qhg0aWBp1Uz2tyre/MMyQiDyM76I4h/o9vRVclOnr3z3g=
X-Gm-Gg: ASbGnctHsD9R6DDRJiE49sh5tATlUkH6b/lP7H/igYDK/ifuvfhMtfzG7J74gOPiA9o
	FoO4CnsMJ4ES7PO4W0s2L+4ILs5ks0RmiDyqTlk6IZzcdmvNqST99YLIpYMcauyHHxBGiMJ1dAH
	JNR9HCAOfG0t+fb7x/lrQrEWf51AkPMeiA3150+Zfl8lePWtRHXm7ARJ6gspQJhkZtvHNCLS/Tt
	kDOaCiJxWOQa55bPgIb/HyL+PYF+Cr1nq4NxFjYunrcS+5jpCGdFtVTk4pVmCj1r1P/p43tKT7o
	m1sKhy93wtGEKqjbel6DqyLzEyn92P/EwgShtviaRLXi73R6LXTx3O9cREDbY/YAdMg9QsbBLzP
	8CnstPn7Y+61PSBSLhIb0z3AMuBlL7Eztlw==
X-Received: by 2002:a17:903:3d0f:b0:297:e575:cc5d with SMTP id d9443c01a7336-297e575cd10mr97124375ad.35.1762774195068;
        Mon, 10 Nov 2025 03:29:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMG6ovmdfjX+JC8Me1fTeukl5fm1TgWV8TPUNLWMYD42ZI2p8Y10hF6Q+EdEn8pCXJX3XaOw==
X-Received: by 2002:a17:903:3d0f:b0:297:e575:cc5d with SMTP id d9443c01a7336-297e575cd10mr97124085ad.35.1762774194529;
        Mon, 10 Nov 2025 03:29:54 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651cd0ee9sm144165495ad.112.2025.11.10.03.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 03:29:54 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
To: andersson@kernel.org, robh@kernel.org, manivannan.sadhasivam@linaro.org,
        krzk@kernel.org, helgaas@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        lpieralisi@kernel.org, kw@linux.com, conor+dt@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree-spec@vger.kernel.org, quic_vbadigan@quicinc.com,
        krishna.chundru@oss.qualcomm.com
Subject: [PATCH v2] schemas: pci: Document PCIe T_POWER_ON
Date: Mon, 10 Nov 2025 16:59:47 +0530
Message-Id: <20251110112947.2071036-1-krishna.chundru@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDEwMCBTYWx0ZWRfXyy1jgHvSrQ1a
 yBTQzF0zLnX6HXd+CIRwgc0utBGMW5iCmjUyXIS/CtsEFbTakkacrOKfUlvHl7uLOgzOkd7ePnz
 vUZM1EJ9E0xw2A12jcQCafFaddoXobnAbwWVKwY4ywEZQJounuoE1D1oiBQhyX6cbSNjQhKQm18
 UJGrFEragfohQpp7OhUOH3fulpg3vBbojt853RCrOcUyemqGcu4E6pvVHC/JqLZv66nsP9t2gdE
 nUXuaQmZpGpgKQWidzpONaTYrsgDlivVLeIJH9fPgmHq6E9YbKp8I1LLUC0vPPdhXFBDJ7J3OpW
 +3i1Jv0QwkDBwgBNIZi1ed8RdMc8qy4Vg9/216CURmfh4vXvJaDvirDc5hjAKvUs7Xs1Jng+mQy
 iPCaom7aIHGC6opjfJxRihAmFw8Mog==
X-Authority-Analysis: v=2.4 cv=TsXrRTXh c=1 sm=1 tr=0 ts=6911ccb4 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=5_BQsOELN8wEIR4Ca7QA:9
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: rcePpvrz0VotQwsRw8gOlQSOkQ8H5Wfd
X-Proofpoint-GUID: rcePpvrz0VotQwsRw8gOlQSOkQ8H5Wfd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100100

From PCIe r6, sec 5.5.4 & Table 5-11 in sec 5.5.5 T_POWER_ON is the
minimum amount of time(in us) that each component must wait in L1.2.Exit
after sampling CLKREQ# asserted before actively driving the interface to
ensure no device is ever actively driving into an unpowered component and
these values are based on the components and AC coupling capacitors used
in the connection linking the two components.

This property should be used to indicate the T_POWER_ON for each Root Port.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Changes in v1:
- Updated the commiit text (Mani).
- Link to v1: https://lore.kernel.org/all/20251110112550.2070659-1-krishna.chundru@oss.qualcomm.com/#t

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


