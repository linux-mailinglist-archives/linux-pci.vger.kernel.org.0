Return-Path: <linux-pci+bounces-3647-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 955EC85877B
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 21:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DC8528AFBA
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 20:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522F812EBEA;
	Fri, 16 Feb 2024 20:51:31 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D697E104;
	Fri, 16 Feb 2024 20:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708116691; cv=none; b=DQk0/bvFt+k3Oa+FMTO2JXep1IwPqJCTOoZAcPU/nI6ll+OLa5o8QKOKwaRTqMhLf1ET22boS18mzcc8y7BKienXBhhvOaKGzTFMNg7dsqXI6V29g3/v6PGp7XFhxuTShYEIw+lBklvpFrKH/pU67dJzxpuT3aYUKmcHcZCCv8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708116691; c=relaxed/simple;
	bh=4JuZDsRRXL+wfYcQ0Z+9Quu+0CjQK1IWFJJenLEWVH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h1JLsTmua2WY5Bmep51V0q15Hxcns9bXOJLbFlcAgTd1venzHcTQnlIYRIzEqCj3iYpnoMAIsE1DFS6GtZGbTHmLChYhDcrwpqnMb6yW1LMTpbtf+eAGT0px38KXo0o+OSN5wO2WjVC98rbcv2eSaWjl0owq1QuLxrJLCv3VDr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-59584f41f1eso875355eaf.1;
        Fri, 16 Feb 2024 12:51:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708116688; x=1708721488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yOyIUEJRVmIRVaMa7fnpLyYEUKlpLUSieFgb1iam7y0=;
        b=GPo8zryPHNn5lxDK1Lqy0UtdC8ZvzD36KrlHZFTIFN/j0EmgF841jrd7AekNk67QyT
         MaCF5e0ODnsHHuky103/EYfdy4KJ88P8cbfUQnhfEsgH051ZNO/9lqyB6ZpWo03Ed3+m
         IV/JXXdKm7y4AiC1Tuz3o6z07jJwLQce25IRYMS9uVIhv5PIz+rtJ1uAP+xswrg2TYbk
         jrFLvSQHfbml1K+wovWrFtVDayxt90dIkvd4hzBbiurHGkc/pwnGEHQENSIHzWYJt8++
         CJ40hrRU/YgAzhpKpvphyddyuTm9gI0Z8P1OVGPlwj65YeMYj+8eEd2v8lH0eF9vzo6Z
         mdfw==
X-Forwarded-Encrypted: i=1; AJvYcCUjGIU76J/ar8+3ENqmpMm/8UgHEGRE7mIQQ0/Az9YW/eALYqItSa0UHFFitR9E9ZdhUilNtqbduHMHZgHTF9n+kB29QeD0/B1HtGmYEoDwxoLel+WT41H1Z51kFfasygblSoghNHJoDxAfdL2hCyWwwj/UzqkCewLJQhtPE19VAiQbDO8Wf3+Rnh4fgCbRDbWBx7EApeHoCrnhqtfGdg==
X-Gm-Message-State: AOJu0YyQDLZ0/UcTYEiN/SKEGhso6NMsgeBbDTpUrtyZJ6RfYwoQ5AVx
	wdSaVOSVfwT4U7svUMtJPApbLwcITmNorW5Z/pKK4N0FhJK8BF2jxVpt6BG4ShktHhpJhzOcq9e
	Az+unM6VdMfdnuxm+G4LYU2WM5ruUR6oC
X-Google-Smtp-Source: AGHT+IGl1Lhi+zkRka1k0bkOo5jc8tqjXNNfqKZTtjqWj+bkWHdkNO/1K+Spdo6X8medMtgAmK6dq8PdZoIC27EClio=
X-Received: by 2002:a05:6820:134d:b0:59f:881f:9318 with SMTP id
 b13-20020a056820134d00b0059f881f9318mr7425058oow.0.1708116688597; Fri, 16 Feb
 2024 12:51:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216184946.GA1349514@bhelgaas> <520eaafc-e723-49d4-8a6b-375fc64dd511@o2.pl>
In-Reply-To: <520eaafc-e723-49d4-8a6b-375fc64dd511@o2.pl>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 16 Feb 2024 21:51:15 +0100
Message-ID: <CAJZ5v0iVTAg+tmuVQJwN0pv77arUsF5fGF2CYaug7xgqiYC_vA@mail.gmail.com>
Subject: Re: [PATCH v4] acpi,pci: warn about duplicate IRQ routing entries
 returned from _PRT
To: =?UTF-8?Q?Mateusz_Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
Cc: Bjorn Helgaas <helgaas@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
	Len Brown <lenb@kernel.org>, Jean Delvare <jdelvare@suse.de>, Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 9:20=E2=80=AFPM Mateusz Jo=C5=84czyk <mat.jonczyk@o=
2.pl> wrote:
>
> W dniu 16.02.2024 o 19:49, Bjorn Helgaas pisze:
> > On Fri, Feb 16, 2024 at 07:26:06PM +0100, Rafael J. Wysocki wrote:
> >> On Tue, Dec 26, 2023 at 1:50=E2=80=AFPM Mateusz Jo=C5=84czyk <mat.jonc=
zyk@o2.pl> wrote:
> >>> On some platforms, the ACPI _PRT function returns duplicate interrupt
> >>> routing entries. Linux uses the first matching entry, but sometimes t=
he
> >>> second matching entry contains the correct interrupt vector.
> >>>
> >>> As a debugging aid, print a warning to dmesg if duplicate interrupt
> >>> routing entries are present. This way, we could check how many models
> >>> are affected.
> >>>
> >>> This happens on a Dell Latitude E6500 laptop with the i2c-i801 Intel
> >>> SMBus controller. This controller is nonfunctional unless its interru=
pt
> >>> usage is disabled (using the "disable_features=3D0x10" module paramet=
er).
> >>>
> >>> After investigation, it turned out that the driver was using an
> >>> incorrect interrupt vector: in lspci output for this device there was=
:
> >>>         Interrupt: pin B routed to IRQ 19
> >>> but after running i2cdetect (without using any i2c-i801 module
> >>> parameters) the following was logged to dmesg:
> >>>
> >>>         [...]
> >>>         i801_smbus 0000:00:1f.3: Timeout waiting for interrupt!
> >>>         i801_smbus 0000:00:1f.3: Transaction timeout
> >>>         i801_smbus 0000:00:1f.3: Timeout waiting for interrupt!
> >>>         i801_smbus 0000:00:1f.3: Transaction timeout
> >>>         irq 17: nobody cared (try booting with the "irqpoll" option)
> >>>
> >>> Existence of duplicate entries in a table returned by the _PRT method
> >>> was confirmed by disassembling the ACPI DSDT table.
> >>>
> >>> Windows XP is using IRQ3 (as reported by HWiNFO32 and in the Device
> >>> Manager), which is neither of the two vectors returned by _PRT.
> >>> As HWiNFO32 decoded contents of the SPD EEPROMs, the i2c-i801 device =
is
> >>> working under Windows. It appears that Windows has reconfigured the
> >>> chipset independently to use another interrupt vector for the device.
> >>> This is possible, according to the chipset datasheet [1], page 436 fo=
r
> >>> example (PIRQ[n]_ROUT=E2=80=94PIRQ[A,B,C,D] Routing Control Register)=
.
> >>>
> >>> [1] https://www.intel.com/content/dam/doc/datasheet/io-controller-hub=
-9-datasheet.pdf
> >>>
> >>> Signed-off-by: Mateusz Jo=C5=84czyk <mat.jonczyk@o2.pl>
> >>> Cc: Bjorn Helgaas <bhelgaas@google.com>
> >>> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> >>> Cc: Len Brown <lenb@kernel.org>
> >>> Cc: Borislav Petkov <bp@suse.de>
> >>> Cc: Jean Delvare <jdelvare@suse.de>
> >>> Previously-reviewed-by: Jean Delvare <jdelvare@suse.de>
> >>> Previously-tested-by: Jean Delvare <jdelvare@suse.de>
> >>>
> >>> ---
> >>> Hello,
> >>>
> >>> I'm resurrecting an older patch that was discussed back in January:
> >>>
> >>> https://lore.kernel.org/lkml/20230121153314.6109-1-mat.jonczyk@o2.pl/=
T/#u
> >>>
> >>> To consider: should we print a warning or an error in case of duplica=
te
> >>> entries? This may not be serious enough to disturb the user with an
> >>> error message at boot.
> >>>
> >>> I'm also looking into modifying the i2c-i801 driver to disable its us=
age
> >>> of interrupts if one did not fire.
> >>>
> >>> v2: - add a newline at the end of the kernel log message,
> >>>     - replace: "if (match =3D=3D NULL)" -> "if (!match)"
> >>>     - patch description tweaks.
> >>> v3: - fix C style issues pointed by Jean Delvare,
> >>>     - switch severity from warning to error.
> >>> v3 RESEND: retested on top of v6.2-rc4
> >>> v4: - rebase and retest on top of v6.7-rc7
> >>>     - switch severity back to warning,
> >>>     - change pr_err() to dev_warn() and simplify the code,
> >>>     - modify patch description (describe Windows behaviour etc.)
> >>> ---
> >>>  drivers/acpi/pci_irq.c | 25 ++++++++++++++++++++++---
> >>>  1 file changed, 22 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
> >>> index ff30ceca2203..1fcf72e335b0 100644
> >>> --- a/drivers/acpi/pci_irq.c
> >>> +++ b/drivers/acpi/pci_irq.c
> >>> @@ -203,6 +203,8 @@ static int acpi_pci_irq_find_prt_entry(struct pci=
_dev *dev,
> >>>         struct acpi_buffer buffer =3D { ACPI_ALLOCATE_BUFFER, NULL };
> >>>         struct acpi_pci_routing_table *entry;
> >>>         acpi_handle handle =3D NULL;
> >>> +       struct acpi_prt_entry *match =3D NULL;
> >>> +       const char *match_int_source =3D NULL;
> >>>
> >>>         if (dev->bus->bridge)
> >>>                 handle =3D ACPI_HANDLE(dev->bus->bridge);
> >>> @@ -219,13 +221,30 @@ static int acpi_pci_irq_find_prt_entry(struct p=
ci_dev *dev,
> >>>
> >>>         entry =3D buffer.pointer;
> >>>         while (entry && (entry->length > 0)) {
> >>> -               if (!acpi_pci_irq_check_entry(handle, dev, pin,
> >>> -                                                entry, entry_ptr))
> >>> -                       break;
> >>> +               struct acpi_prt_entry *curr;
> >>> +
> >>> +               if (!acpi_pci_irq_check_entry(handle, dev, pin, entry=
, &curr)) {
> >>> +                       if (!match) {
> >>> +                               match =3D curr;
> >>> +                               match_int_source =3D entry->source;
> >>> +                        } else {
> >>> +                               dev_warn(&dev->dev, FW_BUG
> >> dev_info() would be sufficient here IMV.
> >>
> >>> +                                      "ACPI _PRT returned duplicate =
IRQ routing entries for INT%c: %s[%d] and %s[%d]\n",
> >>> +                                      pin_name(curr->pin),
> >>> +                                      match_int_source, match->index=
,
> >>> +                                      entry->source, curr->index);
> >>> +                               /* We use the first matching entry no=
netheless,
> >>> +                                * for compatibility with older kerne=
ls.
> > The usual comment style in this file is:
> >
> >   /*
> >    * We use ...
> >    */
> >
> >>> +                                */
> >>> +                       }
> >>> +               }
> >>> +
> >>>                 entry =3D (struct acpi_pci_routing_table *)
> >>>                     ((unsigned long)entry + entry->length);
> >>>         }
> >>>
> >>> +       *entry_ptr =3D match;
> >>> +
> >>>         kfree(buffer.pointer);
> >>>         return 0;
> >>>  }
> >>>
> >>> base-commit: 861deac3b092f37b2c5e6871732f3e11486f7082
> >>> --
> >> Bjorn, any concerns regarding this one?
> > No concerns from me.
> >
> > I guess this only adds a message, right?  It doesn't actually fix
> > anything or change any behavior?
> Exactly.
> > This talks about "duplicate" entries, which suggests to me that they
> > are identical, but I don't think they are.  It sounds like it's two
> > "matching" entries, i.e., two entries for the same (device, pin)?
>
> Right.
>
> > And neither of the two _PRT entries yields a working i801 device?
>
> Unpatched Linux uses the first matching entry, but the second one gives
> a working i801 device. The point is to print a warning message to see
> how many devices are affected and whether it is safe to switch the code
> to use the last matching entry in all instances.
>
> Therefore I used dev_warn().

I don't quite see a connection between the above and the log level.

