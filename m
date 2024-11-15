Return-Path: <linux-pci+bounces-16937-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 566139CF935
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 23:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA3DD1F21E67
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 22:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5E61E3DD5;
	Fri, 15 Nov 2024 21:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQpsNzZA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB841E3790;
	Fri, 15 Nov 2024 21:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731707076; cv=none; b=QDS0QFvVlo9jsMKDQjdA0qKsy/zccJUbHzeY1NRcvDmybbhevHL3nZzlnv0imX5alIWjTExrOv9Yg9noLBki+HIQBKo9OzTLT3Fv89Q/NtBR4Ir52q10allLnGEbmarh74eugVHQPvFuFR8TnUj3O7DEjjpaUku9yEQuxXDw4G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731707076; c=relaxed/simple;
	bh=fZFwIq8PDHhlM72b9JRyIOE2t9jKPIOKwKFpqiGsJPo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jaTaf/4/dV8jgZITBy98twSd9BdBNUTkQRcWLajqDb6iba/rpYF+AT+ntPHDhMBbj/z8+ncKyGOExWZffQ+Dj+S3LWws7152ZLYvjdVMUQtwk0C6ZqM4W4cc1HUPZ3DwnpsX0Z92RIuOnb8zjt0qyIROrglJTFKVU1jShfiwNsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQpsNzZA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81767C4CEDE;
	Fri, 15 Nov 2024 21:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731707075;
	bh=fZFwIq8PDHhlM72b9JRyIOE2t9jKPIOKwKFpqiGsJPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WQpsNzZAHzzeJOcXZs09Mf2PsOadmt+BC8vOk+hMoO+KODmb0iwBFUWNFmiAJfcst
	 cuPYh5EUFb70r2Jcy2YoR/7Tcckdh8wDmKqpT7R3gRWXJGFfx09VZAdviEY0V6l0qK
	 CZzkgU02CBHi9JbLGGJshOpKb3y9MmtcF5YvAnrOUEnfVZQR7RI7RxTDkp8hDbQSDH
	 NSB0BkHTr7b+O+TyrPbUYg65phhxKzKe6GUXUqyTEy7AAYXF2rbi03AnbFbxXANwiB
	 9vFYhJ0bln9OwBNntXz0TAIkANh1l2O1mKqXUwomqOsgZ7Lj3adLINdhHHkBXdZOnz
	 JEuKXIJNXyjFQ==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	"Maciej W . Rozycki" <macro@orcam.me.uk>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Lukas Wunner <lukas@wunner.de>,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Amit Kucheria <amitk@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Amit Pundir <amit.pundir@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Caleb Connolly <caleb.connolly@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 1/2] PCI/pwrctrl: Rename pwrctl files to pwrctrl
Date: Fri, 15 Nov 2024 15:44:27 -0600
Message-Id: <20241115214428.2061153-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241115214428.2061153-1-helgaas@kernel.org>
References: <20241115214428.2061153-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

To slightly reduce confusion between "pwrctl" (the power controller and
power sequencing framework) and "bwctrl" (the bandwidth controller),
rename "pwrctl" to "pwrctrl" so they use the same "ctrl" suffix.

Rename drivers/pci/pwrctl/ to drivers/pci/pwrctrl/, including the related
MAINTAINERS, include file (include/linux/pci-pwrctl.h), Makefile, and
Kconfig changes.

This is the minimal rename of files only.  A subsequent commit will rename
functions and data structures.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 MAINTAINERS                                                 | 4 ++--
 drivers/pci/Kconfig                                         | 2 +-
 drivers/pci/Makefile                                        | 2 +-
 drivers/pci/pwrctl/Makefile                                 | 6 ------
 drivers/pci/{pwrctl => pwrctrl}/Kconfig                     | 0
 drivers/pci/pwrctrl/Makefile                                | 6 ++++++
 drivers/pci/{pwrctl => pwrctrl}/core.c                      | 2 +-
 .../pci-pwrctl-pwrseq.c => pwrctrl/pci-pwrctrl-pwrseq.c}    | 2 +-
 include/linux/{pci-pwrctl.h => pci-pwrctrl.h}               | 0
 9 files changed, 12 insertions(+), 12 deletions(-)
 delete mode 100644 drivers/pci/pwrctl/Makefile
 rename drivers/pci/{pwrctl => pwrctrl}/Kconfig (100%)
 create mode 100644 drivers/pci/pwrctrl/Makefile
 rename drivers/pci/{pwrctl => pwrctrl}/core.c (99%)
 rename drivers/pci/{pwrctl/pci-pwrctl-pwrseq.c => pwrctrl/pci-pwrctrl-pwrseq.c} (98%)
 rename include/linux/{pci-pwrctl.h => pci-pwrctrl.h} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index c27f3190737f..1a6096135424 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17910,8 +17910,8 @@ M:	Bartosz Golaszewski <brgl@bgdev.pl>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
-F:	drivers/pci/pwrctl/*
-F:	include/linux/pci-pwrctl.h
+F:	drivers/pci/pwrctrl/*
+F:	include/linux/pci-pwrctrl.h
 
 PCI SUBSYSTEM
 M:	Bjorn Helgaas <bhelgaas@google.com>
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 0d94e4a967d8..e1c025698a28 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -305,6 +305,6 @@ source "drivers/pci/hotplug/Kconfig"
 source "drivers/pci/controller/Kconfig"
 source "drivers/pci/endpoint/Kconfig"
 source "drivers/pci/switch/Kconfig"
-source "drivers/pci/pwrctl/Kconfig"
+source "drivers/pci/pwrctrl/Kconfig"
 
 endif
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 374c5c06d92f..39a07890abd1 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -9,7 +9,7 @@ obj-$(CONFIG_PCI)		+= access.o bus.o probe.o host-bridge.o \
 
 obj-$(CONFIG_PCI)		+= msi/
 obj-$(CONFIG_PCI)		+= pcie/
-obj-$(CONFIG_PCI)		+= pwrctl/
+obj-$(CONFIG_PCI)		+= pwrctrl/
 
 ifdef CONFIG_PCI
 obj-$(CONFIG_PROC_FS)		+= proc.o
diff --git a/drivers/pci/pwrctl/Makefile b/drivers/pci/pwrctl/Makefile
deleted file mode 100644
index d308aae4800c..000000000000
--- a/drivers/pci/pwrctl/Makefile
+++ /dev/null
@@ -1,6 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-
-obj-$(CONFIG_PCI_PWRCTL)		+= pci-pwrctl-core.o
-pci-pwrctl-core-y			:= core.o
-
-obj-$(CONFIG_PCI_PWRCTL_PWRSEQ)		+= pci-pwrctl-pwrseq.o
diff --git a/drivers/pci/pwrctl/Kconfig b/drivers/pci/pwrctrl/Kconfig
similarity index 100%
rename from drivers/pci/pwrctl/Kconfig
rename to drivers/pci/pwrctrl/Kconfig
diff --git a/drivers/pci/pwrctrl/Makefile b/drivers/pci/pwrctrl/Makefile
new file mode 100644
index 000000000000..75c7ce531c7e
--- /dev/null
+++ b/drivers/pci/pwrctrl/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_PCI_PWRCTL)		+= pci-pwrctrl-core.o
+pci-pwrctrl-core-y			:= core.o
+
+obj-$(CONFIG_PCI_PWRCTL_PWRSEQ)		+= pci-pwrctrl-pwrseq.o
diff --git a/drivers/pci/pwrctl/core.c b/drivers/pci/pwrctrl/core.c
similarity index 99%
rename from drivers/pci/pwrctl/core.c
rename to drivers/pci/pwrctrl/core.c
index 01d913b60316..8a0b4219571d 100644
--- a/drivers/pci/pwrctl/core.c
+++ b/drivers/pci/pwrctrl/core.c
@@ -7,7 +7,7 @@
 #include <linux/export.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
-#include <linux/pci-pwrctl.h>
+#include <linux/pci-pwrctrl.h>
 #include <linux/property.h>
 #include <linux/slab.h>
 
diff --git a/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c b/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c
similarity index 98%
rename from drivers/pci/pwrctl/pci-pwrctl-pwrseq.c
rename to drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c
index a23a4312574b..cc19ad61dd6e 100644
--- a/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c
+++ b/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c
@@ -7,7 +7,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/pci-pwrctl.h>
+#include <linux/pci-pwrctrl.h>
 #include <linux/platform_device.h>
 #include <linux/pwrseq/consumer.h>
 #include <linux/slab.h>
diff --git a/include/linux/pci-pwrctl.h b/include/linux/pci-pwrctrl.h
similarity index 100%
rename from include/linux/pci-pwrctl.h
rename to include/linux/pci-pwrctrl.h
-- 
2.34.1


