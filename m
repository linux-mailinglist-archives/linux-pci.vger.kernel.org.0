Return-Path: <linux-pci+bounces-11629-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 824A4950396
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2024 13:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C900DB217C1
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2024 11:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA7D190470;
	Tue, 13 Aug 2024 11:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dRpgEihu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDC14C8C
	for <linux-pci@vger.kernel.org>; Tue, 13 Aug 2024 11:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723548561; cv=none; b=LyDcHYVpwHQe0Qr2waUSWfgM8RL5BJit+zaeARH5w1LEbjE2sawtNq6r8pERf64UvvqJEellwP5948T7keLERaluxyw88unJanwNoNlGHBa7P1+8Rn/GdFAJ1b5bnejWRRvr+/UC88w2ViFyAN7Z8Jq53B/3H0d/n9ddvGAHfKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723548561; c=relaxed/simple;
	bh=1Zug2B84obFYR23CNhiR/NwtLEhqGMIqbJRwQ7sbMpU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=R6fFkHwNfQq4d3Ql2w7emhQA2SiPyiYYDgsNtZ5Qkz+6AMIqVSSkuLqPA3LE8PKxR5/CkuyWpxwkp1Npaya6Qf18rPzVCp3QwMLSND3iQkvxdapf4rCtfpZlRFWg80p7oCB8AST2hs3IhYcjcAp6OcSbRnTjLiHYgsihzGSxnmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dRpgEihu; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723548559; x=1755084559;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1Zug2B84obFYR23CNhiR/NwtLEhqGMIqbJRwQ7sbMpU=;
  b=dRpgEihuj1xL74xWMekxBmy7EYhtHqjyU5e5FQOxlnJI0gS4uVUQjVPU
   vUb68q6ucYami997838PodazAL7ZlwgE4pGESXz5hEEdxwUXGsaA/I78A
   EQlxCmpF5iqBFfJlb7O8ipuYPs/2iqwKi+2G759yb4+Gscwnzpi8sjEy7
   3SiGk2/sK6/9xhEVSuwxFGrMK4Q8xh8Ic0nIDO1xzq8ItPTbKyZVPIbtY
   yPBupMdIYsAGJ3WRH+rJt61SG6ANrRZF694KjDZwEO8St3MbHRlq8Tq3y
   4wU/DRnt/Bnyn6WOXebHPgdYoW5X8ywYiWDKYIbrtEfCBDu9gIp5SeUg2
   g==;
X-CSE-ConnectionGUID: /KdBkXobTdqP49qcHHutEQ==
X-CSE-MsgGUID: lSCUCch9Q66t0hKJ/2NewA==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="21864307"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="21864307"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 04:29:19 -0700
X-CSE-ConnectionGUID: NpwnhsK8QGKeBmCfCahAzg==
X-CSE-MsgGUID: 2fc4G94cSSGUrz1acdEIDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="89437760"
Received: from mtkaczyk-dev.igk.intel.com ([10.102.108.41])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 04:29:15 -0700
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
Subject: [PATCH v5 0/3] PCIe Enclosure LED Management
Date: Tue, 13 Aug 2024 13:30:21 +0200
Message-Id: <20240813113024.17938-1-mariusz.tkaczyk@linux.intel.com>
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
Link: https://lore.kernel.org/linux-pci/20240711083009.5580-1-mariusz.tkaczyk@linux.intel.com/

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


