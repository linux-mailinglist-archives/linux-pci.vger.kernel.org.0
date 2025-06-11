Return-Path: <linux-pci+bounces-29404-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE07AD511D
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 12:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFA2C3A8DF2
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 10:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB512749C8;
	Wed, 11 Jun 2025 10:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iKTGgywB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A03D274665;
	Wed, 11 Jun 2025 10:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749636256; cv=none; b=P3mT/1y9wLVu5dq0WFvEhPwrV4C5RwyU/e5eFzzeJqRQEMcB8CcR9hXVjOD2opFMx2MHhfvZoUQ184zrAcHKVJAFqxQVKTNNOOLt8B6a59jQVZKcNXT2ETnRmKdaClPi1Ye+bHjuSs2c/tlkkEWI7O7qLH4J6aBK051GuyX9mVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749636256; c=relaxed/simple;
	bh=MQxk7xPXeniS2BjlOZlPQs8xv4mzge4Nvm454psHvs0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lCdeywsitf0c0Tg8OxstTrrYl0EtrZTUBtKGindpccd8O6cjTEhY/orl45anrPedLJsuxH4CJ+qWdwHFQ8yiGJLj4B6lRBlNZ4SEjPnzvwidGhDNd0zigwhsDzWR/l98T3K1xEdCF6fG5JA2UC9lecb8/WJUPwMi2IPlM2w2500=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iKTGgywB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55B9DGRh026057;
	Wed, 11 Jun 2025 10:04:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=9JCCjHSNSTqnwx9Bat5SoPEdOC4SxpqYfMC
	ZXhXugss=; b=iKTGgywBWzzqy5pRaEZNRkARtwgKpJ/Ym5Ghnwzu5/aYuX283/1
	M3QBYLshPOLo+kFT4v8RkMWuZ6mRW9JjjuLyfG3WTqY5DnOzhngg+YrCAF5LJK+B
	jReWM5F1CE75q9sWSuCWAqGGF/KI0teyNsXGXSyh+bG/QGwjnbTat8UELNoGamWa
	0voOZ17rtGUiUfir0bacilpZi2lhGCytN8Npz1zH+dqe6JvG8+pnsw1rZIwmHQiS
	kuqM/ftbx4yfgoGvaG0g81dvi9lTSoAI5NuYxT3bpFNg5WdZnqVE4LJp8ySGHMyh
	B1EBKM44J7aX13SKuuxdeATQV240QPOpYpQ==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 475v2y7c7y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 10:04:01 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 55BA3xbe019081;
	Wed, 11 Jun 2025 10:03:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 474egmgc5j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 10:03:59 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55BA3wUT019071;
	Wed, 11 Jun 2025 10:03:58 GMT
Received: from cse-cd02-lnx.ap.qualcomm.com (cse-cd02-lnx.qualcomm.com [10.64.75.246])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 55BA3vI8019061
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 10:03:58 +0000
Received: by cse-cd02-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id 9E0E63696; Wed, 11 Jun 2025 18:03:56 +0800 (CST)
From: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, jingoohan1@gmail.com,
        mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
        bhelgaas@google.com, johan+linaro@kernel.org, vkoul@kernel.org,
        kishon@kernel.org, dmitry.baryshkov@linaro.org,
        manivannan.sadhasivam@linaro.org, neil.armstrong@linaro.org,
        abel.vesa@linaro.org, kw@linux.com
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, qiang.yu@oss.qualcomm.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Subject: [PATCH v2 0/2] Add Equalization Settings for 8.0 GT/s and Add PCIe Lane Equalization Preset Properties for 8.0 GT/s and 16.0 GT/s
Date: Wed, 11 Jun 2025 18:03:17 +0800
Message-Id: <20250611100319.464803-1-quic_ziyuzhan@quicinc.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDA4NSBTYWx0ZWRfX3M/TXC8wX4TP
 9gRHXN75etoQOiPl8JUdNNJWda+eUgRZyGDUsGCD4zzCHYdmcJG71uNAY3Zx1+MYIvMwDI1hZr3
 F34ElTyvYcCLCQ+rjsb1yIe4iYgB8syycqihB5YcanKjMAIax3/KLkmgKqNOBzEV74tbTTS7I0A
 mtlaRsZ4Z+n7+FEaKhbpwKHTVqfh0TjUeTsDM7yNs784E4SF0iCWU8G1nzzrCMWA7IKOI4qBKDw
 T5EAF6jZZcd8m2jvhhSNUAk7soQtwJ+CdmahXUmls+d436UvDc7Vbz/q6oTrBBLmQPaF0O82/Rm
 6VGI3OIueO+JKcUuIoGy3S2vtnP7Uzynz8Zetps8FlLy0Bra/sdDyoIXnKteplGoaQl7hM/qHhC
 Qju+yUDTWMkGHEAXGvXfYO9aSD6GoRtXDaCazxgwz4IrUqc4A6HWoLJUKeNovRBjfBfsP1QL
X-Proofpoint-GUID: 5WEO9IAOyz6swnFGiPqcpbLamtWOaOIH
X-Proofpoint-ORIG-GUID: 5WEO9IAOyz6swnFGiPqcpbLamtWOaOIH
X-Authority-Analysis: v=2.4 cv=f+BIBPyM c=1 sm=1 tr=0 ts=68495491 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=pGW_TeUqoRlRwQqC-JsA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_04,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 mlxlogscore=740 bulkscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 phishscore=0 mlxscore=0
 malwarescore=0 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506110085

This series adds add equalization settings for 8.0 GT/s, and add PCIe lane equalization
preset properties for 8.0 GT/s and 16.0 GT/s for sa8775p ride platform, which fix AER
errors.

While equalization settings for 16 GT/s have already been set, this update adds the
required equalization settings for PCIe operating at 8.0 GT/s, including the
configuration of shadow registers, ensuring optimal performance and stability.

The DT change for sa8775p add PCIe lane equalization preset properties for 8 GT/s
and 16 GT/s data rates used in lane equalization procedure.

Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>

Changes in v2:
- Update code in pcie-qcom-common.c make it easier to read. (Neil)
- Fix the compile error.
- Link to v1: https://lore.kernel.org/all/20250604091946.1890602-1-quic_ziyuzhan@quicinc.com

Ziyue Zhang (2):
  PCI: qcom: Add equalization settings for 8.0 GT/s
  arm64: dts: qcom: sa8775p: Add PCIe lane equalization preset
    properties

 arch/arm64/boot/dts/qcom/sa8775p.dtsi         |  6 ++
 drivers/pci/controller/dwc/pcie-designware.h  |  1 -
 drivers/pci/controller/dwc/pcie-qcom-common.c | 60 +++++++++++--------
 drivers/pci/controller/dwc/pcie-qcom-common.h |  2 +-
 drivers/pci/controller/dwc/pcie-qcom-ep.c     |  6 +-
 drivers/pci/controller/dwc/pcie-qcom.c        |  6 +-
 6 files changed, 49 insertions(+), 32 deletions(-)


base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
-- 
2.34.1


