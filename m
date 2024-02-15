Return-Path: <linux-pci+bounces-3499-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5C58565E6
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 15:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D849B1F21DE0
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 14:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7351131E31;
	Thu, 15 Feb 2024 14:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lfW4Z3Ha"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26D3131E22;
	Thu, 15 Feb 2024 14:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708007102; cv=none; b=qhnA2/SS6iJc+X939+iEkHIWvgB/BU7wGR3/oEAttkgC5Bb1I0CGFqXx/0yUifzRnkeDsPJkYwaP72bS3pIDMKBzY3x/ssTignmJq4m1JomPXUqn39+sBiFbeV5597XuHLpTzF+HgN3bZAZ9IdRel+KeP93ye89r7VKZjphAHzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708007102; c=relaxed/simple;
	bh=en47z54b1gIFPBqMEd6jYCsoqfnsaNMM97obpZLm+Rg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nDwWAho8/s0T6V0NiCmhOOjMUCruYo25bCFFr8xyDSSiVRxd1/up4T5jsKfzejUN4Wj8nNpMlWgmR6VAuLVJNZ5x2a8WZlndwMZ7nHa1rr93p/7UYjYWxnU703Mok289GdT/KZPed67o7mx7sobAw4bYeHNDcXOyNAR9NzCSZ3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lfW4Z3Ha; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708007100; x=1739543100;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=en47z54b1gIFPBqMEd6jYCsoqfnsaNMM97obpZLm+Rg=;
  b=lfW4Z3Ha4jGsO5ulEK3gDNOfVXC8AE/51iUDA9Qv0fPUd6vE3+WTGL1E
   QGbGnKe3U6hBlLN7ORM5AAiUn0K9X3ozR06aiA+g6/L5Ela83/pSRd6Tz
   0HN70r5I/qgtSVpYVHNhDNGIGB5Wz1QZUYa8o7MXBp1YcqdNOCmnneE3L
   TWrrPqtzj7MSl9BeUyQQWuTxiQxH0S4qJU7dqKef6InnRygnlYibpquvz
   c8F4cTqXNiKU7Iye7eFUvnUz7vrfJSTEqMT+1YpTIDoGAVT9DfadQ0Pvc
   oXUcQdzDLK+qLylO01olY7WUv6OwtRtkbBfGa39OKX7pQ6dhfRPS9pc8q
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="19514414"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="19514414"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 06:25:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="3701822"
Received: from unknown (HELO mtkaczyk-devel.igk.intel.com) ([10.102.108.91])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 06:24:59 -0800
From: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To: linux-pci@vger.kernel.org,
	linux-leds@vger.kernel.org
Cc: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Subject: [PATCH 1/2] leds: Init leds class earlier
Date: Thu, 15 Feb 2024 15:23:44 +0100
Message-Id: <20240215142345.6073-2-mariusz.tkaczyk@linux.intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240215142345.6073-1-mariusz.tkaczyk@linux.intel.com>
References: <20240215142345.6073-1-mariusz.tkaczyk@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PCI subsystem is registered on subsys_initcall() same as leds class.
NPEM driver will require leds class, there is race possibility.

Register led class on arch_initcall() to avoid it.

Signed-off-by: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
---
 drivers/leds/led-class.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
index ba1be15cfd8e..4cf99d64958e 100644
--- a/drivers/leds/led-class.c
+++ b/drivers/leds/led-class.c
@@ -675,7 +675,7 @@ static void __exit leds_exit(void)
 	class_unregister(&leds_class);
 }
 
-subsys_initcall(leds_init);
+arch_initcall(leds_init);
 module_exit(leds_exit);
 
 MODULE_AUTHOR("John Lenz, Richard Purdie");
-- 
2.35.3


