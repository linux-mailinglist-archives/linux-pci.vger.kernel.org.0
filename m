Return-Path: <linux-pci+bounces-24945-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE10A74D02
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 15:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8491165E1B
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 14:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0160D178395;
	Fri, 28 Mar 2025 14:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCRE8Z1L"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8403EAF9;
	Fri, 28 Mar 2025 14:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743172877; cv=none; b=huGj59bSS8eQwDKt3v3VhGANTiVUv1PiuYBaN6T/GX3+suWa8UM2N9cnSFAf9vtaVqc/ihOTUpeHgkiPvbvy1/fhc5oOsry6oNt448At0suE0hEFbTqneiO+RWZzBD/vDcGqm53qTvGSXQPHSKHk5rwnPxyjSWaVKtjpIoQJttc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743172877; c=relaxed/simple;
	bh=+YTvdE2iZ788wN7Wc+2uw+Dvl6sYCHoidGkWfyHGi94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N3y8Ecr+UNoNjYVVURr2HkVBmb+zSjcIcaU2scOQQYDFDsVrV9kmqrjAvUY+05sZv2C+L6YNFwHGMc3cOLjfT2iclopCONrhRpQWJKk5nGOFP8XP0m4xqT53vfjdc8KsDn5/pYSKpo3v4Qju0dTYXFk6mRski6FusHVw9FzKOcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCRE8Z1L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B145C4CEEA;
	Fri, 28 Mar 2025 14:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743172877;
	bh=+YTvdE2iZ788wN7Wc+2uw+Dvl6sYCHoidGkWfyHGi94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RCRE8Z1LhBsgr2sxxO+SC9iT/1qQQzQNPGQwZCR9iheW/x2fyQQ50kfRUQyNR0tbO
	 CG8B64yJL0LOl32J2nrreBQlspSafic3QlZwfGCIkIT1cLrbS2oLaNydTaB5Q27RK2
	 qKGNmpXnePK3uw2DsT8QzTrebcGvNfGohKyJJq0skcztjXEMYBUghGh2x1UdbL2Xwf
	 FsU3I+sKia9ebnGhsjknGZNghv8nrmeX+fp2AyYh6a34hNqrwMCojyLF4uP0whvA+h
	 H2O4OpUvZEjrg2f6ZszIYBdHUtI3YY6pry0NA7j3RfhgB7q32mKnAR4L7zJYsKLk1c
	 zu6N6IQbUtbDw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1tyAte-000000007JG-3cJz;
	Fri, 28 Mar 2025 15:41:22 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	ath11k@lists.infradead.org,
	ath12k@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 1/4] PCI/pwrctrl: Rename pwrctrl Kconfig symbols and slot module
Date: Fri, 28 Mar 2025 15:36:43 +0100
Message-ID: <20250328143646.27678-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250328143646.27678-1-johan+linaro@kernel.org>
References: <20250328143646.27678-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commits b88cbaaa6fa1 ("PCI/pwrctrl: Rename pwrctl files to pwrctrl") and
3f925cd62874 ("PCI/pwrctrl: Rename pwrctrl functions and structures")
renamed the "pwrctl" framework to "pwrctrl" for consistency reasons.

Rename also the Kconfig symbols so that they reflect the new name while
adding entries for the deprecated ones. The old symbols can be removed
once everything that depends on them has been updated.

The new slot module is also renamed to reflect the framework name and
match the other pwrctrl modules.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/pci/pwrctrl/Kconfig  | 27 +++++++++++++++++++++------
 drivers/pci/pwrctrl/Makefile |  8 ++++----
 2 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/pwrctrl/Kconfig b/drivers/pci/pwrctrl/Kconfig
index 990cab67d413..62f176e42e33 100644
--- a/drivers/pci/pwrctrl/Kconfig
+++ b/drivers/pci/pwrctrl/Kconfig
@@ -1,19 +1,19 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-config HAVE_PWRCTL
+config HAVE_PWRCTRL
 	bool
 
-config PCI_PWRCTL
+config PCI_PWRCTRL
 	tristate
 
-config PCI_PWRCTL_PWRSEQ
+config PCI_PWRCTRL_PWRSEQ
 	tristate
 	select POWER_SEQUENCING
-	select PCI_PWRCTL
+	select PCI_PWRCTRL
 
-config PCI_PWRCTL_SLOT
+config PCI_PWRCTRL_SLOT
 	tristate "PCI Power Control driver for PCI slots"
-	select PCI_PWRCTL
+	select PCI_PWRCTRL
 	help
 	  Say Y here to enable the PCI Power Control driver to control the power
 	  state of PCI slots.
@@ -21,3 +21,18 @@ config PCI_PWRCTL_SLOT
 	  This is a generic driver that controls the power state of different
 	  PCI slots. The voltage regulators powering the rails of the PCI slots
 	  are expected to be defined in the devicetree node of the PCI bridge.
+
+# deprecated
+config HAVE_PWRCTL
+	bool
+	select HAVE_PWRCTRL
+
+# deprecated
+config PCI_PWRCTL_PWRSEQ
+	tristate
+	select PCI_PWRCTRL_PWRSEQ
+
+# deprecated
+config PCI_PWRCTL_SLOT
+	tristate
+	select PCI_PWRCTRL_SLOT
diff --git a/drivers/pci/pwrctrl/Makefile b/drivers/pci/pwrctrl/Makefile
index ddfb12c5aadf..a4e5808d7850 100644
--- a/drivers/pci/pwrctrl/Makefile
+++ b/drivers/pci/pwrctrl/Makefile
@@ -1,9 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-obj-$(CONFIG_PCI_PWRCTL)		+= pci-pwrctrl-core.o
+obj-$(CONFIG_PCI_PWRCTRL)		+= pci-pwrctrl-core.o
 pci-pwrctrl-core-y			:= core.o
 
-obj-$(CONFIG_PCI_PWRCTL_PWRSEQ)		+= pci-pwrctrl-pwrseq.o
+obj-$(CONFIG_PCI_PWRCTRL_PWRSEQ)	+= pci-pwrctrl-pwrseq.o
 
-obj-$(CONFIG_PCI_PWRCTL_SLOT)		+= pci-pwrctl-slot.o
-pci-pwrctl-slot-y			:= slot.o
+obj-$(CONFIG_PCI_PWRCTRL_SLOT)		+= pci-pwrctrl-slot.o
+pci-pwrctrl-slot-y			:= slot.o
-- 
2.48.1


