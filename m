Return-Path: <linux-pci+bounces-10142-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A3392E247
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 10:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA3ABB26AB8
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 08:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97691509B1;
	Thu, 11 Jul 2024 08:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AtoaEycN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79EC74416
	for <linux-pci@vger.kernel.org>; Thu, 11 Jul 2024 08:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720686596; cv=none; b=cuZIAlBtA5gAYP4LWE2JsrVK08o+7HE1nr7VBAZjmt2+O7ZXT9P7w1k1GAhEclMaGFMP9EGli4UIDhLcMQmcrwfcELnECJJVad1epv0nvN76TagsqzYIR2pzIPjQtZ0/7tQmbDLY7Tw4TdiNRERJtJ5Scqn0vuKEHxCc1AUTI9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720686596; c=relaxed/simple;
	bh=fYV7kw5WXvf8ivqdFdAtvxXAlK7rcgKZmzEA1HPCPiI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ivYgFan7DuY5VOU54jtGbPLek1FDYz0t/ctwNuz8E2/kFm8KfsN64IIP2oeDviybi1Q+JeF/W55J5q6kQvS3JEqUnH/t7VmZQLx4lFDAiz0cgx6zFRW+kgXdosvIi5wB7RjyidqgWia65EC2EoSz/Co2NF/r1jBCAegQxag0kuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AtoaEycN; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720686595; x=1752222595;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fYV7kw5WXvf8ivqdFdAtvxXAlK7rcgKZmzEA1HPCPiI=;
  b=AtoaEycNy2rTiECM4b1ny4EfFw66VR2tsPU4viFgOSZJvWznwzEn+WIy
   kn2vAIIxkSN98/pxtk2J765+RzxJePxFJYyWQC3ue2o5kktzZiFhSfiVj
   m1XEW4p+n7wBzfYICTnBcLbjO3v/Nd1IYB06wNDFQfAbTPM9MTHwv//h1
   k4dNzNOjzBfS3ml0NTNoDWfkhuDW1E6R+WHMsdaY2EQhQKcOhsrwnjrQs
   rgI14Jf38b6k9sYESoYIQnlPX/eC+TuBrJoVl1U2nUwMBTkHUT5wXflwt
   y+PKj9df6Q4sgTwaa5y+42enZsdeizAIU8pzlZCJtj7noAgfMM1d1Wyo1
   Q==;
X-CSE-ConnectionGUID: j930xJvAQJOg1RNfzTbGfg==
X-CSE-MsgGUID: T+Kx4ur8TH6Muxj36RcT/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="43470995"
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="43470995"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 01:29:54 -0700
X-CSE-ConnectionGUID: bhctlV9FS12T44E6Y5iXuQ==
X-CSE-MsgGUID: 2Gm8IfyOTluwgwM8wDaTLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="48455221"
Received: from mtkaczyk-dev.igk.intel.com ([10.102.108.41])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 01:29:51 -0700
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
Subject: [PATCH v4 0/3] PCIe Enclosure LED Management
Date: Thu, 11 Jul 2024 10:30:06 +0200
Message-Id: <20240711083009.5580-1-mariusz.tkaczyk@linux.intel.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Patchset is named as PCIe Enclosure LED Management because it adds two features:
- Native PCIe Enclosure Management (NPEM)
- PCIe SSD Status LED Management (DSM)

Both are pattern oriented standards, they tell which "indication" should blink.
It doesn't control physical LED or pattern visualization.

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
- Introduce lazy loading to allow DELL _DSM quirks to work, reported by Stuart.
- leds class initcall moved up in Makefile, proposed by Dan.
- fix other nits reported by Dan and Iipo.

Changes from v3:
- Remove unnecessary packed attr.
- Fix doc issue reported by lkp.
- Fix read_poll_timeout() error handling reported by Iipo.
- Minor fixes reported by Christoph.

No feedback received from leds maintainers. No updates in Kconifg. No functional changes from v3.

I hope, it is good to go! Thanks everyone for support.

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
Link: https://lore.kernel.org/linux-pci/20240705125436.26057-1-mariusz.tkaczyk@linux.intel.com/

Mariusz Tkaczyk (3):
  leds: Init leds class earlier
  PCI/NPEM: Add Native PCIe Enclosure Management support
  PCI/NPEM: Add _DSM PCIe SSD status LED management

 drivers/Makefile              |   4 +-
 drivers/pci/Kconfig           |   9 +
 drivers/pci/Makefile          |   1 +
 drivers/pci/npem.c            | 590 ++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h             |   8 +
 drivers/pci/probe.c           |   2 +
 drivers/pci/remove.c          |   2 +
 include/linux/pci.h           |   3 +
 include/uapi/linux/pci_regs.h |  35 ++
 9 files changed, 653 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pci/npem.c

-- 
2.35.3


