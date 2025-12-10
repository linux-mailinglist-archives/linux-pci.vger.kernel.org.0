Return-Path: <linux-pci+bounces-42892-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB6FCB3072
	for <lists+linux-pci@lfdr.de>; Wed, 10 Dec 2025 14:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 422B230AB86B
	for <lists+linux-pci@lfdr.de>; Wed, 10 Dec 2025 13:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBA2325716;
	Wed, 10 Dec 2025 13:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pH6hRL9Z"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8269F3195F5;
	Wed, 10 Dec 2025 13:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765373363; cv=none; b=ooekClaIAlPlZ5m9n52m3xF5vaVBFnuBE5yg9f4WsKW0lz0HbdizDcYUhrU0wpKMMNrK0o9LdcLpBmcoyBfogJU9CkIa9gGRTKjzlOXYw7YscKQmriTzhRQy/vUt2buq5dIzmOUl+mzudpFThak7irs2kGiBuWY0Z6lQmIQxpKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765373363; c=relaxed/simple;
	bh=EF+Elg2H7ity6fC2bHTbLiLgzplv0vdE8ZodSjteStw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=adMCitNyZKTz5giOOEcDkxvuaay1e/t91mOtf5ckO4kOG0sq2qEDWHRkqE6CUepDppOC4pVWjYFdr4ZKK0hz/TaieEqRUJMvGnMkPdtP4YkHndlwJR2YwKICg5XvWRBw7GFFZw407fJJiInXxIWQQT6ZC9XBjC4hDdISOZ4sHHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=pH6hRL9Z; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1765373351; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=oaoPunhgBmLAY+MQh1kYa6SeyceGCw+8rU+zgUhRa+g=;
	b=pH6hRL9ZMlMe9q2sQbUGbOBfWYDHbCLqO1nSLHXDw04C4fNV3op634xyBmvmJdK8+XQphMGZZldvcew5XVEH8Uqdc2fzLLzhcumay8e+frKnfDcZ7v7IF/q4z2PodnH+TL9UUO7WCVoDgv24sqpbLLzI43bHCraXh2rpElbzl9A=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WuWtM3H_1765373347 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 10 Dec 2025 21:29:09 +0800
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
	Jonathan.Cameron@huawei.com,
	alok.a.tiwari@oracle.com
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
Subject: [PATCH v14 0/3] PCI: trace: Add a RAS tracepoint to monitor link speed changes
Date: Wed, 10 Dec 2025 21:29:04 +0800
Message-Id: <20251210132907.58799-1-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

changes since v13:
- fix doc typos per ALOK TIWARI

changes since v12:
- add Reviewed-by tag for PATCH 1 from Steve
- add Reviewed-by tag for PATCH 1-3 from Ilpo
- add comments for why use string to define tracepoint per Steve
- minor doc improvements from Ilpo
- remove use pci_speed_string to fix PCI dependends which cause build error on sparc64

changes since v11:
- rebase to Linux 6.18-rc1 (no functional changes)

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

changes since v7:
- replace the TRACE_INCLUDE_PATH to avoid macro conflict per Steven
- pick up Reviewed-by from Lukas Wunner

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

 Documentation/trace/events-pci.rst |  74 +++++++++++++++++
 drivers/pci/Makefile               |   3 +
 drivers/pci/hotplug/pciehp_ctrl.c  |  31 +++++--
 drivers/pci/hotplug/pciehp_hpc.c   |   3 +-
 drivers/pci/pci.c                  |   2 +-
 drivers/pci/pci.h                  |  21 ++++-
 drivers/pci/pcie/bwctrl.c          |   4 +-
 drivers/pci/probe.c                |   9 +-
 drivers/pci/trace.c                |  11 +++
 include/trace/events/pci.h         | 129 +++++++++++++++++++++++++++++
 include/uapi/linux/pci.h           |   7 ++
 11 files changed, 279 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/trace/events-pci.rst
 create mode 100644 drivers/pci/trace.c
 create mode 100644 include/trace/events/pci.h

-- 
2.39.3


