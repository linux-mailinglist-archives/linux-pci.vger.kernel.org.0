Return-Path: <linux-pci+bounces-32741-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCDCB0E05B
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 17:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD00F56673D
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 15:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAF7264F9C;
	Tue, 22 Jul 2025 15:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eeG5DhrR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAA4264624;
	Tue, 22 Jul 2025 15:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753197703; cv=none; b=a2z87ZotPSY2NUFORMPXTLGJCdRsjfaSYwgIWRGoq7tb7+Dk/dzniCFcGfm8itDvxKOyY0PawHGreszgsor8+d3FG9yg4VcV7eJI+zVj82XEJn5hsXYNCLNqFIAw7dkTp2nXTM5s6G8gYE/0dMBbWI3OFW+EB1lIsLi1D8XxT00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753197703; c=relaxed/simple;
	bh=m44ns21mhY9BtTjcpzHR2Kh6jHFyP297cR6MfBbYG+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HKSNUYs0RqiqZqZt9j2ZiZI1HdS4XDE8q65puxTaU+hz8BQINinEl3CCd96zIYCKolbuft8EdKa8E/vR0/ff7H2kH+6ByBHLTbw9xuTrFyT/mpiecWJvJAC8UYDVyTQzqloriP6zyTVOw627YdlC41jrdzRHiK3Mqy3ZhLzqRW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eeG5DhrR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5B59C4CEF1;
	Tue, 22 Jul 2025 15:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753197702;
	bh=m44ns21mhY9BtTjcpzHR2Kh6jHFyP297cR6MfBbYG+M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eeG5DhrRgUfgsN29snldAldrEiAUG9MTy8DKlJpFvBvaTBYIirXiYRHpQTsoMka/v
	 plY9KwBy8GABOOQGEz5Q7VCtE/AGW5bBzyULhxVXQUGMOIonYPbbSBoNu721aCcbOm
	 gNY285jGRSD317hl9efgDsO6rf0vixaURI9lMKKDbOAkX2mE6T5XQCV6ij/61u9Bcm
	 FERzxAvrLC2IiNZLku5/eNpGgMVJBaIbBhK8uirv3OIzlU8O1xEAZkRXebX6yDsYtW
	 gSe49KsiRJTOlqA2Cd6y1cdKCG15wmbSnlVZXkCajcm8Tpsd9TdMKbTwI33uzKjWaC
	 gBg0Lw6YucCHw==
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-73e88bc3891so2257497a34.0;
        Tue, 22 Jul 2025 08:21:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU10oWk47ToOmtEBRva3g00lnQLj9ABrpPVh0wA+nqqsQyu58wUT4NV+IHHnBu2kPa3WF/HsHCmBdk3f+Fz@vger.kernel.org, AJvYcCUaDMm7jrpDGS6tuv97SlY9MlP9egm2VU06T7O0+1r3OeF0WuAZP3nPovitjZ+oHCQTAuRzm0L5IsOEew==@vger.kernel.org, AJvYcCV/RMBy/jk2GVb/57XlqNMQaTZ5SusnuR4xKMDt03j3bnCkh00wfEEo1vO5xjqURiqSiix5fqQa2h6K@vger.kernel.org, AJvYcCWeuWWlCVe6w8Vtl66+g0MSelYEpQ4flVMiYs75rB/cui0Rg9jmg3ob0FMXryBSXG5TxG+aV8hAM4nQFzQenqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKJLx3TZYnUCKr6YzrrKGpCV0GKTnivbE77UTl0e6k/NNg9UTl
	u3PwnoaLBECc+XGA3GVdeXjnF2n80viZQEralpfHXeVS2/PPV9mfKmA9WPT/lPOYodVhR4nKIhL
	rB8m7el4JPLc7yQOAym4kCrqcctHAeBk=
X-Google-Smtp-Source: AGHT+IEbZT8JFWTOdt00cUuAJNhaNf9vKHSuY3oJ+ccENE6fSxI5Raz3IPM938XcVY3uDnmTfx8EbN1hwIOMO/ClS4U=
X-Received: by 2002:a05:6808:2388:b0:40a:d1ec:703c with SMTP id
 5614622812f47-41e468a6e78mr13933575b6e.23.1753197701979; Tue, 22 Jul 2025
 08:21:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0gT1X9zuoAfxGS5XP0s1TD1tyP2shbC_cbiRJPjDg4=jA@mail.gmail.com>
 <20250722132653.GA2781885@bhelgaas>
In-Reply-To: <20250722132653.GA2781885@bhelgaas>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 22 Jul 2025 17:21:30 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gswpUCiE1HRn8Eb+5WO4P_Hh6NMOi4pMQaBx7YGBvsbw@mail.gmail.com>
X-Gm-Features: Ac12FXzzlcqZbiR6H0ftX3mOMnEHJktuJKE_juIzLr2IypuNoUFp1Oe2bf9r79Q
Message-ID: <CAJZ5v0gswpUCiE1HRn8Eb+5WO4P_Hh6NMOi4pMQaBx7YGBvsbw@mail.gmail.com>
Subject: Re: [PATCH][next] ACPI: pci_link: Remove space before \n newline
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Colin Ian King <colin.i.king@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org, 
	linux-acpi@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 3:26=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Tue, Jul 22, 2025 at 11:48:07AM +0200, Rafael J. Wysocki wrote:
> > On Mon, Jul 21, 2025 at 11:40=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.=
org> wrote:
> > ...
> > >
> > > Fixes for more ACPI-related typos below, feel free to squash or I can
> > > send separately.
> >
> > If I can assume your sign-off on this, no need to resend.
>
> Of course, sorry, my fault:

No worries.

> commit 9cdbf361a40d ("ACPI: Fix typos")
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Mon Jul 21 16:37:14 2025 -0500
>
>     ACPI: Fix typos
>
>     Fix typos in documentation and comments.
>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>
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

Applied, thanks!

