Return-Path: <linux-pci+bounces-22495-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8A4A47364
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 04:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDDE6170C9E
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 03:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEBBD1B21B5;
	Thu, 27 Feb 2025 03:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="iz5sNTtl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ODYVQRb6"
X-Original-To: linux-pci@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC4E1991CA;
	Thu, 27 Feb 2025 03:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740625873; cv=none; b=Fi8hziTMNn4j+zWdCfPihsrrsKji60hdrF3UmQgnIQIQlBwpMkVlD3XDrpzxWg7Cvj9x76cq0N337FHGx+tsB99ZXYY+O/YpMCdN5vLJLHUjz0/69a86e+e9YX1jAAshqgIxI7+kRUxDhWgBV4bRSHPsqThwu7eeoTbITFCQK5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740625873; c=relaxed/simple;
	bh=n+K3oafg8CG2dxmfeKMDA2RDUurNVL0dn+ZVYcpRiLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rk95C1lcFkAAemPN4kP/qfu24LBvZi3HFtS5ZBuu+EYhzC09a/HR7cpqdW6s6SSE+BzD0usdQQISEUXkEuzsqhwwFw84QsqoBkVZrukuv5qb8f7q/+iRdjFdwWJAka077pWGpFF4afpRz1aQ5J+nFxpHgAZQ8DNQc2nripNPwc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=iz5sNTtl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ODYVQRb6; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 788B111400A8;
	Wed, 26 Feb 2025 22:11:10 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 26 Feb 2025 22:11:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1740625870; x=
	1740712270; bh=kEdrbCf5Rp7ZMtPW8kXeQ3LNTbh3Bi8xDHDXhTg3O/s=; b=i
	z5sNTtlaPQX9td1Ot30mYUQzq9NnPJQIXN7KQpWdmxAntP9rGHFO8hrJMO9VHk45
	hKOPt1BUL7of8JlCpoaL147wy0lcTNchk8d9TjBCRgtiZxux9Gsiq/IfdF4oyUpH
	bcqM90rkXhO3Klcc99xJuPN5B4Wm7xZSPWk7BI6pL19cKm1iWfUW7as6SYubwmYl
	CpDNqJN1OPyKm4vlDalFHvNN2apjUHnPopCxoNrGFRoY+Qp2LzeyOn8DYQ5gLSHA
	B86zhlU4TXuycDSBzQu6oZ0tPoK5UF1CQrLRkIsLnO/7WuvD+uZzzZ+jEVoaPjq4
	hOE+n7EcaRUvfikrBC5zA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1740625870; x=1740712270; bh=k
	EdrbCf5Rp7ZMtPW8kXeQ3LNTbh3Bi8xDHDXhTg3O/s=; b=ODYVQRb6NFNItMdGx
	y5fuwCgHEdOYs8TxCWtsPA4yOiD401kzL1ZMEIeK7J+rr8Gr/jdNeWvQuy/EVMa2
	Knq70a2mnkcBs0G4Ikg6pCS7P+VOXiZyokMp8oISIISnXoiJACbC9t1ZJDTy4QzO
	yuuZjUKNlTchYIG/qXJxyYTG+FUfYRwM+V3BGRGOYrCSSaXw7qmoSouUsAx7Bkrz
	A7blRlcRS5En90Hs8Z09QVVxk5ABPuTRaIkFX/FOLaTIZxLqIrh6hlFkLonqFYpo
	gZKa4Xpf8RaPgrK1b2CcdrE79zzHZMTgVyQFy7B8rw4N7Wb3LCnj62Y8jK7xHHnl
	JLz8A==
X-ME-Sender: <xms:zte_Z7N7JLDmQhh6Y7oRiNHmbIfgdSWGM1mX6n_-QgwZBrnITJnMEg>
    <xme:zte_Z1-ZpVEFli2UCcqS8vmQBiQwnGwn-Q-mEbVd-vHdhVJR2FElJ7H8TJBgo38yy
    ZbuVFu88_WxD-ucDC4>
X-ME-Received: <xmr:zte_Z6T_QUiD0E0ShotWYJ-7upIy8fzmyNTN72iBW8zLT757ImBx-meoQhsEDyRyCjuRA_hzxHo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekieefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecuogfuohhrthgvugftvg
    gtihhpvdculdegtddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttden
    ucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgrihhrsegrlh
    hishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeevfefhudefheehgfetheeu
    feeuteefheejtdekvdeugfdvtdevieefjeeklefgveenucffohhmrghinhepkhgvrhhnvg
    hlrdhorhhgpdgumhhtfhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvgdpnh
    gspghrtghpthhtohepvddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhn
    uhigqdgtgihlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugi
    dqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgr
    shesfihunhhnvghrrdguvgdprhgtphhtthhopehlihhnuhigqdhptghisehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepsghhvghlghgrrghssehgohhoghhlvgdrtgho
    mhdprhgtphhtthhopehjohhnrghthhgrnhdrtggrmhgvrhhonheshhhurgifvghirdgtoh
    hmpdhrtghpthhtoheprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdroh
    hrghdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:zte_Z_uc2jeJ_YKCcxAWDCzMOWdEV3d7eorapEmB3c-kkBUWizR3cw>
    <xmx:zte_Zzcdxs6HvkYbDCSLdZm1-3ZYGdt2ojwXzmIMQzDYHAoTOmwbhA>
    <xmx:zte_Z712NCpnxSdVpjkBc8O4UTW-IIijYKlgvOE_hgwHtAdbPejKbg>
    <xmx:zte_Z__t3enajATAC9Nt4dCisDaee7Aeo9COJol3O0CFwK8ecki8uQ>
    <xmx:zte_Z5-FqhpVoNOzp-Q6CiQy1cWilTAY1Zd-mIfGEsjB7VE9ccUhS4is>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 22:11:03 -0500 (EST)
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
	benno.lossin@proton.me,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [RFC v2 09/20] PCI/CMA: Expose in sysfs whether devices are authenticated
Date: Thu, 27 Feb 2025 13:09:41 +1000
Message-ID: <20250227030952.2319050-10-alistair@alistair23.me>
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

From: Lukas Wunner <lukas@wunner.de>

The PCI core has just been amended to authenticate CMA-capable devices
on enumeration and store the result in an "authenticated" bit in struct
pci_dev->spdm_state.

Expose the bit to user space through an eponymous sysfs attribute.

Allow user space to trigger reauthentication (e.g. after it has updated
the CMA keyring) by writing to the sysfs attribute.

Implement the attribute in the SPDM library so that other bus types
besides PCI may take advantage of it.  They just need to add
spdm_attr_group to the attribute groups of their devices and amend the
dev_to_spdm_state() helper which retrieves the spdm_state for a given
device.

The helper may return an ERR_PTR if it couldn't be determined whether
SPDM is supported by the device.  The sysfs attribute is visible in that
case but returns an error on access.  This prevents downgrade attacks
where an attacker disturbs memory allocation or DOE communication
in order to create the appearance that SPDM is unsupported.

Subject to further discussion, a future commit might add a user-defined
policy to forbid driver binding to devices which failed authentication,
similar to the "authorized" attribute for USB.

Alternatively, authentication success might be signaled to user space
through a uevent, whereupon it may bind a (blacklisted) driver.
A uevent signaling authentication failure might similarly cause user
space to unbind or outright remove the potentially malicious device.

Traffic from devices which failed authentication could also be filtered
through ACS I/O Request Blocking Enable (PCIe r6.2 sec 7.7.11.3) or
through Link Disable (PCIe r6.2 sec 7.5.3.7).  Unlike an IOMMU, that
will not only protect the host, but also prevent malicious peer-to-peer
traffic to other devices.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
[ Changes by AF:
 - Drop lib/spdm changes and replace with Rust implementation
]
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 Documentation/ABI/testing/sysfs-devices-spdm | 31 +++++++
 MAINTAINERS                                  |  3 +-
 drivers/pci/cma.c                            | 12 ++-
 drivers/pci/doe.c                            |  2 +
 drivers/pci/pci-sysfs.c                      |  3 +
 drivers/pci/pci.h                            |  5 +
 include/linux/pci.h                          | 12 +++
 lib/rspdm/Makefile                           |  1 +
 lib/rspdm/lib.rs                             |  1 +
 lib/rspdm/req-sysfs.c                        | 97 ++++++++++++++++++++
 lib/rspdm/sysfs.rs                           | 28 ++++++
 11 files changed, 190 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-spdm
 create mode 100644 lib/rspdm/req-sysfs.c
 create mode 100644 lib/rspdm/sysfs.rs

diff --git a/Documentation/ABI/testing/sysfs-devices-spdm b/Documentation/ABI/testing/sysfs-devices-spdm
new file mode 100644
index 000000000000..2d6e5d513231
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-devices-spdm
@@ -0,0 +1,31 @@
+What:		/sys/devices/.../authenticated
+Date:		June 2024
+Contact:	Lukas Wunner <lukas@wunner.de>
+Description:
+		This file contains 1 if the device authenticated successfully
+		with SPDM (Security Protocol and Data Model).  It contains 0 if
+		the device failed authentication (and may thus be malicious).
+
+		Writing "re" to this file causes reauthentication.
+		That may be opportune after updating the device keyring.
+		The device keyring of the PCI bus is named ".cma"
+		(Component Measurement and Authentication).
+
+		Reauthentication may also be necessary after device identity
+		has mutated, e.g. after downloading firmware to an FPGA device.
+
+		The file is not visible if authentication is unsupported
+		by the device.
+
+		If the kernel could not determine whether authentication is
+		supported because memory was low or communication with the
+		device was not working, the file is visible but accessing it
+		fails with error code ENOTTY.
+
+		This prevents downgrade attacks where an attacker consumes
+		memory or disturbs communication in order to create the
+		appearance that a device does not support authentication.
+
+		The reason why authentication support could not be determined
+		is apparent from "dmesg".  To re-probe authentication support
+		of PCI devices, exercise the "remove" and "rescan" attributes.
diff --git a/MAINTAINERS b/MAINTAINERS
index abb3b603299f..03e1076f915a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21385,7 +21385,8 @@ L:	linux-cxl@vger.kernel.org
 L:	linux-pci@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/devsec/spdm.git
-F:	drivers/pci/cma.c
+F:	Documentation/ABI/testing/sysfs-devices-spdm
+F:	drivers/pci/cma*
 F:	include/linux/spdm.h
 F:	lib/rspdm/
 
diff --git a/drivers/pci/cma.c b/drivers/pci/cma.c
index f2c435b04b92..59558714f143 100644
--- a/drivers/pci/cma.c
+++ b/drivers/pci/cma.c
@@ -171,8 +171,10 @@ void pci_cma_init(struct pci_dev *pdev)
 {
 	struct pci_doe_mb *doe;
 
-	if (IS_ERR(pci_cma_keyring))
+	if (IS_ERR(pci_cma_keyring)) {
+		pdev->spdm_state = ERR_PTR(-ENOTTY);
 		return;
+	}
 
 	if (!pci_is_pcie(pdev))
 		return;
@@ -185,8 +187,10 @@ void pci_cma_init(struct pci_dev *pdev)
 	pdev->spdm_state = spdm_create(&pdev->dev, pci_doe_transport, doe,
 				       PCI_DOE_MAX_PAYLOAD, pci_cma_keyring,
 				       pci_cma_validate);
-	if (!pdev->spdm_state)
+	if (!pdev->spdm_state) {
+		pdev->spdm_state = ERR_PTR(-ENOTTY);
 		return;
+	}
 
 	/*
 	 * Keep spdm_state allocated even if initial authentication fails
@@ -204,7 +208,7 @@ void pci_cma_init(struct pci_dev *pdev)
  */
 void pci_cma_reauthenticate(struct pci_dev *pdev)
 {
-	if (!pdev->spdm_state)
+	if (IS_ERR_OR_NULL(pdev->spdm_state))
 		return;
 
 	spdm_authenticate(pdev->spdm_state);
@@ -212,7 +216,7 @@ void pci_cma_reauthenticate(struct pci_dev *pdev)
 
 void pci_cma_destroy(struct pci_dev *pdev)
 {
-	if (!pdev->spdm_state)
+	if (IS_ERR_OR_NULL(pdev->spdm_state))
 		return;
 
 	spdm_destroy(pdev->spdm_state);
diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index 8ea37698082a..e4b609f613da 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -706,6 +706,7 @@ void pci_doe_init(struct pci_dev *pdev)
 		if (IS_ERR(doe_mb)) {
 			pci_err(pdev, "[%x] failed to create mailbox: %ld\n",
 				offset, PTR_ERR(doe_mb));
+			pci_cma_disable(pdev);
 			continue;
 		}
 
@@ -714,6 +715,7 @@ void pci_doe_init(struct pci_dev *pdev)
 			pci_err(pdev, "[%x] failed to insert mailbox: %d\n",
 				offset, rc);
 			pci_doe_destroy_mb(doe_mb);
+			pci_cma_disable(pdev);
 		}
 	}
 }
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index b46ce1a2c554..0645935fbcaf 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1804,6 +1804,9 @@ const struct attribute_group *pci_dev_attr_groups[] = {
 #endif
 #ifdef CONFIG_PCIEASPM
 	&aspm_ctrl_attr_group,
+#endif
+#ifdef CONFIG_PCI_CMA
+	&spdm_attr_group,
 #endif
 	NULL,
 };
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index fa6e3ae10b67..ad646b69a9c7 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -452,10 +452,15 @@ static inline void pci_doe_disconnected(struct pci_dev *pdev) { }
 void pci_cma_init(struct pci_dev *pdev);
 void pci_cma_destroy(struct pci_dev *pdev);
 void pci_cma_reauthenticate(struct pci_dev *pdev);
+static inline void pci_cma_disable(struct pci_dev *pdev)
+{
+	pdev->spdm_state = ERR_PTR(-ENOTTY);
+}
 #else
 static inline void pci_cma_init(struct pci_dev *pdev) { }
 static inline void pci_cma_destroy(struct pci_dev *pdev) { }
 static inline void pci_cma_reauthenticate(struct pci_dev *pdev) { }
+static inline void pci_cma_disable(struct pci_dev *pdev) { }
 #endif
 
 #ifdef CONFIG_PCI_NPEM
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 50c43546a32b..696f5ce971f4 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2704,6 +2704,18 @@ static inline bool pci_is_thunderbolt_attached(struct pci_dev *pdev)
 void pci_uevent_ers(struct pci_dev *pdev, enum  pci_ers_result err_type);
 #endif
 
+#ifdef CONFIG_PCI_CMA
+static inline struct spdm_state *pci_dev_to_spdm_state(struct pci_dev *pdev)
+{
+	return pdev->spdm_state;
+}
+#else
+static inline struct spdm_state *pci_dev_to_spdm_state(struct pci_dev *pdev)
+{
+	return NULL;
+}
+#endif
+
 #include <linux/dma-mapping.h>
 
 #define pci_printk(level, pdev, fmt, arg...) \
diff --git a/lib/rspdm/Makefile b/lib/rspdm/Makefile
index 1f62ee2a882d..f15b1437196b 100644
--- a/lib/rspdm/Makefile
+++ b/lib/rspdm/Makefile
@@ -8,3 +8,4 @@
 obj-$(CONFIG_RSPDM) += spdm.o
 
 spdm-y := lib.o
+spdm-$(CONFIG_SYSFS) += req-sysfs.o
diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
index 2bb716140e0a..24064d3c4669 100644
--- a/lib/rspdm/lib.rs
+++ b/lib/rspdm/lib.rs
@@ -24,6 +24,7 @@
 
 mod consts;
 mod state;
+pub mod sysfs;
 mod validator;
 
 /// spdm_create() - Allocate SPDM session
diff --git a/lib/rspdm/req-sysfs.c b/lib/rspdm/req-sysfs.c
new file mode 100644
index 000000000000..11bacb04f08f
--- /dev/null
+++ b/lib/rspdm/req-sysfs.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Rust implementation of the DMTF Security Protocol and Data Model (SPDM)
+ * https://www.dmtf.org/dsp/DSP0274
+ *
+ * Requester role: sysfs interface
+ *
+ * Copyright (C) 2023-24 Intel Corporation
+ * Copyright (C) 2024 Western Digital
+ */
+
+#include <linux/pci.h>
+
+int rust_authenticated_show(void *spdm_state, char *buf);
+
+/**
+ * dev_to_spdm_state() - Retrieve SPDM session state for given device
+ *
+ * @dev: Responder device
+ *
+ * Returns a pointer to the device's SPDM session state,
+ *	   %NULL if the device doesn't have one or
+ *	   %ERR_PTR if it couldn't be determined whether SPDM is supported.
+ *
+ * In the %ERR_PTR case, attributes are visible but return an error on access.
+ * This prevents downgrade attacks where an attacker disturbs memory allocation
+ * or communication with the device in order to create the appearance that SPDM
+ * is unsupported.  E.g. with PCI devices, the attacker may foil CMA or DOE
+ * initialization by simply hogging memory.
+ */
+static void *dev_to_spdm_state(struct device *dev)
+{
+	if (dev_is_pci(dev))
+		return pci_dev_to_spdm_state(to_pci_dev(dev));
+
+	/* Insert mappers for further bus types here. */
+
+	return NULL;
+}
+
+/* authenticated attribute */
+
+static umode_t spdm_attrs_are_visible(struct kobject *kobj,
+				      struct attribute *a, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	void *spdm_state = dev_to_spdm_state(dev);
+
+	if (IS_ERR_OR_NULL(spdm_state))
+		return SYSFS_GROUP_INVISIBLE;
+
+	return a->mode;
+}
+
+static ssize_t authenticated_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	void *spdm_state = dev_to_spdm_state(dev);
+	int rc;
+
+	if (IS_ERR_OR_NULL(spdm_state))
+		return PTR_ERR(spdm_state);
+
+	if (sysfs_streq(buf, "re")) {
+		rc = spdm_authenticate(spdm_state);
+		if (rc)
+			return rc;
+	} else {
+		return -EINVAL;
+	}
+
+	return count;
+}
+
+static ssize_t authenticated_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	void *spdm_state = dev_to_spdm_state(dev);
+
+	if (IS_ERR_OR_NULL(spdm_state))
+		return PTR_ERR(spdm_state);
+
+	return rust_authenticated_show(spdm_state, buf);
+}
+static DEVICE_ATTR_RW(authenticated);
+
+static struct attribute *spdm_attrs[] = {
+	&dev_attr_authenticated.attr,
+	NULL
+};
+
+const struct attribute_group spdm_attr_group = {
+	.attrs = spdm_attrs,
+	.is_visible = spdm_attrs_are_visible,
+};
diff --git a/lib/rspdm/sysfs.rs b/lib/rspdm/sysfs.rs
new file mode 100644
index 000000000000..50901c55b8f7
--- /dev/null
+++ b/lib/rspdm/sysfs.rs
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2024 Western Digital
+
+//! Rust sysfs helper functions
+//!
+//! Rust implementation of the DMTF Security Protocol and Data Model (SPDM)
+//! <https://www.dmtf.org/dsp/DSP0274>
+
+use crate::SpdmState;
+use kernel::prelude::*;
+use kernel::{bindings, fmt, str::CString};
+
+/// Helper function for the sysfs `authenticated_show()`.
+#[no_mangle]
+pub extern "C" fn rust_authenticated_show(spdm_state: *mut SpdmState, buf: *mut u8) -> isize {
+    // SAFETY: The opaque pointer will be directly from the `spdm_create()`
+    // function, so we can safely reconstruct it.
+    let state = unsafe { KBox::from_raw(spdm_state) };
+
+    let fmt = match CString::try_from_fmt(fmt!("{}\n", state.authenticated)) {
+        Ok(f) => f,
+        Err(_e) => return 0,
+    };
+
+    // SAFETY: Calling a kernel C function with valid arguments
+    unsafe { bindings::sysfs_emit(buf, fmt.as_char_ptr()) as isize }
+}
-- 
2.48.1


