Return-Path: <linux-pci+bounces-6807-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED508B61F7
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 21:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA0AC1F25487
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 19:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23B2839FD;
	Mon, 29 Apr 2024 19:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/kCFbSs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA0A12B73
	for <linux-pci@vger.kernel.org>; Mon, 29 Apr 2024 19:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714418671; cv=none; b=RJ/on2sMbc1bTpczJnNboCzHRYJ5gbbAs7pIq6sMEGWnGcwk+YYa/CGvjJ8Eqj1O4j5abfUeVXPc9Q4xUKId1q3NISunoutA/sRnha1akxHdZ0GQaxkr+hOwDDWYWKvYfWJTitUAhywoIZm8y+aU5D6phpA2NWUEytIZdK8aucY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714418671; c=relaxed/simple;
	bh=Ud8VbGAaHp8m6O+MnFOeLLqLRWdk6hjvmzQw/Dlg+GU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pg1cWzovL/WyHhS7Sb2qkPrWmEGhsOiXogf3PHkl5myeDHMAsFN68X1/N5QgfFrnlQr8Zqxef400xzOA1SuYTQT0yIQ3/JxVaJ1sQMyvZoHi/iRrP+9hpa42YOhWHag824uQz47q3GWdkyz0buOGR4kn7oABiVXl5Yun1ZE226E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/kCFbSs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1604FC113CD;
	Mon, 29 Apr 2024 19:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714418671;
	bh=Ud8VbGAaHp8m6O+MnFOeLLqLRWdk6hjvmzQw/Dlg+GU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y/kCFbSsH4zgWnqLI7y4BdSjNRB/bOioFAMN04m/PwNmLPS7voCJIoo7NkJrE0Ibm
	 hSbCZCEr83dQnr2waifvv8SY9a3nAxA/ZR6Duc5Q87UF43HR3e+9gEz14kkU9ZF8ix
	 0Yf9bhNQ8A6geIxPHCJur/8aFyIcImSF8OmsiC4X0mSWtOuel1xPDtmwb36iC1hHSD
	 t5BZoLFqHW4TCk2I+pdqZ8F4kUjCDXhpQ21Aa1DdG6wDxU1zAWQlTEWSP7+txqTB1f
	 tcj/ZBT4OMpK6mjntAwO0L4Op6f9oDI6MJM76bRumvfFHAcuGl1aihUQpaXb+JRKEH
	 C9M2GuIxdwbfg==
Received: by pali.im (Postfix)
	id 150027BA; Mon, 29 Apr 2024 21:24:28 +0200 (CEST)
Date: Mon, 29 Apr 2024 21:24:27 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH 02/10] PCI: Add helpers to calculate PCI Conf Type 0/1
 addresses
Message-ID: <20240429192427.uqat6ix4opwwvqg6@pali>
References: <20240429104633.11060-1-ilpo.jarvinen@linux.intel.com>
 <20240429104633.11060-3-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240429104633.11060-3-ilpo.jarvinen@linux.intel.com>
User-Agent: NeoMutt/20180716

On Monday 29 April 2024 13:46:25 Ilpo Järvinen wrote:
> Many places in arch and PCI controller code need to calculate PCI
> Configuration Space Addresses for Type 0/1 accesses. There are small
> variations between archs when it comes to bits outside of [10:2] (Type
> 0) and [24:2] (Type 1) but the basic calculation can still be
> generalized.
> 
> drivers/pci/pci.h has PCI_CONF1{,_EXT}_ADDRESS() but due to their
> location the use is limited to PCI subsys and the also always enable
> PCI_CONF1_ENABLE which is not what all the callers want.
> 
> Add generic pci_conf{0,1}_addr() and pci_conf1_ext_addr() helpers into
> include/linux/pci.h which can be reused by various parts of the kernel
> that have to calculate PCI Conf Type 0/1 addresses.
> 
> The PCI_CONF* defines are needed by the new helpers so move also them
> to include/linux/pci.h. The new helpers use true bitmasks and
> FIELD_PREP() instead of open coded masking and shifting so adjust
> PCI_CONF* definitions to match that.

I introduced these PCI_CONF* macros years ago. At that time I studied
more sources and drivers what they use. To make it clear I will first
try to explain few things. Hopefully I do not write mistakes here, it is
longer time.

Configuration mechanism is a SW API which allows access config space.
Configuration access command is on-wire "format" which allows HW bus to
access config space.

There are two standardized configuration mechanisms #1 and #2. #2 was
removed in PCI 3.0 spec and is out of scope (there are no macros for
them). #1 uses pair of I/O registers (on x86 they are CF8 and CFC; on
ARM they are whatever vendor invented). There is an extension of #1
which uses few reserved bits to describe config space registers above
255. Then there is standardized PCIe ECAM. And then there are lot of
proprietary vendor specific ways. Proprietary vendor way can be for
example composing PCIe packet manually or composing configuration access
command manually.

There are two configuration space access commands: type 0 and type 1.
It is required to issue correct command type based on topology of the
endpoint device. When mechanism #1 is used then it is HW who generate
these commands and it takes care to correctly choose type 0 or 1. But if
some vendor specific mechanism is used which requires SW to compose
access command manually then SW is responsible for correct choose.


In your change you have mixed configuration mechanism #1 together with
configuration command for type 0. This is really a problem as it makes
the code harder to understand and even hard to figure out how to write a
new driver (e.g. how to compose configuration command for type 1?).
Also it took me a little bit more time to understand your change.
Format of command for type 1 and format of configuration mechanism #1
really looks very similar. So there can be a confusion. Bit 31 is a key
there.

I understand that you want to unify drivers, so I would suggest to not
change existing macros for configuration mechanism #1 and #1-ext.
And rather create new macros (or functions) for composing configuration
commands.

This makes it explicitly clear that particular PCI or PCIe controller HW
requires SW driver to compose configuration command (type 0 and 1). Or
that HW requires from SW to compose format of configuration mechanism #1
(or #1-ext). Also it would make pci controller drivers more readable as
from the macro/function it would be easy to understand what it is doing.

Also important is that if you are in pci controller driver composing
command for type 0 then with very high probability the HW is designed in
a way that it requires from SW to also compose command type 1. And it
would be an mistake if the driver compose only type 0 or type 1. I
remember from the past an issue: why endpoint PCIe card is working, but
it is not working if it is connected behind PCIe switch. (mistake was:
HW was always sending type 0 command due to SW issue)

> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/pci/pci.h   | 43 ++---------------------
>  include/linux/pci.h | 85 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 88 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 17fed1846847..cf0530a60105 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -833,49 +833,12 @@ struct pci_devres {
>  
>  struct pci_devres *find_pci_dr(struct pci_dev *pdev);
>  
> -/*
> - * Config Address for PCI Configuration Mechanism #1
> - *
> - * See PCI Local Bus Specification, Revision 3.0,
> - * Section 3.2.2.3.2, Figure 3-2, p. 50.
> - */
> -
> -#define PCI_CONF1_BUS_SHIFT	16 /* Bus number */
> -#define PCI_CONF1_DEV_SHIFT	11 /* Device number */
> -#define PCI_CONF1_FUNC_SHIFT	8  /* Function number */
> -
> -#define PCI_CONF1_BUS_MASK	0xff
> -#define PCI_CONF1_DEV_MASK	0x1f
> -#define PCI_CONF1_FUNC_MASK	0x7
> -#define PCI_CONF1_REG_MASK	0xfc /* Limit aligned offset to a maximum of 256B */
> -
> -#define PCI_CONF1_ENABLE	BIT(31)
> -#define PCI_CONF1_BUS(x)	(((x) & PCI_CONF1_BUS_MASK) << PCI_CONF1_BUS_SHIFT)
> -#define PCI_CONF1_DEV(x)	(((x) & PCI_CONF1_DEV_MASK) << PCI_CONF1_DEV_SHIFT)
> -#define PCI_CONF1_FUNC(x)	(((x) & PCI_CONF1_FUNC_MASK) << PCI_CONF1_FUNC_SHIFT)
> -#define PCI_CONF1_REG(x)	((x) & PCI_CONF1_REG_MASK)
> -
>  #define PCI_CONF1_ADDRESS(bus, dev, func, reg) \
>  	(PCI_CONF1_ENABLE | \
> -	 PCI_CONF1_BUS(bus) | \
> -	 PCI_CONF1_DEV(dev) | \
> -	 PCI_CONF1_FUNC(func) | \
> -	 PCI_CONF1_REG(reg))
> -
> -/*
> - * Extension of PCI Config Address for accessing extended PCIe registers
> - *
> - * No standardized specification, but used on lot of non-ECAM-compliant ARM SoCs
> - * or on AMD Barcelona and new CPUs. Reserved bits [27:24] of PCI Config Address
> - * are used for specifying additional 4 high bits of PCI Express register.
> - */
> -
> -#define PCI_CONF1_EXT_REG_SHIFT	16
> -#define PCI_CONF1_EXT_REG_MASK	0xf00
> -#define PCI_CONF1_EXT_REG(x)	(((x) & PCI_CONF1_EXT_REG_MASK) << PCI_CONF1_EXT_REG_SHIFT)
> +	 pci_conf1_addr(bus, PCI_DEVFN(dev, func), reg & ~0x3U))
>  
>  #define PCI_CONF1_EXT_ADDRESS(bus, dev, func, reg) \
> -	(PCI_CONF1_ADDRESS(bus, dev, func, reg) | \
> -	 PCI_CONF1_EXT_REG(reg))
> +	(PCI_CONF1_ENABLE | \
> +	 pci_conf1_ext_addr(bus, PCI_DEVFN(dev, func), reg & ~0x3U))
>  
>  #endif /* DRIVERS_PCI_H */
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 16493426a04f..4c4e3bb52a0a 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -26,6 +26,8 @@
>  #include <linux/args.h>
>  #include <linux/mod_devicetable.h>
>  
> +#include <linux/bits.h>
> +#include <linux/bitfield.h>
>  #include <linux/types.h>
>  #include <linux/init.h>
>  #include <linux/ioport.h>
> @@ -1183,6 +1185,89 @@ void pci_sort_breadthfirst(void);
>  #define dev_is_pci(d) ((d)->bus == &pci_bus_type)
>  #define dev_is_pf(d) ((dev_is_pci(d) ? to_pci_dev(d)->is_physfn : false))
>  
> +/*
> + * Config Address for PCI Configuration Mechanism #0/1
> + *
> + * See PCI Local Bus Specification, Revision 3.0,
> + * Section 3.2.2.3.2, Figure 3-1 and 3-2, p. 48-50.
> + */
> +#define PCI_CONF_REG		0x000000ffU	/* common for Type 0/1 */
> +#define PCI_CONF_FUNC		0x00000700U	/* common for Type 0/1 */
> +#define PCI_CONF1_DEV		0x0000f800U
> +#define PCI_CONF1_BUS		0x00ff0000U
> +#define PCI_CONF1_ENABLE	BIT(31)
> +
> +/**
> + * pci_conf0_addr - PCI Base Configuration Space address for Type 0 access
> + * @devfn:      Device and function numbers (device number will be ignored)
> + * @reg:        Base configuration space offset
> + *
> + * Calculates the PCI Configuration Space address for Type 0 accesses.
> + *
> + * Note: the caller is responsible for adding the bits outside of [10:0].
> + *
> + * Return: Base Configuration Space address.
> + */
> +static inline u32 pci_conf0_addr(u8 devfn, u8 reg)
> +{
> +	return FIELD_PREP(PCI_CONF_FUNC, PCI_FUNC(devfn)) |
> +	       FIELD_PREP(PCI_CONF_REG, reg & ~3);
> +}
> +
> +/**
> + * pci_conf1_addr - PCI Base Configuration Space address for Type 1 access
> + * @bus:	Bus number of the device
> + * @devfn:	Device and function numbers
> + * @reg:	Base configuration space offset
> + * @enable:	Assert enable bit (bit 31)
> + *
> + * Calculates the PCI Base Configuration Space (first 256 bytes) address for
> + * Type 1 accesses.
> + *
> + * Note: the caller is responsible for adding the bits outside of [24:2]
> + * and enable bit.
> + *
> + * Return: PCI Base Configuration Space address.
> + */
> +static inline u32 pci_conf1_addr(u8 bus, u8 devfn, u8 reg, bool enable)
> +{
> +	return (enable ? PCI_CONF1_ENABLE : 0) |
> +	       FIELD_PREP(PCI_CONF1_BUS, bus) |
> +	       FIELD_PREP(PCI_CONF1_DEV | PCI_CONF_FUNC, devfn) |
> +	       FIELD_PREP(PCI_CONF_REG, reg & ~3);
> +}
> +
> +/*
> + * Extension of PCI Config Address for accessing extended PCIe registers
> + *
> + * No standardized specification, but used on lot of non-ECAM-compliant ARM SoCs
> + * or on AMD Barcelona and new CPUs. Reserved bits [27:24] of PCI Config Address
> + * are used for specifying additional 4 high bits of PCI Express register.
> + */
> +#define PCI_CONF1_EXT_REG	0x0f000000UL
> +
> +/**
> + * pci_conf1_ext_addr - PCI Configuration Space address for Type 1 access
> + * @bus:	Bus number of the device
> + * @devfn:	Device and function numbers
> + * @reg:	Base or Extended Configuration space offset
> + * @enable:	Assert enable bit (bit 31)
> + *
> + * Calculates the PCI Base and Extended (4096 bytes per PCI function)
> + * Configuration Space address for Type 1 accesses. This function assumes
> + * the Extended Conguration Space is using the reserved bits [27:24].
> + *
> + * Note: the caller is responsible for adding the bits outside of [27:2] and
> + * enable bit.
> + *
> + * Return: PCI Configuration Space address.
> + */
> +static inline u32 pci_conf1_ext_addr(u8 bus, u8 devfn, u16 reg, bool enable)
> +{
> +	return FIELD_PREP(PCI_CONF1_EXT_REG, (reg & 0xf00) >> 8) |
> +	       pci_conf1_addr(bus, devfn, reg & 0xff, enable);
> +}
> +
>  /* Generic PCI functions exported to card drivers */
>  
>  u8 pci_bus_find_capability(struct pci_bus *bus, unsigned int devfn, int cap);
> -- 
> 2.39.2
> 

