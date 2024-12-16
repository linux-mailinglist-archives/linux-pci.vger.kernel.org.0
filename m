Return-Path: <linux-pci+bounces-18542-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6976D9F3829
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 18:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9115C16C0E0
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 17:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9233520765F;
	Mon, 16 Dec 2024 17:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XnfhPbHD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DC820765E;
	Mon, 16 Dec 2024 17:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734371866; cv=none; b=nW//mSue46u+hTkRCBD14r5uNaB3W2/ZlnLWTR0hKI5U167qDU04GhHhorOMzBWadPDd6eF/A0f+8OvWl+yni07bcSWCC3qZNWLyikGRXs4yFVhtsKJCdEg36yYp9aYtOIua5wMfz8tFBRIHbMoTjSBBzErbQyjqRJDefJtJxWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734371866; c=relaxed/simple;
	bh=4cHsTGVy4Bomfa9noiKGbjnie0ooNWlfaX+VYhXkFb0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s6hGCYzzrqX2BqB/Sxv84gOVQCWsC8Tg2EZBzm+hEANCDpaEpahMOftnQtbil4ITq8QVzlu2YMtWvdud1KFIG4pLMq41kwSyLUq892IqRqJoj3/nGvv7vRqDCPIDUhB+zPROQnf4e7KYkNP650PEubyl5VCqyxF53WvBa5LIEU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XnfhPbHD; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734371865; x=1765907865;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4cHsTGVy4Bomfa9noiKGbjnie0ooNWlfaX+VYhXkFb0=;
  b=XnfhPbHDRlvCCQT5xxBDWMPyUrFRa2qItPsvKsIe+h7/YZrpMOqjhHQz
   P1r4qEOW2SsMjazQ1BZt7FqYmd/vKZ2se7MSCzzEJ4KEY7DMkBBRYWZJb
   Uw5yTfWNrO25B8gnakNphdlz4OPqDDhlEj7XkqaHc47pJDLezb9YtfH1f
   zxMmOVSKGkuOQapyZ3FTMHrOQ0vrX5R/Gof1aZg+6bzsVVOfx6tACsnyX
   TvSmFt0wTKrurYYXS5NEibOfYYvpe1vPtHloVYwcOHoH3gXlvYS7V/cEf
   fKQTXwxQve0QjG31XZhobNBCSKUqAtXE3v141Y4u2cdhiDiReK7tlC3q5
   w==;
X-CSE-ConnectionGUID: t5bhwZPTR3WoOAKWcGtBZw==
X-CSE-MsgGUID: AFw5auYIQ4uKJwtGba56OQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="57250884"
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="57250884"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 09:57:45 -0800
X-CSE-ConnectionGUID: pXCPCjFrQGOF0DgrgOeCEw==
X-CSE-MsgGUID: f+zdronbQcKwDltgVs8QNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="101418843"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.29])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 09:57:41 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	=?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
	Igor Mammedov <imammedo@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 07/25] PCI: resource_set_range/size() conversions
Date: Mon, 16 Dec 2024 19:56:14 +0200
Message-Id: <20241216175632.4175-8-ilpo.jarvinen@linux.intel.com>
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

A few sites that could use resource_set_range/size() in setup-bus.c
were not picked up earlier due to them no matching the usual pattern.
Convert them now.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 303c4fbf2d14..dd9b06947621 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -413,10 +413,8 @@ static void __assign_resources_sorted(struct list_head *head,
 		 * consistent.
 		 */
 		if (add_align > dev_res->res->start) {
-			resource_size_t r_size = resource_size(dev_res->res);
-
-			dev_res->res->start = add_align;
-			dev_res->res->end = add_align + r_size - 1;
+			resource_set_range(dev_res->res, add_align,
+					   resource_size(dev_res->res));
 
 			list_for_each_entry(dev_res2, head, list) {
 				align = pci_resource_alignment(dev_res2->dev,
@@ -1100,7 +1098,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 			if (realloc_head && i >= PCI_IOV_RESOURCES &&
 					i <= PCI_IOV_RESOURCE_END) {
 				add_align = max(pci_resource_alignment(dev, r), add_align);
-				r->end = r->start - 1;
+				resource_set_size(r, 0);
 				add_to_list(realloc_head, dev, r, r_size, 0 /* Don't care */);
 				children_add_size += r_size;
 				continue;
@@ -1180,8 +1178,8 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 		b_res->flags = 0;
 		return 0;
 	}
-	b_res->start = min_align;
-	b_res->end = size0 + min_align - 1;
+
+	resource_set_range(b_res, min_align, size0);
 	b_res->flags |= IORESOURCE_STARTALIGN;
 	if (bus->self && size1 > size0 && realloc_head) {
 		add_to_list(realloc_head, bus->self, b_res, size1-size0, add_align);
@@ -1656,8 +1654,7 @@ static void pci_bridge_release_resources(struct pci_bus *bus,
 		pci_info(dev, "resource %d %pR released\n",
 			 PCI_BRIDGE_RESOURCES + idx, r);
 		/* Keep the old size */
-		r->end = resource_size(r) - 1;
-		r->start = 0;
+		resource_set_range(r, 0, resource_size(r));
 		r->flags = 0;
 
 		/* Avoiding touch the one without PREF */
-- 
2.39.5


