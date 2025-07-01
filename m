Return-Path: <linux-pci+bounces-31211-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE8FAF06EB
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 01:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 211C7189D8E3
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 23:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541612701DC;
	Tue,  1 Jul 2025 23:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nz6gKL5b"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAF5265CC8
	for <linux-pci@vger.kernel.org>; Tue,  1 Jul 2025 23:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751412224; cv=none; b=fwF3U2E7qM7TRfo0PSpRQSz0/elDFzgDhFphsVB6Ku6BdQwRHD98jlhuRMyIdSbAa07xxUtZmC+16r3DMOi01/YXJZcAWidngwQD3PH2rG7zZhO+zxYFKdJfsy2EYBaQXn6V9wvTGdV3+ntMGci86jsc1tn6QsNBwrdoqDXY0ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751412224; c=relaxed/simple;
	bh=VsaJFvyErfmFyKxeUeoJw/OAtAYsiF4q1Os6F5TE+Ls=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=gDGrNgUPYKzJMcCKSO9bzoMLE2hLtVkBQfkwero1vcw8HcxW52EzRS4GFNrc8lY5WAKUteLme/bxJsBwNJPZuTQZDqgj6VtufNqu7DBMx9+BZc0VMqmEIcI4+fSF5jocjLZ+3wRllHdG9fVxyIMsvYk9l6/yr1hNYHAZagctf6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nz6gKL5b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EBE7C4CEEB;
	Tue,  1 Jul 2025 23:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751412222;
	bh=VsaJFvyErfmFyKxeUeoJw/OAtAYsiF4q1Os6F5TE+Ls=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Nz6gKL5bChLbZfs6zi+JYZn2WGBQT/58cgxs8AwOHO4ZEtCfYYJTs54Kqi1VKQQZW
	 KJB+wiSortf1UqVYDf0UBrOkgNKWz+krwOu7woS49wcG7vvxq9AB3PH6tHchtzN3AZ
	 EXszU+qiNH7xAQBdoMvtT0g6uWlw94c+AR2e5+iK/4PrfrcYTRX24/g76cyWSzkBbJ
	 9eoOJsu+jJeQw4iV/KEKVulQEgPLE00QOs//2q8cOaaNeoUkHDAv4AudeUMoGjQkzW
	 tnkDW/9lj2MFsPtSNt8Dad8KWIj8JJ6JpMzdMsWiPxqavMrQJTpPnRl7chFcH/JmKP
	 ilHJ9wjdbYI5g==
Date: Tue, 1 Jul 2025 18:23:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hui Wang <hui.wang@canonical.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	raphael.norwitz@nutanix.com, alay.shah@nutanix.com,
	suresh.gumpula@nutanix.com, ilpo.jarvinen@linux.intel.com,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
	Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Subject: Re: [PATCH] PCI: Disable RRS polling for Intel SSDPE2KX020T8 nvme
Message-ID: <20250701232341.GA1859056@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f7566fe-f662-4cf9-a363-c67dccdde846@canonical.com>

On Tue, Jun 24, 2025 at 08:58:57AM +0800, Hui Wang wrote:
> Sorry for late response, I was OOO the past week.
> 
> This is the log after applied your patch:
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2111521/comments/61
> 
> Looks like the "retry" makes the nvme work.

Thank you!  It seems like we get 0xffffffff (probably PCIe error) for
a long time after we think the device should be able to respond with
RRS.

I always thought the spec required that after the delays, a device
should respond with RRS if it's not ready, but now I guess I'm not
100% sure.  Maybe it's allowed to just do nothing, which would lead to
the Root Port timing out and logging an Unsupported Request error.

Can I trouble you to try the patch below?  I think we might have to
start explicitly checking for that error.  That probably would require
some setup to enable the error, check for it, and clear it.  I hacked
in some of that here, but ultimately some of it should go elsewhere.

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e9448d55113b..c276d0a2b522 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1264,10 +1264,13 @@ void pci_resume_bus(struct pci_bus *bus)
 
 static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
 {
-	int delay = 1;
+	int delay = 10;
 	bool retrain = false;
 	struct pci_dev *root, *bridge;
+	u16 devctl, devsta;
 
+	pci_info(dev, "%s: VF%c %s timeout %d\n", __func__,
+		 dev->is_virtfn ? '+' : '-', reset_type, timeout);
 	root = pcie_find_root_port(dev);
 
 	if (pci_is_pcie(dev)) {
@@ -1276,6 +1279,19 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
 			retrain = true;
 	}
 
+	if (root) {
+		pcie_capability_read_word(root, PCI_EXP_DEVCTL, &devctl);
+		if (!(devctl & PCI_EXP_DEVCTL_URRE))
+			pcie_capability_write_word(root, PCI_EXP_DEVCTL,
+					    devctl | PCI_EXP_DEVCTL_URRE);
+		pcie_capability_read_word(root, PCI_EXP_DEVSTA, &devsta);
+		if (devsta & PCI_EXP_DEVSTA_URD)
+			pcie_capability_write_word(root, PCI_EXP_DEVSTA,
+						   PCI_EXP_DEVSTA_URD);
+		pci_info(root, "%s: DEVCTL %#06x DEVSTA %#06x\n", __func__,
+			 devctl, devsta);
+	}
+
 	/*
 	 * The caller has already waited long enough after a reset that the
 	 * device should respond to config requests, but it may respond
@@ -1305,14 +1321,33 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
 
 		if (root && root->config_rrs_sv) {
 			pci_read_config_dword(dev, PCI_VENDOR_ID, &id);
-			if (!pci_bus_rrs_vendor_id(id))
-				break;
+
+			if (pci_bus_rrs_vendor_id(id)) {
+				pci_info(dev, "%s: read %#06x (RRS)\n",
+					 __func__, id);
+				goto retry;
+			}
+
+			if (PCI_POSSIBLE_ERROR(id)) {
+				pcie_capability_read_word(root, PCI_EXP_DEVSTA,
+							  &devsta);
+				if (devsta & PCI_EXP_DEVSTA_URD)
+					pcie_capability_write_word(root,
+							    PCI_EXP_DEVSTA,
+							    PCI_EXP_DEVSTA_URD);
+				pci_info(root, "%s: read %#06x DEVSTA %#06x\n",
+					 __func__, id, devsta);
+				goto retry;
+			}
+
+			break;
 		} else {
 			pci_read_config_dword(dev, PCI_COMMAND, &id);
 			if (!PCI_POSSIBLE_ERROR(id))
 				break;
 		}
 
+retry:
 		if (delay > timeout) {
 			pci_warn(dev, "not ready %dms after %s; giving up\n",
 				 delay - 1, reset_type);
@@ -1332,7 +1367,6 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
 		}
 
 		msleep(delay);
-		delay *= 2;
 	}
 
 	if (delay > PCI_RESET_WAIT)
@@ -4670,8 +4704,10 @@ static int pcie_wait_for_link_status(struct pci_dev *pdev,
 	end_jiffies = jiffies + msecs_to_jiffies(PCIE_LINK_RETRAIN_TIMEOUT_MS);
 	do {
 		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnksta);
-		if ((lnksta & lnksta_mask) == lnksta_match)
+		if ((lnksta & lnksta_mask) == lnksta_match) {
+			pci_info(pdev, "%s: LNKSTA %#06x\n", __func__, lnksta);
 			return 0;
+		}
 		msleep(1);
 	} while (time_before(jiffies, end_jiffies));
 
@@ -4760,6 +4796,8 @@ static bool pcie_wait_for_link_delay(struct pci_dev *pdev, bool active,
 	 * Some controllers might not implement link active reporting. In this
 	 * case, we wait for 1000 ms + any delay requested by the caller.
 	 */
+	pci_info(pdev, "%s: active %d delay %d link_active_reporting %d\n",
+		 __func__, active, delay, pdev->link_active_reporting);
 	if (!pdev->link_active_reporting) {
 		msleep(PCIE_LINK_RETRAIN_TIMEOUT_MS + delay);
 		return true;
@@ -4784,6 +4822,7 @@ static bool pcie_wait_for_link_delay(struct pci_dev *pdev, bool active,
 			return false;
 
 		msleep(delay);
+		pci_info(pdev, "%s: waited %dms\n", __func__, delay);
 		return true;
 	}
 
@@ -4960,6 +4999,7 @@ void pci_reset_secondary_bus(struct pci_dev *dev)
 
 	ctrl &= ~PCI_BRIDGE_CTL_BUS_RESET;
 	pci_write_config_word(dev, PCI_BRIDGE_CONTROL, ctrl);
+	pci_info(dev, "%s: PCI_BRIDGE_CTL_BUS_RESET deasserted\n", __func__);
 }
 
 void __weak pcibios_reset_secondary_bus(struct pci_dev *dev)

