Return-Path: <linux-pci+bounces-12318-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A4D961ACD
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 01:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C304283BA9
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 23:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5831D47BC;
	Tue, 27 Aug 2024 23:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDmfyFhs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082F31D47B6;
	Tue, 27 Aug 2024 23:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724802547; cv=none; b=q6yYoiq9vsyyd3Xex85MUicQJB4ZF39tl87mjic6REvcwsx+hcF+Pz4OSeLT4n8SwYqwtkDeT9HG7qKuHepPbnTqPfvZhmbo99w5LMB2zr4Pr6WdYzYKxRBT3xuHtnRa9KH56VtPR/u/S0rTs8vhiwRKzFZPHxDPZrWPzxBFtQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724802547; c=relaxed/simple;
	bh=i5Mw1/amHvNegRStCb05RhLW86c+eXarnG69SIJiwes=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mahXdhkZSwuWYj7PuKkGgke7MEfW8oBd45lbf33x9uqiu9eE2qMg3zd2kXXuS6uw3nyx9TmaVYC7sjakSDIabxwSoS135Nivf4VLpWj1XcFjSfp8R75/OKOTlxYWNN7xRY0mktxc8Vr2n4EshRqkcysSFCw/zIhePQCM/5xpLjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MDmfyFhs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B04BC4FE0B;
	Tue, 27 Aug 2024 23:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724802546;
	bh=i5Mw1/amHvNegRStCb05RhLW86c+eXarnG69SIJiwes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MDmfyFhsDvvSjIjMt4XKgWYrrBPXD0urjWk3W3U/8ZPi2LmO3SqGPj9788kYP4KW1
	 qizDcd3ELVEuNXVhJj80Tn79019Yok99tmkPYcXEmLggZpMRMOaDsFB8tIwq/B+UI1
	 5iTGQTjr+3qgcnv8JFCx1W45blZo8Z3bv80puthz/QYjjgrJQJ2lo4kFtblyn9eHWc
	 /gXHqp2DydYfCErz/N6x28PQ0YTkCw6J050mjcKVpjkNI2X/kg7fktYp99DBVLUfgV
	 9ftbwLvk4yIx4tCePCW3Gkyt8Owmr0rWimD22bjpwYolTVyvAR8/VAofTqOgPca0gz
	 +isyW503fKHbw==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Maciej W . Rozycki" <macro@orcam.me.uk>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Duc Dang <ducdang@google.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [RFC PATCH 1/3] PCI: Wait for device readiness with Configuration RRS
Date: Tue, 27 Aug 2024 18:48:46 -0500
Message-Id: <20240827234848.4429-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240827234848.4429-1-helgaas@kernel.org>
References: <20240827234848.4429-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

After a device reset, delays are required before the device can
successfully complete config accesses.  PCIe r6.0, sec 6.6, specifies some
delays required before software can perform config accesses.  Devices that
require more time after those delays may respond to config accesses with
Configuration Request Retry Status (RRS) completions.

Callers of pci_dev_wait() are responsible for delays until the device can
respond to config accesses.  pci_dev_wait() waits any additional time until
the device can successfully complete config accesses.

Reading config space of devices that are not present or not ready typically
returns ~0 (PCI_ERROR_RESPONSE).  Previously we polled the Command register
until we got a value other than ~0.  This is sometimes a problem because
Root Complex handling of RRS completions may include several retries and
implementation-specific behavior that is invisible to software (see sec
2.3.2), so the exponential backoff in pci_dev_wait() may not work as
intended.

Linux enables Configuration RRS Software Visibility on all Root Ports that
support it.  If it is enabled, read the Vendor ID instead of the Command
register.  RRS completions cause immediate return of the 0x0001 reserved
Vendor ID value, so the pci_dev_wait() backoff works correctly.

When a read of Vendor ID eventually completes successfully by returning a
non-0x0001 value (the Vendor ID or 0xffff for VFs), the device should be
initialized and ready to respond to config requests.

For conventional PCI devices or devices below Root Ports that don't support
Configuration RRS Software Visibility, poll the Command register as before.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.c   | 41 ++++++++++++++++++++++++++++-------------
 drivers/pci/pci.h   |  5 +++++
 drivers/pci/probe.c |  9 +++------
 include/linux/pci.h |  1 +
 4 files changed, 37 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e3a49f66982d..fc2ecb7fe081 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1283,7 +1283,9 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
 {
 	int delay = 1;
 	bool retrain = false;
-	struct pci_dev *bridge;
+	struct pci_dev *root, *bridge;
+
+	root = pcie_find_root_port(dev);
 
 	if (pci_is_pcie(dev)) {
 		bridge = pci_upstream_bridge(dev);
@@ -1292,16 +1294,23 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
 	}
 
 	/*
-	 * After reset, the device should not silently discard config
-	 * requests, but it may still indicate that it needs more time by
-	 * responding to them with CRS completions.  The Root Port will
-	 * generally synthesize ~0 (PCI_ERROR_RESPONSE) data to complete
-	 * the read (except when CRS SV is enabled and the read was for the
-	 * Vendor ID; in that case it synthesizes 0x0001 data).
+	 * The caller has already waited long enough after a reset that the
+	 * device should respond to config requests, but it may respond
+	 * with Request Retry Status (RRS) if it needs more time to
+	 * initialize.
 	 *
-	 * Wait for the device to return a non-CRS completion.  Read the
-	 * Command register instead of Vendor ID so we don't have to
-	 * contend with the CRS SV value.
+	 * If the device is below a Root Port with Configuration RRS
+	 * Software Visibility enabled, reading the Vendor ID returns a
+	 * special data value if the device responded with RRS.  Read the
+	 * Vendor ID until we get non-RRS status.
+	 *
+	 * If there's no Root Port or Configuration RRS Software Visibility
+	 * is not enabled, the device may still respond with RRS, but
+	 * hardware may retry the config request.  If no retries receive
+	 * Successful Completion, hardware generally synthesizes ~0
+	 * (PCI_ERROR_RESPONSE) data to complete the read.  Reading Vendor
+	 * ID for VFs and non-existent devices also returns ~0, so read the
+	 * Command register until it returns something other than ~0.
 	 */
 	for (;;) {
 		u32 id;
@@ -1311,9 +1320,15 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
 			return -ENOTTY;
 		}
 
-		pci_read_config_dword(dev, PCI_COMMAND, &id);
-		if (!PCI_POSSIBLE_ERROR(id))
-			break;
+		if (root && root->config_crs_sv) {
+			pci_read_config_dword(dev, PCI_VENDOR_ID, &id);
+			if (!pci_bus_crs_vendor_id(id))
+				break;
+		} else {
+			pci_read_config_dword(dev, PCI_COMMAND, &id);
+			if (!PCI_POSSIBLE_ERROR(id))
+				break;
+		}
 
 		if (delay > timeout) {
 			pci_warn(dev, "not ready %dms after %s; giving up\n",
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 79c8398f3938..fa1997bc2667 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -139,6 +139,11 @@ bool pci_bridge_d3_possible(struct pci_dev *dev);
 void pci_bridge_d3_update(struct pci_dev *dev);
 int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type);
 
+static inline bool pci_bus_crs_vendor_id(u32 l)
+{
+	return (l & 0xffff) == PCI_VENDOR_ID_PCI_SIG;
+}
+
 static inline void pci_wakeup_event(struct pci_dev *dev)
 {
 	/* Wait 100 ms before the system can be put into a sleep state. */
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b14b9876c030..b1615da9eb6b 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1209,9 +1209,11 @@ static void pci_enable_crs(struct pci_dev *pdev)
 
 	/* Enable CRS Software Visibility if supported */
 	pcie_capability_read_word(pdev, PCI_EXP_RTCAP, &root_cap);
-	if (root_cap & PCI_EXP_RTCAP_CRSVIS)
+	if (root_cap & PCI_EXP_RTCAP_CRSVIS) {
 		pcie_capability_set_word(pdev, PCI_EXP_RTCTL,
 					 PCI_EXP_RTCTL_CRSSVE);
+		pdev->config_crs_sv = 1;
+	}
 }
 
 static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
@@ -2343,11 +2345,6 @@ struct pci_dev *pci_alloc_dev(struct pci_bus *bus)
 }
 EXPORT_SYMBOL(pci_alloc_dev);
 
-static bool pci_bus_crs_vendor_id(u32 l)
-{
-	return (l & 0xffff) == PCI_VENDOR_ID_PCI_SIG;
-}
-
 static bool pci_bus_wait_crs(struct pci_bus *bus, int devfn, u32 *l,
 			     int timeout)
 {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 4cf89a4b4cbc..121d8d94d6d0 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -371,6 +371,7 @@ struct pci_dev {
 					   can be generated */
 	unsigned int	pme_poll:1;	/* Poll device's PME status bit */
 	unsigned int	pinned:1;	/* Whether this dev is pinned */
+	unsigned int	config_crs_sv:1; /* Config CRS software visibility */
 	unsigned int	imm_ready:1;	/* Supports Immediate Readiness */
 	unsigned int	d1_support:1;	/* Low power state D1 is supported */
 	unsigned int	d2_support:1;	/* Low power state D2 is supported */
-- 
2.34.1


