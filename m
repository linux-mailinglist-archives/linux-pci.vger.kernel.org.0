Return-Path: <linux-pci+bounces-22492-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7DCA4735E
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 04:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 667F216FB5A
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 03:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09DF1AF0C5;
	Thu, 27 Feb 2025 03:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="bRCxjeo4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="58SeoT9b"
X-Original-To: linux-pci@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FBB1A5B98;
	Thu, 27 Feb 2025 03:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740625851; cv=none; b=nOF6AD7YMkj6pH2DueVEWf14BedKwlkc4tZrSiedXfFvVBn2OB8wQLEXUo5TjkaklT9vfqNKJwmkF7/jjcefLx/zB/F9vggzi2Fo+oNL5q13HvswfZMsVv2TmjjuRieJVS4HPNk4tjYp2JjyK2LHTdpK95cfFrSs6m/uPqdDYMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740625851; c=relaxed/simple;
	bh=F+Lr1xfu683HdbPEJ94aSnfTkngI44RHtI/lbJR5LkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=quTEx1c9F8wqN2tcvsOi13ROzQFjiVfvSCVKZdzKhctQsbwstTZsVkDP9+R5Dhex7vxScC4sGvxhGOPz+55EI0iQ3ix0fOHwEgGIxMHu+kr/Bv100wEbjQA/q4wqeKTpKFkE5YU312bxyj9srTYwJROJhBD7H37e7bG95kTTdq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=bRCxjeo4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=58SeoT9b; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 578E22540200;
	Wed, 26 Feb 2025 22:10:48 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 26 Feb 2025 22:10:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1740625848; x=
	1740712248; bh=f29hxzv4zGLQyokSaZ9Juyb4oTZBi+oHaB95+TG/kAk=; b=b
	RCxjeo4HUL5OwYaVc9mIsMd9glHe98GhRn8z9GFWdpJTIz32pEZbZfHobpPzJ6Fh
	ZBVrTtzaBfY+RWZ7LRXwkn7ZMQ+GLDstlpwTpIaBzlQlsClt6jDqCJdnuyipB09R
	z/HUS7wnnRuqamnHPw9hy1CFF6KDkdaMAF1Al2hZXrs8bZg6z/smojMDToOARl62
	lX45TqZEkR0krUU/HH6cu6lfMIRn03HGteowLgY4ew+p7LuOm9h2CxN1xhvcC5Bj
	AtUNKYyX8G3cL/oYlfDkQiBpU9t25AycwNbNB9vNmmM/vXa4UBcWppthiUZ+pHOR
	QZnUv90cFhP7g5FlRGhgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1740625848; x=1740712248; bh=f
	29hxzv4zGLQyokSaZ9Juyb4oTZBi+oHaB95+TG/kAk=; b=58SeoT9bZYsSKv5YN
	MJhrqP+rcTJWVLFTmfcAug5PpsQ66f+HMlP18+QYOsBfltcotBEo/orvOJVXNra3
	eyNIpNnQe+ilQiY4pq1/Fugt15Taai0sKx4HvXNYGQhn+U8wPXFqn1ql9SDCd5Z0
	JRvTl0vZegXNb0gc2LLhF1uKaW69zHKhGgnObSZG72m78wuI9w8ubOZ4OqO3NBCI
	Q83RDHCyzbNkLjGYRliKW1YfbdSPdqRbKomuwZxZxDzgC4HxFuDrXQkLPGeN4/9z
	bnAyjkxfLcv+6iqEeT7wFHITIMJJGTwVt3RlYvyXaYzRP6f/xKfv4px/ZCrUXQky
	lElvw==
X-ME-Sender: <xms:uNe_Z0JePtrR1S6kDQ1AgLrg4amYwYdPiw6bzWSwfDN1WGpNYSJVug>
    <xme:uNe_Z0KKC14uxO13vvkoxeyJUQaVdu_mYKzMAzVeAzE5X_T_n-g36kg-8hs9fWzFX
    ts94XHErTSM3hyb_wA>
X-ME-Received: <xmr:uNe_Z0uCWRGuAs6o9ewJUd0Ru44NtI_rc25-iPe-nQlg5Wn3CCK0KcbKDwT85TMKRPNTSQk8FeM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekieefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecuogfuohhrthgvugftvg
    gtihhpvdculdegtddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttden
    ucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgrihhrsegrlh
    hishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeekhfetjeduudejudeljefg
    jedtgeeiudefhfeugeeiteehfefftedvfedvheevtdenucffohhmrghinhepughmthhfrd
    horhhgpdhkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvgdpnh
    gspghrtghpthhtohepudelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhn
    uhigqdgtgihlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugi
    dqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgr
    shesfihunhhnvghrrdguvgdprhgtphhtthhopehlihhnuhigqdhptghisehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepsghhvghlghgrrghssehgohhoghhlvgdrtgho
    mhdprhgtphhtthhopehjohhnrghthhgrnhdrtggrmhgvrhhonheshhhurgifvghirdgtoh
    hmpdhrtghpthhtoheprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdroh
    hrghdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:uNe_ZxZIMzqDYiGEk1f6y6Ds6UjxbW49ht69KhSd5ZdR_MWWE4bvVg>
    <xmx:uNe_Z7Y5JZ80Htt5GuXLSzMAvIqCvBSRlHCwc4rTt--JgSaMv1-IVg>
    <xmx:uNe_Z9CyYb3d24a7hoolJ35eDO-EblnaK5yG1Ad9f6vdrSZXKdTwYQ>
    <xmx:uNe_ZxaUnRNuMgjke2jU8aqCm2-6rVM32ltz59frIM9UqqiSk1yzfw>
    <xmx:uNe_Z_OMVlbsk9DLFMFZ3jPWQJMqI1H2ZksjVEKYoHJkBQFwej6pS4qR>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 22:10:42 -0500 (EST)
From: Alistair Francis <alistair@alistair23.me>
To: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lukas@wunner.de,
	linux-pci@vger.kernel.org,
	bhelgaas@google.com,
	Jonathan.Cameron@huawei.com,
	rust-for-linux@vger.kernel.org,
	akpm@linux-foundation.org
Cc: boqun.feng@gmail.com,
	bjorn3_gh@protonmail.com,
	wilfred.mallawa@wdc.com,
	aliceryhl@google.com,
	ojeda@kernel.org,
	alistair23@gmail.com,
	a.hindborg@kernel.org,
	tmgross@umich.edu,
	gary@garyguo.net,
	alex.gaynor@gmail.com,
	benno.lossin@proton.me
Subject: [RFC v2 06/20] PCI/CMA: Authenticate devices on enumeration
Date: Thu, 27 Feb 2025 13:09:38 +1000
Message-ID: <20250227030952.2319050-7-alistair@alistair23.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227030952.2319050-1-alistair@alistair23.me>
References: <20250227030952.2319050-1-alistair@alistair23.me>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Component Measurement and Authentication (CMA, PCIe r6.2 sec 6.31)
allows for measurement and authentication of PCIe devices.  It is
based on the Security Protocol and Data Model specification (SPDM,
https://www.dmtf.org/dsp/DSP0274).

CMA-SPDM in turn forms the basis for Integrity and Data Encryption
(IDE, PCIe r6.2 sec 6.33) because the key material used by IDE is
transmitted over a CMA-SPDM session.

As a first step, authenticate CMA-capable devices on enumeration.
A subsequent commit will expose the result in sysfs.

When allocating SPDM session state with spdm_create(), the maximum SPDM
message length needs to be passed.  Make the PCI_DOE_MAX_LENGTH macro
public and calculate the maximum payload length from it.

Credits:  Jonathan wrote a proof-of-concept of this CMA implementation.
Lukas reworked it for upstream.  Wilfred contributed fixes for issues
discovered during testing.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Co-developed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Co-developed-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 MAINTAINERS             |   1 +
 drivers/pci/Kconfig     |  13 ++++++
 drivers/pci/Makefile    |   2 +
 drivers/pci/cma.c       | 101 ++++++++++++++++++++++++++++++++++++++++
 drivers/pci/doe.c       |   3 --
 drivers/pci/pci.h       |   8 ++++
 drivers/pci/probe.c     |   1 +
 drivers/pci/remove.c    |   1 +
 include/linux/pci-doe.h |   4 ++
 include/linux/pci.h     |   4 ++
 10 files changed, 135 insertions(+), 3 deletions(-)
 create mode 100644 drivers/pci/cma.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 0f37dbdcfd77..abb3b603299f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21385,6 +21385,7 @@ L:	linux-cxl@vger.kernel.org
 L:	linux-pci@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/devsec/spdm.git
+F:	drivers/pci/cma.c
 F:	include/linux/spdm.h
 F:	lib/rspdm/
 
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 2fbd379923fd..80954adbff7d 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -121,6 +121,19 @@ config XEN_PCIDEV_FRONTEND
 config PCI_ATS
 	bool
 
+config PCI_CMA
+	bool "Component Measurement and Authentication (CMA-SPDM)"
+	select CRYPTO_ECDSA
+	select CRYPTO_RSA
+	select CRYPTO_SHA256
+	select CRYPTO_SHA512
+	select PCI_DOE
+	select RSPDM
+	help
+	  Authenticate devices on enumeration per PCIe r6.2 sec 6.31.
+	  A PCI DOE mailbox is used as transport for DMTF SPDM based
+	  authentication, measurement and secure channel establishment.
+
 config PCI_DOE
 	bool
 
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 67647f1880fb..3cbf2c226a2d 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -38,6 +38,8 @@ obj-$(CONFIG_PCI_DYNAMIC_OF_NODES) += of_property.o
 obj-$(CONFIG_PCI_NPEM)		+= npem.o
 obj-$(CONFIG_PCIE_TPH)		+= tph.o
 
+obj-$(CONFIG_PCI_CMA)		+= cma.o
+
 # Endpoint library must be initialized before its users
 obj-$(CONFIG_PCI_ENDPOINT)	+= endpoint/
 
diff --git a/drivers/pci/cma.c b/drivers/pci/cma.c
new file mode 100644
index 000000000000..7463cd1179f0
--- /dev/null
+++ b/drivers/pci/cma.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Component Measurement and Authentication (CMA-SPDM, PCIe r6.2 sec 6.31)
+ *
+ * Copyright (C) 2021 Huawei
+ *     Jonathan Cameron <Jonathan.Cameron@huawei.com>
+ *
+ * Copyright (C) 2022-24 Intel Corporation
+ */
+
+#define dev_fmt(fmt) "CMA: " fmt
+
+#include <linux/pci.h>
+#include <linux/pci-doe.h>
+#include <linux/pm_runtime.h>
+#include <linux/spdm.h>
+
+#include "pci.h"
+
+/* Keyring that userspace can poke certs into */
+static struct key *pci_cma_keyring;
+
+#define PCI_DOE_FEATURE_CMA 1
+
+static ssize_t pci_doe_transport(void *priv, struct device *dev,
+				 const void *request, size_t request_sz,
+				 void *response, size_t response_sz)
+{
+	struct pci_doe_mb *doe = priv;
+	ssize_t rc;
+
+	/*
+	 * CMA-SPDM operation in non-D0 states is optional (PCIe r6.2
+	 * sec 6.31.3).  The spec does not define a way to determine
+	 * if it's supported, so resume to D0 unconditionally.
+	 */
+	rc = pm_runtime_resume_and_get(dev);
+	if (rc)
+		return rc;
+
+	rc = pci_doe(doe, PCI_VENDOR_ID_PCI_SIG, PCI_DOE_FEATURE_CMA,
+		     request, request_sz, response, response_sz);
+
+	pm_runtime_put(dev);
+
+	return rc;
+}
+
+void pci_cma_init(struct pci_dev *pdev)
+{
+	struct pci_doe_mb *doe;
+
+	if (IS_ERR(pci_cma_keyring))
+		return;
+
+	if (!pci_is_pcie(pdev))
+		return;
+
+	doe = pci_find_doe_mailbox(pdev, PCI_VENDOR_ID_PCI_SIG,
+				   PCI_DOE_FEATURE_CMA);
+	if (!doe)
+		return;
+
+	pdev->spdm_state = spdm_create(&pdev->dev, pci_doe_transport, doe,
+				       PCI_DOE_MAX_PAYLOAD, pci_cma_keyring,
+				       NULL);
+	if (!pdev->spdm_state)
+		return;
+
+	/*
+	 * Keep spdm_state allocated even if initial authentication fails
+	 * to allow for provisioning of certificates and reauthentication.
+	 */
+	spdm_authenticate(pdev->spdm_state);
+}
+
+void pci_cma_destroy(struct pci_dev *pdev)
+{
+	if (!pdev->spdm_state)
+		return;
+
+	spdm_destroy(pdev->spdm_state);
+}
+
+__init static int pci_cma_keyring_init(void)
+{
+	pci_cma_keyring = keyring_alloc(".cma", KUIDT_INIT(0), KGIDT_INIT(0),
+					current_cred(),
+					(KEY_POS_ALL & ~KEY_POS_SETATTR) |
+					KEY_USR_VIEW | KEY_USR_READ |
+					KEY_USR_WRITE | KEY_USR_SEARCH,
+					KEY_ALLOC_NOT_IN_QUOTA |
+					KEY_ALLOC_SET_KEEP, NULL, NULL);
+	if (IS_ERR(pci_cma_keyring)) {
+		pr_err("PCI: Could not allocate .cma keyring\n");
+		return PTR_ERR(pci_cma_keyring);
+	}
+
+	return 0;
+}
+arch_initcall(pci_cma_keyring_init);
diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index 7bd7892c5222..8ea37698082a 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -31,9 +31,6 @@
 #define PCI_DOE_FLAG_CANCEL	0
 #define PCI_DOE_FLAG_DEAD	1
 
-/* Max data object length is 2^18 dwords */
-#define PCI_DOE_MAX_LENGTH	(1 << 18)
-
 /**
  * struct pci_doe_mb - State for a single DOE mailbox
  *
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 01e51db8d285..69ba2ae9a0cd 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -448,6 +448,14 @@ static inline void pci_doe_destroy(struct pci_dev *pdev) { }
 static inline void pci_doe_disconnected(struct pci_dev *pdev) { }
 #endif
 
+#ifdef CONFIG_PCI_CMA
+void pci_cma_init(struct pci_dev *pdev);
+void pci_cma_destroy(struct pci_dev *pdev);
+#else
+static inline void pci_cma_init(struct pci_dev *pdev) { }
+static inline void pci_cma_destroy(struct pci_dev *pdev) { }
+#endif
+
 #ifdef CONFIG_PCI_NPEM
 void pci_npem_create(struct pci_dev *dev);
 void pci_npem_remove(struct pci_dev *dev);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 246744d8d268..edf06055e805 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2565,6 +2565,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	pci_rcec_init(dev);		/* Root Complex Event Collector */
 	pci_doe_init(dev);		/* Data Object Exchange */
 	pci_tph_init(dev);		/* TLP Processing Hints */
+	pci_cma_init(dev);		/* Component Measurement & Auth */
 
 	pcie_report_downtraining(dev);
 	pci_init_reset_methods(dev);
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index efc37fcb73e2..e6feab4e3c61 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -61,6 +61,7 @@ static void pci_destroy_dev(struct pci_dev *dev)
 	list_del(&dev->bus_list);
 	up_write(&pci_bus_sem);
 
+	pci_cma_destroy(dev);
 	pci_doe_destroy(dev);
 	pcie_aspm_exit_link_state(dev);
 	pci_bridge_d3_update(dev);
diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
index 1f14aed4354b..0d3d7656c456 100644
--- a/include/linux/pci-doe.h
+++ b/include/linux/pci-doe.h
@@ -15,6 +15,10 @@
 
 struct pci_doe_mb;
 
+/* Max data object length is 2^18 dwords (including 2 dwords for header) */
+#define PCI_DOE_MAX_LENGTH	(1 << 18)
+#define PCI_DOE_MAX_PAYLOAD	((PCI_DOE_MAX_LENGTH - 2) * sizeof(u32))
+
 struct pci_doe_mb *pci_find_doe_mailbox(struct pci_dev *pdev, u16 vendor,
 					u8 type);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 47b31ad724fa..50c43546a32b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -39,6 +39,7 @@
 #include <linux/io.h>
 #include <linux/resource_ext.h>
 #include <linux/msi_api.h>
+#include <linux/spdm.h>
 #include <uapi/linux/pci.h>
 
 #include <linux/pci_ids.h>
@@ -528,6 +529,9 @@ struct pci_dev {
 #ifdef CONFIG_PCI_DOE
 	struct xarray	doe_mbs;	/* Data Object Exchange mailboxes */
 #endif
+#ifdef CONFIG_PCI_CMA
+	struct spdm_state *spdm_state;	/* Security Protocol and Data Model */
+#endif
 #ifdef CONFIG_PCI_NPEM
 	struct npem	*npem;		/* Native PCIe Enclosure Management */
 #endif
-- 
2.48.1


