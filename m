Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0CC9227115
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jul 2020 23:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbgGTVlh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Jul 2020 17:41:37 -0400
Received: from brightrain.aerifal.cx ([216.12.86.13]:34510 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728771AbgGTVlb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Jul 2020 17:41:31 -0400
Date:   Mon, 20 Jul 2020 17:41:28 -0400
From:   Rich Felker <dalias@libc.org>
To:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>
Cc:     helgaas@kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org
Subject: Re: [RFC PATCH 24/35] sh: Change PCIBIOS_SUCCESSFUL to 0
Message-ID: <20200720214128.GN14669@brightrain.aerifal.cx>
References: <20200713122247.10985-1-refactormyself@gmail.com>
 <20200713122247.10985-25-refactormyself@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713122247.10985-25-refactormyself@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 13, 2020 at 02:22:36PM +0200, Saheed O. Bolarinwa wrote:
> In reference to the PCI spec (Chapter 2), PCIBIOS* is an x86 concept.
> Their scope should be limited within arch/x86.
> 
> Change all PCIBIOS_SUCCESSFUL to 0
> 
> Signed-off-by: "Saheed O. Bolarinwa" <refactormyself@gmail.com>
> ---
>  arch/sh/drivers/pci/common.c        | 2 +-
>  arch/sh/drivers/pci/ops-dreamcast.c | 4 ++--
>  arch/sh/drivers/pci/ops-sh4.c       | 4 ++--
>  arch/sh/drivers/pci/ops-sh7786.c    | 8 ++++----
>  arch/sh/drivers/pci/pci.c           | 2 +-
>  5 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/sh/drivers/pci/common.c b/arch/sh/drivers/pci/common.c
> index fe163ecd0719..ee27cdfd3e68 100644
> --- a/arch/sh/drivers/pci/common.c
> +++ b/arch/sh/drivers/pci/common.c
> @@ -61,7 +61,7 @@ int __init pci_is_66mhz_capable(struct pci_channel *hose,
>  			continue;
>  		if (early_read_config_word(hose, top_bus, current_bus,
>  					   pci_devfn, PCI_VENDOR_ID, &vid) !=
> -		    PCIBIOS_SUCCESSFUL)
> +		    0)
>  			continue;
>  		if (vid == 0xffff)
>  			continue;
> diff --git a/arch/sh/drivers/pci/ops-dreamcast.c b/arch/sh/drivers/pci/ops-dreamcast.c
> index 517a8a9702f6..431cd006951f 100644
> --- a/arch/sh/drivers/pci/ops-dreamcast.c
> +++ b/arch/sh/drivers/pci/ops-dreamcast.c
> @@ -56,7 +56,7 @@ static int gapspci_read(struct pci_bus *bus, unsigned int devfn, int where, int
>  	case 4: *val = inl(GAPSPCI_BBA_CONFIG+where); break;
>  	}
>  
> -        return PCIBIOS_SUCCESSFUL;
> +	return 0;
>  }
>  
>  static int gapspci_write(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 val)
> @@ -70,7 +70,7 @@ static int gapspci_write(struct pci_bus *bus, unsigned int devfn, int where, int
>  	case 4: outl((u32)val, GAPSPCI_BBA_CONFIG+where); break;
>  	}
>  
> -        return PCIBIOS_SUCCESSFUL;
> +	return 0;
>  }
>  
>  struct pci_ops gapspci_pci_ops = {
> diff --git a/arch/sh/drivers/pci/ops-sh4.c b/arch/sh/drivers/pci/ops-sh4.c
> index a205be3bfc4a..4d757e5f38c6 100644
> --- a/arch/sh/drivers/pci/ops-sh4.c
> +++ b/arch/sh/drivers/pci/ops-sh4.c
> @@ -49,7 +49,7 @@ static int sh4_pci_read(struct pci_bus *bus, unsigned int devfn,
>  		return PCIBIOS_FUNC_NOT_SUPPORTED;
>  	}
>  
> -	return PCIBIOS_SUCCESSFUL;
> +	return 0;
>  }
>  
>  /*
> @@ -90,7 +90,7 @@ static int sh4_pci_write(struct pci_bus *bus, unsigned int devfn,
>  
>  	pci_write_reg(chan, data, SH4_PCIPDR);
>  
> -	return PCIBIOS_SUCCESSFUL;
> +	return 0;
>  }
>  
>  struct pci_ops sh4_pci_ops = {
> diff --git a/arch/sh/drivers/pci/ops-sh7786.c b/arch/sh/drivers/pci/ops-sh7786.c
> index a10f9f4ebd7f..7c329e467360 100644
> --- a/arch/sh/drivers/pci/ops-sh7786.c
> +++ b/arch/sh/drivers/pci/ops-sh7786.c
> @@ -52,7 +52,7 @@ static int sh7786_pcie_config_access(unsigned char access_type,
>  			else
>  				pci_write_reg(chan, *data, PCI_REG(reg));
>  
> -			return PCIBIOS_SUCCESSFUL;
> +			return 0;
>  		} else if (dev > 1)
>  			return PCIBIOS_DEVICE_NOT_FOUND;
>  	}
> @@ -83,7 +83,7 @@ static int sh7786_pcie_config_access(unsigned char access_type,
>  	/* Disable the configuration access */
>  	pci_write_reg(chan, 0, SH4A_PCIEPCTLR);
>  
> -	return PCIBIOS_SUCCESSFUL;
> +	return 0;
>  }
>  
>  static int sh7786_pcie_read(struct pci_bus *bus, unsigned int devfn,
> @@ -101,7 +101,7 @@ static int sh7786_pcie_read(struct pci_bus *bus, unsigned int devfn,
>  	raw_spin_lock_irqsave(&pci_config_lock, flags);
>  	ret = sh7786_pcie_config_access(PCI_ACCESS_READ, bus,
>  					devfn, where, &data);
> -	if (ret != PCIBIOS_SUCCESSFUL) {
> +	if (ret != 0) {
>  		*val = 0xffffffff;
>  		goto out;
>  	}
> @@ -137,7 +137,7 @@ static int sh7786_pcie_write(struct pci_bus *bus, unsigned int devfn,
>  	raw_spin_lock_irqsave(&pci_config_lock, flags);
>  	ret = sh7786_pcie_config_access(PCI_ACCESS_READ, bus,
>  					devfn, where, &data);
> -	if (ret != PCIBIOS_SUCCESSFUL)
> +	if (ret != 0)
>  		goto out;
>  
>  	dev_dbg(&bus->dev, "pcie-config-write: bus=%3d devfn=0x%04x "
> diff --git a/arch/sh/drivers/pci/pci.c b/arch/sh/drivers/pci/pci.c
> index c7784e156964..77130f035fdd 100644
> --- a/arch/sh/drivers/pci/pci.c
> +++ b/arch/sh/drivers/pci/pci.c
> @@ -204,7 +204,7 @@ pcibios_bus_report_status_early(struct pci_channel *hose,
>  			continue;
>  		ret = early_read_config_word(hose, top_bus, current_bus,
>  					     pci_devfn, PCI_STATUS, &status);
> -		if (ret != PCIBIOS_SUCCESSFUL)
> +		if (ret != 0)
>  			continue;
>  		if (status == 0xffff)
>  			continue;
> -- 
> 2.18.2

Acked-by: Rich Felker <dalias@libc.org>

(for both this and the following one in the series)
