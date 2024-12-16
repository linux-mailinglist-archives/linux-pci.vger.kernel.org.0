Return-Path: <linux-pci+bounces-18547-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6874B9F3848
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 19:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C64D118920FF
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 18:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7296520CCF8;
	Mon, 16 Dec 2024 17:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="afm3HAk/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DF620CCDC;
	Mon, 16 Dec 2024 17:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734371906; cv=none; b=inPAAUXGSaSWfwedoMj5oYCQTSHuWZlVv1dytcRpZ1cevO5VW9Q9ne72yLCXyTWSrwzMh3pWeasAyCZjJYN3ajCapUj1h8fPdn6uW+u3QxCLokpi8C7P8UbhofIpm92z051GL8MEiCNcVdfwlrsg43LWRuvAJsFBd99cFKy98Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734371906; c=relaxed/simple;
	bh=EaKOY1NURyHD7MBz4t/eBMjwdJZLiP/F4PItP37cGuM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bOAa7fEOCrRP/+cGf8cL7tVMYypl4NYNGgjLI3su0sd3s3tcN2s5aYkQkWWHmdqpbcltzwwiyjxbcBsdI6BA0YJ9Jqsjjbi+yk9JJTcX089y0tA2ZkRGGF4QlXO/Nzg3DQm3G2RoO69zZ13EZtkN7gfq6+Euxhkz4ct3PWSKrcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=afm3HAk/; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734371905; x=1765907905;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EaKOY1NURyHD7MBz4t/eBMjwdJZLiP/F4PItP37cGuM=;
  b=afm3HAk/OuQXmGu5j/qRi5AzmtN5j0pFw3ST+pKUoL2S8+JWa1gUHhfe
   LheyuUnaox7NYx0dTaJ0FCvBc9Yl27JsHtswrbfrLubYRXglqyImj2NXw
   HmuK7UQkDA27i3Pk5anZoH9qFP81yyOY/OqwB0w1DbTF/FzngwzRDHuqI
   AS8NlNcgEvrTBZfiL/Aqk+GhIs3a/gg9wAlDXA2VD0U0JNkyx0l2DY/N3
   ktN/MFZFFcFEVtbgTHcPqjH/E9Mdih5HblfCMcPRfx9n+wvu4Uv+XsPYf
   urHhoaX6zFlHk3QKZykAay1lJ30JPnlCGp23LijhcudFZDfq+0J8faZqW
   Q==;
X-CSE-ConnectionGUID: DgO5wL/KT9KkvUKqY1XKUg==
X-CSE-MsgGUID: j69v2sidTyOziobVU31ZVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="57250930"
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="57250930"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 09:58:24 -0800
X-CSE-ConnectionGUID: 1GCzlevXTjumfLGnWuUGMA==
X-CSE-MsgGUID: INcC9lW2QxeaUZO6BnveKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="101419048"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.29])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 09:58:21 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	=?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
	Igor Mammedov <imammedo@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 12/25] PCI: Converge return paths in __assign_resources_sorted()
Date: Mon, 16 Dec 2024 19:56:19 +0200
Message-Id: <20241216175632.4175-13-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241216175632.4175-1-ilpo.jarvinen@linux.intel.com>
References: <20241216175632.4175-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

All return paths want to free head list in __assign_resources_sorted()
so add a label and use goto.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 6b4318da1147..ad7bc6166b23 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -444,8 +444,7 @@ static void __assign_resources_sorted(struct list_head *head,
 		list_for_each_entry(dev_res, head, list)
 			remove_from_list(realloc_head, dev_res->res);
 		free_list(&save_head);
-		free_list(head);
-		return;
+		goto out;
 	}
 
 	/* Check failed type */
@@ -488,6 +487,8 @@ static void __assign_resources_sorted(struct list_head *head,
 	/* Try to satisfy any additional optional resource requests */
 	if (realloc_head)
 		reassign_resources_sorted(realloc_head, head);
+
+out:
 	free_list(head);
 }
 
-- 
2.39.5


