Return-Path: <linux-pci+bounces-29205-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD48BAD1BD2
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 12:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 546663ABBDA
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 10:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B058255222;
	Mon,  9 Jun 2025 10:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MmNM79F5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DCE2550B3
	for <linux-pci@vger.kernel.org>; Mon,  9 Jun 2025 10:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749466302; cv=none; b=InPQb3mUosSca256FaOzNbnpyq2RjNQanbjS+iFE1NYgUXc0DBleel40k0lz7ar1FOK88Ut2+bGjOtF79kis6PzoDkUTnuSXjKdaStUKKPAQ/xSQGExtiaVMcXS0qkBaaTEt9WSdI7I2rslasSdDcCkkEtKKkrfLjD7UZl54RAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749466302; c=relaxed/simple;
	bh=rFIAQDFx/eu1NmFhsrsbLmcPgKmZywYDhyHzqhNfrLQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fjQCt0JxdWAgkObtV+ZRgEmwRCn9ilyqPzc2gkewbrrJL7oT9uSKzsjmAhlorRX30mk9LNqivufNjj49eJMM1cVPAy3yy410jLR4ktae/vLdo4JsO8CMsqE3ccHnQqeVSA/dmwGuKq8qPUQJ3zAnx1go1cWuXwfPuS40Ti/fO+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MmNM79F5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5599MYWm006545
	for <linux-pci@vger.kernel.org>; Mon, 9 Jun 2025 10:51:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=VhUteTfXsocNRs+IopB/b3
	CazovW+anusy46N1ig4I4=; b=MmNM79F5vXiV9wy2/idzS3EvXZ/ms76SWlloWk
	d5oHC2717UXQ4r1VoNqeyI3VlbOjRYwM69M/rJMZPbDObF8aLZYEUg5FjD1dwCFi
	/4awyr/9NNbeYa29X7m9rDMiBuAOVOA2indGk0volUd0AS01alO56AMKs5IIa7Ch
	ooqNooSAvi9dD5QFunYF4AG4ECAgBm0hawS3vpRoeqXW/ZNNx8N2JjOHKUani7yw
	I/lqHHnK9e88PsOpymltgbVASLKyyvqRMbpXCqEKzsK//Gajw/aGXrgIW1ofFobQ
	jzmeRmgfJ5nd+v759tv3b34ke6yp2IZLmLoGIdBrNihCqp6g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 474ce9nwnt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 09 Jun 2025 10:51:39 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-235e3f93687so65644655ad.2
        for <linux-pci@vger.kernel.org>; Mon, 09 Jun 2025 03:51:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749466298; x=1750071098;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VhUteTfXsocNRs+IopB/b3CazovW+anusy46N1ig4I4=;
        b=KTYlRHwHCgxBRBbVEBtmdJvidQBInLdrjh+u9d6XwERap+c8w4EF41jOYKs9MIzKk6
         m6q/jGHdt68nWQ8keRPbhV/PoRydQNIIxLuazmZ8Le+f9mo6A6cBGLF81b1cBjE194rd
         NIB9uRHpELYZcGfSf+CN8fCbqiWLfuBOPz7CTdyQiryBFWUX0LnENhURkzE2HGVJXbWl
         CEkpvEVjVsJzysevrx1LWgos8KxuJphYmKb6iUabasi6fFvfYmjHp3P8hGTeFEm8Gd7I
         Bbz5dJhZ9VdUJLiPHKKY3dCKg9VkmAxAy5xRTVMfFI8icOrR0gSZ3dTWVrnSRxxhVPjp
         gy/Q==
X-Gm-Message-State: AOJu0Yw3eSH2RCzB1RqvYasYAsC7czZ7mPqfEoyqmRsUJiCy+6q6F7lT
	/rINNXvmXrpr3JhFktFqm1A3Y/CE1yAM/JoxJnkd1W6wpK3Mv8L8k1IiBQMEFbau6+LU5DvdkNi
	LKj/t4CoY7PJTIaawclsu8S+xYT0jaWw01lKsglvWAw7jgBaIZGdwxFqJg2fKl6A=
X-Gm-Gg: ASbGncslZDcdg9300xAOQGw/2H+tajkzUNYOdvQixJdv5rWK5Ei24TnX715EHUkp78U
	NER1cLv0+wF7DRavE+YHuS70evKj6uxFQXt6wvWJc/h6i9WeOftxz8JK6kJzMqQIpCbiatiRxnf
	7mDpfVOiNcVnBocDx/5lSZIQy9CL0IIpievRDdy0TOhAsCsVO49UletPu+jq2sRWxbiNsUeC9k3
	3e2cXm/IV4ke9YB/+V2DiB2+Twm30UMEz5ArI3trAnfqAM4ki6NHmBKwus9LOeKfx7U40GngTfg
	Jcj7JbKff09xLI1NDDYocsENnQ9N2eeETwYUEw4cECJ8CWkaUmDN1tkEuQ==
X-Received: by 2002:a17:902:dac6:b0:235:eefe:68f4 with SMTP id d9443c01a7336-23601d136femr181529445ad.29.1749466297814;
        Mon, 09 Jun 2025 03:51:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFm+FtLDaA6kNuRa0Yr3ML7VmNAJgTPlNgcbPHQTB/P+a/aBP+VmVd3vj1/TEZYxUdP0IgxXQ==
X-Received: by 2002:a17:902:dac6:b0:235:eefe:68f4 with SMTP id d9443c01a7336-23601d136femr181529045ad.29.1749466297386;
        Mon, 09 Jun 2025 03:51:37 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603092f44sm51836465ad.63.2025.06.09.03.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 03:51:36 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v4 00/11] bus: mhi: host: Add support for mhi bus bw
Date: Mon, 09 Jun 2025 16:21:21 +0530
Message-Id: <20250609-mhi_bw_up-v4-0-3faa8fe92b05@qti.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKm8RmgC/3XNzQ6CMAzA8VcxOzuybnyIJ9/DGLLCkCXCkAlqC
 O9u4QIHvDT5N82vI/Oms8az82FknRmst66hCI8Hlle6uRtuC2omhYyEhITXlc3wnfUtLxUoEes
 oVoCM7tvOlPazWNcbdWX9y3XfhR5g3u4pA3DBU9QFmFBigXBx3gfPXj9yV9cBDTZjg1wB+rsFJ
 AGnOM21Illg+QdQKxBBugUUAUrnRaghQcRoB5im6QeSLrsXKwEAAA==
X-Change-ID: 20250217-mhi_bw_up-f31306a5631b
To: Bjorn Helgaas <bhelgaas@google.com>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Manivannan Sadhasivam <mani@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        qiang.yu@oss.qualcomm.com, quic_vbadigan@quicinc.com,
        quic_vpernami@quicinc.com, quic_mrana@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Miaoqing Pan <quic_miaoqing@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749466291; l=5603;
 i=krichai@qti.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=rFIAQDFx/eu1NmFhsrsbLmcPgKmZywYDhyHzqhNfrLQ=;
 b=r6QucqB8z7wv1BaaOVcAgK2+rQjPvMf+dR+w28WUfwzwB3Ew05qNSBB9OLHe1B8m45MVCPquB
 mbkAZCL2tzMBx0A2yJgzpJ3FI/gSh5s5lUnSWXmF/m76ANL4hPWpKFK
X-Developer-Key: i=krichai@qti.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: 7M-u5Q8MpXDBlmj2NSJBjS7U2qo2e64t
X-Authority-Analysis: v=2.4 cv=drjbC0g4 c=1 sm=1 tr=0 ts=6846bcbb cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=a1UGM4vktcZ-V-6vu5QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: 7M-u5Q8MpXDBlmj2NSJBjS7U2qo2e64t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDA4MiBTYWx0ZWRfXzLYYbcirAgtL
 XVsXMzCSt7Wfa5MD9LU8piqLqKQRb+0H7Ggy+PRzYJzkAvSeFPBU0yHOUgrfLti72sLPnBDEo++
 17jm8MnGfqHF92SYKxsB/E20Hb4D0JkkZ7X4QM1ZdSjzn3mLEzvTRwSYChE/JgczndUJ99rmKCb
 bEB2piUgH5tYB5yWYHR0ZCHJr3y1uZpP7vSQzr1wIasX1sKPSxLQCQFU3UoCfgCxez2LUA7tYx0
 Fn7fpLXs/7l8dJ1gJjmZv9m48nu1gaZESSthdsfLTgHd4PJ6f38n5Zg42wPbUSEE1TIjJy5aZfU
 1A50Doqgm98BNYcj69loDFYVxuh80UIPy8U9FVs503XmN2slw3xpPTGTOv/cFqTM3bdam9IFYyj
 o5pHBk0Rqxj1LRmertVhCa/sMcyGUd9HF71x41pb+nYI+ozLPw1LBkknY94uScuD2iYfhq2b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_04,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 phishscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506090082

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

So, add pre_link_speed_change() & post_link_speed_change() op to call before & after
the link re-train. There is no explicit locking mechanisms as these are
called by a single client endpoint driver

In case of PCIe switch, if there is a request to change target speed for a
downstream port then no need to call these function ops as these are
outside the scope of the controller drivers.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Changes in v4:
- Remove leftover type case, change the function names to pre/post_link_speed_change(Ilpo Järvinen)
- Add check's for capability read and convert le32 to cpu (Jeffrey Hugo)
- Add macros for GENMASK & BIT() (Ilpo Järvinen)
- Link to v3: https://lore.kernel.org/r/20250519-mhi_bw_up-v3-0-3acd4a17bbb5@oss.qualcomm.com

Changes in v3:
- Move update speed logic to pwrctrl driver (Mani)
- Move pre_bus_bw & post_bus_bw to bridge as these are bridge driver specific ops,
it feels to me we need to add these in the host bridge driver similar to recently
added one reset_slot.
- Remove dwc level wrapper (Mani)
- Enable ASPM only if they are enabled already (Mani)
- Change the name of mhi_get_capability_offset to mhi_find_capability() (Bjorn)
- Fix comments in the code, subjects etc (Mani & Bjorn)
- Link to v2: https://lore.kernel.org/r/20250313-mhi_bw_up-v2-0-869ca32170bf@oss.qualcomm.com

Changes in v2:
- Update the comments.
- Split the icc bw patch as sepertate one (Bjorn)
- update the aspm disablement comment (Bjorn)
- Use FIELD_GET & FIELD_PREP instead of hard macros and couple of nits
  suggested by (Ilpo Järvinen)
- Create a new function to change lnkcntrl2speed to enum pci_bus_speed (Jeff)
- Link to v1: https://lore.kernel.org/r/20250217-mhi_bw_up-v1-0-9bad1e42bdb1@oss.qualcomm.com

---
Krishna Chaitanya Chundru (9):
      PCI: Update current bus speed as part of pci_pwrctrl_notify()
      PCI/bwctrl: Add support to scale bandwidth before & after link re-training
      bus: mhi: host: Add support for Bandwidth scale
      PCI/ASPM: Return enabled ASPM states as part of pcie_aspm_enabled()
      PCI/ASPM: Clear aspm_disable as part of __pci_enable_link_state()
      PCI: qcom: Extract core logic from qcom_pcie_icc_opp_update()
      PCI: qcom: Add support for PCIe pre/post_link_speed_change()
      PCI: Export pci_set_target_speed()
      PCI: Add function to convert lnkctl2speed to pci_bus_speed

Miaoqing Pan (1):
      wifi: ath11k: Add support for MHI bandwidth scaling

Vivek Pernamitta (1):
      bus: mhi: host: Add support to read MHI capabilities

 drivers/bus/mhi/common.h               |  26 +++++++
 drivers/bus/mhi/host/init.c            |  97 +++++++++++++++++++++++++-
 drivers/bus/mhi/host/internal.h        |   7 +-
 drivers/bus/mhi/host/main.c            |  98 +++++++++++++++++++++++++-
 drivers/bus/mhi/host/pm.c              |  10 ++-
 drivers/net/wireless/ath/ath11k/mhi.c  |  41 +++++++++++
 drivers/pci/controller/dwc/pcie-qcom.c | 124 ++++++++++++++++++++++++++-------
 drivers/pci/pci.c                      |  12 ++++
 drivers/pci/pcie/aspm.c                |   5 +-
 drivers/pci/pcie/bwctrl.c              |  16 +++++
 drivers/pci/pwrctrl/core.c             |   5 ++
 include/linux/mhi.h                    |  13 ++++
 include/linux/pci.h                    |  23 +++++-
 13 files changed, 442 insertions(+), 35 deletions(-)
---
base-commit: d178209b7c211256ee736ec7c920acb81ddcea48
change-id: 20250217-mhi_bw_up-f31306a5631b

Best regards,
-- 
krishnachaitanya-linux <krichai@qti.qualcomm.com>


