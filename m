Return-Path: <linux-pci+bounces-30585-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D19AE7B19
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 10:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97B2F3AE3B1
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 08:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBCA285CB1;
	Wed, 25 Jun 2025 08:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="APlbAUrV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D8527991E;
	Wed, 25 Jun 2025 08:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750841898; cv=none; b=VbaYF6nmuiCYxrZWKyarJiCktIiwGT01Wxk936E6ed2vC5C1WU2WHAL/UI0GhM4b0Nu00HyRT9P7taR/GnmUWRmuogkajy1YFi7/BSfhMfLeLUgP3rKV45wB8ueOM69beyCyPZc8aoILB0Yz2sICSjstluUo3mhsMKqinP9Z95U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750841898; c=relaxed/simple;
	bh=9E8dZ2XhVSOUnzuSWos6Vw8+2xKd23JsxUsojcAZsvM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nkpxc6saWTzEjYZHiIDzyVzaZTztHbj2cjki+j3bDpV96mv7vYcRkbWxWl5jtwj7i/Vgn56lubL4otFrb+mQdAqoB8akSvpaqHQjGYmgdbUumjzeyn/esvG8236PHgCPNUjnkmuiHOfUsv5+TDoUwduJO+cQdP1lyf2LjI5N27Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=APlbAUrV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55OMaosk001992;
	Wed, 25 Jun 2025 08:58:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ACLcf/y0+ET
	DyqcTSQT5zp0eSvdxWWbD7AwNu/+16gI=; b=APlbAUrVvsczEIG2q/sv/9pjPS9
	hrXtAIybkhYpLE9DQ1RXYVfv6dfd2QR1pIQjCywn6qPJW+Va2JiREaNIZESlqjtU
	wA1lMkNG7eNBEgPe6f3C+0n8XLQmrHqDs3i0NNiiiDL1G48vmvRqKfl8rLDVlouF
	p1ASX3HvbCTnF6E5IkFVSc2Oe5c/2h9DZEafc5kTA3LDbufUV44rGF0lQXJlj4Q0
	YVxJKdNsbJ6oH3d1dQXgIL6Qz+jPGzRH1Jlzlk6wey4uF4kHb5vgUU2Zrr+Z7PV1
	ylnY7yEqEYiMH9pNbc2Kia8W/vFoScAl9RtDCbJZfyf23OL8YUUjCFsRtnQ==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47evc5r93j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 08:58:07 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 55P8w5Tb016621;
	Wed, 25 Jun 2025 08:58:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 47dntmarvf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 08:58:05 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55P8w511016610;
	Wed, 25 Jun 2025 08:58:05 GMT
Received: from cse-cd02-lnx.ap.qualcomm.com (cse-cd02-lnx.qualcomm.com [10.64.75.246])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 55P8w3oM016595
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 08:58:05 +0000
Received: by cse-cd02-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id DE6823832; Wed, 25 Jun 2025 16:58:02 +0800 (CST)
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
        Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Subject: [PATCH v3 2/3] PCI: qcom: fix macro typo for CURSOR
Date: Wed, 25 Jun 2025 16:58:00 +0800
Message-Id: <20250625085801.526669-3-quic_ziyuzhan@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250625085801.526669-1-quic_ziyuzhan@quicinc.com>
References: <20250625085801.526669-1-quic_ziyuzhan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HxYKdiPbDXQxbeAyny8s_WQWMbx61R_o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDA2NSBTYWx0ZWRfX/DgreZ0KCqjG
 H9voMUpVoF24dxd0ZN70yPGAJ0XewqVPgIOHEkz0t604hS5Krei0KSIAa2JR/c/vA9nzOR5/T6w
 7aXOjpNZZRI3coOm1t5+fN+YrkLZVfgFCSoOkFObAUvx1jstS+BT27ZC+P8Q7uP2itqcWIOFbXr
 Nb/AriuFKytawh0NhB/oo1OP6xL6yxea0Pq08HTua1fI7xkvYyekShujeapJh4HBtkCBVHjFp7I
 ILHKbGcHtygo4GrHay3nip/j7s6phq5s4kg3zdHOgdW3O8vV+OGHbldIEbVFuNNpt0wVZgJ21zm
 ZwfOqCoL0oaVVNFUg1YPDFXONFc+e+NX1kCHApnKwq4JystUaIgiInXgMJ+37PPQVzJ0C1Kx0XV
 RyZtEfKiDxQ6btapmpYgPSkaAYC75ssYy+E+EjzyZqdQ9R/kpWiuNJ8v/eIIP3A5sDoNnsUs
X-Authority-Analysis: v=2.4 cv=caHSrmDM c=1 sm=1 tr=0 ts=685bba1f cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8 a=yZn9HN9ZKZZuwR4VxpAA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: HxYKdiPbDXQxbeAyny8s_WQWMbx61R_o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_02,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxlogscore=889 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 mlxscore=0 spamscore=0
 malwarescore=0 phishscore=0 clxscore=1015 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506250065

Corrected a typo in the macro name GEN3_EQ_FMDC_MAX_PRE_CURSOR_DELTA and
GEN3_EQ_FMDC_MAX_POST_CURSOR_DELTA to ensure consistency and avoid
potential issues.

Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-designware.h  | 4 ++--
 drivers/pci/controller/dwc/pcie-qcom-common.c | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 388306991467..80831f99d72d 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -137,8 +137,8 @@
 #define GEN3_EQ_FB_MODE_DIR_CHANGE_OFF		0x8AC
 #define GEN3_EQ_FMDC_T_MIN_PHASE23		GENMASK(4, 0)
 #define GEN3_EQ_FMDC_N_EVALS			GENMASK(9, 5)
-#define GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA	GENMASK(13, 10)
-#define GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA	GENMASK(17, 14)
+#define GEN3_EQ_FMDC_MAX_PRE_CURSOR_DELTA	GENMASK(13, 10)
+#define GEN3_EQ_FMDC_MAX_POST_CURSOR_DELTA	GENMASK(17, 14)
 
 #define PCIE_PORT_MULTI_LANE_CTRL	0x8C0
 #define PORT_MLTI_UPCFG_SUPPORT		BIT(7)
diff --git a/drivers/pci/controller/dwc/pcie-qcom-common.c b/drivers/pci/controller/dwc/pcie-qcom-common.c
index ed466496f077..86ed86b72d5a 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-common.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-common.c
@@ -35,12 +35,12 @@ void qcom_pcie_common_set_equalization(struct dw_pcie *pci)
 		reg = dw_pcie_readl_dbi(pci, GEN3_EQ_FB_MODE_DIR_CHANGE_OFF);
 		reg &= ~(GEN3_EQ_FMDC_T_MIN_PHASE23 |
 			GEN3_EQ_FMDC_N_EVALS |
-			GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA |
-			GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA);
+			GEN3_EQ_FMDC_MAX_PRE_CURSOR_DELTA |
+			GEN3_EQ_FMDC_MAX_POST_CURSOR_DELTA);
 		reg |= FIELD_PREP(GEN3_EQ_FMDC_T_MIN_PHASE23, 0x1) |
 			FIELD_PREP(GEN3_EQ_FMDC_N_EVALS, 0xd) |
-			FIELD_PREP(GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA, 0x5) |
-			FIELD_PREP(GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA, 0x5);
+			FIELD_PREP(GEN3_EQ_FMDC_MAX_PRE_CURSOR_DELTA, 0x5) |
+			FIELD_PREP(GEN3_EQ_FMDC_MAX_POST_CURSOR_DELTA, 0x5);
 		dw_pcie_writel_dbi(pci, GEN3_EQ_FB_MODE_DIR_CHANGE_OFF, reg);
 
 		reg = dw_pcie_readl_dbi(pci, GEN3_EQ_CONTROL_OFF);
-- 
2.34.1


