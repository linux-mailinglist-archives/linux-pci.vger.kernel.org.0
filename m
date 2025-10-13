Return-Path: <linux-pci+bounces-37889-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 52452BD2A93
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 12:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B0BA24F00A0
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 10:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805EB306B05;
	Mon, 13 Oct 2025 10:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OurtDfbJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01CE3064B7
	for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 10:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760352851; cv=none; b=E/6TfvxQTkWu12rvWz/OL7ABHeW6NdTQ9SLwjFN4chatqo1faMn9+Vw1ZUjUZQu/XvzbUY/pOq+ArdWeh1hHdONOsNRy/861SInBMXDKnlKVOfahP4yKfSNyHfVqu5ZU7VZQYUv0fzgNxKAJ5kAJF6dhhJ+qAlK8cj3aH9Czvys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760352851; c=relaxed/simple;
	bh=zyQNUwXn+YCw1NiWz2KzbTMHzKmDdLyqHONjJeYldj8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yvg25ArFRrqt6dFFE2o0gQ1nCnW8zHMW5QcP0zNMztF8Ultu62ureOggK6jxKkB7eyPtxgCd/t8sJ+kDcXSRg5kf0D8w1L+WVxsYVCAKJ1RT22og2vtYjes4FnGHaeD7dplzBI7newJ2UfPg/MtZyoXq/9AyW9c5IwINMvAlDUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OurtDfbJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59D7QdpX013013
	for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 10:54:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	i7a5MTWxmvi3XHfiDstUA9h/EtTQ90XBtsX+f0facCs=; b=OurtDfbJmJn7G0mE
	I9Y+5JJmUWMGgdYX90/xiHq1zB14B/g3sFtxwOJ3RwI0NVsKNCk1rx7ghnrMLQvU
	AdVScQTU01e6UzPD+Q8G8gPhu7eWL2pmI/Ek1LbXxJhQwbiRRF2vTinSqj9adZOc
	ydjd6mcH5tlcxekad9C1bPPXYEUc2rHg7qMpELfn53lOjagED6jOxS8eM/sFgqIJ
	JCELOuf5pbxqHY4/Zlu/uZEJYIjfgLD8+wnN0IftrfTCqOd3/0WxVo5Rmaidud4Q
	X4I3946g3XIN8I8K5fq/hGRAp9KQBaH1VUsYSNBO6eCwrxiz5+/bjF3qu2cV6/t3
	xZuzAw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49rw1a8m9m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 10:54:08 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b55735710f0so10698852a12.2
        for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 03:54:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760352847; x=1760957647;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i7a5MTWxmvi3XHfiDstUA9h/EtTQ90XBtsX+f0facCs=;
        b=pqGkO9c39RTeCPdHKQ44bZP41mKoOnScx73TRfAZ7qhyr7n/0dmNT0c45XUHncq722
         PdFthYVxrN1cS3MWkatba4INqyfMyRhhIBydrdap8/JJ7A5iPCzOJ1wnVxRMPM6eE7Fo
         nQHN5d3A81K5lCNvhefU/U1qK70OVEqYdNecYo6edoMemWxK57+bQeRaltfbB0G793jM
         sctLxDlrqskDpbln+Eu9MfD6JGTY03gnfqjlj7YERB+xD/A8xKxmv6C+TCDpjIe30k5q
         sCU4lQxGP8Adt8Nq4dKAIGQEWM2s4wy6+RRjIkmrrahP1+bmBLvc1A42qIhy9HdkzFh2
         20Cw==
X-Forwarded-Encrypted: i=1; AJvYcCWHpudUSBPO81YRedSXLjBjgKkLmiq91aXiGHZ7aULardKCDGX/m2TJOrubsEdf3mOAlydL5MM0IT4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi45m+j2H+rF6dsLDLokv9u8niSG3Pmf4Je0Eri8UT7c17kF65
	CdnnfCibgWO8pMFpVdZVt5XfZM2dHVPGhN1W06xDS/5SOPInwTlib/qulE3SUYOao1fgBDQOTl6
	Uff2JM2669305Nut3MH9cMA6/+5VfqeQFHSNMRclRSTImMwf1QgeU2+oxccXykqU=
X-Gm-Gg: ASbGncsNyR1qV4cyOBpsG/EWw1zpYvgI6Iu9qf0x5CGM+XivjXJnGkSOSgq37n3MVas
	xVR+NVlfgs1kuJeBFWnNSPR7WfOmazPuSbfNDizCU/0c2OSDv93ubyQR62f+NHkD3jJZgANC3BD
	WGF1/KB1YHKACiYg0/Yku0WfrwABPZVPCwaoVh7o73SacavXpYN3Xr1aH2HlVTIWHTL2J21Il57
	pzJvBerOVZmKxa3xoiswzmJwMViMH5gWTlCZOGNGs6buYs0etxZhPGuGcYfXJ6JmXs+XXIzbhkZ
	e+vKyp+kLIAhIi2aCiRtp/3ThD3y2axYVn/EzjhzBK0tauLhnnumSU3uXV74Yc6B3jROFzigWNk
	=
X-Received: by 2002:a17:90b:1e0a:b0:339:9f7d:92d4 with SMTP id 98e67ed59e1d1-33b51110ef7mr28806967a91.9.1760352847173;
        Mon, 13 Oct 2025 03:54:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgRMJ+7K8YTL8id+HqQG26nT2LHUMUcyjIqS6elWn7IDUMbrcaXna2wmd70NXIrZ//ptwSDA==
X-Received: by 2002:a17:90b:1e0a:b0:339:9f7d:92d4 with SMTP id 98e67ed59e1d1-33b51110ef7mr28806920a91.9.1760352846649;
        Mon, 13 Oct 2025 03:54:06 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b626403desm11662295a91.7.2025.10.13.03.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 03:54:06 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 13 Oct 2025 16:23:30 +0530
Subject: [PATCH v5 3/5] arm64: dts: qcom: sm8650: Add opp-level to indicate
 PCIe data rates
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-opp_pcie-v5-3-eb64db2b4bd3@oss.qualcomm.com>
References: <20251013-opp_pcie-v5-0-eb64db2b4bd3@oss.qualcomm.com>
In-Reply-To: <20251013-opp_pcie-v5-0-eb64db2b4bd3@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760352825; l=4818;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=zyQNUwXn+YCw1NiWz2KzbTMHzKmDdLyqHONjJeYldj8=;
 b=Xq7E3mW0MADg2b/YJ48xGeqRlGPOJorM141r+oyVNujfNESx+p44bJQrZnLWpyP+MyJTsL3xS
 ifiDm/PnCobC0SSC/TgRVc1GoLl4CERYyyUfbrHumJaJ4yjjQMR4rks
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=K88v3iWI c=1 sm=1 tr=0 ts=68ecda50 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=xTuWgevKKEmUOcCBws0A:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: xTkdP8Fx9zNBitCf-FmM1ChG8RtQQQak
X-Proofpoint-ORIG-GUID: xTkdP8Fx9zNBitCf-FmM1ChG8RtQQQak
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDAzNSBTYWx0ZWRfXwwjC8QET/q1q
 HLL3Yj9ni+AvYZKvjwHmeuDSxQvG/RuNaajO1jIbPKio5VUI2tVu5/nTTjE7mVg2I9zoS4/Hv/1
 XjCddsn5/WRUJzHtk3NtRYvYPle59MjuDG0Aj6gFk5tQJcUyziKJQhpsRRRsOC6oTymKiHac4+d
 qX0CabiT0bGOuWCbYB3mGyGrDlqGLMFr3VoHi8EZOmW4bpTs6WXcYmJ7Ndb5oP62AV7ByEZbVvk
 x+5FJcMg7HjyWbkrg5iRxh6Uvz8PFzXilBDRTfa5oZt+d0rH47coci18IsHyJ9YQl3W/6fPwTxF
 W+EiOtnjaYJMK/7Pr2T6KH7n4IRcwleZqYn+XePrR+ruo9KsWCcLra09dcAsTxZIC8qlJpuX4WH
 j6upEz9DsU8sidxmNHEzCDHSpch0ZQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 adultscore=0 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130035

The existing OPP table for PCIe is shared across different link
configurations such as data rates 8GT/s x2 and 16GT/s x1. These
configurations often operate at the same frequency, allowing them
to reuse the same OPP entries. However, 8GT/s and 16 GT/s may have
different RPMh votes which cannot be represented accurately when
sharing a single OPP.

To address this, introduce an `opp-level` to indicate the PCIe data
rate and uniquely differentiate OPP entries even when the frequenc
is the same.

Although this platform does not currently suffer from this issue, the
change is introduced to support unification across platforms.

Append the opp level to name of the opp node to indicate both frequency
and level.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 79 ++++++++++++++++++++++++++----------
 1 file changed, 57 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index ebf1971b1bfbebf4df5a80247a6682ac8e413e3b..0f2a389aafe5c7475a40adf8c43614a007429b41 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -3659,39 +3659,52 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
 			pcie0_opp_table: opp-table {
 				compatible = "operating-points-v2";
 
-				/* GEN 1 x1 */
-				opp-2500000 {
+				/* 2.5 GT/s x1 */
+				opp-2500000-1 {
 					opp-hz = /bits/ 64 <2500000>;
 					required-opps = <&rpmhpd_opp_low_svs>;
 					opp-peak-kBps = <250000 1>;
+					opp-level = <1>;
 				};
 
-				/* GEN 1 x2 and GEN 2 x1 */
-				opp-5000000 {
+				/* 2.5 GT/s x2 */
+				opp-5000000-1 {
 					opp-hz = /bits/ 64 <5000000>;
 					required-opps = <&rpmhpd_opp_low_svs>;
 					opp-peak-kBps = <500000 1>;
+					opp-level = <1>;
 				};
 
-				/* GEN 2 x2 */
-				opp-10000000 {
+				/* 5 GT/s x1 */
+				opp-5000000-2 {
+					opp-hz = /bits/ 64 <5000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+					opp-peak-kBps = <500000 1>;
+					opp-level = <2>;
+				};
+
+				/* 5 GT/s x2 */
+				opp-10000000-2 {
 					opp-hz = /bits/ 64 <10000000>;
 					required-opps = <&rpmhpd_opp_low_svs>;
 					opp-peak-kBps = <1000000 1>;
+					opp-level = <2>;
 				};
 
-				/* GEN 3 x1 */
-				opp-8000000 {
+				/* 8 GT/s x1 */
+				opp-8000000-3 {
 					opp-hz = /bits/ 64 <8000000>;
 					required-opps = <&rpmhpd_opp_nom>;
 					opp-peak-kBps = <984500 1>;
+					opp-level = <3>;
 				};
 
-				/* GEN 3 x2 */
-				opp-16000000 {
+				/* 8 GT/s x2 */
+				opp-16000000-3 {
 					opp-hz = /bits/ 64 <16000000>;
 					required-opps = <&rpmhpd_opp_nom>;
 					opp-peak-kBps = <1969000 1>;
+					opp-level = <3>;
 				};
 			};
 
@@ -3839,46 +3852,68 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
 			pcie1_opp_table: opp-table {
 				compatible = "operating-points-v2";
 
-				/* GEN 1 x1 */
-				opp-2500000 {
+				/* 2.5 GT/s x1 */
+				opp-2500000-1 {
 					opp-hz = /bits/ 64 <2500000>;
 					required-opps = <&rpmhpd_opp_low_svs>;
 					opp-peak-kBps = <250000 1>;
+					opp-level = <1>;
 				};
 
-				/* GEN 1 x2 and GEN 2 x1 */
-				opp-5000000 {
+				/* 2.5 GT/s x2 */
+				opp-5000000-1 {
 					opp-hz = /bits/ 64 <5000000>;
 					required-opps = <&rpmhpd_opp_low_svs>;
 					opp-peak-kBps = <500000 1>;
+					opp-level = <1>;
 				};
 
-				/* GEN 2 x2 */
-				opp-10000000 {
+				/* 5 GT/s x1 */
+				opp-5000000-2 {
+					opp-hz = /bits/ 64 <5000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+					opp-peak-kBps = <500000 1>;
+					opp-level = <2>;
+				};
+
+				/* 5 GT/s x2 */
+				opp-10000000-2 {
 					opp-hz = /bits/ 64 <10000000>;
 					required-opps = <&rpmhpd_opp_low_svs>;
 					opp-peak-kBps = <1000000 1>;
+					opp-level = <2>;
 				};
 
-				/* GEN 3 x1 */
-				opp-8000000 {
+				/* 8 GT/s x1 */
+				opp-8000000-3 {
 					opp-hz = /bits/ 64 <8000000>;
 					required-opps = <&rpmhpd_opp_nom>;
 					opp-peak-kBps = <984500 1>;
+					opp-level = <3>;
+				};
+
+				/* 8 GT/s x2 */
+				opp-16000000-3 {
+					opp-hz = /bits/ 64 <16000000>;
+					required-opps = <&rpmhpd_opp_nom>;
+					opp-peak-kBps = <1969000 1>;
+					opp-level = <3>;
 				};
 
-				/* GEN 3 x2 and GEN 4 x1 */
-				opp-16000000 {
+				/* 16 GT/s x1 */
+				opp-16000000-4 {
 					opp-hz = /bits/ 64 <16000000>;
 					required-opps = <&rpmhpd_opp_nom>;
 					opp-peak-kBps = <1969000 1>;
+					opp-level = <4>;
 				};
 
-				/* GEN 4 x2 */
-				opp-32000000 {
+				/* 16 GT/s x2 */
+				opp-32000000-4 {
 					opp-hz = /bits/ 64 <32000000>;
 					required-opps = <&rpmhpd_opp_nom>;
 					opp-peak-kBps = <3938000 1>;
+					opp-level = <4>;
 				};
 			};
 

-- 
2.34.1


