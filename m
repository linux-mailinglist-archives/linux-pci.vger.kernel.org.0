Return-Path: <linux-pci+bounces-38104-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E99D2BDC2C1
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 04:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C46242042D
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 02:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75181257AD1;
	Wed, 15 Oct 2025 02:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uqMkjEmc"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD77E2EFD95;
	Wed, 15 Oct 2025 02:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760496131; cv=none; b=S6JgNtGRt5avVEKPmtHmOwFbaSJUK3fiBLElMkdOOgRaD7qNcQbWH2G5ySJNWdTfhUBQGmlkUw4QMgOaP4GOmRuELPjsvI2oy6LPHHauMkoxTAp2iqrFDYq2hV8cjfy0XscbY4jBiiL6e3tChW7pVHhOetEib/zveHM93RlFAmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760496131; c=relaxed/simple;
	bh=014Py1s/FbA/gxplaC4PtzFIBmvUlYJ1ExAgwJXx610=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WcQKMy9QlKoT4dC9pLQj4OJwi0b0a9Jwp18auM5mJ4OC9psz+7mip3XxQ9qlYn0p3W6CcEMe05aHVrk9kfZB7msT9m5wzKsvY0VBS4ntuIGS8GDnkXxwU374Cp7SN/CvyJRexZ/kb+q4X/nvLt8fJOHBEXD4t9HrTrBb319AKyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=uqMkjEmc; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760496121; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=zebhL7qvvzWTRlhLZGSq5g9aY1gfkbEgG5c4GvbYqVw=;
	b=uqMkjEmcicWDq4wWjClUbkGD7fQrx6foIRX4PrkQHd1qZyJCxTPSFKkRm+UxbL7nYfZe3IW3CYRgH7crXep8W5OesqZ6ANIVbufIc05y4BtDXpwmv4Y2zDtlffQPLfmHnbv5UAZoTUcfgRN+NZ0qcsDM4ApCbvvQeT6DXN47mx8=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WqEYD3-_1760496119 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 15 Oct 2025 10:42:01 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	bhelgaas@google.com,
	kbusch@kernel.org,
	sathyanarayanan.kuppuswamy@linux.intel.com
Cc: mahesh@linux.ibm.com,
	oohall@gmail.com,
	xueshuai@linux.alibaba.com,
	Jonathan.Cameron@huawei.com,
	terry.bowman@amd.com,
	tianruidong@linux.alibaba.com,
	lukas@wunner.de
Subject: [PATCH v6 0/5] PCI/AER: Report fatal errors of RCiEP and EP if link recoverd
Date: Wed, 15 Oct 2025 10:41:54 +0800
Message-Id: <20251015024159.56414-1-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

changes since v5:
- rebase to 6.18-rc1
- add separate patches to clear device fatal status per Kuppuswamy

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

Shuai Xue (5):
  PCI/DPC: Clarify naming for error port in DPC Handling
  PCI/DPC: Run recovery on device that detected the error
  PCI/AER: Report fatal errors of RCiEP and EP if link recoverd
  PCI/ERR: Use pcie_aer_is_native() to check for native AER control
  PCI/AER: Clear both AER fatal and non-fatal status

 drivers/pci/pci.h      |  6 ++++--
 drivers/pci/pcie/aer.c | 18 +++++++++++-------
 drivers/pci/pcie/dpc.c | 31 ++++++++++++++++++++++++-------
 drivers/pci/pcie/edr.c | 35 ++++++++++++++++++-----------------
 drivers/pci/pcie/err.c | 16 +++++++++++++---
 5 files changed, 70 insertions(+), 36 deletions(-)

-- 
2.39.3


