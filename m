Return-Path: <linux-pci+bounces-11669-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EF5951AD1
	for <lists+linux-pci@lfdr.de>; Wed, 14 Aug 2024 14:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47D4DB21DDC
	for <lists+linux-pci@lfdr.de>; Wed, 14 Aug 2024 12:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E241B0120;
	Wed, 14 Aug 2024 12:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MkUeBA2H"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7551A00F3
	for <linux-pci@vger.kernel.org>; Wed, 14 Aug 2024 12:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723638482; cv=none; b=biza6cku1Ry8tQ+tr4XIliXyPy5i/QWikBa9JJ11fiL+yQx8t8Fkklhy3bYhu2AwJxKAZmo9zkM/m7EFIT0vDjOwAjesbEXjyzoJqbUPCybYqsGEbxcTaV8ejdn3RPHjNQ/ywM5DTcJ1zSqgiCGkVaDRabUTBoCONASEA6B0DIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723638482; c=relaxed/simple;
	bh=HPTYTMuiU/bb+n2lZXp9hte9CX8oZXr1Y8Y2vsgKLJA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ifs03WW0ZZY1Uo28hFPxVvUmp7qS0qinDdMiYL9BpgSl/KhIMDQSDhrmXWKDsY+o/9Npf/dUNPY6AMJTywWnxVlQ29dxcJ1WIfnEaqISV0rSuF7DYJcknKuacM27i7jcTr6YehM+1NkQCMv0NCLmFjh6/O5/Z6kw1mnnlkENe24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MkUeBA2H; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723638481; x=1755174481;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HPTYTMuiU/bb+n2lZXp9hte9CX8oZXr1Y8Y2vsgKLJA=;
  b=MkUeBA2H/SPqj7pJhDqNlqdYkTZ7nhIB/1qeFni81nIdc/UmxEZWYeih
   GJDdbi9ONPsjj3GtLKhcLoml2KsE33LeQkg1R+t0HsX5YfCdHSZQKu4Ly
   ep2Gc5nEDdXPutnzJx1p9nRt+G2zLEJt6ySXRMz8Mh1IByoKFZdtnKkUf
   o1alGsfxIKMv9rcDy67qneXKwyDocf4oHyiq/T+5ui9eMHJrZhksKD/Dx
   dI0ZbsszvjxDWqIfcyUF16LUp1Xa0ZoLMbvXE2PWIn9xL2lxmIn01V5s+
   uMJwMliYIcqjRS/m4lDd+g8JOG3E9Q/DIRzGA5P/5gV4kGvBC1aLDw7Sm
   g==;
X-CSE-ConnectionGUID: l8ylOqKoT/q/G7j70c0FyA==
X-CSE-MsgGUID: K1HNwkVeQga8Be4PdvUW/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="33256475"
X-IronPort-AV: E=Sophos;i="6.10,145,1719903600"; 
   d="scan'208";a="33256475"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 05:28:01 -0700
X-CSE-ConnectionGUID: HtFIbc37SMeWPvhoPMm7yQ==
X-CSE-MsgGUID: ED/fOTYERKizTtxRfsidNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,145,1719903600"; 
   d="scan'208";a="82232969"
Received: from mtkaczyk-dev.igk.intel.com ([10.102.108.41])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 05:27:57 -0700
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
Subject: [PATCH v6 1/3] leds: Init leds class earlier
Date: Wed, 14 Aug 2024 14:28:58 +0200
Message-Id: <20240814122900.13525-2-mariusz.tkaczyk@linux.intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240814122900.13525-1-mariusz.tkaczyk@linux.intel.com>
References: <20240814122900.13525-1-mariusz.tkaczyk@linux.intel.com>
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


