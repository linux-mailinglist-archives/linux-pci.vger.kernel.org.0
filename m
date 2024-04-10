Return-Path: <linux-pci+bounces-6006-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 079B989EF95
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 12:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C4271C22237
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 10:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11718158204;
	Wed, 10 Apr 2024 10:07:47 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB4013D274
	for <linux-pci@vger.kernel.org>; Wed, 10 Apr 2024 10:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712743667; cv=none; b=lw2soVqnSWLPLh1FCSwYWuZ/gpEMhJ7Gpdnn3/4wG9FTFJnnmpNmvg+M2H7H+NkJXL766YFmQGzQSRZdkKEBheX/x0tIZJ2iNyNvwyypIlguBYquSk//JOCwWCgkg6cldCrexKE7IBUftJgCvA6diuQ5oKgiykS69vOeCNip/3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712743667; c=relaxed/simple;
	bh=094i0aNlqgYoru+iK7sz5NX4e+uhTgu6fdmWkVqgpzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f43HGbT/5psvgVHjCe+NTvKW9mAAFU3S4NGUUHk/tngWrLxYDksMwM1DkzJXWoResXE214ewn48bc36Si3jx+VvgjueSo1JRThLz/gCIQMHk2ZXrCk5GCuEIJ1gcCgnbtzbXK9zfBnrqz3xqzS/72dwR9sklM91G+56Jbf0iOLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 9522F2800C8ED;
	Wed, 10 Apr 2024 12:07:40 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 6FF4C44FAB0; Wed, 10 Apr 2024 12:07:40 +0200 (CEST)
Date: Wed, 10 Apr 2024 12:07:40 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Ricky WU <ricky_wu@realtek.com>
Cc: "scott@spiteful.org" <scott@spiteful.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"kbusch@kernel.org" <kbusch@kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [bug report] nvme not re-recognize when changed M.2 SSD in S3
 mode
Message-ID: <ZhZk7MMt_dm6avBJ@wunner.de>
References: <a608b5930d0a48f092f717c0e137454b@realtek.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a608b5930d0a48f092f717c0e137454b@realtek.com>

[cc += Mika]

On Tue, Apr 09, 2024 at 05:44:38AM +0000, Ricky WU wrote:
> I find some problem in S3 mode maybe S2idle has the same situation.
> The current situation is: Enter S3 mode I unplugged a correctly recognized
> Kingston A2000 250GB and switched it for a Intel 760p 256GB, when back to
> S0 there is also Kingston A2000 still installed.
> It did not call pciehp_ist(), pciehp_handle_presence_or_link_change() when
> back to S0, I don't know if this is the reason.

IIUC, you've got a regular PC with an ASRock H370M Pro 4 mainboard
which you suspended to S3, replaced the SSD and resumed.

And your point is that Linux doesn't notice the SSD was changed
during suspend.

For comparison, I think with Thunderbolt, a hotplug event is signaled
even during system sleep.  That's probably not possible on a Root Port
that's not powered in S3, despite it being hotplug-capable.

My guess is that S0ix would indeed behave differently here.  But it's
probably not safe to replace the SSD while the system is powered.

What we could do is check the Vendor ID and Device ID of the device
in the slot and compare it to what's cached in its struct pci_dev.
Below is a patch which does that.  Does it fix the issue for you?

This is just a heuristic, a poor man's way to detect a device change.

We could try to improve it by also checking the Subsystem Vendor ID
and Device ID, but that's only present in a Type 0 Config Space Header.
We could also try to check the Class Code and Revision ID, but it's
doubtful whether that's much of an improvement.
There's also the Device Serial Number, but it's optional and we're
not caching it right now.

If the device was replaced with an identical one (same Vendor ID and
Device ID), it's probably fine not to re-enumerate it.  If it was
indeed powered off (which is likely if the Root Port was powered off
as well), its driver will re-initialize it on resume and it will be
just as if it wasn't replaced.

Conceivably, the device driver might apply quirks based on the
Revision ID, Subsystem Vendor / Device ID or something else.
In that case it may handle the device incorrectly after resume
because it's not re-enumerated.  Again, this patch is just a
heuristic but probably an improvement on the status quo.

Anyway, here's the patch:

-- >8 --

diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index ddd55ad..ff19985 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -152,6 +152,25 @@ static int get_adapter_status(struct hotplug_slot *hotplug_slot, u8 *value)
 	return 0;
 }
 
+static bool pciehp_device_replaced(struct controller *ctrl)
+{
+	struct pci_dev *pdev;
+	u32 reg;
+
+	pdev = pci_get_slot(ctrl->pcie->port->subordinate, PCI_DEVFN(0, 0));
+	if (!pdev)
+		return true;
+
+	if (!pci_bus_read_dev_vendor_id(ctrl->pcie->port->subordinate,
+					PCI_DEVFN(0, 0), &reg, 0))
+		return true;
+
+	if (reg != (pdev->vendor | (pdev->device << 16)))
+		return true;
+
+	return false;
+}
+
 /**
  * pciehp_check_presence() - synthesize event if presence has changed
  * @ctrl: controller to check
@@ -172,7 +191,8 @@ static void pciehp_check_presence(struct controller *ctrl)
 
 	occupied = pciehp_card_present_or_link_active(ctrl);
 	if ((occupied > 0 && (ctrl->state == OFF_STATE ||
-			  ctrl->state == BLINKINGON_STATE)) ||
+			      ctrl->state == BLINKINGON_STATE ||
+			      pciehp_device_replaced(ctrl))) ||
 	    (!occupied && (ctrl->state == ON_STATE ||
 			   ctrl->state == BLINKINGOFF_STATE)))
 		pciehp_request(ctrl, PCI_EXP_SLTSTA_PDC);

