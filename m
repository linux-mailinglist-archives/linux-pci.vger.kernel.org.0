Return-Path: <linux-pci+bounces-34254-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B045B2BA90
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 09:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8406C7B860F
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 07:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC7B2EB5DA;
	Tue, 19 Aug 2025 07:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fDw5Lhfh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D502C2365;
	Tue, 19 Aug 2025 07:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755587831; cv=none; b=DetkU2aGxXyPOazqOFvdYSwV3dCt0PR02H5EaiUQKdNyM7PziimB58+gYLF3jD1jKh4LxqgpjSfpV5MXxjbiQHTuKA1y17UpKar6NsxAZ8vlsGOVy+A9+0OtDHi/+fbq6GaR7SnlYf+ALqUg+P1N/kqNvxIM42A3hnGazp4XVEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755587831; c=relaxed/simple;
	bh=wsh5BfVW7w3EPHW18YpfGU7tztTcXdNG4hss7f09DIE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bxn6wSGMrGBBRrsisjTteOptXgd46gMqyiOUx5sjE2H42g/EYNDDuq4Xm7Yg7QTIHQBcIZct5x0C99xU2JU1H5DcD1QJ5mJUxGnveU4HdilRwoMaAHvB9Z5oAerx38tOpZHPnTLc+V3CwhMtxoYCOsyO7CXvE4NWr9s3VJiMRyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fDw5Lhfh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57ILgfNk026592;
	Tue, 19 Aug 2025 07:17:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=H5QDIlgZhVEw3Dtlp9D9mUIdHrXDnQNN+e7
	HzAzOPIo=; b=fDw5LhfhG/eyF1H0OpzmdupSL3omUxs1xVgCx8PxH0nlyvqHXjF
	ei+IuiMTnuG06kTmUHMrmZ3li+bORg9bsgXqclOZf/vebMMPlNX8PisXPhvMjlW0
	3K71HIbcrYYxKwcbULItbMQINutvZ4YXKFiyZ62iZQxUx/Iss9NLn28AcUKDHXIV
	aoZJtH0XTXdL4NBeWlL0RCQ03ZoeOyKRXH233cHjekAES3XHkUNJQZ1etpy4C8i5
	1DH+OYdXqorMCb0oYVhX7MA/BIrMCbLryZVSImGEnju5YFHSW6BAiKiCPNHcDOfO
	AsYy+63UifvD7PgRUwyFzoBdxuwMs469UrA==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48mca5h91w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Aug 2025 07:17:00 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 57J7GvTO031751;
	Tue, 19 Aug 2025 07:16:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 48jk2m3ekr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Aug 2025 07:16:57 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 57J7GvBK031742;
	Tue, 19 Aug 2025 07:16:57 GMT
Received: from ziyuzhan-gv.ap.qualcomm.com (ziyuzhan-gv.qualcomm.com [10.64.66.102])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 57J7Guix031722
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Aug 2025 07:16:57 +0000
Received: by ziyuzhan-gv.ap.qualcomm.com (Postfix, from userid 4438065)
	id 1F01A51C; Tue, 19 Aug 2025 15:16:55 +0800 (CST)
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
        Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
Subject: [PATCH v5 0/3] Add Equalization Settings for 8.0 GT/s and 32.0 GT/s and Add PCIe Lane Equalization Preset Properties for 8.0 GT/s and 16.0 GT/s
Date: Tue, 19 Aug 2025 15:16:45 +0800
Message-ID: <20250819071649.1531437-1-ziyue.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
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
X-Authority-Analysis: v=2.4 cv=FdU3xI+6 c=1 sm=1 tr=0 ts=68a424ec cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=86bffDG3X0gLe1KFPuUA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: WxFVZs_Fwo5aKPzD9KG2jo39w06X4rUM
X-Proofpoint-GUID: WxFVZs_Fwo5aKPzD9KG2jo39w06X4rUM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDIwMiBTYWx0ZWRfXywtO31nzvZLw
 quQPjX1jSty5pk8m79kfew6M6JJsOQYML4yiWBVyIdLeqndZBgLmy88udXzMboeWE6Kt6Tw8nKd
 RNa9ulvnQxkf9P/h4mgxXI9vjokUjVuKOBmkmws9MTVNAdXAsZitRXzYokqGjFJt1280LbeyCsL
 jOQTRWSQpHm5VRetcSAprpWpySsaglMGhC8UcUnL/oJZZZ4lio47gD/4T+Je5WJXYlabvBhSZyA
 xXsQWGEEyzvJBr3mIigLU58+lMBW7RPNiva8WgYhMLuUDQoDmued7DkrE3ezxSj1x+v7gjOqFxR
 zAc+sr5HGB6UforULat9Ysj0diA8RQ3QF0hmwbTmGsrSJrUwV+4S4pKQ7atLtbNluJUD/3qVaux
 QWetWxzd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508180202

This series adds add equalization settings for 8.0 GT/s and 32.0 GT/s,
and add PCIe lane equalization preset properties for 8.0 GT/s and
16.0 GT/s for sa8775p ride platform, which fix AER errors.

While equalization settings for 16 GT/s have already been set, this
update adds the required equalization settings for PCIe operating at
8.0 GT/s and 32.0 GT/s, including the configuration of shadow registers,
ensuring optimal performance and stability.

The DT change for sa8775p add PCIe lane equalization preset properties
for 8 GT/s and 16 GT/s data rates used in lane equalization procedure.

Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>

Changes in v5:
- Add support for 32.0 GT/s
- Add warning print for speed higher than 32.0 GT/s (Mani)
- Link to v4: https://lore.kernel.org/all/20250714082110.3890821-1-ziyue.zhang@oss.qualcomm.com/

Changes in v4:
- Bail out early if the link speed > 16 GT/s and use pci->max_link_speed directly (Mani)
- Fix the build warning. (Bjorn)
- Link to v3: https://lore.kernel.org/all/8ccd3731-8dbc-4972-a79a-ba78e90ec4a8@quicinc.com/

Changes in v3:
- Delte TODO tag and warn print in pcie-qcom-common.c. (Bjorn)
- Refined the commit message for better readability. (Bjorn)
- Link to v2: https://lore.kernel.org/all/20250611100319.464803-1-quic_ziyuzhan@quicinc.com/

Changes in v2:
- Update code in pcie-qcom-common.c make it easier to read. (Neil)
- Fix the compile error.
- Link to v1: https://lore.kernel.org/all/20250604091946.1890602-1-quic_ziyuzhan@quicinc.com

Ziyue Zhang (3):
  PCI: qcom: Add equalization settings for 8.0 GT/s and 32.0 GT/s
  PCI: qcom: fix macro typo for CURSOR
  arm64: dts: qcom: lemans: Add PCIe lane equalization preset properties

 arch/arm64/boot/dts/qcom/lemans.dtsi          |  7 +++
 drivers/pci/controller/dwc/pcie-designware.h  |  5 +-
 drivers/pci/controller/dwc/pcie-qcom-common.c | 58 +++++++++++--------
 drivers/pci/controller/dwc/pcie-qcom-common.h |  2 +-
 drivers/pci/controller/dwc/pcie-qcom-ep.c     |  6 +-
 drivers/pci/controller/dwc/pcie-qcom.c        |  6 +-
 6 files changed, 50 insertions(+), 34 deletions(-)


base-commit: 3ac864c2d9bb8608ee236e89bf561811613abfce
-- 
2.43.0


