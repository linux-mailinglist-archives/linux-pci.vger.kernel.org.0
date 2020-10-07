Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9F0286063
	for <lists+linux-pci@lfdr.de>; Wed,  7 Oct 2020 15:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbgJGNoX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Oct 2020 09:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728177AbgJGNoX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Oct 2020 09:44:23 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40D6C061755;
        Wed,  7 Oct 2020 06:44:22 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id 10so1798764qtx.12;
        Wed, 07 Oct 2020 06:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GeRjpSUQ2jW1Q1yjJ1KlQhrnaqHqoZ0A1BbISlbu6h8=;
        b=j6csTAmU/Ok77oROc1FQ2AWjwiNTXtgEgAE1Vf3pO5EImtyM6ewilvdxGgI1M5VJFi
         rFhkpXbRnLqlmkzCaIFks/zZ8oKENlUIFBNlOsKAdz6TyxEbQtLubnuJkggHJlT0TvIl
         E9N3x9i03KAQAnKAS6BCiwe7+saCIsTfD3QGDlv/89tTrK3O7k9bHjeGfGLagZmhrp1x
         mu/DHtR+k44qWZZi9J53KR5ASAYd0udw08qqmchb02hixH75EUxBNle2ubA0UuaclhNK
         N7hF1D4iBbDr4v21EsVcg1sZ9Rda2yKBzdvVN5uAKgrCcW7saKmwPPQc2bgJT5PxrgxZ
         ypOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GeRjpSUQ2jW1Q1yjJ1KlQhrnaqHqoZ0A1BbISlbu6h8=;
        b=UE3skIKploOMchWYyKTUscMsjHEbqeJ+E3VC5BHLVobv6ao4vk1Xo390HDUUXSfvCY
         Z46/I/U49ecr/+xkwi1nLcKd/h4LOVtPdioYavfNm0BeqxPhqVrdZU+KNuWkK/ObFhL8
         8dmtCP5fgxZJtSb9ZkGW9Q3tuOa7QLfOAVqeOqTL1J8ae51sPlCGcQ9EzvUaU6biA9Pj
         RU1QWaB/qQh1OuQfuGpgNx2OejVmhQgmwyTeztduBO5Uwc/8JWwlNsZ6XHe2JkAkEXpB
         SlJThc7E+s/oAYz6QOiARh4WjlpD7g9D1oX6IEube39qq1D5vyFUUHfbevIFqft1PqW/
         C3eg==
X-Gm-Message-State: AOAM533x0MxM+Gl0pLXfuA+bJOggggHTCM6rmcoxfRFiha8iUd32WRJZ
        TlBQiK1wJXY3A8ggn1XMcWcauwXWdv+i+6BdtaNwepXg+nI6Ng==
X-Google-Smtp-Source: ABdhPJxamo5y5k8Xk/2PhdT83fRgcnfwBJ6spaPUADn1eedINhr4ZA93lrn/zbiSUS1452KPS3k7QnYoTEl1rCoMNLc=
X-Received: by 2002:ac8:7773:: with SMTP id h19mr3146354qtu.337.1602078261965;
 Wed, 07 Oct 2020 06:44:21 -0700 (PDT)
MIME-Version: 1.0
References: <902912C5-FEE0-488A-8017-9A59B0398BD1@canonical.com> <20201007133002.GA3236436@bjorn-Precision-5520>
In-Reply-To: <20201007133002.GA3236436@bjorn-Precision-5520>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Wed, 7 Oct 2020 15:44:10 +0200
Message-ID: <CAA85sZsVuukUBwV7kTWmjXUomkTcF4nvJEFPgE7QWvmDuqP3gg@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: vmd: Enable ASPM for mobile platforms
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Derrick, Jonathan" <jonathan.derrick@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 7, 2020 at 3:30 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Oct 07, 2020 at 12:26:19PM +0800, Kai-Heng Feng wrote:
> > > On Oct 6, 2020, at 03:19, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Tue, Oct 06, 2020 at 02:40:32AM +0800, Kai-Heng Feng wrote:
> > >>> On Oct 3, 2020, at 06:18, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > >>> On Wed, Sep 30, 2020 at 04:24:54PM +0800, Kai-Heng Feng wrote:
>
> ...
> > >> I wonder whether other devices that add PCIe domain have the same
> > >> behavior?  Maybe it's not a special case at all...
> > >
> > > What other devices are these?
> >
> > Controllers which add PCIe domain.
>
> I was looking for specific examples, not just a restatement of what
> you said before.  I'm just curious because there are a lot of
> controllers I'm not familiar with, and I can't think of an example.
>
> > >> I understand the end goal is to keep consistency for the entire ASPM
> > >> logic. However I can't think of any possible solution right now.
> > >>
> > >>> - If we built with CONFIG_PCIEASPM_POWERSAVE=3Dy, would that solve =
the
> > >>>   SoC power state problem?
> > >>
> > >> Yes.
> > >>
> > >>> - What issues would CONFIG_PCIEASPM_POWERSAVE=3Dy introduce?
> > >>
> > >> This will break many systems, at least for the 1st Gen Ryzen
> > >> desktops and laptops.
> > >>
> > >> All PCIe ASPM are not enabled by BIOS, and those systems immediately
> > >> freeze once ASPM is enabled.
> > >
> > > That indicates a defect in the Linux ASPM code.  We should fix that.
> > > It should be safe to use CONFIG_PCIEASPM_POWERSAVE=3Dy on every syste=
m.
> >
> > On those systems ASPM are also not enabled on Windows. So I think
> > ASPM are disabled for a reason.
>
> If the platform knows ASPM needs to be disabled, it should be using
> ACPI_FADT_NO_ASPM or _OSC to prevent the OS from using it.  And if
> CONFIG_PCIEASPM_POWERSAVE=3Dy means Linux enables ASPM when it
> shouldn't, that's a Linux bug that we need to fix.
>
> > > Are there bug reports for these? The info we would need to start with
> > > includes "lspci -vv" and dmesg log (with CONFIG_PCIEASPM_DEFAULT=3Dy)=
.
> > > If a console log with CONFIG_PCIEASPM_POWERSAVE=3Dy is available, tha=
t
> > > might be interesting, too.  We'll likely need to add some
> > > instrumentation and do some experimentation, but in principle, this
> > > should be fixable.
> >
> > Doing this is asking users to use hardware settings that ODM/OEM
> > never tested, and I think the risk is really high.
>
> What?  That's not what I said at all.  I'm asking for information
> about these hangs so we can fix them.  I'm not suggesting that you
> should switch to CONFIG_PCIEASPM_POWERSAVE=3Dy for the distro.
>
> Let's back up.  You said:
>
>   CONFIG_PCIEASPM_POWERSAVE=3Dy ... will break many systems, at least
>   for the 1st Gen Ryzen desktops and laptops.
>
>   All PCIe ASPM are not enabled by BIOS, and those systems immediately
>   freeze once ASPM is enabled.
>
> These system hangs might be caused by (1) some hardware issue that
> causes a hang when ASPM is enabled even if it is configured correctly
> or (2) Linux configuring ASPM incorrectly.

Could this be:
1044 PCIe =C2=AE Controller May Hang on Entry Into Either L1.1 or
L1.2 Power Management Substate

Description
Under a highly specific and detailed set of internal timing
conditions, the PCIe =C2=AE controller may hang on entry
into either L1.1 or L1.2 power management substate.
This failure occurs when L1 power management substate exit is
triggered by a link partner asserting CLKREQ#
prior to the completion of the L1 power management stubstates entry protoco=
l.

Potential Effect on System
The system may hang or reset.

Suggested Workaround
Disable L1.1 and L1.2 power management substates. System software may
contain the workaround for this
erratum.

Fix Planned
Yes

Link: https://www.amd.com/system/files/TechDocs/55449_Fam_17h_M_00h-0Fh_Rev=
_Guide.pdf

> For case (1), the platform should be using ACPI_FADT_NO_ASPM or _OSC
> to prevent the OS from enabling ASPM.  Linux should pay attention to
> that even when CONFIG_PCIEASPM_POWERSAVE=3Dy.
>
> If the platform *should* use these mechanisms but doesn't, the
> solution is a quirk, not the folklore that "we can't use
> CONFIG_PCIEASPM_POWERSAVE=3Dy because it breaks some systems."
>
> For case (2), we should fix Linux so it configures ASPM correctly.
>
> We cannot use the build-time CONFIG_PCIEASPM settings to avoid these
> hangs.  We need to fix the Linux run-time code so the system operates
> correctly no matter what CONFIG_PCIEASPM setting is used.
>
> We have sysfs knobs to control ASPM (see 72ea91afbfb0 ("PCI/ASPM: Add
> sysfs attributes for controlling ASPM link states")).  They can do the
> same thing at run-time as CONFIG_PCIEASPM_POWERSAVE=3Dy does at
> build-time.  If those knobs cause hangs on 1st Gen Ryzen systems, we
> need to fix that.
>
> Bjorn
