Return-Path: <linux-pci+bounces-29018-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95162ACEBE4
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 10:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFA651890C02
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 08:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5915220469E;
	Thu,  5 Jun 2025 08:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o3KpyXAc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF101B4240
	for <linux-pci@vger.kernel.org>; Thu,  5 Jun 2025 08:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749112253; cv=none; b=V6mNReNU4Rav42wDo6yLroZn7TCP2Qt5S/rTT4F/D03tIxzGmW/4We2dOmAqeeVQZKXVVQlkZa/Xz/NjBQMPHL6AGqg/tT3umg0v/WsbCn9ZBEZt7OPZ6jyj0kzH0HB7Hq20nV/VgMEtn77y2XeumZ4jGyfmzest1iRWBSH1C2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749112253; c=relaxed/simple;
	bh=AkHB+thfbIQIqfeaA9UXwrnfoEhwL6KbN+8bNql7SCE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KhvSQHrqrN0vQwnE6WwaXetgCF1EVc+ovs84wl+19IUVn+1d6IyI5dv04mRldC8b6AvCm35fQP5uHFQdEMN1dvH8CRWmrst7Q7x5ih8lKMMdXN3fT+EEHNU836KAeBZeVdoGDQlR2SMh2QFXtzg1xn/r3nxpibPbzcGzvJls3PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o3KpyXAc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554KSSPm012952
	for <linux-pci@vger.kernel.org>; Thu, 5 Jun 2025 08:30:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=F+dqIkfsczA9GFhBQTlcna
	o8P8XWtJj7CYZ1dLe6ckw=; b=o3KpyXAch4TXHCXTeDQsjUBrptC/TpVi5jDrWH
	hIrbQVBcCIZo6KCVjtrWd2eM47hW41wGzCRQakFYDJ5Njt2cRGFp0QveyH5sR82V
	S8IT3EktQE9stKm6JBUIq2kU3DL1o0k7AqvbPpgXYl53QiTOLtxCYWVk6H00LxYw
	sisqVwI/zoCDWNfg3h4DqGbBUs75k3Wb3elW9mhw9B1VTcjaNb6irBNpmtTQDwUO
	hPnlLgikWCZUVGBZ4iGjaiVLfhxNY3wrX1MrZdVvCyA/Gg1MpqRtbhmpraVXfob+
	s/rf3Ts6ZF0mA4+yzsQMKDKT2BflgbFmsC8w5f2RNprWuPlA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47202we9d5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 05 Jun 2025 08:30:50 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b2c36951518so679407a12.2
        for <linux-pci@vger.kernel.org>; Thu, 05 Jun 2025 01:30:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749112249; x=1749717049;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F+dqIkfsczA9GFhBQTlcnao8P8XWtJj7CYZ1dLe6ckw=;
        b=rEOABpQL1wPU+tLKe7c1lGrqZMUASb1xx1VEj5eEIlqBONIhADVYYosp6qB1BZWcOA
         dr6niE/wu+nF0Ur2wduJb6iYR64kCP+6zgS3fkvU/WwV/2oBi2SoTnp/MGsF8W/ZL2Kt
         U9GGj8qs3FcLsp8TbGxPA0qpt/bVgre06wCdxbh3nHdhrcWn4AgHMH/n+WhlpmhwDgXN
         W7imatAc1MucR0wLPyEQW4NmIvuSCWhWOKK8eW9hDAr+BrNDY6Ke6UegV1FcAS6SDOK/
         RVV6FiyUXbE4+hRHyKUqr1/N1QuYPsdQNf8QKml45cvNkhlMWeNtYrDmpl+nn2LbXaRw
         wKYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUw0b0rpHynR1rU7/4iL77zUeL7ACtvbYngboXMhaX2zxyWkcgTqEFC6MW1aiwqk1vf29DitVD07ig=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiGs0vMzEyE9NIhB/Tv1qn+K1h1OeId+AegBx15gpCf44TrZ8P
	GyjyYIl3E8vaPY9qhc+1LA3x0a5oS37XcsDzeGITXDoeWjLe8rdlcMga7bybMnKeSai1lIvhH6K
	iNizjAAc+TtVINLughUgj+lfDRlpyKoRa0UgfXAnKUia7jJ3T2j5k1I1WJbCmnXowI+Jqlzw=
X-Gm-Gg: ASbGncu6gjfcMnP4joA46R5Mw6a9a18En9l9m4SKT8JBCe2J/m/ZVjSr0jWnHe0YUgy
	K8GuQK2wBVoxtxxU/NfjnSsF9kykFnkhmi70s4Z3mesTY3T19el2ZL7qgvcG2JL3wISC3Hr7X9y
	q9UQyHwcAM5jJO2O61VT+syiPTdqEocOMZ0yNiiKFclGZBvrOg/fdz3iRyU1M0TuMLcIrWIqjeQ
	KAraW0NSzMABeLmJKjnUWP2FAYft+5cEskgPvZ+p7z1oOB7amKjQnNkHziOG8kKbkojnuxjlidG
	wewBnJEZoK7SCvZOpiu/IGV8M4xriLeFArwR10cNwQa/LLY=
X-Received: by 2002:a05:6a21:9982:b0:1f5:717b:46dc with SMTP id adf61e73a8af0-21d22c6620dmr8915821637.27.1749112248700;
        Thu, 05 Jun 2025 01:30:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGylkJnpUOGJZB7KO5B1USnsbYCwCycZuG/xEPtXYdkFvCeHitQoWPi0Kj0W7n6zqS31uMn5w==
X-Received: by 2002:a05:6a21:9982:b0:1f5:717b:46dc with SMTP id adf61e73a8af0-21d22c6620dmr8915778637.27.1749112248213;
        Thu, 05 Jun 2025 01:30:48 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2eceb37d5dsm9819095a12.34.2025.06.05.01.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 01:30:47 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v4 0/2] PCI: qcom: Move PERST# GPIO & phy retrieval from
 controller to PCIe bridge node
Date: Thu, 05 Jun 2025 14:00:36 +0530
Message-Id: <20250605-perst-v4-0-efe8a0905c27@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKxVQWgC/33Oy2rDMBAF0F8JWldBMxo9nFX/I2ShyONG0MSpl
 JiW4H+vbGpq6GMjuGLO5T5E4Zy4iN3mITIPqaT+UgM9bUQ8hcsLy9TWLFChUaBAXjmXm4xH783
 RBAvYiHp7zdyl97lnf6j5lMqtzx9z7QDT79JgvxoGkEoq8pZZM0Wln/tStm/38Br783lbn6l3R
 hrVGnUQDHbgjbP4H8I1YsPUBkcBFf1E0+QBv2cS0IKxYt8gOUe2dcb8gfUaNwvWFUPoOOpIHH6
 bexjH8RNvd67HhQEAAA==
X-Change-ID: 20250101-perst-cb885b5a6129
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749112243; l=3003;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=AkHB+thfbIQIqfeaA9UXwrnfoEhwL6KbN+8bNql7SCE=;
 b=aBzd0q2UeMu0y5PpuU6Sn6yccSOXnqz6vMHKIPHsDdx2cBR0KzPn5z8pXk6xw4fXHjJhJeuMH
 dVqAsYgwRisAaoZkRpz3s6opfGgtqzJCm/5uSENhV5KFxKTlBabmnQL
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: GXzrEMlTaiC0Nm5-G4S1ld_A4wkxDJdE
X-Proofpoint-GUID: GXzrEMlTaiC0Nm5-G4S1ld_A4wkxDJdE
X-Authority-Analysis: v=2.4 cv=Y/D4sgeN c=1 sm=1 tr=0 ts=684155ba cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=DNAdngzMxNmsW-howNoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDA3NCBTYWx0ZWRfXzVdvL1eCuvDd
 wWw1ZEBPtWddqRgm1xvee9F8fdY2Glt7pdLPUpHgBsC99TFInYXcxbIO5OOPpRHysZfs/PKzw93
 DP48Sdj5XUtgebxW+pD9w/5el0lds+MVQdoAUmH+XLAeIAppkwXY0Ut+QSCeshPZE33ImlmhU+I
 IYSd70d+x0gdWJ+QHrIpN5zwJwaDrrlOj1iFfrHkejiWBWtg01z2cbLsttqPuSJ/H5Ft7IYFSvk
 NudJHl2K7XenbBgKzH9kfdSfHr1Z2lRT0nC8wkqupKU1C+JytsyHzLuaCuc5GWXe8C3bIa418r8
 KfDwE2R09W9rItgxnt6wdLPdcwogBiDXavrYjx6xFTfrt4MuLVgmaBTPEGjQVaWrnUwTZNTy5qA
 kkKaluWOKaBntvLd0qFd1TC6jvdeopiGQw8dCMe5b1qP2YUNM+9MtXCA9MwFRcfmYcx2PlHI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_02,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506050074

The main intention of this series is to move wake# to the root port node.
After this series we will come up with a patch which registers for wake IRQ
from the pcieport driver. The wake IRQ is needed for the endpoint to wakeup
the host from D3cold. The driver change for wake IRQ is posted here[1].

There are many places we agreed to move the wake and perst gpio's
and phy etc to the pcie root port node instead of bridge node[2] as the
these properties are root port specific and does not belongs to
bridge node.

So move the phy, phy-names, wake-gpio's in the root port.
There is already reset-gpio defined for PERST# in pci-bus-common.yaml,
start using that property instead of perst-gpio.

For backward compatibility, don't remove any existing properties in the
bridge node.

There are some other properties like num-lanes, max-link-speed which
needs to be moved to the root port nodes, but in this series we are
excluding them for now as this requires more changes in dwc layer and
can complicate the things.

Once this series gets merged all other platforms also will be updated
to use this new way.

Note:- The driver change needs to be merged first before dts changes.
Krzysztof Wilczyński or Mani can you provide the immutable branch with
these PCIe changes.

[1] https://lore.kernel.org/all/20250401-wake_irq_support-v1-0-d2e22f4a0efd@oss.qualcomm.com/ 
[2] https://lore.kernel.org/linux-pci/20241211192014.GA3302752@bhelgaas/

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Changes in v4:
- Removed dts patch as Mani suggested to merge driver and dt-binding
  patch in this release and have dts changes in the next release.
- Remove wake property from as this will be addressed in
  pci-bus-common.yaml (Mani)
- Did couple of nits in the comments, function names code etc (Mani).
- Link to v3: https://lore.kernel.org/r/20250419-perst-v3-0-1afec3c4ea62@oss.qualcomm.com

Changes in v3:
- Make old properties as deprecated, update commit message (Dmitry)
- Add helper functions wherever both multiport and legacy methods are used. (Mani)
- Link to v2: https://lore.kernel.org/r/20250414-perst-v2-0-89247746d755@oss.qualcomm.com

Changes in v2:
- Remove phy-names property and change the driver, dtsi accordingly (Rob)
- Link to v1: https://lore.kernel.org/r/20250322-perst-v1-0-e5e4da74a204@oss.qualcomm.com

---
Krishna Chaitanya Chundru (2):
      dt-bindings: PCI: qcom: Move phy & reset gpio's to root port
      PCI: qcom: Add support for multi-root port

 .../devicetree/bindings/pci/qcom,pcie-common.yaml  |  32 +++-
 .../devicetree/bindings/pci/qcom,pcie-sc7280.yaml  |  16 +-
 drivers/pci/controller/dwc/pcie-qcom.c             | 177 +++++++++++++++++----
 3 files changed, 192 insertions(+), 33 deletions(-)
---
base-commit: ec7714e4947909190ffb3041a03311a975350fe0
change-id: 20250101-perst-cb885b5a6129

Best regards,
-- 
krishnachaitanya-linux <krishna.chundru@oss.qualcomm.com>


