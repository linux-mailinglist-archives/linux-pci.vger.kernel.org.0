Return-Path: <linux-pci+bounces-11851-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C39957DFA
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2024 08:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8246B20EB1
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2024 06:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF6C16A952;
	Tue, 20 Aug 2024 06:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQPas/b7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C665D2A1B2;
	Tue, 20 Aug 2024 06:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724134830; cv=none; b=RUsX/w7WTUeLBAiK6JZoPQv323dQ4CiEZfaX1Pz3xD1whOlVle/GIWK1r+Wjj5KCoxjQwpkOeMgl6bazVu7Emg/LRd5gJfnBz38HVwu3eCWoNJP38WkhE1h+PO8BmrPMZOvutorLtF1ttQePHPfnpJwR9/++ci/a3Edjdig5N/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724134830; c=relaxed/simple;
	bh=gDL/XzLpfSCl65/S6UQmsoIBx12iV+8+2JyhWc5HjPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cCOtdX7U3bPhDdq+x0b8tRA1/D9JTg/hmQ8Q73LcBFsZlIxr7Orrh3h+1pGr5JnV5dJ20X8cxJnn7ISrzIHU+86ko33lHCLa+IgkUcjmUFhTsdi241ew1MLJ4ajWwdPW3LeGwFmp7tqsjOWZG7BK4dNO1Y4c5mNvtqr+QbwZACk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQPas/b7; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e115ef5740dso5427619276.3;
        Mon, 19 Aug 2024 23:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724134828; x=1724739628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bK1pglKCKtTqAT4LHsBsp+M9eWHSExxYXES04lOb7A8=;
        b=EQPas/b7GQ3m4p25YsLXQABAZvW34kg3HaBM2WlpAnN3McxjiVaYEcbwUbGNKnChbM
         5fekhqAuV2regyihtGq3S6erHQHtCf1L5QVzVndHFofJNk1ZInkab+6KdD2Q4Z3qc1/s
         XUhaSY7jgN/AcfrnR+FEdjCbFSZLDdQme0nSNgB5sxig6t+UBxYAo6/Ks6PX/aXj7WFS
         3ewvkjDHYKBKJb70bPGVfihvVoUOjsxywGr0Wntc+KwwCMJK5fIhuU/0DzklbY+x12FL
         KWtUUW7y+5VvilNkZg7WIpSKNBbx+7Lu3LSifjV8JdUpNxHm0IKftal/VEkUQ/meNmCF
         DWLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724134828; x=1724739628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bK1pglKCKtTqAT4LHsBsp+M9eWHSExxYXES04lOb7A8=;
        b=eDVBHI6qlBhMwaS+P51DazhsW7yUTnOIjkgY+Kv83tIR1zCRkO9J8KvEmjWkfjKMPh
         NRXvkr8cPNTMsSVoJcU+GV3VqDBTrZa1X6r9MfoukDS9zexWH19Ef62YHar946A/y8SO
         M4HDKddXqvUd1hCMpgsAF5Ul4gXsgnT/j7THD644E9vlicQwcYSH1ISeYUyTtp6mHhz7
         l4hFJfI9si122OYFMZCGVAZcosNbWL5u9XZ7G8eh7CQg6cZRtYm9hRkOCOy0kmkzBpBf
         lLzPuJwmFUTmVDAMWsXN4qvVPHrRs6JSpY4101F681MH6VaW3erzrNWeyPdXlNIWGALa
         Y31w==
X-Forwarded-Encrypted: i=1; AJvYcCUGDHVldC/rfM8RP1uviTmg7ai8ML1uP5uD+/ka3BIL/z1lEP2bm71v+4piI0iNw3z5EQxLykwhr6oE@vger.kernel.org, AJvYcCXEENa2q8kaAeSHMzEvt/3d9cpqks0bk1wKfLT5VMgkPxA/EHdNT0ot/M0etZgDVkCWimf4VyTEhF+kWxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO1ZFTF6GRDhxEx/CGlE2t/WVnlUHMWuBYpmLU/Vk1ADY3ElWL
	MUmjVd6U5eHmSF4kLIMA9BOY5bO9U7zwoeH2Ve6P/cSljqQanm9exq1fjeBdoS1D09q6uChiERA
	Qb+Xqvkh4gBzrPNF6hsiUkv9pj/4pJ3Qc
X-Google-Smtp-Source: AGHT+IGQ5TvN1eH7RbR+l0F+sFZqphnn3ouY8ajt7N3LRSkSXJoLgWgETas8H0QX1yo3eeqfKcIl4hX7OpN1PmYi78E=
X-Received: by 2002:a05:6902:1b86:b0:e13:cca0:6672 with SMTP id
 3f1490d57ef6-e13cca06792mr12829303276.51.1724134827580; Mon, 19 Aug 2024
 23:20:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819120112.23563-1-rick.wertenbroek@gmail.com> <20240820055208.g6iorjl4uhl2jq45@thinkpad>
In-Reply-To: <20240820055208.g6iorjl4uhl2jq45@thinkpad>
From: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Date: Tue, 20 Aug 2024 08:19:51 +0200
Message-ID: <CAAEEuhoLM1zO3vZds58AM6X-roDkZcHzcq_GzrZ2jj_QcisKUw@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: endpoint: pci-epf-test: Move DMA check into
 read/write/copy functions
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: rick.wertenbroek@heig-vd.ch, dlemoal@kernel.org, 
	alberto.dassatti@heig-vd.ch, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Niklas Cassel <cassel@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 7:52=E2=80=AFAM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Mon, Aug 19, 2024 at 02:01:10PM +0200, Rick Wertenbroek wrote:
> > The pci-epf-test PCI endpoint function /drivers/pci/endpoint/function/p=
ci-epf_test.c
> > is meant to be used in a PCI endpoint device inside a host computer wit=
h
> > the host side driver: /drivers/misc/pci_endpoint_test.c.
> >
>
> s/inside/connected to

Thanks, I will substitute this.

>
> > The host side driver can request read/write/copy transactions from the
> > endpoint function and expects an IRQ from the endpoint function once
> > the read/write/copy transaction is finished. These can be issued with o=
r
> > without DMA enabled. If the host side driver requests a read/write/copy
> > transaction with DMA enabled and the endpoint function does not support
> > DMA, the endpoint would only print an error message and wait for furthe=
r
> > commands without sending an IRQ because pci_epf_test_raise_irq() is
> > skipped in pci_epf_test_cmd_handler(). This results in the host side
> > driver hanging indefinitely waiting for the IRQ.
> >
>
> TBH, it doesn't make sense to control the endpoint DMA from host. Host sh=
ould
> just issue the transfer command, and let the endpoint use DMA or memcpy b=
ased on
> its capability.

No, because the test driver is meant to test the endpoint functions
(including the endpoint controller and its capabilities, so they test
if BARs can be read, if IRQs of each type can be sent, if transfers
work, etc.) so it is by design that it allows to ask for transfer with
or without DMA, this allows to test they both work. Also in real case
scenarios on DMA capable devices DMA will not always be used (e.g.,
small transfers where the overhead of DMA setup is bigger than just
doing memcpy_from/toio().

>
> > Move the DMA check into the pci_epf_test_read()/write()/copy() function=
s
> > so that they report a transfer (IO) error and that pci_epf_test_raise_i=
rq()
> > is called when a transfer with DMA is requested, even if unsupported.
> >
> > The host side driver will no longer hang but report an error on transfe=
r
> > (printing "NOT OKAY") thanks to the checksum because no data was moved.
> >
> > Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
> > ---
> >  drivers/pci/endpoint/functions/pci-epf-test.c | 29 +++++++++++++++----
> >  1 file changed, 23 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pc=
i/endpoint/functions/pci-epf-test.c
> > index 7c2ed6eae53a..ec0f79383521 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > @@ -314,6 +314,17 @@ static void pci_epf_test_print_rate(struct pci_epf=
_test *epf_test,
> >                (u64)ts.tv_sec, (u32)ts.tv_nsec, rate);
> >  }
> >
> > +static int pci_epf_test_check_dma(struct pci_epf_test *epf_test,
> > +                                struct pci_epf_test_reg *reg)
> > +{
> > +     if ((READ_ONCE(reg->flags) & FLAG_USE_DMA) &&
> > +         !epf_test->dma_supported) {
> > +             dev_err(&epf_test->epf->dev, "DMA transfer not supported\=
n");
> > +             return -EIO;
> > +     }
> > +     return 0;
> > +}
> > +
> >  static void pci_epf_test_copy(struct pci_epf_test *epf_test,
> >                             struct pci_epf_test_reg *reg)
> >  {
> > @@ -327,6 +338,10 @@ static void pci_epf_test_copy(struct pci_epf_test =
*epf_test,
> >       struct device *dev =3D &epf->dev;
> >       struct pci_epc *epc =3D epf->epc;
> >
> > +     ret =3D pci_epf_test_check_dma(epf_test, reg);
> > +     if (ret)
> > +             goto err;
> > +
> >       src_addr =3D pci_epc_mem_alloc_addr(epc, &src_phys_addr, reg->siz=
e);
> >       if (!src_addr) {
> >               dev_err(dev, "Failed to allocate source address\n");
> > @@ -423,6 +438,10 @@ static void pci_epf_test_read(struct pci_epf_test =
*epf_test,
> >       struct pci_epc *epc =3D epf->epc;
> >       struct device *dma_dev =3D epf->epc->dev.parent;
> >
> > +     ret =3D pci_epf_test_check_dma(epf_test, reg);
> > +     if (ret)
> > +             goto err;
> > +
> >       src_addr =3D pci_epc_mem_alloc_addr(epc, &phys_addr, reg->size);
> >       if (!src_addr) {
> >               dev_err(dev, "Failed to allocate address\n");
> > @@ -507,6 +526,10 @@ static void pci_epf_test_write(struct pci_epf_test=
 *epf_test,
> >       struct pci_epc *epc =3D epf->epc;
> >       struct device *dma_dev =3D epf->epc->dev.parent;
> >
> > +     ret =3D pci_epf_test_check_dma(epf_test, reg);
> > +     if (ret)
> > +             goto err;
> > +
> >       dst_addr =3D pci_epc_mem_alloc_addr(epc, &phys_addr, reg->size);
> >       if (!dst_addr) {
> >               dev_err(dev, "Failed to allocate address\n");
> > @@ -647,12 +670,6 @@ static void pci_epf_test_cmd_handler(struct work_s=
truct *work)
> >       WRITE_ONCE(reg->command, 0);
> >       WRITE_ONCE(reg->status, 0);
> >
> > -     if ((READ_ONCE(reg->flags) & FLAG_USE_DMA) &&
> > -         !epf_test->dma_supported) {
> > -             dev_err(dev, "Cannot transfer data using DMA\n");
> > -             goto reset_handler;
>
> Why can't you just set the status and trigger the IRQ here itself? This a=
voids
> duplicating the check inside each command handler.
>

You are right, that would avoid the duplicated code, I will do so for v3.

> - Mani
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

Thank you for your comments,
Best regards.
Rick

