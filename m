Return-Path: <linux-pci+bounces-35433-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0636B432E0
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 08:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B20F2582CED
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 06:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A2628688A;
	Thu,  4 Sep 2025 06:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eKkByZlU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F160B2798E8;
	Thu,  4 Sep 2025 06:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756968770; cv=none; b=AI4WwkGfXwQjCiyTUNiqiJwW0IgaXHbuJuIAq/Yr7vNhT/yZI6Zxdz7qDZ3n6HEjQlW0eyDo1PZgqRNLJIb8vYKFzbpwUHnFkptpcWtp6X0S9bzclHBHKChtKdpgQB9UW9kEXav2ygEROCQIzCAm3/CXBQp+1i7JSDZa0/eLrGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756968770; c=relaxed/simple;
	bh=LmteC8eEXyQFdu1T3XeqZ6nxdjNpge73D7sRNjjdvU4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BNgtCXTNXyJXUG9+EM99hyiP7vU0JzJ7mS6GCKMzrj5LJLnW2R3nT1O5oqXEsxWa4heUwZAcQOZTXSW3EdvzGZdPGMpQyUnc/ch7qGr8IZ0qqwSDeCNkgyZXEag0b0LEHNBNFZoGtzpniW1giCtbaNjKLOVMCFe8SKdCIOcY8dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eKkByZlU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5841ZnND017552;
	Thu, 4 Sep 2025 06:52:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=ShvfqUKiwT9ZBAvm/aHo7/nEYaAn/E/Q0Vx
	P5kLXaiw=; b=eKkByZlUwtyAPzIH0dHWq/jqdDHEp6kCBs53SRaKzirc9Vyq2J9
	cxGZTTJGKsjulfAV1FGvcczxPThM6Bgox013pkx4irpA+WY6SXKpifp8ZWlZ5C4h
	erV4mAtWNLClEmCj8zmLPqaW2mcFwCUZ/LJikJy+V7Tj6WFvcIk8r82dJO1MJrQO
	qpa3fW7GLgBy1lAS2a19smnnFGwywbgYt8JYJaxiGrdRp3VIyeGGKJeWfDIXRwj0
	xFrV0mByddjU3HNSEcJ6r8a5nAJkllWNwCNp8+bO+OeaxU7JUCCDlYArS2x8ImYh
	i4mt7ADYyKTJ5bnrvtYEw4rnOWHosh7rFuw==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48xmxj31s7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 06:52:37 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 5846qZWV016337;
	Thu, 4 Sep 2025 06:52:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 48utcmhjct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 06:52:35 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5846qYQM016326;
	Thu, 4 Sep 2025 06:52:35 GMT
Received: from ziyuzhan-gv.ap.qualcomm.com (ziyuzhan-gv.qualcomm.com [10.64.66.102])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 5846qYEg016323
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 06:52:34 +0000
Received: by ziyuzhan-gv.ap.qualcomm.com (Postfix, from userid 4438065)
	id 187CA51C; Thu,  4 Sep 2025 14:52:33 +0800 (CST)
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
Subject: [PATCH v6 0/3] Add Equalization Settings for 8.0 GT/s and 32.0 GT/s and Add PCIe Lane Equalization Preset Properties for 8.0 GT/s and 16.0 GT/s
Date: Thu,  4 Sep 2025 14:52:22 +0800
Message-ID: <20250904065225.1762793-1-ziyue.zhang@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAzMDExNyBTYWx0ZWRfXyfnAjN4vVhD9
 9c7vMbN9u97VPReMY9o9nQoOh+pQmef+14Cm1FJWbLBuJembSN0L0jBq6l26d3z1IzAzCdTNvvB
 gImYulOYRKW2D4RJsSpZ4yDhZylMsBqBoSGZIywo19h94aIJ/ItSJb2hu00GztvqpogHfn8Ryff
 ChmEALK+CTYdmPVERHZ6AgklA+glXJaYTEGmQLUoCR69MEZIFdhS5ForiTBljkQIr0isLy7DJQU
 bqqsM+W06E4Y6HQtpdGinPr6ioS+xrm9p7PtzIni4z0JMt9UmR/zOmEKg/x/gFE6+/TIqr+UQN7
 ghx8nlT/6DNZwNciOUKLya+pV8WpKLYF8x4rBUpPREtnEDsf6xsJPGKfdQK6yXsm1t3tgjt0G0a
 EFZ7HPn6
X-Authority-Analysis: v=2.4 cv=a5cw9VSF c=1 sm=1 tr=0 ts=68b93735 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=86bffDG3X0gLe1KFPuUA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: kVNBCdZ9dKbyxkZiL8WJT9dZNLzNT4d-
X-Proofpoint-ORIG-GUID: kVNBCdZ9dKbyxkZiL8WJT9dZNLzNT4d-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509030117

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

Changes in v6:
- Add Fix tag and format as Xmax order (Mani)
- Delte the blank line (Neil)
- Link to v5: https://lore.kernel.org/all/20250819071649.1531437-1-ziyue.zhang@oss.qualcomm.com/

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

 arch/arm64/boot/dts/qcom/lemans.dtsi          |  6 ++
 drivers/pci/controller/dwc/pcie-designware.h  |  5 +-
 drivers/pci/controller/dwc/pcie-qcom-common.c | 58 +++++++++++--------
 drivers/pci/controller/dwc/pcie-qcom-common.h |  2 +-
 drivers/pci/controller/dwc/pcie-qcom-ep.c     |  6 +-
 drivers/pci/controller/dwc/pcie-qcom.c        |  6 +-
 6 files changed, 49 insertions(+), 34 deletions(-)


base-commit: 3ac864c2d9bb8608ee236e89bf561811613abfce
-- 
2.43.0


