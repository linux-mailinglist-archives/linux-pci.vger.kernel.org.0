Return-Path: <linux-pci+bounces-25170-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3348FA78FBA
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 15:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4625188A49A
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 13:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB90723A98E;
	Wed,  2 Apr 2025 13:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVfo+JTY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C142376EA;
	Wed,  2 Apr 2025 13:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743600421; cv=none; b=QQ2d3ckObE4EnkunX1sKb7oZcUTylEVPpaQPRWBANQN/H8by2YE72FCPRJacI2klXN0oYunfmCTWcK3C0fx0SN6Syz7GlnUnNMdhc1eSuorNeJIR0F70uJpn4g19489E8MCTeREPNGRtcZhaXACiYV577u/C897Fx8FgrUeLnjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743600421; c=relaxed/simple;
	bh=q8MlTcMdTxqASv9J/gaoNv8sWTK+B2H8IJ7Qnbtnb1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u1YNwcUDQt6xCN/XtAKM8iMBsv08aDYyZBCew5hMLxmDZibyXCwlgdlheOgf4QZenD6sBRZZFedM/vwRqod8V0qWJ1GfbwxA6FvdHm+M8A9Q4HkBJrTKo5DSvvlYcGdkoNqpy98aZD7J+xCoTJFzy+bQqqsfbOLyodUTOEU0KA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVfo+JTY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2263BC4CEDD;
	Wed,  2 Apr 2025 13:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743600421;
	bh=q8MlTcMdTxqASv9J/gaoNv8sWTK+B2H8IJ7Qnbtnb1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LVfo+JTYRbWK1cu1fOodOq39dmcomePZ+LktifxPm6ESLTvdMXIHtIXzClQpBgXf1
	 mpmQAIcLOngU9OSCXKbFHE2c5XGeJiSfdsGStGQi+V8Cmm/dEn20UYWn6QRabWWrtD
	 frAQEdD25dqgxVy0l8JCvwTyWopF9Lur/0Z7xw9vCqg4MaauQCt70tuRC032WNejVs
	 nsQd39VEY3cflmGP9VuxUgIOj/+m5O+OQ/E1fiEl9l+JNC2E9j/GAVLIU4o6aij2nX
	 HFeZ++gE1vT7S/OwMQ9XN0GRyHdWHD7dLW4JyShRHRQPL89q1z+jf2+m0UUUfrbLFQ
	 B4dZQtnOt9IBQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1tzy7W-000000004iI-1d0r;
	Wed, 02 Apr 2025 15:27:06 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	ath11k@lists.infradead.org,
	ath12k@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 1/4] PCI/pwrctrl: Rename pwrctrl Kconfig symbols and slot module
Date: Wed,  2 Apr 2025 15:26:31 +0200
Message-ID: <20250402132634.18065-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250402132634.18065-1-johan+linaro@kernel.org>
References: <20250402132634.18065-1-johan+linaro@kernel.org>
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

Note that no deprecated symbol is added for the new slot driver to avoid
having to add a user visible option.

The new slot module is also renamed to reflect the framework name and
match the other pwrctrl modules.

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/pci/pwrctrl/Kconfig  | 22 ++++++++++++++++------
 drivers/pci/pwrctrl/Makefile |  8 ++++----
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/pwrctrl/Kconfig b/drivers/pci/pwrctrl/Kconfig
index 990cab67d413..6956c1854811 100644
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
@@ -21,3 +21,13 @@ config PCI_PWRCTL_SLOT
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
2.49.0


