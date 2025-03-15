Return-Path: <linux-pci+bounces-23840-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BC2A62FC5
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 17:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB6667A411D
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 16:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BB9201270;
	Sat, 15 Mar 2025 16:04:17 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1CA17995E;
	Sat, 15 Mar 2025 16:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742054657; cv=none; b=pOo8HShUWWaehZ4j+Sw5hfnNUdOaykOAAHF/3ytgYkLDXWs+r4dgK8iYO2ZyzilXXnoPQtTIxAuZUst4sW52FESmPxvXtc7GmngmYLWsaeZ1wAJ3K8sAtu8ky5xWYzqBpj257qrQJTBhXKr8XiHJYuFHbO6969tpUrD3k6VD85U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742054657; c=relaxed/simple;
	bh=jCLcEAKOk+ffm3F5QK/1pdIOC2FtZ2xLKeqPv2n00MU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jc3lv0wsIGwYTKLwOTtmkUOH1ZpuGdqBCTkcmVh+0l95CSxJDVgxsmO6NlKAIRpGJvF9DH85kvJ19/EZme7PpJpp63WkB9j3PuqXuNQmcJz651o9rO1sTIxsMf//VT7is01pQAsG/E5cm3LTGTmvqMxs0C63y346yM0I2qZ3SnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id B71622800B4B2;
	Sat, 15 Mar 2025 16:58:11 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id A15C916BB0D; Sat, 15 Mar 2025 16:58:11 +0100 (CET)
Date: Sat, 15 Mar 2025 16:58:11 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Guenter Roeck <groeck@juniper.net>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Rajat Jain <rajatxjain@gmail.com>,
	Joel Mathew Thomas <proxy0@tutamail.com>,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/4] PCI/hotplug: Disable HPIE over reset
Message-ID: <Z9Wjk2GzrSURZoTG@wunner.de>
References: <20250313142333.5792-1-ilpo.jarvinen@linux.intel.com>
 <20250313142333.5792-2-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250313142333.5792-2-ilpo.jarvinen@linux.intel.com>

On Thu, Mar 13, 2025 at 04:23:30PM +0200, Ilpo Järvinen wrote:
> pciehp_reset_slot() disables PDCE (Presence Detect Changed Enable) and
> DLLSCE (Data Link Layer State Changed Enable) for the duration of reset
> and clears the related status bits PDC and DLLSC from the Slot Status
> register after the reset to avoid hotplug incorrectly assuming the card
> was removed.
> 
> However, hotplug shares interrupt with PME and BW notifications both of
> which can make pciehp_isr() to run despite PDCE and DLLSCE bits being
> off. pciehp_isr() then picks PDC or DLLSC bits from the Slot Status
> register due to the events that occur during reset and caches them into
> ->pending_events. Later, the IRQ thread in pciehp_ist() will process
> the ->pending_events and will assume the Link went Down due to a card
> change (in pciehp_handle_presence_or_link_change()).
> 
> Change pciehp_reset_slot() to also clear HPIE (Hot-Plug Interrupt
> Enable) as pciehp_isr() will first check HPIE to see if the interrupt
> is not for it. Then synchronize with the IRQ handling to ensure no
> events are pending, before invoking the reset.

After dwelling on this for a while, I'm thinking that it may re-introduce
the issue fixed by commit f5eff5591b8f ("PCI: pciehp: Fix AB-BA deadlock
between reset_lock and device_lock"):

Looking at the second and third stack trace in its commit message,
down_write(reset_lock) in pciehp_reset_slot() is basically equivalent
to synchronize_irq() and we're holding device_lock() at that point,
hindering progress of pciehp_ist().

So I think I have guided you in the wrong direction and I apologize
for that.

However it seems to me that this should be solvable with the small
patch below.  Am I missing something?

@Joel Mathew Thomas, could you give the below patch a spin and see
if it helps?

Thanks!

-- >8 --

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index bb5a8d9f03ad..99a2ac13a3d1 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -688,6 +688,11 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
 		return IRQ_HANDLED;
 	}
 
+	/* Ignore events masked by pciehp_reset_slot(). */
+	events &= ctrl->slot_ctrl;
+	if (!events)
+		return IRQ_HANDLED;
+
 	/* Save pending events for consumption by IRQ thread. */
 	atomic_or(events, &ctrl->pending_events);
 	return IRQ_WAKE_THREAD;

