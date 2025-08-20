Return-Path: <linux-pci+bounces-34365-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A157B2D672
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 10:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA9BF5645D2
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 08:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B501D2DCF4D;
	Wed, 20 Aug 2025 08:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cD52eMG1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8695A2D879F
	for <linux-pci@vger.kernel.org>; Wed, 20 Aug 2025 08:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755678574; cv=none; b=ciEPGbwxsDg1cYxVZucvmgENdWzv3jMDXdE10c4RlEubh+8IIgPdO8osM5UXH3gyy5YFg4HOpNam1BDkbwCY9P9FbJh43liuw4VpF7BzuetVzOJcdS0j9KutKMRG52h9Zptxzgk1N2/42Z5oNCe3Rf3RK6X22bb+sVcQNIWKkdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755678574; c=relaxed/simple;
	bh=X3JieKiGrbzpcpUf9dETjBnX6ENnEPn9ryahTm5csmk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K8epfpUlKW50+5+r2J6CsEGBTvZwvbvqUl+Z8xTKw7Nj2DMGG1xNRcv7bj0JM+Rd62AsZzARbPJLubdOzq8wXZ8UR4T2jkyyZDMW+lIAdLD3pcJMiMfQo6pF8yCPXw3S/5fJZWlDcAamk8ernYil4qJ7rV646NTDoggA+E8NgXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cD52eMG1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57K1p6wl004202
	for <linux-pci@vger.kernel.org>; Wed, 20 Aug 2025 08:29:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TLYYOeSkC0vWS5m7p6WzBJHWogZZSLtvzFoDMbjU4tU=; b=cD52eMG17louFCj4
	XFeCP2I44ENLWbYrgeNJSGdiCDQXfpKOnNE8nl3toli6pW+VEj4EZA/RHBq+o56Q
	OY1QZQcojyO/9V1mllCXmPtVBcQkIoj+dtDHmdC4Av3T+V/CDaf/Y8wehZJSS81D
	B7X1aP8dpnu4Hm9UWkpFOTe2PyRxTPOoex3QddzfhVaC3AotBHF4InbpieEp8J43
	ud+QGgwlzSHLTVWOjCAB4dCVLoQ1z9aAIkWLcXiJ2B1+C0to/DklgTmaYzc0sJg/
	+D89KKnIXpWz0d/cXyiLPjpXesSlI94LzpRVErEeOxjrlIHNH3Vvj8uaMy8Q6zBj
	8VMDLg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52agyg7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 20 Aug 2025 08:29:31 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-24457f59889so67853465ad.0
        for <linux-pci@vger.kernel.org>; Wed, 20 Aug 2025 01:29:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755678570; x=1756283370;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TLYYOeSkC0vWS5m7p6WzBJHWogZZSLtvzFoDMbjU4tU=;
        b=ms8oijWxIIthhGmntMn1jDJ5iN8WMaaLv+2z4Sxr33JtGe8YNKcWar+ymYK4lDIXV5
         DPozWBZaOG0LKPJLcKr7sUL4rUH/m3nU85c7KBlpwcidClupHVvTjQ1GfriN+rd7rOJ8
         S1vfZ8cPA2u3Bq7NKKAtDGg7l9/+U/Wqm4E8Je9I9zlilYPoQ8dzf9JrXfgOAVheSOc3
         HkQzXK8LAF8mae8vxmkAWhcYMzKxK8ggD9DfQ0aggPuAeSLhLFwh9S8ufz12NY7+4qia
         umVM/IDcDzPV0PDiKQzgOmAQEx7D91JBCqttB6t3c4gIGoEAsCrnEZ/Kht1LdDKO/oUR
         mnUg==
X-Forwarded-Encrypted: i=1; AJvYcCU9FnJaAVx0DCJKO3xKNUS/jAy9WpK2M+G7PnIJmSO0cmqm/JWiysS39ZX8ktTpq3mCUVOSGpUvq7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKqy4/hZ0tEf1fY4L2gndZlU2EYHD1MCCEIoumJ5NgsRzk3ElJ
	RFHQw5Y4qOdCPKeva8CZIYoy5B7jDd6D3SfxfThwr8+rKdzLA+tCtFCgM5IYQqwTonJzZOITQly
	qs/epAmqrmc5nhLKNeLGfpS3exFBSOBsgWsl+VfRjUkbiR4omsQENy6xQr4u1Pmw=
X-Gm-Gg: ASbGnctHhJzo4MVOgZbMGxnkMSwn0B7y8EA3c/wTc7/IHAZJpZN/a3HH2thpuIK7852
	LwDmDlnXccYAuwo51pYw8ZHM0558NMhhNF+8RH7FB7mzLQJ8qXP3r9sgl+Qnki0jjkmH9x8lj+f
	e+PNHlnwgOrLdXIuDuFaMj3cL78iN87Crk8mwCJPWe8gsY+dwjPCh/YGhd1ssD+1Q5k0dJ4114K
	/5mZ8aYXOInFJWe4/tIbG1Urp4P8RRgTyOLJYH16t170+QJzlwiPXN93YfuaP3Q3rAvdV8WucR9
	3Ef4q02LOl66JWYqfSzoh619BhFkzlJRwQov/kHtZNEl/xAcMDN5ROkXsEP+lfZtkUutPmaPgGE
	=
X-Received: by 2002:a17:902:d2cd:b0:240:1bba:fc7d with SMTP id d9443c01a7336-245ef226c6bmr25534595ad.33.1755678570194;
        Wed, 20 Aug 2025 01:29:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgFRO4SFI/az62W4NvsRPK8ThASGxzV98yrYTSm2+Cr/JT9TMlIljWBDyHFZaG54Wx5AyVeg==
X-Received: by 2002:a17:902:d2cd:b0:240:1bba:fc7d with SMTP id d9443c01a7336-245ef226c6bmr25534325ad.33.1755678569736;
        Wed, 20 Aug 2025 01:29:29 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed53e779sm19037735ad.160.2025.08.20.01.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 01:29:29 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Wed, 20 Aug 2025 13:58:52 +0530
Subject: [PATCH v4 6/7] arm64: dts: qcom: x1e80100: Add opp-level to
 indicate PCIe data rates
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-opp_pcie-v4-6-273b8944eed0@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755678529; l=4392;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=X3JieKiGrbzpcpUf9dETjBnX6ENnEPn9ryahTm5csmk=;
 b=xCM0+u+MtriiF+Ee8OQ6M3MuLmsOxCxVlto5TNAerliX4oV74o2Jmi7DMZXMx/MEO8Pj58NKb
 dp5DSPx/SzSD5OnDAAY2oXg8Nijve//7z7RLAqz6bOVc+WOUWHXf2xy
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: wLZ8Tkj-o4phiCPcufkDjUKvdHLs8CnO
X-Proofpoint-ORIG-GUID: wLZ8Tkj-o4phiCPcufkDjUKvdHLs8CnO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX6ZWcBc67RNCM
 q8Sfq+kdo7f1cv1G8am4b3ppFmrZ9+iEUwrfpqOEIwDBRHFKgtUDD99AMQhNYmzPpaQlbVh5tjz
 e0XqSKFNQ68SkSW+5bNhP2lXk8qwt2yPqcgSOZ+9LXW3F36RBGk6ICTKvdKFfxrv9LdOYPhApFe
 WEu8x5hWKaEppudvEIlK7F/dv61qdyqq/rRIYymwU72lws2NLXIAjPvOCVpw5DNQuK9q3oNySJ1
 Z0He/zRoQ3dVFMw0wR5wOze5oNQ5NIoPgPXNZFOaJyfc2nvV8fdbdb5hdR8Oi/ggGiArgG2wWc/
 7Bxk1Z0pUCWfnnpvAfElt+vHCyJNNzuimYUzWfei7CdTfCUfzGJdQS3Fx58W7+Tm2DVmrvRN3Os
 apIzEjVF4ppSymh2VOFQwKR/uvokAQ==
X-Authority-Analysis: v=2.4 cv=XfbQDI55 c=1 sm=1 tr=0 ts=68a5876b cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=xTuWgevKKEmUOcCBws0A:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_03,2025-08-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2508110000
 definitions=main-2508200013

Add opp-level to indicate PCIe data rates and also define OPP enteries
for each link width and data rate. Append the opp level to name of the
opp node to indicate both frequency and level.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 90 ++++++++++++++++++++++++++++------
 1 file changed, 74 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index a9a7bb676c6f8ac48a2e443d28efdc8c9b5e52c0..6644017132bdd7677dcb4fccf90b1e5b36326647 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -3237,73 +3237,131 @@ pcie3_opp_table: opp-table {
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
 					opp-hz = /bits/ 64 <5000000>;
 					required-opps = <&rpmhpd_opp_low_svs>;
 					opp-peak-kBps = <500000 1>;
+					opp-level = <1>;
 				};
 
-				/* GEN 1 x4 and GEN 2 x2 */
-				opp-10000000 {
+				/* GEN 1 x4 */
+				opp-10000000-1 {
 					opp-hz = /bits/ 64 <10000000>;
 					required-opps = <&rpmhpd_opp_low_svs>;
 					opp-peak-kBps = <1000000 1>;
+					opp-level = <1>;
 				};
 
-				/* GEN 1 x8 and GEN 2 x4 */
-				opp-20000000 {
+				/* GEN 1 x8 */
+				opp-20000000-1 {
 					opp-hz = /bits/ 64 <20000000>;
 					required-opps = <&rpmhpd_opp_low_svs>;
 					opp-peak-kBps = <2000000 1>;
+					opp-level = <1>;
+				};
+
+				/* GEN 2 x1 */
+				opp-5000000-2 {
+					opp-hz = /bits/ 64 <5000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+					opp-peak-kBps = <500000 1>;
+					opp-level = <2>;
+				};
+
+				/* GEN 2 x2 */
+				opp-10000000-2 {
+					opp-hz = /bits/ 64 <10000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+					opp-peak-kBps = <1000000 1>;
+					opp-level = <2>;
+				};
+
+				/* GEN 2 x4 */
+				opp-20000000-2 {
+					opp-hz = /bits/ 64 <20000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+					opp-peak-kBps = <2000000 1>;
+					opp-level = <2>;
 				};
 
 				/* GEN 2 x8 */
-				opp-40000000 {
+				opp-40000000-2 {
 					opp-hz = /bits/ 64 <40000000>;
 					required-opps = <&rpmhpd_opp_low_svs>;
 					opp-peak-kBps = <4000000 1>;
+					opp-level = <2>;
 				};
 
 				/* GEN 3 x1 */
-				opp-8000000 {
+				opp-8000000-3 {
 					opp-hz = /bits/ 64 <8000000>;
 					required-opps = <&rpmhpd_opp_svs>;
 					opp-peak-kBps = <984500 1>;
+					opp-level = <3>;
+				};
+
+				/* GEN 3 x2 */
+				opp-16000000-3 {
+					opp-hz = /bits/ 64 <16000000>;
+					required-opps = <&rpmhpd_opp_svs>;
+					opp-peak-kBps = <1969000 1>;
+					opp-level = <3>;
+				};
+
+				/* GEN 3 x4 */
+				opp-32000000-3 {
+					opp-hz = /bits/ 64 <32000000>;
+					required-opps = <&rpmhpd_opp_svs>;
+					opp-peak-kBps = <3938000 1>;
+					opp-level = <3>;
+				};
+
+				/* GEN 3 x8 */
+				opp-64000000-3 {
+					opp-hz = /bits/ 64 <64000000>;
+					required-opps = <&rpmhpd_opp_svs>;
+					opp-peak-kBps = <7876000 1>;
+					opp-level = <3>;
 				};
 
-				/* GEN 3 x2 and GEN 4 x1 */
-				opp-16000000 {
+				/* GEN 4 x1 */
+				opp-16000000-4 {
 					opp-hz = /bits/ 64 <16000000>;
 					required-opps = <&rpmhpd_opp_svs>;
 					opp-peak-kBps = <1969000 1>;
+					opp-level = <4>;
 				};
 
-				/* GEN 3 x4 and GEN 4 x2 */
-				opp-32000000 {
+				/* GEN 4 x2 */
+				opp-32000000-4 {
 					opp-hz = /bits/ 64 <32000000>;
 					required-opps = <&rpmhpd_opp_svs>;
 					opp-peak-kBps = <3938000 1>;
+					opp-level = <4>;
 				};
 
-				/* GEN 3 x8 and GEN 4 x4 */
-				opp-64000000 {
+				/* GEN 4 x4 */
+				opp-64000000-4 {
 					opp-hz = /bits/ 64 <64000000>;
 					required-opps = <&rpmhpd_opp_svs>;
 					opp-peak-kBps = <7876000 1>;
+					opp-level = <4>;
 				};
 
 				/* GEN 4 x8 */
-				opp-128000000 {
+				opp-128000000-4 {
 					opp-hz = /bits/ 64 <128000000>;
 					required-opps = <&rpmhpd_opp_svs>;
 					opp-peak-kBps = <15753000 1>;
+					opp-level = <4>;
 				};
 			};
 		};

-- 
2.34.1


