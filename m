Return-Path: <linux-pci+bounces-32769-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F8CB0E917
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 05:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D0083A5EB8
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 03:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DB024678E;
	Wed, 23 Jul 2025 03:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="PW4sntQk"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79C81EB9FA;
	Wed, 23 Jul 2025 03:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753241494; cv=none; b=odsaSYwm7OODfvnSE0IVtcCH/p1ZTFJI50elJ9F5TbXtR5oSmj7OXk3FzrRG4CTdJYE4zpjG8kDe8tKc5owxDh0PAi9YEfPQlD1hvluS94zx+cxtb7DJKZ/NIzOOluvl21l0pao0B/xyDShjEH8Bin/j5RTMZhMTV5GuX/KqYr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753241494; c=relaxed/simple;
	bh=6bCQcolvuibuBF306pHwBMIQKL09hFn4GKG6NZNGu2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=oDQLETma14ogtgPZJSOUElk4pqcxT+VRF+FWQ/TazsaF8fjIagaRuErndEu5LSEY0FQ5BXF9qq3GzIVLSNSKR1Tv01I+lUxFuqrXqkdtvfL4TI6Mj23uiNrmN5EhvG4zg46Lze2PBEAQ6cwZzA6117MEAhb03bew6b75we0zN20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=PW4sntQk; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753241483; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=qNM2R76KG/iWIUpD/7vKxG7buUzQcrBiSdbH8d5CUGU=;
	b=PW4sntQkg8leU2UhEo2mAVTMFVR9a3musM5PRVsRgS0iX9Y7U4bzH5KinhE7a3f+hvoJieDzfz2Npc3f7Cpl9VkCakXbxMCpZOPQMkXRCYhWks5aSmJNQ0MHA/e7FMndmH2v51E7k5sUZXxHbJp7yItXZisbfp+eJE9aLm3Nw6E=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WjZukoU_1753241468 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 23 Jul 2025 11:31:21 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: rostedt@goodmis.org,
	lukas@wunner.de,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	helgaas@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	mattc@purestorage.com,
	Jonathan.Cameron@huawei.com
Cc: bhelgaas@google.com,
	tony.luck@intel.com,
	bp@alien8.de,
	xueshuai@linux.alibaba.com,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	oleg@redhat.com,
	naveen@kernel.org,
	davem@davemloft.net,
	anil.s.keshavamurthy@intel.com,
	mark.rutland@arm.com,
	peterz@infradead.org,
	tianruidong@linux.alibaba.com
Subject: [PATCH v9 0/2] add PCI hotplug and PCIe link tracepoint
Date: Wed, 23 Jul 2025 11:31:06 +0800
Message-Id: <20250723033108.61587-1-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

changes since v8:
- rewrite commit log from Bjorn
- move pci_hp_event to a common place (include/trace/events/pci.h) per Ilpo
- rename hotplug event strings per Bjorn and Lukas
- add PCIe link tracepoint per Bjorn, Lukas, and Ilpo

Hotplug events are critical indicators for analyzing hardware health, and
surprise link downs can significantly impact system performance and reliability.
In addition, PCIe link speed degradation directly impacts system performance and
often indicates hardware issues such as faulty devices, physical layer problems,
or configuration errors.

This patch set add PCI hotplug and PCIe link tracepoint to help analyze PCI
hotplug events and PCIe link speed degradation.

Shuai Xue (2):
  PCI: trace: Add a generic RAS tracepoint for hotplug event
  PCI: trace: Add a RAS tracepoint to monitor link speed changes

 drivers/pci/hotplug/pciehp_ctrl.c |  33 +++++++--
 drivers/pci/hotplug/pciehp_hpc.c  |   5 +-
 drivers/pci/pci.c                 |   2 +-
 drivers/pci/pci.h                 |  12 ++-
 drivers/pci/pcie/bwctrl.c         |   4 +-
 drivers/pci/probe.c               |  10 ++-
 include/linux/pci.h               |   1 +
 include/trace/events/pci.h        | 119 ++++++++++++++++++++++++++++++
 include/uapi/linux/pci.h          |   7 ++
 9 files changed, 177 insertions(+), 16 deletions(-)
 create mode 100644 include/trace/events/pci.h

-- 
2.39.3


