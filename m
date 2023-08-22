Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390EC783DA7
	for <lists+linux-pci@lfdr.de>; Tue, 22 Aug 2023 12:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjHVKLd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 22 Aug 2023 06:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233487AbjHVKLb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Aug 2023 06:11:31 -0400
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE404CCB;
        Tue, 22 Aug 2023 03:11:23 -0700 (PDT)
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-570e8bee8b5so197940eaf.1;
        Tue, 22 Aug 2023 03:11:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692699083; x=1693303883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nkUB8Q5p3An3nKuRxt+zSoSlyY4Sk7U3gc/0U0+fP/w=;
        b=Tp6rVq78aBjVF+ft1x5LZBlsX0wocZXbT+naDOw2F0NyQiwWThBrgLEH+2oM3IT603
         b/nFkI8KnMI9ukaa4tRZ0ZuzkCu8Y71kwsqzazl3NZ2rhHbUtQTqFJbhLR42E6qaokfN
         gOz1zOEjyQwlawLMnWDxD/hiZUpRvSAryJXn3TPCrV17F7CKv3BM5DvGH65y4vs88ejJ
         1Q5lQpdn5rphmGwEHcQUnFgtm4DmKRJfBSoWBIdg3WEpeNmvWw9xO1/mQEv9aGj6HMuR
         dsyU2PCzd+M9X1QmtqWNd6S0e6yzSDopEgBMtpN9IiG/6Afn9ALBn/c5uxXdaXMn+u2C
         4lww==
X-Gm-Message-State: AOJu0YyTS1evZxOiWqlT4OdQPtZqSrLdc3l3CNVJQuL+costLf8A+m0j
        GOeOadgMbnSb/euEqlKq/OVFEQK0a3yj4BeThEc=
X-Google-Smtp-Source: AGHT+IGIZwFt4/TzRTflcghiEdeOQjaN4GPFJhE/xj5C2hPs8sU4QnS0JjMPyOz/AknP8fGhbotpWP0JTbIxKT2oaBE=
X-Received: by 2002:a4a:e882:0:b0:570:d852:f77f with SMTP id
 g2-20020a4ae882000000b00570d852f77fmr4467620ooe.1.1692699082625; Tue, 22 Aug
 2023 03:11:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230818193932.27187-1-mario.limonciello@amd.com> <20230821224207.GA369432@bhelgaas>
In-Reply-To: <20230821224207.GA369432@bhelgaas>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 22 Aug 2023 12:11:10 +0200
Message-ID: <CAJZ5v0hU3mWFaaujWozHnPw8+A=bf2OwzcendXjpP35wCv_B6g@mail.gmail.com>
Subject: Re: [PATCH v14.a 1/1] PCI: Only put Intel PCIe ports >= 2015 into D3
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, Iain Lane <iain@orangesquash.org.uk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 22, 2023 at 12:42 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Aug 18, 2023 at 02:39:32PM -0500, Mario Limonciello wrote:
> > commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
> > changed pci_bridge_d3_possible() so that any vendor's PCIe ports
> > from modern machines (>=2015) are allowed to be put into D3.
> >
> > Iain reports that USB devices can't be used to wake a Lenovo Z13
> > from suspend. This is because the PCIe root port has been put
> > into D3 and AMD's platform can't handle USB devices waking in this
> > case.
> >
> > This behavior is only reported on Linux. Comparing the behavior
> > on Windows and Linux, Windows doesn't put the root ports into D3.
> >
> > To fix the issue without regressing existing Intel systems,
> > limit the >=2015 check to only apply to Intel PCIe ports.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
> > Reported-by: Iain Lane <iain@orangesquash.org.uk>
> > Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
> > Reviewed-by:Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > ---
> > In v14 this series has been split into 3 parts.
> >  part A: Immediate fix for AMD issue.
> >  part B: LPS0 export improvements
> >  part C: Long term solution for all vendors
> > v13->v14:
> >  * Reword the comment
> >  * add tag
> > v12->v13:
> >  * New patch
> > ---
> >  drivers/pci/pci.c | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 60230da957e0c..bfdad2eb36d13 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -3037,10 +3037,15 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
> >                       return false;
> >
> >               /*
> > -              * It should be safe to put PCIe ports from 2015 or newer
> > -              * to D3.
> > +              * Allow Intel PCIe ports from 2015 onward to go into D3 to
> > +              * achieve additional energy conservation on some platforms.
> > +              *
> > +              * This is only set for Intel PCIe ports as it causes problems
> > +              * on both AMD Rembrandt and Phoenix platforms where USB keyboards
> > +              * can not be used to wake the system from suspend.
> >                */
> > -             if (dmi_get_bios_year() >= 2015)
> > +             if (bridge->vendor == PCI_VENDOR_ID_INTEL &&
> > +                 dmi_get_bios_year() >= 2015)
> >                       return true;
>
> Hmm.  I'm really not a fan of checks like this that aren't connected
> to an actual property of the platform.  The Intel Vendor ID tells us
> nothing about what the actual problem is, which makes it really hard
> to maintain in the future.  It's also very AMD- and Intel-centric,
> when this code is ostensibly arch-agnostic, so this potentially
> regresses ARM64, RISC-V, powerpc, etc.

That's a fair point.

Would it be better to reverse this and filter out AMD systems as they
are affected by the existing check?

> It's bad enough that we check for 2015.  A BIOS security update to a
> 2014 platform will break things,

Well, not necessarily.  Pre-2015 systems already worked and the check
was added as "surely, everything 2015 or newer should work either".
While it is true that putting PCIe Root Ports into D3hot was necessary
for extra energy conservation on Intel systems, it actually has been
expected to work everywhere.

> even though the update has nothing to
> do with D3.  We're stuck with that one, and it's old enough that maybe
> it won't bite us any more, but I hate to add more.

Well, how would you like to deal with the systems that don't work
today, because they expect a different behavior?

Effectively, the current behavior for all modern systems is to allow
bridge D3 if there are no indications that it shouldn't be allowed.
The platforms in question assume the reverse, so what else can be
done?

> The list of conditions in pci_bridge_d3_possible() is a pretty good
> clue that we don't really know what we're doing, and all we can do is
> find configurations that happen to work.

Yes, because by the spec it all should work just fine.  The PCI PM 1.2
specification defines the expected behavior for bridges and the PCIe
specification claims to be a superset of that.

What we need to deal with here is basically non-compliant systems and
so we have to catch the various forms of non-compliance.

> I don't have any better suggestions, other than that this should be
> described somehow via ACPI (and not in vendor-specific stuff like
> PNP0D80).

Well, it isn't in practice.
