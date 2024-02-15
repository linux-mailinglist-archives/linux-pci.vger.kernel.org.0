Return-Path: <linux-pci+bounces-3498-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE40C8565E2
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 15:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E06B21C21842
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 14:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A48312FB33;
	Thu, 15 Feb 2024 14:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m1j4nByU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4112131E2B;
	Thu, 15 Feb 2024 14:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708007080; cv=none; b=kNLbPsY4g4EMMVza3kTwwYwcAHQY3Y6lp6/8f3d6SktQXdEOW1LrJMovUKJmekVdFWsAHZFn74YaJGRIWFa3QK8rxfSJz1pRRL7h1QVKB6P5PKYWOsAfqpuAbfhSYxWaROxov+Kaa1Cx6/EcK+HIuhrQfCfJfFUEbSoHl+QL4zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708007080; c=relaxed/simple;
	bh=zYTCS8MpuiOCc+WScUKApIvP5bK8xDhtqdGf8yM6aZc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dXxIZKaeIspAfY7ZEvcRpv2LOANqwP27Z7oifH3rKYu5rm1ej9kMrvs7MOApqS108akC8nNZThSGv6GoeAdDT9SKUawFkZGxlpvzFCbQqvu9Gw43aI8d+AT5qQrnBw2I1fh4KHjs8Cljs9Vs4zErVNuOaNNI74irXThkbNpfGiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m1j4nByU; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708007077; x=1739543077;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zYTCS8MpuiOCc+WScUKApIvP5bK8xDhtqdGf8yM6aZc=;
  b=m1j4nByU+o8IyodoDzFtBqXxe6uKczMPF1BpT4N1I93NCmdMHQ/PlKy2
   WzzpoehuQmZKRoREczcuzjvqAMcxpipPyRrKn3XA4ff6NynrSfcuL67Kq
   n4Z7v7EQQXtpf/8kyoCbUbo3W9zCHfeMccvlNoUPLF95jNCB7iE+7eXp6
   mtx4gbPVAXs9y+IO9oyJ9INBZkgpSqCJO7tXl9oNXP/+HCbgvUgAWPO7R
   UMgrwMlcWXdINVZBLMPoVW6sAvAUYJyZqcrHaZMViRjdOFuzflZe1iGZI
   qxHfwF63QNvc2Ujt4z8aHajUVrEcdAG2DrslpwBSKNirwdktiyf0BBjUP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="19514363"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="19514363"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 06:24:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="3701584"
Received: from unknown (HELO mtkaczyk-devel.igk.intel.com) ([10.102.108.91])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 06:24:33 -0800
From: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To: linux-pci@vger.kernel.org,
	linux-leds@vger.kernel.org
Cc: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>, Keith Busch <kbusch@kernel.org>,
	Marek Behun <marek.behun@nic.cz>, Pavel Machek <pavel@ucw.cz>,
	Randy Dunlap <rdunlap@infradead.org>, Shevchenko@web.codeaurora.org,
	Andriy <andriy.shevchenko@intel.com>,
	Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: [PATCH 0/2] Native PCIe Enclosure Management
Date: Thu, 15 Feb 2024 15:23:43 +0100
Message-Id: <20240215142345.6073-1-mariusz.tkaczyk@linux.intel.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In this patchset support of Native PCIe Enclosure Management is proposed.
Stuart Hayes was working on this earlier. It is a new serie because it
is NPEM only.

NPEM is pattern oriented standard, it tells which "pattern" should blink.
It doesn't control physical LED or pattern visualization. It is described
better in second patch.

Overall, driver is simple but it was not simple to fit it into interfaces
we have in kernel (We considered leds and enclosure interfaces). It reuses
leds interface, this approach seems to be the best because:
- leds are actively maintained, no new interface added.
- leds do not require any extensions, enclosure needs to be adjusted first.

There are trade-offs:
- "brightness" is the name of sysfs file to control led. It is not
  natural to use brightness to set patterns, that is why multiple led
  devices are created (one per pattern);
- Update of one led may affect other leds, led triggers may not work
  as expected.

It doesn't provide ACPI _DSM support, it requires separate implementation
outside drives/pci/ but NPEM is not registered if _DSM is available.

This patchset was made in close collaboration with Lucas Wunner.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Marek Behun <marek.behun@nic.cz>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Shevchenko, Andriy <andriy.shevchenko@intel.com>
Cc: Stuart Hayes <stuart.w.hayes@gmail.com>
Link: https://lore.kernel.org/linux-pci/20201106194221.59353-1-stuart.w.hayes@gmail.com/
Link: https://lore.kernel.org/linux-pci/20201110153735.58587-1-stuart.w.hayes@gmail.com/
Link: https://lore.kernel.org/linux-pci/20210416192010.3197-1-stuart.w.hayes@gmail.com/
Link: https://lore.kernel.org/linux-pci/20210601203820.3647-1-stuart.w.hayes@gmail.com/
Link: https://lore.kernel.org/linux-pci/20210813213653.3760-1-stuart.w.hayes@gmail.com/
Link: https://lore.kernel.org/linux-pci/cover.1642460765.git.stuart.w.hayes@gmail.com/
Link: https://lore.kernel.org/linux-pci/cover.1643822289.git.stuart.w.hayes@gmail.com/


Mariusz Tkaczyk (2):
  leds: Init leds class earlier
  PCI/NPEM: Add Native PCIe Enclosure Management support

 drivers/leds/led-class.c      |   2 +-
 drivers/pci/Kconfig           |   7 +
 drivers/pci/Makefile          |   1 +
 drivers/pci/bus.c             |   1 +
 drivers/pci/npem.c            | 339 ++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h             |   8 +
 drivers/pci/remove.c          |   1 +
 include/linux/pci.h           |   4 +
 include/uapi/linux/pci_regs.h |  34 ++++
 9 files changed, 396 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pci/npem.c

-- 
2.35.3


