Return-Path: <linux-pci+bounces-18536-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9A79F3819
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 18:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CAB01887E5A
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 17:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BD9206F0F;
	Mon, 16 Dec 2024 17:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MTp0uK0R"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4360206F09;
	Mon, 16 Dec 2024 17:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734371815; cv=none; b=QIHb6hbnnd7DYUhfcZsB0O2eryEQGr2WrW2NT3eic2wJV9nDoExokqaDODTpeV+xPK+4ADvrwInoj0kewHYUAy5B4RUnSi0qrL82AIcmfLRDM9qaBXAjzTfdtIwYM+5LX2WfIC6YnRL9UhENML04RmmwJ53SOfA75F8N+eQPzaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734371815; c=relaxed/simple;
	bh=6kTJno/nt11ujNvZctMxK8UbaiHyzJnwfjvF5S4R/Mo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n182t9AsCSDynfESPvhT3RtTb9rf9NATn0ou+thLT3FLyMnFkxFNKPKLhmObTl3+6y7xqfJJ0prAhZN8GypghGWlIFN4eUH6ahigCYlf7gGCQNb6cz5jE9ltwjssYl7JmaALO4m/4/uQ7fUSZgChDiDiDDQYFtvXy1rNE/ljY6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MTp0uK0R; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734371814; x=1765907814;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=6kTJno/nt11ujNvZctMxK8UbaiHyzJnwfjvF5S4R/Mo=;
  b=MTp0uK0RX4TTZWXCViZsFktyUzn5lXg1zGV1yK30Xjazx2utkdaecUCP
   NkIlGe6R7Kqeey8WNLXW71azmL7Hk2ioPCXbSrt9ALqnlZgxBQs4zfk0D
   0BYrEV5CGUtmc3V4RXmYveDEIQ7lXHVnbWQMmyQGQPcriWqvGWX/p+d5z
   T7yOmEa6rsnTAZMYr8txXDczfQinI3ejVr7ebwXuuoSZrCyOfQSNKZ7nw
   flC8Q/eOUh1Lap9GfuSQSbH7t/5ygzmx6Hc7VM2X7ZkUYca+OXTCktQao
   lrXrAldWbD3GG/7GKEw7/E3/hyxrHfmTSwy5H/BezuBQ8iYVQUYkEQ66Z
   w==;
X-CSE-ConnectionGUID: Z1MVKtY6RcSaT0nrC84lLg==
X-CSE-MsgGUID: IYVs1/7yQPKO9n+PdX9ejw==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="45465706"
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="45465706"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 09:56:53 -0800
X-CSE-ConnectionGUID: rMD2mwsAQ5CJigKmW8Dfgw==
X-CSE-MsgGUID: JGmNdwIAQAGu8JXoRMKY6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="97309279"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.29])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 09:56:50 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	=?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/25] PCI: Remove add_align overwrite unrelated to size0
Date: Mon, 16 Dec 2024 19:56:08 +0200
Message-Id: <20241216175632.4175-2-ilpo.jarvinen@linux.intel.com>
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

The commit 566f1dd52816 ("PCI: Relax bridge window tail sizing rules")
relaxed bridge window tail alignment rule for the non-optional part
(size0, no add_size/add_align). The change, however, also overwrite
add_align that is only related to case where optional size1 related
entry is added into realloc head.

Correct this by removing the add_align overwrite.

Fixes: 566f1dd52816 ("PCI: Relax bridge window tail sizing rules")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 5e00cecf1f1a..d92832e1f4a1 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1149,7 +1149,6 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 		min_align = 1ULL << (max_order + __ffs(SZ_1M));
 		min_align = max(min_align, win_align);
 		size0 = calculate_memsize(size, min_size, 0, 0, resource_size(b_res), win_align);
-		add_align = win_align;
 		pci_info(bus->self, "bridge window %pR to %pR requires relaxed alignment rules\n",
 			 b_res, &bus->busn_res);
 	}
-- 
2.39.5


