Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62434244028
	for <lists+linux-pci@lfdr.de>; Thu, 13 Aug 2020 22:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgHMUzc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Aug 2020 16:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgHMUzc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Aug 2020 16:55:32 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F174AC061757;
        Thu, 13 Aug 2020 13:55:31 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id f5so3160575plr.9;
        Thu, 13 Aug 2020 13:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UZu+QNWcu9a1nnFaNXesM0OrNcOGQFzQ4RmZA28SzWs=;
        b=Hv6H2ZCivIa6Vv3O9Lq3CjeaL9nRNM2qGdr16HK5XAsSltdPej6nNliCPjl/PJ7onT
         HDzQQUUYgPXpEbD4xVUytYndMDRWYB3Dp5oJcBF9wqMYsVpAGWnMp3kC/PIcCrFJIpmx
         NtjgXXc7VvOPoOaOrgKvvnCs6QXbSb1uNLMIa62sTrJjQFL9ZBsndSTiDekpU7+vvGhW
         7+a58Th6PokLzj7Xl1fY35cb+8fr9eGsiJVXpjPPlDJrO6LgID8j/z6DmAS+nh5wBgOD
         OdQq3nPkV3Axvm9b/twu6oABYHtsvYXyBbEOYXqrJ0iYSb1WuqUaUEy97RC0JLeFLb8v
         DKVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UZu+QNWcu9a1nnFaNXesM0OrNcOGQFzQ4RmZA28SzWs=;
        b=CeH/eEFp9aNK/AfZkTKPERHfk/qavaJOz+N3deOrVitK39ly99dbTszNTbN2yMpI6I
         veSpZymfOlpIznSPbzqXUIQPae/WNPubCfJbtdAtoZstuOJNJbU/Fj0MS2kCtvIqSc93
         upxWBWvaZ2AakLplkgUnU8pqrjgJdQWef/vsv7Eg8PSnUDTKnuPHe7ujpvYXo3eZB3Ou
         LLPfc1HhKMBP3SLdCgxWeI31L86lQXnH03tiBXCpqlalDBF2FPttHV8egwOgcAuEdAl+
         ZbCjAmKlRWE3OMJBuIxT0yKD27oEgUXZCY9xJ4Kv9L5etXiNQC05sgOGsHnEeRPw4osL
         AVpQ==
X-Gm-Message-State: AOAM532+q/8ByBP2R9qzl2s47FEbKFX5XTjQQvm4w7wJVIbxxKSWuIQH
        n4k9Q28v9wLJAf431h3IOW8AdnUwUAY/4sNKXfs=
X-Google-Smtp-Source: ABdhPJwM1pI0B6b4gxi8ApqCk4jdKXG2bgEXY/ko7NpAJR8LTajuFmrshj8MFCpx5cDPEegaPOidFtV+SwRsHqr732M=
X-Received: by 2002:a17:902:d3cb:: with SMTP id w11mr5389985plb.255.1597352131027;
 Thu, 13 Aug 2020 13:55:31 -0700 (PDT)
MIME-Version: 1.0
References: <20952e3e-6b06-11e4-aff7-07dfbdc5ee18@infradead.org> <810f1b0e-0adf-c316-f23c-172338f9ef0a@linux.intel.com>
In-Reply-To: <810f1b0e-0adf-c316-f23c-172338f9ef0a@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 13 Aug 2020 23:55:14 +0300
Message-ID: <CAHp75VcJCjJJvbkSiGHC+3_shWRwoqeZHE2KNDLQBjneW=02dg@mail.gmail.com>
Subject: Re: [PATCH] x86/pci: fix intel_mid_pci.c build error when ACPI is not enabled
To:     Arjan van de Ven <arjan@linux.intel.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Len Brown <lenb@kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 13, 2020 at 11:31 PM Arjan van de Ven <arjan@linux.intel.com> w=
rote:
> On 8/13/2020 12:58 PM, Randy Dunlap wrote:
> > From: Randy Dunlap <rdunlap@infradead.org>
> >
> > Fix build error when CONFIG_ACPI is not set/enabled by adding
> > the header file <asm/acpi.h> which contains a stub for the function
> > in the build error.
> >
> > ../arch/x86/pci/intel_mid_pci.c: In function =E2=80=98intel_mid_pci_ini=
t=E2=80=99:
> > ../arch/x86/pci/intel_mid_pci.c:303:2: error: implicit declaration of f=
unction =E2=80=98acpi_noirq_set=E2=80=99; did you mean =E2=80=98acpi_irq_ge=
t=E2=80=99? [-Werror=3Dimplicit-function-declaration]
> >    acpi_noirq_set();

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Thanks!

> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Cc: Len Brown <lenb@kernel.org>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Jesse Barnes <jsbarnes@google.com>
> > Cc: Arjan van de Ven <arjan@linux.intel.com>
> > Cc: linux-pci@vger.kernel.org
> > ---
> > Found in linux-next, but applies to/exists in mainline also.
> >
> > Alternative.1: X86_INTEL_MID depends on ACPI
> > Alternative.2: drop X86_INTEL_MID support
>
> at this point I'd suggest Alternative 2; the products that needed that (p=
ast tense, that technology
> is no longer need for any newer products) never shipped in any form where=
 a 4.x or 5.x kernel could
> work, and they are also all locked down...

This is not true. We have Intel Edison which runs nicely on vanilla
(not everything, some is still requiring a couple of patches, but most
of it works out-of-the-box).

And for the record, I have been working on removing quite a pile of
code (~13kLOCs to the date IIRC) in MID area. Just need some time to
fix Edison watchdog for that.

--=20
With Best Regards,
Andy Shevchenko
