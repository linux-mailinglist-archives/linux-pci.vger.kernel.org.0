Return-Path: <linux-pci+bounces-10143-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6626392E245
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 10:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97A131C22DFA
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 08:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BFB15445D;
	Thu, 11 Jul 2024 08:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OTZ8irW/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0576B1514F3
	for <linux-pci@vger.kernel.org>; Thu, 11 Jul 2024 08:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720686600; cv=none; b=tHaEzJub0giZsTYreCzj54uvU9inYGpA9h6ej6Suwr42bMVJJccoeqRCu1HMBKxA1mGAhhhZdL7VFg5dx4qibhZhE4S2PyV4hjh65vqzwXkDuJBm02eGbR8kI+rw/H2Kvkm/VUf8LUvK9pVImubw1mrzHwtUBtWpMPRAq/r0Z7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720686600; c=relaxed/simple;
	bh=HPTYTMuiU/bb+n2lZXp9hte9CX8oZXr1Y8Y2vsgKLJA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b60sEeo1CaqF0F9Hu3xTpOgtCPA0VJmChcU0uD0aA8dWxeFGsltI3WYZQhL2RnO6UgvtEKrlZPG/XZi3unkHeAWOl2kPY1uxV9bxCwWY+4LehPNMiCcvw5dMgDHKwyoiAPrWobUcn8UMQNSoowG99qKPlsM6/RHsyLfSs6oauI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OTZ8irW/; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720686599; x=1752222599;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HPTYTMuiU/bb+n2lZXp9hte9CX8oZXr1Y8Y2vsgKLJA=;
  b=OTZ8irW/nQpEr/RNBmqi5c151BnR7DRyaj/OrDpl18fIuqsQd6nTvwLQ
   tdzt/FaLhn9k40uvbg2Wz7akCtAjFv4W4RqyaNNtWlAKOj8Okzij5+KU0
   lCWH2JwRv/LKYxGDx7vDOUB2dzHNJ+cQ6YJEs8j7XxmqRLXxFSNu563i2
   ut7p5jlRYeVwdLy6DcrsT3zTET69ThNFMBwcLjkguFdIifuBOuvbsO+C6
   +Cf7H1R3D0KL1+jne5SWadpdKJtijiQY2enmU8Ke1TM3Uh7fDyHaWAONE
   rcCZuH4PZXkDP9dcpc5nfpeeD6AY8vClIEZvjRhhppuuVC6NpuHaeoQW+
   Q==;
X-CSE-ConnectionGUID: OTTTOyNDQ8GhYzdutq3exg==
X-CSE-MsgGUID: g4IUsagfSo2vHQ8Qrkw4UA==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="43471011"
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="43471011"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 01:29:59 -0700
X-CSE-ConnectionGUID: bv07Hhj8T1iIsuxaWEi/+w==
X-CSE-MsgGUID: DCHj9ZdwS+mD6jL3XQEmSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="48455234"
Received: from mtkaczyk-dev.igk.intel.com ([10.102.108.41])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 01:29:56 -0700
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
Subject: [PATCH v4 1/3] leds: Init leds class earlier
Date: Thu, 11 Jul 2024 10:30:07 +0200
Message-Id: <20240711083009.5580-2-mariusz.tkaczyk@linux.intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240711083009.5580-1-mariusz.tkaczyk@linux.intel.com>
References: <20240711083009.5580-1-mariusz.tkaczyk@linux.intel.com>
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


