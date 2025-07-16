Return-Path: <linux-pci+bounces-32208-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1CFB06BF9
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 05:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0343F178F44
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 03:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C88279DCB;
	Wed, 16 Jul 2025 03:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f/Cm3yBO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C242797BD;
	Wed, 16 Jul 2025 03:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752635188; cv=none; b=kMQrb+JKpbL4aOJglROAkbeg4geLIp1RwfZSYHA3n0LW8EGCe49EwAqFDsZcd3XnQEHNhbSVeR+JxLl5XRChA2/HuNG2Ma4dRGGdKu15BocdrCon17oytWPemDergXwTTVnjzEtkL0aBNFxPAatuN87bMxRtk2H/WDqEii4NMvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752635188; c=relaxed/simple;
	bh=dCp/UCpr4GavL9cgZvFa6YTICidgQ0aooqsKTZtkXtY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=VBgCvFtvfbRxr/rc58y6Yf+reaZ/T/VE/fT6mcNcaxW3sMPUW7HRcYXcaHNhUy59xB6wsQtfU6DxCguFQ/mAz5yWczKMk/BGZ6pQsh3Eb3Y2Xe84x+0ZwM+hCpskRLe3IPq1jfh5mgt6XfAAaXyh1ixFJ54MwUEScPV8TFrZd/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f/Cm3yBO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FGDU72008226;
	Wed, 16 Jul 2025 03:06:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=YM4m4LvwJpEIvXehHnO+Z9
	OI4GIz8l3zpiUHNdqZPDw=; b=f/Cm3yBOnsfQ6nHMxBkcHS7dIXey6ipeM8VvhD
	Z7wACvSWrDQIYXTzoIic2mkFuK8SFbzqy5bRf3hDc34/w9IRyhOEta2Fi1cHTE30
	bwGyhpLhwObsKIuxzkpElmuJe2LO7n49Sx6t2Hwau9eLy2hP8GNhY4FddCmDzg94
	iS4bwn9M2eSEeSaJq4kNpb6bwddwQEkbPV90BzblV5ah8IQx8Hy+c6sOoFZt2aBU
	JT/xGbx+H44eYK5m04BwdsZN0gbpvH4Y52y7DTCjH+aZa25ENoLwQVBtfvYeXXYm
	YkOP2ic+5zOjOnxEX5J4O+oolQ4gzCaGpSO8o0ESNdR9vIhg==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wnh5tfqd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Jul 2025 03:06:13 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 56G36BsF018523;
	Wed, 16 Jul 2025 03:06:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 47ugsmhveh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Jul 2025 03:06:11 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56G36BuD018518;
	Wed, 16 Jul 2025 03:06:11 GMT
Received: from cse-cd01-lnx.ap.qualcomm.com (cse-cd01-lnx.qualcomm.com [10.64.75.209])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 56G36ANd018476
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Jul 2025 03:06:11 +0000
Received: by cse-cd01-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id CC98F2122F; Wed, 16 Jul 2025 11:06:09 +0800 (CST)
From: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, jingoohan1@gmail.com,
        mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
        bhelgaas@google.com, johan+linaro@kernel.org, vkoul@kernel.org,
        kishon@kernel.org, neil.armstrong@linaro.org, abel.vesa@linaro.org,
        kw@linux.com
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, qiang.yu@oss.qualcomm.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>,
        Tingguo Cheng <quic_tingguoc@quicinc.com>
Subject: [PATCH v1 1/1] arm64: dts: qcom: qcs615: Set LDO12A regulator to HPM to avoid boot hang
Date: Wed, 16 Jul 2025 11:06:01 +0800
Message-Id: <20250716030601.1705364-1-ziyue.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=dKimmPZb c=1 sm=1 tr=0 ts=68771725 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=ae3z3FTj68mGPq7uMvUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 7NYoC0pDTzXfesvzBybFEgEklgYO2ZeW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDAyNyBTYWx0ZWRfX4X0cQHxWGj4q
 XkHVzEkBuBdsXGMEXqODLnR88M2hLK0mJhINAZRZElv6t4uDforEm+VsJYzGlBLvUE/TJa/WWDX
 hBKLk1NRS3bViNMvPHJ3XK9TGsxLQRjWHeSN6jhxznkGcA++ugD77/FDblJaFbkyRzSHmGTl90r
 cRQIXWCmGFBfU9yGbMBPd3i4UNibvsYTWANWfPr6jjA6S4dEikj8SOKaNm7mp55NxFbLfzzXP9y
 i8W2IWQr5XclWKUCNhk15iYMPCwRaDHX6xGu8sSuqmZvLrQmaNKKZRy1Ewam2DubGOOjmHAQkJE
 GzzhULZka8tL60ubAKB6lAKhcs/BRV0oB1gGGDyhQxxOr2Fv+HxqzYlF4Qf7aEo6sfvo6HRnvrK
 iU834tHm81vV03X6uPCBONwSNVnv96Jkbv6sazs0dz8U9oNsZlD8M056w1uvvQhxZuyvQgxn
X-Proofpoint-ORIG-GUID: 7NYoC0pDTzXfesvzBybFEgEklgYO2ZeW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_01,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507160027

On certain platforms (e.g., QCS615), consumers of LDO12A—such as PCIe,
UFS, and eMMC—may draw more than 10mA of current during boot. This can
exceed the regulator's limit in Low Power Mode (LPM), triggering current
limit protection and causing the system to hang.

To address this, there are two possible approaches:
a) Set the regulator's initial mode to High Performance Mode (HPM) in
   the device tree.
b) Keep the default LPM setting and have each consumer driver explicitly
   set its current load.

Since some regulators are shared among multiple consumers, and setting
the current must be coordinated across all of them, we will initially
adopt option a by setting the regulator to HPM. We can later migrate to
option b when the timing is appropriate and all consumer drivers are
ready.

Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
Signed-off-by: Tingguo Cheng <quic_tingguoc@quicinc.com>
---
This patch follows a suggestion from Bjorn Andersson regarding USB
regulator handling where each consumer is expected to explicitly set its
current load.
Link: https://lore.kernel.org/linux-arm-msm/37fc7aa6-23d2-4636-8e02-4957019121a3@quicinc.com/
---
 arch/arm64/boot/dts/qcom/qcs615-ride.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs615-ride.dts b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
index a6652e4817d1..7639635c67c4 100644
--- a/arch/arm64/boot/dts/qcom/qcs615-ride.dts
+++ b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
@@ -166,7 +166,7 @@ vreg_l12a: ldo12 {
 			regulator-name = "vreg_l12a";
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1890000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 			regulator-allow-set-load;
 			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
 						   RPMH_REGULATOR_MODE_HPM>;
-- 
2.34.1


