Return-Path: <linux-pci+bounces-11668-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6248E951AD0
	for <lists+linux-pci@lfdr.de>; Wed, 14 Aug 2024 14:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 945B6B2115B
	for <lists+linux-pci@lfdr.de>; Wed, 14 Aug 2024 12:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011CF1B0111;
	Wed, 14 Aug 2024 12:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DtXbiuR/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5531A00F3
	for <linux-pci@vger.kernel.org>; Wed, 14 Aug 2024 12:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723638478; cv=none; b=WaSkf2YBtkpvWPcHO0GvMInjqtDmR/BW8u7Ue8BB0MPj2JIYet8i7FnurmEiAIh3ib8cSHxf3dqSSlvnmQS4hdUvTFnfkOEjIRw5uCBd/w+YGJbItqFkNCm97OOblln+4MPdxrd7XzRW5vu9noKXFKzkh+QWJUUDgtONHTj8Qww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723638478; c=relaxed/simple;
	bh=ZRU+QTLnI/iy/xaKdrquHdEbdCwKrGniABpCjA1yO0o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=sOL+NpEV+PPOZ1WWgY3DDaD1NrY7K8nPLkhBeuIDt7eO4gksIgTjBEOMjG9hMieDooWKFu/dtwwQzNe5rXHEvjurupebPO727JkfyxQE65e457Df0nur5ybHPpM9DzRcd8ma1a2Giwx7ePolz4pzvNYP452/rOwjJY9KEY0ryhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DtXbiuR/; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723638477; x=1755174477;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZRU+QTLnI/iy/xaKdrquHdEbdCwKrGniABpCjA1yO0o=;
  b=DtXbiuR/vFrQq/dfFdyB5CWSE/Ea3XpiwGluMX9T3iXq4MWj8sFcvW2t
   Uz07W73J7W4SZ/UGjHK5jbwfGGlw7V1m/buWw6x3mxhyI3+gWQPD641gl
   rMb9AvdBZuTaCbGemgmQur5hODU6ziNhZfkalAIgbDRDisbeWVLmdYvhH
   YNAnkOgJ9Iy9eDA5eRH0Svkmyhrhk8Z2xaBCCFkdgOaHFSoQGhW0uG+G5
   Gfgpew2JcLxCT3nhT0106Pz0oYysowevSSpc5VD2CpzBqyYgOduaVfFZ7
   uzI1eJ/KdNZrAuDQA7tqnAOyPRUdMgbPzxGg/qNSCOOTzKtKW4cDVVqnE
   g==;
X-CSE-ConnectionGUID: /rkv64D2T/yNyQQQjXal9Q==
X-CSE-MsgGUID: TT/DudQsTg6j7us9KzCD9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="33256464"
X-IronPort-AV: E=Sophos;i="6.10,145,1719903600"; 
   d="scan'208";a="33256464"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 05:27:56 -0700
X-CSE-ConnectionGUID: VszXL5pHQRyoUl9nsk/eLg==
X-CSE-MsgGUID: 0e4rLMKMT66VpQ/Dm1ipAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,145,1719903600"; 
   d="scan'208";a="82232940"
Received: from mtkaczyk-dev.igk.intel.com ([10.102.108.41])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 05:27:53 -0700
From: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To: linux-pci@vger.kernel.org
Cc: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Christoph Hellwig <hch@lst.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Stuart Hayes <stuart.w.hayes@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Keith Busch <kbusch@kernel.org>,
	Marek Behun <marek.behun@nic.cz>,
	Pavel Machek <pavel@ucw.cz>,
	Randy Dunlap <rdunlap@infradead.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v6 0/3] PCIe Enclosure LED Management
Date: Wed, 14 Aug 2024 14:28:57 +0200
Message-Id: <20240814122900.13525-1-mariusz.tkaczyk@linux.intel.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Patchset is named as PCIe Enclosure LED Management because it adds two
features:
- Native PCIe Enclosure Management (NPEM)
- PCIe SSD Status LED Management (DSM)

Both are pattern oriented standards, they tell which "indication"
should blink. It doesn't control physical LED or pattern visualization.

Overall, driver is simple but it was not simple to fit it into interfaces
we have in kernel (We considered leds and enclosure interfaces). It reuses
leds interface, this approach seems to be the best because:
- leds are actively maintained, no new interface added.
- leds do not require any extensions, enclosure needs to be adjusted first.

There are trade-offs:
- "brightness" is the name of sysfs file to control led. It is not
  natural to use brightness to set patterns, that is why multiple led
  devices are created (one per indication);
- Update of one led may affect other leds, led triggers may not work
  as expected.

Changes from v1:
- Renamed "pattern" to indication.
- DSM support added.
- fixed nits reported by Bjorn.

Changes from v2:
- Introduce lazy loading to allow DELL _DSM quirks to work, reported by
  Stuart.
- leds class initcall moved up in Makefile, proposed by Dan.
- fix other nits reported by Dan and Iipo.

Changes from v3:
- Remove unnecessary packed attr.
- Fix doc issue reported by lkp.
- Fix read_poll_timeout() error handling reported by Iipo.
- Minor fixes reported by Christoph.

Changes from v4:
- Use 0 / 1 instead of LED_OFF/LED_ON, suggested by Marek.
- Documentation added, suggested by Bjorn.

Change from v5:
- Remove unnecessary _packed, reported by Christoph.
- Changed "led" to "LED" and other typos suggested by Randy.

Suggested-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Tested-by: Stuart Hayes <stuart.w.hayes@gmail.com>

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
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Stuart Hayes <stuart.w.hayes@gmail.com>
Link: https://lore.kernel.org/linux-pci/20240813113024.17938-1-mariusz.tkaczyk@linux.intel.com

Mariusz Tkaczyk (3):
  leds: Init leds class earlier
  PCI/NPEM: Add Native PCIe Enclosure Management support
  PCI/NPEM: Add _DSM PCIe SSD status LED management

 Documentation/ABI/testing/sysfs-bus-pci |  72 +++
 drivers/Makefile                        |   4 +-
 drivers/pci/Kconfig                     |   9 +
 drivers/pci/Makefile                    |   1 +
 drivers/pci/npem.c                      | 590 ++++++++++++++++++++++++
 drivers/pci/pci.h                       |   8 +
 drivers/pci/probe.c                     |   2 +
 drivers/pci/remove.c                    |   2 +
 include/linux/pci.h                     |   3 +
 include/uapi/linux/pci_regs.h           |  35 ++
 10 files changed, 725 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pci/npem.c

-- 
2.35.3


