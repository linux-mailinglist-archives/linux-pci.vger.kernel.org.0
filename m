Return-Path: <linux-pci+bounces-9834-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 423B992891B
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2024 14:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73A5E1C20E8A
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2024 12:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE8B14AD2C;
	Fri,  5 Jul 2024 12:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dQFSckY/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5883414A61E
	for <linux-pci@vger.kernel.org>; Fri,  5 Jul 2024 12:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720184166; cv=none; b=SOIyU+H3bE9TXcpzvkackFiJugTaj4s5MxTZE/UChtJCGV+6tjFM1puMHwMjKbSiE92jr6NNCHqxaxFHdL7fR/m9UegtnVzljMQEPei+dZKVsU7KvQwOoZWfn9zyc8BJOgiuxvMHuM7tTAC6C7o5CHqdWhozaAUUNWvngVzShLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720184166; c=relaxed/simple;
	bh=JNc7PEu0P1U0w8u5SMvkCieU3V8TsGyso8lzCgjpG1k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fy/4GMuHELbMhWqkMQosE9enCTndWtzS8V7hCFH3PVu7+Ure6G9kTJ49HeKYssXyAjO0bm9OoH2ZbmNdiphOWl0XUMKHVma0MM6nEAnRzrT5kZjCfH4prBSOQqB9BO78X9LzfUZGiCtJ+XzROhpjI+/w7vGkfazwq1jhIX54FVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dQFSckY/; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720184165; x=1751720165;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JNc7PEu0P1U0w8u5SMvkCieU3V8TsGyso8lzCgjpG1k=;
  b=dQFSckY/Z/RfLw/1W5/0yffK5aqj6ekKcK8iJMXddYAEtGnb2KE8t6fs
   cHJwdMO4svSKfeLDIIP+6bwPEUB8jqqIKVgnY2aFkXMw/pnzh3+d8mk53
   Dt6dJ/zXMmPpFf0okOXzCi03Lh+tOj5wE12Jqe1VOgR7iEridKqP3q3UG
   QRbNJRv48N5gdi53gtLVcHUNPZvr0S5yMuMXaUnFaMkZ1P4prtSHYbd8l
   Yv8L8DdB+axY/mpT0utd8ZemHsD8E9S2/FmKSsgg8dmR3egZV4ee4QvXR
   Muib51on0ISuFP99tKpk2yNkjnIic1Kp8yeRHe55dDUUjgCYin0O9K2kQ
   g==;
X-CSE-ConnectionGUID: CXJ9YId4Sw+cQRVZWweoig==
X-CSE-MsgGUID: VUQ6sri1Qn2p5JCI8T6ubA==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="21348032"
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; 
   d="scan'208";a="21348032"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2024 05:54:41 -0700
X-CSE-ConnectionGUID: yr1HRqSCTAOw6lhGWf+CFQ==
X-CSE-MsgGUID: P/AugMP+TGObFJV+J6V9Jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; 
   d="scan'208";a="47620777"
Received: from mtkaczyk-dev.igk.intel.com ([10.102.108.41])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2024 05:54:38 -0700
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
Subject: [PATCH v3 1/3] leds: Init leds class earlier
Date: Fri,  5 Jul 2024 14:54:34 +0200
Message-Id: <20240705125436.26057-2-mariusz.tkaczyk@linux.intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240705125436.26057-1-mariusz.tkaczyk@linux.intel.com>
References: <20240705125436.26057-1-mariusz.tkaczyk@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NPEM driver will require leds class, there is an init-order conflict.
Make sure that LEDs initialization happens first and add comment.

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


