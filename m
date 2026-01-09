Return-Path: <linux-pci+bounces-44351-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BBAD08B08
	for <lists+linux-pci@lfdr.de>; Fri, 09 Jan 2026 11:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D95E30A1586
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jan 2026 10:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C78C33A032;
	Fri,  9 Jan 2026 10:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CFRGKnYk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8B218A956;
	Fri,  9 Jan 2026 10:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767955532; cv=none; b=Se3/AlZgZUSeYrV8LlJtPDFrospWdYMUCdPqqtFWlmcZwbCBNyZ+VPiCXbKe53fWLL8/qCu64xUyIqd39521S01edxKX/ejNhWzNpRceUEG9yCzYEqFH0U3PpmxsVekdHc9yUFZTBAsqxnkcbpyuxAetNI5ObNDbhkpFmvgsPac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767955532; c=relaxed/simple;
	bh=ptF8+6Zny20X8v9kvnYs1hP74CPjifxVdwVec1qJhB4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fpQxGQo36cbMHk9ZvOIyuRSGwyxg5p7lzyNn6wdwb5BSUJ4nodZCvL3JTHZNKg6iNAJo/GHlWvTzQL1SbOFrwcUl767CdsQmEQjpXaPgRs+k/eWVjM3iT8ecEI0vu0CmL8mZCo2XXSC+DgJxWShyrAwHOwi7NCWCr8+wVqSfOdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CFRGKnYk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60952hnZ3542117;
	Fri, 9 Jan 2026 10:45:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=vtmdJfOOZTM9etuuE/wEyXnqf53PBhwwUin
	8Yrle/CA=; b=CFRGKnYkIfWUZAPRXtRa1eIpsSekU7vI+rfqX4WWJm5ycGNl7Kl
	aBsbTGt1lfA1ddSfR3wRZQb3VSAgaUv6G7o08GIr4uUdgQIKRCegf4wXxMJnLz2O
	2CMrhmzqu4RKYrWjYtvDsjisjn9daE1oMySlK3FJOJiY/Ig7nXAjlxbxY4zAqwhj
	yNWX5dZD1TPvWwbnFljde15xc9rLqyG2Xi4jUS54HiGGNW+Hb96jltIjCrNOiTgR
	545elLMkyqD62RZ0b2mE+oIIsFYHm/HJ3ecnYpXVFz/18SDk1kYKgiRx4Fi1YzIC
	5QD2z5MEhm97K9TvJVbslysBNcTpXsH9lVQ==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bju6b0yeh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Jan 2026 10:45:19 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 609AjH4O004104;
	Fri, 9 Jan 2026 10:45:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 4bev6mpxx1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Jan 2026 10:45:17 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 609AjGfo004089;
	Fri, 9 Jan 2026 10:45:16 GMT
Received: from cse-cd02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 609AjGRw004088
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Jan 2026 10:45:16 +0000
Received: by cse-cd02-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id F2C1F77D; Fri,  9 Jan 2026 18:45:14 +0800 (CST)
From: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, ziyue.zhang@oss.qualcomm.com,
        jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org,
        kwilczynski@kernel.org, bhelgaas@google.com, johan+linaro@kernel.org,
        vkoul@kernel.org, kishon@kernel.org, neil.armstrong@linaro.org,
        abel.vesa@linaro.org, kw@linux.com
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, qiang.yu@oss.qualcomm.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Subject: [PATCH v4 0/3] Add PCIe3 and PCIe5 support for HAMOA-IOT-EVK board
Date: Fri,  9 Jan 2026 18:45:01 +0800
Message-Id: <20260109104504.3147745-1-ziyue.zhang@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA3OCBTYWx0ZWRfX5NRJx4oiZVhp
 BXQGvykgL6Y86SiXsWjW47Otk0/DrwJFEUsWxZRLmnI4yjIQ/EQwDynIC2i6iKNHNHM9bekubOV
 pksZYHgdo8AHZlS5UqPd5crzbmElY/BkF5t7tkYTq0VUBWcUtqh/I6D4P/RNdJcrjYgES0ZEaym
 ZbXqFWE55NapnhRs6IM8YLnx89S36Cq2o4tOi5NtE/Adxm1/c8U15y3Bj9x9FPsoUxhcips5R+f
 woL8lu3UJEPCZ2TofvCbYJfxlYXsYbAAsxlcR+jKPtM7W75/UpO2cne0gs5XNqLTheZeoa75DZx
 EMCEsjmdOmsBiFy0Q0vBR1OFAWNcQR71otw3P3yPMH8FcBhyjxvrpTP2cyr/USSS7hr6fHFT/Ga
 ILokibGGWDrkMq5OSkDPrfqri8F4nmDU4URuQ67OXbcbq78dphOmarN/f8Ln/mHBhq3sUI1sRFU
 nnhnlrH+X0DAoXkeiGA==
X-Proofpoint-ORIG-GUID: Q4giVK4zTW6LGRCtsx6HWX6KXNSRrW5M
X-Authority-Analysis: v=2.4 cv=V+5wEOni c=1 sm=1 tr=0 ts=6960dc40 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=_1SJXrV41PCVPbEzUN8A:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: Q4giVK4zTW6LGRCtsx6HWX6KXNSRrW5M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_03,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601090078

From: Ziyue Zhang <quic_ziyuzhan@quicinc.com>

This patch series adds support for PCIe3 and PCIe5 on the HAMOA-IOT-EVK
board.

PCIe3 is a Gen4 x8 slot intended for sata controller.
PCIe5 is a Gen3 x2 slot designed for external modem connectivity.

To enable these interfaces, the series introduces the necessary device
tree nodes and associated regulator definitions to ensure proper power
sequencing and functionality.

---
Changes in v4:
- Move PCIe reset/wake GPIOs to pcie_port node (Mani)
- Move PCIe phy to pcie_port node for all Hamoa platform (Mani)
- Remove output-high property (Konrad)
- Modified the DT and patch format, and adjusted the commit message (Konrad)
- Link to v3: https://lore.kernel.org/all/20251112090316.936187-1-ziyue.zhang@oss.qualcomm.com/

Changes in v3:
- Update commit message and DT format (Bjron)
- Merge PCIe3 and PCIe5 changes into one patch
- Link to v2: https://lore.kernel.org/all/20251030084804.1682744-1-ziyue.zhang@oss.qualcomm.com/

Changes in v2:
- Move PMIC gpio pins to patch set 4 (Krishna)
- Link to v1: https://lore.kernel.org/all/20250922075509.3288419-1-ziyue.zhang@oss.qualcomm.com/

Ziyue Zhang (3):
  arm64: dts: qcom: hamoa: Move PHY, PERST, and Wake GPIOs to PCIe port
    nodes and add port Nodes for all PCIe ports
  arm64: dts: qcom: Add PCIe3 and PCIe5 support for HAMOA-IOT-SOM
    platform
  arm64: dts: qcom: Add PCIe3 and PCIe5 regulators for HAMAO-IOT-EVK
    board

 arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts    | 97 +++++++++++++++++++
 arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi   | 80 +++++++++++++--
 arch/arm64/boot/dts/qcom/hamoa.dtsi           | 42 +++++---
 arch/arm64/boot/dts/qcom/x1e001de-devkit.dts  | 24 +++--
 .../qcom/x1e78100-lenovo-thinkpad-t14s.dtsi   | 24 +++--
 .../dts/qcom/x1e80100-asus-vivobook-s15.dts   | 14 +--
 .../dts/qcom/x1e80100-asus-zenbook-a14.dts    |  3 +
 .../dts/qcom/x1e80100-dell-xps13-9345.dts     | 14 +--
 .../dts/qcom/x1e80100-lenovo-yoga-slim7x.dts  |  8 +-
 .../dts/qcom/x1e80100-microsoft-romulus.dtsi  | 19 ++--
 arch/arm64/boot/dts/qcom/x1e80100-qcp.dts     | 21 ++--
 11 files changed, 279 insertions(+), 67 deletions(-)

-- 
2.34.1


