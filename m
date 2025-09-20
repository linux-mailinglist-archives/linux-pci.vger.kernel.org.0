Return-Path: <linux-pci+bounces-36556-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A316B8C047
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 08:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E0D8A4E14A9
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 06:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8702D230996;
	Sat, 20 Sep 2025 06:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ZdiBNxLZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965402629D;
	Sat, 20 Sep 2025 06:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758348093; cv=none; b=VDhFD4GGQOaTLdRakySThi2zQGWlB/7zBE7sfN56tM5Yn7w0cXy5ZkqcVN4SFBCJCMorGShqmsIh6xQYPfG4oH9OT0p45DgI9t+K8A/biss/rz0AXpffPHzyGTogGPou9nFwRq+D0hsqhWsuUg0Shg93wf2iEbRcG/e0t3kuYME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758348093; c=relaxed/simple;
	bh=K3MHmHBt3T2hSiux8viqZoYK2Az4LJ6h9Nv2EUc65OY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ME2ThtgYiYC6tZYl0628N/30vNGoj5LKlW/LdFKuvr+FWhaJuhAz5aPovhmHOL/cNFOe5i2HY6ZKeDpavB9QaLujh0sXTqQ+5q0p4i9BTWEmNeIT3dd4HQ+Wae91BkmDt2pYgJ/gWR7ZWIcNZd7q8nNTCP5g78KGqHnQ9pExVV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ZdiBNxLZ; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758348081; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=Nff32aw+jOTs3pXsAheYKwlDae25v0gyCalo/7xB5U4=;
	b=ZdiBNxLZDbGq5eMyCbHJrq8VYXmri8OwzCiY/RsfThpoH6OAEC2GYZiVF3FAvXTu0CYfnPXirRsx1GrUws+DrLwjAcHjQa8y6kugVscwhJl0dlvRQuwR0KS+qbuHL7NDrcw+kKPCj8Ko6oWS6GfvJsidvRlkVQkTkdV5I4cXAnA=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WoMFQrw_1758348077 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 20 Sep 2025 14:01:19 +0800
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
Subject: [PATCH v10 0/3] PCI: trace: Add a RAS tracepoint to monitor link speed changes
Date: Sat, 20 Sep 2025 14:01:14 +0800
Message-Id: <20250920060117.866-1-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
 drivers/pci/Makefile               |   2 +
 drivers/pci/hotplug/Makefile       |   3 +-
 drivers/pci/hotplug/pciehp_ctrl.c  |  31 ++++++--
 drivers/pci/hotplug/pciehp_hpc.c   |   3 +-
 drivers/pci/pci.c                  |   2 +-
 drivers/pci/pci.h                  |  22 +++++-
 drivers/pci/pcie/bwctrl.c          |   4 +-
 drivers/pci/probe.c                |   9 ++-
 drivers/pci/trace.c                |  11 +++
 include/linux/pci.h                |   1 +
 include/trace/events/pci.h         | 119 +++++++++++++++++++++++++++++
 include/uapi/linux/pci.h           |   7 ++
 13 files changed, 271 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/trace/events-pci.rst
 create mode 100644 drivers/pci/trace.c
 create mode 100644 include/trace/events/pci.h

-- 
2.39.3


