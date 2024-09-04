Return-Path: <linux-pci+bounces-12742-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3559A96B8E5
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 12:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E754C285B0D
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 10:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1801CF7A2;
	Wed,  4 Sep 2024 10:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cSDBk6Rv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362D61482E1;
	Wed,  4 Sep 2024 10:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725446855; cv=none; b=hjAME1Jb68wqyiYZQU2fms4O23mb+98sZ9UOdEIpnPNLvs5XS9u9N+Jw/ghlrHL1AlQeaX6Nv8lteUJkDBTvrMbTc9BRdjvSu5a03Pa6FeYfVbiHlP4WSCPqZSdsx9BpHBveCnZ6DxnAi7Pvz23T1rW7zatho+VNpz42Z0xp7Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725446855; c=relaxed/simple;
	bh=RMFZComQrOBf5u5EfjCa5JakSHPbru5gT/wE1CJR5qQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BogkT7FSk86QrrxLGVWsIYZOt+qePMLOG8z2TqDqfoI3w0CGtm9hO0nKGZV+8XIAgJHJQt2sbKd/MJfCPPosyGRkcRNoef1TOtRxuypWWCTI6/yc+Gra4UTk0CmTq7trxE/9jmqavFBFjdeWh/4MFjMnTa3CDArS3mIicc0MLOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cSDBk6Rv; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725446854; x=1756982854;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RMFZComQrOBf5u5EfjCa5JakSHPbru5gT/wE1CJR5qQ=;
  b=cSDBk6RvJsoU9HrtGRNVumHQH9SrWbunBk7XxHik2mwdxvPmjSIn0mj0
   0ug5BiKI4MrcovRC+Z4KHDxZ68zk95STkUXhyoNt706eHQp9y7/53lsnt
   K3iJlQmdK2p1B0weVrdVZmBGX7bWtLNI5jFW1gKDrFGQPQ0NAa7nF2fbC
   y++3RNkiSRQxPl7vsOo3zj9UwQ5pzM8NhkUAcMEHE2kZeuW+IgGOoAQb9
   mXi27KkOA2vt8y/48CIpi1lQZwAJs27y13db66k/NpZYFWt8h5JCvKdYE
   LS4rYMwKXnyT4H6MFChZvjoufycTqbrp7gleEvcbgvTtksiwS8qJa2ug6
   g==;
X-CSE-ConnectionGUID: fg+ro4GfQ5y7rwY3zjCrrw==
X-CSE-MsgGUID: BreqF/QeRJa2VzAHZh6jNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="24261249"
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="24261249"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 03:47:29 -0700
X-CSE-ConnectionGUID: uzBgy1dNQkKhvdsmdtQt5Q==
X-CSE-MsgGUID: wQwp7XyJSQ+ynm+Xe5YozQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="102636635"
Received: from mtkaczyk-dev.igk.intel.com ([10.102.108.41])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 03:47:26 -0700
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
Subject: [PATCH v7 1/3] leds: Init leds class earlier
Date: Wed,  4 Sep 2024 12:48:46 +0200
Message-Id: <20240904104848.23480-2-mariusz.tkaczyk@linux.intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240904104848.23480-1-mariusz.tkaczyk@linux.intel.com>
References: <20240904104848.23480-1-mariusz.tkaczyk@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

NPEM driver will require leds class, there is an init-order conflict.
Make sure that LEDs initialization happens first and add comment.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
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


