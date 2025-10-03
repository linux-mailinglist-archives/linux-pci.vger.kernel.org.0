Return-Path: <linux-pci+bounces-37523-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E85FBB64B7
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 11:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A6E2B344B5E
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 09:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC2528150F;
	Fri,  3 Oct 2025 09:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="m0hOtV3R"
X-Original-To: linux-pci@vger.kernel.org
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A17127EFFE;
	Fri,  3 Oct 2025 09:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.245.243.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759482213; cv=none; b=KsU4E7mYMUKp6RPXaetGNLMopXpUq8Fh31tXZgRWmMo6/9pBLXpea7jjBICt3baqia5ZB2Shlqm/8zvGLtx+6ki/ocf1cQaL4Mx39V0sTl1JmyIVrGcikSzxulAVPJar9bVHrIk2V8ZEqpNIuzNN2ddcC5s2y1sZ9Tf7hLC7kR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759482213; c=relaxed/simple;
	bh=7YJj/l6hm9baYCf0DdWLW1O1HHavwXDrXJi17yievAQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b07ubKxHQi91GWoI2w4b+CouFvYHUUL+a9uGndZSErQTlYowFJLeiCVSNSMEJOIhf1RxKgGtfj4yKuU3bok1sjwPBk+kcs3dSRc5UGWXVs0IfBCBKbn86TrHgGjrmbnMZQA0oUaaKAJlFHydfYnndECeKUvAYH3WQC5ZV7aFbfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=m0hOtV3R; arc=none smtp.client-ip=44.245.243.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1759482211; x=1791018211;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R53udJ/Bwhc5LJsFCV4Fcn4Db8eU4XSezxWONzLc/Iw=;
  b=m0hOtV3RsGF+knvW4hJJeKsPRmtqric9G5Sryrn+HPxwDrfK5MFP9pPu
   UqoTFmEPf4GSJxoXdp3QJ8cbchAmlwSCVDvEtiKNyOihqu5GwjnYM3hqP
   E8e2harlr1OZdxdnF+E/CnwAn4rZJPgSnbd/eonhLNYsWCHiWDSZv8lqJ
   apSiDrLawsfgOeguCcrFhYQcPh/49s8YUG826MW0H37rvpae6LFZy7aRl
   Zub5m+YGJxA8YVzgDPT2cjLNLnz+t7abPP4/AAr6FUH5fe8ao8nrC+DZW
   bfaCm6QUScZeBFSsz2uip24I4l0ynuF0Uiqb0C0WCdxaT/ZhOOgd0iQln
   w==;
X-CSE-ConnectionGUID: JbmNmWK0RlOcLU6UPh3vwg==
X-CSE-MsgGUID: 5x8eu3ipS52YAasc1TR2kQ==
X-IronPort-AV: E=Sophos;i="6.18,281,1751241600"; 
   d="scan'208";a="4212779"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2025 09:03:31 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:50300]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.32.215:2525] with esmtp (Farcaster)
 id 08837055-f124-4a21-8817-637d1c0a30bd; Fri, 3 Oct 2025 09:03:30 +0000 (UTC)
X-Farcaster-Flow-ID: 08837055-f124-4a21-8817-637d1c0a30bd
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Fri, 3 Oct 2025 09:03:30 +0000
Received: from dev-dsk-epetron-1c-1d4d9719.eu-west-1.amazon.com
 (10.253.109.105) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Fri, 3 Oct 2025
 09:03:28 +0000
From: Evangelos Petrongonas <epetron@amazon.de>
To: Bjorn Helgaas <bhelgaas@google.com>, Alex Williamson
	<alex.williamson@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>, "Len
 Brown" <lenb@kernel.org>
CC: Evangelos Petrongonas <epetron@amazon.de>, Pasha Tatashin
	<pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, "Vipin
 Sharma" <vipinsh@google.com>, Chris Li <chrisl@kernel.org>, Jason Miu
	<jasonmiu@google.com>, Pratyush Yadav <pratyush@kernel.org>, "Stanislav
 Spassov" <stanspas@amazon.de>, <linux-pci@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nh-open-source@amazon.com>
Subject: [RFC PATCH 05/13] pci: pcsc: control the cache via sysfs and kernel params
Date: Fri, 3 Oct 2025 09:00:41 +0000
Message-ID: <2a0e6b85b06fef2d77ddd6879dea4335aeb3021f.1759312886.git.epetron@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1759312886.git.epetron@amazon.de>
References: <cover.1759312886.git.epetron@amazon.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D040UWB002.ant.amazon.com (10.13.138.89) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add kernel parameters and runtime control mechanisms for the PCSC

A new kernel parameter 'pcsc_enabled' allows enabling or disabling
the cache at boot time. The parameter defaults to disabled.

A sysfs interface at /sys/bus/pci/pcsc/enabled provides:
- Read access to query current cache status (1=enabled, 0=disabled)
- Write access to dynamically enable/disable the cache at runtime

Signed-off-by: Evangelos Petrongonas <epetron@amazon.de>
---
 Documentation/ABI/testing/sysfs-bus-pci-pcsc  | 20 ++++
 .../admin-guide/kernel-parameters.txt         |  3 +
 drivers/pci/pcsc.c                            | 93 ++++++++++++++++++-
 3 files changed, 114 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-pci-pcsc

diff --git a/Documentation/ABI/testing/sysfs-bus-pci-pcsc b/Documentation/ABI/testing/sysfs-bus-pci-pcsc
new file mode 100644
index 000000000000..ee92bf087816
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-pci-pcsc
@@ -0,0 +1,20 @@
+PCI Configuration Space Cache (PCSC)
+-------------------------------------
+
+The PCI Configuration Space Cache (PCSC) is a transparent caching layer
+that intercepts configuration space operations to reduce hardware access
+overhead. This subsystem addresses performance bottlenecks in PCI
+configuration space accesses, particularly in virtualization
+environments with high-density SR-IOV deployments where repeated
+enumeration of Virtual Functions creates substantial delays.
+
+What:			/sys/bus/pci/pcsc/enabled
+Date:			September 2025
+Contact:		Linux PCI developers <linux-pci@vger.kernel.org>
+Description:
+				PCI Configuration Space Cache (PCSC) is a subsystem that
+				caches accesses to the PCI configuration space of PCI
+				functions. When this file contains the "1", the kernel
+				is utilizing the cache, while when on "0" the
+				system bypasses it. This setting can also be controlled
+parameter.
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 747a55abf494..08c7a13f107c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5036,6 +5036,9 @@
 
 	pcmv=		[HW,PCMCIA] BadgePAD 4
 
+	pcsc_enabled=	[PCSC] enable the use of the PCI Configuration Space
+		Cache (PCSC).
+
 	pd_ignore_unused
 			[PM]
 			Keep all power-domains already enabled by bootloader on,
diff --git a/drivers/pci/pcsc.c b/drivers/pci/pcsc.c
index 343f8b03831a..44d842733230 100644
--- a/drivers/pci/pcsc.c
+++ b/drivers/pci/pcsc.c
@@ -16,13 +16,21 @@
 
 #include <linux/atomic.h>
 #include <linux/pcsc.h>
+#include <linux/sysfs.h>
+
+static bool pcsc_enabled;
+static int __init pcsc_enabled_setup(char *str)
+{
+	return kstrtobool(str, &pcsc_enabled) == 0;
+}
+__setup("pcsc_enabled=", pcsc_enabled_setup);
 
 static bool pcsc_initialised;
 static atomic_t num_nodes = ATOMIC_INIT(0);
 
 inline bool pcsc_is_initialised(void)
 {
-	return pcsc_initialised;
+	return pcsc_initialised && pcsc_enabled;
 }
 
 static int pcsc_add_bus(struct pci_bus *bus)
@@ -899,14 +907,95 @@ static struct notifier_block pcsc_bus_nb = {
 	.notifier_call = pcsc_bus_notify,
 };
 
+static ssize_t pcsc_enabled_show(struct kobject *kobj,
+				 struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%d\n", pcsc_enabled);
+}
+
+static ssize_t pcsc_enabled_store(struct kobject *kobj,
+				  struct kobj_attribute *attr, const char *buf,
+				  size_t count)
+{
+	bool new_value;
+	int ret;
+
+	ret = kstrtobool(buf, &new_value);
+	if (ret < 0)
+		return ret;
+
+	pcsc_enabled = new_value;
+	return count;
+}
+
+static struct kobj_attribute pcsc_enabled_attribute =
+	__ATTR(enabled, 0644, pcsc_enabled_show, pcsc_enabled_store);
+
+static struct attribute *pcsc_attrs[] = {
+	&pcsc_enabled_attribute.attr,
+	NULL,
+};
+
+static struct attribute_group pcsc_attr_group = {
+	.attrs = pcsc_attrs,
+};
+
+static struct kobject *pcsc_kobj;
+
+static void pcsc_create_sysfs(void)
+{
+	struct kset *pci_bus_kset;
+	int ret;
+
+	if (pcsc_kobj)
+		return; /* Already created */
+
+	pci_bus_kset = bus_get_kset(&pci_bus_type);
+	if (!pci_bus_kset) {
+		/* PCI bus kset not ready yet, will be retried later */
+		return;
+	}
+
+	pcsc_kobj = kobject_create_and_add("pcsc", &pci_bus_kset->kobj);
+	if (!pcsc_kobj) {
+		pr_err("Failed to create sysfs kobject\n");
+		return;
+	}
+
+	ret = sysfs_create_group(pcsc_kobj, &pcsc_attr_group);
+	if (ret) {
+		pr_err("Failed to create sysfs group\n");
+		kobject_put(pcsc_kobj);
+		pcsc_kobj = NULL;
+		return;
+	}
+}
+
 static int __init pcsc_init(void)
 {
 	bus_register_notifier(&pci_bus_type, &pcsc_bus_nb);
 
+	/* Try to create sysfs entry, but don't fail if PCI bus isn't ready yet */
+	pcsc_create_sysfs();
+
 	pcsc_initialised = true;
-	pr_info("initialised\n");
+	pr_info("initialised (enabled=%d)\n", pcsc_enabled);
 
 	return 0;
 }
 
+/* Late initcall to retry sysfs creation if it failed during core_initcall */
+static int __init pcsc_sysfs_init(void)
+{
+	pcsc_create_sysfs();
+	return 0;
+}
+
 core_initcall(pcsc_init);
+
+/*
+ * The PCI subsystem is initialised later, therefore we need to add
+ * our sysfs entries later. This is done to avoid modifying the sysfs
+ * creation of the core pci driver.
+ */
+late_initcall(pcsc_sysfs_init);
-- 
2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


