Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6D2288B74
	for <lists+linux-pci@lfdr.de>; Fri,  9 Oct 2020 16:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388703AbgJIOen (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Oct 2020 10:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387662AbgJIOen (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Oct 2020 10:34:43 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8421C0613D2;
        Fri,  9 Oct 2020 07:34:42 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id t6so736965qvz.4;
        Fri, 09 Oct 2020 07:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ls9vz0a1qTFN1GMHqLkY6qWko2ASP2xU7lPUVCQ8ZGo=;
        b=levKtKXFBhq1hsCUosWHpEv/H426nlHTQ3ECBv+8Iy7DpkdaeY39QdjY3zkTjsOm70
         gRk5tZVVA8vrMLi55gQmOimNmJDQvpZGoazL/GrWa2T6/FhYgThl0o4hL9c7ROhz8FYB
         TL4xG8f+5xVVJnLL7c4aRq45Srx6wli9ZW5YFsxzqoYfO5LoORJ2NI1at1XwcpAfvnTV
         GPmSp/XQ3kIs0EFKSkXqPggcX++30zoetJLzhNDPQsNeYn03ai8Ev/36id6KFVPxyT1p
         E0rd+bTNLwwugNEMTcslkgGV2DE6eXN6J0hXM8hL7DVzebR0xzDJG1NarANwM71Qg3ir
         7uxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ls9vz0a1qTFN1GMHqLkY6qWko2ASP2xU7lPUVCQ8ZGo=;
        b=hQ3omL5Js1MGbvPd0uD/Fz/Zw0wXP/MURgRskhfjZo0lqAeb+7b8eiaCn62pGEurJr
         7qJ1ldEtgq7PbdBFRSpCgAq9QoFKpJfhQwqd4tIzxOuSLHsYJn8h7Nlu365kNRUTtDtt
         slmwzgzR4CJQmTE92pjl7IWZVexl+epSWETjknYAtaNVzJKsJba2B7rkFlhQsJ1elKA2
         0Y7/VJvwaI/furkrqf0TL0/8reV5OvAlbnzcOuIe8HvEb8dH4NLDFmEpXf0ZhXHh7c92
         eTSVivHp16VEX1xPv07r51i2C4A2GBbygsb3vQb1xujmJPh2yyYN6lqU2aZVGtwlu29F
         eKFg==
X-Gm-Message-State: AOAM5317zUsTcHD72+BC058PFatHg7cw2mYTMmyz1h4UZuP+f4KFQkLU
        7JWqGDLTl9X7QECCMN59e4cT76/MTfWy9lp62iI=
X-Google-Smtp-Source: ABdhPJzBD8SPzyj50tFSLUKQ30K6ksYYUgx5iylfjWwPGxFTqyAs3HpJ76EoSYTvPiJxGfR6KfH5wRtdb4nQV05p5So=
X-Received: by 2002:a05:6214:1147:: with SMTP id b7mr5862560qvt.10.1602254081785;
 Fri, 09 Oct 2020 07:34:41 -0700 (PDT)
MIME-Version: 1.0
References: <20201007133002.GA3236436@bjorn-Precision-5520> <2C086FFC-28F5-42BB-933E-0C1C4FDC738B@canonical.com>
In-Reply-To: <2C086FFC-28F5-42BB-933E-0C1C4FDC738B@canonical.com>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Fri, 9 Oct 2020 16:34:30 +0200
Message-ID: <CAA85sZszpwU4MNKzb=W3MaK8YHwfuEmdXkc03TJkDtOD6a3L0A@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: vmd: Enable ASPM for mobile platforms
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Derrick, Jonathan" <jonathan.derrick@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 8, 2020 at 6:19 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
>
>
> > On Oct 7, 2020, at 21:30, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Wed, Oct 07, 2020 at 12:26:19PM +0800, Kai-Heng Feng wrote:
> >>> On Oct 6, 2020, at 03:19, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >>> On Tue, Oct 06, 2020 at 02:40:32AM +0800, Kai-Heng Feng wrote:
> >>>>> On Oct 3, 2020, at 06:18, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >>>>> On Wed, Sep 30, 2020 at 04:24:54PM +0800, Kai-Heng Feng wrote:
> >
> > ...
> >>>> I wonder whether other devices that add PCIe domain have the same
> >>>> behavior?  Maybe it's not a special case at all...
> >>>
> >>> What other devices are these?
> >>
> >> Controllers which add PCIe domain.
> >
> > I was looking for specific examples, not just a restatement of what
> > you said before.  I'm just curious because there are a lot of
> > controllers I'm not familiar with, and I can't think of an example.
> >
> >>>> I understand the end goal is to keep consistency for the entire ASPM
> >>>> logic. However I can't think of any possible solution right now.
> >>>>
> >>>>> - If we built with CONFIG_PCIEASPM_POWERSAVE=y, would that solve the
> >>>>>  SoC power state problem?
> >>>>
> >>>> Yes.
> >>>>
> >>>>> - What issues would CONFIG_PCIEASPM_POWERSAVE=y introduce?
> >>>>
> >>>> This will break many systems, at least for the 1st Gen Ryzen
> >>>> desktops and laptops.
> >>>>
> >>>> All PCIe ASPM are not enabled by BIOS, and those systems immediately
> >>>> freeze once ASPM is enabled.
> >>>
> >>> That indicates a defect in the Linux ASPM code.  We should fix that.
> >>> It should be safe to use CONFIG_PCIEASPM_POWERSAVE=y on every system.
> >>
> >> On those systems ASPM are also not enabled on Windows. So I think
> >> ASPM are disabled for a reason.
> >
> > If the platform knows ASPM needs to be disabled, it should be using
> > ACPI_FADT_NO_ASPM or _OSC to prevent the OS from using it.  And if
> > CONFIG_PCIEASPM_POWERSAVE=y means Linux enables ASPM when it
> > shouldn't, that's a Linux bug that we need to fix.
>
> Yes that's a bug which fixed by Ian's new patch.
>
> >
> >>> Are there bug reports for these? The info we would need to start with
> >>> includes "lspci -vv" and dmesg log (with CONFIG_PCIEASPM_DEFAULT=y).
> >>> If a console log with CONFIG_PCIEASPM_POWERSAVE=y is available, that
> >>> might be interesting, too.  We'll likely need to add some
> >>> instrumentation and do some experimentation, but in principle, this
> >>> should be fixable.
> >>
> >> Doing this is asking users to use hardware settings that ODM/OEM
> >> never tested, and I think the risk is really high.
> >
> > What?  That's not what I said at all.  I'm asking for information
> > about these hangs so we can fix them.  I'm not suggesting that you
> > should switch to CONFIG_PCIEASPM_POWERSAVE=y for the distro.
>
> Ah, I thought your suggestion is switching to CONFIG_PCIEASPM_POWERSAVE=y, because I sense you want to use that to cover the VMD ASPM this patch tries to solve.
>
> Do we have a conclusion how to enable VMD ASPM with CONFIG_PCIEASPM_DEFAULT=y?
>
> >
> > Let's back up.  You said:
> >
> >  CONFIG_PCIEASPM_POWERSAVE=y ... will break many systems, at least
> >  for the 1st Gen Ryzen desktops and laptops.
> >
> >  All PCIe ASPM are not enabled by BIOS, and those systems immediately
> >  freeze once ASPM is enabled.
> >
> > These system hangs might be caused by (1) some hardware issue that
> > causes a hang when ASPM is enabled even if it is configured correctly
> > or (2) Linux configuring ASPM incorrectly.
>
> It's (2) here.
>
> >
> > For case (1), the platform should be using ACPI_FADT_NO_ASPM or _OSC
> > to prevent the OS from enabling ASPM.  Linux should pay attention to
> > that even when CONFIG_PCIEASPM_POWERSAVE=y.
> >
> > If the platform *should* use these mechanisms but doesn't, the
> > solution is a quirk, not the folklore that "we can't use
> > CONFIG_PCIEASPM_POWERSAVE=y because it breaks some systems."
>
> The platform in question doesn't prevent OS from enabling ASPM.
>
> >
> > For case (2), we should fix Linux so it configures ASPM correctly.
> >
> > We cannot use the build-time CONFIG_PCIEASPM settings to avoid these
> > hangs.  We need to fix the Linux run-time code so the system operates
> > correctly no matter what CONFIG_PCIEASPM setting is used.
> >
> > We have sysfs knobs to control ASPM (see 72ea91afbfb0 ("PCI/ASPM: Add
> > sysfs attributes for controlling ASPM link states")).  They can do the
> > same thing at run-time as CONFIG_PCIEASPM_POWERSAVE=y does at
> > build-time.  If those knobs cause hangs on 1st Gen Ryzen systems, we
> > need to fix that.
>
> Ian's patch solves the issue, at least for the systems I have.

Could you add:
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 15d64832a988..cd9f2101f9a2 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -482,7 +482,12 @@ static void pcie_aspm_check_latency(struct
pci_dev *endpoint)
                        latency = max_t(u32, link->latency_up.l1,
link->latency_dw.l1);
                        l1_max_latency = max_t(u32, latency, l1_max_latency);
                        if (l1_max_latency + l1_switch_latency > acceptable->l1)
+                       {
+                               pci_info(endpoint, "L1 latency
exceeded - path: %i - max: %i\n", l1_switch_latency, l1_max_latency);
+                               pci_info(link->pdev, "Upstream device
- %i\n", link->latency_up.l1);
+                               pci_info(link->downstream, "Downstream
device - %i\n", link->latency_dw.l1);
                                link->aspm_capable &= ~ASPM_STATE_L1;
+                       }

                        l1_switch_latency += 1000;
                }

So we can see what device triggers what links to be disabled?

I think your use-case is much more important than mine - mine fixes
something as a side effect

Also, please send me the lspci -vvv output as well as lspci -PP -s
<device id> for the device id:s mentioned in dmesg with the patch
above applied ;)

> Kai-Heng
>
> >
> > Bjorn
>
