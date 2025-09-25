Return-Path: <linux-pci+bounces-36925-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F385B9D912
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 08:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B03B4C1D9E
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 06:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAAEA2E8B67;
	Thu, 25 Sep 2025 06:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SEh6nNnf"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899CC219E8;
	Thu, 25 Sep 2025 06:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758781179; cv=none; b=uIgl1Jhg7bkM+boSeREn/L4cnfcokFiUbJL4AlJ+KsIHDIvxi1sBZE+3yQTTzUvwKpDb1b8jskgTnvFumL/Ul5+zNnHU7SpjVHwAIvq6IvSeDW58TN/FSBJeDdf8seTTofuA27x4uc+rhRbsZUogHQceGPg25YIrkfuDE54qFMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758781179; c=relaxed/simple;
	bh=E3sIhDFIoW2A7mwTcqOC9i3/SpjE43lvtBHLOasoS0o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=V1HA9izUcFUv4v6DE9YrfgxpP/LdsWrQgGaAuE1E+LIdJlKs4K/pAoV1kpBhKk51nSqZPVyIFATjZkZzkxmcPXe1ypuT5e079S5LqO5SLuntuEw8Ixg9UWPpflqbcY2pvBD8cszgRNdNHV4A+mJpWpnSyAN8szF3DbmfJMW7vuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=SEh6nNnf; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758781173; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=tt8kVT66d/MuViT91PtT0495oORqS0sRchNfOfeila8=;
	b=SEh6nNnfopC5hzO+1xDuYOhg8qUoSv7vwsW/kkpHkJ0T8l+zvlThbxe/XlK5w7rx2SJ4iWf3ptnJafVgfKdbR+1q9+XC4Fjm/dFofNAprY1T4K7bznJWVonK3KBVgRKOHhJ4vLBseJak6BWT8oLdkxlOhj7syD6ZnmaHd3+VqIk=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WomdUdW_1758781170 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 25 Sep 2025 14:19:32 +0800
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
Subject: [PATCH v11 0/3] PCI: trace: Add a RAS tracepoint to monitor link speed changes
Date: Thu, 25 Sep 2025 14:19:25 +0800
Message-Id: <20250925061928.42758-1-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

changes since v10:
- explicitly include header file per Ilpo
- add comma on any non-terminator entry  per Ilpo
- compile trace.o under CONFIG_TRACING per Ilpo

changes since v9:
- add a documentation about PCI tracepoints per Bjorn
- create a dedicated drivers/pci/trace.c that always defines the PCI tracepoints per Steve
- move tracepoint callite into __pcie_update_link_speed() per Lukas and Bjorn

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

Shuai Xue (3):
  PCI: trace: Add a generic RAS tracepoint for hotplug event
  PCI: trace: Add a RAS tracepoint to monitor link speed changes
  Documentation: tracing: Add documentation about PCI tracepoints

 Documentation/trace/events-pci.rst |  74 ++++++++++++++++++
 drivers/pci/Makefile               |   3 +
 drivers/pci/hotplug/pciehp_ctrl.c  |  31 ++++++--
 drivers/pci/hotplug/pciehp_hpc.c   |   3 +-
 drivers/pci/pci.c                  |   2 +-
 drivers/pci/pci.h                  |  22 +++++-
 drivers/pci/pcie/bwctrl.c          |   4 +-
 drivers/pci/probe.c                |   9 ++-
 drivers/pci/trace.c                |  11 +++
 include/linux/pci.h                |   1 +
 include/trace/events/pci.h         | 120 +++++++++++++++++++++++++++++
 include/uapi/linux/pci.h           |   7 ++
 12 files changed, 271 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/trace/events-pci.rst
 create mode 100644 drivers/pci/trace.c
 create mode 100644 include/trace/events/pci.h

-- 
2.39.3


