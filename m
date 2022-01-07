Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB1E34872EC
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jan 2022 07:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbiAGGDP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Jan 2022 01:03:15 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:47255 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232763AbiAGGDO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Jan 2022 01:03:14 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R751e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=yaohongbo@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0V19Yyfg_1641535391;
Received: from 30.225.24.141(mailfrom:yaohongbo@linux.alibaba.com fp:SMTPD_---0V19Yyfg_1641535391)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 07 Jan 2022 14:03:12 +0800
Message-ID: <24d3294b-2d22-3f68-e280-a833879c69b1@linux.alibaba.com>
Date:   Fri, 7 Jan 2022 14:03:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [RFC PATCH] PCI: Add "pci=reassign_all_bus" boot parameter
To:     bhelgaas@google.com
Cc:     zhangliguang@linux.alibaba.com,
        alikernel-developer@linux.alibaba.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1640856613-101412-1-git-send-email-yaohongbo@linux.alibaba.com>
From:   Yao Hongbo <yaohongbo@linux.alibaba.com>
In-Reply-To: <1640856613-101412-1-git-send-email-yaohongbo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Bjorn,
Gentel ping! Any comments on this patch?

I think this is useful to find whether there is a problem with
the PCI enumeration of the bios or the OS.

在 2021/12/30 下午5:30, Yao Hongbo 写道:
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
> 
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
