Return-Path: <linux-pci+bounces-23721-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD643A60BAD
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 09:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A39419C1F8F
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 08:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C3418A6B2;
	Fri, 14 Mar 2025 08:32:54 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9151C862E;
	Fri, 14 Mar 2025 08:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741941174; cv=none; b=amw24gSdtmFHF+/Em7qFd+XPsmaes3apWbSMnHGm5nDDrcstliFh5uiUlasIvr9Mogd6JUweaff7Ecvu64Z+f6sAHHqjvPmJEP+ScKSxaMK4oz2TGa1cLZjwuy5gGG+5O4dNPsO8diwxZ2vff/qfOzryQGLGt1X4Xk2TNA76ZHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741941174; c=relaxed/simple;
	bh=MOrnk0Qp328GYxb+Li/Avejp1YhRukc3wwHbN6pL8eA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fp0sSyzzpxnTSGdPpHIx8EIM0G0nNpA5w6nUOmb4WbHC3zk7HNTtmpix6KpdbdfClr4hc8q/mUJXF/tv3+O0hQYoHvsqLBn9JQlZY+T2F/Ctqd8yw6WE6izRikFEmJD+N2tBu3K033Ug9+9Hgh7ALJ7Y/kpZMlLzNOEmn65jbE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id C4E1E100FBF26;
	Fri, 14 Mar 2025 09:32:47 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 92DB8100E1; Fri, 14 Mar 2025 09:32:47 +0100 (CET)
Date: Fri, 14 Mar 2025 09:32:47 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Guenter Roeck <groeck@juniper.net>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Rajat Jain <rajatxjain@gmail.com>,
	Joel Mathew Thomas <proxy0@tutamail.com>,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 3/4] PCI/hotplug: reset_lock is not required
 synchronizing with irq thread
Message-ID: <Z9Ppr63yDUhOF1Xo@wunner.de>
References: <20250313142333.5792-1-ilpo.jarvinen@linux.intel.com>
 <20250313142333.5792-4-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250313142333.5792-4-ilpo.jarvinen@linux.intel.com>

On Thu, Mar 13, 2025 at 04:23:32PM +0200, Ilpo Järvinen wrote:
> Disabling HPIE (Hot-Plug Interrupt Enable) and synchronizing with irq
> handling in pciehp_reset_slot() is enough to ensure no pending events
> are processed during the slot reset. Thus, there is no need to take
> reset_lock in the IRQ thread.
[...]
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -748,12 +748,10 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
>  	 * Disable requests have higher priority than Presence Detect Changed
>  	 * or Data Link Layer State Changed events.
>  	 */
> -	down_read_nested(&ctrl->reset_lock, ctrl->depth);
>  	if (events & DISABLE_SLOT)
>  		pciehp_handle_disable_request(ctrl);
>  	else if (events & (PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC))
>  		pciehp_handle_presence_or_link_change(ctrl, events);
> -	up_read(&ctrl->reset_lock);
>  
>  	ret = IRQ_HANDLED;
>  out:

The release and re-acquisition of reset_lock in
pciehp_configure_device() and pciehp_unconfigure_device()
needs to be removed as well if the above hunk is applied.

But please wait a little while before respinning so that I can
think through the whole series.

Thanks,

Lukas

