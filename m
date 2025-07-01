Return-Path: <linux-pci+bounces-31138-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0005AEEF33
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 08:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B74E17E129
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 06:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6432238C05;
	Tue,  1 Jul 2025 06:47:45 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8289E21323C;
	Tue,  1 Jul 2025 06:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751352465; cv=none; b=E3bjQBUqovBvPI/QPkmyhV660DHzEtRyHdmoOADJ/vZO/Fn2rLt0ct6YwhnAHF7Nxbm5gRFw7Fx5/RA6HlqS57nZ+zO8kVXS6EjBWxw7PHSCZXktMgKZTr2OscGg63dFQMysh4dXXf6pWiy8OgmmCwmRDF+RFk5QENmbX0UJkqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751352465; c=relaxed/simple;
	bh=q8s+GpT4npG0EyYJoiXndD35PXvldamsaZRW/maQ/+c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OnDDWULRZtz6GlyOS6VEzqGv0dtco3I7A10cdrLVIon3j4rpC+83IQ08BzDWTM9PDG5Oq9iaL/sd4aLexOG9s8kX9h9dm8oXusm4QDySobqc526e6eWZ/TFKD8fquturxvmUP1m4R5tjTIChOhXXpcIZ/UP9EdHR6h+mXpTCEic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67754C4CEEB;
	Tue,  1 Jul 2025 06:47:42 +0000 (UTC)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: bhelgaas@google.com
Cc: lukas@wunner.de,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	stable@vger.kernel.org,
	Jim Quinlan <james.quinlan@broadcom.com>
Subject: [PATCH v2] PCI/pwrctrl: Skip creating pwrctrl device unless CONFIG_PCI_PWRCTRL is enabled
Date: Tue,  1 Jul 2025 12:17:31 +0530
Message-ID: <20250701064731.52901-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If devicetree describes power supplies related to a PCI device, we
previously created a pwrctrl device even if CONFIG_PCI_PWRCTL was
not enabled.

When pci_pwrctrl_create_device() creates and returns a pwrctrl device,
pci_scan_device() doesn't enumerate the PCI device. It assumes the pwrctrl
core will rescan the bus after turning on the power. However, if
CONFIG_PCI_PWRCTL is not enabled, the rescan never happens.

This may break PCI enumeration on any system that describes power supplies
in devicetree but does not use pwrctrl. Jim reported that some brcmstb
platforms break this way.

While the actual fix would be to convert all the platforms to use pwrctrl
framework, we also need to skip creating the pwrctrl device if
CONFIG_PCI_PWRCTL is not enabled and let the PCI core scan the device
normally (assuming it is already powered on or by the controller driver).

Cc: stable@vger.kernel.org # 6.15
Fixes: 957f40d039a9 ("PCI/pwrctrl: Move creation of pwrctrl devices to pci_scan_device()")
Reported-by: Jim Quinlan <james.quinlan@broadcom.com>
Closes: https://lore.kernel.org/r/CA+-6iNwgaByXEYD3j=-+H_PKAxXRU78svPMRHDKKci8AGXAUPg@mail.gmail.com
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---

Changes in v2:

* Used the stub instead of returning NULL inside the function

 drivers/pci/probe.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 4b8693ec9e4c..e6a34db77826 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2508,6 +2508,7 @@ bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
 }
 EXPORT_SYMBOL(pci_bus_read_dev_vendor_id);
 
+#if IS_ENABLED(CONFIG_PCI_PWRCTRL)
 static struct platform_device *pci_pwrctrl_create_device(struct pci_bus *bus, int devfn)
 {
 	struct pci_host_bridge *host = pci_find_host_bridge(bus);
@@ -2537,6 +2538,12 @@ static struct platform_device *pci_pwrctrl_create_device(struct pci_bus *bus, in
 
 	return pdev;
 }
+#else
+static struct platform_device *pci_pwrctrl_create_device(struct pci_bus *bus, int devfn)
+{
+	return NULL;
+}
+#endif
 
 /*
  * Read the config data for a PCI device, sanity-check it,
-- 
2.43.0


