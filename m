Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F008D407DA9
	for <lists+linux-pci@lfdr.de>; Sun, 12 Sep 2021 15:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235291AbhILNeC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 12 Sep 2021 09:34:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:33170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235178AbhILNeC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 12 Sep 2021 09:34:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D8D8C60F5D;
        Sun, 12 Sep 2021 13:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631453568;
        bh=cKQEhXb0SCLU/htoFmTwh5ClJ7S0cV5ysGMhszIIQGg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=r/ay00JuVXs+pr0XkMxfUyWIQ036lMKou+T+hkFtXAYpd97LJaJHSgxNthudT7yqe
         3ObokYwDoTUplbENn8EvwT2Lb/tYV4QuxWzkwoH6k+6tmfpabw7fKgAEFmgfwhuAe8
         KBEEuaxoW2KLDreUeAxYSrFqnb8wXZ6sll0rdlxBd9ReOTC94ympBpDAFxX7h3GZNa
         NcEqrr6HQd++42V3oX74ZHBB80LPtb2FT4hKhw1OhkTqTkhvy33+uM4xvr73/U4NlX
         IAV2pYzOicU5WMAk22c99FDQlifkNp+gxcYOhdXWpbBsDBEUfhpErQC6XHkhdNOwMg
         1oD7f/n3An9LQ==
Date:   Sun, 12 Sep 2021 08:32:46 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Stanislav Spassov <stanspas@amazon.com>
Cc:     linux-pci@vger.kernel.org, Stanislav Spassov <stanspas@amazon.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan H =?iso-8859-1?Q?=2E_Sch=F6nherr?= <jschoenh@amazon.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Ashok Raj <ashok.raj@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Sinan Kaya <okaya@kernel.org>, Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH v4 2/3] PCI: Cache CRS Software Visibiliy in struct
 pci_dev
Message-ID: <20210912133246.GA1279483@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200307172044.29645-3-stanspas@amazon.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Mar 07, 2020 at 06:20:43PM +0100, Stanislav Spassov wrote:
> From: Stanislav Spassov <stanspas@amazon.de>
> 
> Arguably, since CRS SV is a capability of Root Ports and determines
> how Root Ports will handle incoming CRS Completions, it makes more
> sense to store this flag in the struct pci_bus that represents the
> port's secondary bus, and to cache it in any buses further down the
> hierarchy.
> 
> However, storing the flag in struct pci_dev allows individual devices
> to be marked as not supporting CRS properly even when CRS SV is enabled
> on their parent Root Port. This way, future code that relies on the new
> flag will not be misled that it is safe to probe a device by relying on
> CRS SV to not cause platform timeouts (See the note on CRS SV on p. 553
> of PCI Express Base Specification r5.0 from May 22, 2019).

If we find devices that don't support CRS properly, I think we should
quirk them directly with something other than "crssv_enabled".

> Note: Endpoints integrated into the Root Complex (RCiEP) may also be
> capable of using CRS. In that case, the software visibility is
> controlled using a Root Complex Register Block (RCRB). This is currently
> not supported by the kernel. The code introduced here would simply not
> set the newly introduced flag for RCiEP as for those bus->self is NULL.
> 
> Signed-off-by: Stanislav Spassov <stanspas@amazon.de>
> ---
>  drivers/pci/probe.c | 8 +++++++-
>  include/linux/pci.h | 3 +++
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 512cb4312ddd..eeff8a07f330 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1080,9 +1080,11 @@ static void pci_enable_crs(struct pci_dev *pdev)
>  
>  	/* Enable CRS Software Visibility if supported */
>  	pcie_capability_read_word(pdev, PCI_EXP_RTCAP, &root_cap);
> -	if (root_cap & PCI_EXP_RTCAP_CRSVIS)
> +	if (root_cap & PCI_EXP_RTCAP_CRSVIS) {
>  		pcie_capability_set_word(pdev, PCI_EXP_RTCTL,
>  					 PCI_EXP_RTCTL_CRSSVE);
> +		pdev->crssv_enabled = true;

I'd use "crssv_enabled = 1" instead of mixing the "unsigned int" and
"bool" ideas.

> +	}
>  }
>  
>  static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
> @@ -2414,6 +2416,10 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
>  	list_add_tail(&dev->bus_list, &bus->devices);
>  	up_write(&pci_bus_sem);
>  
> +	/* Propagate CRS Software Visibility bit from the parent bridge */
> +	if (bus->self)
> +		dev->crssv_enabled = bus->self->crssv_enabled;

I think we should use pcie_find_root_port() instead of propagating it.
SV is a property of the Root Port, and devices below it have no idea
whether it's enabled at the Root Port.

>  	ret = pcibios_add_device(dev);
>  	WARN_ON(ret < 0);
>  
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 3840a541a9de..1c222c7c2572 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -354,6 +354,9 @@ struct pci_dev {
>  						      user sysfs */
>  	unsigned int	clear_retrain_link:1;	/* Need to clear Retrain Link
>  						   bit manually */
> +	unsigned int	crssv_enabled:1;	/* Configuration Request Retry
> +						   Status Software Visibility
> +						   enabled on (parent) bridge */
>  	unsigned int	d3_delay;	/* D3->D0 transition time in ms */
>  	unsigned int	d3cold_delay;	/* D3cold->D0 transition time in ms */
>  
> -- 
> 2.25.1
> 
> 
> 
> 
> Amazon Development Center Germany GmbH
> Krausenstr. 38
> 10117 Berlin
> Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
> Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
> Sitz: Berlin
> Ust-ID: DE 289 237 879
> 
> 
> 
