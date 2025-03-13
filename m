Return-Path: <linux-pci+bounces-23606-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C83EA5F299
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 12:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE2F63B918F
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 11:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0075D266597;
	Thu, 13 Mar 2025 11:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XE13bQZE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4F42661B1
	for <linux-pci@vger.kernel.org>; Thu, 13 Mar 2025 11:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741866048; cv=none; b=pTnA6O6tR7UCReEEKgNlhl6f5l/IsuMDrq0PxkW2gl7vYKs87e2cKLkUt5W1gt9xqUrIu37aDgiKwYzdb0gqr/UNh81oxm7evQdhFpMgnnpHUxB6MBtKWl4nEWq+w7zM+BSTZuiYVvxjYE4ykvi9oRYsZMwaQscN6NO3hYZz3i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741866048; c=relaxed/simple;
	bh=2SgNcjekpgSmNx2cAg4AHpHq4cD2vlM+XcdUmTLUki8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FcJPswsPP9PiPRIzITlu/KXkHgJMhNmcSYNTqyh9qKVl9fEofq30KCdrww/QmUIJq7Xhyt+4q282RhXncbEFbpgAs1znaZ+GAfiJATt5V9XasUp4gx4stAuu4yopOvxFf338rLnSdRCPYzLW/kK6MzfRw6mHls3M2C3PwojlvyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XE13bQZE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DA8e0n027346
	for <linux-pci@vger.kernel.org>; Thu, 13 Mar 2025 11:40:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Gl7dBfMIRvY0UvTHq74D2M
	L1Fou8p6qnw6IkR/ArEuY=; b=XE13bQZEuvxtwFZeeT52hwgPvfrobB8/JWTcUb
	xbZRZFD8w+2wVHkwZe0RF2DCB0S+AV2+6cJAtTNf+XmWw0lX0IbarbYdgcRKmVFi
	LgUJCUWVsOSlWQkQNC6CfEN2Z3MucrlmTIvZIoLmXljRdNxw60wO2jTp5wsKZ16t
	6NYlmiCwyM6gbtz1FN2VOa3+VfTEmIA6BWhMKB8udm6S2hdrbd5RC3p+QC9WhUQn
	w8DVt74Ard51HLVlODHvsvpcae3USubpGMtaGxbPSlN/6SSRNFKeLImQQjpM3Ld2
	cxPiYPM2slhfxBDTqdd0lkx3UIgDP6l7wJoJVCPJjHpOph4w==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au2pwpeq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 13 Mar 2025 11:40:46 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ff7cf599beso1606578a91.0
        for <linux-pci@vger.kernel.org>; Thu, 13 Mar 2025 04:40:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741866045; x=1742470845;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gl7dBfMIRvY0UvTHq74D2ML1Fou8p6qnw6IkR/ArEuY=;
        b=n61gK0IsDZqdizKA/pC/s2TSJpg21a5OYKfjhpu4VuHOiShChgK11WSZYfI5hoUo7L
         wVsQ0xQZvwIpffOSWe1DG0B8uQ9iY+7mfcWMKbeW59WbVUVxu0UsVD7r2zyvRY2jhbUU
         NHfrTkwvNs86+AKf5zfhSBlaeHFSXSDrmmFKJN2qAO+lCshxUZVLwvFuEHpvF6ttoG23
         wJL27G6VAMxx1sIlTKnUGdnhdxVqU637JixkzJAo/kIVVMp5Cbbnf0r93DPBCQyT40qV
         CRmMqMa9XDd1kxP4UbJb47B9M32f4dEErEX7xQQ0MOei+mA/dXqaycNSpBU52aE/cKmv
         wA3A==
X-Gm-Message-State: AOJu0YzYfqsSGRwNUHl1rdJkAhgZhb9RngqKUdWCHNY2L8OuRgHhFP+N
	1GdBe3nPrvjQzhFdQcWjaDoW/X0bjy9XZHX1wtCM4W8+YUvGPegVbplYbj84P24+GDJggMF193D
	d9tbDMrxzhzIzHT4sq3WTNYTcAQW4kck9jb5bMxOX+Yg/eNC5H+SNILXk3QknwRgSDas=
X-Gm-Gg: ASbGncsRH5HXcAzSS4HCEBbXW/Vtc0zE8cz+pkH+zmMDts6/J8EnXKujuxbIi5i1kkX
	U6133SjXZfLt9hxOzTZCmKJgFn5ssRF+Rps1KY0ARwZOpFwFDjiL3Px/Kk4r0nsmLoM2wge/yj1
	k2vE4Ltm2rHmRhCy8xoVtUgvICp+LZ1E5dy0EXblZ8QuLKMIc8Zb/mXet1n42JkPrQF37UQYFOK
	Y6Mgr3T/9/eit85YRSRoR6P+cCH62eprov61xYerE3TDEfzFuO+8SZ7sXj48RiMxyLOmJB0UEvv
	K9Ja2WaZJKEIitXxs1TWYk1q+yu/YIWY26eKZmbYo9d0VaaElbU=
X-Received: by 2002:a05:6a21:700d:b0:1ee:d8c8:4b82 with SMTP id adf61e73a8af0-1f58cbb5ba7mr19226991637.31.1741866045014;
        Thu, 13 Mar 2025 04:40:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6s3QZNBzun6qfGJI2O3KJt450CQvYZp8l0pZDZwjkBQ5mu3SdVVl6RYCh7FCs50haBcj3Xg==
X-Received: by 2002:a05:6a21:700d:b0:1ee:d8c8:4b82 with SMTP id adf61e73a8af0-1f58cbb5ba7mr19226954637.31.1741866044659;
        Thu, 13 Mar 2025 04:40:44 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56ea964e3sm1063219a12.76.2025.03.13.04.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 04:40:44 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v2 00/10] bus: mhi: host: Add support for mhi bus bw
Date: Thu, 13 Mar 2025 17:10:07 +0530
Message-Id: <20250313-mhi_bw_up-v2-0-869ca32170bf@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABfE0mcC/22MwQ6CMBAFf4Xs2ZJuEYye+A9DSEuL3cRSbAU1p
 P9u5ezlJfMymQ2iCWQiXIoNglkpkp8yiEMBg5XTzTDSmUFwUXOBJ+Ys9erVLzMbK6x4I+umQgX
 Zn4MZ6b23rl1mS/Hpw2dPr/h7/1VWZJydldRojkJpha2PsXws8j5458o80KWUvnVrbjypAAAA
To: Bjorn Helgaas <bhelgaas@google.com>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        quic_pyarlaga@quicinc.com, quic_vbadigan@quicinc.com,
        quic_vpernami@quicinc.com, quic_mrana@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Miaoqing Pan <quic_miaoqing@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741866038; l=4760;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=2SgNcjekpgSmNx2cAg4AHpHq4cD2vlM+XcdUmTLUki8=;
 b=o6VzA2SG9Rsit2fb3dOpREA44zKodJ0C7U3EpcGdhR9B+kmwOrlQ2SUNIvaPshB3JMcA1fTox
 mE+KPCyc0/9DlNoQ0QB2sx0shVKdtmCDzeSdUAfQlG0XzLHugIAJWKO
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=P506hjAu c=1 sm=1 tr=0 ts=67d2c43e cx=c_pps a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Vq2kaiCTda8s_ErnlBgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: TcEpyTCp2JkwENYdLPtzC1kEaOJHFu1e
X-Proofpoint-ORIG-GUID: TcEpyTCp2JkwENYdLPtzC1kEaOJHFu1e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_05,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxscore=0 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503130092

As per MHI spec sec 14, MHI supports bandwidth scaling to reduce power
consumption. MHI bandwidth scaling is advertised in devices that contain
the bandwidth scaling capability registers. If enabled, the device
aggregates bandwidth requirements and sends them to the host in the form
of an event. After the host performs the bandwidth switch, it sends an
acknowledgment by ringing a doorbell.

if the host supports bandwidth scaling events, then it must set
BW_CFG.ENABLED bit, set BW_CFG.DB_CHAN_ID to the channel ID to the
doorbell that will be used by the host to communicate the bandwidth
scaling status and BW_CFG.ER_INDEX to the index for the event ring
to which the device should send bandwidth scaling request in the
bandwidth scaling capability register.

As part of mmio init check if the bw scale capability is present or not,
if present advertise host supports bw scale by setting all the required
fields.

MHI layer will only forward the bw scaling request to the controller
driver, it is responsibility of the controller driver to do actual bw
scaling and then pass status to the MHI. MHI will response back to the
device based up on the status of the bw scale received.

Add a new get_misc_doorbell() to get doorbell for misc capabilities to
use the doorbell with mhi events like MHI BW scale etc.

Use workqueue & mutex for the bw scale events as the pci_set_target_speed()
which will called by the mhi controller driver can sleep.

If the driver want to move higher data rate/speed then the current data
rate/speed then the controller driver may need to change certain votes
so that link may come up in requested data rate/speed like QCOM PCIe
controllers need to change their RPMh (Resource Power Manager-hardened)
state. And also once link retraining is done controller drivers needs
to adjust their votes based on the final data rate/speed.

Some controllers also may need to update their bandwidth voting like
ICC bw votings etc.

So, add pre_scale_bus_bw() & post_scale_bus_bw() op to call before & after
the link re-train. There is no explicit locking mechanisms as these are
called by a single client endpoint driver

In case of PCIe switch, if there is a request to change target speed for a
downstream port then no need to call these function ops as these are
outside the scope of the controller drivers.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Changes in v2:
- Update the comments.
- Split the icc bw patch as sepertate one (Bjorn)
- update the aspm disablement comment (Bjorn)
- Use FIELD_GET & FIELD_PREP instead of hard macros and couple of nits
  suggested by (Ilpo Järvinen)
- Create a new function to change lnkcntrl2speed to enum pci_bus_speed (Jeff)
- Link to v1: https://lore.kernel.org/r/20250217-mhi_bw_up-v1-0-9bad1e42bdb1@oss.qualcomm.com

---
Krishna Chaitanya Chundru (8):
      PCI: update current bus speed as part of pci_bus_add_devices()
      PCI/bwctrl: Add support to scale bandwidth before & after link re-training
      PCI: dwc: Implement .pre_scale_bus_bw() & .post_scale_bus_bw hook
      PCI: qcom: Extract core logic from qcom_pcie_icc_opp_update()
      PCI: qcom: Add support for PCIe bus bw scaling
      bus: mhi: host: Add support for Bandwidth scale
      PCI: Export pci_set_target_speed()
      PCI: Add function to convert lnkctl2speed to pci_bus_speed

Miaoqing Pan (1):
      wifi: ath11k: add support for MHI bandwidth scaling

Vivek Pernamitta (1):
      bus: mhi: host: Add support to read MHI capabilities

 drivers/bus/mhi/common.h                          |  20 ++++
 drivers/bus/mhi/host/init.c                       |  93 +++++++++++++++++-
 drivers/bus/mhi/host/internal.h                   |   7 +-
 drivers/bus/mhi/host/main.c                       | 101 +++++++++++++++++++-
 drivers/bus/mhi/host/pm.c                         |  10 +-
 drivers/net/wireless/ath/ath11k/mhi.c             |  41 ++++++++
 drivers/pci/bus.c                                 |   3 +
 drivers/pci/controller/dwc/pcie-designware-host.c |  21 +++++
 drivers/pci/controller/dwc/pcie-designware.h      |   2 +
 drivers/pci/controller/dwc/pcie-qcom.c            | 110 +++++++++++++++++-----
 drivers/pci/pci.c                                 |  12 +++
 drivers/pci/pcie/bwctrl.c                         |  16 ++++
 include/linux/mhi.h                               |  13 +++
 include/linux/pci.h                               |  14 +++
 14 files changed, 431 insertions(+), 32 deletions(-)
---
base-commit: 80e54e84911a923c40d7bee33a34c1b4be148d7a
change-id: 20250217-mhi_bw_up-f31306a5631b

Best regards,
-- 
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>


