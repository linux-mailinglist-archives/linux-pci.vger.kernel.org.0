Return-Path: <linux-pci+bounces-38962-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F95BFA813
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 09:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADB70188EDAB
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 07:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3392F5A27;
	Wed, 22 Oct 2025 07:20:10 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA082ED84A
	for <linux-pci@vger.kernel.org>; Wed, 22 Oct 2025 07:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761117610; cv=none; b=Wed+0c9Z9bGVnwS9N+CrsDHjaYjoVXanMIq0hCX02Fg0gT691bENqGPWzM2MbmddOT/ZPSHnhj8otUrn0gfSCKEtTfWTnT1EjIWe3n6Yw2OBL2s7gy+F4OM7ZrX3VeN6Z8JiADmu5ncyXrcIhoNPKgym7Ug7vU//Uzi+Z5fqt8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761117610; c=relaxed/simple;
	bh=oj2g+iXtUrFUuNWS7IxNGMMhQzbaj0lpzDuF73afwdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cLBQe/kycZg5FqYyaPTQHXZ0b7tEkSNlkIXZ3N3zZPEGOajTZcYCakKnom3cLKzYd5Gam16aChW4/gyOoFhhhIvBbC0npNuH3logHjqvR9gj/9+4lxIPb1F7Bmd7r5klIXV5UjNH4CF2bX+2B9hUsPG3mnxNKq6PHoYO/msctkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-5d6266f1a33so2900933137.3
        for <linux-pci@vger.kernel.org>; Wed, 22 Oct 2025 00:20:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761117607; x=1761722407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LB4UmnebrIV6VHjidh9rexno3FG0/9sLJFVzFv+0Cqk=;
        b=w7hYy5UwoAtk1F86oAERzQ0ApdYL/46K1IUvPW4RIJDSsqiSl1Y+BwNMdpbprROkhy
         qNvgj39evmW8hb0BkWAC3iydZ14U2YCr5e/U633/pK+PInTdt3QNc3zTwrlRO4PTO2DE
         Ktw8VlU5kfWk1wZQxvriGncldl4sCo8mNYlHL+BOfPmRFe0L1dgRpAZR0BEK4J8iBi9b
         61PkogwyRU5LhZE1+g1U6QJqL33NOX8wQ/Y23cTH33jg7BAhfCgIj6w8walyN77HqE0z
         qDikXbPHFrfZSmttDYpf5AycUOF3kCFV9RPwKkH3bH5ekjlB6ZtJMGKJsVoDlfoFp9CN
         jY9g==
X-Forwarded-Encrypted: i=1; AJvYcCU8yRTTWbrdV8ScV+pKrX+vITB8Y85F6eCQgjWqv+QATjRs5dTgwcD6OBcQtG39X8HYpIKgmpj00Y0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCv8GD/YsD8hmfys9BX3jynnDbjqOwnGmKzLabZ7jAQi4ze4BK
	ktzh8fE1UtPsYb8mFz6j1uOpZiUiN8BGW7K+cPG3Yw331L26RRDB8R71QQBcVs28
X-Gm-Gg: ASbGnctPsNQlktZ2BBc20s4KrZ9X9vmJCmC5FvchzsQ4TJqa10Pk6L5IR3/Lm34m5nh
	/WSo6Fs/4j6uMTJT8oyZDaUS53DYRFSOVgUkSHMY/mbfrrc58400bGjmi/WFsuBdyXjFFsGT3ZQ
	oXfHoEXAnT2WTUyyKYYpwxdmFRNIu57n3j6lRF8b+4FHvSfciAAm8fm8DPz+Fu2mWrvtrX9jCl9
	I9BbELL4/wIvf5Y1PscgL1cewI6Jsg+PoTNea5i4fOSmPgszb1Qaw/spWzX+j4/ho6RgXwKUMqG
	kWrYRipuzV8X03fl70Ak/wrOIKFHMp/pDWikq3NErkwUNWA0NSfVPsXKuBYYIlWxC33ZAumRwSy
	SWnkf1DdFv2ray8+oIAjwAlQNBfydsLqLBBNwkYA1pVjFOQyo9KLyIXCzYjDD+UXQ402osLVPP9
	m44aqwTQhT5m76hbiZLxyi4iT9sycsEu4yydj7EA==
X-Google-Smtp-Source: AGHT+IEn4+bqQJRI/3kkaDWa6bfuTKYoHMTOL2sR7P8ZZB9GSP/A0w93qNgzcuONcrMgZJ2wbNG5Rw==
X-Received: by 2002:a05:6102:291e:b0:5d6:6ce:9675 with SMTP id ada2fe7eead31-5d7dd6bb0d8mr5272548137.40.1761117606191;
        Wed, 22 Oct 2025 00:20:06 -0700 (PDT)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-932c3e4794fsm4223743241.14.2025.10.22.00.20.05
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 00:20:06 -0700 (PDT)
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-90f6d66e96dso1674475241.0
        for <linux-pci@vger.kernel.org>; Wed, 22 Oct 2025 00:20:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUvSXE0NxFCA3TDxX20sXnbpwTXEHSL6jpwuzQVBtBqck5PIz8ypHxmrBOP7J0UeSBgGuvYO3KPBbU=@vger.kernel.org
X-Received: by 2002:a05:6102:419f:b0:5d5:ff0f:aea1 with SMTP id
 ada2fe7eead31-5d7dd634d15mr5387817137.22.1761117605738; Wed, 22 Oct 2025
 00:20:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010144231.15773-1-ilpo.jarvinen@linux.intel.com>
 <CAMuHMdVwAkC0XOU_SZ0HeH0+oT-j5SvKyRcFcJbbes624Yu9uQ@mail.gmail.com>
 <89a20c14-dd0f-22ae-d998-da511a94664a@linux.intel.com> <CAMuHMdUbseFEY8AGOxm2T8W-64qT9OSvfmvu+hyTJUT+WE2cVw@mail.gmail.com>
 <20844374-d3df-cc39-a265-44a3008a3bcb@linux.intel.com> <aPerdPErjXANiBOl@smile.fi.intel.com>
In-Reply-To: <aPerdPErjXANiBOl@smile.fi.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 22 Oct 2025 09:19:54 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWjty_fzRp9r8bet7G_YTwAvGRdW73-uxn7Dp8WsFmEEQ@mail.gmail.com>
X-Gm-Features: AS18NWBTgmWnrLRZQpcXx7nybYEdoprYZTPpfACzWUOBzMWL72E1MPEt5nuaQyU
Message-ID: <CAMuHMdWjty_fzRp9r8bet7G_YTwAvGRdW73-uxn7Dp8WsFmEEQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] PCI & resource: Make coalescing host bridge windows safer
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Kai-Heng Feng <kaihengf@nvidia.com>, Rob Herring <robh@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Tue, 21 Oct 2025 at 17:49, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Tue, Oct 21, 2025 at 02:54:03PM +0300, Ilpo J=C3=A4rvinen wrote:
> > The expected result is that those usb resources are properly parented a=
nd
> > the ee080000-ee08ffff and ee090000-ee090bff are not coalesced together =
(as
> > that would destroy information). So something along the lines of:
> >
> >     ee080000-ee08ffff : pci@ee090000
>
> For my pedantic eye, the naming is a bit confusing here. Is this a mistak=
e in
> the code or in the example?
>
> >       ee080000-ee080fff : 0000:00:01.0
> >         ee080000-ee080fff : ohci_hcd
> >       ee081000-ee0810ff : 0000:00:02.0
> >         ee081000-ee0810ff : ehci_hcd
> >     ee090000-ee090bff : ee090000.pci pci@ee090000

A platform device instantiated from DT is named after the node name
and unit address of the corresponding DT node.  If the device has
multiple register banks, all its register banks are still claimed by
the same device, so all but the first (in DT) register bank show a
non-matching address in the device name.

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

