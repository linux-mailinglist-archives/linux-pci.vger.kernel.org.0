Return-Path: <linux-pci+bounces-43943-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C3443CEEE12
	for <lists+linux-pci@lfdr.de>; Fri, 02 Jan 2026 16:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C6705300768D
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jan 2026 15:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E8822D78A;
	Fri,  2 Jan 2026 15:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZumjnFLY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B2A3C465;
	Fri,  2 Jan 2026 15:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767368105; cv=none; b=AwwmkR4O74WoL5tYUMSEZYKUtHOj5oDghy3OANKVEctwRDqb5c/qZmzDSR2BNr0jGB2LvbG8TWEkVkaGiJ+YVYCBEyQ8914bwWAHdGUP5natm+Dfu7hkjeiXRr/97RIkDE2VQ5I13VGbxpj/fHrfusfY73pRKWksala5x02cHYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767368105; c=relaxed/simple;
	bh=yKt9mXmVeWjVPM+Kk7KdqbalkLGUCWIr2ZFmKG8rePc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LbOvbAu7vHE+R2GWgXA3KuiSr3BpbMEyJ4GB4IK+yHvqMCcpH1+y/ZvHj1EsQ2kq/56e3JEVQudE6iBUV7EhHXj1LakbqwiYnzoTcR/iSSzpmJv7mKoe+zdwucRvf+FRi+/MB0gbzOnW6NQP68yfF2P825mh8StfNScoilz/jZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZumjnFLY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D6B2C116B1;
	Fri,  2 Jan 2026 15:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767368104;
	bh=yKt9mXmVeWjVPM+Kk7KdqbalkLGUCWIr2ZFmKG8rePc=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=ZumjnFLY2bdbYaMpM6rEPG6egTRiU2gAEgEPQkCqIoLv6FRyFrwRG9lmCSvnNMHIG
	 sSM4XDuSmRaxJZwNNrbdypDUVFVDSsVDsVXb33099GI/GO7pdjIi3DfbRSsbNzsz3m
	 qx8dy4WfdkJY+pRejHO//b+onxMv7nmDexq0DxDAAI1vE832E8kKbFoBeutorXkfAF
	 NM12+fFxLxYXjF2DUPIUYhjOUp2W8mIBWp9mXJbkPjfpZcd5dINts6yqK0KOxV4lti
	 rag8X+CnJJ8k9cpJjQZk4FNGkApQ61MCuLdijpe2p4tSpQlSV895rVidLKgGVQit4Z
	 DaEK6CXoU0WbQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E425EED628;
	Fri,  2 Jan 2026 15:35:04 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Subject: [PATCH v3 0/4] PCI: Fix ACS enablement for Root Ports in OF
 platforms
Date: Fri, 02 Jan 2026 21:04:46 +0530
Message-Id: <20260102-pci_acs-v3-0-72280b94d288@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJblV2kC/z3MQQrCMBCF4auUWZuSTBvSuPIeUiSm0Q7Ypma0K
 KV3NxZ0M/APj28BDokCw75YIIWZmOKYo9oV4Hs3XoOgLjegRK1QKjF5OjnP4qy0c5WtDTYW8np
 K4UKvTTq2uXviR0zvDZ7x+/0Z+DdmFFLoDo22zqi6sYfIXN6f7ubjMJT5QLuu6wdrODPxpQAAA
 A==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5180;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=yKt9mXmVeWjVPM+Kk7KdqbalkLGUCWIr2ZFmKG8rePc=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpV+WlUVx/4bTP6BfZNlt9eRALRoMamvKIMXGrS
 rLG5CQHJE2JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaVflpQAKCRBVnxHm/pHO
 9c1yB/9lxtQB67vgbAZABpKAdvNTS9M+n/dB9DGvBp36IZwncJeWKEh5UCXoElnzqv9GazqhCIy
 Ul9O3agybGYO1QOMFtOM5pW5eBM0VW9CUC/9tMK/RVWNRqLzen5WlQDUn7b4ITqBxd4bnfE1vor
 CY/F9/5lFDy8FprwqsRmORYkMAE+MgtayGr5XSKl369u88v8F0gMwYyhwk/sjatOFBQ+FhXxzTS
 i3hr+i5LPqGLVky0X4yeXrBLqXR7Sw22IlwpUR7zRG3MMgB0HUoX6Ob8eXEe6bfSFgqSIiZdSZP
 HBzAXzMoYgdtwKFgT+lrKI03d0GyB0M9X9y579vz/u0J07zk
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

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
and disabled the broken capability for the IDT switches in the cache. This also
allowed to get rid of the earlier workaround for the switch.

[1] https://lore.kernel.org/all/038397a6-57e2-b6fc-6e1c-7c03b7be9d96@huawei.com
[2] https://lore.kernel.org/all/1621566204-37456-1-git-send-email-wangxingang5@huawei.com
[3] https://lore.kernel.org/all/01314d70-41e6-70f9-e496-84091948701a@samsung.com
[4] https://lore.kernel.org/all/CADYN=9JWU3CMLzMEcD5MSQGnaLyDRSKc5SofBFHUax6YuTRaJA@mail.gmail.com
[5] https://lore.kernel.org/linux-pci/20241107-pci_acs_fix-v1-1-185a2462a571@quicinc.com
[6] https://lore.kernel.org/linux-pci/20250910-pci-acs-v1-0-fe9adb65ad7d@oss.qualcomm.com

Changes in v3:
- Dropped the 'acs_broken_cap' field and directly called the quirk from
  pci_acs_init()
- Collected tags. Since the delta between v2 and v3 is minimal, I've kept them.
- Rebased on top of v6.19-rc1 
- Link to v2: https://lore.kernel.org/r/20251202-pci_acs-v2-0-5d2759a71489@oss.qualcomm.com

Changes in v2:

* Reworked the patches completely as mentioned above.
* Rebased on top of v6.18-rc7

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
Manivannan Sadhasivam (4):
      PCI: Enable ACS only after configuring IOMMU for OF platforms
      PCI: Cache ACS capabilities
      PCI: Disable ACS SV capability for the broken IDT switches
      PCI: Extend the pci_disable_broken_acs_cap() quirk for one more IDT switch

 drivers/pci/pci-driver.c |  8 +++++++
 drivers/pci/pci.c        | 33 ++++++++++++--------------
 drivers/pci/pci.h        |  4 +++-
 drivers/pci/probe.c      | 12 ----------
 drivers/pci/quirks.c     | 62 ++++++++++++------------------------------------
 include/linux/pci.h      |  1 +
 6 files changed, 42 insertions(+), 78 deletions(-)
---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251201-pci_acs-b15aa3947289

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>



