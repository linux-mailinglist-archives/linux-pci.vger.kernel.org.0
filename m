Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9946C148EB7
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2020 20:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390723AbgAXTbq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jan 2020 14:31:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:37158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390186AbgAXTbp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Jan 2020 14:31:45 -0500
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B3052071E;
        Fri, 24 Jan 2020 19:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579894304;
        bh=Yos5tOqea+lsAAg57si5E3RrTRdqcrub8CC4qYiRuSk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=2cLe8SweJIHy2T6kvegl/tSdIhGCnodJPelsnrD/+GIr+l5Eh8wFzncfimSpKwOXF
         Cy6kRqRyGgCs9PNjQaYHbr0u6XTqmmZc8FSDUw0gNvisxH4UxYIdnB1ZEbKr3ORfpD
         3gygHmN1C91zWJMsePZ/L/lKWZayg61worbQb87o=
Date:   Fri, 24 Jan 2020 13:31:42 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     linux-pci@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH][RFC] PCI: Add "pci=blacklist_dev=" parameter to
 blacklist specific devices
Message-ID: <20200124193142.GA33298@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124144248.11719-1-yu.c.chen@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 24, 2020 at 10:42:48PM +0800, Chen Yu wrote:
> It was found that on some platforms the bogus pci device might bring
> troubles to the system. For example, on a MacBookPro the system could
> not be power off or suspended due to internal pci resource confliction
> between bogus pci device and [io 0x1804]. Another case is that, once
> resumed from hibernation on a VM, the pci config space of a pci device
> is corrupt.
> 
> To narrow down and benefit future debugging for such kind of issues,
> introduce the command line blacklist_dev=<vendor:device_id>> to blacklist
> such pci devices thus they will not be scanned thus not visible after
> bootup. For example,
> 
>  pci.blacklist_dev=8086:293e
> 
> forbid the audio device to be exposed to the OS.

I'm not really a fan of this.  I'd rather see some details about what
the problem is so we can actually fix it.

Ignoring the device doesn't mean the device is removed or even
inactive.  It may still be consuming address space that we need to
avoid.

Can you point us to bug reports about the issues you mentioned?

> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  6 ++++++
>  drivers/pci/pci.c                               | 17 +++++++++++++++++
>  drivers/pci/pci.h                               |  1 +
>  drivers/pci/probe.c                             |  3 +++
>  4 files changed, 27 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index ade4e6ec23e0..cd4a47e236aa 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3583,6 +3583,12 @@
>  				may put more devices in an IOMMU group.
>  		force_floating	[S390] Force usage of floating interrupts.
>  		nomio		[S390] Do not use MIO instructions.
> +		blacklist_dev=<vendor:device_id>[; ...]
> +				Specify one or more PCI devices (in the format
> +				specified above) separated by semicolons.
> +				Each device specified will not be scanned thus
> +				will be invisible after boot up. This can be
> +				used for debugging purpose.
>  
>  	pcie_aspm=	[PCIE] Forcibly enable or disable PCIe Active State Power
>  			Management.
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e87196cc1a7f..0e3626a401f4 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6393,6 +6393,19 @@ void __weak pci_fixup_cardbus(struct pci_bus *bus)
>  }
>  EXPORT_SYMBOL(pci_fixup_cardbus);
>  
> +static const char *pci_blacklist_devs_param;
> +
> +bool pci_is_blacklist_dev(unsigned short vendor, unsigned short device)
> +{
> +	char search[10];
> +
> +	if (!pci_blacklist_devs_param)
> +		return false;
> +	sprintf(search, "%x:%x", vendor, device);
> +
> +	return strstr(pci_blacklist_devs_param, search) ? true : false;
> +}
> +
>  static int __init pci_setup(char *str)
>  {
>  	while (str) {
> @@ -6451,6 +6464,8 @@ static int __init pci_setup(char *str)
>  				pci_add_flags(PCI_SCAN_ALL_PCIE_DEVS);
>  			} else if (!strncmp(str, "disable_acs_redir=", 18)) {
>  				disable_acs_redir_param = str + 18;
> +			} else if (!strncmp(str, "blacklist_dev=", 14)) {
> +				pci_blacklist_devs_param = str + 14;
>  			} else {
>  				pr_err("PCI: Unknown option `%s'\n", str);
>  			}
> @@ -6476,6 +6491,8 @@ static int __init pci_realloc_setup_params(void)
>  					   GFP_KERNEL);
>  	disable_acs_redir_param = kstrdup(disable_acs_redir_param, GFP_KERNEL);
>  
> +	pci_blacklist_devs_param = kstrdup(pci_blacklist_devs_param, GFP_KERNEL);
> +
>  	return 0;
>  }
>  pure_initcall(pci_realloc_setup_params);
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index a0a53bd05a0b..01b8ab2da065 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -669,4 +669,5 @@ static inline int pci_acpi_program_hp_params(struct pci_dev *dev)
>  extern const struct attribute_group aspm_ctrl_attr_group;
>  #endif
>  
> +bool pci_is_blacklist_dev(unsigned short vendor, unsigned short device);
>  #endif /* DRIVERS_PCI_H */
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 512cb4312ddd..812ef901ecea 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2271,6 +2271,9 @@ static struct pci_dev *pci_scan_device(struct pci_bus *bus, int devfn)
>  	if (!pci_bus_read_dev_vendor_id(bus, devfn, &l, 60*1000))
>  		return NULL;
>  
> +	if (pci_is_blacklist_dev(l & 0xffff, (l >> 16) & 0xffff))
> +		return NULL;
> +
>  	dev = pci_alloc_dev(bus);
>  	if (!dev)
>  		return NULL;
> -- 
> 2.17.1
> 
