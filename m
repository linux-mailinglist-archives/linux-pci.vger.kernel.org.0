Return-Path: <linux-pci+bounces-16524-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D533B9C5721
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 12:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CF77283404
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 11:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA4E1F778E;
	Tue, 12 Nov 2024 11:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="MG13sBcK"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FD11AFB35;
	Tue, 12 Nov 2024 11:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731412755; cv=none; b=GSyD0IX+x38h3m6WNcOI80xt1H3u1LVDrSWwrwRRj9HSpBcqwtUHaFhgeKmuyaKz4++zWXIpjAmurGTutNgcwFngM71M9qnZceMAFVx/YKY96ZWcHIf7tVgsKZeiAMM+b5yIg7macWlwuAdaol3rpQgbIZ4DmBJyvJ4O8/YMIo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731412755; c=relaxed/simple;
	bh=Daf9fen0jANxUa3bwVHfuik7iNz6t8KH3gPW5ceg4aQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Da44+sflqCHAboTJBF2qsAeDn3/kbdjN9G+Q2EakAwfa3M1HI31sRLqS72pv3nZprwpiO/2/BdcfqiLBAZ8X2YtORvKjWZwVU4m9/iUivuFUnc8IH1/KlsWBIRV4pJdTWZP6U52PPDXEnV67Cdx0aBk/dBEgsEjoG3agWsMZGj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=MG13sBcK; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731412744; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=5i9h5TJI1pI4NFu5wIcXzuVbAI3ZVqD3KjqQxZbyXvw=;
	b=MG13sBcK5WY5AXwTSeoRh/mvxq7ja8wjP5v3tpeH1df/KAqGjCOJ6pj0M0Sae8YFurShWgkpjCmcrWmLZsJaL4s0qSfSqrpiXasPRxUcBQXmCMzkX+kgtoOWLjc9p4Ep4RWwalo8PcFfchYi1RvSwp/+//jFDoO5NRuidO9PoG4=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WJHYqwK_1731412742 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 12 Nov 2024 19:59:03 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: lukas@wunner.de,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org
Cc: bhelgaas@google.com,
	tony.luck@intel.com,
	bp@alien8.de,
	xueshuai@linux.alibaba.com
Subject: [PATCH v2 0/2] PCI: hotplug: Add a generic RAS tracepoint for hotplug event
Date: Tue, 12 Nov 2024 19:58:50 +0800
Message-ID: <20241112115852.52980-1-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hotplug events are critical indicators for analyzing hardware health,
particularly in AI supercomputers where surprise link downs can
significantly impact system performance and reliability. The failure
characterization analysis illustrates the significance of failures
caused by the Infiniband link errors. Meta observes that 2% in a machine
learning cluster and 6% in a vision application cluster of Infiniband
failures co-occur with GPU failures, such as falling off the bus, which
may indicate a correlation with PCIe.[1]

PATCH 1/2: Add a generic RAS tracepoint for hotplug event to help healthy check. 
PATCH 2/2: Generate tracepoints for PCIe hotplug event

The output like below:

$ echo 1 > /sys/kernel/debug/tracing/events/hotplug/pci_hp_event/enable
$ cat /sys/kernel/debug/tracing/trace_pipe
           <...>-206     [001] .....    40.373870: pci_hp_event: 0000:00:02.0 slot:10, trans_state:Link Down

           <...>-206     [001] .....    40.374871: pci_hp_event: 0000:00:02.0 slot:10, trans_state:Card not present

[1]https://arxiv.org/abs/2410.21680


Shuai Xue (2):
  PCI: hotplug: Add a generic RAS tracepoint for hotplug event
  pci: pciehp: Generate tracepoints for hotplug event

 drivers/pci/hotplug/pciehp_ctrl.c | 33 ++++++++++++---
 drivers/pci/hotplug/trace.h       | 68 +++++++++++++++++++++++++++++++
 include/uapi/linux/pci.h          |  7 ++++
 3 files changed, 102 insertions(+), 6 deletions(-)
 create mode 100644 drivers/pci/hotplug/trace.h

-- 
2.39.3


