Return-Path: <linux-pci+bounces-16349-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7569C22E0
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 18:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1D5A1F221A9
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 17:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125901F428F;
	Fri,  8 Nov 2024 17:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NvNERBPH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B8D199953;
	Fri,  8 Nov 2024 17:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731086689; cv=none; b=aL8P5tspLOBQXADLzXIeKnuHWVpIp0WkIZwN5kw6+69ZL9c9DDZ8XrTo4oJdDnEDf7cpXoDwCmWHtyPZwqIO0f+C1efVxiCkl1SxtfuyrI07KTPiPXNk2hi8587I3O4fap+A8dLJ8lMGxF0A8i8sFddXUgp2+JFXQThIkbNLAkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731086689; c=relaxed/simple;
	bh=KCAI+t0FDLnCxPwS3wOLx2If4t6X/SaOrnESfIJLqbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U4k0l0cHDVoYvZY1qeDD/TQETffXqbQ5CEa023NrfGi0WIagMN5c3Mjt6qk3XeLilvfzZ6ByyVN5oJFx3kLTQsnp+hbVnAQ8bfRTvsTg+/Zts7o+GvP08RpKx+53NPEPaXRXt7yxts4gGNL+ahZiOUQwCgnx03JCrTITAKVlZp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NvNERBPH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 583C3C4CED4;
	Fri,  8 Nov 2024 17:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731086688;
	bh=KCAI+t0FDLnCxPwS3wOLx2If4t6X/SaOrnESfIJLqbY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NvNERBPH4lBhuvKatnosoN9Ho3crexy1Z9MpDvcV3EE5H1gBQtCWjweHq+6YYPGuh
	 FmdD6UdJYD9cbaYI6bRjU8p3vW29dyNKzz8GmqpZcrQqnOjp2Ig/0T5UVupg27B8C/
	 3x/+Ut+D9lHW5UMR9mCoQ48/fOBnqOsQgbRlT0qk8VLDKCt7cIk7UErBZYvcNJ5qNt
	 iM1wnMGICNVE7CKJ/zNDxFRiLUigY8fK3OkK9DBSARkHObszY8hxv1r5O0n5Mlf7tt
	 uz3lPV1VvFInfWfpYpqpm2+7gITzov7pj7Gv9JUKtVGKekNyuxYvvjW4V2SAzPIxnu
	 8Sobx2Tvz43TQ==
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6e33c65d104so20599647b3.3;
        Fri, 08 Nov 2024 09:24:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVESmIW9qre/oiTnZ44uAVawEipjMWB7qy8eb+7Uu7nDq2igJvY5fvc7oGnHuTrFbZBZACmUzkb3QoJ@vger.kernel.org, AJvYcCXG9KP/btpgtnCpQydPSYJfImJSIDIWqI0ZCZ+h1XmqDClJe8ZrHFxDJpaYkDNV1KnoSgM8kU9zp6M3@vger.kernel.org, AJvYcCXwE+cGR/uMnjUoAYv3Ptuf1XPMSOe+QPombHv8CbHMBXTcaw+kFJ3f/GIaYcP10lmsvgvOhKs/JMYg/KEL@vger.kernel.org
X-Gm-Message-State: AOJu0YycRdTuqzKaO4uhz2EAXPp3gdZwNtt/G6XuldEuKyYxad9CWnjr
	a8Z6EVZ3Db1EIEnvGpPI2XNPcmb7ZdViK827rxipjuZiOtNdM0FeHRui2jT4KF9mXVq9JkHLEKG
	bybuAW/0/03ON3NkygdjILo53Ng==
X-Google-Smtp-Source: AGHT+IGAZBfJGxfw4NOqc6ySUStY1o7/948qZdZBOgA2D5SiBeoZvIJWd4DLZ2BoZw8kmgLuwhGCHUjvFAmP2DLNAsI=
X-Received: by 2002:a05:690c:46c4:b0:69d:e911:88c3 with SMTP id
 00721157ae682-6eadde3ce09mr47040557b3.29.1731086687506; Fri, 08 Nov 2024
 09:24:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108143600.756224-1-herve.codina@bootlin.com>
 <20241108143600.756224-6-herve.codina@bootlin.com> <CAL_JsqJ-05tB7QSjmGvFLbKFGmzezJhukDGS3fP9GFtp2=BWOA@mail.gmail.com>
 <20241108172946.7233825e@bootlin.com>
In-Reply-To: <20241108172946.7233825e@bootlin.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 8 Nov 2024 11:24:36 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLWUSCJMU5LMz8X_0gU74YNy6-vRXGvY24ZpVj+EZW-sA@mail.gmail.com>
Message-ID: <CAL_JsqLWUSCJMU5LMz8X_0gU74YNy6-vRXGvY24ZpVj+EZW-sA@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] of: Add #address-cells/#size-cells in the
 device-tree root empty node
To: Herve Codina <herve.codina@bootlin.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lizhi Hou <lizhi.hou@amd.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org, 
	Allan Nielsen <allan.nielsen@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>, 
	Steen Hegelund <steen.hegelund@microchip.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 10:29=E2=80=AFAM Herve Codina <herve.codina@bootlin.=
com> wrote:
>
> Hi Rob,
>
> On Fri, 8 Nov 2024 10:03:31 -0600
> Rob Herring <robh@kernel.org> wrote:
>
> > On Fri, Nov 8, 2024 at 8:36=E2=80=AFAM Herve Codina <herve.codina@bootl=
in.com> wrote:
> > >
> > > On systems where ACPI is enabled or when a device-tree is not passed =
to
> > > the kernel by the bootloader, a device-tree root empty node is create=
d.
> > > This device-tree root empty node doesn't have the #address-cells and =
the

> > > +       /*
> > > +        * #address-cells/#size-cells are required properties at root=
 node
> > > +        * according to the devicetree specification. Use same values=
 as default
> > > +        * values mentioned for #address-cells/#size-cells properties=
.
> >
> > Which default? We have multiple...
>
> I will reword:
>   Use values mentioned in the devicetree specification as default values
>   for #address-cells and #size-cells properties

My point was that "default" is meaningless because there are multiple
sources of what's default.

> >
> > There's also dtc's idea of default which IIRC is 2 and 1 like OpenFirmw=
are.
>
> I can re-add this part in the commit log:
>   The device tree compiler already uses 2 as default value for address ce=
lls
>   and 1 for size cells. The powerpc PROM code also use 2 as default value
>   for #address-cells and 1 for #size-cells. Modern implementation should
>   have the #address-cells and the #size-cells properties set and should
>   not rely on default values.
>
> In your opinion, does it make sense?
>
> >
> > > +        */
> > > +       #address-cells =3D <0x02>;
> > > +       #size-cells =3D <0x01>;
> >
> > I think we should just do 2 cells for size.
>
> Why using 2 for #size-cells?
>
> I understand that allows to have size defined on 64bits but is that neede=
d?
> How to justify this value here?

Most systems are 64-bit today. And *all* ACPI based systems are. Not
that the DT has to match 32 vs 64 bit CPU, most of the time it does.

It also doesn't actually change anything for you because you're going
to have "pci" nodes and the "ranges" there takes #size-cells from the
pci node, not the parent.

Rob

