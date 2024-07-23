Return-Path: <linux-pci+bounces-10636-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C05939BDA
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 09:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5B1A1C21945
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 07:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C25D14A4E9;
	Tue, 23 Jul 2024 07:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADjxfDYQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57ADF42AB3;
	Tue, 23 Jul 2024 07:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721720514; cv=none; b=ikr/nCIGafC7Y4b9M3mPuP6lydxtYSKuFQ5YlMUUQGWDjRPLJ16oKc5UwMgHX6a2MtYjA83o3SJ7VRGYtXFUbrphGeakXNr65VZyubMDBLLWLAGyjCsgBp+GFLECiAGrH9dfrWPvqdYONzk1wxl6aoJ6NVITrAC+BZisanexUI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721720514; c=relaxed/simple;
	bh=mjJlkZUdiQOsxb3KPDefPZy6tlndQuukurOV/EoN7R4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pJn+qtfRRaanack3N/ZorGAF/ra0GiQvmKOeg7Ni8grh4sGBM1frx9Kx21UApATT9bOStQRuKuycbQveyTLHuwV9K3hKP8THewgFAP4NB7blOltFjj99puThdTo28UqGH+osNW8X0h70iGHql40nzzpm5mDumMBSa9JNnXYP2f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ADjxfDYQ; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e03caab48a2so3833762276.1;
        Tue, 23 Jul 2024 00:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721720511; x=1722325311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HoLGoaNhQAMFouQQOCIue6COJ0M0mQUucqfPGyliNeI=;
        b=ADjxfDYQKcMWVVT3NFVhmdBYF6zfvxkolpjrgcvmZNFr8S2us+Dasj7nOwa1ghIVoQ
         hGZOSegKhJRvTMC4YMCRvF/Gn2sjTZK4/6Q2UiZliyvBQSJbMmcZl9RCNErPztP0i/aA
         Hwb4qN9mbVjNNO++tg+7qGX2RXjqmzk6DmVwMjoQyAun/s8Xi01dBbsvYU4qPoGn6Ekd
         zonBTrFqShucW8t+zopr1TDe1JIHbaaUW/VxEsjNaiIXoa4xSwC4YyAtcqXENOspjd06
         UkTWsyURibLdePhbGkjlg/AV//pb6yMX+V5p4TwppDi+FrTSmXeCpsehjkXLY5jiPOV4
         XRKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721720511; x=1722325311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HoLGoaNhQAMFouQQOCIue6COJ0M0mQUucqfPGyliNeI=;
        b=vyNqeU28vtwtjDTfy0OsXHtC33S5LuXR1nHkYsGA7wJapYQkDRCh3v6pAHhDW+GQXt
         xoN6kcvs2RgeNBQxkLeiSE8NlDAO/ljPu5j1iMbOYr6VIN0hnmKEXYkxR4ccwJkqlwEy
         4+n+05T7ZcR14Yda7xXElcfLLf+yJ49AfdomaG7AMAlNyPFizRDBMJ3QSaUe2WPlrZ4R
         w9IX1wW8zsa3JbYG6A+0NwEP4O5+n+eaAGfjcWmwkcH/KbDTHbJPPIUt93b3R6eb+iAV
         qFRB++riqOacw1op5Y8GdKpO0cIZ7z5a1N7qcJ9azUytgUxE6/c6+SgBmPeZ43aaAOyp
         TAeA==
X-Forwarded-Encrypted: i=1; AJvYcCWZYfhzINWNZFHfc7wxRYSuY/u1W2ljzLk0/fX+xg0IXYEppyWKz0HML2MDrHzzGdP27tcArPWKI3YMAzwNtYBVV4zOTn65HL1xbQORFr9RiD8RTqyoUbHMf/WonDWuRo7koySLJbyD
X-Gm-Message-State: AOJu0YyVU8v/RvoV1T55a1EZ0R3m6dx9ei4jGlY5Dk6Ntg6OdAlNIbqn
	tefEnwlmAugWH8Td3gP/oUxSvquG9R0mLEIZQdN4lL3qOJFVVrfQMiIvqrVj4VcQ+i0Hy+XTVC9
	5bdMRp1I2iL5b3kvHU4NLvK/xCCpIOMoXias=
X-Google-Smtp-Source: AGHT+IGXhl/p62RZSHYNvC7pLtpx1+6BLud8/ujTr8sJwh3H6iVrVLXwxyt67iZhFSrC5fK6kSDZgEuhO38SsSTl/zo=
X-Received: by 2002:a05:6902:18cd:b0:e05:f696:9170 with SMTP id
 3f1490d57ef6-e08b95b8fc5mr1130234276.5.1721720511204; Tue, 23 Jul 2024
 00:41:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240719115741.3694893-1-rick.wertenbroek@gmail.com>
 <20240719115741.3694893-2-rick.wertenbroek@gmail.com> <b4256f7c-350b-4fba-ba49-a91ee463b8d7@kernel.org>
 <CAAEEuhqCM08NLTkM+WFh88S45OP-mjbJUd+KPtu2tBA+fbJvpw@mail.gmail.com> <b75de7a9-09fe-4c53-8e73-a3dbfd6efa4d@kernel.org>
In-Reply-To: <b75de7a9-09fe-4c53-8e73-a3dbfd6efa4d@kernel.org>
From: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Date: Tue, 23 Jul 2024 09:41:14 +0200
Message-ID: <CAAEEuhq1JLo+Lyhah6EGSTPZRbeEUFmbUehYXY1dA1f0KUwvrQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: endpoint: Introduce 'get_bar' to map fixed
 address BARs in EPC
To: Damien Le Moal <dlemoal@kernel.org>
Cc: rick.wertenbroek@heig-vd.ch, alberto.dassatti@heig-vd.ch, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Niklas Cassel <cassel@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 9:16=E2=80=AFAM Damien Le Moal <dlemoal@kernel.org>=
 wrote:
>
> On 7/23/24 16:06, Rick Wertenbroek wrote:
> > On Tue, Jul 23, 2024 at 2:03=E2=80=AFAM Damien Le Moal <dlemoal@kernel.=
org> wrote:
> >>
> >> On 7/19/24 20:57, Rick Wertenbroek wrote:
> >>> The current mechanism for BARs is as follows: The endpoint function
> >>> allocates memory with 'pci_epf_alloc_space' which calls
> >>> 'dma_alloc_coherent' to allocate memory for the BAR and fills a
> >>> 'pci_epf_bar' structure with the physical address, virtual address,
> >>> size, BAR number and flags. This 'pci_epf_bar' structure is passed
> >>> to the endpoint controller driver through 'set_bar'. The endpoint
> >>> controller driver configures the actual endpoint to reroute PCI
> >>> read/write TLPs to the BAR memory space allocated.
> >>>
> >>> The problem with this is that not all PCI endpoint controllers can
> >>> be configured to reroute read/write TLPs to their BAR to a given
> >>> address in memory space. Some PCI endpoint controllers e.g., FPGA
> >>> IPs for Intel/Altera and AMD/Xilinx PCI endpoints. These controllers
> >>> come with pre-assigned memory for the BARs (e.g., in FPGA BRAM),
> >>> because of this the endpoint controller driver has no way to tell
> >>> these controllers to reroute the read/write TLPs to the memory
> >>> allocated by 'pci_epf_alloc_space' and no way to get access to the
> >>> memory pre-assigned to the BARs through the current API.
> >>>
> >>> Therefore, introduce 'get_bar' which allows to get access to a BAR
> >>> without calling 'pci_epf_alloc_space'. Controllers with pre-assigned
> >>> bars can therefore implement 'get_bar' which will assign the BAR
> >>> pyhsical address, virtual address through ioremap, size, and flags.
> >>>
> >>> PCI endpoint functions can query the endpoint controller through the
> >>> 'fixed_addr' boolean in the 'pci_epc_bar_desc' structure. Similarly
> >>> to the BAR type, fixed size or fixed 64-bit descriptions. With this
> >>> information they can either call 'pci_epf_alloc_space' and 'set_bar'
> >>> as is currently the case, or call the new 'get_bar'. Both will provid=
e
> >>> a working, memory mapped BAR, that can be used in the endpoint
> >>> function.
> >>>
> >>> Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
> >>> ---
> >>>  drivers/pci/endpoint/pci-epc-core.c | 37 +++++++++++++++++++++++++++=
++
> >>>  include/linux/pci-epc.h             |  7 ++++++
> >>>  2 files changed, 44 insertions(+)
> >>>
> >>> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoi=
nt/pci-epc-core.c
> >>> index 84309dfe0c68..fcef848876fe 100644
> >>> --- a/drivers/pci/endpoint/pci-epc-core.c
> >>> +++ b/drivers/pci/endpoint/pci-epc-core.c
> >>> @@ -544,6 +544,43 @@ int pci_epc_set_bar(struct pci_epc *epc, u8 func=
_no, u8 vfunc_no,
> >>>  }
> >>>  EXPORT_SYMBOL_GPL(pci_epc_set_bar);
> >>>
> >>> +/**
> >>> + * pci_epc_get_bar - get BAR configuration from a fixed address BAR
> >>> + * @epc: the EPC device on which BAR resides
> >>> + * @func_no: the physical endpoint function number in the EPC device
> >>> + * @vfunc_no: the virtual endpoint function number in the physical f=
unction
> >>> + * @bar: the BAR number to get
> >>> + * @epf_bar: the struct epf_bar to fill
> >>> + *
> >>> + * Invoke to get the configuration of the endpoint device fixed addr=
ess BAR
> >>> + */
> >>> +int pci_epc_get_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> >>> +                 enum pci_barno bar, struct pci_epf_bar *epf_bar)
> >>> +{
> >>> +     int ret;
> >>> +
> >>> +     if (IS_ERR_OR_NULL(epc) || func_no >=3D epc->max_functions)
> >>> +             return -EINVAL;
> >>> +
> >>> +     if (vfunc_no > 0 && (!epc->max_vfs || vfunc_no > epc->max_vfs[f=
unc_no]))
> >>> +             return -EINVAL;
> >>> +
> >>> +     if (bar < 0 || bar >=3D PCI_STD_NUM_BARS)
> >>> +             return -EINVAL;
> >>> +
> >>> +     if (!epc->ops->get_bar)
> >>> +             return -EINVAL;
> >>> +
> >>> +     epf_bar->barno =3D bar;
> >>> +
> >>> +     mutex_lock(&epc->lock);
> >>> +     ret =3D epc->ops->get_bar(epc, func_no, vfunc_no, bar, epf_bar)=
;
> >>> +     mutex_unlock(&epc->lock);
> >>> +
> >>> +     return ret;
> >>> +}
> >>> +EXPORT_SYMBOL_GPL(pci_epc_get_bar);
> >>> +
> >>>  /**
> >>>   * pci_epc_write_header() - write standard configuration header
> >>>   * @epc: the EPC device to which the configuration header should be =
written
> >>> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> >>> index 85bdf2adb760..a5ea50dd49ba 100644
> >>> --- a/include/linux/pci-epc.h
> >>> +++ b/include/linux/pci-epc.h
> >>> @@ -37,6 +37,7 @@ pci_epc_interface_string(enum pci_epc_interface_typ=
e type)
> >>>   * @write_header: ops to populate configuration space header
> >>>   * @set_bar: ops to configure the BAR
> >>>   * @clear_bar: ops to reset the BAR
> >>> + * @get_bar: ops to get a fixed address BAR that cannot be set/clear=
ed
> >>>   * @map_addr: ops to map CPU address to PCI address
> >>>   * @unmap_addr: ops to unmap CPU address and PCI address
> >>>   * @set_msi: ops to set the requested number of MSI interrupts in th=
e MSI
> >>> @@ -61,6 +62,8 @@ struct pci_epc_ops {
> >>>                          struct pci_epf_bar *epf_bar);
> >>>       void    (*clear_bar)(struct pci_epc *epc, u8 func_no, u8 vfunc_=
no,
> >>>                            struct pci_epf_bar *epf_bar);
> >>> +     int     (*get_bar)(struct pci_epc *epc, u8 func_no, u8 vfunc_no=
,
> >>> +                        enum pci_barno, struct pci_epf_bar *epf_bar)=
;
> >>>       int     (*map_addr)(struct pci_epc *epc, u8 func_no, u8 vfunc_n=
o,
> >>>                           phys_addr_t addr, u64 pci_addr, size_t size=
);
> >>>       void    (*unmap_addr)(struct pci_epc *epc, u8 func_no, u8 vfunc=
_no,
> >>> @@ -163,6 +166,7 @@ enum pci_epc_bar_type {
> >>>   * struct pci_epc_bar_desc - hardware description for a BAR
> >>>   * @type: the type of the BAR
> >>>   * @fixed_size: the fixed size, only applicable if type is BAR_FIXED=
_MASK.
> >>> + * @fixed_addr: indicates that the BAR has a fixed address in memory=
 map.
> >>>   * @only_64bit: if true, an EPF driver is not allowed to choose if t=
his BAR
> >>>   *           should be configured as 32-bit or 64-bit, the EPF drive=
r must
> >>>   *           configure this BAR as 64-bit. Additionally, the BAR suc=
ceeding
> >>> @@ -176,6 +180,7 @@ enum pci_epc_bar_type {
> >>>  struct pci_epc_bar_desc {
> >>>       enum pci_epc_bar_type type;
> >>>       u64 fixed_size;
> >>> +     bool fixed_addr;
> >>
> >> Why make this a bool instead of a 64-bits address ?
> >> If the controller sets this to a non-zero value, we will know it is a =
fixed
> >> address bar. And that can avoid adding the get_bar operations, no ?
> >>
> >
> > The reason to use a bool is to force the use of 'get_bar', get_bar will=
 fill
> > the 'pci_epf_bar' structure and memory map the BAR. This ensures the
> > 'pci_epf_bar' structure is filled correctly and usable, same as after a
> > 'pci_epf_alloc_space' operation. This also removes a burden to the
> > endpoint function (i.e., map the memory, handle errors, set the fields
> > of the structure etc.). This will likely avoid errors in the endpoint f=
unctions
> > as this code is quite sensitive and possibly controller specific (e.g.,
> > memremap for virtual controllers vs ioremap for real controllers). Also=
,
> > this code would be duplicated for each endpoint function, therefore I t=
hink
> > it is better to just call 'get_bar' instead of rewriting all correspond=
ing lines
> > in each endpoint function (which would be very error prone).
> >
> > There could also be other cases where the PCIe controller is behind a
> > specific bus and the BAR doesn't have a physical address and needs
> > to be accessed in a specific way. E.g., one could make a BAR accessible
> > via a serial interface in the FPGA (probably no one will do this, but i=
t is
> > a possible architecture).
> >
> > That's why I believe it is important to let the controller fill the
> > 'pci_epf_bar'
> > structure and do the necessary io/mem remapping internally.
>
> OK. All fair points. I asked because I am not a fan of the code we end up
> needing in the epf, such as you have in the test driver changes in patch =
2:
>
> +       if (!epc_features->bar[test_reg_bar].fixed_addr)
> +               base =3D pci_epf_alloc_space(epf, test_reg_size, test_reg=
_bar,
> +                                          epc_features, PRIMARY_INTERFAC=
E);
> +       else {
> +               ret =3D pci_epc_get_bar(epf->epc, epf->func_no, epf->vfun=
c_no,
> +                                     test_reg_bar, &epf->bar[test_reg_ba=
r]);
> +               if (ret < 0) {
> +                       dev_err(dev, "Failed to get fixed address BAR\n")=
;
> +                       return ret;
> +               }
> +               base =3D epf->bar[test_reg_bar].addr;
> +       }
> +
>
> It would be a lot nicer if we could have a single epf function that does =
the
> alloc space call OR the get bar called based on the type of the bar.
>
> I was thinking of something like:
>
>         base =3D pci_epf_alloc_bar(epf, &epf->bar[test_reg_bar], test_reg=
_size,
>                                  PRIMARY_INTERFACE);
>
> (we do not need to pass the epc_features as we can get that through epf->=
epc)
>
> That would greatly simplify the epf driver code. And of course we need th=
e
> reverse pci_epf_free_bar() which would call either pci_epf_free_space() o=
r
> pci_epc_release_bar() for fixed address bars. This last function is neede=
d
> either way I think so that we can have a clean teardown of the epc resour=
ces
> used for an epf.
>

Interesting. I like this approach, this would also make it possible to
combine the current 'pci_epf_alloc_space' and 'pci_epc_set_bar' into a
single function which would simplify the endpoint functions.

The reason why it is separate now is so that 'pci_epf_alloc_space' can
be called before the endpoint function is bound to a controller, and
therefore the BAR memory can be filled and prepared before bind() is
called. Merging 'pci_epf_alloc_bar' with 'pci_epc_set_bar' into a
'pci_epc_alloc_bar' (epc because it is dependent on the endpoint
controller and prior to be bound to a specific controller we don't
know if we need to allocate locally or remap) would make it impossible
to access the BAR prior to be bound to a controller (because the
function 'pci_epc_alloc_bar' would fail without a specific
controller). I don't think this is a problem as an unbound endpoint
function is kind of useless on its own, but this means the BAR memory
could only be allocated/remapped/accessed once the endpoint is bound
to a controller.

This would also mean that unbinding an endpoint function from
controller X and rebinding it to controller Y would require refilling
the whole BAR memory (so if the current state of the BAR memory is
important it needs to be saved and restored). While this is a scenario
we will probably not see often, it is impacted by the change, and with
the current architecture one could rebind the function to another
controller and the BAR contents would remain in their current state.
(Note: to rebind, remove symlink in PCI endpoint controller X
configfs, and symlink it in another controller Y configfs).

Unless someone relies on unbinding/rebinding (unlikely), I think
'pci_epc_alloc_bar' could be introduced without breaking anything and
would simplify the endpoint functions as well (remove duplicate checks
that are currently in the endpoint bind and epc core init functions,
because both check epc features for the 'pci_epf_alloc_space' and for
'pci_epc_set_bar'.). And for the future in the unlikely case where
someone wants to implement an endpoint function that should be
unbound-rebound while preserving the BAR state, they can add the BAR
memory save/restore mechanism.

So, I totally agree it would be better to rely on a single
'pci_epc_alloc_bar' function.

> >
> >>>       bool only_64bit;
> >>>  };
> >>>
> >>> @@ -238,6 +243,8 @@ int pci_epc_set_bar(struct pci_epc *epc, u8 func_=
no, u8 vfunc_no,
> >>>                   struct pci_epf_bar *epf_bar);
> >>>  void pci_epc_clear_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> >>>                      struct pci_epf_bar *epf_bar);
> >>> +int pci_epc_get_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> >>> +                 enum pci_barno, struct pci_epf_bar *epf_bar);
> >>>  int pci_epc_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> >>>                    phys_addr_t phys_addr,
> >>>                    u64 pci_addr, size_t size);
> >>
> >> --
> >> Damien Le Moal
> >> Western Digital Research
> >>
> >
> > Thank you for your insights.
> > Rick
>
> --
> Damien Le Moal
> Western Digital Research
>

Regards,
Rick

