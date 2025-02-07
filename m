Return-Path: <linux-pci+bounces-20872-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DFCA2BF7B
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 10:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B2CF7A1C39
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 09:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA0B1DE3A7;
	Fri,  7 Feb 2025 09:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xN6X0AaD"
X-Original-To: linux-pci@vger.kernel.org
Received: from out199-7.us.a.mail.aliyun.com (out199-7.us.a.mail.aliyun.com [47.90.199.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD3D236A89;
	Fri,  7 Feb 2025 09:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738920924; cv=none; b=AHa0ecnAxFqPXF3Rf28ajLj8WoFSlcrS4ylgoaFc7VxxpkQES72f5vp49THH54HqAd6hWs9SjyVWLFaxf4aa0aH/HED/dfSz8p/4/ZepM69RkVUa93DFjvCyvA0cMfSOllWFDVzSI029KMp9KAg1HMemBOzhyq1G/ztyEiDdFLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738920924; c=relaxed/simple;
	bh=n+KDLJ+vD3Bt+/Cr8vhSTfA6mf0eChU3PqcwnHXsbxk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nII9D5ZfdkCFLMqhrA2U2FDci30Ir7rN2J1topg2XHwNjfFGHv1F0ZylFmvonDQN8gJgs6bhcCfWRLYo6F0u5G/qnxloFuj8I817Wwjykx1xwBpKrJsseMGmIW3YBAi5o/2Mz99Ds08Hp/Gs/Px/wrR6vvTEpFRE3QXAf4n+SHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xN6X0AaD; arc=none smtp.client-ip=47.90.199.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1738920903; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=nsVyOK7lf4dncZjmNZ83lvgaF7otJZXfXf1rIy5TN2k=;
	b=xN6X0AaDFM134nZqlPaxRnASZZMaC2hMpMH3uXDA0G+P44VstETa8W97PIBU6co8ewkSCzzzsBvGlD9lL9Gdwlmfa5Aux+++wJzebNNarpEVmX2nBQWFMj/c5ZGCxINbD4E12MxxAWSSKQ30ylK2Zmu0FJ7PtW6Ysywk+YsFSzA=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WOyzNCd_1738920901 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 07 Feb 2025 17:35:02 +0800
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
	terry.bowman@amd.com
Subject: [PATCH v3 0/4] PCI/AER: Report fatal errors of RCiEP and EP if link recoverd
Date: Fri,  7 Feb 2025 17:34:56 +0800
Message-ID: <20250207093500.70885-1-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Shuai Xue (4):
  PCI/DPC: Rename pdev to err_port for dpc_handler
  PCI/EDR: Rename edev to err_port for edr_handle_event
  PCI/DPC: Run recovery on device that detected the error
  PCI/AER: Report fatal errors of RCiEP and EP if link recoverd

 drivers/pci/pci.h      |  5 +++--
 drivers/pci/pcie/aer.c | 11 +++++++----
 drivers/pci/pcie/dpc.c | 31 ++++++++++++++++++++++++-------
 drivers/pci/pcie/edr.c | 35 ++++++++++++++++++-----------------
 drivers/pci/pcie/err.c |  9 +++++++++
 5 files changed, 61 insertions(+), 30 deletions(-)

-- 
2.39.3


