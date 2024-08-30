Return-Path: <linux-pci+bounces-12524-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6169E96668C
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 18:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13C6C1F21638
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 16:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8301B3B15;
	Fri, 30 Aug 2024 16:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b="oXbROQLz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EB1199FB7
	for <linux-pci@vger.kernel.org>; Fri, 30 Aug 2024 16:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725034329; cv=none; b=j+DNQAY00N97oGUhY0ogbWeOrESmvXxe83lzXz+ZD5PpoBFNyYUHV3AfZJkf/FuHgOELMQ3RRbvnHrM89dJ8fyAik6R7Gq3FzycWwqsu9oaAgfX6i+DLyU5LANea63DUQFDUE9t5FjYvPH2FPYO1PO7zkrcpOC9hZIqvtjvLca8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725034329; c=relaxed/simple;
	bh=dK1d5OoMnp7x/LLdkb383yto76ri3nmVIZz+8dK5Jls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IcxjV2HkBaCgxwtaxu9TD8TYubmkiGClS/dCW4wo+DjQf00IffNy74gpIVwHsOEmSsuLr0gTEw5PTMFE3X6Tu4ZgNJcl02nBB+15wGdKchqGuGUkIRoSiAj6XqvR0inhb9M4D7zD6HRUAszWbG/YIZ0wXwEO4z6ls4s20vMuHzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b=oXbROQLz; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c0a9ae3665so2122352a12.0
        for <linux-pci@vger.kernel.org>; Fri, 30 Aug 2024 09:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks.com; s=google; t=1725034326; x=1725639126; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/9FLctole61vEfwdoWMJoE9xXyb0sTvmy+ncvIVR+xY=;
        b=oXbROQLzNdji7LddPG4veghIqiu7Dmj8FIIOMvvzoCo6G2RrJFek4pltNBr+CisNNK
         8QIEsbs636NAVZ8SyhXujhIe82jp7+EGEqaIGKf6IbspHPt8pQ+qyscSupCGKAJb4nTP
         6XckrYHN4QKDPmuplFTOSyrmgtkfwY8jlj54aVR1GkNOLFw+oTWNjtMghkpejXYKEfup
         AkLI7zlgDbIcNXhXENW8VcC+KNU2W0Qm+lxeHhfHQD4LY6qhqn+f+reqPuSaEZnn8NbF
         WJ+CbdOFz0F+7OHaZaLba2+q3CpNRMU7F1CFzuK4Lsb2lYkTUOxH/YglCQ9M3epeoRPN
         uysA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725034326; x=1725639126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/9FLctole61vEfwdoWMJoE9xXyb0sTvmy+ncvIVR+xY=;
        b=DTKvMAsbTDSEm90A8u3F+CFeEzA3FQvth8Gz1I5WSWEr9xG9T0kaKlwvRhhuyNPXEJ
         ey9ODr8eLOe8FKGCHd6IK1lFguxf/fi1O9hj2Aje2Qki0Y454Xl7QPAIYyOTcEWDE9ZI
         IVEkTut+BaPMkSh+9GSlYU/49OpVXXJhQ215veTldfdKIyl4OgwQbJ7Qpf90yXyaHdb6
         zwhQLTotnTqPcJeiubzU8NclE/52QzxujPgA2SU0uvxLiSb9Ce6o6Tt2TtYejgKvtIov
         g0PQCwZbJ5AsLNKzbD08jxekNqrlARIreLcE645ZBDAhguuxLY+xB6n4nr1E0Y0p9nVh
         XBPw==
X-Forwarded-Encrypted: i=1; AJvYcCW5br1Wa7uDzmCkkIRMfYzYYeOb+d8NnxEdrY5i3PbYNutIWQAyUcFFsm3VSoCBI5TEwA67S3BPFwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz13gOOqkuTVVe33OyYSAj7YlyKCYi91ckid/SbI5WuwlSxEwi3
	dhjwtoYiVfaWduoRZJmc1dy5zakHm/aeDqsapJsDE/bYpqNvYN/iMrW3uZ/ndna/3B0xbNFylGz
	wiaz1vOHgaw1a0K5ZFc0HPnCXgKDe6/dDjwa1Gg==
X-Google-Smtp-Source: AGHT+IHKYPJaSGGd51QpvKB7EUTICR7TYTz4bahiK29RKw0Wv0vjDM696NIBR3z568Z9jbSVEeXNYpMZTXgg9M46REw=
X-Received: by 2002:a17:907:1b2a:b0:a86:9868:5d9d with SMTP id
 a640c23a62f3a-a897f930932mr560469966b.29.1725034325369; Fri, 30 Aug 2024
 09:12:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZtDrjl3b8yhumk+A@lizhi-Precision-Tower-5810> <20240829220005.GA81596@bhelgaas>
 <CAJ+vNU0taRj3PgP1tgcK68C++x93XO-aitvn42Pmk3EoWuj7OA@mail.gmail.com> <ZtHqxfPgXo1RlZbC@lizhi-Precision-Tower-5810>
In-Reply-To: <ZtHqxfPgXo1RlZbC@lizhi-Precision-Tower-5810>
From: Tim Harvey <tharvey@gateworks.com>
Date: Fri, 30 Aug 2024 09:11:54 -0700
Message-ID: <CAJ+vNU2uBq5t5wJG-kRX=ErBzR6o2Ft8aTk5oY6g1UbQ7BKb-w@mail.gmail.com>
Subject: Re: legacy PCI device behind a bridge not getting a valid IRQ on imx
 host controller
To: Frank Li <Frank.li@nxp.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Richard Zhu <hongxing.zhu@nxp.com>, 
	Lucas Stach <l.stach@pengutronix.de>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 8:52=E2=80=AFAM Frank Li <Frank.li@nxp.com> wrote:
>
> On Thu, Aug 29, 2024 at 03:21:13PM -0700, Tim Harvey wrote:
> > On Thu, Aug 29, 2024 at 3:00=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.o=
rg> wrote:
> > >
> > > On Thu, Aug 29, 2024 at 05:43:42PM -0400, Frank Li wrote:
> > > > On Thu, Aug 29, 2024 at 04:22:35PM -0500, Bjorn Helgaas wrote:
> > > > > On Wed, Aug 28, 2024 at 02:40:33PM -0700, Tim Harvey wrote:
> > > > > > Greetings,
> > > > > >
> > > > > > I have a user that is using an IMX8MM SoC (dwc controller) with=
 a
> > > > > > miniPCIe card that has a PEX8112 PCI-to-PCIe bridge to a legacy=
 PCI
> > > > > > device and the device is not getting a valid interrupt.
> > > > >
> > > > > Does pci-imx6.c support INTx at all?
> > > >
> > > > Yes, dwc controller map INTx message to 4 irq lines, which connect =
to GIC.
> > > > we tested it by add nomsi in kernel command line.
> > >
> > > Thanks, Frank.  Can you point me to the dwc code where this happens?
> > > Maybe I can remember this for next time or add a comment to help
> > > people find it.
> > >
> > > Bjorn
> >
> > Bjorn and Frank,
> >
> > I provided some misinformation regarding IMX6 - my original testing
> > was flawed. When testing the IMX6DL linked to a XIO2001 with a legacy
> > PCI device behind it the device driver is given an appropriate legacy
> > IRQ.
> >
> > Regarding IMX8MM linked to a PEX8112 bridge with a legacy PCI device
> > behind it; the user gets a -28 (ENOSPC) when requesting an IRQ from
> > the driver but I don't have the hardware or the driver for that in
> > hand so I need to wait for more details. I don't see any reason why
> > this case would not work as it works on an IMX6DL.
>
> Do you have chance to try other arm64 platform? Maybe defconfig cause thi=
s
> difference. CONFIG_PCIEPORTBUS=3Dy is enabled default in arm64, but not
> at arm32.
>

Frank,

It's unclear what other platforms they have been able to run this on.
I'll have to wait for the hardware in the form of a miniPCIe card. The
card showing the issue on imx8mm is a DDC BU-67114 [1].

Best Regards,

Tim
[1]

