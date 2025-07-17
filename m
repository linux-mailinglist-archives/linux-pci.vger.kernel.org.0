Return-Path: <linux-pci+bounces-32347-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7217CB0817E
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 02:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED0261C274C5
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 00:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FBE15A864;
	Thu, 17 Jul 2025 00:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YP9I60bs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24431273FE;
	Thu, 17 Jul 2025 00:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752712848; cv=none; b=LR3kdp6k4TkMuQIWru7vRsiu070psBjM5hCXPO7f2TTtKpnWhlsHfUMJQ3Vxrs+FcYEaUKEJynVBoMMLQ7TI8rXB/mBHC3dKj962wsvqil+3/LrttvUujVisdBA4p4bRbG8maHk/yDl4HXYtmhan8E7ts19R8ar5A7U3uKqVEU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752712848; c=relaxed/simple;
	bh=wBD2mHrdjLnvkVZe75H43+6jhreRQ6Gm5AWdiT+UcDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pdPuhL6FFviScr0FR5iuBztPenBa0F/J2AavD0r/Mub3EYBphpEbji3f/soxPTT1MjoW/CeYyXhrXVS8fXJ3K4vNoT2z3wFeuZ1qiNNGqz77tyPwjY8xpTe3rePa0FpXIb0rNRfqA41cKNY7n7hNUwDtUklIlluQ96B0q9kAvAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YP9I60bs; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752712847; x=1784248847;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wBD2mHrdjLnvkVZe75H43+6jhreRQ6Gm5AWdiT+UcDY=;
  b=YP9I60bsfywXZbaq1h+E+gKGguQMjmgmOGmP+KFMAmFex580M6dCX+Rz
   M2d92jDPwh7bNJymThwi9teRhBP5PgCNkKrnUdqxMOVJ1hy+UwZvH9hvu
   hJz5wG9AJtzm4RndhD/JcEMegwEihh8ni0otbrMmmPSbmHZYy4sSEfcDX
   v0tmp7zwBfjCfTxr0tjYWvCFVxwUbSaheqzjBUddpBvfAVKTvS/37gnuu
   8nwMMLGOg1XIPjVoKx8jZ1/1jPzlB6s4SNaYxIVuuLcw+txf9nBizK8oj
   mPBvNtAZx1oNeRvB2CrMzK4Cc3ccOia/qt2LWQpzJqLzZGqtNipvKCu0E
   w==;
X-CSE-ConnectionGUID: ZuD64mmUQfm1aQm4CExOVw==
X-CSE-MsgGUID: s40eizPkROi1Hbr2ybj0Ew==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="54912426"
X-IronPort-AV: E=Sophos;i="6.16,317,1744095600"; 
   d="scan'208";a="54912426"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 17:40:44 -0700
X-CSE-ConnectionGUID: +KV19wsbSm+fIrDmxijSSQ==
X-CSE-MsgGUID: SqjOLTbwQ4uEj+/kYIPI7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,317,1744095600"; 
   d="scan'208";a="188596626"
Received: from rfrazer-mobl3.amr.corp.intel.com (HELO debox1-desk4.intel.com) ([10.124.220.193])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 17:40:43 -0700
From: "David E. Box" <david.e.box@linux.intel.com>
To: rafael@kernel.org,
	bhelgaas@google.com,
	vicamo.yang@canonical.com,
	kenny@panix.com,
	nirmal.patel@linux.intel.com
Cc: "David E. Box" <david.e.box@linux.intel.com>,
	linux-pm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [RFC 1/2] PCI/ASPM: Allow drivers to provide ASPM link state via pci_bus
Date: Wed, 16 Jul 2025 17:40:25 -0700
Message-ID: <20250717004034.2998443-2-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250717004034.2998443-1-david.e.box@linux.intel.com>
References: <20250717004034.2998443-1-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Synthetic PCIe hierarchies such as those created by Intel VMD are not
enumerated or configured by firmware, and therefore do not receive
BIOS-provided ASPM defaults. This leaves devices behind such domains with
ASPM effectively disabled, despite platform intent.

Introduce a mechanism to allow the bus owner (e.g. a controller driver) to
supply a default ASPM policy via a new aspm_bus_link_state field in
pci_bus.  A new bus flag, PCI_BUS_FLAGS_ASPM_DEFAULT_OVERRIDE, indicates
that the core should use this value instead of the BIOS default when
initializing link state.

This avoids the need for controller-specific logic in ASPM core and allows
for proper power savings in these otherwise unsupported hierarchies.

Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/pci/pcie/aspm.c |  5 ++++-
 include/linux/pci.h     | 12 ++++++++----
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 29fcb0689a91..2ad1852ac9b2 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -866,7 +866,10 @@ static void pcie_aspm_cap_init(struct pcie_link_state =
*link, int blacklist)
 	}
=20
 	/* Save default state */
-	link->aspm_default =3D link->aspm_enabled;
+	if (parent->bus->bus_flags & PCI_BUS_FLAGS_NO_ASPM_DEFAULT)
+		link->aspm_default =3D parent->bus->aspm_bus_link_state;
+	else
+		link->aspm_default =3D link->aspm_enabled;
=20
 	/* Setup initial capable state. Will be updated later */
 	link->aspm_capable =3D link->aspm_support;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 05e68f35f392..7e1c305c419c 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -256,10 +256,11 @@ enum pci_irq_reroute_variant {
=20
 typedef unsigned short __bitwise pci_bus_flags_t;
 enum pci_bus_flags {
-	PCI_BUS_FLAGS_NO_MSI	=3D (__force pci_bus_flags_t) 1,
-	PCI_BUS_FLAGS_NO_MMRBC	=3D (__force pci_bus_flags_t) 2,
-	PCI_BUS_FLAGS_NO_AERSID	=3D (__force pci_bus_flags_t) 4,
-	PCI_BUS_FLAGS_NO_EXTCFG	=3D (__force pci_bus_flags_t) 8,
+	PCI_BUS_FLAGS_NO_MSI		=3D (__force pci_bus_flags_t) 1,
+	PCI_BUS_FLAGS_NO_MMRBC		=3D (__force pci_bus_flags_t) 2,
+	PCI_BUS_FLAGS_NO_AERSID		=3D (__force pci_bus_flags_t) 4,
+	PCI_BUS_FLAGS_NO_EXTCFG		=3D (__force pci_bus_flags_t) 8,
+	PCI_BUS_FLAGS_NO_ASPM_DEFAULT	=3D (__force pci_bus_flags_t) 16,
 };
=20
 /* Values from Link Status register, PCIe r3.1, sec 7.8.8 */
@@ -665,6 +666,9 @@ struct pci_bus {
 	void		*sysdata;	/* Hook for sys-specific extension */
 	struct proc_dir_entry *procdir;	/* Directory entry in /proc/bus/pci */
=20
+#ifdef CONFIG_PCIEASPM
+	unsigned int	aspm_bus_link_state;	/* Bus owner provided link state */
+#endif
 	unsigned char	number;		/* Bus number */
 	unsigned char	primary;	/* Number of primary bridge */
 	unsigned char	max_bus_speed;	/* enum pci_bus_speed */
--=20
2.43.0


