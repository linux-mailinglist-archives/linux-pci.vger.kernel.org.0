Return-Path: <linux-pci+bounces-37661-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2E2BC0FF9
	for <lists+linux-pci@lfdr.de>; Tue, 07 Oct 2025 12:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9F7FB4EA0AB
	for <lists+linux-pci@lfdr.de>; Tue,  7 Oct 2025 10:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F492D7DEB;
	Tue,  7 Oct 2025 10:22:40 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC71439ACF
	for <linux-pci@vger.kernel.org>; Tue,  7 Oct 2025 10:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759832559; cv=none; b=radCvIos/QHCSEa6UvLXCY8IO3g4aOvOADnVRCGgKQGpjAG2jEJL9kVT8HD7+NGhI5ga+9oBBVaEFHntnFgoiwODt+J52R3iIhu/hslcyGqcH9ktIkU8CwnmP1TjDJUX8HOiGhteylCE4zYhU+OOwH4Ne4ECbiNWOiaOFBBNLcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759832559; c=relaxed/simple;
	bh=X08yRMXxYQpEQFN6+DWg0rBxqMjXg4JwaZTEUg+jC/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O2rLbKk9gd0xvpPkZ7Bwxfw7lfNwnEcxsyndKouZkHEAEt+p8M8PCivUOmBJ0POxrXu1Us9mXk7sEtG9VSseF4XwgCs3voCl5Gd9k1tP4Gc4P1DEVseqNzSy6zV78+8KUA2ZT8m8UVozYYqw/UaxdcSbEi50WKdbIG276ZplJpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-54bd3158f7bso4585725e0c.0
        for <linux-pci@vger.kernel.org>; Tue, 07 Oct 2025 03:22:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759832557; x=1760437357;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0UyUj3Qix+qDVReFl/Sm439a80dBofMDi/9/TOImgQQ=;
        b=C4QIBFgm0xVzboGiweQ0sJLX60JPUO+kZFsfPZhvEh6FthML67i7QhqhdDdMQnmZec
         oNXn8lUATFLo8KD5UoA8zV/xmWfDA9hGRoUNSc7R0G618zYl7AeWA9lp9KNf3wWz69LA
         6I8ceFPTI4vZqasTIrwMgxr6NQ2nIvd0/bpT6lrzjuS4K+BfXajgBce2EtW0PVV8qI7n
         56W4KHVWkSwTF39dEBhjk53Wqfib6qMdAlXSAckd6Yj6Fu+5/kRMN7+nRyGKPlR1fVF0
         8d+Snor17WjJeOvFNAM01VjdjtRIDdkimBmZvytjLG8nw877Xs1WpHfFEk+Vz8qRrnOW
         1VyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVT6GTOw0L+vn+wpm1CzO8+US1W+PsHmJ6Pipd9aGkh6fMYaxV2Y5K/BnwzMHG7XVsD02C1BJUdjDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuOnA5ZQqVgVblo2paiOeKvABl8MUIgDvB2jMxfeW+RpTvTuU0
	eux389w+/yp0uA3ZmGHx/rm4GuJaRvo2S1I1TDtZqFDvLji2oHhpEYLKnKGM8Aby
X-Gm-Gg: ASbGnctSPvtu3ZYrEnm+e2v/4H6xAh2alIlpn0O6LIZZRJsXa4V1R2z5j4Wlzv9Xbxs
	Yj1phhGNR0sr2HQGEC1lE8cauAdVqiQuBNBcfZrVj3gO7FD2HdRUhd7o/msnMaNzL+Qn2Fjr5kJ
	ehfasBrJBOsEXvwebhw2NoSKEafXh7AGVXY6/Nom1t5Q/4Wh75mAflAqhEjJQxyUfF/bXxkTW4t
	GAu3yEccEXmYDBoyCm9eHKztOBD4A9vr+qIe27zo8JNNR1gUEVfth1hvT9rSH8LgBibALRe6d2I
	wqbMTsv8b8kroWJljD+90FEMbKHGKayFaIzZzFjk0UXJut6k88hk4Unsnj9MerXVLsOIfsdWXYA
	uGwURH5T5ExiH7R6XOybo7ejCAryH4oUJfpshIZqF7a8HfZYLxehLCs1cgrFoqtPDzpGEmaMZYm
	TTbP+XQj+9KfQAedHZKFr1wek=
X-Google-Smtp-Source: AGHT+IFEskHbv6Up877/bTKJvsSCE0umNdOqevE9E5K8BFXpqkD+ZiLHnHFCHEPLt0a7QAQJ/x0ZSA==
X-Received: by 2002:a05:6122:8293:b0:540:68c4:81a2 with SMTP id 71dfb90a1353d-5524ea9e945mr6374845e0c.14.1759832556440;
        Tue, 07 Oct 2025 03:22:36 -0700 (PDT)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com. [209.85.221.180])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5523ce202c6sm3649101e0c.5.2025.10.07.03.22.36
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 03:22:36 -0700 (PDT)
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5523142df73so4356146e0c.1
        for <linux-pci@vger.kernel.org>; Tue, 07 Oct 2025 03:22:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXUn6sPjAZ7U1HP4wZOzjgO2ToDPPuqup/1B94t/+gn3idToc4uwP/EMltnDy3JYmlWsKfIy5s4OSM=@vger.kernel.org
X-Received: by 2002:a05:6122:1e0d:b0:543:e262:ade2 with SMTP id
 71dfb90a1353d-5524ea6b0e4mr5683075e0c.12.1759832556074; Tue, 07 Oct 2025
 03:22:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007092313.755856-1-daniel@thingy.jp> <20251007092313.755856-4-daniel@thingy.jp>
 <CAMuHMdWDfNgUUh-uU7ZFKmmAccEMqDdfDpwRXQYmwjMG6O_Trg@mail.gmail.com> <46382bc6cab2196a79780a946bee96dde402ae31.camel@physik.fu-berlin.de>
In-Reply-To: <46382bc6cab2196a79780a946bee96dde402ae31.camel@physik.fu-berlin.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 7 Oct 2025 12:22:25 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUUAEoN+KBnk=aY6UnkxXnFp8KY0BV8qQGfGip=nNtfaQ@mail.gmail.com>
X-Gm-Features: AS18NWAPkggXOuJ8Zyug-B_6vXxzZFwJxIAhU-W5_YEhuf5bM649C2kMw_p5v_Y
Message-ID: <CAMuHMdUUAEoN+KBnk=aY6UnkxXnFp8KY0BV8qQGfGip=nNtfaQ@mail.gmail.com>
Subject: Re: [RFC PATCH 3/5] m68k: amiga: Allow PCI
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Daniel Palmer <daniel@thingy.jp>, linux-m68k@lists.linux-m68k.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Adrian,

On Tue, 7 Oct 2025 at 11:41, John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On Tue, 2025-10-07 at 11:37 +0200, Geert Uytterhoeven wrote:
> > On Tue, 7 Oct 2025 at 11:33, Daniel Palmer <daniel@thingy.jp> wrote:
> > > The Amiga has various options for adding a PCI bus so select HAVE_PCI.
> > >
> > > Signed-off-by: Daniel Palmer <daniel@thingy.jp>
> >
> > Thanks for your patch!
> >
> > > --- a/arch/m68k/Kconfig.machine
> > > +++ b/arch/m68k/Kconfig.machine
> > > @@ -7,6 +7,7 @@ config AMIGA
> > >         bool "Amiga support"
> > >         depends on MMU
> > >         select LEGACY_TIMER_TICK
> > > +       select HAVE_PCI
> > >         help
> > >           This option enables support for the Amiga series of computers. If
> > >           you plan to use this kernel on an Amiga, say Y here and browse the
> >
> > This doesn't make much sense without upstream support for actual
> > PCI host bridge controllers.
>
> Isn't this what patch 5 does?

Oops, sorry, I hadn't realized this is part of a series, as I somehow
haven't received the other patches from the series yet...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

