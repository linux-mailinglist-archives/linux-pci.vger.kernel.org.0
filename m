Return-Path: <linux-pci+bounces-7898-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BAA8D1CC8
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2024 15:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E05532825C2
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2024 13:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68C0170841;
	Tue, 28 May 2024 13:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T3N4Iv1r"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D4917083F
	for <linux-pci@vger.kernel.org>; Tue, 28 May 2024 13:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716902395; cv=none; b=AWxOd3I3umnHiUcGDCSbknlqyioG81nuIG7U2pOK0Fy6is/KGwvtujsLTl2mICA4z10uaGPOvNnwxDt04e3VF9lx5OwATusA+D22lAtBP93YTMd/TT3IsQhjdeJNW/GLDteJwalT/38P7S7IKV6COG7sXLDtasGbAfHO0A2GPbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716902395; c=relaxed/simple;
	bh=MfARBEBCjoO+NlPB7WkkkqxIPMUxlUhlWraHpzqloGY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=B5P/siSnzbjFbsWHTuApzocrnmkETe+nNQAa3YpX/fdGTlgVB0RMw/VKzfBxKjp5jwNtl6Oenau2YfDbHkRSyW5z7ZDT5b/bQNSu9fQTBTz8Vnba5mQU1YWeBj1ShvCXkqBkA5XNCACdw2aDi7Q/prOa+jufjFtYzXJajImDVu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T3N4Iv1r; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716902394; x=1748438394;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MfARBEBCjoO+NlPB7WkkkqxIPMUxlUhlWraHpzqloGY=;
  b=T3N4Iv1rTKLw5m5gw0H3oHYD/9AZ99K9/lAbbBt/ONSZ6XgeDiCdM4TR
   xZ2pFe9L0U6x3VlJHlMRKQ4t/Quw4EYaTXb2PcoAoI/cZWlDPplJTRCYe
   noN8ocsV4qBsy6SFY+0JKnq7fL0zqkVYZ92q/IwGFkPZOB6kHzU4tWztO
   dsSL+YaWZsyJzooB915/HryIOIUABp05UfNXL8jZeBnA1e1fdr1p1Jt5V
   022imuwNxguO8C4WjLszAWnBe7buMn4/Jxi63odJw2ExnbkEUa7bWXzyz
   BWikt8cxqueYzcr8ZYO5JqXsqumoPlnRuBsywlnjrFksa0pH0zlZLVcs3
   g==;
X-CSE-ConnectionGUID: ypC4uajkQ6a5x9Z2yPBaUw==
X-CSE-MsgGUID: x+y9s9r1RcikY6jLdQYFcQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="16195152"
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="16195152"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 06:19:53 -0700
X-CSE-ConnectionGUID: FbJOlk7LQCickva7XeQtAQ==
X-CSE-MsgGUID: Jh95YE3NRvu1TvwJH9L3Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="39510527"
Received: from unknown (HELO mtkaczyk-dev.igk.intel.com) ([10.102.108.41])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 06:19:49 -0700
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
Subject: [PATCH v2 0/3] PCIe Enclosure LED Management
Date: Tue, 28 May 2024 15:19:37 +0200
Message-Id: <20240528131940.16924-1-mariusz.tkaczyk@linux.intel.com>
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

This patchset was made in close collaboration with Lucas Wunner.

Before it can be merged, DSM tests are needed.
Stuart, please test it and let us know.

Changes from v1:
- Renamed "pattern" to indication.
- DSM support added (not tested yet!).
- fixed nits reported by Bjorn.

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

 drivers/leds/led-class.c      |   2 +-
 drivers/pci/Kconfig           |   9 +
 drivers/pci/Makefile          |   1 +
 drivers/pci/npem.c            | 551 ++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h             |   8 +
 drivers/pci/probe.c           |   2 +
 drivers/pci/remove.c          |   2 +
 include/linux/pci.h           |   3 +
 include/uapi/linux/pci_regs.h |  34 +++
 9 files changed, 611 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pci/npem.c

-- 
2.35.3


