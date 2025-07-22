Return-Path: <linux-pci+bounces-32708-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 202DFB0D641
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 11:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB0191C269FE
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 09:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D597223E226;
	Tue, 22 Jul 2025 09:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uY3jpVhI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A385523C50E;
	Tue, 22 Jul 2025 09:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753177701; cv=none; b=A2exwGr6o3S5CJQF5boUPL3t/0LR30lIpp3VHrak4EiWa4pSq8UYFKZoMiabKtf7jurlIInKlOrd5s3P3MlWTL/0lCsYwdyoWRPml63fL9h2aHux59lweXm4pTaLvxnMYx4XrHvAtzI0UCww98Hh8/BLdg0fNPNpd/g9P8n9rUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753177701; c=relaxed/simple;
	bh=/fkjRHbtz6L40UsKyBjKVzJsr6GgvV345DTaJqD2qqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IFnKHMjc5ddNyzQEmEqhhyoapxFaMnA7U4Y87uwJSdgBNfo5BUDIWTUoj0VagGnEOt++MLSivc1Q4LHnXO3fV3HPF2VmwKZRgzIH+hMzUsRrMNa2qziraIx5Fyp1OulGFrkNmPN3pTy/AiV4J7yINNWIAztUD0TxA6gFpywY/gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uY3jpVhI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D80FC4CEF5;
	Tue, 22 Jul 2025 09:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753177701;
	bh=/fkjRHbtz6L40UsKyBjKVzJsr6GgvV345DTaJqD2qqw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uY3jpVhIrJXrnJoyRCM8Kz2D0ikZfV4UaKvE/s46ETcnW2xM2RH5rsH8+p48fg62n
	 DV8wmvTmHkUzx1fCy3HqiosXk9ZXn4bG7y40hh5jLWNMF6jzx4g42KmtN7a9uKBlcs
	 DnnNnMT+MEwE282k60g5dW6QNwypY/myaHwjZhyUgLOCkUVNkx8EiSWJWpTMqlUe4p
	 BLU8CthLpRmFfyVndjD81unqnPDKaxlETV1P5NW51h7k3TmRmp5HliIUrMJ48y4atG
	 zMB+tiBaj8tBwNXgc9N7sTsaBeu7jJlqg3CCBfj5cdqlGr7JEC8SMqzBKpj9ZlwHSi
	 6wLSTNEOwDsiA==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-613b02e801aso3053827eaf.2;
        Tue, 22 Jul 2025 02:48:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWQQdZDRHwqnx2keYzaX8N8Nk3hgW+OIQAz77YYvRz3ABy/y+a9/+zBZYcskytWn8rRb7c9ycEdX9GfAPrY@vger.kernel.org, AJvYcCWv1L1+tTtY6fKCEqAo7HzOGC70GRUYr/Yem37gzUlJmuKWc9m0LHLRmaYwVMpys2TcIwNHQayQnOlUbCQSMFk=@vger.kernel.org, AJvYcCX0c9xSb42bz1AU49BLiu8nQsXd+ECC/MtIYq7sZbKjYdxXWJ86/xVXV3nJkRso28FljIDqDeU9ERtZ@vger.kernel.org, AJvYcCXhnMhFIyiWvQHrMsronmsqEvBopTjv6A3xOYdlt/zMpv7EO0F64BAzq8ucyElWmx7GkqhtuliKUczNpw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxqMNZYldIkh6Bqo4gWz/jiHrCO3MHYoPPDoI/mtHbUrPJXljyi
	A4RFUPPzEU9sEbC6DwG/RqCJB678SHVmovh2vS0aDM/Z5GfqccWDFkkrGo30mRrpo/UMDaN5R40
	Auh5q89dkzHuCivnvtgKlALwyLewld1k=
X-Google-Smtp-Source: AGHT+IEfTTSEyAOWYu++w5ruAiPqSTMP5i2OLym7qvAO9o3zZKs/j+u5M18LziWEI2JeDHbEZLYaFm+Dh+IghvOJRP4=
X-Received: by 2002:a05:6820:8186:b0:615:ca49:388f with SMTP id
 006d021491bc7-615ca493bf4mr8078409eaf.4.1753177700484; Tue, 22 Jul 2025
 02:48:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721145952.2601422-1-colin.i.king@gmail.com> <20250721214004.GA2756360@bhelgaas>
In-Reply-To: <20250721214004.GA2756360@bhelgaas>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 22 Jul 2025 11:48:07 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gT1X9zuoAfxGS5XP0s1TD1tyP2shbC_cbiRJPjDg4=jA@mail.gmail.com>
X-Gm-Features: Ac12FXyrTfRVdkTJQlvj2cygHb3kv9Y5PxK2A1xgwD3hpMohtoUsDBnOxKEKga0
Message-ID: <CAJZ5v0gT1X9zuoAfxGS5XP0s1TD1tyP2shbC_cbiRJPjDg4=jA@mail.gmail.com>
Subject: Re: [PATCH][next] ACPI: pci_link: Remove space before \n newline
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Colin Ian King <colin.i.king@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org, 
	linux-acpi@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 11:40=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org>=
 wrote:
>
> On Mon, Jul 21, 2025 at 03:59:52PM +0100, Colin Ian King wrote:
> > There is an extraneous space before a newline in an acpi_handle_debug
> > message.  Remove it.
> >
> > Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
>
> FWIW,
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>
> Fixes for more ACPI-related typos below, feel free to squash or I can
> send separately.

If I can assume your sign-off on this, no need to resend.

> > ---
> >  drivers/acpi/pci_link.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
> > index 08e10b6226dc..e4560b33b8ad 100644
> > --- a/drivers/acpi/pci_link.c
> > +++ b/drivers/acpi/pci_link.c
> > @@ -268,7 +268,7 @@ static int acpi_pci_link_get_current(struct acpi_pc=
i_link *link)
> >
> >       link->irq.active =3D irq;
> >
> > -     acpi_handle_debug(handle, "Link at IRQ %d \n", link->irq.active);
> > +     acpi_handle_debug(handle, "Link at IRQ %d\n", link->irq.active);
> >
> >        end:
> >       return result;
>
> diff --git a/Documentation/ABI/testing/sysfs-firmware-acpi b/Documentatio=
n/ABI/testing/sysfs-firmware-acpi
> index f4de60c4134d..72e7c9161ce7 100644
> --- a/Documentation/ABI/testing/sysfs-firmware-acpi
> +++ b/Documentation/ABI/testing/sysfs-firmware-acpi
> @@ -108,15 +108,15 @@ Description:
>                 number of a "General Purpose Events" (GPE).
>
>                 A GPE vectors to a specified handler in AML, which
> -               can do a anything the BIOS writer wants from
> +               can do anything the BIOS writer wants from
>                 OS context.  GPE 0x12, for example, would vector
>                 to a level or edge handler called _L12 or _E12.
>                 The handler may do its business and return.
> -               Or the handler may send send a Notify event
> +               Or the handler may send a Notify event
>                 to a Linux device driver registered on an ACPI device,
>                 such as a battery, or a processor.
>
> -               To figure out where all the SCI's are coming from,
> +               To figure out where all the SCIs are coming from,
>                 /sys/firmware/acpi/interrupts contains a file listing
>                 every possible source, and the count of how many
>                 times it has triggered::
> diff --git a/Documentation/firmware-guide/acpi/gpio-properties.rst b/Docu=
mentation/firmware-guide/acpi/gpio-properties.rst
> index db0c0b1f3700..1e603189b5b1 100644
> --- a/Documentation/firmware-guide/acpi/gpio-properties.rst
> +++ b/Documentation/firmware-guide/acpi/gpio-properties.rst
> @@ -92,8 +92,8 @@ and polarity settings. The table below shows the expect=
ations:
>  |             | Low         | as low, assuming active                   =
    |
>  +-------------+-------------+-------------------------------------------=
----+
>
> -That said, for our above example the both GPIOs, since the bias setting
> -is explicit and _DSD is present, will be treated as active with a high
> +That said, for our above example, since the bias setting is explicit and
> +_DSD is present, both GPIOs will be treated as active with a high
>  polarity and Linux will configure the pins in this state until a driver
>  reprograms them differently.
>
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index c2ab2783303f..a984ccd4a2a0 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -1406,7 +1406,7 @@ static int __init acpi_bus_init(void)
>                 goto error1;
>
>         /*
> -        * Register the for all standard device notifications.
> +        * Register for all standard device notifications.
>          */
>         status =3D
>             acpi_install_notify_handler(ACPI_ROOT_OBJECT, ACPI_SYSTEM_NOT=
IFY,

