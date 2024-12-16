Return-Path: <linux-pci+bounces-18540-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 281299F3826
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 18:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B01416CEA0
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 17:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEA4207E17;
	Mon, 16 Dec 2024 17:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="csA8o4fm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5778F207E1F;
	Mon, 16 Dec 2024 17:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734371846; cv=none; b=r0Q1+U6wAPZUnfnQ/FQ/Z8/jMaaSeBGRd5Vbk1l18NT0fAilEzcfywPf6a4I9AT1FRgNFLEvqJAm8yvMjPKyKczbaE4BSjYELJj2PkoNijoGMakIapAvbuDlS4rmNoNcZUnH6ardDFuzBI1VtwP+nWaSd9ggLCF8KZYmEoxcY84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734371846; c=relaxed/simple;
	bh=z6NBlZ67l3dh/xBF9ns+kvBNUNHpTdjZ66+mw5l461w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dim9zFutTdCZmF7h6g/tZJ/yzRc70OYElXpky8Q0Jw94DD9fTYTT+jZX6gZhpzBUxpVpKZZKNSaagrjigIZp3c+q3ejFZvIwgYLFjwyCfA//EdvIX9B3jpKyoeaLIzdZmCBUowXy/IErhtapk9vFJEW+FIivA/Zq/TORqmyhiCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=csA8o4fm; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734371846; x=1765907846;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z6NBlZ67l3dh/xBF9ns+kvBNUNHpTdjZ66+mw5l461w=;
  b=csA8o4fmqjl5jqdM/lFbzr2AAlstz0audkV8+vfYW+vunRGTyJFwGfGZ
   AaA8uMcViKge8H1QyAeXkzU/lnu8og1X9dV9WHks2WhhVjiqgwQE0ITEf
   wemH/tF5RqKQM8KKB78/5FM/5HDDbl1usHrpsSsma6Fx5daCYegIIfez/
   Yh3U0KAAhdTr0lJkG4Kge2SzK/cnil5WerMav07Eo6lTf0/PIDNPv3P+A
   0bAtMhtafdXHwKunCJiXmzzW9iDMu2mcYwe7bQHKmBZfqEVzBBqS+2SCW
   +gUqEYw6Q7DjMESbBxnebrjGSx0STOvd5jWf8Mfyjb4T0YSahqBGg+U8g
   w==;
X-CSE-ConnectionGUID: +cyS7HgSRTaSKluwgpBeaQ==
X-CSE-MsgGUID: dgaj9vfwQ0mYvcC7S7nKbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="57250866"
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="57250866"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 09:57:25 -0800
X-CSE-ConnectionGUID: yysNd/oMQd+dGFvwKGtUig==
X-CSE-MsgGUID: rMbAnVoFQaGWsz1/whtTpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="101418741"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.29])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 09:57:22 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	=?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
	Igor Mammedov <imammedo@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 05/25] PCI: Fix old_size lower bound in calculate_iosize() too
Date: Mon, 16 Dec 2024 19:56:12 +0200
Message-Id: <20241216175632.4175-6-ilpo.jarvinen@linux.intel.com>
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

The commit 903534fa7d30 ("PCI: Fix resource double counting on remove &
rescan") fixed double counting of mem resources because of old_size
being applied too early.

Fix a similar counting bug on the io resource side.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 31f051cdac68..ca544fb83700 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -814,11 +814,9 @@ static resource_size_t calculate_iosize(resource_size_t size,
 	size = (size & 0xff) + ((size & ~0xffUL) << 2);
 #endif
 	size = size + size1;
-	if (size < old_size)
-		size = old_size;
 
-	size = ALIGN(max(size, add_size) + children_add_size, align);
-	return size;
+	size = max(size, add_size) + children_add_size;
+	return ALIGN(max(size, old_size), align);
 }
 
 static resource_size_t calculate_memsize(resource_size_t size,
-- 
2.39.5


