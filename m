Return-Path: <linux-pci+bounces-7899-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DEE68D1CCC
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2024 15:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC5EF281E97
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2024 13:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C02217085F;
	Tue, 28 May 2024 13:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cXOMrb5g"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFC8171068
	for <linux-pci@vger.kernel.org>; Tue, 28 May 2024 13:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716902399; cv=none; b=Jr9K4QNnr6T0N+oaoqs9eBGNr1iO1quqXzttvaQZQjRBj598vkstwhYOuSfhCcqtm1l5VaK6U3SVtCrbameHZv+uggBGa7zbY/1SWNfcT2jpjHVkZceBJ6O/8/dSSo8WIrS9Uul6g9bfLC2lcaFkHQsLeoCNLGahPH66ACHptN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716902399; c=relaxed/simple;
	bh=fPzVTaxPuya9HuoafHHPnsnmlprzt0gPyBxm60v94m0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rLikCas2MAGJZemFG02fjDTesPxLbBpIBQ6Ba73JKn1N25gFOw4UJOo3yoDtQlO1GmiovqfPedF3YIYUAWpZWWb9MOWoUNptMyR6sAjxxRyQ6xq0Wv18rNl0s5JAdlofoT8+ehC7mhYAbiXHtVL14FQ/ZaGQ/GS9wNi37S3hwUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cXOMrb5g; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716902398; x=1748438398;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fPzVTaxPuya9HuoafHHPnsnmlprzt0gPyBxm60v94m0=;
  b=cXOMrb5gxMd+MhF10HAEI6QUCC72ASGk7+WKFd/F7SGz7gkMw85Os5VJ
   l8VgHCvD/OMU0RjRR5BMMIo0dc6Tw7li4EfIqVKTnwNQ1a/vM/33pObuo
   NTnr22K7S+kP7Ht2fKveylReX2KrxRUQ7SlEgl3KNj8HhU5STz2g+Dq/Y
   Fxy13CQuiYMmolxnB3hj9wKLCh9aqvYwp4lL1SVQUwpNbRganrXfeQsha
   /GLv7eL+ZujQPxKQeoqgcjx0L5NkTzi0RjVU4SVIg21aBwU+Es9DnXj5J
   EiPakH6hbA+vYvFLszLAVxlD2cw1iDbGIW48V7SP2484pPa6o1FRuUTFy
   w==;
X-CSE-ConnectionGUID: PCocJbeATOmbus41o7BJ8Q==
X-CSE-MsgGUID: Mhfi66YSQpeMc5VI3tetWg==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="16195166"
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="16195166"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 06:19:58 -0700
X-CSE-ConnectionGUID: Xp6v+cXdSnKsCF+bwpeooQ==
X-CSE-MsgGUID: YA24mV/MRSeFBKzNNO/iaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="39510542"
Received: from unknown (HELO mtkaczyk-dev.igk.intel.com) ([10.102.108.41])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 06:19:54 -0700
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
Subject: [PATCH v2 1/3] leds: Init leds class earlier
Date: Tue, 28 May 2024 15:19:38 +0200
Message-Id: <20240528131940.16924-2-mariusz.tkaczyk@linux.intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240528131940.16924-1-mariusz.tkaczyk@linux.intel.com>
References: <20240528131940.16924-1-mariusz.tkaczyk@linux.intel.com>
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
index 24fcff682b24..bed7b6ea9b98 100644
--- a/drivers/leds/led-class.c
+++ b/drivers/leds/led-class.c
@@ -681,7 +681,7 @@ static void __exit leds_exit(void)
 	class_unregister(&leds_class);
 }
 
-subsys_initcall(leds_init);
+arch_initcall(leds_init);
 module_exit(leds_exit);
 
 MODULE_AUTHOR("John Lenz, Richard Purdie");
-- 
2.35.3


