Return-Path: <linux-pci+bounces-40696-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42AD4C46400
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 12:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 299951894F4E
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 11:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CEC73074AF;
	Mon, 10 Nov 2025 11:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g9QEI04n";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RaQFylHM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB93309EF2
	for <linux-pci@vger.kernel.org>; Mon, 10 Nov 2025 11:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762773963; cv=none; b=MjACNok7O1Vgx9dXuPz7Fmn/JDNwrzVHg6olAT0g7Bn8toKIr4wf8R/NdepNTROSZFUQXeGg2a5LR+/qnOgeWS44paJMtQ+QpcCEvkCoBlBQbk9PzoVwro8Ig5IniV99d7NprRx5qEOc8+4SXuLggNizphF/kxv4nqgspfJW43o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762773963; c=relaxed/simple;
	bh=65t2YV+u7nGpYrt6fCSvmlRZmwzvXuDTZ/2KGVhOeLA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m0JRVbjk1elh9Q25A1IXpJZWVE0vjwMWQpYrYK7nFUh0QfTrXYx09mMpiBs14/ZsB76MkeyguaNpScJAG3UcTiot0Gs/Z5/sUzca5+e5o1heoert80sv0x/1rDDYkBvgLdah4do7Addi7BXA7j2vTebEyfr1N8YlJzIS43TUdQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g9QEI04n; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RaQFylHM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AA8mTvm1853200
	for <linux-pci@vger.kernel.org>; Mon, 10 Nov 2025 11:26:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=II41ff+SvutXHXTwYhbHZQEKHES6u7sCKND
	PZnxgk60=; b=g9QEI04nMslElKThs5IT5iFCdHXRXmTFi0jIdr+CdUz1zc8fbhm
	4uUu7nLhawiyRTfFpndcYlKiaBRhBZ+G3b2uHFRBwnEe4aLX7FR7q9sc4irqTbEL
	YkMLmnVCpCZsLHpIYQuEqM69avcRvUmaAsIl99aXveBld15/ZR4WZpwlQij1qOJb
	o3yDRVXz2M5m7a7YUA8rSoc0jQnInd0afah6xSapYZhccL3Za7nx03Wpv+4OcIQU
	VAhIZa6sZtUgrjngFyyVmygqP3r4KpQQA6JGjJp2RTcHNNBSnh07Lh18D4KMPiah
	3ojKghYzmD5TAIQyA9lfY9tuCYCPHcyqHuQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9xuemgxb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 10 Nov 2025 11:26:00 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3436d81a532so4463986a91.3
        for <linux-pci@vger.kernel.org>; Mon, 10 Nov 2025 03:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762773959; x=1763378759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=II41ff+SvutXHXTwYhbHZQEKHES6u7sCKNDPZnxgk60=;
        b=RaQFylHMAz9d0lTigmcBfU59WHFQE+0YnV3QtNm15KxnDMQyXlcKBcy5FnohH7UP0K
         CcTYNntwQLNGnv0ZX+0jwIpZ5QSGPXjNXi/yGxyn6uP8a53I7YXm7q4ERF8QhInYw4Hy
         q/fvoFgndFNGSaFFi89E84shWGSBcTDEAWJRhVg7oODPK4QQ5KVZ47qh3IDol4LIV9Y2
         aLDS66l3CL2IbkHpk/YbUZpSrnXZNMJFXspohRvJ1aWvwt4CnaejMbNt8dTdRm1p6Dtl
         484V1tT3QnvwQRyDjBV+Ye+pOizfAs6mvrDnZzvfBEagRJdY3GEvgbDBMn7GR7N0Uo2g
         8q8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762773959; x=1763378759;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=II41ff+SvutXHXTwYhbHZQEKHES6u7sCKNDPZnxgk60=;
        b=iTler6q6YB4PvCE89BI2T2qWBWlFOrR02xCFlqH0xNJfU9+S5Hz4y9coHLHTev84wi
         WhFkqAQWoMN3B+wmR5IXK/nBXBgjEVUPW3cE0uM1wKSMe1D9sjBNXQgBXQhWSKd6lroK
         R/bPoK6ROeG7Kw1jjRmS6ZxIfrrrxMQLqTqHOJ8T69BBC4XmakjEYwVXn41TWZjXfTAh
         xn6PotHS3f6WyaFrgI0lz6wjbSkjIRdhEnLeb0/bzS+ZUsMNUKZvR6COW78ja+HJeazZ
         WnWhXpjRf7AoYQpfc6lNl8o6SIz/mgIHULAM2YUb60d8Sq5AC6lbkYtSyvrPpWmTQfIu
         YC0A==
X-Forwarded-Encrypted: i=1; AJvYcCXPZt9v5OP2YQpAG38CbPurdd3OVQM2CyfDDfe5u3KdLz6Zdj/tfxI4d/jwCThFFmy0mLlgSyc3X0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaoADwWAfL4/1ZBa+iAC0jIHfIw2W3Ie/sVjuMBV/PaQc1Mzu1
	Vt+klaCs5hY74U5JRijuoyqfQsfU7wsOgnuKIA57X9qUOLQzkrutHZFQZ1MwpdzYzeXCFIDlAjG
	6k/UbTKRiBeckronB+tqzAa7aoR/czOHPxg/flBQPYx21lN9kPt9z9ZK5/PeeFhc=
X-Gm-Gg: ASbGncvH6GpcOljWv1TiCIV81cNBNLnyu9Yg74ACyPLHwsR2ziiAguIyANEvYEKlYpL
	jdLvWyTOmVVnEaF5nRhvX0GNSdVtCSmcCX/zBPpbGxPIIGKYukcm7lUCSm++KjsoVybAYNtpJPH
	ropG37QeXMW8IZufFazh7B5laYqzznx/+eCwPBLIkHxYhh8t8PB8KMpD8seSB1v9SVjpSw6OUHB
	7Uu28z03oipn7owI8hScKta9JYtsruFMoWnSUsrXNzxUzC1LurS+NgsIol/0ho4Y8vNjmRaZKwf
	EsH7qGsun/kg1Ahep1/3+zymuwkdG0X63gmnqpslu6N2FmTEqwr4Q+WruOhpTNelLwWMdu2GHDQ
	a5sjGXE+17BX6V6ZqtwHNx7JI2UbRiCJtmA==
X-Received: by 2002:a17:90a:ac08:b0:343:7f04:79c1 with SMTP id 98e67ed59e1d1-3437f047a07mr5788234a91.9.1762773959352;
        Mon, 10 Nov 2025 03:25:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxlrDc8N4hRHSZZ3POhzWZIEuLZPkwIs1KhS+IqqAGFvhrS/Uv1cDfw09eZ649n2HqNb51ZQ==
X-Received: by 2002:a17:90a:ac08:b0:343:7f04:79c1 with SMTP id 98e67ed59e1d1-3437f047a07mr5788208a91.9.1762773958832;
        Mon, 10 Nov 2025 03:25:58 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3434c30bffesm10390114a91.6.2025.11.10.03.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 03:25:58 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
To: andersson@kernel.org, robh@kernel.org, manivannan.sadhasivam@linaro.org,
        krzk@kernel.org, helgaas@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        lpieralisi@kernel.org, kw@linux.com, conor+dt@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree-spec@vger.kernel.org, quic_vbadigan@quicinc.com,
        krishna.chundru@oss.qualcomm.com
Subject: [PATCH] schemas: pci: Document PCIe T_POWER_ON
Date: Mon, 10 Nov 2025 16:55:50 +0530
Message-Id: <20251110112550.2070659-1-krishna.chundru@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDA5OSBTYWx0ZWRfX4upnEx6U3HEd
 02KmaZJ4e7qnIPic8HtbNtYV6VAq++dbp+L/BOEixqgGcX1mEBV3xIvfyg+uZ3tpS4JESvbv8qk
 xnjn+w2YAjvUURXfklASJR/XlJu6DsNcOKi0eGj4FvVjuli2NvrYoXpkD7EiPqXSWcnEEpEwfDv
 AOuXmUWATVwkqXbl1KrHycwAvrBtCnkvQhxrPyqxgHhWwHTRQf7qQGI0zQAyzaMBJLs+4Upx3HA
 VoU4Rbrnrohg2ak4L5Swqk9OoDnipApy23rCX7p1AwTqjXopjHNZUUkI7MHkVzfz5NmaILPc8eC
 rEwdUW86ZAF8pBf3KkOxAiNfDoqSqrzteorQPOJPpTfS6Q7v02ULcMjMD5gznbSJDIDrIB6WZio
 Vx+XI2RjxFEBzHAPi/Gx7A7WhB5lhA==
X-Proofpoint-GUID: 72nC9CduE4GSZBPHSLnJ9EmBszaY5B3n
X-Proofpoint-ORIG-GUID: 72nC9CduE4GSZBPHSLnJ9EmBszaY5B3n
X-Authority-Analysis: v=2.4 cv=BOK+bVQG c=1 sm=1 tr=0 ts=6911cbc8 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=5cN519QvuxvD8VeTpmwA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100099

From PCIe r6, sec 5.5.4 & Table 5-11 in sec 5.5.5 T_POWER_ON is the
minimum amount of time(in us) that each component must wait in L1.2.Exit
after sampling CLKREQ# asserted before actively driving the interface to
ensure no device is ever actively driving into an unpowered component and
these values are based on the components and AC coupling capacitors used
in the connection linking the two components.

This property should be used to indicate the T_POWER_ON for each Root Port.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Changes in V1:
- Updated the commit text (Mani).

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


