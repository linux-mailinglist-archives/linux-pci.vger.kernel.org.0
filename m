Return-Path: <linux-pci+bounces-5227-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D461988D87C
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 09:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE29D1C22EBF
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 08:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66082C1B6;
	Wed, 27 Mar 2024 08:11:48 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53312D047;
	Wed, 27 Mar 2024 08:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711527108; cv=none; b=CKPjyp0ZmqWV24HxNkPIfMzDjaWOlSzBoa0K93oBZlS96cLiwV97nAKodWzGWDDVtzZ1g8sh1PEUehUiC4agqiPxFzXFYuCxO+6U6RG1JmpHjoPHHMQLz142fjCt/dRZLGTzPtmAtTKEBhll0RXm8d75yD52NnA2chVGecQGrOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711527108; c=relaxed/simple;
	bh=U46D17B2Gu9vk8trCq1/YRj4IZbq5hVLH5WPLSTv7ew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ty7CKY95jFPZ+/dccryJd9ihvQPhtPn9ndT1v852lVmbY7h1NFvZ/+2jf59Ul23Wl0gqaBoT9+C2lqp+N1Uk1C50SyrrLHzwL4ROYfXj79mZFHtmpFcp0clJDxXHag+5bnyUSISb1/AImf4quFZH2aCsv184lyaFi+cQ1au78Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-60a057b6601so65165627b3.2;
        Wed, 27 Mar 2024 01:11:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711527104; x=1712131904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2YlWqaeQzs82rsborTsg3j6aUzmebX6FCOBG9i4Wy0Q=;
        b=Ujc2IED1oxd6KOc2ZXTK5ajMNsQHvxfxHCln/VGA9cEtk0jgX6t4h4iluhgn7mW45F
         B0oVHF7BUqsO2HHQCHSMKUCR2N7LAwQJN2QbCP5HQTvaUjDTBTg+oJ3UWLjTcBSUAD95
         DzYEFoSt14VwDQNM2uuRjwlVNai8Ay7+PDZwT/uStuFKV/PsckPdHVwBzLeUdV96rATt
         p6eHScbt15LDjRIKkvajLLSj4CneFicCJ5rM85gdDRFWmxo1SzA8ZXccGYfaZDWTE6BL
         kYYOJD3TM8nid0x9ASjXWBdqHtY43mJ61MmFWhlAcmjaqyjPHPoghXAE3GxVmFQ/tdYL
         yG+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXOKWrngOJbahZ5tSUna1Y23Oc/UPGzmTHgoWGLxxVSM8aiMyzRMpPFyMswMaYpmpmX74gG1WrjeK6Y/uJq3YWkHsOh4IUO7BRqNUdcTZOCqDMvLR5Ffx+yyvByCWY6I5Q5pS6wce/qVhOG+WAh2Blxj1lcOvza2EBvw2XoCTXUi9EzWX5i7Ude
X-Gm-Message-State: AOJu0Ywl0E2RQpCT6HsRsZ5tfIexML+WKgMSR6S37d/Pk2tZ+klkQZIc
	CepQmANUb0nVOHnz6/xFJVIfHQs7RIkcAElqmois8niH1eksKKi2j6CCIDYtTs0=
X-Google-Smtp-Source: AGHT+IEH+cKQzWRIWB2MAWB9HzEsTPA8uBlQhvp6yz8xTUmQx1SO6KkUjCS92+REMGblp+utOcKE7g==
X-Received: by 2002:a0d:dd96:0:b0:610:e31f:2656 with SMTP id g144-20020a0ddd96000000b00610e31f2656mr386514ywe.43.1711527104440;
        Wed, 27 Mar 2024 01:11:44 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id l190-20020a0dfbc7000000b006112b1708a4sm1870302ywf.86.2024.03.27.01.11.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 01:11:43 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dcd7c526cc0so6628670276.1;
        Wed, 27 Mar 2024 01:11:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWtAZ1Ii41ZqgyMOa0ZZCh8fe85wq6GxCRbDOkljnOxGYrSAi6RPKnYJzfWBQ8s+4OSBwXJxUcTpdg3YRSCf7Uhn65RvlLNeIaKi0yfM+YF5egrfYtizFGMSOK3AeqK8poYRxoQLJTcgqfBZs9Kmvz2icEVKQ5tyxlaXmnI0ybv0CoCGoSNX8nf
X-Received: by 2002:a25:ae8e:0:b0:dc7:4f61:5723 with SMTP id
 b14-20020a25ae8e000000b00dc74f615723mr328182ybj.39.1711527103652; Wed, 27 Mar
 2024 01:11:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326024540.2336155-1-yoshihiro.shimoda.uh@renesas.com>
 <20240326024540.2336155-7-yoshihiro.shimoda.uh@renesas.com>
 <ZgI/IGe2L0rJ8SSF@lizhi-Precision-Tower-5810> <TYCPR01MB1104072DA4D6B3DF120A10D0AD8352@TYCPR01MB11040.jpnprd01.prod.outlook.com>
In-Reply-To: <TYCPR01MB1104072DA4D6B3DF120A10D0AD8352@TYCPR01MB11040.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 27 Mar 2024 09:11:32 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU+5=r5Wa9cy0XDRnygumjMsC6mH0Tg-OVgbBkQjk1+0g@mail.gmail.com>
Message-ID: <CAMuHMdU+5=r5Wa9cy0XDRnygumjMsC6mH0Tg-OVgbBkQjk1+0g@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] misc: pci_endpoint_test: Add Device ID for R-Car
 V4H PCIe controller
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Frank Li <Frank.li@nxp.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>, 
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>, 
	"bhelgaas@google.com" <bhelgaas@google.com>, 
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>, 
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "jingoohan1@gmail.com" <jingoohan1@gmail.com>, 
	"gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>, "mani@kernel.org" <mani@kernel.org>, 
	"marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shimoda-san,

On Tue, Mar 26, 2024 at 6:47=E2=80=AFAM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> > From: Frank Li, Sent: Tuesday, March 26, 2024 12:21 PM
> > On Tue, Mar 26, 2024 at 11:45:40AM +0900, Yoshihiro Shimoda wrote:
> > > Add Renesas R8A779G0 in pci_device_id table so that pci-epf-test
> > > can be used for testing PCIe EP on R-Car V4H.
> > >
> > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > ---
> > >  drivers/misc/pci_endpoint_test.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endp=
oint_test.c
> > > index c38a6083f0a7..2fa3c6473c7d 100644
> > > --- a/drivers/misc/pci_endpoint_test.c
> > > +++ b/drivers/misc/pci_endpoint_test.c
> > > @@ -83,6 +83,7 @@
> > >  #define PCI_DEVICE_ID_RENESAS_R8A774C0             0x002d
> > >  #define PCI_DEVICE_ID_RENESAS_R8A774E1             0x0025
> > >  #define PCI_DEVICE_ID_RENESAS_R8A779F0             0x0031
> > > +#define PCI_DEVICE_ID_RENESAS_R8A779G0             0x0030
> > >
> > >  static DEFINE_IDA(pci_endpoint_test_ida);
> > >
> > > @@ -1005,6 +1006,9 @@ static const struct pci_device_id pci_endpoint_=
test_tbl[] =3D {
> > >     { PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A779F=
0),
> > >       .driver_data =3D (kernel_ulong_t)&default_data,
> > >     },
> > > +   { PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A779G=
0),
> > > +     .driver_data =3D (kernel_ulong_t)&default_data,
> > > +   },
> >
> > You use default_data, why need new device_id? I think you can use 0x003=
1
> > to do test.
>
> I thought we can add a new device_id freely like other devices.
> Since the PCIe controller's endpoint mode can configure the device id,
> I can use 0x0031 to do test though.

Can it? The documentation for the PCICONF0Fi register states both the
DEVICE_ID and VENDOR_ID bits are read-only.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

