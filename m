Return-Path: <linux-pci+bounces-6903-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFC08B8000
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 20:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B49A6283175
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 18:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99ED5194C77;
	Tue, 30 Apr 2024 18:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZ19ZD8z"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761B7194C6B
	for <linux-pci@vger.kernel.org>; Tue, 30 Apr 2024 18:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714502638; cv=none; b=RbqDRGCOTBSD61mIPI7V7KU5WZA8JcP7b6sWJUZSH8A78+icUwZSym98vCjPb+2+QgDI/hClDubCaQUUL0e9IErXjqHPEqw1N/h0qFWuwHJWmBgFpqhPQlSI7zdK5HoVbfPBaa/wX/yMO+cmnrgQpASFWwScf8pxN+6Qm9wxFsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714502638; c=relaxed/simple;
	bh=yBcTPZCCmx7Upn9F1YxSf9Y+4FbVu6INqQ1DtEjjxks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o2r/WgkgjTj8J/fgNiqUqknmsDqZlmk9H0Na1yzBhGQlAtQKCNbsnSiCLX/NveHpx2+GxNikY2nu2to+4TALzC42YKJjbaPew6FUFyyEce4YAThqFlJxpsAj9u45jEKuxwWYxw9nqOKg5EHrtPDF8f86UbA1g03BkB7IfQTgeMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZ19ZD8z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F2E4C4AF17;
	Tue, 30 Apr 2024 18:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714502638;
	bh=yBcTPZCCmx7Upn9F1YxSf9Y+4FbVu6INqQ1DtEjjxks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QZ19ZD8z9Bk5R95L6L0qdOSk3J5CPrH3AOKkOqf09YsPPbu/O2H9gn/JY9AO4FlOp
	 pFXtd5Yk2ZcHleY2U4Ldc4WVYBn1Jc64/NM7e8qzbPzz17WNngqsE9IUgW5NNje6oW
	 vDdibjQHCnyFX3sfSqVpRrRM0e/NsKBA/EjbI6jlhTkCeC3sUqfrC1XYY10MyUmzKl
	 pZSI7XsWvDu85Pmo2Mei1o6/oPS/gO7J7sY2vohp+GSnSPHAuTGW85jlvltSh8nADX
	 SMBFFnj7IExgNwNqi1DBW7/ueLUiwlgn1KlzxCzR8O8mRZ8ZCACdGsKigA40aZlP/l
	 f59hAhqeBHerw==
Received: by pali.im (Postfix)
	id E76EB7FD; Tue, 30 Apr 2024 20:43:54 +0200 (CEST)
Date: Tue, 30 Apr 2024 20:43:54 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH 02/10] PCI: Add helpers to calculate PCI Conf Type 0/1
 addresses
Message-ID: <20240430184354.cvowo4zdxpjqnqok@pali>
References: <20240429104633.11060-1-ilpo.jarvinen@linux.intel.com>
 <20240429104633.11060-3-ilpo.jarvinen@linux.intel.com>
 <20240429192427.uqat6ix4opwwvqg6@pali>
 <e56ae9b2-7089-397d-c672-de6c80953677@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e56ae9b2-7089-397d-c672-de6c80953677@linux.intel.com>
User-Agent: NeoMutt/20180716

On Tuesday 30 April 2024 13:21:23 Ilpo Järvinen wrote:
> On Mon, 29 Apr 2024, Pali Rohár wrote:
> 
> > On Monday 29 April 2024 13:46:25 Ilpo Järvinen wrote:
> > > Many places in arch and PCI controller code need to calculate PCI
> > > Configuration Space Addresses for Type 0/1 accesses. There are small
> > > variations between archs when it comes to bits outside of [10:2] (Type
> > > 0) and [24:2] (Type 1) but the basic calculation can still be
> > > generalized.
> > > 
> > > drivers/pci/pci.h has PCI_CONF1{,_EXT}_ADDRESS() but due to their
> > > location the use is limited to PCI subsys and the also always enable
> > > PCI_CONF1_ENABLE which is not what all the callers want.
> > > 
> > > Add generic pci_conf{0,1}_addr() and pci_conf1_ext_addr() helpers into
> > > include/linux/pci.h which can be reused by various parts of the kernel
> > > that have to calculate PCI Conf Type 0/1 addresses.
> > > 
> > > The PCI_CONF* defines are needed by the new helpers so move also them
> > > to include/linux/pci.h. The new helpers use true bitmasks and
> > > FIELD_PREP() instead of open coded masking and shifting so adjust
> > > PCI_CONF* definitions to match that.
> >
> > I introduced these PCI_CONF* macros years ago. At that time I studied
> > more sources and drivers what they use. To make it clear I will first
> > try to explain few things. Hopefully I do not write mistakes here, it is
> > longer time.
> > 
> > Configuration mechanism is a SW API which allows access config space.
> > Configuration access command is on-wire "format" which allows HW bus to
> > access config space.
> > 
> > There are two standardized configuration mechanisms #1 and #2. #2 was
> > removed in PCI 3.0 spec and is out of scope (there are no macros for
> > them). #1 uses pair of I/O registers (on x86 they are CF8 and CFC; on
> > ARM they are whatever vendor invented). There is an extension of #1
> > which uses few reserved bits to describe config space registers above
> > 255. Then there is standardized PCIe ECAM. And then there are lot of
> > proprietary vendor specific ways. Proprietary vendor way can be for
> > example composing PCIe packet manually or composing configuration access
> > command manually.
> >
> > There are two configuration space access commands: type 0 and type 1.
> > It is required to issue correct command type based on topology of the
> > endpoint device. When mechanism #1 is used then it is HW who generate
> > these commands and it takes care to correctly choose type 0 or 1. But if
> > some vendor specific mechanism is used which requires SW to compose
> > access command manually then SW is responsible for correct choose.
> > 
> > 
> > In your change you have mixed configuration mechanism #1 together with
> > configuration command for type 0. This is really a problem as it makes
> > the code harder to understand and even hard to figure out how to write a
> > new driver (e.g. how to compose configuration command for type 1?).
> >
> > Also it took me a little bit more time to understand your change.
> > Format of command for type 1 and format of configuration mechanism #1
> > really looks very similar. So there can be a confusion. Bit 31 is a key  
> > there.
> 
> Thanks a lot for chimming in!
> 
> In practice, the calculation done is very similar for many archs. I 
> initially was planning to only convert things in drivers/pci/pci.h to 
> FIELD_PREP() and be done with it, but then I came across this (a rough and 
> incomplete list):
> 
> $ git grep -e 'bus.*<<.*16' -B1 -A3 arch
> 
> So I ended up extending the scope and trying to find a common ground, 
> which was to make functions into include/linux/pci.h to cover the main 
> calculations. This should explain the placement which you asked in the 
> other reply. I don't think drivers/pci/pci.h is helpful when arch/ code 
> has this very calculation repeated n times.

I know. In past I have called similar git grep commands and at that time
I also come to similar conclusion and that is why I originally also
suggested to provide macros in include/linux/*.h

> To me it looked obvious that those calculations relate to what is 
> described in PCI Local Bus Spec r3.0 sec 3.2.2.3.1 (some even explicitly 
> indicate type 0 or type 1).

It is important to see that there are sections 3.2.2.3.1. and 3.2.2.3.2.
which describes different things.

> I still had to find some name for the functions and didn't see any reason 
> why I couldn't just use type 0 and type 1 as in that spec. To me, it's 
> hardly an accident that mechanism #1 fields are 1:1 copy of type 1 
> calculation but I think I can still see it also from your viewpoint. I 
> perhaps just look this from more practical standpoint than you (no offence 
> meant in any way).

The best names of the functions is to use terminology from the
standards (instead of inventing new custom terminology). Because
standards are "standards", so anybody from the specific industry would
be able to better understand the code.

> I don't know if the vendor specific part is even relevant to this series
> or if you just noted it for completeness.

For completeness because it is very common and it is important to know
about it. Also mechanism #1-ext is vendor specific but somehow used by
lot of vendors.

> I'm looking for common ground 
> here and if vendor's copying the existing format where they could have 
> invented entirely custom formatting, but is that good enough reason to 
> name the functions differently? Or falsely claim it's vendor specific when 
> it's obviously nothing but copying the existing way (i.e., the fields from 
> type 1)?

"type 1 command" has exact definition and well-defined usage. It is used
for communication with device behind the PCI-to-PCI bridge. PCIe
endpoint device has to reply with status unsupported request.

Using "type 1 command" in function name which sends arbitrary command
(including type 0; e.g. for filling mechanism #1 format) is misleading
and would open questions like: why is using function "type 1 command"
for sending "type 0 command"?

Reason that some bits in the formats have same meaning does not mean to
use wrong names.

> Perhaps the main wrong here was in the naming step or in the terminology 
> I used in the commit messages, or do you think those calcs done under 
> arch/ do not related to type 0/1 in any way (despite being 1:1 copy!)?

For example what is wrong is this documentation:

"pci_conf1_ext_addr - PCI Configuration Space address for Type 1 access"

This function does not generate Type 1 command as it does not sets
BIT(0) to 1. It let BIT(0) as 0, which means that it generates Type 0
command.

It needs to be properly investigated if the HW which targets code in
arch/ generates type 0/1 commands in SW or in HW.

> Lets take a look at a real function in kernel (this is not the only 
> example, there are more similar ones under arch/, e.g., in
> arch/alpha/kernel/core_lca.c):
> 
> static u32 ixp4xx_config_addr(u8 bus_num, u16 devfn, int where)
> {
>         /* Root bus is always 0 in this hardware */
>         if (bus_num == 0) {
>                 /* type 0 */
>                 return (PCI_CONF1_ADDRESS(0, 0, PCI_FUNC(devfn), where) &
>                         ~PCI_CONF1_ENABLE) | BIT(32-PCI_SLOT(devfn));
>         } else {
>                 /* type 1 */
>                 return (PCI_CONF1_ADDRESS(bus_num, PCI_SLOT(devfn),
>                                           PCI_FUNC(devfn), where) &
>                         ~PCI_CONF1_ENABLE) | 1;
>         }
> }
> 
> So is this "mixing" #1 and type 0 together? Or how you categorize this?
> I suspect, by your definition, it's actually abusing what is meant for 
> mechanism #1 to calculate type 1 (obviously because the main calculation 
> is undeniably very much the same :-))?

So first is: Is this code correct? Are not you just trying to create
some new functions and abstractions for something which is wrong? As I
wrote in previous email, I have an experience with wrongly written SW
which incorrectly generated config requests.

The example is for some alpha HW, I guess something not commonly used,
so if there is a bug in that code, there is very little chance that
somebody will report it.

The worst thing which can happen is to design some abstraction based on
wrong assumptions (or wrong code). As it would lead to new bugs in newly
written code. New designed abstraction should prevent it.

> > I understand that you want to unify drivers, so I would suggest to not
> > change existing macros for configuration mechanism #1 and #1-ext.
> > And rather create new macros (or functions) for composing configuration
> > commands.
> 
> And what about code under arch/? I see bits 24-27 and bit #31 being 
> enabled there as well. Or do those categorize as "vendor specific" methods 
> so nothing can be done to them?!?

Do you mean above ixp4xx_config_addr? The correct answer is to look into
HW documentation. It is hard to predict but I guess that it is
constructions of the format for raw commands. When bus_num is not 0 then
is is type 1 command. And if bus_num is 0 then bits 11-31 are reserved
(in HW can be hardwired to zero) so BIT(32-PCI_SLOT(devfn)) can do
nothing. But this is only my assumption and reality can be different.
It is really common do to such mistake if you do not read documentation
properly or have assumptions from wrong input information (like mixing
formats of type 0 command and mech #1).

> > This makes it explicitly clear that particular PCI or PCIe controller HW
> > requires SW driver to compose configuration command (type 0 and 1). Or
> > that HW requires from SW to compose format of configuration mechanism #1
> > (or #1-ext). Also it would make pci controller drivers more readable as
> > from the macro/function it would be easy to understand what it is doing.
> 
> So does this effectively boil down to instead of having a boolean enable
> parameter for bit #31, I should create two functions with different names
> (well, reusing the existing ones perhaps for one of them but the same 
> idea)? Couldn't I just name the function and that enable parameter 
> differently and/or document things better without having two functions?
> It's not like these these two things came to be mostly the same by chance,
> they're very much related.

What I'm trying to say. If your HW requires from SW to generate RAW
commands, then driver has to implement logic for generating _both_ type0
and type1 commands and also needs to have logic to correctly choose
which command to generate. If you are developer of the driver for such
HW then the worst what can happen is that you forgot to add logic for
generating type 0 commands. And finding such bug can be really hard for
somebody who does not know difference between mech #1 and type 1.

mech #1 is something which generates _both_ type 0 and type 1.

When working with mech #1 I do not see any reason why driver would want
to disable access (by setting enable bit to 0). So I think that helper
kernel function should always set enable bit to 1. If there is a reason
to disable access then there could be another function (without
arguments) which will do it.

It is wrong to call function with enable=0 and expecting that it would
_enable_ access to HW.


So I'm suggesting to:

1) let macros for mech #1 and #1-ext there as is

2) introduce new macros (functions, abstractions, ...) for generating
configuration commands type 0 and type 1.

It can be either one macro which takes an argument type of the command
(0 or 1, ideally asserted that no other value is valid). Or it can be
two commands, one for type 0 and one for type 1.

Type of the command is defined by BIT(1) and BIT(0).

Personally I'm for having two macros, one for type 0 and one for type 1.
And that is because type 0 command has only function number and register
number. Whether type 1 has additionally bus number and device number. So
it would be easier to look if correct parameters are passed for
particular format.

So if author of driver figure out that has to write a code which needs
to issue type 1 command, would be also forced to write a code for
issuing type 0 command. And for other people it would be easy to review
if driver has code for both type 0 and type 1.

For example having macros:

  PCI_CONF1_ADDRESS(bus, dev, func, reg)

  PCI_CONF1_EXT_ADDRESS(bus, dev, func, reg)

  PCI_CONF_COMMAND_TYPE0_ADDRESS(func, reg)

  PCI_CONF_COMMAND_TYPE1_ADDRESS(bus, dev, func, reg)

(and maybe PCI_CONF_COMMAND_TYPE1_EXT_ADDRESS if there is such vendor ext)

I'm not sure if the PCI_CONF_COMMAND_TYPEX_ADDRESS is the best name, but
I wrote something as an example.

3) switch drivers to use new macros. And figure out if the drivers are
   not buggy and are trying to sets wire-0 bits...

> > Also important is that if you are in pci controller driver composing
> > command for type 0 then with very high probability the HW is designed in
> > a way that it requires from SW to also compose command type 1. And it
> > would be an mistake if the driver compose only type 0 or type 1. I
> > remember from the past an issue: why endpoint PCIe card is working, but
> > it is not working if it is connected behind PCIe switch. (mistake was:
> > HW was always sending type 0 command due to SW issue)
> 
> Do you think this would warrant something that actually combines the 
> type 0/1 calculations inside? Just asking your opinion, I'm not sure how 
> easy the arch code would be to adapt such a bigger change because of the
> variations.

I do not know how hard is to refactor all arch/ code. I guess there are
lot of code from history, which may be wrong/buggy and for which nobody
is doing periodic testing. Nowadays new pci controller drivers are in
the drivers/pci/ subdir. So maybe the best option is to let arch/ pci
code as is?

> -- 
>  i. 
> 
> > > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > > ---
> > >  drivers/pci/pci.h   | 43 ++---------------------
> > >  include/linux/pci.h | 85 +++++++++++++++++++++++++++++++++++++++++++++
> > >  2 files changed, 88 insertions(+), 40 deletions(-)
> > > 
> > > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > > index 17fed1846847..cf0530a60105 100644
> > > --- a/drivers/pci/pci.h
> > > +++ b/drivers/pci/pci.h
> > > @@ -833,49 +833,12 @@ struct pci_devres {
> > >  
> > >  struct pci_devres *find_pci_dr(struct pci_dev *pdev);
> > >  
> > > -/*
> > > - * Config Address for PCI Configuration Mechanism #1
> > > - *
> > > - * See PCI Local Bus Specification, Revision 3.0,
> > > - * Section 3.2.2.3.2, Figure 3-2, p. 50.
> > > - */
> > > -
> > > -#define PCI_CONF1_BUS_SHIFT	16 /* Bus number */
> > > -#define PCI_CONF1_DEV_SHIFT	11 /* Device number */
> > > -#define PCI_CONF1_FUNC_SHIFT	8  /* Function number */
> > > -
> > > -#define PCI_CONF1_BUS_MASK	0xff
> > > -#define PCI_CONF1_DEV_MASK	0x1f
> > > -#define PCI_CONF1_FUNC_MASK	0x7
> > > -#define PCI_CONF1_REG_MASK	0xfc /* Limit aligned offset to a maximum of 256B */
> > > -
> > > -#define PCI_CONF1_ENABLE	BIT(31)
> > > -#define PCI_CONF1_BUS(x)	(((x) & PCI_CONF1_BUS_MASK) << PCI_CONF1_BUS_SHIFT)
> > > -#define PCI_CONF1_DEV(x)	(((x) & PCI_CONF1_DEV_MASK) << PCI_CONF1_DEV_SHIFT)
> > > -#define PCI_CONF1_FUNC(x)	(((x) & PCI_CONF1_FUNC_MASK) << PCI_CONF1_FUNC_SHIFT)
> > > -#define PCI_CONF1_REG(x)	((x) & PCI_CONF1_REG_MASK)
> > > -
> > >  #define PCI_CONF1_ADDRESS(bus, dev, func, reg) \
> > >  	(PCI_CONF1_ENABLE | \
> > > -	 PCI_CONF1_BUS(bus) | \
> > > -	 PCI_CONF1_DEV(dev) | \
> > > -	 PCI_CONF1_FUNC(func) | \
> > > -	 PCI_CONF1_REG(reg))
> > > -
> > > -/*
> > > - * Extension of PCI Config Address for accessing extended PCIe registers
> > > - *
> > > - * No standardized specification, but used on lot of non-ECAM-compliant ARM SoCs
> > > - * or on AMD Barcelona and new CPUs. Reserved bits [27:24] of PCI Config Address
> > > - * are used for specifying additional 4 high bits of PCI Express register.
> > > - */
> > > -
> > > -#define PCI_CONF1_EXT_REG_SHIFT	16
> > > -#define PCI_CONF1_EXT_REG_MASK	0xf00
> > > -#define PCI_CONF1_EXT_REG(x)	(((x) & PCI_CONF1_EXT_REG_MASK) << PCI_CONF1_EXT_REG_SHIFT)
> > > +	 pci_conf1_addr(bus, PCI_DEVFN(dev, func), reg & ~0x3U))
> > >  
> > >  #define PCI_CONF1_EXT_ADDRESS(bus, dev, func, reg) \
> > > -	(PCI_CONF1_ADDRESS(bus, dev, func, reg) | \
> > > -	 PCI_CONF1_EXT_REG(reg))
> > > +	(PCI_CONF1_ENABLE | \
> > > +	 pci_conf1_ext_addr(bus, PCI_DEVFN(dev, func), reg & ~0x3U))
> > >  
> > >  #endif /* DRIVERS_PCI_H */
> > > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > > index 16493426a04f..4c4e3bb52a0a 100644
> > > --- a/include/linux/pci.h
> > > +++ b/include/linux/pci.h
> > > @@ -26,6 +26,8 @@
> > >  #include <linux/args.h>
> > >  #include <linux/mod_devicetable.h>
> > >  
> > > +#include <linux/bits.h>
> > > +#include <linux/bitfield.h>
> > >  #include <linux/types.h>
> > >  #include <linux/init.h>
> > >  #include <linux/ioport.h>
> > > @@ -1183,6 +1185,89 @@ void pci_sort_breadthfirst(void);
> > >  #define dev_is_pci(d) ((d)->bus == &pci_bus_type)
> > >  #define dev_is_pf(d) ((dev_is_pci(d) ? to_pci_dev(d)->is_physfn : false))
> > >  
> > > +/*
> > > + * Config Address for PCI Configuration Mechanism #0/1
> > > + *
> > > + * See PCI Local Bus Specification, Revision 3.0,
> > > + * Section 3.2.2.3.2, Figure 3-1 and 3-2, p. 48-50.
> > > + */
> > > +#define PCI_CONF_REG		0x000000ffU	/* common for Type 0/1 */
> > > +#define PCI_CONF_FUNC		0x00000700U	/* common for Type 0/1 */
> > > +#define PCI_CONF1_DEV		0x0000f800U
> > > +#define PCI_CONF1_BUS		0x00ff0000U
> > > +#define PCI_CONF1_ENABLE	BIT(31)
> > > +
> > > +/**
> > > + * pci_conf0_addr - PCI Base Configuration Space address for Type 0 access
> > > + * @devfn:      Device and function numbers (device number will be ignored)
> > > + * @reg:        Base configuration space offset
> > > + *
> > > + * Calculates the PCI Configuration Space address for Type 0 accesses.
> > > + *
> > > + * Note: the caller is responsible for adding the bits outside of [10:0].
> > > + *
> > > + * Return: Base Configuration Space address.
> > > + */
> > > +static inline u32 pci_conf0_addr(u8 devfn, u8 reg)
> > > +{
> > > +	return FIELD_PREP(PCI_CONF_FUNC, PCI_FUNC(devfn)) |
> > > +	       FIELD_PREP(PCI_CONF_REG, reg & ~3);
> > > +}
> > > +
> > > +/**
> > > + * pci_conf1_addr - PCI Base Configuration Space address for Type 1 access
> > > + * @bus:	Bus number of the device
> > > + * @devfn:	Device and function numbers
> > > + * @reg:	Base configuration space offset
> > > + * @enable:	Assert enable bit (bit 31)
> > > + *
> > > + * Calculates the PCI Base Configuration Space (first 256 bytes) address for
> > > + * Type 1 accesses.
> > > + *
> > > + * Note: the caller is responsible for adding the bits outside of [24:2]
> > > + * and enable bit.
> > > + *
> > > + * Return: PCI Base Configuration Space address.
> > > + */
> > > +static inline u32 pci_conf1_addr(u8 bus, u8 devfn, u8 reg, bool enable)
> > > +{
> > > +	return (enable ? PCI_CONF1_ENABLE : 0) |
> > > +	       FIELD_PREP(PCI_CONF1_BUS, bus) |
> > > +	       FIELD_PREP(PCI_CONF1_DEV | PCI_CONF_FUNC, devfn) |
> > > +	       FIELD_PREP(PCI_CONF_REG, reg & ~3);
> > > +}
> > > +
> > > +/*
> > > + * Extension of PCI Config Address for accessing extended PCIe registers
> > > + *
> > > + * No standardized specification, but used on lot of non-ECAM-compliant ARM SoCs
> > > + * or on AMD Barcelona and new CPUs. Reserved bits [27:24] of PCI Config Address
> > > + * are used for specifying additional 4 high bits of PCI Express register.
> > > + */
> > > +#define PCI_CONF1_EXT_REG	0x0f000000UL
> > > +
> > > +/**
> > > + * pci_conf1_ext_addr - PCI Configuration Space address for Type 1 access
> > > + * @bus:	Bus number of the device
> > > + * @devfn:	Device and function numbers
> > > + * @reg:	Base or Extended Configuration space offset
> > > + * @enable:	Assert enable bit (bit 31)
> > > + *
> > > + * Calculates the PCI Base and Extended (4096 bytes per PCI function)
> > > + * Configuration Space address for Type 1 accesses. This function assumes
> > > + * the Extended Conguration Space is using the reserved bits [27:24].
> > > + *
> > > + * Note: the caller is responsible for adding the bits outside of [27:2] and
> > > + * enable bit.
> > > + *
> > > + * Return: PCI Configuration Space address.
> > > + */
> > > +static inline u32 pci_conf1_ext_addr(u8 bus, u8 devfn, u16 reg, bool enable)
> > > +{
> > > +	return FIELD_PREP(PCI_CONF1_EXT_REG, (reg & 0xf00) >> 8) |
> > > +	       pci_conf1_addr(bus, devfn, reg & 0xff, enable);
> > > +}
> > > +
> > >  /* Generic PCI functions exported to card drivers */
> > >  
> > >  u8 pci_bus_find_capability(struct pci_bus *bus, unsigned int devfn, int cap);
> > > -- 
> > > 2.39.2
> > > 
> > 


