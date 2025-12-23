Return-Path: <linux-pci+bounces-43561-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E23EDCD88F6
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 10:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C2E6301E144
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 09:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA3C31353C;
	Tue, 23 Dec 2025 09:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZWcahKFe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YMuWyDsD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B097E3016E3
	for <linux-pci@vger.kernel.org>; Tue, 23 Dec 2025 09:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766481393; cv=none; b=PCMUDUlJmyxCvQGGBNZj4QKKQ5CTV+mzh13AfbZcJUw7U7urGUse874epUm4AooEL7cXIa/mYJG2A4qBsHND/nO0UEPJUcyksgV3avYWqp8AeMV5FO66EI5hj/9ALTY1vigDdBr/sVBo/ADDwLK9xwHnr8yaKAsdifaeLVrvzDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766481393; c=relaxed/simple;
	bh=VG9Yc/Ztp5a99ek/5VbjwSWG3pwWefSVP9Qc0r25dQo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lTpX+jQsz/BhTi3kDuWALCcutpWGMR9eBDvTvTdBsIP6r18s5bzNWt8zGKESZjBdbMnfYvgiVWcGl8cb4fneW40TOhVji/8siWsUWWmp+h55Zqci18MF1/W6Ivud3oPXew6mSDHMwYRp60k731iIHv6IOfj2R61zDXM4K6DK77A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZWcahKFe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YMuWyDsD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BN8VEwM3062290
	for <linux-pci@vger.kernel.org>; Tue, 23 Dec 2025 09:16:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=AVg8wbVKdA1+SXjGfkmL44
	d4AfhbsnZkLtmnEiP+VbM=; b=ZWcahKFelLJ9zyXAY1Z9gN1okubWmynGqZYLyN
	u2v0jxuDX0HGWYw+ClcHaQu0HkLqaXUu6DOPbGDfKLrZnO2sZd918N7RVotiBAre
	8rnlsOXT7yk60YH/U6ueOj9Q7CRoY6OPrvYLLDim32z7TiyFEXkPSBTyB2ztXkma
	P9y6Jnt8wxZ+IvIgjMC1t84i5gQ2az/ZsO3gXnLTT8sPBcanJZNQN7VG4hpI+EpD
	+a2nEKl4iUnjpdti9HIopLJF9Y6fDRAPyTq78XchPidQukLSbW89EAyXt2FOLmAx
	vo9OCHR1DXpF5Cd4FChiLpAwxw5MZhcSR3A9VTm59fxI9lHA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b763pk55y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 23 Dec 2025 09:16:30 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a0f47c0e60so121195845ad.3
        for <linux-pci@vger.kernel.org>; Tue, 23 Dec 2025 01:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766481389; x=1767086189; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AVg8wbVKdA1+SXjGfkmL44d4AfhbsnZkLtmnEiP+VbM=;
        b=YMuWyDsDBb00WxkJ0zXuVz8bxG3YHmBJEOqwBBGmBebkDNy4+X5wP7pPpE2rI9qIPq
         QQ4c8aCfdxYVq9lZGNAOyN7uF5UTWZV1KH8Sm0HTvsB5MZJpncJxgpSYhXU4YH+E5hyq
         ds6CGCMSqZKbE9iG+0SOOfkhdUfU9xxOy9Tlskc5LCir/ftOfW23fi0t7ID9XwRWLZvW
         AgLu0dLTknzbiOeaRHYqt4e6XNeCgkZz1HYfnPBTsHV2d6h9QNjGgvBIvseoS/o6Ul4B
         DHmyxpIIi/UUWo1r0wLiBQE783ZrC7Tkrxl+ekePeSQXkjx93RhPtl7OzesG//ScmCCr
         J5ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766481389; x=1767086189;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AVg8wbVKdA1+SXjGfkmL44d4AfhbsnZkLtmnEiP+VbM=;
        b=QYUbVKA9BRTQbbI/km9Y1E7fxJZyGktvQpRM3XmIcuB9iM+FKL7rGTomb0uNbMZDGQ
         f8/qKAHfyCxQe8kfwbUYDDZ1DneTApKvsevaMwghj4CpzLH73hlhCx/sBfcZOIYVYiFU
         ZCyRa6gxnfG1en1+81ON/f9QJDprtk3nCK56u51tnBJQPRgsK83nRS90drcXRdMSJa/9
         UJQG2wBaef978dakmxH+Am1sR/Z/eCNGLxsEtQLtes766+Xiqx8tiQZfIV9wQBcZAIAp
         ZgShNsJSO9KJGwhU99r/pvkvveKNp3Muk+wKIN1vbrp2lcuWdnnf8yliDY+wWWxixZ89
         q0yA==
X-Forwarded-Encrypted: i=1; AJvYcCUutlVhiW732m6eW1zsenG9B3JQE8M3dzYgkoB34W7W3LUze8oN7QqmRM6aMJ0Ax8TjOSQKdYkAzmk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8FIiERbfZ2o+d/sHUcRlXzKo3ZrSSBMEFDUkLAmWbaAGybvea
	WIah7X0wGIvNUJxDRm0bNANdIL+YfFXk0QD0zYVoWaEDEcfPipj5TLgoFuDT7vF0uqUu2Nj+OdZ
	BilW3RU60+a1t6IOWy2WNuFfMZlLgDkMtwsHB61fIayGEnIZXYxUmHLiT32YPEao=
X-Gm-Gg: AY/fxX6jOZnvReN+fDSehYe2HGCqWQFn/AtMwMprv4pA1ov7iFBEerLS4o0/kwQAYjQ
	tdlwF9k0PkFKnfEnQuve59o5+VboGVyuQHLyTax8Zchdjna3gcc+J07rQ9Sekmj9iktMUBGV1RD
	hU8pJExev9GXPIsAws75Xul/3rB+wbDzqWlGfbIDrLYE3oLZc86DZa1e7B2uOaGWsFRQ8WiaqjH
	EX0b/JjUlm0pONgkXGL6md2/yghLHNbbHtlg0M93xXWbkn4J5sxSBzCyOvUdHH4nChwK/wrH1D2
	ElsOwuS01jmeyTwz151P9eIiCkBttaIy9Mr4nLMVXjWSzXepR4dhAgnlfvOxu3EjXCHSi2H9U9H
	KdSeFPej7R/B00gZB8WWIGtPtQEff7QHjojzHLSdkbPI=
X-Received: by 2002:a17:902:e846:b0:2a0:9656:a218 with SMTP id d9443c01a7336-2a2f2a3587emr110669935ad.28.1766481389311;
        Tue, 23 Dec 2025 01:16:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5CDUf0DW0KwHRj2MZfztHU8oSvgoeruZN+oe8H/s+rmsBQ33CEC+cbT5Dx21OxR3v/cxm4A==
X-Received: by 2002:a17:902:e846:b0:2a0:9656:a218 with SMTP id d9443c01a7336-2a2f2a3587emr110669555ad.28.1766481388801;
        Tue, 23 Dec 2025 01:16:28 -0800 (PST)
Received: from hu-msarkar-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d76ceesm122507585ad.91.2025.12.23.01.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 01:16:28 -0800 (PST)
From: Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>
Subject: [PATCH v4 0/2] Add firmware-managed PCIe Endpoint support for
 SA8255P
Date: Tue, 23 Dec 2025 14:46:19 +0530
Message-Id: <20251223-firmware_managed_ep-v4-0-7f7c1b83d679@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAONdSmkC/33NwQ6CMAyA4VcxOzvCNsYWT76HMWRAC0uE4aZTQ
 3h3BycPxEuTv0m/ziSAtxDI6TATD9EG68YUxfFAmt6MHVDbpiY855JxVlK0fngZD9VgRtNBW8F
 EEWUrmS5KKTVJl5MHtO9NvVxT9zY8nP9sTyJft/+9yGlOlVGCCa5ErvDsQsjuT3Nr3DBkaZCVj
 eKXUvuUSBSiVqw2pdZY71DLsnwBGS50gQgBAAA=
X-Change-ID: 20251216-firmware_managed_ep-ff5d51846558
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        quic_vbadigan@quicinc.com, quic_shazhuss@quicinc.com,
        konrad.dybcio@oss.qualcomm.com,
        Mrinmay sarkar <mrinmay.sarkar@oss.qualcomm.com>,
        Rama Krishna <quic_ramkri@quicinc.com>,
        Ayiluri Naga Rashmi <quic_nayiluri@quicinc.com>,
        Nitesh Gupta <quic_nitegupt@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766481382; l=1764;
 i=mrinmay.sarkar@oss.qualcomm.com; s=20250423; h=from:subject:message-id;
 bh=VG9Yc/Ztp5a99ek/5VbjwSWG3pwWefSVP9Qc0r25dQo=;
 b=TvT/mcOIFWaluCRUX3jueXAaOE0th1lrb+QttW7hksTWV6NmBig8vg+3SpVr6hOg6ZrZSTPSY
 F1zsfC7jyaTDk32Q7pjxrxIR38g3VllmvxEbcI1g3kklk3EESUTfD0E
X-Developer-Key: i=mrinmay.sarkar@oss.qualcomm.com; a=ed25519;
 pk=5D8s0BEkJAotPyAnJ6/qmJBFhCjti/zUi2OMYoferv4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIzMDA3NCBTYWx0ZWRfX43Ronv+RVgPp
 wcdKxJtikyyvrI2udV8ON9TBo8n6xJDC1s0/c5Qu1+gjtsqJcLqFKTWQ1VoHCXlw+6qaXLn8hEl
 cZ4bLXwtAcInvh4SFVGCzqE9Kr17W3J7R1ZoUJYOG858OzuGiJiqQgx0rWQd82WP6KUC+01tUhX
 ylsjqqy2EY4FdpToMxPkcbvJtCbDNoOLHR3JEr23FElrowe5rZvA9G31AjshOCi7h6lFBfHLpQl
 cBJVA5YpzI9DL4QmHJ+SUOQxSAO0hnykAev9ECJlfmyXbmF52cqOJSh2D+kg7Be3nCknZinEc4Z
 lFL+LynmckO7l8Ev1kSXq8C8C7RY93TLb5wHiHZWovUuPMVEv8AaXQvBdHjTAGvJsRk3lw+nTWK
 2MVB2ftEdgpwMZUvMLRTPsttvt/zO4vnXj3EkF8ZajGtC58q6XarwfOVn5wRUwxjvKO7n+8QJqd
 VUadgFmWlm7P9VG/vcw==
X-Proofpoint-ORIG-GUID: 7aq1Yw5jSPVx_BNxJeVeTSIqNkebWNnZ
X-Proofpoint-GUID: 7aq1Yw5jSPVx_BNxJeVeTSIqNkebWNnZ
X-Authority-Analysis: v=2.4 cv=H6TWAuYi c=1 sm=1 tr=0 ts=694a5dee cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=3jyur01tNAjp9li57p8A:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-23_02,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 phishscore=0 suspectscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512230074

This patch series introduces support for Qualcomm SA8255P platform
where PCIe Endpoint resources are managed by firmware instead of
Linux driver. So the Linux driver should avoid redundant resource
management and relies on runtime PM calls to inform firmware for
resource management.

And document the new compatible string "qcom,sa8255p-pcie-ep" for
SA8255P platform in the device tree bindings.

Tested on Qualcomm SA8255P platform.

Signed-off-by: Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>
---
Changes in v4:
- Updated compatible string.
- Updated dt binding file name to match with compatible.
- Link to v3: https://lore.kernel.org/r/20251217-firmware_managed_ep-v3-0-ff871ba688fb@oss.qualcomm.com

Changes in v3:
- Updated compatible string in dt binding example node.
- Link to v2: https://lore.kernel.org/r/20251216-firmware_managed_ep-v2-0-7a731327307f@oss.qualcomm.com

Changes in v2:
- Updated dt binding as suggested by Krzysztof.
- Updated compatible string to match file name and compatible.
- Updated driver as suggested by bjorn.
- Link to v1: https://lore.kernel.org/r/20251203-firmware_managed_ep-v1-0-295977600fa5@oss.qualcomm.com

---
Mrinmay Sarkar (2):
      dt-bindings: PCI: qcom,sa8255p-pcie-ep: Document firmware managed PCIe endpoint
      PCI: qcom-ep: Add support for firmware-managed PCIe Endpoint

 .../bindings/pci/qcom,sa8255p-pcie-ep.yaml         | 110 +++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-qcom-ep.c          |  82 +++++++++++----
 2 files changed, 172 insertions(+), 20 deletions(-)
---
base-commit: 563c8dd425b59e44470e28519107b1efc99f4c7b
change-id: 20251216-firmware_managed_ep-ff5d51846558

Best regards,
-- 
Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>


