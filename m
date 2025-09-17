Return-Path: <linux-pci+bounces-36320-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D12B7DBC5
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 14:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3264D165E96
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 06:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5467A283140;
	Wed, 17 Sep 2025 06:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="XexQ9P0T"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D7826F29F;
	Wed, 17 Sep 2025 06:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758090846; cv=none; b=SH8KtO4L5L9KKmkeRQDO8HoEqNInu+lHIg4a7QYnp9ZdnxRQkgvrSSsEqihGwaIlhkfRdwa+jaBv5k09BpXtp4TfodhCMjeffEIUncLq4sUlS8X6gXwLQ/4vGx450ZqPDzjVVJHRjwDOsiHXktsSfC4zDLjnzjmGsaY3tUaXQi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758090846; c=relaxed/simple;
	bh=qV51Bzr1Uaqo7vTv4kUZrSpIVL0MQlRN1/V/D8aZiIM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iSxu9Ywd0FqA8s+7KPqvmf0yhnHInJra60mBTrdFJDHs6/xBu7U+6y/RxmaSRdgIHSSN/nDI8TQ0t3Pb79VT9SH6jVRew0eEzTLm/TJLPytfhid8j7YBC/uvVf0sOOdrJZ05lTo69dIhkpShnKmj7zpyZ0/myLQer41SGOjn3B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=XexQ9P0T; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758090834; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=ig9l9rq/RFKj6WZZ/ptY2bx7snCiOe83lWv6zfwEAe4=;
	b=XexQ9P0TwtLZY0XOHJSVlvMQUVXgRunI4fvvWnqodd2JttloSkrpvlLJMsL3tn9l2TJ5PZ8y4nF1XPO0El9132BQMtBWxsFTfPzzZGzWXRv20AJXDVsn8312nEPeNrgXUg1rCYlf2w8sWVlMuTPb11wmCBtUP+0/4QoeopPPZW0=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WoBL8JQ_1758090832 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 17 Sep 2025 14:33:54 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: bhelgaas@google.com,
	mahesh@linux.ibm.com,
	mani@kernel.org,
	Jonathan.Cameron@huawei.com,
	sathyanarayanan.kuppuswamy@linux.intel.com
Cc: oohall@gmail.com,
	xueshuai@linux.alibaba.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v5 0/3] PCI/AER: Report fatal errors of RCiEP and EP if link recoverd
Date: Wed, 17 Sep 2025 14:33:49 +0800
Message-Id: <20250917063352.19429-1-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

changes since v4:
- rebase to 6.17-rc6
- pick up Reviewed-by tag for PATCH[2] from Sathyanarayanan
- minor typos in commit log per Manivannan

changes since v3:
- squash patch 1 and 2 into one patch per Sathyanarayanan
- add comments note for dpc_process_error per Sathyanarayanan
- pick up Reviewed-by tag for PATCH[1] from Sathyanarayanan

changes since v2:
- moving the "err_port" rename to a separate patch per Sathyanarayanan
- rewrite comments of dpc_process_error per Sathyanarayanan
- remove NULL initialization for err_dev per Sathyanarayanan

changes since v1:
- rewrite commit log per Bjorn
- refactor aer_get_device_error_info to reduce duplication per Keith
- fix to avoid reporting fatal errors twice for root and downstream ports per Keith

The AER driver has historically avoided reading the configuration space of an
endpoint or RCiEP that reported a fatal error, considering the link to that
device unreliable. Consequently, when a fatal error occurs, the AER and DPC
drivers do not report specific error types, resulting in logs like:

	pcieport 0015:00:00.0: EDR: EDR event received
	pcieport 0015:00:00.0: EDR: Reported EDR dev: 0015:00:00.0
	pcieport 0015:00:00.0: DPC: containment event, status:0x200d, ERR_FATAL received from 0015:01:00.0
	pcieport 0015:00:00.0: AER: broadcast error_detected message
	pcieport 0015:00:00.0: AER: broadcast mmio_enabled message
	pcieport 0015:00:00.0: AER: broadcast resume message
	pcieport 0015:00:00.0: pciehp: Slot(21): Link Down/Up ignored
	pcieport 0015:00:00.0: AER: device recovery successful
	pcieport 0015:00:00.0: EDR: DPC port successfully recovered
	pcieport 0015:00:00.0: EDR: Status for 0015:00:00.0: 0x80

AER status registers are sticky and Write-1-to-clear. If the link recovered
after hot reset, we can still safely access AER status and TLP header of the
error device. In such case, report fatal errors which helps to figure out the
error root case.

After this patch, the logs like:

	pcieport 0015:00:00.0: EDR: EDR event received
	pcieport 0015:00:00.0: EDR: Reported EDR dev: 0015:00:00.0
	pcieport 0015:00:00.0: DPC: containment event, status:0x200d, ERR_FATAL received from 0015:01:00.0
	pcieport 0015:00:00.0: AER: broadcast error_detected message
	vfio-pci 0015:01:00.0: PCIe Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
	pcieport 0015:00:00.0: pciehp: Slot(21): Link Down/Up ignored
	vfio-pci 0015:01:00.0:   device [144d:a80a] error status/mask=00001000/00400000
	vfio-pci 0015:01:00.0:    [12] TLP                    (First)
	vfio-pci 0015:01:00.0: AER:   TLP Header: 0x4a004010 0x00000040 0x01000000 0xffffffff
	pcieport 0015:00:00.0: AER: broadcast mmio_enabled message
	pcieport 0015:00:00.0: AER: broadcast resume message
	pcieport 0015:00:00.0: AER: device recovery successful
	pcieport 0015:00:00.0: EDR: DPC port successfully recovered
	pcieport 0015:00:00.0: EDR: Status for 0015:00:00.0: 0x80

Shuai Xue (3):
  PCI/DPC: Clarify naming for error port in DPC Handling
  PCI/DPC: Run recovery on device that detected the error
  PCI/AER: Report fatal errors of RCiEP and EP if link recoverd

 drivers/pci/pci.h      |  5 +++--
 drivers/pci/pcie/aer.c | 11 +++++++----
 drivers/pci/pcie/dpc.c | 31 ++++++++++++++++++++++++-------
 drivers/pci/pcie/edr.c | 35 ++++++++++++++++++-----------------
 drivers/pci/pcie/err.c | 11 +++++++++++
 5 files changed, 63 insertions(+), 30 deletions(-)

-- 
2.39.3


