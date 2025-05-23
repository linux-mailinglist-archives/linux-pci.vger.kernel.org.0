Return-Path: <linux-pci+bounces-28355-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D994AC2AC5
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 22:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EC5C4E54AE
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 20:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0BA1F3B98;
	Fri, 23 May 2025 20:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J3Wl17+B"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2252E1DACB1;
	Fri, 23 May 2025 20:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748031580; cv=none; b=rYjg+lBEFxMEWMD33FYvzKjwcUBu1GAD9fRDaSL6qsrzhNZYHwEwbz2NXFDEeNly36SZrQA30Z+hgXjPlMJuMnp3ZP6CmyQRJ+ih92gLPXId7v6/4PneIG19A5jVvt95+Stg6sKQcx/93n4AbXWhxnzklgrfCUDm0HnvGc3D2j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748031580; c=relaxed/simple;
	bh=J39Tu8C1B1Ew13gSMOZ+Aoe329Y7AmIvYP41Spj66gI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YkzAfjxQWDdQ8JUUvjdCPaddYq9zuu8C/wjDedOkl+Dkgv4ag8VqemcSEEf0kI5k1vafH4UH+WQGoY0O0+09QMqfnyGyeqCvQ/mVJrUR5wF+87aVZ+G4xiBT0JbNObilGq2o/YqAjeo6lBhztegXrcglnQYC6ucqR7yctxi01fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J3Wl17+B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 649CBC4CEE9;
	Fri, 23 May 2025 20:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748031579;
	bh=J39Tu8C1B1Ew13gSMOZ+Aoe329Y7AmIvYP41Spj66gI=;
	h=From:To:Cc:Subject:Date:From;
	b=J3Wl17+BgntjwUucfpOuLVig3LlcFG6us+myWqo8okhujzSosvpfYfIwT13qhiwbm
	 cs+L5o7nly32VPrkqGpWgOulnU1ru2vkVbrHYZH2vv+vlZhXgOJAkrx+xcmq2tE7cN
	 FOrovO+fCZ5TUN/e10dMDt7q0MK1nQSVQepXdUJSVVIJHh04x7mzinrXOnQEp9gXTF
	 SPPd8B6pHPVOIb5Z/tSAW82jfU3WwiO/uuCDxlu3uWttFM+oqi2goWg2er//JFxOHM
	 OrPnZAmie6EncJ1GrcZmxF3Kbx5sMRldjWw53Ft78p++uPXd1xKsIRo5Rlj1Xkmwau
	 VTXPfayA9FyfA==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Cyril Brulebois <kibi@debian.org>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Jim Quinlan <james.quinlan@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI/pwrctrl: Skip creating platform device unless CONFIG_PCI_PWRCTL enabled
Date: Fri, 23 May 2025 15:17:59 -0500
Message-ID: <20250523201935.1586198-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

If devicetree describes power supplies related to a PCI device,
pci_pwrctrl_create_device() previously created a pwrctrl platform device
even if CONFIG_PCI_PWRCTL was not enabled.

When pci_pwrctrl_create_device() creates a pwrctrl device and returns it,
pci_scan_device() doesn't enumerating the PCI device on the assumption that
the pwrctrl core will rescan the bus after turning on the power.  If
CONFIG_PCI_PWRCTL is not enabled, the rescan never happens.

This breaks PCI enumeration on any system that describes power supplies in
devicetree but does not use pwrctrl.  Jim reported that some brcmstb
platforms break this way.

If CONFIG_PCI_PWRCTL is not enabled, skip creating the pwrctrl platform
device and scan the device normally.

Fixes: 957f40d039a9 ("PCI/pwrctrl: Move creation of pwrctrl devices to pci_scan_device()")
Reported-by: Jim Quinlan <james.quinlan@broadcom.com>
Closes: https://lore.kernel.org/r/CA+-6iNwgaByXEYD3j=-+H_PKAxXRU78svPMRHDKKci8AGXAUPg@mail.gmail.com
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
This an alternate to
https://lore.kernel.org/r/20250522140326.93869-1-manivannan.sadhasivam@linaro.org

It should accomplish the same thing but I think using #ifdef makes it a
little more visible and easier to see that pci_pwrctrl_create_device() is
only relevant when CONFIG_PCI_PWRCTL is enabled.

 drivers/pci/probe.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 364fa2a514f8..855da472b608 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2510,6 +2510,7 @@ EXPORT_SYMBOL(pci_bus_read_dev_vendor_id);
 
 static struct platform_device *pci_pwrctrl_create_device(struct pci_bus *bus, int devfn)
 {
+#if defined(CONFIG_PCI_PWRCTL) || defined(CONFIG_PCI_PWRCTL_MODULE)
 	struct pci_host_bridge *host = pci_find_host_bridge(bus);
 	struct platform_device *pdev;
 	struct device_node *np;
@@ -2536,6 +2537,9 @@ static struct platform_device *pci_pwrctrl_create_device(struct pci_bus *bus, in
 	}
 
 	return pdev;
+#else
+	return NULL;
+#endif
 }
 
 /*
-- 
2.43.0


