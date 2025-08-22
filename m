Return-Path: <linux-pci+bounces-34585-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F51FB31DA5
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 17:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B562EB2440D
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 15:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5B831352A;
	Fri, 22 Aug 2025 14:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oB2jR3Yl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4912A23ABBF;
	Fri, 22 Aug 2025 14:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755874728; cv=none; b=AhzAv5sb5xXXkuArtpGTukSLhUJomlzSpH+rNMR7J5SczUgypanZ5e7Z+MSG3RV6RNfeyH/caMpVF80jYIUqEx7IydiPNEiF76PT/5jS66RRuKEOzle06eWWKBgZSQ9JzwpR1vbx6c8Pk5sHsqkubEHbtYBwS2eBqC4kdLB4jhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755874728; c=relaxed/simple;
	bh=hKKkyDwuMgQSuHsgEQCnHOBtmnEIBd1H4fruJqqsGtc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l2g5ba8uZf1x/z8covKjrIzdE7/oTpvjSlHu90ZX/U6ZejmNqOJwsTvizoSw1ssEkKmHlMG70dOsmkhpB55xemLyJOafSVucBouqMEK7Yno3OSwHQu5QRvuLzxLpBFF/BbZVM7WK2bTx3CRA4rvqFgLuhZicap4uMDflTqHkGJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oB2jR3Yl; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755874726; x=1787410726;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hKKkyDwuMgQSuHsgEQCnHOBtmnEIBd1H4fruJqqsGtc=;
  b=oB2jR3Yly6iZar15hvXG6H4104C/22UAS5cqR3tmnbhuJ87wnDpZky0Z
   TUcZvuMeNd6mkqWuJlOcjiCdTO1ElE3+YBh5eI9cHecOIHiyxH4EW1B+N
   IlzzV5GwGQt3mesx8/QnVvmXobcKtHNma6b/iOJAX1Y66RQrgWo8UBCnZ
   uZKBmVMk0D3vjN8UrmNpxGwvyuqGcEFaRrP+cnEdp4dZCCubE9vbFA9kS
   xaf0B8VQRxi0mwQr8L8KMpF+w8buLjzUr9KWu80/41hp73F5Fkba8mDUY
   /xaxh3oisFqmbrSPcyS+g6hwL4MDPxbd4wjmc8cH6wuXj4H4veXsju8y9
   g==;
X-CSE-ConnectionGUID: 6T7UJMQiQ4uX4s1mUbV/Cw==
X-CSE-MsgGUID: yr9p7X2cQ3G58o0+AAM6pA==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="57201505"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="57201505"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 07:58:45 -0700
X-CSE-ConnectionGUID: oPGWRSQbROyBWCGWWqNJgg==
X-CSE-MsgGUID: SJBAxeC5SDOdrWApIXnu9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="199695252"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.115])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 07:58:40 -0700
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
Subject: [PATCH 16/24] PCI: Use pbus_select_window_for_type() during IO window sizing
Date: Fri, 22 Aug 2025 17:55:57 +0300
Message-Id: <20250822145605.18172-17-ilpo.jarvinen@linux.intel.com>
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

Convert pbus_size_io() to use pbus_select_window_for_type().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 55289cd58e2c..3f2776f7a1b2 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1122,8 +1122,7 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 			 struct list_head *realloc_head)
 {
 	struct pci_dev *dev;
-	struct resource *b_res = find_bus_resource_of_type(bus, IORESOURCE_IO,
-							   IORESOURCE_IO);
+	struct resource *b_res = pbus_select_window_for_type(bus, IORESOURCE_IO);
 	resource_size_t size = 0, size0 = 0, size1 = 0;
 	resource_size_t children_add_size = 0;
 	resource_size_t min_align, align;
-- 
2.39.5


