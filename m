Return-Path: <linux-pci+bounces-42482-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EED2DC9BC25
	for <lists+linux-pci@lfdr.de>; Tue, 02 Dec 2025 15:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 910743A7093
	for <lists+linux-pci@lfdr.de>; Tue,  2 Dec 2025 14:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526A4225A34;
	Tue,  2 Dec 2025 14:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="meaYjznM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bgWCy4SF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC9A2153D3
	for <linux-pci@vger.kernel.org>; Tue,  2 Dec 2025 14:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764685385; cv=none; b=tqqzNX8px5QNR/OQWzhuCVqC6hTbyOn0zQK4pU4ZgsTxoR07gMvUlMyrJOMoQjwrqsRL8CJQCNVI6hbhJCqFVF1oYIGiLMZ0PXQ7UHRkgzk5wG1EhyXTlhQbp5x970k87ahOOvc7yavQDn8mvQP3ktm3WhDOw1wC9MiuVM9yF0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764685385; c=relaxed/simple;
	bh=eA6BaU3akT3wnKeZNsD4pLHCgDMpkqhtg9BGK+xv3bk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ptCflhr76S/Cu7L0su0ORHHDndYCzNhIRoduRjIj9e4gFf5CDkqAXHLLeoKovsAwQdZw/8Rog8RLeJUS3hz/VpQcc/xy3F7CzsP4u4rfAKp4kl37NaJDh/LQZqZM5P5gSO+zWm6pDv2zkj7CCcppvQvx0V3KSWkOXD1XFmunR1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=meaYjznM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bgWCy4SF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B2AVckN3660474
	for <linux-pci@vger.kernel.org>; Tue, 2 Dec 2025 14:23:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=gt9061e9Zzb5snnDuta68b
	5d/6B+BS6Pl0XDPKQZm0w=; b=meaYjznMvsh+gVwTDbAvzqohuueOLLbbyHHQna
	Q+ib67jsgOJ0/khNaN15jIysiwwLxWpoSMx4msSHw+OXpSHC+mpfiuR/80RW2Io9
	NpwnIPpQ1WPPcnRQr6Lxynw7UE+WF6FCM13qx05P3nHNtCbJqQelOxCpRDuiUl5Y
	S0anfuPmVgXXlUaPwiNNo0otgOgjfkkQPHdPUmC37SfscKxTIcn+XUqwiZ8sGWz9
	bPJjl0WS+rOI1xoFn23PQLsLtV8Tv8LGUnB/9ZRWRwFnZnFs23tanAklj3YewLj/
	YL6y/04NJt4bgi3N259GcgwAsK4QvKhvz4Hy1gcYQ663SLxA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4asxeegnrw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 02 Dec 2025 14:23:02 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-297e1cf9aedso95237135ad.2
        for <linux-pci@vger.kernel.org>; Tue, 02 Dec 2025 06:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764685381; x=1765290181; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gt9061e9Zzb5snnDuta68b5d/6B+BS6Pl0XDPKQZm0w=;
        b=bgWCy4SFhTuIZwKd0Fd9dou9jG7nZhFTXRN1cmak7xAzx4Te4caKR3Ve9kONnHOZX7
         +WOOjI6x+bgX5wYdfXzY25ojPi95v+wRqDibcrX9tvyF6exCeWaKkp8XZXeDYzP17Fku
         Vx2Qtuo6K7AXoDI6hdXBAqVbaPuAMHXBtFVK42tF6s3QCppGgMWhLZ+/D5QwwL6sZcmZ
         1fTnddkS0IK5GX8ZSoSPgjbtv2x/jOSUqMRjHZpJZ29FGxXIYMWSs6ad5zgPkzxXMyOA
         M2hE4YAdFONEjcQWiTrbEkAyxeaZ6vfNc82LnuCzVjJQZ/FmWILm5Xrs6/E+nnmqF9+2
         FIPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764685381; x=1765290181;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gt9061e9Zzb5snnDuta68b5d/6B+BS6Pl0XDPKQZm0w=;
        b=iOkXe6k5nCuE35mFnu4PMgRLG6ZL/aQUSrKGlUGHtKNF0+YSBpsEVCnBaviTKPKlGt
         UeluImWdl2S2OfhiUGNP6mUbyrrS+t+bkKMz6d3FJ/25vNVfZqKfut3VI0dVXX17WyVA
         I2p6APxGGr4hh2RzA6F0ucDuneSzMSymi6wPrgT1DRDWR2WrtgnHrP+iurWREgbCbXk4
         Rug7+lU7y9nHlbJANX8Quoz1uYA5sife0Zx0jhO+qkcYn5FJ33hMbdGeeJKV7OpTZEko
         16/7WLmLWyiUCGaHEHrkJ377BsU8/F697BpTqQv82Y9U6XziPD/e9K3ZrXGkAP/HLnIH
         t02Q==
X-Gm-Message-State: AOJu0YwRQNak1+wWDWnfgThmWTkLOcLR09ZMh+n4WUivSmW1FvDF5TRW
	e8pA4CwlTF5L1nlE1SyPAeFR2sS3yrjI2Y48F4uk1GezSHGtOM20swe3+L7uaqf4d/u5eRHW/SN
	hKqIQld5oeSTchfs/sRhmQsbUE3cNgtQ0JOOEUeU0Mqeug2Mcq3zFLjhTeE8cW2k=
X-Gm-Gg: ASbGncv9qy3hQ42Fb3Jv+973tcPuLo24JHnw6lZl6LCULTXWthgFLsYeocMp0TDbE3x
	DmbF02HxG57/fmturtwY2hZnV03MRxypHVKnLnViP/Kw3i9KuLz9iH0V/s8tqhFIXS/BhryRmAN
	7yClm9DcvhUdW6E9D0jw63J6oB1wyGJyYSyGhqxW9Qb6Q2qZDKJ7mBNCyvjWrzZIijXvgtWqopG
	zxhGWnNwO2R9Q5VJ8jVMOZsEmXU31IIO2Esok0h1HOrGNE1IDT/Sw04zHFgs8kpfCkD+jHhvkbr
	WS6XzVSYRPYhhLMudBgq1s4Ki7pMzoSGIiBIpPkW4gf2bAvyhcHVooRuhXgCIrVky5tOfeNSBq/
	wClapDhEa58QUAcEywvJk/RztjwAC63/54J/pUTc=
X-Received: by 2002:a17:903:38c4:b0:297:df17:54cd with SMTP id d9443c01a7336-29b6becd454mr555446345ad.27.1764685381155;
        Tue, 02 Dec 2025 06:23:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYGeGusbs/g+jO0YEX3EENp9TaG3F7EKKdp50YdySHdKRFLyNGCxjWLZ57TlxhUWCgvPPUTw==
X-Received: by 2002:a17:903:38c4:b0:297:df17:54cd with SMTP id d9443c01a7336-29b6becd454mr555445975ad.27.1764685380605;
        Tue, 02 Dec 2025 06:23:00 -0800 (PST)
Received: from [192.168.1.102] ([120.60.68.196])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-be5095a4821sm15659084a12.29.2025.12.02.06.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 06:22:59 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: [PATCH v2 0/4] PCI: Fix ACS enablement for Root Ports in OF
 platforms
Date: Tue, 02 Dec 2025 19:52:47 +0530
Message-Id: <20251202-pci_acs-v2-0-5d2759a71489@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADf2LmkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDI1NDIwND3YLkzPjE5GLdJEPTxERjSxNzIwtLJaDqgqLUtMwKsEnRsbW1ANT
 fqndZAAAA
X-Change-ID: 20251201-pci_acs-b15aa3947289
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, Naresh Kamboju <naresh.kamboju@linaro.org>,
        Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        Xingang Wang <wangxingang5@huawei.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4906;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=eA6BaU3akT3wnKeZNsD4pLHCgDMpkqhtg9BGK+xv3bk=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpLvZAsgKRW+ABF3om7Yt/tr9BwOU+D3+JukHRy
 AUokbng5rGJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaS72QAAKCRBVnxHm/pHO
 9fN5B/988yBuq8P3aWdrLMwmZq2znSuNO4gh7x8a4u8iBnTZhMGZb8zXMQPj7tfYyNxQ4nbdyIg
 rZ4F7L344Kj3VeQq7RgJnwjZ471ERtXG6RqiwLD+C7sFlytP5zyc7PLPG1oigJlDNAuaEM8rfOG
 dQ+eQRKy2fs4eTNNe7ftDC903xveyO/8FJeii5IbhEY5zSOAx9TF7KZSPe8K/k0w1lIoh3fis1q
 9toVpP2QOusvKp/bpremIpSAeHoKn+a6/EmRrr2wQZmYxpO+eqQcA03HaqYtUGdjjXOxOr7bBM2
 sk88PqVsmrptpAFAFf0N4yY/RCi+Llx9aDnMrEHxDtofzPL0
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Proofpoint-GUID: MhhVrlxI0S8NUEAPvRqPEHlkjkCHxd5a
X-Authority-Analysis: v=2.4 cv=TMRIilla c=1 sm=1 tr=0 ts=692ef646 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=8ziBJk15IZ5r+wOU3RLduA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8 a=hD80L64hAAAA:8
 a=pGLkceISAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=IdX4pC80JRwBxN0NBHEA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: MhhVrlxI0S8NUEAPvRqPEHlkjkCHxd5a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAyMDExNSBTYWx0ZWRfX72B+q4MtJRHT
 SCio2WDIkwf7TOlTdCMxhWdm7W/lQNFFwRDWEEIQOm8AOVUH3m2qvVYfeREvMnQgdXtYzYIa6iv
 wZBcrKYQKG84lAoyYla9K8uta7FHJCvtc4CaTbVFOnFSjkeEQ9Ql43CluG9uvPnD8qPw9KfU3yR
 y6Wi1JMXQuYQxwjKjgo3QfxuMztpqscPq+sdeCFAOimSKHd1rFByorbESt7hTOPmvHNFWPaV//T
 SVitO8lt1kJ6bYQfe4U4WvV1rqNV0E1CLlcrpQXFYDKG5Ng+mZivMAmgTN4+q4BoAEjIvLkXP7J
 YS/rUzjf3EeP6+pAW6bI0AdVh3uLa3okECYjpvXq4SsZAdNrxbR2TKCSO4Y7cx1I3TInVeLV9Et
 lhL2lFc8J7+rT7vp0B4UsoxCEmyt4A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512020115

Hi,

This series fixes the long standing issue with ACS in OF platforms. There are
two fixes in this series, both fixing independent issues on their own, but both
are needed to properly enable ACS on OF platforms.

Issue(s) background
===================

Back in 2021, Xingang Wang first noted a failure in attaching the HiSilicon SEC
device to QEMU ARM64 pci-root-port device [1]. He then tracked down the issue to
ACS not being enabled for the QEMU Root Port device and he proposed a patch to
fix it [2].

Once the patch got applied, people reported PCIe issues with linux-next on the
ARM Juno Development boards, where they saw failure in enumerating the endpoint
devices [3][4]. So soon, the patch got dropped, but the actual issue with the
ARM Juno boards was left behind.

Fast forward to 2024, Pavan resubmitted the same fix [5] for his own usecase,
hoping that someone in the community would fix the issue with ARM Juno boards.
But the patch was rightly rejected, as a patch that was known to cause issues
should not be merged to the kernel. But again, no one investigated the Juno
issue and it was left behind again.

Now it ended up in my plate and I managed to track down the issue with the help
of Naresh who got access to the Juno boards in LKFT. The Juno issue was with the
PCIe switch from Microsemi/IDT, which triggers ACS Source Validation error on
Completions received for the Configuration Read Request from a device connected
to the downstream port that has not yet captured the PCIe bus number. As per the
PCIe spec r6.0 sec 2.2.6.2, "Functions must capture the Bus and Device Numbers
supplied with all Type 0 Configuration Write Requests completed by the Function
and supply these numbers in the Bus and Device Number fields of the Requester ID
for all Requests". So during the first Configuration Read Request issued by the
switch downstream port during enumeration (for reading Vendor ID), Bus and
Device numbers will be unknown to the device. So it responds to the Read Request
with Completion having Bus and Device number as 0. The switch interprets the
Completion as an ACS Source Validation error and drops the completion, leading
to the failure in detecting the endpoint device. Though the PCIe spec r6.0, sec
6.12.1.1, states that "Completions are never affected by ACS Source Validation".
This behavior is in violation of the spec.

Solution
========

In September, I submitted a series [6] to fix both issues. For the IDT issue,
I reused the existing quirk in the PCI core which does a dummy config write
before issuing the first config read to the device. And for the ACS enablement
issue, I just resubmitted the original patch from Xingang which called
pci_request_acs() from devm_of_pci_bridge_init().

But during the review of the series, several comments were received and they
required the series to be reworked completely. Hence, in this version, I've
incorported the comments as below:

1. For the ACS enablement issue, I've moved the pci_enable_acs() call from
pci_acs_init() to pci_dma_configure().

2. For the IDT issue, I've cached the ACS capabilities (RO) in 'pci_dev',
collected the broken capability for the IDT switches in the quirk and used it to
disable the capability in the cache. This also allowed me to get rid of the
earlier workaround for the switch.

[1] https://lore.kernel.org/all/038397a6-57e2-b6fc-6e1c-7c03b7be9d96@huawei.com
[2] https://lore.kernel.org/all/1621566204-37456-1-git-send-email-wangxingang5@huawei.com
[3] https://lore.kernel.org/all/01314d70-41e6-70f9-e496-84091948701a@samsung.com
[4] https://lore.kernel.org/all/CADYN=9JWU3CMLzMEcD5MSQGnaLyDRSKc5SofBFHUax6YuTRaJA@mail.gmail.com
[5] https://lore.kernel.org/linux-pci/20241107-pci_acs_fix-v1-1-185a2462a571@quicinc.com
[6] https://lore.kernel.org/linux-pci/20250910-pci-acs-v1-0-fe9adb65ad7d@oss.qualcomm.com

Changes in v2:

* Reworked the patches completely as mentioned above.
* Rebased on top of v6.18-rc7

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
Manivannan Sadhasivam (4):
      PCI: Enable ACS only after configuring IOMMU for OF platforms
      PCI: Cache ACS capabilities
      PCI: Disable ACS SV capability for the broken IDT switches
      PCI: Extend the pci_disable_acs_sv quirk for one more IDT switch

 drivers/pci/pci-driver.c |  8 +++++++
 drivers/pci/pci.c        | 33 ++++++++++++--------------
 drivers/pci/pci.h        |  2 +-
 drivers/pci/probe.c      | 12 ----------
 drivers/pci/quirks.c     | 62 ++++++++++++------------------------------------
 include/linux/pci.h      |  2 ++
 6 files changed, 41 insertions(+), 78 deletions(-)
---
base-commit: ac3fd01e4c1efce8f2c054cdeb2ddd2fc0fb150d
change-id: 20251201-pci_acs-b15aa3947289

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>


