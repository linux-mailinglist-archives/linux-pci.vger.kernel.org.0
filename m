Return-Path: <linux-pci+bounces-11630-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6EF950395
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2024 13:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 276B41C225B8
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2024 11:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E502198A3D;
	Tue, 13 Aug 2024 11:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NOcwBTT9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222C74C8C
	for <linux-pci@vger.kernel.org>; Tue, 13 Aug 2024 11:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723548564; cv=none; b=ZZSChyBApAPsxoPbSIMce5Z6WYk27oORswDTHuL3kovQ1DsmMkO0MUeCqSI5ptZ2VplVvw4mFg5mZO5dNQ2eYBRccdXql4tXwlwLw2J8zksVhz9hefadJIV18WOiT7RqCWU0L0D81XDo2b3PNgmS6F1Lntqw31lmxvilwwsEaQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723548564; c=relaxed/simple;
	bh=HPTYTMuiU/bb+n2lZXp9hte9CX8oZXr1Y8Y2vsgKLJA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FUD0wE9SbTnN+wxD9CdhhwPYiqwHw56lYL5XtAeKub3zqyyLcCPOHCxLWHu8ijGfl+EUHH37QvPk5vyu6kbffdnsfDWV3bQAeP5wGfFKDJqYgR5hr80LH6o5maLcVbv6darkv8T6kQdGNBLs1p5fHkci3CXb9xiu3x7sV5IRx20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NOcwBTT9; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723548563; x=1755084563;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HPTYTMuiU/bb+n2lZXp9hte9CX8oZXr1Y8Y2vsgKLJA=;
  b=NOcwBTT9uD1PhByox8HFLLktId12L+ka2kQ50bxvrN/G8yvHNlNyarV7
   5i8ewRoqNrp98WMNqY6hpbqMW9QCzWB+gijutAFf+RtYJlFSEy1sPkzqR
   zrgRvHij5nz/IihPlz/apD5A8hTyQjIAxWgdVO4lji8bgL34KTm0aZUO8
   jkGQ7TSw1mqNH/OKCwXDE0WeUCYWOqdDE64CIXB2yPSPO/LaCkclA7Xjx
   uUNiKUFW7ihbZNWeBU0atJEhQnHYJ5jle3za+D+HPm0HQEw+pjr5jCqCi
   cY92L4DmGULtddSvjfDnzF74nUoVWIHIC7dCBZkkOOQJvdhYfzQYP3PKV
   A==;
X-CSE-ConnectionGUID: OC5Q7SoZQhuAVhzINHHbOA==
X-CSE-MsgGUID: Tlt2cMaHTMOLonf19RRK9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="21864320"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="21864320"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 04:29:23 -0700
X-CSE-ConnectionGUID: 8EHlrovwS1mmptcvbU0CfQ==
X-CSE-MsgGUID: l4s7tGwnQrGjROQ7AhOPdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="89437766"
Received: from mtkaczyk-dev.igk.intel.com ([10.102.108.41])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 04:29:20 -0700
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
Subject: [PATCH v5 1/3] leds: Init leds class earlier
Date: Tue, 13 Aug 2024 13:30:22 +0200
Message-Id: <20240813113024.17938-2-mariusz.tkaczyk@linux.intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240813113024.17938-1-mariusz.tkaczyk@linux.intel.com>
References: <20240813113024.17938-1-mariusz.tkaczyk@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NPEM driver will require leds class, there is an init-order conflict.
Make sure that LEDs initialization happens first and add comment.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
---
 drivers/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/Makefile b/drivers/Makefile
index fe9ceb0d2288..45d1c3e630f7 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -17,6 +17,9 @@ obj-$(CONFIG_PINCTRL)		+= pinctrl/
 obj-$(CONFIG_GPIOLIB)		+= gpio/
 obj-y				+= pwm/
 
+# LEDs must come before PCI, it is needed by NPEM driver
+obj-y				+= leds/
+
 obj-y				+= pci/
 
 obj-$(CONFIG_PARISC)		+= parisc/
@@ -130,7 +133,6 @@ obj-$(CONFIG_CPU_IDLE)		+= cpuidle/
 obj-y				+= mmc/
 obj-y				+= ufs/
 obj-$(CONFIG_MEMSTICK)		+= memstick/
-obj-y				+= leds/
 obj-$(CONFIG_INFINIBAND)	+= infiniband/
 obj-y				+= firmware/
 obj-$(CONFIG_CRYPTO)		+= crypto/
-- 
2.35.3


