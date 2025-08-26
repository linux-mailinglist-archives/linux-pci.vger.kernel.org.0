Return-Path: <linux-pci+bounces-34698-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC204B35325
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 07:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98225685228
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 05:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BD62D481D;
	Tue, 26 Aug 2025 05:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AH2uWj3A"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0D51A23B9
	for <linux-pci@vger.kernel.org>; Tue, 26 Aug 2025 05:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756185516; cv=none; b=YZe3uGcGJWutOc7JDocTRMJTPqUAR8OP7UeQXWlvv+mYG7Tmbev8uAPMrhw8OiN8UIbcX76MYjoHK4S1DDKWa7+loryF1X7hE3TASjk9KId2trm7DhGvzZtvwvnhIeKhIJI3s9Foon23Vy1StcWEFzFhbBsdJXv7aCmvFgk+QnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756185516; c=relaxed/simple;
	bh=vlIwpMdPLzbszsLDUE4+FJfpWc1+VEt9tIvX90Lc+30=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ThH2gxLvbPuEtGVhmlyOf0ROqpbIYhcdH5mIpVaJx4O0X6rGJXUa36j6pD4MPb7gaJGmZWv7V00Dw24hhL7iadxXaHiAH/nY08YZZUUSqcIIQsSHZHkCFRm31Q1pSoW+IGkk3iKgXndOv4nJPMNOF0Im6Cyw3TgOCfmMTeF1DPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AH2uWj3A; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57PMjUXV019633
	for <linux-pci@vger.kernel.org>; Tue, 26 Aug 2025 05:18:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=2vsPhyKBqG+IBewEtmHLJo
	hfftWb+4Dg3ZClfwqwBQM=; b=AH2uWj3AsUXqsfQ9CHE3rUMsJRLP6TjvIt5RW5
	7gJxkvCYE8uNT5h6V4K+VAen4WClM4AcRMf4qlHI4DV9FEfBji66EpcuTyNPQtKn
	yMrrKbWItE5QSrrkZm1y7GwnQz3oBDjN+0D6mh3XYTnvVE9pxPoMA/wqugwrf3IV
	vbJTNp5c3Da2VQzyXaxA9Fb8/sOwmmBCoqqd/u3ikMBfV9CMOurqWSoJN6v0VQqw
	jjnyed6mhXC2ZimLNKcTkQj4BHdgBn+P5I9oS6ERPYEUXM9V/n2/koFs6q7YGg1Y
	o3wRNklyQAxWoS3lH7Zh0U5kwn3QroqCpYJUEX9Yez66KixQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5y5fbxa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 26 Aug 2025 05:18:32 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2461907278dso48975455ad.3
        for <linux-pci@vger.kernel.org>; Mon, 25 Aug 2025 22:18:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756185512; x=1756790312;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2vsPhyKBqG+IBewEtmHLJohfftWb+4Dg3ZClfwqwBQM=;
        b=OHEdEu8WZ6beA8GcyW3pJhTeeZ3iolmhGdSMszG1SrQg8FcJ6rpv+xnJYc2uyvKVXi
         jQFAMJJog/0jN8TEjZBt0iDNHL5fWUJyeFDU5q8DVLfD9etY45+PxmjEGPEl71gQBZbb
         H75OGgbVE945mBst/IDsbb863i0WuYE8Xus5xFEym9a+xqjQag6rr9LbFDgfpQnoKEi3
         OHsqeEIT9B8LIAQb6npabYK9rh37L/yiKPnX8EdE5EouJGOKwntVBArFlzETwi8q9zf8
         hb76GXryxqQZfiwmOcdadc3tUo1Uz7B11oR1YqLsMihXLrgYRJ6jgGE8xvhNhjWMeuGR
         //yw==
X-Forwarded-Encrypted: i=1; AJvYcCVF+QN5qt+Ps8tuYz7fUufqHuqDkfKUT2ULquaw/9JFXTZpN/8uqapFJBBO5rCrwdrPfMNIDsf/jH4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2dH0QNqTyz3HnBOAFTSbyZrEhmrETocFyc2hFx2bh8zhZaJEl
	deMU2Qk43r20tsBNshn9n8IdewYwdDhvuYDjP0XJuTnRsNsg96JJZGK7e7jZHiX9srAK0VaBV3A
	HcugvZhpVAEOc4mOgDo5oV6f7uARcaqSq/R3aRcbRdqrP4oeooGRZJntHda1k5P0=
X-Gm-Gg: ASbGncv7XjCopO/W6X7EFGmb6z6FCFBXwlaPmh6YnbEnnF7t8VMu72w+L/GhFI7JUJi
	63GvicIe+4QaO5BFUTtjILAgrimcINVaywzI2+Nw9PXZ2+NSE+Ndt3NpkiL46msS2JJxykEXMkK
	ccSqk+I5IOBF9KSd6UXSNhh+uay0v8zsMHGVK2fV0WqYdAD//HYB58mySHcuDokKgwYAKwwTKcT
	iYe7hnxVbGHfGXXAW/GL1DLJrY8Ggmk2Ydj4Wu94LyMAfAlIBwvcqpJYCgg8mYde8yqzfwDQmFd
	GBxAakg9LXrJWlI1O20YURAo9WIJ5OfV3HK5oh8OzHdxBHp5wBhfsWDhW0K6AvvL+cjOB9RHJ1I
	=
X-Received: by 2002:a17:902:db0c:b0:242:a0b0:3c1f with SMTP id d9443c01a7336-2462ee0b27dmr189012805ad.7.1756185511512;
        Mon, 25 Aug 2025 22:18:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGh6SmRROLIr6PMOz1PXF4cr/CmjrIyVmNC6hvrLBZh8ZNDcT48YrclMSup6MtV2RwVhMvgVw==
X-Received: by 2002:a17:902:db0c:b0:242:a0b0:3c1f with SMTP id d9443c01a7336-2462ee0b27dmr189012375ad.7.1756185511073;
        Mon, 25 Aug 2025 22:18:31 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2466889f188sm84348085ad.146.2025.08.25.22.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 22:18:30 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v2 0/3] arm64: dts: qcom: Add PCIe Support for sm8750
Date: Tue, 26 Aug 2025 10:48:16 +0530
Message-Id: <20250826-pakala-v2-0-74f1f60676c6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJhDrWgC/2XMQQ7CIBCF4as0s5YGiGh15T1MF1OgdmJbKqNE0
 3B3sVs3k/yTl28F9pE8w7laIfpETGEuoXcV2AHnmxfkSoOW2shGnsSCdxxRaINHq5zrsDFQxkv
 0Pb036NqWHoifIX42N6nf949ISkiBXa/sXh0KhJfAXD9eONowTXU50Oacv54v/WGjAAAA
X-Change-ID: 20250809-pakala-25a7c1ddba85
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_mrana@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756185504; l=1290;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=vlIwpMdPLzbszsLDUE4+FJfpWc1+VEt9tIvX90Lc+30=;
 b=0KL+6x8TGQEUpYJvqY3iP7+9EiYO5OHNdo3h8C2d3xI/A7u5IucNW+PqyxEKSkGSKdoxYvNTS
 VfQB9wQxqcECRS59Ps24xjDDVMDDAnOl+9daRomBfOlTaY1dUeBmR0y
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX6aHmjBnR6w9o
 HsgN95Qo5l14rKPHD87i2Qr7w4jnzeaBFbqcE+QTDAn92h1M40UdmaJqNkvJkNbUYk98X2Y4i3R
 192kzW2RkSfZ6DKiSiFxLZteeGqP6M9G/dg6b7hrHgxyU7Jj2GdAiYX5GaZFo02jXjJUK8DxetW
 E75fa0ZR4/1OuEMWUdr+r0mFgnksCHiSuPqWjaRDnWmr4O7x7dm05AsMTB7lkBEfqqHXrP+smhr
 DOcK5fptj9gRqzi04bu6ULS1fmoK82Mj/N2ImdcCk8PVnVSgTwFXJinpPmpC+WsC0n0AcTLyX6w
 ftbs2tiThOdVpRVwGx10tp6d3I+J90jsh63nemlHOMUQF0MdHesnQs7MzlAgojSeByf+wiEnRLt
 tRGrnOB6
X-Authority-Analysis: v=2.4 cv=Lco86ifi c=1 sm=1 tr=0 ts=68ad43a8 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=qIbWdXD6M1inJYch3NYA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: e_0RgjkEKcKXaGHtwGEQlpZgo7xhTyf2
X-Proofpoint-ORIG-GUID: e_0RgjkEKcKXaGHtwGEQlpZgo7xhTyf2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_01,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033

Describe PCIe controller and PHY. Also add required system resources like
regulators, clocks, interrupts and registers configuration for PCIe.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Changes in v2:
- Follow the x1e80100.dtsi pcie node description (Konrad).
- define phy & perst, wake in port node as per latest bindings.
- Add check in the driver to parse only pcie child nodes.
- Added acked by tag(Rob).
- Removed dtbinding and phy driver patches as they got applied.
- Link to v1: https://lore.kernel.org/r/20250809-pakala-v1-0-abf1c416dbaa@oss.qualcomm.com

---
Krishna Chaitanya Chundru (3):
      dt-bindings: PCI: qcom,pcie-sm8550: Add SM8750 compatible
      arm64: dts: qcom: sm8750: Add PCIe PHY and controller node
      PCI: qcom: Restrict port parsing only to pci child nodes

 .../devicetree/bindings/pci/qcom,pcie-sm8550.yaml  |   1 +
 arch/arm64/boot/dts/qcom/sm8750.dtsi               | 180 ++++++++++++++++++++-
 drivers/pci/controller/dwc/pcie-qcom.c             |   2 +
 3 files changed, 182 insertions(+), 1 deletion(-)
---
base-commit: b6add54ba61890450fa54fd9327d10fdfd653439
change-id: 20250809-pakala-25a7c1ddba85

Best regards,
-- 
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>


