Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB3D48C774
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jan 2022 16:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354737AbiALPnY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jan 2022 10:43:24 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:44234 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242234AbiALPnO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jan 2022 10:43:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A9EAFB81F68;
        Wed, 12 Jan 2022 15:43:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 170D6C36AE5;
        Wed, 12 Jan 2022 15:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642002192;
        bh=Zg7ygGz6sOLlajsI3tjCRIWEiEwQ+qlt2jgeme43mro=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=a/4hVBsxpAOcJv+atUaGlJNYXSbgn93sjNGu4mtwH2sATr9mEbgWoYeH7Jo+8A2vt
         pDOrNTzTjquuuQh26/TKbaDqmVekQHzAnkC9NjlrsOwqVLxrisSNLsE3enZQbg6RH7
         eUW27COvQai1RQ9UR+qgU0zdXjulxU2XIHLqBI8W8m16v9KqnFd3PwwQffLl+snpkw
         0tPXsRdOYNZuNVbEHl6RdBk+/GRqnveGEMw+f9zLn3iZNq8dxFWOa2FTP4R4Ncht0N
         zcQjdBok8gXbaHz346NK4GgdbGPkXlOk6xXPQXmwfExQbkNohEk6D92p5Gjz5XVXJv
         kAVez7FWOqRFQ==
Date:   Wed, 12 Jan 2022 09:43:10 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yao Hongbo <yaohongbo@linux.alibaba.com>
Cc:     bhelgaas@google.com, zhangliguang@linux.alibaba.com,
        alikernel-developer@linux.alibaba.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] PCI: Add "pci=reassign_all_bus" boot parameter
Message-ID: <20220112154310.GA259954@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1640856613-101412-1-git-send-email-yaohongbo@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 30, 2021 at 05:30:13PM +0800, Yao Hongbo wrote:
> PCI bridges may be misconfigured by te system BIOS, and then the OS
> scan the bridges that need to be reconfigured.
> However, the PCI bus topology configured by the bios may be wrong:
> 
> [   19.376273] pci 0000:40:00.0: bridge configuration invalid ([bus
> 00-00]), reconfiguring
> [   19.384443] pci_bus 0000:47: busn_res: can not insert [bus 47-46]
> under [bus 40-46] (conflicts with (null) [bus 40-46])
> 
> The primary bus number and subordinate bus number written by the bios
> were wrong, and the OS continues to add bridges on the wrong bus
> topology.
> 
> In order to avoid such problems, a kernel cmdline needs to be
> added to support the os to fully configure the pci bus.

Why can't we make Linux smart enough to fix this by itself, without
forcing the user to boot with "pci=reassign_all_bus"?

> Signed-off-by: Yao Hongbo <yaohongbo@linux.alibaba.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 1 +
>  drivers/acpi/pci_root.c                         | 3 +++
>  drivers/pci/pci.c                               | 5 +++++
>  include/linux/pci.h                             | 2 ++
>  4 files changed, 11 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 2fba824..c83a2e5 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4084,6 +4084,7 @@
>  		nomio		[S390] Do not use MIO instructions.
>  		norid		[S390] ignore the RID field and force use of
>  				one PCI domain per PCI function
> +		reassign_all_bus	The OS fully configure the PCI bus.
>  
>  	pcie_aspm=	[PCIE] Forcibly enable or disable PCIe Active State Power
>  			Management.
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index ab2f7df..e21ac25 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -592,6 +592,9 @@ static int acpi_pci_root_add(struct acpi_device *device,
>  	is_pcie = strcmp(acpi_device_hid(device), "PNP0A08") == 0;
>  	negotiate_os_control(root, &no_aspm, is_pcie);
>  
> +	if (pci_reassign_all_bus)
> +		pci_add_flags(PCI_REASSIGN_ALL_BUS);
> +
>  	/*
>  	 * TBD: Need PCI interface for enumeration/configuration of roots.
>  	 */
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 3d2fb39..5746e88 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -142,6 +142,9 @@ bool pci_reset_supported(struct pci_dev *dev)
>  /* If set, the PCI config space of each device is printed during boot. */
>  bool pci_early_dump;
>  
> +/* If set, the pci will reassign resources*/
> +bool pci_reassign_all_bus;
> +
>  bool pci_ats_disabled(void)
>  {
>  	return pcie_ats_disabled;
> @@ -6846,6 +6849,8 @@ static int __init pci_setup(char *str)
>  				pci_add_flags(PCI_SCAN_ALL_PCIE_DEVS);
>  			} else if (!strncmp(str, "disable_acs_redir=", 18)) {
>  				disable_acs_redir_param = str + 18;
> +			} else if (!strncmp(str, "reassign_all_bus", 16)) {
> +				pci_reassign_all_bus = true;
>  			} else {
>  				pr_err("PCI: Unknown option `%s'\n", str);
>  			}
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 18a75c8e..ad0e3e9 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2119,6 +2119,8 @@ int pcim_iomap_regions_request_all(struct pci_dev *pdev, int mask,
>  extern u8 pci_dfl_cache_line_size;
>  extern u8 pci_cache_line_size;
>  
> +extern bool pci_reassign_all_bus;
> +
>  /* Architecture-specific versions may override these (weak) */
>  void pcibios_disable_device(struct pci_dev *dev);
>  void pcibios_set_master(struct pci_dev *dev);
> -- 
> 1.8.3.1
> 
