Return-Path: <linux-pci+bounces-37890-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EACBD2AA2
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 12:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4336C3B47F7
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 10:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794213043D8;
	Mon, 13 Oct 2025 10:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OM4yPuQY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9B0306B39
	for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 10:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760352857; cv=none; b=U2VJwd84xhYlSdwtVSy9oAc3VecSGCDTNVg8fNJAXZhZQ/0qedjQYkZ2jpegUMr5U1K5U5LeZtpsmnXEXdvluCUotlZ3EudHxb9zDnkiANgxQPQj9rlFxk7pAuUrns3eSwa4sRar8cIdwGYz+DbZ98QzMd4tw3Fx8QLv2UHE0bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760352857; c=relaxed/simple;
	bh=MfR1jV6eq/YYIA14Wj7rCxiMT+Ho24Flcb/t1rnKumY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gi/hE0SJ5OjKYossFn7LLV9nN7XLHBpdp8+jkmoeFB/ytxJjncPIFXY6PKrrwzWE1yjbyYLiTu639goa7BH5ia6DYc0v06PBNQAuD8uoMBEX3eM0tJ1Ju6NeTp7Dvnpr4PC5plYORS57cWpFpfOYICoMv/Zau6qWxdnmEi5G534=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OM4yPuQY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59D4pUtJ020462
	for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 10:54:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wL25zqHZA5p49x6EbdmQyT/vsQhuS7USBHx55ojonKY=; b=OM4yPuQYv8hwIDnW
	VVgOynC0iRTNZPb3a2tCZzVhBjXyAiaXqH/N2dvg6etPCNFn12929CqS5czFQx8k
	fVck7TrR8u6uzGrG0iwVsis13ELgQUjwknlV9v5ltKZEdkgpzydIdmosL0sBnnr8
	ZCd4EELarpuNL9cUgvdLb299sQm9odz0Jy2kNC6GD1uu8NhQze/TG0px9qirX6gx
	jwEi+rzNveJpcEXzDyEV7nhcC2ESMei9ZAF0zmRxdZEjxIQ74aOItMLxrudrqAnB
	nWPD6kLcdGJAwe8tZTQCPMaRO6EOiJ2d4Wv1nY95KZwHExwv19rvp1EnSyF3EVFh
	TqVVZg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49rtrt11xa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 10:54:13 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3306543e5abso10963156a91.1
        for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 03:54:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760352853; x=1760957653;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wL25zqHZA5p49x6EbdmQyT/vsQhuS7USBHx55ojonKY=;
        b=Jo8dY2HDrfa4K2/jmtvnGiRSnVi4FBocxHPBXYTjh0kWzdQrUixoWsLEbg0uqPGV3w
         iwkQVWCAu85rXAFzVPNZ+rWD0Em/Gy+nepHPN95qOR7eNt6s8riRyPUnNdCIzJXaq1vM
         D/KQdlYlfh2kCMBFPu//r2lXLUyDE7Tt2ukJGgvblVN/4w21QaHz1rVwZxt9UcwT1zAz
         YwzQ23wfJnWzGQ+7hmH7G7D0ljrevqZGGg0JnoEHu3/R/zLyHK2EQzt4ZX2yX+0sLQe5
         rk5YxH+Sn+fExlVMM3/Fz1Ad85WdpT3VjPY/a2L4N1maDVKPs2KweefrN4J5tP2DsZKi
         nplg==
X-Forwarded-Encrypted: i=1; AJvYcCXS5n/1+G+dTEKBQgst1E8EpzkNVbaH6+MjEAQqhUDJ/pIFtwhHWtVatr50ILQ3KeP1mTgrST5oWCg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4JLagAyVglWFXmWtbs+jFK0a9/pZuuXbZpWrgVRWfSuvHwj/s
	3kTbbjkyaErkUx62tDLRgc2cKqE6Azps2NbT3TQ6prsUzWDY2vN6mJK2bSDfKqDKzywUEOX/r7O
	KyAtZrdiHAtZeI5JwNq4T9waSFE8kYtfRxsuRjw8YIyexXk3nAPB2RDXCPxq6JA4=
X-Gm-Gg: ASbGncs8xKKlU3TlFAMIoOUzjhkKR3wftkm9nYVdivC0L98fBBrA64d4ZaAYP9eRqU7
	lbXjGUaQI9dnqYD+ubTfhfgMcxKO3r7UUZBxgwA3DTLjMjXAwHCbFV5/onQ16ugDVRNNUomit/a
	4IPEVwffJzeV9lY1vtZ6mUuIH2KFET8fm8m02vHBtq7+3fJvlEp7YfDlN6Vd2dEBTr4gYKT3Qkb
	SPd1El4JctpJdBr8tlI5jHHsTNJpFBnvyciMyU18F+bE8TWZEZW7nhVz6/gztZ4DgHuubyL4jTI
	jlXjxKRh11/t2ca5Uk3FivYdIbQJztmlXJ03UIZmAdnW8XGfzOdJAbholADv7dK1z1fDpBvo81c
	=
X-Received: by 2002:a17:90b:1b01:b0:32e:7277:9a81 with SMTP id 98e67ed59e1d1-33b51660588mr28605073a91.4.1760352852644;
        Mon, 13 Oct 2025 03:54:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/yZlRBooTIIXFKaInY/sJrf8yLLhlb+Jc44JB2qOxtQbkQ67CwNW9zuCTTxca9MrAB//Rbg==
X-Received: by 2002:a17:90b:1b01:b0:32e:7277:9a81 with SMTP id 98e67ed59e1d1-33b51660588mr28605045a91.4.1760352852137;
        Mon, 13 Oct 2025 03:54:12 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b626403desm11662295a91.7.2025.10.13.03.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 03:54:11 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 13 Oct 2025 16:23:31 +0530
Subject: [PATCH v5 4/5] arm64: dts: qcom: x1e80100: Add opp-level to
 indicate PCIe data rates
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-opp_pcie-v5-4-eb64db2b4bd3@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760352825; l=5084;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=MfR1jV6eq/YYIA14Wj7rCxiMT+Ho24Flcb/t1rnKumY=;
 b=ppwjdO64XNEwf/jv5oUWPu9UGGyQbnkz72uUMal/pVv0HOjBB10u3PzB8mephbeZCQTvLz9ZX
 sPKjbX90MzQCJXHcIm1UurwUjoCSl01D4bRcEPMrrS33/ERfy1tfIeO
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: TiPaTTPawulVL6PzZ_7VBJ3RdNbAA7D8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDAyMiBTYWx0ZWRfXx5tkGq13b+vt
 KUS+rCG+j3SiXraYb6jQm5pBZTEBb8xvMfAEs35CAypDOvrJEyZXkGdgKcGn91IL8fuW3QBoNGt
 l9e7bFlCiOonZIQjMbxg4aY9QEPm/7f4+o9YTp06khXzDKymMFG+m5m42WRLf2SrkqumS0RgeDx
 Schyl1MWQy7biAFDyYrKDtB1Bh6MBfCMdeHYRtWcL6DO8394aSR0e1VBqp9P3y4N9metlaCsLzF
 3aoZQoX8d2nRCKvZlczdNuuyrDbRtTd/DlIUNoQQyqVo5NDnZyW9wNgIIZWOvUOpHWMCFQ/T4nK
 jbpMjDbjSim1vMK+xifu3tnwFAtiwDqkX9buZ71Fn853ZLMTuqNWyQSvzfD2SwKRFFOuTOH+T4p
 nRdvsQ9n46K+lwEj0YBrgfVXA47rUA==
X-Authority-Analysis: v=2.4 cv=SfD6t/Ru c=1 sm=1 tr=0 ts=68ecda55 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=xTuWgevKKEmUOcCBws0A:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: TiPaTTPawulVL6PzZ_7VBJ3RdNbAA7D8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130022

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
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 98 +++++++++++++++++++++++++++-------
 1 file changed, 78 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index 51576d9c935decbc61a8e4200de83e739f7da814..6e931fbd409269be2fd1cc848bcaf0b4037bc793 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -3240,74 +3240,132 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
 			pcie3_opp_table: opp-table {
 				compatible = "operating-points-v2";
 
-				/* GEN 1 x1 */
-				opp-2500000 {
+				/* 2.5GT/s x1 */
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
 
-				/* GEN 1 x4 and GEN 2 x2 */
-				opp-10000000 {
+				/* 2.5 GT/s x4 */
+				opp-10000000-1 {
 					opp-hz = /bits/ 64 <10000000>;
 					required-opps = <&rpmhpd_opp_low_svs>;
 					opp-peak-kBps = <1000000 1>;
+					opp-level = <1>;
 				};
 
-				/* GEN 1 x8 and GEN 2 x4 */
-				opp-20000000 {
+				/* 2.5 GT/s x8 */
+				opp-20000000-1 {
 					opp-hz = /bits/ 64 <20000000>;
 					required-opps = <&rpmhpd_opp_low_svs>;
 					opp-peak-kBps = <2000000 1>;
+					opp-level = <1>;
 				};
 
-				/* GEN 2 x8 */
-				opp-40000000 {
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
+					opp-hz = /bits/ 64 <10000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+					opp-peak-kBps = <1000000 1>;
+					opp-level = <2>;
+				};
+
+				/* 5 GT/s x4 */
+				opp-20000000-2 {
+					opp-hz = /bits/ 64 <20000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+					opp-peak-kBps = <2000000 1>;
+					opp-level = <2>;
+				};
+
+				/* 5 GT/s x8 */
+				opp-40000000-2 {
 					opp-hz = /bits/ 64 <40000000>;
 					required-opps = <&rpmhpd_opp_low_svs>;
 					opp-peak-kBps = <4000000 1>;
+					opp-level = <2>;
 				};
 
-				/* GEN 3 x1 */
-				opp-8000000 {
+				/* 8 GT/s x1 */
+				opp-8000000-3 {
 					opp-hz = /bits/ 64 <8000000>;
 					required-opps = <&rpmhpd_opp_svs>;
 					opp-peak-kBps = <984500 1>;
+					opp-level = <3>;
+				};
+
+				/* 8 GT/s x2 */
+				opp-16000000-3 {
+					opp-hz = /bits/ 64 <16000000>;
+					required-opps = <&rpmhpd_opp_svs>;
+					opp-peak-kBps = <1969000 1>;
+					opp-level = <3>;
+				};
+
+				/* 8 GT/s x4 */
+				opp-32000000-3 {
+					opp-hz = /bits/ 64 <32000000>;
+					required-opps = <&rpmhpd_opp_svs>;
+					opp-peak-kBps = <3938000 1>;
+					opp-level = <3>;
+				};
+
+				/* 8 GT/s x8 */
+				opp-64000000-3 {
+					opp-hz = /bits/ 64 <64000000>;
+					required-opps = <&rpmhpd_opp_svs>;
+					opp-peak-kBps = <7876000 1>;
+					opp-level = <3>;
 				};
 
-				/* GEN 3 x2 and GEN 4 x1 */
-				opp-16000000 {
+				/* 16 GT/s x1 */
+				opp-16000000-4 {
 					opp-hz = /bits/ 64 <16000000>;
 					required-opps = <&rpmhpd_opp_svs>;
 					opp-peak-kBps = <1969000 1>;
+					opp-level = <4>;
 				};
 
-				/* GEN 3 x4 and GEN 4 x2 */
-				opp-32000000 {
+				/* 16 GT/s x2 */
+				opp-32000000-4 {
 					opp-hz = /bits/ 64 <32000000>;
 					required-opps = <&rpmhpd_opp_svs>;
 					opp-peak-kBps = <3938000 1>;
+					opp-level = <4>;
 				};
 
-				/* GEN 3 x8 and GEN 4 x4 */
-				opp-64000000 {
+				/* 16 GT/s x4 */
+				opp-64000000-4 {
 					opp-hz = /bits/ 64 <64000000>;
 					required-opps = <&rpmhpd_opp_svs>;
 					opp-peak-kBps = <7876000 1>;
+					opp-level = <4>;
 				};
 
-				/* GEN 4 x8 */
-				opp-128000000 {
+				/* 16 GT/s x8 */
+				opp-128000000-4 {
 					opp-hz = /bits/ 64 <128000000>;
 					required-opps = <&rpmhpd_opp_svs>;
 					opp-peak-kBps = <15753000 1>;
+					opp-level = <4>;
 				};
 			};
 

-- 
2.34.1


