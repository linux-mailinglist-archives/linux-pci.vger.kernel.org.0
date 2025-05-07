Return-Path: <linux-pci+bounces-27317-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EA4AAD3EA
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 05:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D070B4E815A
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 03:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F731DD0D4;
	Wed,  7 May 2025 03:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="miPKMmkE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50D51D516C;
	Wed,  7 May 2025 03:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746587783; cv=none; b=tBoV2ho7tPJEQD6+jeraCYn8PYF4AxEWTVVO3F0We/9lknSP8jUaQYC3dVfTuf9RtUcyLjPa4gBQwDImGiM3mTsl2e+/ccLHTdO2tWnp3BtEGoYMQnakCLG1kwMtEQhkIc9VCfuSbjwMyWUVhdKZgBRswfbOmf+2DUm7fpAOdcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746587783; c=relaxed/simple;
	bh=qnih2Q3fDdHNxkI+GRo65pjwV5RPh3Ol6SJVr1A8jHc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h9WqU4OGpjDxpUXib1aUaKLirG81A7TE4oM7K7PgXzUCkHxdCTFBNGhj2/LTpVLIZWICVLMVwiei6zMZSUglEKqdp4NfnmwWlJ1Oo1XXXar9dNoPXQYkBU8907P72z6Wa7HoZSzuWdecLRLl9XT6Wrr/m4Nipj8++YA3qx1cLRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=miPKMmkE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5471HA0A028443;
	Wed, 7 May 2025 03:16:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=mBH+GfjC+j4
	rk6f5spyQReEfLrRh87IzYlgQYCkCLVE=; b=miPKMmkE7IUbIRNtQ7ExES3qVRT
	y6VNjiJtvtNmkDONqoq8t3pFbnqsBS6Q07IxeTvet3r9/jjsBtZRMheds1l/mpty
	e36Z1EqANEAL8zevTGkKyy6EvS7Dl8VyyzrzBt5AEiL8cCLZJ4d0pM5T21Ifvq1S
	OBpCKKt6BNjgR4WzAwH/aQNU79tCY6CO02FtJHgAebdlKIGFg+jm8GzwFUg04yId
	ZIomBxHBNwG5MqkRStkS5gg9CwxXPkQ3QWovSTmVGo4bF1ecUCUOzDszx5kotrJy
	CQ3YzOgN6C5LhCcJNXwnLLTpyVg14wwyw7Z/hu8zMFpHus/HXG+haEIxz5A==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46fguujdm8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 03:16:08 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 5473G6Wh012882;
	Wed, 7 May 2025 03:16:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 46dc7m60u7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 03:16:06 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5473G6Fd012872;
	Wed, 7 May 2025 03:16:06 GMT
Received: from cse-cd02-lnx.ap.qualcomm.com (cse-cd02-lnx.qualcomm.com [10.64.75.246])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 5473G5UT012850
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 03:16:05 +0000
Received: by cse-cd02-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id 6E1DC2F3B; Wed,  7 May 2025 11:16:04 +0800 (CST)
From: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
To: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, dmitry.baryshkov@linaro.org,
        neil.armstrong@linaro.org, abel.vesa@linaro.org,
        manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org, kw@linux.com,
        bhelgaas@google.com, andersson@kernel.org, konradybcio@kernel.org
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, quic_qianyu@quicinc.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Subject: [PATCH v4 5/5] PCI: qcom: Add support for QCS615 SoC
Date: Wed,  7 May 2025 11:15:59 +0800
Message-Id: <20250507031559.4085159-6-quic_ziyuzhan@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250507031559.4085159-1-quic_ziyuzhan@quicinc.com>
References: <20250507031559.4085159-1-quic_ziyuzhan@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=UJPdHDfy c=1 sm=1 tr=0 ts=681ad078 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=esfGit-853AAzAUiwWkA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 3WpzF2Oqrl6K4vRWJJuGu_l1uO9H_uRi
X-Proofpoint-GUID: 3WpzF2Oqrl6K4vRWJJuGu_l1uO9H_uRi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDAyOCBTYWx0ZWRfXwquaN+suwMwz
 3T79lXxS3Epo1Xg2nKksU3X9jrwz4Y7oluD9axJgGJSFEoD95q/JXwzJoSkumMCKDvOGDluZloQ
 eiX8s4HnuaXX+PxkamHcNfdEiTzxyYS3xfox5UBu7mPBYJboPOBMGrZ7YyHIGi5eMhiZlbwv5wF
 sOLhlUWS7nI614ZcTZ0Y83MrZa9KAFSAWuCx1PiQCW+IWhPcvrPLwlIOjJRu7nhgjVW6iVLKXop
 hAYtejsHJhWZaU7vbaFTd1CQjGZKVFZ8ZbQVbIGqwJTxZVESVNirjSZqKOPVRJCrpRBF5xUxNZ6
 xlTBrxsNGMfUHXkgtJPvJJBw6n00q/qoVIkFxoGDRYDEqeXiBl9VmtTmnVorx6GZOZ+tzd6xujK
 2mxLk3FtcZrp11+QWBxFySVFLyWn0HFoWFHa3BzLHLt0+Fep11xgAX9L/BM3bj2rcc/D7DnE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_01,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 phishscore=0 spamscore=0
 impostorscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505070028

Add the compatible and the driver data for QCS615 PCIe controller.
There is only one controller instance found on this platform, which
is capable of up to 8.0GT/s.
The version of the controller is 1.38.0 which is compatible with 1.9.0
config.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index dc98ae63362d..0ed934b0d1be 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1862,6 +1862,7 @@ static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-sm8450-pcie1", .data = &cfg_1_9_0 },
 	{ .compatible = "qcom,pcie-sm8550", .data = &cfg_1_9_0 },
 	{ .compatible = "qcom,pcie-x1e80100", .data = &cfg_sc8280xp },
+	{ .compatible = "qcom,qcs615-pcie", .data = &cfg_1_9_0 },
 	{ }
 };
 
-- 
2.34.1


