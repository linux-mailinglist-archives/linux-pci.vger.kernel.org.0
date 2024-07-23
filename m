Return-Path: <linux-pci+bounces-10661-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F4693A427
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 18:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07B4E1F234DE
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 16:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3A1157470;
	Tue, 23 Jul 2024 16:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lcm/08Fj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AD5156F4D;
	Tue, 23 Jul 2024 16:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721750826; cv=none; b=TLBgcEvBYpUWrXYgJMwAoSfT6+5MJ2SauqhYoXO+f4P/9GmazSRRDnjusdzx48hH3qtNnH5OikbNxzSef1Sgr3wlVbTafnyqqgtv3tW0NQLq5cZVFS7gJID0w4Nvm1WnYsEk4qhHBZP1qGwGw2tJPLYlbst/hknPv1Y3w3RQYCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721750826; c=relaxed/simple;
	bh=e9EW7Nc+mZb16mvN+ebaUU/kC4zDknEwVmlDcy9SVuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U7+yKoEDJMJrAgYtRCbRSKaCQcv+7s60+izegMpTX4Hr1VuzI1x8Lz7is8FewKZn1URb+sivJascf6vJsLz1+ZEvTABZqk1JWcZTC/Xz4mQnKyJrfltO3Q01Mj7JRgxkL3qAG1nD4nMTwY9KIjVvDG0GxYHq5T5SCNe5JUsEwnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lcm/08Fj; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e08724b2a08so3264045276.1;
        Tue, 23 Jul 2024 09:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721750824; x=1722355624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6whKPONxWpuod2UaAfqMj9j4YRdef/KUUH1KzMzXWQw=;
        b=Lcm/08FjubgHXU7v2rjY5i8IhLk8kFNo99sgwbbypIG2D+EkOZrvkSLiZ9BTmtmMn1
         Mao5BMUlQqj50q5LZ8cgwRnhLlCAY5W4YFOuHpOf/aj1nYyUQJy6uygAGFSnEpSBAd9i
         XxVPOs39xN1FNDPJ2RsikO6AKIKBYrt9nywZ3UbBPBdX4+dF6xovd3sA5MX6+LtsaUYK
         WAx1TLMuWIYhYVRpzLJLDAmolSqUVb1F1sqTUEW2RkNlRr47WY83Hj4lUNbunal5fpYX
         8UR+QBCGRkjx9XyG9foj2dGJAcJJJqrNMv6SwUZsCWdGV6YdmPcY0VkoHdrj2TIcw4L3
         r+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721750824; x=1722355624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6whKPONxWpuod2UaAfqMj9j4YRdef/KUUH1KzMzXWQw=;
        b=dc8MfmPUYASsEI8TM3DRliQTPupUAtxDR8TxH0+M/PoSz71VGXkv1b93+hNep6SGEF
         VtGnFB27Dc3oHHXMsGCtFw/oIhJ/B1Uei9vgMwBmv7F5QeBE1RsqduLmQ8viWwOGa9v4
         vl2OCKx08pM3h7On+kl6ASthjTZ53GA6KxHPKIXGJ+vSlNI7fnscAw+3/R4blijjZ6PX
         brXcZnsygV/LOlGvYIs2XBf7B97OsRkPnGnZGKKgBoKugCBqm0olp50WJRQrRa7m1VPU
         IsRXD6fYTwx7u4oNgmwvc4kYy+w9Wv6TW79EyOyQxW58pne/WSjI3K1EbYOq54ADqJJW
         Pzuw==
X-Forwarded-Encrypted: i=1; AJvYcCU0urt7LvdYkG+xZs8Ec138aGDltj9TF/SLz6stMHL5Unvz5UD2SnWtX47WwdKeQ5YclovOvZsYiu2RKM/sIY5ROhc8L00WeUhyLeF4AdqqSIEGCtlo//glFXYepec2b0f+bjNtQb07
X-Gm-Message-State: AOJu0Ywwa3lzsg2YOP9SODWxocF/EjP8hz9vaaBd3Esc/zOgS1H60YQc
	9kvuFUSBdXItvZQCkfBkzi+aOpfejEF1O831Y9+nJoh8ziWvVwVErX0wkG0uVZwmPsDTthCtw4Q
	aYiD9jS+tFAHq2qUrmIcYCiqp4s4=
X-Google-Smtp-Source: AGHT+IF1cItnDlJqIfIlEFkY8o7SJ9R4Itiszg3o01fP1prXMEJJpL2VxjYQqt6AZUJDpJsaZuvfEtYFqF3Gmaf6APw=
X-Received: by 2002:a05:6902:2b8b:b0:e02:e12d:88c7 with SMTP id
 3f1490d57ef6-e0b098ccc0cmr349389276.51.1721750823603; Tue, 23 Jul 2024
 09:07:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240719115741.3694893-1-rick.wertenbroek@gmail.com>
 <20240719115741.3694893-2-rick.wertenbroek@gmail.com> <Zp+6TU/nn/Ea6xqq@x1-carbon.lan>
In-Reply-To: <Zp+6TU/nn/Ea6xqq@x1-carbon.lan>
From: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Date: Tue, 23 Jul 2024 18:06:26 +0200
Message-ID: <CAAEEuho08Taw3v2BeCjNDQZ0BRU0oweiLuOuhfrLd7PqAyzSCQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: endpoint: Introduce 'get_bar' to map fixed
 address BARs in EPC
To: Niklas Cassel <cassel@kernel.org>
Cc: rick.wertenbroek@heig-vd.ch, alberto.dassatti@heig-vd.ch, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>, 
	Damien Le Moal <dlemoal@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 4:17=E2=80=AFPM Niklas Cassel <cassel@kernel.org> w=
rote:
>
> On Fri, Jul 19, 2024 at 01:57:38PM +0200, Rick Wertenbroek wrote:
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
>
> Looking at your series, it seems that you skip not only setting up the
> PCI address to internal address translation, you also skip the whole
> call to set_bar(). set_bar() takes a 'pci_epf_bar' struct, and configures
> the hardware accordingly, that means setting the flags for the BARs,
> configuring it as 32 or 64-bit etc.

Thank you for the comments,

This is not skipped, it is done in the new 'get_bar()' function,
depending on the hardware the flags are either fixed, then they are
set inside the 'get_bar()' function, either they are settable and we
could use the ones that come from the 'pci_epf_bar' structure as an
"in-out" parameter. This is dependent on the controller and will be
set in 'get_bar'. The structure returned by 'get_bar' will be filled.
It also means get_bar() will call ioremap() to set the virtual
address, as well as the physical address.

>
> I think you should still call set_bar(). Your PCIe EPC .set_bar() callbac=
k
> can then detect that the type is fixed address, and skip setting up the
> internal address translation. (Although I can imagine someone in the
> future might need a fixed internal address for the BAR, but they still
> need to setup internal address translation.)

That is why I suggested at first to have either the option to use
'set_bar' (translate TLPs to the BAR address to the phys address from
the pci_epf_bar struct) or 'get_bar' (because the translation of TLPs
to BAR is fixed by hardware, and you want to fill the pci_epf_bar
struct with the correct addresses), having both allows to choose the
one adequate for the controller hardware based on features.

>
> Maybe something like this:
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index 85bdf2adb760..50ad728b3b3e 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -151,18 +151,22 @@ struct pci_epc {
>  /**
>   * @BAR_PROGRAMMABLE: The BAR mask can be configured by the EPC.
>   * @BAR_FIXED: The BAR mask is fixed by the hardware.
> + * @BAR_FIXED_ADDR: The BAR mask and physical address is fixed by the ha=
rdware.
>   * @BAR_RESERVED: The BAR should not be touched by an EPF driver.
>   */
>  enum pci_epc_bar_type {
>         BAR_PROGRAMMABLE =3D 0,
>         BAR_FIXED,
> +       BAR_FIXED_ADDR,
>         BAR_RESERVED,
>  };
>
>  /**
>   * struct pci_epc_bar_desc - hardware description for a BAR
>   * @type: the type of the BAR
> - * @fixed_size: the fixed size, only applicable if type is BAR_FIXED_MAS=
K.
> + * @fixed_size: the fixed size, only applicable if type is BAR_FIXED or
> + *             BAR_FIXED_ADDRESS.
> + * @fixed_addr: the fixed address, only applicable if type is BAR_FIXED_=
ADDRESS.
>   * @only_64bit: if true, an EPF driver is not allowed to choose if this =
BAR
>   *             should be configured as 32-bit or 64-bit, the EPF driver =
must
>   *             configure this BAR as 64-bit. Additionally, the BAR succe=
eding
>

Yes, this is very similar to what I suggested initially, with the enum
type instead of a boolean, and we need the address for
pci_epf_alloc_space to do the ioremap, which is not needed if done in
pci_epc_get_bar because the EPC itself knows about the fixed address.

>
> I know you are using a FPGA, but for e.g. DWC, you would simply
> ignore:
> https://github.com/torvalds/linux/blob/master/drivers/pci/controller/dwc/=
pcie-designware-ep.c#L232-L234
>

Yes, exactly. But that needs your change suggested below (if not the
caller should not call 'pci_epf_alloc_space' before calling
'pci_epc_set_bar' and 'pci_epc_set_bar' should still ioremap the fixed
physical address to provide to get the virtual address and provide
both in the 'pci_epf_bar' struct (which should not be pre-filled by
pci_epf_alloc_space)).

>
> Perhaps we even want the EPF drivers to keep calling pci_epf_alloc_space(=
),
> by doing something like:
>
> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/p=
ci-epf-core.c
> index 323f2a60ab16..35f7a9b68006 100644
> --- a/drivers/pci/endpoint/pci-epf-core.c
> +++ b/drivers/pci/endpoint/pci-epf-core.c
> @@ -273,7 +273,9 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t=
 size, enum pci_barno bar,
>         if (size < 128)
>                 size =3D 128;
>
> -       if (epc_features->bar[bar].type =3D=3D BAR_FIXED && bar_fixed_siz=
e) {
> +       if ((epc_features->bar[bar].type =3D=3D BAR_FIXED ||
> +            epc_features->bar[bar].type =3D=3D BAR_FIXED_ADDR)
> +           && bar_fixed_size) {
>                 if (size > bar_fixed_size) {
>                         dev_err(&epf->dev,
>                                 "requested BAR size is larger than fixed =
size\n");
> @@ -296,10 +298,15 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size=
_t size, enum pci_barno bar,
>         }
>
>         dev =3D epc->dev.parent;
> -       space =3D dma_alloc_coherent(dev, size, &phys_addr, GFP_KERNEL);
> -       if (!space) {
> -               dev_err(dev, "failed to allocate mem space\n");
> -               return NULL;
> +       if (epc_features->bar[bar].type =3D=3D BAR_FIXED_ADDR) {
> +               request_mem_region(...);
> +               ioremap(...);
> +       } else {
> +               space =3D dma_alloc_coherent(dev, size, &phys_addr, GFP_K=
ERNEL);
> +               if (!space) {
> +                       dev_err(dev, "failed to allocate mem space\n");
> +                       return NULL;
> +               }
>         }
>
>         epf_bar[bar].phys_addr =3D phys_addr;
>
>

This seems like a sane approach, I thought that because
'pci_epf_alloc_space' was in the EPF part, the EPF may not have been
linked yet to a controller, but here as the features are passed, they
EPF section already knows about the EPC features, so it makes sense to
to do the ioremap() here instead of in 'set/get_bar()'. This would
also be compatible with the current API.

I really like this because it doesn't require a new function. Also it
will not alloc/fill if it is a fixed BAR so less risk of errors when
writing the endpoint function driver.

And I like passing the BAR fixed address in the features, it makes sense.

>
> I could also see some logic in the request_mem_region() and ioremap() cal=
l
> being in the EPC driver's set_bar() callback.

My initial thought was that because it was really EPC dependent it
would be in an EPC function, thus I suggested get_bar.

>
> But like you suggested in the other mail, the right thing is to merge
> alloc_space() and set_bar() anyway. (Basically instead of where EPF drive=
rs
> currently call set_bar(), the should call alloc_and_set_bar() (or whateve=
r)
> instead.)
>

Yes, if we merge both, the code will need to be in the EPC code
(because of the set_bar), and then the pci_epf_alloc_space (if needed)
would be called internally in the EPC code and not in the endpoint
function code.

The only downside, as I said in my other mail, is the very niche case
where the contents of a BAR should be moved and remain unchanged when
rebinding a given endpoint function from one controller to another.
But this is not expected in any endpoint function currently, and with
the new changes, the endpoint could simply copy the BAR contents to a
local buffer and then set the contents in the BAR of the new
controller.
Anyways, probably no one is moving live functions between controllers,
and if needed it still can be done, so no problem here...

>
> Kind regards,
> Niklas

Thank you very much for your insights.
I really like the approach of setting the type and fixed address in
the features.

By doing so we can then merge the alloc/set_bar functions and simplify
the endpoint function drivers while at the same time support fixed
address BARs.

Best regards,
Rick

