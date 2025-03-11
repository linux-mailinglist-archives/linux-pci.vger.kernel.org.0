Return-Path: <linux-pci+bounces-23434-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B006A5C42D
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 15:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B8911885CEE
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 14:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186CE257AF7;
	Tue, 11 Mar 2025 14:46:17 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFA225C70D
	for <linux-pci@vger.kernel.org>; Tue, 11 Mar 2025 14:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741704377; cv=none; b=Zab5k+Gcy9MDvc2WIy0bE9G2tt2xaFNFBREaA710bGIARRZwdQos1q4osY6UjoYafG02SpYOR4V976bOSX3/U7YB+pAkWlMpCZQigxWOik971glr7nCoNBs2S07kLa6Ho9KxUxYVjpjSV226mrLkJLRNceBEMPh5/cWTJgiGv0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741704377; c=relaxed/simple;
	bh=x//dKC9oGUFGVKaiveq/8PxZA285XCr2A7hIamJNYYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GpdIQlZB+wkSvY5iadzREoWFodh30+cfyrCiE8oh+GFniy/Amq9Pz3r2ld+vmmK6hl8M/Tw0EVDxgJEcGfbK2Wv7Pou9ZXtpcUTwU7Wv7MfF9t59pl7M37c3BcuOkqEABtaycUSkqRLgUSiO+FHKMs1EBTNaU1B0KxOtD11N9GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE5771692;
	Tue, 11 Mar 2025 07:46:25 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 597B23F694;
	Tue, 11 Mar 2025 07:46:13 -0700 (PDT)
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: lpieralisi@kernel.org,
	robin.murphy@arm.com,
	aneesh.kumar@kernel.org,
	linux-coco@lists.linux.dev,
	bhelgaas@google.com,
	lukas@wunner.de,
	sameo@rivosinc.com,
	aik@amd.com,
	yilun.xu@linux.intel.com,
	linux-pci@vger.kernel.org,
	Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [RESEND RFC PATCH 3/3] samples: devsec: Add support for PCI_DOMAINS_GENERIC
Date: Tue, 11 Mar 2025 14:46:01 +0000
Message-ID: <20250311144601.145736-3-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250311144601.145736-1-suzuki.poulose@arm.com>
References: <20250311141712.145625-1-suzuki.poulose@arm.com>
 <20250311144601.145736-1-suzuki.poulose@arm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allocate/free a domain at runtime for the sample devsec TSM.

Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 samples/Kconfig         |  1 -
 samples/devsec/bus.c    | 32 +++++++++++++++++++++-----------
 samples/devsec/common.c |  2 +-
 samples/devsec/devsec.h |  2 +-
 4 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/samples/Kconfig b/samples/Kconfig
index 6bd64fc54ac1..f23be5088b9e 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -308,7 +308,6 @@ config SAMPLE_DEVSEC
 	tristate "Build a sample TEE Security Manager with an emulated PCI endpoint"
 	depends on PCI
 	depends on VIRT_DRIVERS
-	depends on X86 # TODO: PCI_DOMAINS_GENERIC support
 	select PCI_BRIDGE_EMUL
 	select PCI_TSM
 	select TSM
diff --git a/samples/devsec/bus.c b/samples/devsec/bus.c
index b78c04b21eb9..8ec04b3549f0 100644
--- a/samples/devsec/bus.c
+++ b/samples/devsec/bus.c
@@ -21,7 +21,7 @@
 #define NR_DEVSEC_DEVS 1
 
 struct devsec {
-	struct pci_sysdata sysdata;
+	int domain;
 	struct gen_pool *iomem_pool;
 	struct resource resource[2];
 	struct pci_bus *bus;
@@ -70,7 +70,7 @@ struct devsec {
 
 static struct devsec *bus_to_devsec(struct pci_bus *bus)
 {
-	return container_of(bus->sysdata, struct devsec, sysdata);
+	return container_of(bus->sysdata, struct devsec, domain);
 }
 
 static int devsec_dev_config_read(struct devsec *devsec, struct pci_bus *bus,
@@ -309,6 +309,17 @@ static struct pci_ops devsec_ops = {
 };
 
 /* borrowed from vmd_find_free_domain() */
+#ifdef CONFIG_PCI_GENERIC_DOMAINS
+static int find_free_domain(void)
+{
+	return pci_alloc_dynamic_domain();
+}
+
+static int release_domain(int domain)
+{
+	pci_free_dynamic_domain(domain);
+}
+#else
 static int find_free_domain(void)
 {
 	int domain = 0xffff;
@@ -318,13 +329,15 @@ static int find_free_domain(void)
 		domain = max_t(int, domain, pci_domain_nr(bus));
 	return domain + 1;
 }
-
+static void release_domain(int domain) {}
+#endif
 static void destroy_bus(void *data)
 {
 	struct devsec *devsec = data;
 
 	pci_stop_root_bus(devsec->bus);
 	pci_remove_root_bus(devsec->bus);
+	release_domain(devsec->domain);
 }
 
 static u32 build_ext_cap_header(u32 id, u32 ver, u32 next)
@@ -588,7 +601,6 @@ static int __init devsec_bus_probe(struct platform_device *pdev)
 	int rc;
 	LIST_HEAD(resources);
 	struct devsec *devsec;
-	struct pci_sysdata *sd;
 	u64 mmio_size = SZ_64G;
 	struct pci_host_bridge *hb;
 	struct device *dev = &pdev->dev;
@@ -633,15 +645,13 @@ static int __init devsec_bus_probe(struct platform_device *pdev)
 	};
 	pci_add_resource(&resources, &devsec->resource[1]);
 
-	sd = &devsec->sysdata;
-	devsec_sysdata = sd;
-	sd->domain = find_free_domain();
-	if (sd->domain < 0)
-		return sd->domain;
-
+	devsec_sysdata = &devsec->domain;
+	devsec->domain = find_free_domain();
+	if (devsec->domain < 0)
+		return devsec->domain;
 
 	devsec->bus = pci_create_root_bus(dev, 0, &devsec_ops,
-					  &devsec->sysdata, &resources);
+					  &devsec->domain, &resources);
 	if (!devsec->bus) {
 		pci_free_resource_list(&resources);
 		return -ENOMEM;
diff --git a/samples/devsec/common.c b/samples/devsec/common.c
index 9b6f4022f241..4da85b53b6a9 100644
--- a/samples/devsec/common.c
+++ b/samples/devsec/common.c
@@ -8,7 +8,7 @@
  * devsec_bus and devsec_tsm need a common location for this data to
  * avoid depending on each other. Enables load order testing
  */
-struct pci_sysdata *devsec_sysdata;
+void *devsec_sysdata;
 EXPORT_SYMBOL_GPL(devsec_sysdata);
 
 static int __init common_init(void)
diff --git a/samples/devsec/devsec.h b/samples/devsec/devsec.h
index 794a9898ee2d..496020c9cb6d 100644
--- a/samples/devsec/devsec.h
+++ b/samples/devsec/devsec.h
@@ -3,5 +3,5 @@
 
 #ifndef __DEVSEC_H__
 #define __DEVSEC_H__
-extern struct pci_sysdata *devsec_sysdata;
+extern void *devsec_sysdata;
 #endif /* __DEVSEC_H__ */
-- 
2.43.0


