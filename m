Return-Path: <linux-pci+bounces-12741-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC2D96B8DD
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 12:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09F10285635
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 10:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148981482E1;
	Wed,  4 Sep 2024 10:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ie+g+rt2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224E0635;
	Wed,  4 Sep 2024 10:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725446841; cv=none; b=INxYXi/XmYpFu6J5vEjg2Wh0e9nB4oX832dyCSBpnzu1um962Aw8FRnSeHMeP2eBzZUWfriNQbGR6mrojxhb8mH4qsotVhPWOl7Tq7QLqKDdl5jET4TBqNyp3snJHfeVUuj32/4YOr9x1q03wZfDFGFX6HVjQ5HvX3l3GGIiDmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725446841; c=relaxed/simple;
	bh=m8idEMp2Zh4Pg1Bcg/0Zmqt7dn8s/nSOxdepFUKXZ94=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Zepxutq6r1Uhxg77lOKj/G6j8T7OKWj+LSf8c+Bc9wJB09G0zUdKlODlBim2IhEt02AcHOPkiwqy8iDKjC9AZXSFR+Opi9L00Saop8FkZpPcvFuaTFc4T4mTtVH5GtqAanYs0NTH2HhMbDfC8QomCrTWHUaBG3pVlgB/7f6EApo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ie+g+rt2; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725446839; x=1756982839;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=m8idEMp2Zh4Pg1Bcg/0Zmqt7dn8s/nSOxdepFUKXZ94=;
  b=ie+g+rt2mZc7C4YttQzuA6+mN0F4kB18hil7LdERJyC+U68hoIwcNuML
   ks6AEHqrcjtZ5FhchxNyXAsxa4qGgkBRWSakx082a3VAhMdHEFKUBo9Cj
   8YTWMYX+s/B4w4JG0DqaKrjVzX71PJHwwwp1mR461Kqwk2wWO8O0iL1RK
   fmPKbIetSJBatIHTGRh96kRctaknKNJ093kvlB5ZEgAOntZaFGXT1gsGP
   gmTpx0F/14DPd+Tvx+WPr/FYrzYSnZtB70tYqJQg7UqCKUPRTYq3knsdE
   eg5avtXF2l6pyJ646WeSUlxA417ZdFFZn/3vKCFjaXUHNfS7Hz6A59Z6b
   A==;
X-CSE-ConnectionGUID: 6WZewbZuTgGRGrdX7Jx79A==
X-CSE-MsgGUID: g6yYpJ5/TCS7Mmkf1Or22w==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="24261229"
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="24261229"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 03:47:18 -0700
X-CSE-ConnectionGUID: 45A3Hv77TyW6BG441oMXbA==
X-CSE-MsgGUID: h2JiVcV5Spm7mHC9bOmj7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="102636610"
Received: from mtkaczyk-dev.igk.intel.com ([10.102.108.41])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 03:47:14 -0700
From: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To: linux-pci@vger.kernel.org
Cc: linux-leds@vger.kernel.org,
	Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Christoph Hellwig <hch@lst.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Stuart Hayes <stuart.w.hayes@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lee Jones <lee@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Marek Behun <marek.behun@nic.cz>,
	Pavel Machek <pavel@ucw.cz>,
	Randy Dunlap <rdunlap@infradead.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v7 0/3] PCIe Enclosure LED Management
Date: Wed,  4 Sep 2024 12:48:45 +0200
Message-Id: <20240904104848.23480-1-mariusz.tkaczyk@linux.intel.com>
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
- Fixed nits reported by Bjorn.

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

Change from v6:
- Removed links, suggested by Bjorn.
- npem->active_inds_initialized:1 moved to DSM commit, suggested by Bjorn.
- Improve justification for active_inds_initialized, suggested by Bjorn.
- Chosen backed logging added, suggested by Bjorn.

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
Cc: Lee Jones <lee@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Marek Behun <marek.behun@nic.cz>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Stuart Hayes <stuart.w.hayes@gmail.com>
Link: https://lore.kernel.org/linux-pci/20240814122900.13525-1-mariusz.tkaczyk@linux.intel.com/

Mariusz Tkaczyk (3):
  leds: Init leds class earlier
  PCI/NPEM: Add Native PCIe Enclosure Management support
  PCI/NPEM: Add _DSM PCIe SSD status LED management

 Documentation/ABI/testing/sysfs-bus-pci |  72 +++
 drivers/Makefile                        |   4 +-
 drivers/pci/Kconfig                     |   9 +
 drivers/pci/Makefile                    |   1 +
 drivers/pci/npem.c                      | 597 ++++++++++++++++++++++++
 drivers/pci/pci.h                       |   8 +
 drivers/pci/probe.c                     |   2 +
 drivers/pci/remove.c                    |   2 +
 include/linux/pci.h                     |   3 +
 include/uapi/linux/pci_regs.h           |  35 ++
 10 files changed, 732 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pci/npem.c

-- 
2.35.3


