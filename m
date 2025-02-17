Return-Path: <linux-pci+bounces-21569-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AF5A379D5
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 03:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E0A73AE622
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 02:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F22741C71;
	Mon, 17 Feb 2025 02:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="AzZJF1qv"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA3546BF;
	Mon, 17 Feb 2025 02:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739760150; cv=none; b=n7aTD3LAvZ3zFk7W+NvlThkiNkZAsWWrejsd6Z3ClX2U54VJOn0INuwZ946VrLDw8vKgZk1BMQYqdkudgowJauBgRMQ/h36FgG6LCxtgmR/wd7dbyaX6ZQbPGHdZ+Zfycw1PWcmEE0DEgzAJDBSci7hFXDdWmt/RdCyjS7drzSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739760150; c=relaxed/simple;
	bh=g18vLvEIV15RdL6Pta+w/k1IEM9YdjuSeCpk6WlEJpc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=moRUceFxJejYOLaz8SqCwevAPsXA5MT7APjE8Q2p/XqcdsdQubEHy/SlwLoZVMQKJJRAGxbZIZaogbSx714hdZu25me802atkH48BGFWhzjdU789iqy/SAMUTgxkfRDxZIE07oqiU0pfOUovWvIvjNYIoW8y7coW0Nko4ZIiEU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=AzZJF1qv; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739760142; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=IWnXk2v+MvIdKRnunCl5x6oEXE/uiljBcFUSPpVL73o=;
	b=AzZJF1qvWmZsVNMAImWeksAs2HzPevm7zSvoCp9JuXiNjwO8kyB9z7QOTQFtVp9W9XWp1jrT5Xo8MKB3UPyT6AK0NZB1l5ypceQynMnQBzjd2yyfzQ/yLSKiFOhVh732npjKbnFpwRE8lbj9u/Lp7sOW9x1gtE6TnylIwhqOQAs=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WPYBR1G_1739760140 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 17 Feb 2025 10:42:22 +0800
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
	tianruidong@linux.alibaba.com
Subject: [PATCH v4 0/3] PCI/AER: Report fatal errors of RCiEP and EP if link recoverd
Date: Mon, 17 Feb 2025 10:42:15 +0800
Message-ID: <20250217024218.1681-1-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

changes since v3:
- squash patch 1 and 2 into one patch per Sathyanarayanan
- add comments note for dpc_process_error per Sathyanarayanan
- pick up Reviewed-by tag from Sathyanarayanan

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

   pcieport 0000:30:03.0: EDR: EDR event received
   pcieport 0000:30:03.0: DPC: containment event, status:0x0005 source:0x3400
   pcieport 0000:30:03.0: DPC: ERR_FATAL detected
   pcieport 0000:30:03.0: AER: broadcast error_detected message
   nvme nvme0: frozen state error detected, reset controller
   nvme 0000:34:00.0: ready 0ms after DPC
   pcieport 0000:30:03.0: AER: broadcast slot_reset message

AER status registers are sticky and Write-1-to-clear. If the link recovered
after hot reset, we can still safely access AER status of the error device.
In such case, report fatal errors which helps to figure out the error root
case.

After this patch set, the logs like:

   pcieport 0000:30:03.0: EDR: EDR event received
   pcieport 0000:30:03.0: DPC: containment event, status:0x0005 source:0x3400
   pcieport 0000:30:03.0: DPC: ERR_FATAL detected
   pcieport 0000:30:03.0: AER: broadcast error_detected message
   nvme nvme0: frozen state error detected, reset controller
   pcieport 0000:30:03.0: waiting 100 ms for downstream link, after activation
   nvme 0000:34:00.0: ready 0ms after DPC
   nvme 0000:34:00.0: PCIe Bus Error: severity=Uncorrectable (Fatal), type=Data Link Layer, (Receiver ID)
   nvme 0000:34:00.0:   device [144d:a804] error status/mask=00000010/00504000
   nvme 0000:34:00.0:    [ 4] DLP                    (First)
   pcieport 0000:30:03.0: AER: broadcast slot_reset message 

Shuai Xue (3):
  PCI/DPC: Clarify naming for error port in DPC Handling
  PCI/DPC: Run recovery on device that detected the error
  PCI/AER: Report fatal errors of RCiEP and EP if link recoverd

 drivers/pci/pci.h      |  5 +++--
 drivers/pci/pcie/aer.c | 11 +++++++----
 drivers/pci/pcie/dpc.c | 34 +++++++++++++++++++++++++++-------
 drivers/pci/pcie/edr.c | 35 ++++++++++++++++++-----------------
 drivers/pci/pcie/err.c |  9 +++++++++
 5 files changed, 64 insertions(+), 30 deletions(-)

-- 
2.39.3


