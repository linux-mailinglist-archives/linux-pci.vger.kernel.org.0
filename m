Return-Path: <linux-pci+bounces-34241-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7DAB2B8C4
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 07:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BED8B567D39
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 05:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110743101B6;
	Tue, 19 Aug 2025 05:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YCxSDkLu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0933112B2
	for <linux-pci@vger.kernel.org>; Tue, 19 Aug 2025 05:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755581720; cv=none; b=PoY0bS3CrUl15ZVl1ePRKeS7hvkiZw9u+5c1M6GMyvSSyRgZOtTlr1S0OGPvlKGZHyH16+8lyq20Fr88UnWBSNQ+BwZFKn8LBKrXF8l9UfltVwDlwo8mfPU5UqIoTJ0tawHsiGLEP/Mrz8cZHogsjz1nT6w/S5cdP1rZpb8Lq+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755581720; c=relaxed/simple;
	bh=2rSyjnOXNH6jZxqRWat3S+IfaQ+klyL79lUq0adK6VI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ucMbCzLJuMNxp/Xx5TLVdJwhBkzjzlhQ+Fxr2YRb01dhe2EMHXPujgJxqTz9f9Ylc94rPZhqg7ofK/m9Yh+YlyvRJPI3/rBqnR0DGFE5R0CRg1OYFJT8WhZFCelMboCsQfLTp/+DSKCBQ3NjqyqDmLS1uCo9uySPkED3Yk5qUIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YCxSDkLu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J13344031569
	for <linux-pci@vger.kernel.org>; Tue, 19 Aug 2025 05:35:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B8vAYM0Ri6HzYPqPusEESOhjr79e1ErFVtCFN1cMUUQ=; b=YCxSDkLu5yz2f4Q3
	RcDI3dRVpQtdarphXwI7VUURtKhFouxoneOiEpR6SkW/U/Om50feVe2HUmcbm+nZ
	AUbOtfMWinS5JdeFxIYwfirwbeCPQ0xZMVT0tO2TwJqOn9rreFHikevzQXnCC0V/
	JT8Hnz6t18U/n+JlgPRQ0jyjUnmr3GuMSP35QNI5xoMgwc8eMfsTYE3L6qRUk0Nh
	Vv3qsJvZ/tZkFWIwDJh3Y0h+u9uHnSJ5LShHd9yhjF2P3Q9/2LnQUZZX962t0yoR
	SiIM94zAQGblgcawe1ippuoVDNQIMr0QxGBDrQv240dmXijMZc+Pc2G8+PTw5ZRP
	z6HoIQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jk5mf7jj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 19 Aug 2025 05:35:17 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2445806b18aso54213755ad.1
        for <linux-pci@vger.kernel.org>; Mon, 18 Aug 2025 22:35:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755581707; x=1756186507;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B8vAYM0Ri6HzYPqPusEESOhjr79e1ErFVtCFN1cMUUQ=;
        b=fve6rz19EOwHlHYvN91CQs+3smDWp8JG/WPf4sVvjzbJ/AYcaSIEtm12OSL52ZCqjf
         5EpNtNFMLx5DAJ2vKssYhwD2617vsQ1xJPDkWpqtgQUrX4jmfxYgbe6dOzgt8cLujOok
         OW8pN8FPBc2Ft90SMJuaTXg9C8Q6RCWYdQgcnsiomtqLVwSido6gVukeMj2bX4jXsu2p
         nONy8A7R3jyyY4fs7ccqM06JuookAA+B73kC1fKWsBTld+g0q6Ke/LP5JErNQM6Du/xB
         nVsJLOdcPyZSbUeZo/fOD9vLiuiGBV2ELzGsTA8htyctHh0GLkAPP3KEFAu7SJbVFYKz
         /v3w==
X-Forwarded-Encrypted: i=1; AJvYcCW2o6JksO0osYveDCZIQlFhhmgo2cx2Ir+uutDnoypD733GA+NXKGSVH6cfMt/ELUU6wY+HTaY/YwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH63IgI3QfkFPiNSURwvi8U9KKgIDJVPgjGRlNl6pdSlK4UobX
	E0PORhJHSxkv51+bYF9wmKsPrTWX2lyK7dTeSbVC2kfMEGfgASf9AGZNgikPyMDOTPlAchjz3MI
	2DOoORt5YL0JgBBANmzsoWAKy+8YOPsQAGoWkpyQIN/CXUIGNlLp6w5Ndqs6c2Pg=
X-Gm-Gg: ASbGnctZjpBtr6WPmIGLkZlIkVbuqVT41nu61dW6b0UlyNE2biZwY/QDkm13SNL1nY7
	34gmzKvEVYXzRtDknJtZQdgvj5bW4BgX3kRq3hX2UV9gmFGxUNhFgANpm1YDHt7yc7vaA1jLFsb
	QTQORkhh5KaYTdzttY8Ti5JN3F5BTx3QKCaHrlg/MXQnLP4NNxqbn8bVmsaBiQeLoGP47HJgGUt
	pZF7sy40WHUyhURo+u4QUF0LTzpjYBSQfLo7hpi0wTLIiv0UuwtnAS0MT/or7dGtCZXdEYd2Ly7
	77VC6H9AOVbD8sJFOWnms1On9kz23YBNaASVe9p3Kpq64p2BzsP4ml/J7sPjkBuH55Z4Ib4K0Gk
	=
X-Received: by 2002:a17:902:d4ca:b0:244:9a88:bf6 with SMTP id d9443c01a7336-245e0526b3dmr20781855ad.38.1755581706742;
        Mon, 18 Aug 2025 22:35:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3T2DWF0sM5aMCv7IQ1WuvOo+eJnBtoWO3vhU5xsD6yPrx9RP8y2lOdkUyfyrc1jBjsJmiIg==
X-Received: by 2002:a17:902:d4ca:b0:244:9a88:bf6 with SMTP id d9443c01a7336-245e0526b3dmr20781465ad.38.1755581706220;
        Mon, 18 Aug 2025 22:35:06 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d50f710sm97004785ad.86.2025.08.18.22.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 22:35:05 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Tue, 19 Aug 2025 11:04:43 +0530
Subject: [PATCH v3 2/3] arm64: dts: qcom: sm8450: Add opp-level to indicate
 PCIe data rates
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-opp_pcie-v3-2-f8bd7e05ce41@oss.qualcomm.com>
References: <20250819-opp_pcie-v3-0-f8bd7e05ce41@oss.qualcomm.com>
In-Reply-To: <20250819-opp_pcie-v3-0-f8bd7e05ce41@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755581690; l=3189;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=2rSyjnOXNH6jZxqRWat3S+IfaQ+klyL79lUq0adK6VI=;
 b=JlhlQ7TUFYilxYzRYBEH44c1xz4YIwI0fcVfxHuf0FM5xfY9kBMX68LMdQPURjW1d48qfMVRb
 jBzsfMXLcBvDWMTBKEoi+XFYXQByPcCDsCWFyRQW4zGN/lvwwIpaDi7
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=Sdn3duRu c=1 sm=1 tr=0 ts=68a40d16 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=qQkGquXN9PvF_GGjQ98A:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: EVIl9SUTY7IOure7ScIWTRAYlQAXUqg_
X-Proofpoint-GUID: EVIl9SUTY7IOure7ScIWTRAYlQAXUqg_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDA0MiBTYWx0ZWRfX8yAB3G0b9ILw
 ZHnxRSEigGQekCtWRToN1Be7hIlMruhAmSCEtXAVySyVdo5SEiUxglqFFhyOaAjAdy9su08Vy9E
 cz/tj0NtJ3ECBBfKC96Bnbp1c+ZrkkuJJV2MnUDjLJI5p5WVIRnKFmNlMno9WhxKXQpGd/rGbCT
 tbyz695vvcUFAQiAdCJhgUtf+wENBQb5jAECAlXkEj2J0C0IM+lwrUqltEiWL5DPnWHPIjS6EOl
 aZvBLDutoPlOSj9I8kLg1slUnUrJ6N/GIexwkKbh5l2tUXuJ8P4Jqb4L2eFPRSd/yT9IWxRwqz7
 3HCZG4cfp504bvbp2JU+aHxpi7/0lW8o8/GkQJh9zM6Pn8QUTnnNR+XxLEEfegC0sBLwv13YyW5
 7Br6xm5z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 spamscore=0
 adultscore=0 malwarescore=0 bulkscore=0 phishscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508160042

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


