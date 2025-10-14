Return-Path: <linux-pci+bounces-38054-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FA8BD9581
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 14:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 59DA64FB4F0
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 12:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597AC2652B7;
	Tue, 14 Oct 2025 12:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xi8kleKW"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670204C85;
	Tue, 14 Oct 2025 12:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760445131; cv=none; b=d59JTN2zXD/3E/p6HMzuU+CsRkhLOb2UhIMzlr/ObhlGo4AEVjEUog9gr2MVW3xFEopgdo4QVRElvK5Rjh4T3oUChl6OGZd/sfDfFmi1+Zv7LakdO982dcu7Zkal09lvBihwbo3uF/VuSbcp/94jg1mrKL0tVFwcOV3grAZMZwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760445131; c=relaxed/simple;
	bh=rxmZDHG9BFl+LG1InFEF0IG470QiPisc+6MABaa56e0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=k/fxdrB0Eq8WqXT/w7C3VtR2Vcue6guR/FxXdD6/FL12mQynxleIJMGznu73d1Myjn+Cnkd4ojSR2ByzXl884DQyanfuYjv7fiUNTb7qRR2ftM7n1nu4pV19xuxNs0WbiDxdk31GGi/nPP2oqNIcNs5r9fgbRGJzBjnQsahmLug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xi8kleKW; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760445124; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=m5LIWQlRe26TtIFnE3bC6Pja7pO8YWqeZs/R+4bIQUc=;
	b=xi8kleKW6T1H/ve5J8QEzuxTdLqal3+XH3N4I8u9VAs3V60nyl7oLUXB6HzNhd5ZzL1C27ZTNA4U+DHsX9Kt7EHj3BJ1r1kzGJ9h8X8NwmTi4y68WM7/u/paH/Haje8en5zqYCH/08kziz/gZzUVsEARSC/UBe+rV5Gb07GAwlA=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WqC6J3F_1760445120 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 14 Oct 2025 20:32:02 +0800
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
Subject: [PATCH v12 0/3] PCI: trace: Add a RAS tracepoint to monitor link speed changes
Date: Tue, 14 Oct 2025 20:31:56 +0800
Message-Id: <20251014123159.57764-1-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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


