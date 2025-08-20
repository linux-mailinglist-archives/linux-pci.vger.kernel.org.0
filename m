Return-Path: <linux-pci+bounces-34362-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD45B2D662
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 10:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E41B17A8468
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 08:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF392DBF49;
	Wed, 20 Aug 2025 08:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N6rkdm2S"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EB82DAFCC
	for <linux-pci@vger.kernel.org>; Wed, 20 Aug 2025 08:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755678557; cv=none; b=tcou3HJ3OJ5qbSkbKU7MXAAjXvOZE72JcWiyRR8XJ4VZ6+ZHeUWAZzwRsA728iV7Lwy+MzxDkrO+f1ivSxHn42qK1O47EnF6yj4Em/LwQJCSjmM9i2WqaHapTVN1PWNcAB2ytXCnCQ8GgFFpl8YR2eAG1/qr6q97xYCsWQZyKOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755678557; c=relaxed/simple;
	bh=2rSyjnOXNH6jZxqRWat3S+IfaQ+klyL79lUq0adK6VI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RzmhigWnN3KrPzKCrjrgWSyeBHvWAcyZFax6vHrk8w0L8T5cXZiYfiov2Iu8CuwyT80kZGGho075vBweFK649Y7XyTUebT5C0zu4xQ8FEtXoi4g3Njkxt9eNl19HZGcpy7AxnGCepHE/O6ZW5PMpcvyHU7G7t0pL2Mwfyn02PVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N6rkdm2S; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57K1od9M006141
	for <linux-pci@vger.kernel.org>; Wed, 20 Aug 2025 08:29:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B8vAYM0Ri6HzYPqPusEESOhjr79e1ErFVtCFN1cMUUQ=; b=N6rkdm2SLD4tiqge
	felAGgUHNHlk9bbtBNZuzAiwTUMzTXnBMc5eovI95FucIC9RvKeGkx3+OTL4TaIK
	YH/fta/o3yluTkpTyXUzCxsHRdSfUlMPeL61hIZ257Ed3GMf6ZWdyQxnT1niTs2E
	WnJNEmHVeDLWOAuv7O7DphELJvVReCQhMl8DdDfwOXY2tU+l5Vqs2BgQ6Jp4CDSY
	8VSs0iRUMVMgTQMWG+Pzq9swu+6lL2BRdTBzbjN3Z4HJ4ggRjtRB8JuEgNtdOV7C
	LZmORbrXONpTurUMVuZihZ9LcPk2Tmi0uyWPbUaZTkCQnELYfs8SMsKvalY+aaNS
	7YdIyA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n5290yns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 20 Aug 2025 08:29:14 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-24457efb475so72582865ad.0
        for <linux-pci@vger.kernel.org>; Wed, 20 Aug 2025 01:29:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755678553; x=1756283353;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B8vAYM0Ri6HzYPqPusEESOhjr79e1ErFVtCFN1cMUUQ=;
        b=s2o4AUIykZBdy1s4bnWoeWDr7QVCYkumkhRVRAeCA0PoQbZ628WhigprSJpu5+AzfQ
         kEsQDdXASzu48FcXhRN+SSLNDuY5c+ZhTDFBUBFm5TQD2eXjwK1sEIvoepIRr0KKyEqa
         HhCf2+PHZlVL0y/NR8klVtS72lxEve1yjP9SEkLjnXyGFLiqjZD6wKYOZoqZTYp66e6r
         GDiomN9VlvVkdkKZ6LJY8YUQwDQf+z4rqwqQZFsoBgonN3AfkkpYkplvS3qLVJ4BxGkG
         gyAtThOaYLn9Babj1cW3KVBJ5vWlwqNZeaGBYBdcgCgGEBELcw+Tyo/R/h+PDNKp+PAM
         WCjg==
X-Forwarded-Encrypted: i=1; AJvYcCUccotHoOxtPaKCx8wLXBcfILr6ty3qvqSui7JUNy2M2tN1+gM64hTALmcDnRpV1BJNJDU8n8jqD5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ6vkpXvA4+kBG8t7d257wQ4F1n1Xy+n/L2UYA28aEq+R/VjE5
	w+eD+/Y3UdAEg7Y+ljvizfE9iZKihxEr15jxupwfDi86ryqoad51VfkiFQMXdZmggnAWXrK0ydJ
	sbUV50Cnh7/DUQQ1gqrpgqGQlbKXcw/NoRvCLXjZKAologn907eG25DCMQ1dwgYI=
X-Gm-Gg: ASbGncsMTXdTWmuwTHJcE8kK5iTezERhkjLKgb0uemsrmXn3zw19/NT3MDTPiUs+Med
	AU/DU9TKvP9z0ny63wEB0yBoFs6G6ZBCfV9ymTsw94QNm11OZ33O1N+K8nraRuuJg0XZSRlXXDO
	54ANM/T/+BWcqlv6L9p7jvAW/9W/3Y4Av/3lN9DukoQK/v/nJZH1KnWqOEyFS+Ualo5xHfXS/OE
	Tp0A+AyAkQMcOKaeQEhOJ8Hi2lntaPoGCnogNymzboOt0lkFbkf/cYtwMxmlcKSWlr/OWtEZKKN
	XFZmx8cpcsCtRpTvGX/1RbQ4GwIYajZkJ2hS1AjiGqGFVGWIX4ckVkzYsLSz6sLj/GUocygtw44
	=
X-Received: by 2002:a17:902:da8e:b0:236:9726:7264 with SMTP id d9443c01a7336-245ef11259cmr21816935ad.5.1755678553183;
        Wed, 20 Aug 2025 01:29:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEH58s+l49kW9kCSGQZvGGVUFWqSm2Tm7559FEKLDrLbXRmO7pk0REh9tawRxJs0dbxdX2M4w==
X-Received: by 2002:a17:902:da8e:b0:236:9726:7264 with SMTP id d9443c01a7336-245ef11259cmr21816625ad.5.1755678552732;
        Wed, 20 Aug 2025 01:29:12 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed53e779sm19037735ad.160.2025.08.20.01.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 01:29:12 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Wed, 20 Aug 2025 13:58:49 +0530
Subject: [PATCH v4 3/7] arm64: dts: qcom: sm8450: Add opp-level to indicate
 PCIe data rates
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-opp_pcie-v4-3-273b8944eed0@oss.qualcomm.com>
References: <20250820-opp_pcie-v4-0-273b8944eed0@oss.qualcomm.com>
In-Reply-To: <20250820-opp_pcie-v4-0-273b8944eed0@oss.qualcomm.com>
To: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755678529; l=3189;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=2rSyjnOXNH6jZxqRWat3S+IfaQ+klyL79lUq0adK6VI=;
 b=KMmLYXCx2jpkOHi6xaQPHpldFZ07RBtLf+K6gKtKbz9lBE6uK1iQtrlG7AMP4UMtkYLRWuxK8
 4KzMEreo8atBndl2xMueG3ny6n4BmAYSQJEnth69/GUc4Qp54fwwepy
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=Aui3HO9P c=1 sm=1 tr=0 ts=68a5875a cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=qQkGquXN9PvF_GGjQ98A:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: Vv9xEhk40X5bALQ0AYhv1ZJKPO6Om5kX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfXw65m2Eku/LIV
 Y/mH19evpNUcqd1zwn4CBqUN3TKFLTKqXyAUSo6SNHH2v/cF1W+tgF5SlB63sefHILv0i5G8uWt
 Mkp46tmZ1+GmcvAEAibZbNoQSMh8Y5lIRHF86HihHFuq4advutDC4Qy1yTdIIx4H+K7zptvS4Fu
 2zgPYAiCb8MnHgV3D06RAdkwqrL7sJqaE4/m8pdp5KHpgXnUk2TtwVA//ZXBVGWN39xvIkn42eB
 D9LAXfrDKqpw5JIRcIdLjJmJYSNuH4DgYG/EefwAZM410xV03a7qlKhmu/ADxQfRTlaT46tUr8D
 nrKtDKIxvn7vLJMKC1BaBioCyggatvEHC9R+FfR6FOpgXbKe8ticdaRGRGc57wKmjS0RJQS5m+B
 xfZytcvewa74qMMyjFbcETMuA4vpLQ==
X-Proofpoint-GUID: Vv9xEhk40X5bALQ0AYhv1ZJKPO6Om5kX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_03,2025-08-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2508110000
 definitions=main-2508200013

Add opp-level to indicate PCIe data rates and also define OPP enteries
for each link width and data rate. Append the opp level to name of the
opp node to indicate both frequency and level.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 41 +++++++++++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 33574ad706b915136546c7f92c7cd0b8a0d62b7e..d7f8706ca4949e253a4102474c92b393a345262f 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -2052,6 +2052,7 @@ opp-2500000 {
 					opp-hz = /bits/ 64 <2500000>;
 					required-opps = <&rpmhpd_opp_low_svs>;
 					opp-peak-kBps = <250000 1>;
+					opp-level = <1>;
 				};
 
 				/* GEN 2 x1 */
@@ -2059,6 +2060,7 @@ opp-5000000 {
 					opp-hz = /bits/ 64 <5000000>;
 					required-opps = <&rpmhpd_opp_low_svs>;
 					opp-peak-kBps = <500000 1>;
+					opp-level = <2>;
 				};
 
 				/* GEN 3 x1 */
@@ -2066,6 +2068,7 @@ opp-8000000 {
 					opp-hz = /bits/ 64 <8000000>;
 					required-opps = <&rpmhpd_opp_nom>;
 					opp-peak-kBps = <984500 1>;
+					opp-level = <3>;
 				};
 			};
 
@@ -2210,45 +2213,67 @@ pcie1_opp_table: opp-table {
 				compatible = "operating-points-v2";
 
 				/* GEN 1 x1 */
-				opp-2500000 {
+				opp-2500000-1 {
 					opp-hz = /bits/ 64 <2500000>;
 					required-opps = <&rpmhpd_opp_low_svs>;
 					opp-peak-kBps = <250000 1>;
+					opp-level = <1>;
 				};
 
-				/* GEN 1 x2 and GEN 2 x1 */
-				opp-5000000 {
+				/* GEN 1 x2 */
+				opp-5000000-1 {
+					opp-hz = /bits/ 64 <5000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+					opp-peak-kBps = <500000 1>;
+					opp-level = <1>;
+				};
+
+				/* GEN 2 x1 */
+				opp-5000000-2 {
 					opp-hz = /bits/ 64 <5000000>;
 					required-opps = <&rpmhpd_opp_low_svs>;
 					opp-peak-kBps = <500000 1>;
+					opp-level = <2>;
 				};
 
 				/* GEN 2 x2 */
-				opp-10000000 {
+				opp-10000000-2 {
 					opp-hz = /bits/ 64 <10000000>;
 					required-opps = <&rpmhpd_opp_low_svs>;
 					opp-peak-kBps = <1000000 1>;
+					opp-level = <2>;
 				};
 
 				/* GEN 3 x1 */
-				opp-8000000 {
+				opp-8000000-3 {
 					opp-hz = /bits/ 64 <8000000>;
 					required-opps = <&rpmhpd_opp_nom>;
 					opp-peak-kBps = <984500 1>;
+					opp-level = <3>;
+				};
+
+				/* GEN 3 x2 */
+				opp-16000000-3 {
+					opp-hz = /bits/ 64 <16000000>;
+					required-opps = <&rpmhpd_opp_nom>;
+					opp-peak-kBps = <1969000 1>;
+					opp-level = <3>;
 				};
 
-				/* GEN 3 x2 and GEN 4 x1 */
-				opp-16000000 {
+				/* GEN 4 x1 */
+				opp-16000000-4 {
 					opp-hz = /bits/ 64 <16000000>;
 					required-opps = <&rpmhpd_opp_nom>;
 					opp-peak-kBps = <1969000 1>;
+					opp-level = <4>;
 				};
 
 				/* GEN 4 x2 */
-				opp-32000000 {
+				opp-32000000-4 {
 					opp-hz = /bits/ 64 <32000000>;
 					required-opps = <&rpmhpd_opp_nom>;
 					opp-peak-kBps = <3938000 1>;
+					opp-level = <4>;
 				};
 			};
 

-- 
2.34.1


