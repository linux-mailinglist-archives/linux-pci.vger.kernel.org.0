Return-Path: <linux-pci+bounces-34593-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D5CB31D86
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 17:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BAB71D20897
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 15:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6216034AAF6;
	Fri, 22 Aug 2025 15:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R91WdgkA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DFE3128C8;
	Fri, 22 Aug 2025 15:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755874803; cv=none; b=XJO7VsT7QCvw8LU47muFonKpeTdCWABTfpNG/YFp7vK1Yw1+64Wf01My0eEhiO8FZTBF+/2OGqk67V1o9ZZB4YLxzQzGf4R8bRLN668ORvZu5fzz/B1+UT0KK5LVG/xD/0Pl7pJfTGyDSrsyfuT2TCiRbFYrB1lt8+hptLlvfMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755874803; c=relaxed/simple;
	bh=EK5M2izVE5p40XIaVUFrZSmUkgoozndw/itQ2SrR1Ew=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mf5eLJXaG3+w9NO19gIvsqx+KOfy8g0wGF1pz3lN4p5de2lhX22T7UNZwHw7zb9ZIba+SidQhYLkkKVUrERvJp1msVOc7Lixt62zXgQq3a3wP0gyhDXTwiTXWzfQc953xxFWKN+Ezp5MfRULqy6qvZ2GgSxAKPWRFwilup82nWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R91WdgkA; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755874802; x=1787410802;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EK5M2izVE5p40XIaVUFrZSmUkgoozndw/itQ2SrR1Ew=;
  b=R91WdgkAOa9/1Jz1EiE36E4dJCmMDFBS0vs3jEHAc5IZ6AJwlO/faiT6
   vVT+suVhEBrwrsk17pBfPVXFiJJX7Lh5XRrlz2lrZLdZFOfmF9GpLaZrq
   /m6ut+U/wsE94lrZhwNPtyi64z/w37LgKf7Z7XUwXW5HtnWAYksl+q0CE
   VHgAMqS3FVFyvYtnxdfxC9dGEpgggMZvPmun7P/O9jPgWIDdn/AB13iuM
   x20b/NnmmVZSlW18tYNW7fxSiurOzCbIJJNtScfH8vk4HTU1HRL5uguKU
   0ltxq25C7ryQ+0qL7pYFTmwYLOGm1VBQwj5VX8Civwuw110x3WSQnyMih
   A==;
X-CSE-ConnectionGUID: h/wuobybT0+ycmdCzmCUGQ==
X-CSE-MsgGUID: xu8tuuBTS8WERaScdsV3cw==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="62016122"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="62016122"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 08:00:01 -0700
X-CSE-ConnectionGUID: SF7XkM7uRzyQinj/cT/aBA==
X-CSE-MsgGUID: 4p1p4yJ2RJyg+8Th6VhtFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="173994924"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.115])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 07:59:56 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Andreas Larsson <andreas@gaisler.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-pci@vger.kernel.org,
	sparclinux@vger.kernel.org,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Igor Mammedov <imammedo@redhat.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
	linuxppc-dev@lists.ozlabs.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 24/24] PCI: Alter misleading recursion to pci_bus_release_bridge_resources()
Date: Fri, 22 Aug 2025 17:56:05 +0300
Message-Id: <20250822145605.18172-25-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250822145605.18172-1-ilpo.jarvinen@linux.intel.com>
References: <20250822145605.18172-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Recursing into pci_bus_release_bridge_resources() should not alter
rel_type because it makes no sense to change the release type within
the recursion call chain. A literal "whole_subtree" is passed into the
recursion instead of "rel_type" parameter which is misleading as the
release type should remain the same throughout the entire operation.

This is not a correctness issue because of the preceding if () that
only allows the recursion to happen if rel_type is "whole_subtree".
Still, replace the non-intuitive parameter with direct passing of
"rel_type".

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 9c69a84f2b23..0fbdb031bc3d 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1855,7 +1855,7 @@ static void pci_bus_release_bridge_resources(struct pci_bus *bus,
 			if (res->parent != b_win)
 				continue;
 
-			pci_bus_release_bridge_resources(b, res, whole_subtree);
+			pci_bus_release_bridge_resources(b, res, rel_type);
 		}
 	}
 
-- 
2.39.5


