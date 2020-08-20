Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3DE824C222
	for <lists+linux-pci@lfdr.de>; Thu, 20 Aug 2020 17:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbgHTPYr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Aug 2020 11:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728488AbgHTPYn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Aug 2020 11:24:43 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF03C061386
        for <linux-pci@vger.kernel.org>; Thu, 20 Aug 2020 08:24:42 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id a65so1747564otc.8
        for <linux-pci@vger.kernel.org>; Thu, 20 Aug 2020 08:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/gFfZIvWRZ4wg4R/uBBAuZhKNYjvYxxfxHZSYVxIT+Q=;
        b=QT6mSW+Jn8IOX6L4osdroRSC5BZInGyhbEx/g8kE7d9yyhODCp+9Q2hmSjS47By6XX
         KQVwtChOySNvSJCdQ/o6Dj+2NPYS2WmSLGsHnIfgA5TYlPFL+zYXJc31maYK/uiz+soR
         tnLx2iR5RsQBpnrzAzpIHMUY5iWHi849WT3NQfM63n4BYFdJCuj0OpjlSwLxfyzcsLNu
         ZuGqZIZ75TTpoQvBSbPbCMt3ldbA6Kq3UZfZCTVcdhG3+D3KOdX3LrtdZM5ELN+4uRV0
         oMQ56H35xZoXUDPWMRPms/prbldwAQEA5hgmAG0n5wZg41Re6bMqd2eLJxh2dErw6/ka
         2vnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/gFfZIvWRZ4wg4R/uBBAuZhKNYjvYxxfxHZSYVxIT+Q=;
        b=JZfng0Jw0GaqyobDL8Li60CJtUXyS2Sttmlq0l3HVPghqzcCyfMk2ZOgtErmf4uY5k
         RXIhUXWMpl445f5870aVWzK7dwfoK1kB0d/lhyejdmbNZOlHhKku/TpMCSWBGmH0/flY
         +LwiT5bMZI5bq+cSKXrZ2LIWTXa0XX+O7rbCWc6FxAejzHHxFFpoiqSddzQJCo0W26+s
         Z3hIekiJCu3TGaAyOhuO0PBa9YvwRYQl0cV/rUI/JPRmTyvd/17lGnxUUt9FiflLunUi
         /K7+DPfG92JeOvJvk2az0mIBBWxKIkyHyyOYRtiwzhtPB+OlA7/Hi6Y6PoxPHY7n1QJ/
         HCuw==
X-Gm-Message-State: AOAM530QCf8ah3e5QkgLpiEARxRbkUINnyKD5OXJhK50DKi/GlyeaTXN
        8onbnfEWjEUcQg1K/N7gYEzsdpsu/t/KeffXQBoP2A==
X-Google-Smtp-Source: ABdhPJwh8kb5Z50Vf5lSdANxMDzBzkJTMkmz+R8SwNsqzMM0RY19OYAksQesFFwBCai3OIQWl/QOmwdqcrz0afkW7pM=
X-Received: by 2002:a9d:7f8e:: with SMTP id t14mr2620491otp.63.1597937081310;
 Thu, 20 Aug 2020 08:24:41 -0700 (PDT)
MIME-Version: 1.0
References: <20952e3e-6b06-11e4-aff7-07dfbdc5ee18@infradead.org>
 <810f1b0e-0adf-c316-f23c-172338f9ef0a@linux.intel.com> <CAHp75VcJCjJJvbkSiGHC+3_shWRwoqeZHE2KNDLQBjneW=02dg@mail.gmail.com>
 <2b14b6be-a031-a28b-6585-8307d2fdae21@infradead.org>
In-Reply-To: <2b14b6be-a031-a28b-6585-8307d2fdae21@infradead.org>
From:   Jesse Barnes <jsbarnes@google.com>
Date:   Thu, 20 Aug 2020 08:24:30 -0700
Message-ID: <CAJmaN=khV6By1e8LnkbK+mgFweqnmXcu6hhjDzyD1uiFASC2Rg@mail.gmail.com>
Subject: Re: [PATCH] x86/pci: fix intel_mid_pci.c build error when ACPI is not enabled
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Len Brown <lenb@kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 19, 2020 at 9:08 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 8/13/20 1:55 PM, Andy Shevchenko wrote:
> > On Thu, Aug 13, 2020 at 11:31 PM Arjan van de Ven <arjan@linux.intel.co=
m> wrote:
> >> On 8/13/2020 12:58 PM, Randy Dunlap wrote:
> >>> From: Randy Dunlap <rdunlap@infradead.org>
> >>>
> >>> Fix build error when CONFIG_ACPI is not set/enabled by adding
> >>> the header file <asm/acpi.h> which contains a stub for the function
> >>> in the build error.
> >>>
> >>> ../arch/x86/pci/intel_mid_pci.c: In function =E2=80=98intel_mid_pci_i=
nit=E2=80=99:
> >>> ../arch/x86/pci/intel_mid_pci.c:303:2: error: implicit declaration of=
 function =E2=80=98acpi_noirq_set=E2=80=99; did you mean =E2=80=98acpi_irq_=
get=E2=80=99? [-Werror=3Dimplicit-function-declaration]
> >>>    acpi_noirq_set();
> >
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Thanks!
>
> also:
> Reviewed-by: Jesse Barnes <jsbarnes@google.com>
>
> >
> >>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> >>> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> >>> Cc: Len Brown <lenb@kernel.org>
> >>> Cc: Bjorn Helgaas <bhelgaas@google.com>
> >>> Cc: Jesse Barnes <jsbarnes@google.com>
> >>> Cc: Arjan van de Ven <arjan@linux.intel.com>
> >>> Cc: linux-pci@vger.kernel.org
> >>> ---
> >>> Found in linux-next, but applies to/exists in mainline also.
> >>>
> >>> Alternative.1: X86_INTEL_MID depends on ACPI
> >>> Alternative.2: drop X86_INTEL_MID support
> >>
> >> at this point I'd suggest Alternative 2; the products that needed that=
 (past tense, that technology
> >> is no longer need for any newer products) never shipped in any form wh=
ere a 4.x or 5.x kernel could
> >> work, and they are also all locked down...
> >
> > This is not true. We have Intel Edison which runs nicely on vanilla
> > (not everything, some is still requiring a couple of patches, but most
> > of it works out-of-the-box).
> >
> > And for the record, I have been working on removing quite a pile of
> > code (~13kLOCs to the date IIRC) in MID area. Just need some time to
> > fix Edison watchdog for that.
>
>
> I didn't see a consensus on this patch, although Andy says it's still nee=
ded,
> so it shouldn't be removed (yet). Maybe his big removal patch can remove =
it
> later. For now can we just fix the build error?


Yeah I think it makes sense to land it.  Doesn't get in the way of a
future removal and fixes a build error in the meantime.

Jesse
