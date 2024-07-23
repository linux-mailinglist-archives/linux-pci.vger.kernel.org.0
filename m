Return-Path: <linux-pci+bounces-10633-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CB4939B6D
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 09:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B5DA1F2209F
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 07:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E8013D882;
	Tue, 23 Jul 2024 07:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTp9wDxz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC2818D;
	Tue, 23 Jul 2024 07:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721718418; cv=none; b=EyV4Gq22F8TWCAYNJL6EbiPuUAKRS0wyTDqzLJgsxvetJeIH9qZdK1r1iXdJJdYfzDE9SlCMmnkHMtUzktGFvikrMtxKlKbykePQyWSZrOk+nmJZzKbESSQaZvGAIf+5qbmYWkYfjqZcYNRTh3Y3pO9p39F72tNCkWkbUDilPWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721718418; c=relaxed/simple;
	bh=k8MRrBMVFfYZDFMx7bEp4Bj9HMFjcifBjx9Ov+crcH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IIQT0ZJBWrDb1vMa1KllrKupnURyhzcKUR+7Z1CdQy2cyu85rtLcDNacYKaDKn+JN+2rvt23hntylEhkXkNc9lWm8j3CAI+dZqoUP0ELiuyyjDFdd91CsH+BebDtMuvrJDfmw7fRFsHB8AuZuxIw3GGsWINSuU2Q3L0GIxciVd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fTp9wDxz; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e03a17a50a9so5556035276.1;
        Tue, 23 Jul 2024 00:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721718416; x=1722323216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vyWNjpEuHIjY8oO8nir6ymzjNGx2iSKiLuLIzOdWYzg=;
        b=fTp9wDxzkxPZDsfYWHwfgHWBuFpfHRNAuCwjn5s/UazkiUXZa0cAMxvyvaFD83OfQk
         rgaKXjgnjLJnDT+tlu1nrVvMJESUzbczSrOYJwb+PEeF4eDSuXyFjb61p99fJtUZDQ1K
         2MEVSyV1WLm7yLHuQP243MPoDdif0gDVMOs10qhRefzQn3x+qufHgJCq4FwGWP6PXTgQ
         QN80ldoXKTKvZvQ1m7diNT2SuNihBRtcJinCHaknPVB5jqtblQB+2hp72d1G72gxc1sT
         s3NyhsKefcCbeDyMxkhQVtxgb2A/hPf8Vxbx9X89Yl4JRNyy7Ip/PbUI3da8sz6Kyz2F
         ABZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721718416; x=1722323216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vyWNjpEuHIjY8oO8nir6ymzjNGx2iSKiLuLIzOdWYzg=;
        b=Eb3/+r4QfWlT5lv+sGRa3Ear75a4XjFxdgp0Up0VYgEbmsHtay48k7hLcVyKruHteK
         sH68C9lvfnh5mySqt09uE2EuoDuuI2mOQVZ+Y9/7T0EAYr/S+q+ZSGD7ifseSrgkdTAS
         LAX41JkVfAglb9fzqy0LaSES5hyEGW/vxlGZ/qSiiMOH0ioXB9jJOccKIP/9NOgLZfuf
         xveLY3CKO/qO7Vvf56VNmwEQaA41az9WjjkSEw90EB2mR+NWir/E2hS9ubBiP2GraeiY
         ou0FhLFBi4VCN/bMlyczBJMhkNiK68vm/Pwi3/jB9FZVsrMPVdTozEU1JeRqnp3bkDOU
         7/sg==
X-Forwarded-Encrypted: i=1; AJvYcCWE+xLSXlOXn6M5LKLh3z4Ksdx4Ygisohfcr3gIG+E7E7e+d10lO9mSfzNvTN5Xjd4JHy61EVNCiRKwg2xv8Zfq6zsiF6GXBzbeX3O97Qb1RDoeKWP+x4zmfVibYvS6QxemAsteFnAZ
X-Gm-Message-State: AOJu0YxoH/bJk8JNESVUuzEjtdO1i5rY0TZ1sgodP8PG1TNyoIxb5D+w
	94xFksdCwtR2APXmxQ23NpGfxvpjKl7vyEXR3baB/+MB51NSqIOaHTJnrkVKraNTbcI18Pofs7j
	llV4SjII8ELxDsav2YEpNmNU8CkE=
X-Google-Smtp-Source: AGHT+IEAOaAFZ1K9IY7dR21pVSsJCONa9CysJx+Hk7vqe1hctFsp0WkeXfxodVtVvwChKzLr/2QPABH1T7oYhPRdT3I=
X-Received: by 2002:a05:6902:2083:b0:e03:25d5:8039 with SMTP id
 3f1490d57ef6-e08706af0bfmr11423537276.51.1721718415978; Tue, 23 Jul 2024
 00:06:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240719115741.3694893-1-rick.wertenbroek@gmail.com>
 <20240719115741.3694893-2-rick.wertenbroek@gmail.com> <b4256f7c-350b-4fba-ba49-a91ee463b8d7@kernel.org>
In-Reply-To: <b4256f7c-350b-4fba-ba49-a91ee463b8d7@kernel.org>
From: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Date: Tue, 23 Jul 2024 09:06:19 +0200
Message-ID: <CAAEEuhqCM08NLTkM+WFh88S45OP-mjbJUd+KPtu2tBA+fbJvpw@mail.gmail.com>
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

On Tue, Jul 23, 2024 at 2:03=E2=80=AFAM Damien Le Moal <dlemoal@kernel.org>=
 wrote:
>
> On 7/19/24 20:57, Rick Wertenbroek wrote:
> > The current mechanism for BARs is as follows: The endpoint function
> > allocates memory with 'pci_epf_alloc_space' which calls
> > 'dma_alloc_coherent' to allocate memory for the BAR and fills a
> > 'pci_epf_bar' structure with the physical address, virtual address,
> > size, BAR number and flags. This 'pci_epf_bar' structure is passed
> > to the endpoint controller driver through 'set_bar'. The endpoint
> > controller driver configures the actual endpoint to reroute PCI
> > read/write TLPs to the BAR memory space allocated.
> >
> > The problem with this is that not all PCI endpoint controllers can
> > be configured to reroute read/write TLPs to their BAR to a given
> > address in memory space. Some PCI endpoint controllers e.g., FPGA
> > IPs for Intel/Altera and AMD/Xilinx PCI endpoints. These controllers
> > come with pre-assigned memory for the BARs (e.g., in FPGA BRAM),
> > because of this the endpoint controller driver has no way to tell
> > these controllers to reroute the read/write TLPs to the memory
> > allocated by 'pci_epf_alloc_space' and no way to get access to the
> > memory pre-assigned to the BARs through the current API.
> >
> > Therefore, introduce 'get_bar' which allows to get access to a BAR
> > without calling 'pci_epf_alloc_space'. Controllers with pre-assigned
> > bars can therefore implement 'get_bar' which will assign the BAR
> > pyhsical address, virtual address through ioremap, size, and flags.
> >
> > PCI endpoint functions can query the endpoint controller through the
> > 'fixed_addr' boolean in the 'pci_epc_bar_desc' structure. Similarly
> > to the BAR type, fixed size or fixed 64-bit descriptions. With this
> > information they can either call 'pci_epf_alloc_space' and 'set_bar'
> > as is currently the case, or call the new 'get_bar'. Both will provide
> > a working, memory mapped BAR, that can be used in the endpoint
> > function.
> >
> > Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
> > ---
> >  drivers/pci/endpoint/pci-epc-core.c | 37 +++++++++++++++++++++++++++++
> >  include/linux/pci-epc.h             |  7 ++++++
> >  2 files changed, 44 insertions(+)
> >
> > diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint=
/pci-epc-core.c
> > index 84309dfe0c68..fcef848876fe 100644
> > --- a/drivers/pci/endpoint/pci-epc-core.c
> > +++ b/drivers/pci/endpoint/pci-epc-core.c
> > @@ -544,6 +544,43 @@ int pci_epc_set_bar(struct pci_epc *epc, u8 func_n=
o, u8 vfunc_no,
> >  }
> >  EXPORT_SYMBOL_GPL(pci_epc_set_bar);
> >
> > +/**
> > + * pci_epc_get_bar - get BAR configuration from a fixed address BAR
> > + * @epc: the EPC device on which BAR resides
> > + * @func_no: the physical endpoint function number in the EPC device
> > + * @vfunc_no: the virtual endpoint function number in the physical fun=
ction
> > + * @bar: the BAR number to get
> > + * @epf_bar: the struct epf_bar to fill
> > + *
> > + * Invoke to get the configuration of the endpoint device fixed addres=
s BAR
> > + */
> > +int pci_epc_get_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> > +                 enum pci_barno bar, struct pci_epf_bar *epf_bar)
> > +{
> > +     int ret;
> > +
> > +     if (IS_ERR_OR_NULL(epc) || func_no >=3D epc->max_functions)
> > +             return -EINVAL;
> > +
> > +     if (vfunc_no > 0 && (!epc->max_vfs || vfunc_no > epc->max_vfs[fun=
c_no]))
> > +             return -EINVAL;
> > +
> > +     if (bar < 0 || bar >=3D PCI_STD_NUM_BARS)
> > +             return -EINVAL;
> > +
> > +     if (!epc->ops->get_bar)
> > +             return -EINVAL;
> > +
> > +     epf_bar->barno =3D bar;
> > +
> > +     mutex_lock(&epc->lock);
> > +     ret =3D epc->ops->get_bar(epc, func_no, vfunc_no, bar, epf_bar);
> > +     mutex_unlock(&epc->lock);
> > +
> > +     return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(pci_epc_get_bar);
> > +
> >  /**
> >   * pci_epc_write_header() - write standard configuration header
> >   * @epc: the EPC device to which the configuration header should be wr=
itten
> > diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> > index 85bdf2adb760..a5ea50dd49ba 100644
> > --- a/include/linux/pci-epc.h
> > +++ b/include/linux/pci-epc.h
> > @@ -37,6 +37,7 @@ pci_epc_interface_string(enum pci_epc_interface_type =
type)
> >   * @write_header: ops to populate configuration space header
> >   * @set_bar: ops to configure the BAR
> >   * @clear_bar: ops to reset the BAR
> > + * @get_bar: ops to get a fixed address BAR that cannot be set/cleared
> >   * @map_addr: ops to map CPU address to PCI address
> >   * @unmap_addr: ops to unmap CPU address and PCI address
> >   * @set_msi: ops to set the requested number of MSI interrupts in the =
MSI
> > @@ -61,6 +62,8 @@ struct pci_epc_ops {
> >                          struct pci_epf_bar *epf_bar);
> >       void    (*clear_bar)(struct pci_epc *epc, u8 func_no, u8 vfunc_no=
,
> >                            struct pci_epf_bar *epf_bar);
> > +     int     (*get_bar)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> > +                        enum pci_barno, struct pci_epf_bar *epf_bar);
> >       int     (*map_addr)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> >                           phys_addr_t addr, u64 pci_addr, size_t size);
> >       void    (*unmap_addr)(struct pci_epc *epc, u8 func_no, u8 vfunc_n=
o,
> > @@ -163,6 +166,7 @@ enum pci_epc_bar_type {
> >   * struct pci_epc_bar_desc - hardware description for a BAR
> >   * @type: the type of the BAR
> >   * @fixed_size: the fixed size, only applicable if type is BAR_FIXED_M=
ASK.
> > + * @fixed_addr: indicates that the BAR has a fixed address in memory m=
ap.
> >   * @only_64bit: if true, an EPF driver is not allowed to choose if thi=
s BAR
> >   *           should be configured as 32-bit or 64-bit, the EPF driver =
must
> >   *           configure this BAR as 64-bit. Additionally, the BAR succe=
eding
> > @@ -176,6 +180,7 @@ enum pci_epc_bar_type {
> >  struct pci_epc_bar_desc {
> >       enum pci_epc_bar_type type;
> >       u64 fixed_size;
> > +     bool fixed_addr;
>
> Why make this a bool instead of a 64-bits address ?
> If the controller sets this to a non-zero value, we will know it is a fix=
ed
> address bar. And that can avoid adding the get_bar operations, no ?
>

The reason to use a bool is to force the use of 'get_bar', get_bar will fil=
l
the 'pci_epf_bar' structure and memory map the BAR. This ensures the
'pci_epf_bar' structure is filled correctly and usable, same as after a
'pci_epf_alloc_space' operation. This also removes a burden to the
endpoint function (i.e., map the memory, handle errors, set the fields
of the structure etc.). This will likely avoid errors in the endpoint funct=
ions
as this code is quite sensitive and possibly controller specific (e.g.,
memremap for virtual controllers vs ioremap for real controllers). Also,
this code would be duplicated for each endpoint function, therefore I think
it is better to just call 'get_bar' instead of rewriting all corresponding =
lines
in each endpoint function (which would be very error prone).

There could also be other cases where the PCIe controller is behind a
specific bus and the BAR doesn't have a physical address and needs
to be accessed in a specific way. E.g., one could make a BAR accessible
via a serial interface in the FPGA (probably no one will do this, but it is
a possible architecture).

That's why I believe it is important to let the controller fill the
'pci_epf_bar'
structure and do the necessary io/mem remapping internally.

> >       bool only_64bit;
> >  };
> >
> > @@ -238,6 +243,8 @@ int pci_epc_set_bar(struct pci_epc *epc, u8 func_no=
, u8 vfunc_no,
> >                   struct pci_epf_bar *epf_bar);
> >  void pci_epc_clear_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> >                      struct pci_epf_bar *epf_bar);
> > +int pci_epc_get_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> > +                 enum pci_barno, struct pci_epf_bar *epf_bar);
> >  int pci_epc_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> >                    phys_addr_t phys_addr,
> >                    u64 pci_addr, size_t size);
>
> --
> Damien Le Moal
> Western Digital Research
>

Thank you for your insights.
Rick

