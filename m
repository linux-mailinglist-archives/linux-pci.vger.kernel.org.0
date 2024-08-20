Return-Path: <linux-pci+bounces-11866-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 812C0958138
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2024 10:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFA9F1F2501C
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2024 08:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321F318A933;
	Tue, 20 Aug 2024 08:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VN4EYgCL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8574A18A6CA;
	Tue, 20 Aug 2024 08:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724143476; cv=none; b=QannhyOnRt5zEfQCSQSv2gcM3NakCLm2/F65ghFOA9d0PxseyD5cgcdt9KbyYCEd2fpeScS7L33faW8tI5seN0Wprx1pE+4WYxE2bJPA1FTil6Wax8ZitTi49XX4+LXjSyaEmmSQ8WcRFxdZ1P4v/ubpEvJOIuwsjdav7XnRqBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724143476; c=relaxed/simple;
	bh=zXjLTqp2h/x8G1ZuHFIdm15gsckshfdMYAxJZ/Rg9jQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=umf5FMBdpOqAOafF/aEHltmD6lrWwP3i+3U/yCEb4XK3wStznAJ2bJFBbG5txCnrPM8v82lMYx9kfZLk3Xc0v6MoIXAvmOYFI4bzYap/6UFgnU0mAtei7/98DR2llsbQ3HlodjCxxNy2coRstVDVu79velZBXO7PMmD6/4QbTRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VN4EYgCL; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e117059666eso4909222276.3;
        Tue, 20 Aug 2024 01:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724143473; x=1724748273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xcJIFfrDiJ0q2Ax8EZvdVHtaHrMDhvNm5ii2A3n09y0=;
        b=VN4EYgCLuzMBPvcAnxKaw7jruYaj/jDXhR/Kt+LCtUh6PAo1uknpudp4+GfniPNdDY
         ev5rs9gNgQYMYJ6FN12Wlm3sO3pGGLKqjXIhlRcSmdMugOQ8XQQDjSZDunDwH0mzC6K9
         a9fzpHvFPFy4fB0YSKQbNx9FJ3RktBc9ouWokTfZdNSlZsalh36m2SIJrmyVYWu2Ze54
         T6qk6iOGpfBGDZHlF2Uk/OE+IuFea4cxAEzB9ll4PwLsf8CI5CJYsWrxYMl+bYGV9pLK
         qT0xh4wrYwDI+ImXnQ5c6cQxFnSq/VWYiSIppjZpbHmSe16kPwXLbME/ayo5pIhM60OB
         yTow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724143473; x=1724748273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xcJIFfrDiJ0q2Ax8EZvdVHtaHrMDhvNm5ii2A3n09y0=;
        b=DvwZ2JM91bNWkEKyFEyF6/s/oN5b6Z0ZxuDgpillVQ2pQbcOxCpweoPqlz6n82evlW
         syH3NNTQbLWHprSlRhBFpk2DXwlkWJp831v7+m45bKIpFMEkH+/wF4fAe6ASv2sNK1kH
         leE6j2KU9OktXXsxjQoHCNGh5PwcxQ+RrdKfZ+B/g843b24renF4eQDwE5v1n6zFNymk
         52J328k1LS2PD+E/HtysGUHWmkTF/u0V5skhsLzY4ax4KFPVstzycqmRrjfUpbv+FXps
         k5qqe2V4Aj3N1u972A3PuGLlDkrSMpTgpfqvXGySvqu4aKsciXwDo0vZMiWLP9H15aA0
         IrWA==
X-Forwarded-Encrypted: i=1; AJvYcCUAbEJO42hEouOvkJnfXY0wMpkTrW/V4VuXFV7ArDotOlftn7gFRpj0hbhLt+GCp1kCJNx3hl7trs6nN+Q=@vger.kernel.org, AJvYcCXpcnINwy1UnCoVkjGqYkN9xuIs1/LWpidDtQJznFcZEwhayjA0QRzr8YfSClJOI+sq8hWV+RKlYcUN@vger.kernel.org
X-Gm-Message-State: AOJu0YwanlhiFV7Fo5JdF3bLc3CyKzcakhhFuSwvn2/tkUDDWKQyRxaP
	4UDEVY/No2rRstHXS6MvF8KCpus5taRkY+ybLNhqGLN9BcxycSjTOO+V2CXA0Fw700OQtK7F7/S
	GyuMm523FwgDiJc/CU8dYFLD+aWo=
X-Google-Smtp-Source: AGHT+IE6eB/rNQ6Oeba5+IdjGRKnD7dGJoj8sKX+nCcvXftQWM+Nye+Jn8rUWfuSMzzYQRfsB9UJCJ0NqfMBo9731LY=
X-Received: by 2002:a05:6902:1382:b0:e0e:c869:676 with SMTP id
 3f1490d57ef6-e1180f1bfb5mr13531703276.32.1724143473200; Tue, 20 Aug 2024
 01:44:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820071100.211622-1-rick.wertenbroek@gmail.com>
 <20240820071100.211622-2-rick.wertenbroek@gmail.com> <54451b81-b503-4072-807a-af2f0b914ec2@kernel.org>
In-Reply-To: <54451b81-b503-4072-807a-af2f0b914ec2@kernel.org>
From: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Date: Tue, 20 Aug 2024 10:43:56 +0200
Message-ID: <CAAEEuhpt_WnxOZeYsMxjwTGZm-FJKoj3at-qPgyAH6D76P9wOA@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] PCI: endpoint: pci-epf-test: Call
 pci_epf_test_raise_irq() on failed DMA check
To: Damien Le Moal <dlemoal@kernel.org>
Cc: rick.wertenbroek@heig-vd.ch, alberto.dassatti@heig-vd.ch, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Niklas Cassel <cassel@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 10:18=E2=80=AFAM Damien Le Moal <dlemoal@kernel.org=
> wrote:
>
> On 8/20/24 16:10, Rick Wertenbroek wrote:
> > The pci-epf-test PCI endpoint function /drivers/pci/endpoint/function/p=
ci-epf_test.c
> > is meant to be used in a PCI endpoint device connected to a host comput=
er
> > with the host side driver: /drivers/misc/pci_endpoint_test.c.
> >
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
> > Call pci_epf_test_raise_irq() when a transfer with DMA is requested but
> > DMA is unsupported. The host side driver will no longer hang but report
> > an error on transfer (printing "NOT OKAY") thanks to the checksum becau=
se
> > no data was moved.
> >
> > Clarify the error message in the endpoint function as "Cannot ..." is
> > vague and does not state the reason why it cannot be done.
> >
> > Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
> > ---
> >  drivers/pci/endpoint/functions/pci-epf-test.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pc=
i/endpoint/functions/pci-epf-test.c
> > index 7c2ed6eae53a..b02193cef06e 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > @@ -649,7 +649,8 @@ static void pci_epf_test_cmd_handler(struct work_st=
ruct *work)
> >
> >       if ((READ_ONCE(reg->flags) & FLAG_USE_DMA) &&
> >           !epf_test->dma_supported) {
> > -             dev_err(dev, "Cannot transfer data using DMA\n");
> > +             dev_err(dev, "DMA transfer not supported\n");
>
> Should we set the FAIL status flag here ?
> E.g.:
>                  reg->status |=3D STATUS_READ_FAIL;
>
> Note: I have no idea why the status flags are different for the different
> operations. We should really have a single SUCCESS/FAIL flag common to al=
l
> operations. So I think we could just do:
>
>                 reg->status |=3D STATUS_READ_FAIL | STATUS_WRITE_FAIL |
>                         STATUS_COPY_FAIL;
>
> here, or go back to your v1 and handle the failure in each operation func=
tion to
> set the correct flag.
>

Good catch, indeed with the check outside of the functions, the status
FAIL bits are not set. I think setting the status as a combined fail
flag makes sense, however, it conveys the idea that read/write/copy
failed whereas only one of them actually failed.

I agree that a single status SUCCESS/FAIL flag would be simpler. But
changing this would require changes on both sides (EP & RC) and will
reduce compatibility between EP and RC side driver versions, so I
would refrain from changing this.

 I think I still prefer the v1/v2 code because even as it has a little
bit of duplication it is clear and sets the correct FAIL bit without
extra logic whereas here we either set all FAIL bits or have to add
extra logic.

Thank you for spotting this.

> > +             pci_epf_test_raise_irq(epf_test, reg);
> >               goto reset_handler;
> >       }
> >
>
> --
> Damien Le Moal
> Western Digital Research
>

Best regards,
Rick

