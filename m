Return-Path: <linux-pci+bounces-40327-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 60450C34D28
	for <lists+linux-pci@lfdr.de>; Wed, 05 Nov 2025 10:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 33102500390
	for <lists+linux-pci@lfdr.de>; Wed,  5 Nov 2025 09:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1835F2FE575;
	Wed,  5 Nov 2025 09:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l6S85Saq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UFT6inZa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988682FBE03
	for <linux-pci@vger.kernel.org>; Wed,  5 Nov 2025 09:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762334196; cv=none; b=MtYjhVEhECQLXNU9tJvmh2gUVi4MdIDcfTGBQ8A+ksQ8CLADDHXsraUyCyilkjCjkB5tqvByX/bsGLbXQ3u8agzaw7P7bidpTR79wIzfRkjJ8G8iAbGejfg3DxHt6YWMQ8tBW8EOCGyyfKHYNHsXHfeM2xCiXYtFDHRT6wdvSIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762334196; c=relaxed/simple;
	bh=G5qLkPbiy5mAe0CS1JhXvG0iaH8m8lqZJ9LVnFx7vuQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LPxKu5X0oeAWaf5MqjOZh4tvdGEMPTRFgBvxsATu1Qqp5hhxTp0WEzr08H46TJUAvQIPZ4X9xb172g3ajhlVnUClS0PxF/ErSF+YEAlMXneNosQrgfmqXN3qqcAt34tQnkP60gdAKU7TQS3FC0bMOzgL//iX48viFPmOJIVkZmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l6S85Saq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UFT6inZa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A57xT5T3165840
	for <linux-pci@vger.kernel.org>; Wed, 5 Nov 2025 09:16:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=sFARRt9q9VyojgpMQL1RCl
	I6kbqGYcPQtji5bXwNoNM=; b=l6S85SaqYiZwBhH8cAVJCI+RuVdBw65528FU39
	tKh+ghK5bEuPts43nPW9p/x/1XY0cOVXWcBOoMdDAoM/iySUq0v/Igi+hYVhNyE1
	P90D9t150gMf3/EfV9d3A8TAODZFvrIvRz3iuIFfBx+sae/JHoOJMT54emj99ZlZ
	0xId0eLSlm3WlXNTMaqlbabyo2LiSBGV01UIdoBLSI3Ab9pf1Wdab2o//3YhuXGz
	wStqrv2ZzH+ZUhu01REZ0Mtj9viAdof2Dp/M0wdJa8phCwz/jtpm9qb/E2X+Ofzm
	ZdIeOZTAwbA6zRG8OwzyFkQtmPR5WOL2gov/v0Vguh8dCWjg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7ketk22k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 05 Nov 2025 09:16:33 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-340be2e9c4bso3774979a91.1
        for <linux-pci@vger.kernel.org>; Wed, 05 Nov 2025 01:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762334192; x=1762938992; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sFARRt9q9VyojgpMQL1RClI6kbqGYcPQtji5bXwNoNM=;
        b=UFT6inZa+BKOJzHe3lPjtshn7yZp8BwhYeBacxzZKWE9vs/ZinVEyWITMpYiBWD7eK
         hnoTEGW+zUAthRDjIoXOpspOCliJq+/cC0vKSRz33/SxhjZdbGhrsrNKxUxn0yjbAzSY
         v/LJQ611+FecIakwba5BD+nTisMrX2xemwXsMtKSN2ZZtH2XbwrRTOw2ng8tt8MVszlf
         s4E892PduQ6fm52VnGnYjg/lbvTQMT+YHOoYSrkw2oaF/U5u90JMpyJ6ApxA4MKj+P7+
         EbqV4ZgmLCOOLS8V8rG74A15czbaQfIvw3nREq5tpdP7xspmlqgGLx6BW1hTUC1+dghL
         VCPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762334192; x=1762938992;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sFARRt9q9VyojgpMQL1RClI6kbqGYcPQtji5bXwNoNM=;
        b=DmnoO3tpvw4UnVViYtF3MSw2gO2uyBoxwXwlKZ/xEwLyV3bIcXArKs6x8r1BevnfyZ
         BOJ7f3peAkFSyBVT2Iob478hKhraloo14swc+HvyTNEWDgo1sev9roANpe5lQHuYHG21
         qCRb1PyX0UgnH7EDx/cqUsz+Sn8EKQoEWOQH5KuTwVVIa1cztji5OGvdARjluJcwWaZD
         nJe9lvxQypW/VVeBbCARb9OizyLlUY4aBNaXyHA8nucJdQDr1p/iTn09Au7kZ8QtMF45
         Apu77DGwcE7cig8F5WPT27isVzqFiHl0eaWaR6VgFc+WTD98kXyIBT3ZHyxrWkV0RSBl
         6SVg==
X-Forwarded-Encrypted: i=1; AJvYcCW26hh0yMGRFkoXsBKCh9qIvhd6IhOj1ohYvPO8KnNfOvlFZd2e5hJVPaq9iPUrKLm1CAUhNfFbJDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwechIihj1HC8ERahAqwM+l5QichjQ1aTGY6kE4eFoP/rKwAXh+
	nX92/yMHkPWd4nkt8esQL4ARN1paHN0zDo3vp7q8mnd3NVJX0kkVyLHf/TgxmRPfqBkIHSMKaUm
	Qmro9umeOrCPvD0AtCfxQlLUbDyo391cqOFDKMzewnD0ljBxd3NMAQnj6y/hSeJQ=
X-Gm-Gg: ASbGncuZAKfBQo9C2K8k7YutIr972mW7PoouGI10Dk3lA9fEWnJ0eYgvljjFn9ZGwB7
	LlQ9x7Qeh39Mr8yHRrSkMR8xR/fwq6GLKS/3RfYvXlhnWn+aURzHaY59q1NZf628w54daiaUKt2
	wDfUM2bsiIKYRx2CAj1x+zTIH/M6w6RRtUX9mhiehPSDCSUEMyW4wOXohNTT9qDBvlmFoqkTnNV
	S+DG1tWslAuPmNid2k65GPufZWAd3mfhnBf2qbnUVGH7uYUlv/Sgo8hLytjXpWzxV02JneSe74O
	i5np29erqGde3sagSj7+JBYY4B7Stf9BW469RISJKERYn+PXB1exzhDlXmS1eVX3TSIrR0j9oAp
	ac1MnhQxf2hbkIE5C5CBAnKHs53Ad
X-Received: by 2002:a17:90b:1f88:b0:340:c060:4d44 with SMTP id 98e67ed59e1d1-341a6c4d7aamr2891970a91.14.1762334192443;
        Wed, 05 Nov 2025 01:16:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFxgs1fikzPsn/Uzt2XJnjpiZb5nexbrA/xinXkHzp1PjfMUCh8IEA/nDWZDho9364Lklw3w==
X-Received: by 2002:a17:90b:1f88:b0:340:c060:4d44 with SMTP id 98e67ed59e1d1-341a6c4d7aamr2891925a91.14.1762334191932;
        Wed, 05 Nov 2025 01:16:31 -0800 (PST)
Received: from [192.168.1.102] ([120.60.68.120])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3417a385563sm2274249a91.0.2025.11.05.01.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 01:16:31 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: [PATCH 0/4] PCI: Add initial support for handling PCIe M.2
 connectors in devicetree
Date: Wed, 05 Nov 2025 14:45:48 +0530
Message-Id: <20251105-pci-m2-v1-0-84b5f1f1e5e8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMQVC2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDQwNj3YLkTN1cI11zM2NjM2PDJLO0xEQloOKCotS0zAqwQdGxtbUALbp
 yFlgAAAA=
X-Change-ID: 20251103-pci-m2-7633631b6faa
To: Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3343;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=G5qLkPbiy5mAe0CS1JhXvG0iaH8m8lqZJ9LVnFx7vuQ=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpCxXoDdyGhLtN9uKCzqzSqHPnH2YoTYU4IrxY1
 Ve++Gmb5UOJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaQsV6AAKCRBVnxHm/pHO
 9beJB/oCjStqQkgyMExHRzWblMIVQmQUCcrOHhmFhFh4gQMU6s70nszG6SRwPwawERB6MI5FcKL
 uUrIOacvZHgjirXX3mItamztaSmiC+qKWmrm0w5ReBlXTpA0H7Nub38DEI6L5hUeNKlN+5SLO+7
 dpPd9E2Rq1V399rHZZJcyqn3qqtQUbMd/nk1uPzKRpQGL0h01ateAHj6q1dirRL8kXY1d7b/pqX
 Ib3piaYcYQBeU7QgIK8YIRMcdrwzpYaLyjx/1jkXGdHdInFEMAP98dXcSWOhpyt9kS1U8pdpPuw
 GywqFZWfsxLaJrdpEqGXHJQy6ttj95C973WGiVUDVoWuPNyB
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDA2OCBTYWx0ZWRfX/tS6o1tUSvuF
 6i36bL8S3g+DxNKWFP5/sHXee5/Mu9MF65ahhDXX71pOlpq82vSXGtBDWlK28ZxeFHEXDKuwpFf
 +i1qNi4H4zOSmKJuHQ5gSBIcVqQCKSy8gbuYJuXQ4uFP6Jt+E8kgb2BY1wIKe1qdP0uvE5Uknd5
 E5YQThDrSPaFC9ylLRdM2pktMyN3UWWAEtUtKODed9BgdBUbG6iSBmoaWR4Dpg5WCmo8aVjBkP3
 Zt9bL8/A6fwId/ISyefWuUnMABI1yBsv7Wf2Lo5ynZcUNk8cYsocpeOk85ocjxhfloIjpSlJL9x
 /QGUAasL6En4d1oR7QljFZX+haAhF85OUht85oSUgeSIau4IDAJy1JRL/kJAwquoQItlVPx6g+G
 IZ3hael2odY3e9+w37BPdxFDIbbDAA==
X-Proofpoint-GUID: f26_ql1WNcFRQunpKE2Iv6_zW3z-awHT
X-Authority-Analysis: v=2.4 cv=IdSKmGqa c=1 sm=1 tr=0 ts=690b15f1 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=adoi+G5QptZiRYWGMQz2cA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8
 a=YBl5744q8zTd1FMgO4cA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-ORIG-GUID: f26_ql1WNcFRQunpKE2Iv6_zW3z-awHT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_03,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511050068

Hi,

This series is an initial attempt to support the PCIe M.2 connectors in the
kernel and devicetree binding. The PCIe M.2 connectors as defined in the PCI
Express M.2 Specification are widely used in Notebooks/Tablet form factors (even
in PCs). On the ACPI platforms, power to these connectors are mostly handled by
the firmware/BIOS and the kernel never bothered to directly power manage them as
like other PCIe connectors. But on the devicetree platforms, the kernel needs to
power manage these connectors with the help of the devicetree description. But
so far, there is no proper representation of the M.2 connectors in devicetree
binding. This forced the developers to fake the M.2 connectors as PMU nodes [1]
and fixed regulators in devicetree.

So to properly support the M.2 connectors in devicetree platforms, this series
introduces the devicetree binding for Mechanical Key M connector as an example
and also the corresponding pwrseq driver and PCI changes in kernel to driver the
connector.

The Mechanical Key M connector is used to connect SSDs to the host machine over
PCIe/SATA interfaces. Due to the hardware constraints, this series only adds
support for driving the PCIe interface of the connector in the kernel.

Also, the optional interfaces supported by the Key M connectors are not
supported in the driver and left for the future enhancements.

Future work
===========

I'm planning to submit the follow-up series to add support for the Mechanical
Key A connector for connecting the WiFI/BT cards, once some initial review
happens on this series.

Testing
=======

This series, together with the devicetree changes [2] [3] were tested on the
Qualcomm X1e based Lenovo Thinkpad T14s Laptop which has the NVMe SSD connected
over PCIe.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts?h=v6.18-rc4&id=d09ab685a8f51ba412d37305ea62628a01cbea57
[2] https://github.com/Mani-Sadhasivam/linux/commit/8f1d17c01a0d607a36e19c6d9f7fc877226ba315
[3] https://github.com/Mani-Sadhasivam/linux/commit/0b1f14a18db2a04046ad6af40e94984166c78fbc

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
Manivannan Sadhasivam (4):
      dt-bindings: connector: Add PCIe M.2 Mechanical Key M connector
      PCI/pwrctrl: Add support for handling PCIe M.2 connectors
      PCI/pwrctrl: Create pwrctrl device if the graph port is found
      power: sequencing: Add the Power Sequencing driver for the PCIe M.2 connectors

 .../bindings/connector/pcie-m2-m-connector.yaml    | 121 ++++++++++++++++++
 MAINTAINERS                                        |   7 ++
 drivers/pci/probe.c                                |   3 +-
 drivers/pci/pwrctrl/Kconfig                        |   1 +
 drivers/pci/pwrctrl/slot.c                         |  35 +++++-
 drivers/power/sequencing/Kconfig                   |   8 ++
 drivers/power/sequencing/Makefile                  |   1 +
 drivers/power/sequencing/pwrseq-pcie-m2.c          | 138 +++++++++++++++++++++
 8 files changed, 308 insertions(+), 6 deletions(-)
---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251103-pci-m2-7633631b6faa

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>


