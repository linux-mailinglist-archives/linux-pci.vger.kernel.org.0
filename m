Return-Path: <linux-pci+bounces-13563-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3DB987472
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2024 15:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 396D41F21C44
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2024 13:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEAD427473;
	Thu, 26 Sep 2024 13:29:37 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F8419BBC;
	Thu, 26 Sep 2024 13:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727357377; cv=none; b=WweniZLnyUsfCDepy4RzULC69wyRwymgRzeYd1TlQVdtkF9+QmepU9equUs0xttKN1fakA8DzN9FWtQHuydnJ0vKGDyGsjsWr2U+MBpCyN+6gJmU2HhvMnR3ku45DecOnFtvzNzp03HnIEiwX3Howl9yRqZKKxqWytZaPBikUOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727357377; c=relaxed/simple;
	bh=4Q7VZ5hROygratp34PdNOscE5YXzzq0eAG5EnRiblC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJJAhmUchJoev7UQdY9iECWuYiLXnzcFXlEIVXzam5VZcCtxtHe4QIgaysyOPY9gZ0RdAhHX1flYNOYlzIF7DdTslu8lsT1Zf4jciMxTErxO+AG/z8jdvvtys+IEn3XrAmQHjxVgd6gF5UvcXk9BeLJQ0Q3Qr2gkcbOocU7QlLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 44B4C30001EA9;
	Thu, 26 Sep 2024 15:23:24 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 2ED3018F60A; Thu, 26 Sep 2024 15:23:24 +0200 (CEST)
Date: Thu, 26 Sep 2024 15:23:24 +0200
From: Lukas Wunner <lukas@wunner.de>
To: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: pciehp: Fix system hang on resume after hot-unplug
 during suspend
Message-ID: <ZvVgTGVSco0Kg7H5@wunner.de>
References: <20240926125909.2362244-1-acelan.kao@canonical.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926125909.2362244-1-acelan.kao@canonical.com>

On Thu, Sep 26, 2024 at 08:59:09PM +0800, Chia-Lin Kao (AceLan) wrote:
> Remove unnecessary pci_walk_bus() call in pciehp_resume_noirq(). This
> fixes a system hang that occurs when resuming after a Thunderbolt dock
> with attached thunderbolt storage is unplugged during system suspend.
> 
> The PCI core already handles setting the disconnected state for devices
> under a port during suspend/resume.

Please explain in the commit message where the PCI core does that.

> The redundant bus walk was
> interfering with proper hardware state detection during resume, causing
> a system hang when hot-unplugging daisy-chained Thunderbolt devices.

Please explain what "proper hardware state detection" means.

Did you get a hung task stacktrace?  If so, please include it in the
commit message.

If you're getting a system hang, it means there's a deadlock
involving pci_bus_sem.  I don't quite see how that could happen,
so a more verbose explanation would be appreciated.

Thanks,

Lukas


> Fixes: 9d573d19547b ("PCI: pciehp: Detect device replacement during system sleep")
> Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
> ---
>  drivers/pci/hotplug/pciehp_core.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
> index ff458e692fed..c1c3f7e2bc43 100644
> --- a/drivers/pci/hotplug/pciehp_core.c
> +++ b/drivers/pci/hotplug/pciehp_core.c
> @@ -330,8 +330,6 @@ static int pciehp_resume_noirq(struct pcie_device *dev)
>  		 */
>  		if (pciehp_device_replaced(ctrl)) {
>  			ctrl_dbg(ctrl, "device replaced during system sleep\n");
> -			pci_walk_bus(ctrl->pcie->port->subordinate,
> -				     pci_dev_set_disconnected, NULL);
>  			pciehp_request(ctrl, PCI_EXP_SLTSTA_PDC);
>  		}
>  	}
> -- 
> 2.43.0

