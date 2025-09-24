Return-Path: <linux-pci+bounces-36858-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D20ACB9A145
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 15:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB2781B23B6A
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 13:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FCD304BC5;
	Wed, 24 Sep 2025 13:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N6oqan85"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D624230499D;
	Wed, 24 Sep 2025 13:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758721380; cv=none; b=iccNGJCwQvDpLdD+lHsfPUYyJ92/8lPMYw7/zf2TocrpaEGEs8zp6UyKAtImcqdvWlRI6DxY8jmZASMJvCSAksegeDArnbRtlv5bBzWtqrPIlgFHZX0iMp6Wigcbv2R2YLiZ+DrmGrvK9KbwYTnQdHxJSgNgvp1UneMRbA3rMVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758721380; c=relaxed/simple;
	bh=e0AUn/YJNJcbdLRDzj5KvK9VlJ15qt96BJwtL6lPIHg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cDzgFCC5hmw9Zu00Py5vpZBxYiSQnUrkpo3CSvVeNPzO7WGwQ6p/YFC+W1dbpybjiPYkoeXUvID2WlTnuYp6rn1bxUeeFu3OMMh1MNP1T68YCyXcx3IK8cALNFd1M7NDU/xZeCD4XR3JEVOEXxHVsiFyHj1VpeklwOLxrDoqmX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N6oqan85; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758721379; x=1790257379;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e0AUn/YJNJcbdLRDzj5KvK9VlJ15qt96BJwtL6lPIHg=;
  b=N6oqan85r28WxN4IlQAs7RinSgqjD/ERrb7+NMWnRdFoVz/9APEWmwVx
   mkPJB9jE9zT9PsmmIFXhWC5NJBMj+ksGLA+9HphmijNextRjdDHuioPGp
   LQvgzi7zCaitQqaFqyJG0onL9GFIpodftKGP6QAyQkbVqMw2JR6wkW1lg
   ZObEIIQ5ulijmODbOJ2B4Fa+VpihqU4Q0Ip+gj+nm5bo5C5IrUI7/J0ts
   HMFu+8n/ThEJmfGlIQI5lfjBOk/965bucbh7VVOgoxT7aucHGLUIveLSs
   m/KmqM3tlUblv/ZssehOsHVUuJWUslFGD73JmS9mqlv2+EvEPDa1jSjjY
   g==;
X-CSE-ConnectionGUID: RvDwXfQ8SIqfwXF41ML5MQ==
X-CSE-MsgGUID: z9UeGNihTz2cc9iaBli05w==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="64854846"
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="64854846"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 06:42:58 -0700
X-CSE-ConnectionGUID: 5GXx4cbwR1uNFz/Vlqujsg==
X-CSE-MsgGUID: WVV1wb/mS0+lY5nEXhpKBA==
X-ExtLoop1: 1
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.210])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 06:42:55 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-kernel@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 2/2] PCI: Resources outside their window must set IORESOURCE_UNSET
Date: Wed, 24 Sep 2025 16:42:28 +0300
Message-Id: <20250924134228.1663-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250924134228.1663-1-ilpo.jarvinen@linux.intel.com>
References: <20250924134228.1663-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

PNP resources are checked for conflicts with the other resource in the
system by quirk_system_pci_resources() that walks through all PCI
resources. quirk_system_pci_resources() correctly filters out resource
with IORESOURCE_UNSET.

Resources that do not reside within their bridge window, however, are
not properly initialized with IORESOURCE_UNSET resulting in bogus
conflicts detected in quirk_system_pci_resources():

pci 0000:00:02.0: VF BAR 2 [mem 0x00000000-0x1fffffff 64bit pref]
pci 0000:00:02.0: VF BAR 2 [mem 0x00000000-0xdfffffff 64bit pref]: contains BAR 2 for 7 VFs
...
pci 0000:03:00.0: VF BAR 2 [mem 0x00000000-0x1ffffffff 64bit pref]
pci 0000:03:00.0: VF BAR 2 [mem 0x00000000-0x3dffffffff 64bit pref]: contains BAR 2 for 31 VFs
...
pnp 00:04: disabling [mem 0xfc000000-0xfc00ffff] because it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
pnp 00:05: disabling [mem 0xc0000000-0xcfffffff] because it overlaps 0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]
pnp 00:05: disabling [mem 0xfedc0000-0xfedc7fff] because it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
pnp 00:05: disabling [mem 0xfeda0000-0xfeda0fff] because it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
pnp 00:05: disabling [mem 0xfeda1000-0xfeda1fff] because it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
pnp 00:05: disabling [mem 0xc0000000-0xcfffffff disabled] because it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
pnp 00:05: disabling [mem 0xfed20000-0xfed7ffff] because it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
pnp 00:05: disabling [mem 0xfed90000-0xfed93fff] because it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
pnp 00:05: disabling [mem 0xfed45000-0xfed8ffff] because it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
pnp 00:05: disabling [mem 0xfee00000-0xfeefffff] because it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]

Mark resources that are not contained within their bridge window with
IORESOURCE_UNSET in __pci_read_base() which resolves the false
positives for the overlap check in quirk_system_pci_resources().

Fixes: f7834c092c42 ("PNP: Don't check for overlaps with unassigned PCI BARs")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

This change uses resource_contains() which will reject partial overlaps.
I don't know for sure if partial overlaps should be allowed or not (but
they feel as something FW didn't set things up properly so I chose to
mark them UNSET as well).

 drivers/pci/probe.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 7f9da8c41620..097389f25853 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -205,6 +205,26 @@ static void __pci_size_rom(struct pci_dev *dev, unsigned int pos, u32 *sizes)
 	__pci_size_bars(dev, 1, pos, sizes, true);
 }
 
+static struct resource *pbus_select_window_for_res_addr(
+					const struct pci_bus *bus,
+					const struct resource *res)
+{
+	unsigned long type = res->flags & IORESOURCE_TYPE_BITS;
+	struct resource *r;
+
+	pci_bus_for_each_resource(bus, r) {
+		if (!r || r == &ioport_resource || r == &iomem_resource)
+			continue;
+
+		if ((r->flags & IORESOURCE_TYPE_BITS) != type)
+			continue;
+
+		if (resource_contains(r, res))
+			return r;
+	}
+	return NULL;
+}
+
 /**
  * __pci_read_base - Read a PCI BAR
  * @dev: the PCI device
@@ -329,6 +349,18 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 			 res_name, (unsigned long long)region.start);
 	}
 
+	if (!(res->flags & IORESOURCE_UNSET)) {
+		struct resource *b_res;
+
+		b_res = pbus_select_window_for_res_addr(dev->bus, res);
+		if (!b_res ||
+		    b_res->flags & (IORESOURCE_UNSET | IORESOURCE_DISABLED)) {
+			pci_dbg(dev, "%s %pR: no initial claim (no window)\n",
+				res_name, res);
+			res->flags |= IORESOURCE_UNSET;
+		}
+	}
+
 	goto out;
 
 
-- 
2.39.5


