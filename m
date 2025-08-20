Return-Path: <linux-pci+bounces-34364-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B8CB2D68D
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 10:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEA0E683ABF
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 08:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3542DC359;
	Wed, 20 Aug 2025 08:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XbhWL9W7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6182DC355
	for <linux-pci@vger.kernel.org>; Wed, 20 Aug 2025 08:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755678567; cv=none; b=gapamptyMiwehsPcN8xAs8LHkKB3KbRhHvnyBMJ9Z5WQL1GsxR3kjymygE9vP41JzwA8G1FunTkA5Gshn9RtL0Han3J9b1u2xdiG8JHq8cjz1ouHpmlvvichrspJKeb8JSdr8wPuDey2AqNmQnokG0+oZredEFa3dXB7X061DtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755678567; c=relaxed/simple;
	bh=cUKVuatuU0/Edgpdfxw3c/N86a1mg3uApCUinYHTLyY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MDk2sbPSiDsOTEEh9XMOQ6ooYpHoVFWm/NzCCnWQda1RP29eawfYf/omyHeu4wo/5tQz08DpFz6bGWyB/A5nA/YkUqkbqCNsC/EnwyCj89a8cb1D7xyTSh0/pCgouAkyIvMMBusmXijKgXhzzMi/m24OkSjaaH3Uf6MzoXnwoMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XbhWL9W7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57K1pApP021351
	for <linux-pci@vger.kernel.org>; Wed, 20 Aug 2025 08:29:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JGiuOX/3Gl5SQ8ZJEPIiy7Ut2Wjdc99qWaL4w8mdXMw=; b=XbhWL9W7mFtOw0On
	Md6vs4tmwOGE2wjJttE/D7KDSXYAqom/pH2/sflw0z1Xw8q0fpKTIyGeVNrNAGuB
	gGVzcwiBg9e8u+EzaM04/+acp6CnT6rEUvdj2UhNXc5JMwq/+e8w9HGBoCdKA9Wi
	LMoleEpWN2qfhyzt2ZsrAOld8/XjtCrt2HqvwHWTriAGrgdv5GHThgaNTeYyPkjx
	SyEw5Dyyk0aZUGlfpI8Td2RCeir2vM+pLiOxMwxik7WZ/rx2G7+F4YBYRRy3aErD
	UMlwXdnjgzVpWDP1zlKSbJadfOOaDVTz1u9EuqigEqFYv3eFeNcfKOugUQ/42Tax
	t+GQag==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n5290ytu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 20 Aug 2025 08:29:25 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-24458194d82so65845085ad.2
        for <linux-pci@vger.kernel.org>; Wed, 20 Aug 2025 01:29:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755678565; x=1756283365;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JGiuOX/3Gl5SQ8ZJEPIiy7Ut2Wjdc99qWaL4w8mdXMw=;
        b=YSKsuH+tuhkFDC4/d6M0NCd+TxJftUTUJybUMUIggEcTpiABxonm9oeomW49CwYS5G
         cdv3CE9e+J7UQR+ydQy/yJjaZfzqfcEhTljtV96VRSrUNYeJzeIKHNDZq/2pn3BH1Y0N
         G3lyuwpsv/Zu8dPXms0zU2vVegS1ujc7FfgPLU4MsT+G566VtP0Q3vHAjtX947n2HQ4b
         40NNI3WCfbDAkG1XodLWIkTi3PzjJu7+lQ0+T/+RJO6VjD1d2iz80C2oRFGMDqc+52SM
         sqiqsrgbaN5d0XEzayggQeawc6dMX+dT2Fkh7oTTyBfj0wNOGQZitbqIvuMf6Uv/Zm2Q
         0b0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUD7p/xwZewi1o+SNUxxloc7kTw4xOsaIy9p8Ev6YhK839CmGDI9/wBH92LerP+zooQpGfQmjpM0i4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5aEIhpNc/O12BLcfPzEfAOpSeZm2i3w4zh9UVSoy+blr2a19N
	0+9ZbrueGwv3RikX1tZ3ERJmPhgLIr1PJHVwkdoLgmRNRYUtDRuzYDosahRmPoEjJN1treRxW52
	u0Y4Bc6bG+SIKxQXGzPyzrfI2UEYd0/ZkfK+5cWcT1DiqLAMHTCjhSfGFnZ96fHw=
X-Gm-Gg: ASbGnctmjdaOQtGGRJLiv5HvVVajn6+YE3hZ+hU5rDsxyhTzePAnkRUlroJaXuhP7/t
	mANA17AOkhczTgP2ubILVo5eFIIUkJNz4Ww3WPkhxrwDGtYY5kWggAzrkp/yABkGsL3urapgsFk
	GbtHxzN9sH6NAkcVs5bu8PWYqOZyfL9h2bv8NjJxTgUg51NBtdM51xbR9AgJvoYwtheu2sEQUq7
	8t8YuiF5vvxK9wprPoQM6DuFimDjsNU7j7bx1ReNU9kYIZsQ60WEdBMWBnZEbreOBVepPv/bwlh
	jrVdxRiYCWgH7DdKZgiWSZ3WasDYCZqDYBn5qO8k68nM47jAxXSRG5zNvFHUuAC1pMtt3z+CL9w
	=
X-Received: by 2002:a17:903:1aeb:b0:242:9bc6:63c3 with SMTP id d9443c01a7336-245ef27bb12mr26602695ad.54.1755678564525;
        Wed, 20 Aug 2025 01:29:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuJc5jlXFWnGiYoLB1WpPpHS4FuxQkro7nZwC6fQBl/f109El4o5ghE83SpvySv0MBi2OCTQ==
X-Received: by 2002:a17:903:1aeb:b0:242:9bc6:63c3 with SMTP id d9443c01a7336-245ef27bb12mr26602405ad.54.1755678564076;
        Wed, 20 Aug 2025 01:29:24 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed53e779sm19037735ad.160.2025.08.20.01.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 01:29:23 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Wed, 20 Aug 2025 13:58:51 +0530
Subject: [PATCH v4 5/7] arm64: dts: qcom: sm8650: Add opp-level to indicate
 PCIe data rates
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-opp_pcie-v4-5-273b8944eed0@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755678529; l=3994;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=cUKVuatuU0/Edgpdfxw3c/N86a1mg3uApCUinYHTLyY=;
 b=j5NiflaSgQGzH5k3irCGzLAmssdtB0MNKNmsAjE+zZf7QsSW5X3nxr9zNrCfcextwvlqln45K
 4cKrCm4HRKlAADynfcudFC42Oxfk7uIwFW96kSOlrvM83JUmTSEWsiE
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: m_6ekHS8Ku1sh1pEn9EftiCMd1QEfop7
X-Proofpoint-ORIG-GUID: m_6ekHS8Ku1sh1pEn9EftiCMd1QEfop7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfXziYY7e1jYOZf
 I9Ny8HOScMGU/XpyFIjhX2InXkOoWG1CDAytx1UiZC2MYC5bMjopXDq0mqdRc0HMbrJzJW7Z9gD
 Ido6XlUaA/jfxVsQkFjrD9bX/CBWvMz7EZxmKe4USh8G6putRMqQibqYYNle3HN5qzkOIK+V6+B
 5DKSkI41sPaETvEprxEtvv4xijbGI+zNdhm1T9ZT/QPxp1Dd60AGW1HwvG/kZfG0KDMqKyCiXC0
 2+Cpriy8SKK0tyqhTURDZVLdztvvW9LdLvfhRgc5nPPE31vWe7065XrKakrYE5L/8CHMTJVTFtF
 LBWHaSSou79fCAHPTZP7Ow5bCVBLuq/KrVB8E5/SQ7ZsVjU4HlQso9MX8yAJgPENlgwbw+aub1t
 jRLqVCMBB/naELHvuZZk/9T0+k15AA==
X-Authority-Analysis: v=2.4 cv=SPkblOvH c=1 sm=1 tr=0 ts=68a58765 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=qQkGquXN9PvF_GGjQ98A:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_03,2025-08-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0
 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

Add opp-level to indicate PCIe data rates and also define OPP enteries
for each link width and data rate. Append the opp level to name of the
opp node to indicate both frequency and level.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 63 ++++++++++++++++++++++++++++--------
 1 file changed, 49 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index e14d3d778b71bbbd0c8fcc851eebc9df9ac09c31..fc05f5eee870ca67cbafab5d989e5f861d96add7 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -3660,38 +3660,51 @@ pcie0_opp_table: opp-table {
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
+				};
+
+				/* GEN 2 x1 */
+				opp-5000000-2 {
+					opp-hz = /bits/ 64 <5000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+					opp-peak-kBps = <500000 1>;
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
 				};
 
 				/* GEN 3 x2 */
-				opp-16000000 {
+				opp-16000000-3 {
 					opp-hz = /bits/ 64 <16000000>;
 					required-opps = <&rpmhpd_opp_nom>;
 					opp-peak-kBps = <1969000 1>;
+					opp-level = <3>;
 				};
 			};
 
@@ -3840,45 +3853,67 @@ pcie1_opp_table: opp-table {
 				compatible = "operating-points-v2";
 
 				/* GEN 1 x1 */
-				opp-2500000 {
+				opp-2500000-1 {
 					opp-hz = /bits/ 64 <2500000>;
 					required-opps = <&rpmhpd_opp_low_svs>;
 					opp-peak-kBps = <250000 1>;
+					opp-level = <1>;
+				};
+
+				/* GEN 1 x2 */
+				opp-5000000-1 {
+					opp-hz = /bits/ 64 <5000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+					opp-peak-kBps = <500000 1>;
+					opp-level = <1>;
 				};
 
-				/* GEN 1 x2 and GEN 2 x1 */
-				opp-5000000 {
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


