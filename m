Return-Path: <linux-pci+bounces-32359-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6025FB0869B
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 09:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18A447B914C
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 07:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390EB22CBFE;
	Thu, 17 Jul 2025 07:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jJxHHA9z"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F07122DFA4;
	Thu, 17 Jul 2025 07:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752737286; cv=none; b=OtYLovjuAHn6Y32eMlogwMD3phPxzDI+QrVK6Z6pB29MMl/3qY0V2JB6lyr6DAihE26P1JiOVEk0N4qvlUfoh0ziJ26elGEJY6bXVIKC/yN1dapyGwtsey5SS9CD1y0QJ+49KGOdCyCD8bF4vclhTMuVjHcMsbe02BeyEcsNEIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752737286; c=relaxed/simple;
	bh=iNGfZUT3vIjs9LIEtmZBN/64+7hv7dRJ5bx0l4MtKW4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=dShpJutaTL6VGlfPda2lXhtPC8nu+br17DV+rVand0eOKK15p2uDJvU/4VajneLTUGq7CRfZ3CzYoSvhVL3euSJ+53F8fmvSRJtZKh22PxpuABwnobz6GigMmQRHXVpvJWqQWb4+ELVZAwvLnvDqp9i1n5+VfSiqO0arRQd2B9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jJxHHA9z; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56H5PRRQ021567;
	Thu, 17 Jul 2025 07:27:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=d14ckrCMuZgzNHnUDuNhFN
	FqmXjLNb/Tp604F/4Ov/w=; b=jJxHHA9zif7whnGBq6dKLlrJx/7GYbLey9+/d+
	cRsmwsMQm90sDNCQuW/HUQ0hFWwPYW21QOmRq/4Yzxs1PHkKrNjoBrvv8qAx/ULD
	ZyYAmMrQi0kXLJli7LTk5Gn8cewbLaVhgu2Y53H+/gatcuk3csI0nfiUUO+8XJVH
	noTVufU4NjojMPXi6MHcie6SWZM8mRn5b8XDbxh6YnaRP4V7D9mga7ylMynT+LF5
	IGS839uV22m1QEqzOapG0m9hWJ2f+hT4qAyKoXP/FvyWNDW1vvRZbCfiaQ1j0G07
	VZpknn7w/EVbom6pdkFIWaLpHUet7HTduqecRTYLyuN7ERlw==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufu8ejj9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 07:27:53 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 56H7RotA029527;
	Thu, 17 Jul 2025 07:27:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 47ugsmt61c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 07:27:50 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56H7Rn30029522;
	Thu, 17 Jul 2025 07:27:50 GMT
Received: from cse-cd01-lnx.ap.qualcomm.com (cse-cd01-lnx.qualcomm.com [10.64.75.209])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 56H7RmgQ029519
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 07:27:49 +0000
Received: by cse-cd01-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id E8A3D20CAF; Thu, 17 Jul 2025 15:27:47 +0800 (CST)
From: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
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
Subject: [PATCH v2 1/1] arm64: dts: qcom: qcs615: Set LDO12A regulator to HPM to avoid boot hang
Date: Thu, 17 Jul 2025 15:27:46 +0800
Message-Id: <20250717072746.987298-1-quic_ziyuzhan@quicinc.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDA2NCBTYWx0ZWRfX7K9LvX4f/Cko
 auYN982UNh+2cpgz6cn0/ECv8V71k+igsCBotfCN0/0FFRmBWCgVTipTlTOUxLUvSoCHtNrmjfN
 uWVHv6pmdNUdrSIFJu/fqZEybVuBxRcg1uVwxmMd/IhU0oJ4wJeWO7l9xNE5kgKrDv8E0H1pQN+
 RuYy6jmWbGAYA8MoFQIuP/XoMnOrtA/mjVosi3weNFmLiusVOMm62KLM/4wEnGkcknIi/9C6cjP
 TIVvVtx+pF6s6OFa+SiUqlclJoTnr9jGbjbj6KAU6RWlLMlw7StkvVWdZT1HaVjEadasX61eHek
 8BGOHwlU6qoBPdtsww0iPSIYVgGELbjtu4IrX60owWdYT+8gXZejaJ9aXq4ZrRtiREo4fsuOgAc
 xkkdnh1KlucjVH4XcRiLYIJVgFnWEGsAR5r17X7MtC9MCByNf8abScURQngBOqdJGcZNTZ6l
X-Proofpoint-ORIG-GUID: 3xaLGOW8Gc40F4fpnWAo7K_NMNc0-Pa4
X-Proofpoint-GUID: 3xaLGOW8Gc40F4fpnWAo7K_NMNc0-Pa4
X-Authority-Analysis: v=2.4 cv=f59IBPyM c=1 sm=1 tr=0 ts=6878a5f9 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=lOb7t7NH7aykvVN8AcwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170064

From: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>

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

changes in v2:
 - Delete all LPM mode config in ldo12a, which may lead to potential
   risks
 - Link to v1: https://lore.kernel.org/all/20250716030601.1705364-1-ziyue.zhang@oss.qualcomm.com/
---
 arch/arm64/boot/dts/qcom/qcs615-ride.dts | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs615-ride.dts b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
index a6652e4817d1..75effc790c79 100644
--- a/arch/arm64/boot/dts/qcom/qcs615-ride.dts
+++ b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
@@ -166,10 +166,7 @@ vreg_l12a: ldo12 {
 			regulator-name = "vreg_l12a";
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1890000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
-			regulator-allow-set-load;
-			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
-						   RPMH_REGULATOR_MODE_HPM>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
 		vreg_l13a: ldo13 {
-- 
2.34.1


