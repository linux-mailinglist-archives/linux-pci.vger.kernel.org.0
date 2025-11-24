Return-Path: <linux-pci+bounces-41975-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F08E2C81CC4
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 18:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 605CA4E6D00
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 17:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA5F274FFD;
	Mon, 24 Nov 2025 17:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BYmAFR4i"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E66915CD74;
	Mon, 24 Nov 2025 17:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764003866; cv=none; b=e9euimfQhkHUOX09JjIPRwQqLzwdls2A/rMMTRD3npiC39gl/f/X6LKGQ152HBQx3cKZIsjL0TsWypdAGAcfln/xlAGR38G9OfnDgAqN0EeibvhHspE62rp0G690qVrNR0r7q2YDk3CYMPMsdgifb3KxQFP0zwdLC7cs7tSIBAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764003866; c=relaxed/simple;
	bh=YY50eJzr4IS/BlZOaKPxeusBqwn7f+tKcxS5KLWsEAM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=nqj5Q+mJx2YU93gurTktWqQXVg/FnNFd0su1a/JbvJGWbLWHSx6DSqMJ7zDt5Tj2PNt2ZETvFETw/sHdbuUeL/1iC0rikmIVTtA1TSiSJHzTxjmB+RYOsaRHbdAJAZYYBuq+Er291svjpTiK3yrKVXPnblX8iOhvyPDeEbR2T7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BYmAFR4i; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764003865; x=1795539865;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YY50eJzr4IS/BlZOaKPxeusBqwn7f+tKcxS5KLWsEAM=;
  b=BYmAFR4ifuFPLk/ki5xU0pSbSnoMSj+4XN8i5pH31hSaeowdENktgs8M
   SEPuYUzMkLBgkhymIb3IGcuR80mJJEzScb3r8pPEZVBC4/czfcmteE8RH
   wl7+iXjgNmhtjE6JsTCrPauds6jx7DOvcwB4L/ZEbdKLx4xR3l5s6653v
   u5LjbDaNUtt3y1B502ADhCaTJWM3UaKOt92QlOBvCnxYjRGlOhq1zxwjJ
   FhV3CJtnoySr3DHlsvvHAXOQ9KrFZxrnO5KkLBnU3WGYoJmqFpFIhTkzX
   qjO/jqwbJybcyLX/S0Hj8DL/kOTVPi0p5LB/DE8av0FpYV8SY06IHxcIV
   A==;
X-CSE-ConnectionGUID: UD4ritntS1O4gp1HkwV4NQ==
X-CSE-MsgGUID: NeYcqoIzTP+1a07Lctmgag==
X-IronPort-AV: E=McAfee;i="6800,10657,11623"; a="65707762"
X-IronPort-AV: E=Sophos;i="6.20,223,1758610800"; 
   d="scan'208";a="65707762"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 09:04:24 -0800
X-CSE-ConnectionGUID: 8TKuqc5STjSVBqT3mI3Iww==
X-CSE-MsgGUID: 5Uaapji9Tq2oe3c+yKXuiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,223,1758610800"; 
   d="scan'208";a="192622096"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.97])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 09:04:19 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Rob Herring <robh@kernel.org>,
	linux-pci@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nathaniel Roach <nroach44@gmail.com>
Subject: [PATCH RESEND 1/1] SPARC/PCI: Correct 64-bit non-pref -> pref BAR resources
Date: Mon, 24 Nov 2025 19:04:11 +0200
Message-Id: <20251124170411.3709-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

SPARC T5-2 dts describes some PCI BARs as 64-bit resources without
pref(etchable) bit (0x83... vs 0xc3... in assigned-addresses) for
address ranges above the 4G threshold. Such resources cannot be placed
into a non-prefetchable PCI bridge window that is capable only to
32-bit addressing. As such, it looks the platform is improperly
describe by dts.

Kernel detect this problem (see the IORESOURCE_PREFETCH check in
pci_find_parent_resource()) and fails to assign these BAR resources to
the resource tree due to lack of a compatible bridge window.

Prior to the commit 754babaaf333 ("sparc/PCI: Remove
pcibios_enable_device() as they do nothing extra") SPARC arch code did
not test whether device resources were successfully in the resource
tree when enabling a device, effectively hiding the problem. After
removing the arch specific enable code, PCI core's
pci_enable_resources() refuses to enable the device when it finds not
all mem resources are assigned, and therefore mpt3sas can't be enabled:

pci 0001:04:00.0: reg 0x14: [mem 0x801110000000-0x80111000ffff 64bit]
pci 0001:04:00.0: reg 0x1c: [mem 0x801110040000-0x80111007ffff 64bit]
pci 0001:04:00.0: BAR 1 [mem 0x801110000000-0x80111000ffff 64bit]: can't claim; no compatible bridge window
pci 0001:04:00.0: BAR 3 [mem 0x801110040000-0x80111007ffff 64bit]: can't claim; no compatible bridge window
mpt3sas 0001:04:00.0: BAR 1 [mem size 0x00010000 64bit]: not assigned; can't enable device

For clarity, this filtered log only shows failures for one mpt3sas
device but other devices fail similarly. In the reported case, the end
result with all the failures is an unbootable system.

Things appeared to "work" before the commit 754babaaf333 ("sparc/PCI:
Remove pcibios_enable_device() as they do nothing extra") because the
resource tree is agnostic to whether PCI BAR resources are properly in
the tree or not. So as long as there was a parent resource (e.g. a root
bus resource) that contains the address range, the resource tree code
just places resource request underneath it without any consideration to
the intermediate BAR resource. While it worked, it's incorrect setup
still.

Add of fixup to set IORESOURCE_PREFETCH flag for a 64-bit PCI resource
that has the end address above 4G requiring placement into the
prefetchable window. Also log the issue.

Fixes: 754babaaf333 ("sparc/PCI: Remove pcibios_enable_device() as they do nothing extra")
Reported-by: Nathaniel Roach <nroach44@gmail.com>
Tested-by: Nathaniel Roach <nroach44@gmail.com>
Closes: https://github.com/sparclinux/issues/issues/22
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

Resending with linux-pci@ ML.

Any comments on the approach are welcome. E.g., is the fixup done at a
correct level? Should it be targeted specifically to the known failures
(how?) to avoid hiding more platform description problems?

It seems VF BARs still have 64-bit non-pref despite this change, AFAICT,
those are read directly from the device's config space so would require
ordinary quirks. None of them result in device enable failing though so the
issue is orthogonal to the one being fixed here.

If suggesting a different approach, please do realize my knowledge
about OF code is generally very limited (and I'm not sure how directly
the fixup code in other archs, mainly ppc, can be used as an example
how to do fixups with sparc).
---
 arch/sparc/kernel/pci.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index a9448088e762..b290107170e9 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -181,6 +181,28 @@ static int __init ofpci_debug(char *str)
 
 __setup("ofpci_debug=", ofpci_debug);
 
+static void of_fixup_pci_pref(struct pci_dev *dev, int index,
+			      struct resource *res)
+{
+	struct pci_bus_region region;
+
+	if (!(res->flags & IORESOURCE_MEM_64))
+		return;
+
+	if (!resource_size(res))
+		return;
+
+	pcibios_resource_to_bus(dev->bus, &region, res);
+	if (region.end <= ~((u32)0))
+		return;
+
+	if (!(res->flags & IORESOURCE_PREFETCH)) {
+		res->flags |= IORESOURCE_PREFETCH;
+		pci_info(dev, "reg 0x%x: fixup: pref added to 64-bit resource\n",
+			 index);
+	}
+}
+
 static unsigned long pci_parse_of_flags(u32 addr0)
 {
 	unsigned long flags = 0;
@@ -244,6 +266,7 @@ static void pci_parse_of_addrs(struct platform_device *op,
 		res->end = op_res->end;
 		res->flags = flags;
 		res->name = pci_name(dev);
+		of_fixup_pci_pref(dev, i, res);
 
 		pci_info(dev, "reg 0x%x: %pR\n", i, res);
 	}

base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
-- 
2.39.5


