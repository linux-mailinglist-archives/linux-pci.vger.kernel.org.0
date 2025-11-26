Return-Path: <linux-pci+bounces-42106-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3550AC894F1
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 11:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AB9923556CE
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 10:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3390230215A;
	Wed, 26 Nov 2025 10:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z6Yhuagp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R1aQ/TDR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA802FD1C2
	for <linux-pci@vger.kernel.org>; Wed, 26 Nov 2025 10:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764153086; cv=none; b=Y2pH1oECmsN8VtSaN8UeH7tb4de/zyBV3yQ20eEUCm3f4Kzy7yv745vYH7+iaxIeHZ2JvtVEK9+XODkr2NO4IYlq6nfYmlETxeSFdIWoTqFumH2pSBET3n9C4HtZ7yF6MoPFYA2IoYuPeMPs9S+5Nbd7ocjosDKCoe904EiYroM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764153086; c=relaxed/simple;
	bh=XBQV6zbTgM5PW/11ScmAaN6KwicooE8rv47r9WmQPd4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dIcmTvk2J7aJuqg8o8Fh/GAGDln7u5Y3UCj/3dkKETH14EuddvKiC654rP/jNyKn/bBc498j6VslJl2qKZkHMsfKjmtU4UTODhIk3Ku8Ou8zEyLX7mheakmoCMtckj/pC1FyR0+bKy8IM0YmuD+fbyJt/6pggc8W7qgris/XPYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z6Yhuagp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=R1aQ/TDR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AQ5tRkJ3890412
	for <linux-pci@vger.kernel.org>; Wed, 26 Nov 2025 10:31:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=ysWSZ/rG34suqAdQu+gZ4WZ32lkN3tM8tmq
	ZfOIp8GY=; b=Z6YhuagpBv6E0NEJQiV2zHRpcwac7Gy1+EoP5JbaFYuFa2+BG2j
	1JR+OLcuMzO1lsswNzr5hBX8j/1Nmt2a6XLHSH6RqNRQHeHtvw+KOxQdjNMOu1y4
	FQEUCcTZ6s+alU7s5lCcy65/6KE1N79RkZpnOFgoqTVw8AlJM1ycAZSd0vvr/NOB
	mQkYmoAIkfoguXyhbLrznm64Xh9oakQQDddd93DM3EbgqvjjBArXy8GA9FFMqMSJ
	8OvuVu4pIP3rBK26A/2+rarAJBWIvEFDk52nJAUhjtDazp9mdHTYjCXCE4hHr0/D
	MxnbhnNo8W90grOrYFaIyn6Cj00DgpGJRuA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4angmeag00-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 26 Nov 2025 10:31:23 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2958a134514so89249745ad.2
        for <linux-pci@vger.kernel.org>; Wed, 26 Nov 2025 02:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764153082; x=1764757882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ysWSZ/rG34suqAdQu+gZ4WZ32lkN3tM8tmqZfOIp8GY=;
        b=R1aQ/TDRszkr1IQkOFcWPP0f1BOhsGUgn7K/D8hIuJq9FA+hbbLbgUDSl/OeTywfl4
         PLThNlrmOjZQcHWPyNRa1hx9c8W87sOR5qUDCZeAb+c/ETxEzTlsuVH1RElTuf2idNoS
         a38Sk0S9WtEG85/PK1HLZsjjQN7Eeig+Gb0Q37EAURzfUlpcu1UfbdgKYuOGVYEmOyqd
         qRNMN3jJAzYGdmvlJahLZNV2nD4wwSsWRhlkNNtJhoBtPNUIMH8HaiWq0/tbA6apmBP1
         oyzaqksg8+bUGJS2NYYxOa+CXlPriKi8orYTupjjng9DoLHyC6Ur2GixGbm1oOTEljW7
         JbGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764153082; x=1764757882;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ysWSZ/rG34suqAdQu+gZ4WZ32lkN3tM8tmqZfOIp8GY=;
        b=FpOBAyvaS1Kihxsc39UEO0IbO+9CSQvHFlHAX8UVdXM6Fkt0D9VTaR2zBjMToRFD6k
         2KV8fyDBSzgms8X7AUdZ35UwmA2N7oj+reZWFJv9ZB8ZYjb0vsFVPgS7EZDQrGc7lmQu
         2/glJ1ue6tT2aNqtlDMgtxse1OQOeamTzjn9fbDXavaQ6QcsTLHtShVJ94BohVD3javU
         w62y4YC3r8JJ6BkUWSYizzMF/fA+3qtkdETSzv05TB0LsUJdccCQhqUMI0G98XcTIw6Q
         krhInhZqfs2GFBiVLK8sIZJZSHmpeWjYrkT4OCXmzJmfwwgQLSLOuG2cRimiac+SpvsP
         LqyA==
X-Forwarded-Encrypted: i=1; AJvYcCVahoK5EiPCKnf6zuy7RzBvTZzz0KmFBvk7PqIlpLGUHU5uZ5P01GPdyobCaQrG59W2E+m45FUjC/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNqAsuqh0mZGDxxLArYGGuemAj+PLlf/idxZahq2J00XDT01ym
	hVaxHzFATea0+yjhI7w1FYq3nbyZ/Lr8UkE/4sQ1AIgQQUAEim8gyrEO7j+ngXi966ROLDRXmUQ
	+ySyKgbAitVKxCxKCMaF+8iC78Vk7I+faLBU+CrW6ZXwxiftRCNKD5BWzfJpBD62QHkqFqyA=
X-Gm-Gg: ASbGnctmk0dMuRexoVSPlN/TOWz2hD5qwjbLjnGFW5157+cX0nyMnxjaulhNp+bK7Vs
	a/TodCghWMSweCP4CVWr8mEmLIb/LIl75E32ynTj80SYIE/p4IQBvxbWH5N56yuHI+cqq9mbDQk
	pvBupxqWLIFtFAui74K2AeOC8N+rgD51/dDAKNGWJ3eBluP0nwvFPK/8iT1zDjNu0VWMBcT/2zl
	0z2bt8u/8j8VntddorB2HfQjGbWLZtA2efXXlulS5lkEqqSpN/1AA+XDSqT1lHycSS5GY4wvA+T
	cpAd1dz9ajRMHH4ZKi/LgEacRN4XQ7RDLMQzmGlkj8yZMAvWDaYFc2vwrfhHu2qveGVSDidbBI2
	tOqqwAQgjNKI1VK6KYtEKN0Bds+y3eVSMKmoKWQstkC3I
X-Received: by 2002:a17:902:d4d1:b0:246:e1b6:f9b0 with SMTP id d9443c01a7336-29baaf9abb7mr68896015ad.18.1764153082185;
        Wed, 26 Nov 2025 02:31:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtNSOALWZhHSuDXvX3CzC6UbjFFjub+TsW750YdkPPPyau87i9PtTK1ZxruaatUAFQE/8y0Q==
X-Received: by 2002:a17:902:d4d1:b0:246:e1b6:f9b0 with SMTP id d9443c01a7336-29baaf9abb7mr68895455ad.18.1764153081592;
        Wed, 26 Nov 2025 02:31:21 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b26fed2sm196534635ad.69.2025.11.26.02.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 02:31:21 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
To: andersson@kernel.org, robh@kernel.org, mani@kernel.org, krzk@kernel.org,
        helgaas@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        lpieralisi@kernel.org, kw@linux.com, conor+dt@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree-spec@vger.kernel.org, quic_vbadigan@quicinc.com,
        krishna.chundru@oss.qualcomm.com, lukas@wunner.de
Subject: [PATCH v3] schemas: pci: Document PCIe T_POWER_ON
Date: Wed, 26 Nov 2025 16:01:12 +0530
Message-Id: <20251126103112.838549-1-krishna.chundru@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=PJgCOPqC c=1 sm=1 tr=0 ts=6926d6fb cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=qIbWdXD6M1inJYch3NYA:9
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI2MDA4NiBTYWx0ZWRfX38TZk6d4m6Mw
 N59T9HZpUWIHmLrBqdUCwq0Hhd1heWhmnUAisXnjALSMpVRWYZ0berjKRq9L3YAyki4JbLhCRPA
 KZArO7rm2ES6ar+cKS9tk4ZNn0FeLYnLrEs9X9OIZ82DtCUylsZ/dEUa28ZYZmSflQNjFDHAEb+
 fFLQqxRvElIM4dwGzluPf/+gSuKtxABmIQ3gpVXK5kSU5UUZhRjv4drDPLi8+UzzDkSz61K4tA8
 YIlS8TOKz4U6ksL54C61Li6FYU104XIxFIx4HQT6iyqxUtU9yQfa1Qu0+uQJWfr/ISeIBhSG+bV
 6W2cR6v7Pmjx2dmoXcGarpPhtFMUQIKzaRpj9Gglv+F8p+fmcijaEIra4X0xOaI4QWrmbeeJ5tv
 NGkZk7056j0NaE0E7vLTv0AeR0JQjQ==
X-Proofpoint-GUID: i5lSMOC2n9rDDISPCn37T7-ZJB8spSRR
X-Proofpoint-ORIG-GUID: i5lSMOC2n9rDDISPCn37T7-ZJB8spSRR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511260086

From PCIe r7, sec 5.5.4 & Table 5-11 in sec 5.5.5 T_POWER_ON is the
minimum amount of time(in us) that each component must wait in L1.2.Exit
after sampling CLKREQ# asserted before actively driving the interface to
ensure no device is ever actively driving into an unpowered component and
these values are based on the components and AC coupling capacitors used
in the connection linking the two components.

This property should be used to indicate the T_POWER_ON and drivers using
this property are responsible for parsing both the scale and the value of
T_POWER_ON to comply with the PCIe specification.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Changes in v2:
- Move the property to pci-device.yaml so that it will be applicable to
  endpoint devices also (Mani).
- Use latest spec (Lukas)
- Link to v2: https://lore.kernel.org/all/20251110112947.2071036-1-krishna.chundru@oss.qualcomm.com/
Changes in v1:
- Updated the commiit text (Mani).
- Link to v1: https://lore.kernel.org/all/20251110112550.2070659-1-krishna.chundru@oss.qualcomm.com/#t

 dtschema/schemas/pci/pci-device.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/dtschema/schemas/pci/pci-device.yaml b/dtschema/schemas/pci/pci-device.yaml
index ca094a0..4baab71 100644
--- a/dtschema/schemas/pci/pci-device.yaml
+++ b/dtschema/schemas/pci/pci-device.yaml
@@ -63,6 +63,15 @@ properties:
     description: GPIO controlled connection to WAKE# signal
     maxItems: 1
 
+  t-power-on-us:
+    description:
+      The minimum amount of time that each component must wait in
+      L1.2.Exit after sampling CLKREQ# asserted before actively driving
+      the interface to ensure no device is ever actively driving into an
+      unpowered component. This value is based on the components and AC
+      coupling capacitors used in the connection linking the two
+      components(PCIe r7.0, sec 5.5.4).
+
 required:
   - reg
 
-- 
2.34.1


