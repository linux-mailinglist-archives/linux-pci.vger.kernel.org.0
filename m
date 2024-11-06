Return-Path: <linux-pci+bounces-16107-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E75EA9BE1BA
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 10:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FDCFB22724
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 09:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454171DE4C6;
	Wed,  6 Nov 2024 09:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="kZ78pNUP"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE4E1DE3CB;
	Wed,  6 Nov 2024 09:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730883841; cv=none; b=Ko0Qb7s8B16qWHPCBw6u0hjqus6jyFdKnwKUi7Ql88u9upJhKy+hCAK7/aP4KFCB6IeHU4NoC1z8bEGh9rkpz3kcNkq94kvs44T5UD52OcTL5O+FtqRa0QsOixeuVC35wLv2SIeSAnuIT3qQABwTvBtgx0kKRtKQZkvVZvSwiKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730883841; c=relaxed/simple;
	bh=qidPoNUqR/ZCstdKkrYlQEKod8UWXPA6uyG69/L1ru4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e1bfQBj7EVyGNavmxAZA0UUrm9Rix35QFlYcdX/04vooHidZ5vffWwSWDyGtZT4EwtaEkEnBO3OSzW+lV4WFbI7gVF2es3pg447qyx+EeXQ4UKAbZssEwm4Y+P0RMOl9HqnWJH70PFhdH2qluOaPwRUdbSAL0CnqL2fs69OxyMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=kZ78pNUP; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730883831; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=/VbmmPghqrzkfDXHRbkEgFY7wgZZwTeBy4+zs3iLQME=;
	b=kZ78pNUP4GA2lpA9nxV4bxWn5PIXQLTJ2KYOF91HRxx4ssScmCOt/5G/hc+HCYCR+s0B/S152FfD8YA5+Q+cV0Tv3YYgH5OsHg44RnYrcOH53uSzVQfCDw0gLwzr7XrH/kMKxo5iomDDtKDBrpLewTWxx/zMKx6MaEbnSfceiWA=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WIqmpCP_1730883829 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 06 Nov 2024 17:03:50 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Cc: bhelgaas@google.com,
	mahesh@linux.ibm.com,
	oohall@gmail.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	xueshuai@linux.alibaba.com
Subject: [RFC PATCH v1 0/2] PCI/AER: report fatal errors of RCiEP and EP if link recoverd
Date: Wed,  6 Nov 2024 17:03:37 +0800
Message-ID: <20241106090339.24920-1-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The AER driver has historically avoided reading the configuration space of an
endpoint or RCiEP that reported a fatal error, considering the link to that
device unreliable. Consequently, when a fatal error occurs, the AER and DPC
drivers do not report specific error types, resulting in logs like:

[  245.281980] pcieport 0000:30:03.0: EDR: EDR event received
[  245.287466] pcieport 0000:30:03.0: DPC: containment event, status:0x0005 source:0x3400
[  245.295372] pcieport 0000:30:03.0: DPC: ERR_FATAL detected
[  245.300849] pcieport 0000:30:03.0: AER: broadcast error_detected message
[  245.307540] nvme nvme0: frozen state error detected, reset controller
[  245.722582] nvme 0000:34:00.0: ready 0ms after DPC
[  245.727365] pcieport 0000:30:03.0: AER: broadcast slot_reset message

But, if the link recovered after hot reset, we can safely access AER status of
the error device. In such case, report fatal error which helps to figure out the
error root case.

- Patch 1/2 identifies the error device by SOURCE ID register
- Patch 2/3 reports the AER status if link recoverd.

After this patch set, the logs like:

[  414.356755] pcieport 0000:30:03.0: EDR: EDR event received
[  414.362240] pcieport 0000:30:03.0: DPC: containment event, status:0x0005 source:0x3400
[  414.370148] pcieport 0000:30:03.0: DPC: ERR_FATAL detected
[  414.375642] pcieport 0000:30:03.0: AER: broadcast error_detected message
[  414.382335] nvme nvme0: frozen state error detected, reset controller
[  414.645413] pcieport 0000:30:03.0: waiting 100 ms for downstream link, after activation
[  414.788016] nvme 0000:34:00.0: ready 0ms after DPC
[  414.796975] nvme 0000:34:00.0: PCIe Bus Error: severity=Uncorrectable (Fatal), type=Data Link Layer, (Receiver ID)
[  414.807312] nvme 0000:34:00.0:   device [144d:a804] error status/mask=00000010/00504000
[  414.815305] nvme 0000:34:00.0:    [ 4] DLP                    (First)
[  414.821768] pcieport 0000:30:03.0: AER: broadcast slot_reset message

Shuai Xue (2):
  PCI/AER: run recovery on device that detected the error
  PCI/AER: report fatal errors of RCiEP and EP if link recoverd

 drivers/pci/pci.h      |  3 ++-
 drivers/pci/pcie/aer.c | 50 ++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pcie/dpc.c | 30 ++++++++++++++++++++-----
 drivers/pci/pcie/edr.c | 35 +++++++++++++++--------------
 drivers/pci/pcie/err.c |  6 +++++
 5 files changed, 100 insertions(+), 24 deletions(-)

-- 
2.39.3


