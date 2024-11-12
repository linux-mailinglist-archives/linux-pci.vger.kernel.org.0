Return-Path: <linux-pci+bounces-16537-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A209C599B
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 14:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DE441F2337E
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 13:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78D51FBF51;
	Tue, 12 Nov 2024 13:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YVHuN7m7"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691B11FBCBC;
	Tue, 12 Nov 2024 13:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731419677; cv=none; b=iEil5rznQ0UL/uR3995calO/vPg2v4ah3EYG13tsgEiqwcKG31NibYXNl6y729NbYm73A89ZH/FsExdcyqVx0p73Z3GKF5OYR16fUvP8WICighCjKTdm/a5PUmz28dy96N0Aj0avNolUMhas9fozWDXDoScHK59g6jlQ8uoAOmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731419677; c=relaxed/simple;
	bh=rpxkM6gpo4MMArNHaYrI67rjGFHShjJaUXVq85AD6Og=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D5vdEVTUkKvF8k7ZDxv4U31fe0SfW1tIkoEWJ41ensJPXapPcFTTnYtCYvOV409v1OsNK4Vx7lr3cC3HeHdCbg2t5dZc8qmGxpX6zvNUv8MEfhFjhGB/w0uLQBgG29j8MJrZR166zHC5VnAAtn7r+P0n9TZU9pawQln/VBU1OKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YVHuN7m7; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731419671; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=J0yoky5hVi3m0oetpcrW8t6Yucb2Ph3LMUU2z7W3hCI=;
	b=YVHuN7m7uxlieR/w02yOOLWfiwfr+J/WvNCgziGtb3cjZ7UGqgoITQPI7GAJkFIBeRWkisnM4qqsUHkUT/7oNLbTSc0iJZNNUGuRBh05KgvNkyJ5X/FeYLg5FJArLzcSPFQI905vTNKWNQ9If3zxFSOgbHj5irnEv60TmoxbphQ=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WJHmH-E_1731419670 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 12 Nov 2024 21:54:31 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	bhelgaas@google.com,
	kbusch@kernel.org
Cc: mahesh@linux.ibm.com,
	oohall@gmail.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	xueshuai@linux.alibaba.com
Subject: [PATCH v2 0/2] PCI/AER: Report fatal errors of RCiEP and EP if link recoverd
Date: Tue, 12 Nov 2024 21:54:17 +0800
Message-ID: <20241112135419.59491-1-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

- Patch 1/2 identifies the error device by SOURCE ID register
- Patch 2/3 reports the AER status if link recoverd.

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

Shuai Xue (2):
  PCI/DPC: Run recovery on device that detected the error
  PCI/AER: Report fatal errors of RCiEP and EP if link recoverd

 drivers/pci/pci.h      |  5 +++--
 drivers/pci/pcie/aer.c | 11 +++++++----
 drivers/pci/pcie/dpc.c | 32 +++++++++++++++++++++++++-------
 drivers/pci/pcie/edr.c | 35 ++++++++++++++++++-----------------
 drivers/pci/pcie/err.c |  9 +++++++++
 5 files changed, 62 insertions(+), 30 deletions(-)

-- 
2.39.3


