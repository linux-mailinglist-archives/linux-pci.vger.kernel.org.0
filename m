Return-Path: <linux-pci+bounces-9833-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF9692891C
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2024 14:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 656FDB211D7
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2024 12:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417A613C8F9;
	Fri,  5 Jul 2024 12:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WWjLg2hV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8ED14B96A
	for <linux-pci@vger.kernel.org>; Fri,  5 Jul 2024 12:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720184164; cv=none; b=Dwl82Adst8/oI9RmKIdLALjQ9r5oXnKQsz9ihSOhcMwaR0u8EMwgSlZYgD9YNHx2sNVqb6t/PEJsSAZEDQ8JbLjTg0XQO+nNBX1o6oJfH4u5Cr/8ZMIPkkyTVCJ5dszCThifF+0c6WCeZM7Zs39KP5OJkyeAJfwoPBQEmpyVBWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720184164; c=relaxed/simple;
	bh=R50hgsseQTBHJ9zehpvjuoR+dSYXAyRbmH14lQ/UmJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=a8lZPh00hzcfIXMcIPw7H4d0a0SYowTwjez9L3RkL7JsQ0n9ACsARzkm8QbapvLK8IznqOpSLNbQ/KQd+WoZOTMRW8aY9/rXz6z5nf7I6cjUthNElFyRGsmE0sG6xEPamHXsu9gC4FvedWn7OldiXFMJU8dreHPcgXJgr8OBpho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WWjLg2hV; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720184161; x=1751720161;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=R50hgsseQTBHJ9zehpvjuoR+dSYXAyRbmH14lQ/UmJ0=;
  b=WWjLg2hVOPncBNW+EhbRxkyivYm4a+rgGCALa0rpXlvjirrfL63ApWxE
   jsPNRp6iKppj4SahhhgB7LlhPAaAbNkG57O1CWkvgHn/HW1XFdExnsMZ+
   /ZkGxTWKia5nnPkNiBu9wAH1A6pyLwg6TvI2HgULDD+s/5jw4XJUtb30T
   u+emIRKJHbHeVvl3zbnO3B6NB0ulSATxVo0l3EHvej+pcG50vALeZM6RA
   cnRBPcraYw166pEZuBOtJhXkReQlHaxnANRW1Zw4bJaX5XqV/BfX4z9U/
   E4oidHiTw8xKv1OiyD0JbDa7qJx+P3lPHvrfbZgvLvO9zMrQ4CM/6qjP9
   A==;
X-CSE-ConnectionGUID: cVFaJA9XSuSK0qmb90n/hQ==
X-CSE-MsgGUID: HtojYXY8Rwylsmf4aEs4eQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="21347935"
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; 
   d="scan'208";a="21347935"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2024 05:54:28 -0700
X-CSE-ConnectionGUID: Q/2w0AT1To+Nva05aFfRBA==
X-CSE-MsgGUID: 1+oDOxcaQjySpubV8osILg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; 
   d="scan'208";a="47620687"
Received: from mtkaczyk-dev.igk.intel.com ([10.102.108.41])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2024 05:54:25 -0700
From: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To: linux-pci@vger.kernel.org
Cc: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Keith Busch <kbusch@kernel.org>,
	Marek Behun <marek.behun@nic.cz>,
	Pavel Machek <pavel@ucw.cz>,
	Randy Dunlap <rdunlap@infradead.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: [PATCH v3 0/3] PCIe Enclosure LED Management
Date: Fri,  5 Jul 2024 14:54:33 +0200
Message-Id: <20240705125436.26057-1-mariusz.tkaczyk@linux.intel.com>
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

It was tested with _DSM but I do some minor updates after review.
Stuart please retest.

Changes from v1:
- Renamed "pattern" to indication.
- DSM support added.
- fixed nits reported by Bjorn.

Changes from v2:
- Introduce lazy loading to allow DELL _DSM quirks to work, reported by Stuart.
- leds class initcall moved up in Makefile, proposed by Dan.
- fix other nits reported by Dan and Iipo.

No feedback received from leds maintainers. No updates in Kconifg.

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
Link: https://lore.kernel.org/linux-pci/20240215142345.6073-1-mariusz.tkaczyk@linux.intel.com/

Mariusz Tkaczyk (3):
  leds: Init leds class earlier
  PCI/NPEM: Add Native PCIe Enclosure Management support
  PCI/NPEM: Add _DSM PCIe SSD status LED management

 drivers/Makefile              |   4 +-
 drivers/pci/Kconfig           |   9 +
 drivers/pci/Makefile          |   1 +
 drivers/pci/npem.c            | 588 ++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h             |   8 +
 drivers/pci/probe.c           |   2 +
 drivers/pci/remove.c          |   2 +
 include/linux/pci.h           |   3 +
 include/uapi/linux/pci_regs.h |  35 ++
 9 files changed, 651 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pci/npem.c

-- 
2.35.3


