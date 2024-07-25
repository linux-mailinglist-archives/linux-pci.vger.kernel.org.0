Return-Path: <linux-pci+bounces-10775-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B705B93BDB1
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 10:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 374611F25446
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 08:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FFA172BAD;
	Thu, 25 Jul 2024 08:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlbVAu/y"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5775B249ED;
	Thu, 25 Jul 2024 08:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721894837; cv=none; b=CCgr570VCkpqSpbbcKm/+eoU4MktFLpkLXtT7+zM0q37ekUs9Lhrrws0xeCaw5gbxDCiWtCNNG6WlXznR7HHLY2l8qJIGTJ5/40Snj9EbqR9CZT9PT8oMKiZnfdcUlwOgmAjDfELx/tgJWkEv+Lr3bqK7nXtZ8pD2lsbFDlNgYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721894837; c=relaxed/simple;
	bh=uRF8pambJl322RqU1w85aToq0Z8fYmDJceRpw2xLLyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JojZBmQXha2Htxs6zk/6vH9ntyfyNyaKE9MOYt5I+w2LeCLc3oxHNj4Bhc+4ddz/wUirXYc+5NfrMLGjezhGRhoUOYLgHRU+hvMA7tESRsD1S0wc6EZq9CCCkIS7Tj7+kEHEa0iOPq8R99qS56XshZj7Wd2qorDQ+qpoof6A3HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mlbVAu/y; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e0b2d2e7dc9so323968276.2;
        Thu, 25 Jul 2024 01:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721894835; x=1722499635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRF8pambJl322RqU1w85aToq0Z8fYmDJceRpw2xLLyU=;
        b=mlbVAu/ySEkwBVcZUpTIh+751KZ4d57Crm1ZWz8HQpXKf4MHS+zhnvO2NZSnz0sX0X
         8uDQbeW09ZRHlOQNgUNtqteed01o5rAWF+0v7NOHWFPTof+kGD6hCy9UT+CXsOZsldE2
         EJHHYIkzamTAjaSnXQXg4PE7XAPIPvNesxGhs3a1LA4c8EE11ui7f2EE3LU4pFBTROZq
         Zy8fhBRwYpkiVKPwbx6OUOzFc8IE87xL+Vey7QZkdQUglIczdE16RqHU+s7Iw0HxlXJE
         9GotP/Qm/mc5RUu/3XfgLpFN/o9BW+zsZ+h/3jFBVGAAosD02mkAXOIQumgF/SwG0nIK
         w0lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721894835; x=1722499635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uRF8pambJl322RqU1w85aToq0Z8fYmDJceRpw2xLLyU=;
        b=Ib70SjhZzSPsn5YzVNbbiVsV52R9lnzsxYiTdGjBIJG8aCQrlGNNvpf7BkkFCjiiG6
         2JtD5usRuoq04Bjb0O38ERqJQvYtTSzUzqkR3Xz45WVJ8y0YPebkrQN2lixXxljzFj3j
         tYtZeF3mkFzHh083OEZyoSTd+/hcurvwR14+5vGzY7TJh4Z57IZ7+GBH+ADMLEiLj7y8
         noL8zZgCe18BpcLMF7oP2+19ATi9J/vJYuSEaNgoJq0XE+8lyAU0e36iqeKRAgiuTsQq
         W6Z4adOccFZYRrx/hHZP2ujXtn7DXnxobW0To+isXqRsr5H5HX1Lxo5kiCYHkkPON8Av
         EmDA==
X-Forwarded-Encrypted: i=1; AJvYcCXRvts1bmfAtZL4z34FCCaZj83oAL3d6yzelC/Tkd3mimNXktriYC8OgdBMSAgkH2AWdFjyeTbREnicd90DFuUpgZfCsBAktf146drWyc/qcOa3BPoPAojdn5MQMiKwPFcOAdx3F+sI
X-Gm-Message-State: AOJu0Yx2kzanE3PQGSmyvMQBasmRw6QCtJIiu6wwhYdPzSCWPL/dXMUt
	r27z1/VW/4Aeo5z/30fD/oRIeFhAwnGvxwp/pvBTgVYSzP/OBw2GDBzQmJUUJ1KhHYeGE9DTdwv
	2W1aD27ACMu4t31AmngHunwPLqOM=
X-Google-Smtp-Source: AGHT+IHrhxwnPYZgM5EehjsiQcLvHlMl8QU7y+f+55RQlhP/M18toEOXGDLullzSQcZy1oi+8wBFfnKpLb66fJwp8qM=
X-Received: by 2002:a05:6902:726:b0:e03:6085:33e9 with SMTP id
 3f1490d57ef6-e0b231ddd3fmr2157737276.2.1721894835154; Thu, 25 Jul 2024
 01:07:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240719115741.3694893-1-rick.wertenbroek@gmail.com>
 <20240719115741.3694893-2-rick.wertenbroek@gmail.com> <Zp+6TU/nn/Ea6xqq@x1-carbon.lan>
 <CAAEEuho08Taw3v2BeCjNDQZ0BRU0oweiLuOuhfrLd7PqAyzSCQ@mail.gmail.com>
 <Zp/e2+NanHRNVfRJ@x1-carbon.lan> <20240725053348.GN2317@thinkpad>
In-Reply-To: <20240725053348.GN2317@thinkpad>
From: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Date: Thu, 25 Jul 2024 10:06:38 +0200
Message-ID: <CAAEEuhpH-HB-tLinkLcCmiJ-9fmrGVjJFTjj7Nxk5M8M3XxSPA@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: endpoint: Introduce 'get_bar' to map fixed
 address BARs in EPC
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Niklas Cassel <cassel@kernel.org>, rick.wertenbroek@heig-vd.ch, 
	alberto.dassatti@heig-vd.ch, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>, 
	Damien Le Moal <dlemoal@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 7:33=E2=80=AFAM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Tue, Jul 23, 2024 at 06:48:27PM +0200, Niklas Cassel wrote:
> > Hello Rick,
> >
> > On Tue, Jul 23, 2024 at 06:06:26PM +0200, Rick Wertenbroek wrote:
> > > >
> > > > But like you suggested in the other mail, the right thing is to mer=
ge
> > > > alloc_space() and set_bar() anyway. (Basically instead of where EPF=
 drivers
> > > > currently call set_bar(), the should call alloc_and_set_bar() (or w=
hatever)
> > > > instead.)
> > > >
> > >
> > > Yes, if we merge both, the code will need to be in the EPC code
> > > (because of the set_bar), and then the pci_epf_alloc_space (if needed=
)
> > > would be called internally in the EPC code and not in the endpoint
> > > function code.
> > >
> > > The only downside, as I said in my other mail, is the very niche case
> > > where the contents of a BAR should be moved and remain unchanged when
> > > rebinding a given endpoint function from one controller to another.
> > > But this is not expected in any endpoint function currently, and with
> > > the new changes, the endpoint could simply copy the BAR contents to a
> > > local buffer and then set the contents in the BAR of the new
> > > controller.
> > > Anyways, probably no one is moving live functions between controllers=
,
> > > and if needed it still can be done, so no problem here...
> >
> > I think we need to wait for Mani's opinion, but I've never heard of any=
one
> > doing so, and I agree with your suggested feature to copy the BAR conte=
nts
> > in case anyone actually changes the backing EPC controller to an EPF.
> > (You would need to stop the EPC to unbind + bind anyway, IIRC.)
> >
>
> Hi Rick/Niklas,
>
> TBH, I don't think currently we have an usecase for remapping the EPC to =
EPF. So
> we do not need to worry until the actual requirement comes.
>
> But I really like combining alloc() and set_bar() APIs. Something I wante=
d to do
> for so long but never got around to it. We can use the API name something=
 like
> pci_epc_alloc_set_bar(). I don't like 'set' in the name, but I guess we n=
eed to
> have it to align with existing APIs.
>
> And regarding the implementation, the use of fixed address for BAR is not=
 new.
> If you look into the pci-epf-mhi.c driver, you can see that I use a fixed=
 BAR0
> location that is derived from the controller DT node (MMIO region).
>
> But I was thinking of moving this region to EPF node once we add DT suppo=
rt for
> EPF driver. Because, there can be many EPFs in a single endpoint and each=
 can
> have upto 6 BARs. We cannot really describe each resource in the controll=
er DT
> node.
>
> Given that you really have a usecase now for multiple BARs, I think it is=
 best
> if we can add DT support for the EPF drivers and describe the BAR resourc=
es in
> each EPF node. With that, we can hide all the resource allocation within =
the EPC
> core without exposing any flag to the EPF drivers.
>
> So if the EPF node has a fixed location for BAR and defined in DT, then t=
he new
> API pci_epf_alloc_set_bar() API will use that address and configure it
> accordingly. If not, it will just call pci_epf_alloc_space() internally t=
o
> allocate the memory from coherent region and use it.
>
> Wdyt?
>
> - Mani
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

Hello Mani, thank you for your feedback.

I don't know if the EPF node in the DT is the right place for the
following reasons. First, it describes the requirements of the EPF and
not the restrictions imposed by the EPC (so for example one function
requires the BAR to use a given physical address and this is described
in the DT EPF node, but the controller could use any address, it just
configures the controller to use the address the EPF wants, but in the
other case (e.g., on FPGA), the EPC can only handle a BAR at a given
physical address and no other address so this should be in the EPC
node). Second, it is very static, so the EPC relation EPF would be
bound in the DT, I prefer being able to bind-unbind from configfs so
that I can make changes without reboot (e.g., alternate between two or
more endpoint functions, which may have different BAR requirements and
configurations).

For the EPFs I really think it is good to keep the BAR requirements in
the code for the moment, this makes it easier to swap endpoint
functions and makes development easier as well (e.g., binding several
different EPFs without reboot of the SoC they run on. In my typical
tests I bind one function, turn-on the host, do tests, turn-off the
host, make changes to an EPF, scp the new .ko on the SoC, rebind,
turn-on the host, etc.). For example, I alternate between pci-epf-test
(6 bars) and pci-epf-nvme (1 bar) of different sizes.

However, I can see a world where both binding and configuring EPF from
DT and the way it is currently done (alloc/set bar in code) and bind
in configfs could exist together as each have their use cases. But
forcing the use of DT seems impractical.

For combining pci_epf_alloc_space and pci_epc_set_bar into a single
function, everyone seems to agree on this one.

Best regards,
Rick

