Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB5DE349B2F
	for <lists+linux-pci@lfdr.de>; Thu, 25 Mar 2021 21:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbhCYUp1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Mar 2021 16:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbhCYUpW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Mar 2021 16:45:22 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B951C06175F
        for <linux-pci@vger.kernel.org>; Thu, 25 Mar 2021 13:45:22 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id u8so2706799qtq.12
        for <linux-pci@vger.kernel.org>; Thu, 25 Mar 2021 13:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mFybgM3J0xN8eb0mL6JyWmrKNINwf1FLQ2Vv0es9yBU=;
        b=pRO9gasJG2U01hTstX0TisBC1HrBJ1djFbDTUgKqHdmKGX+3+0EhuRbtLhakkHrUDG
         5VUqaSY9OGQzO/Ggd8EkY4IsTu+Ue9NttT8frJ92xT/vdF/VMRU56HtD2tUjPxrSYtCL
         jAwVuvMNYbaMibuM3FNkOrIn+EFHyzNwU3Lka8I69pdb2pJ0xFH86WKkFhxHkgajovTa
         mCjMcc2HZvV0+w4AQgbU1GUsUA+Ly8A8AqcS6wA1x49qYWCpNNm4SruicXWa/SzkaUDv
         OOqEbYWFqsN52Twba8AzjcdwaQe+dMSw0m2PuVaYrKM0t2urP7iY/ta+D75vERE6kZ02
         oiZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mFybgM3J0xN8eb0mL6JyWmrKNINwf1FLQ2Vv0es9yBU=;
        b=tb0tvYVxcUIRtHNZjsffZ9e+nvG9oO4wZbHQaYoJRMUX/d8fVYZXRhMwz1gZ3gcv6i
         ZqT5nZ/NDl+c5xww66CrRuUPJ1Tp4Pp2yOr+A5NWNCcKtMUGqIoqnX/oszJkw8lQxB+W
         Oyey8cSP93A5gqTCZWYX7uvmU0sMuw7fWdU9BpRj3zFKXATQoesArK9t+u9Q5cLthkuK
         li7ujCfuFlMs9WXrfOOAT+NCebY2Kg2nqI2ysVRHKjEn/9WCXSxc+OhgSRcNZIMrzABA
         dxJ3ibIIrXRAZOwTmnJ/fgVpBt5PjyQGEK5QL6WpPscpJ19O6pMnyNsLpl8E+PuWr5Eh
         cgog==
X-Gm-Message-State: AOAM531yRDZ7Xw1BlT7OBe5FC5K3OjdtoZYr1lJl6YXgjuauAd0BgF+g
        +ms0MAj8wZnr4LJrzKTRxIYqIFAc4eI33vkR5fZ1RQ==
X-Google-Smtp-Source: ABdhPJy2CUZSBuohpaeqblMV61XQmQx4Dbpvd/wN7nECjwxT+KwpVyQWAjoXCDtAu+sri9HI+etbcZY5s2UTUSCTxYM=
X-Received: by 2002:ac8:777a:: with SMTP id h26mr9428385qtu.318.1616705121343;
 Thu, 25 Mar 2021 13:45:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210105045735.1709825-1-jeremy.linton@arm.com>
 <20210107181416.GA3536@willie-the-truck> <56375cd8-8e11-aba6-9e11-1e0ec546e423@jonmasters.org>
 <20210108103216.GA17931@e121166-lin.cambridge.arm.com> <20210122194829.GE25471@willie-the-truck>
 <b37bbff9-d4f8-ece6-3a89-fa21093e15e1@nvidia.com> <20210126225351.GA30941@willie-the-truck>
 <20210325131231.GA18590@e121166-lin.cambridge.arm.com>
In-Reply-To: <20210325131231.GA18590@e121166-lin.cambridge.arm.com>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Thu, 25 Mar 2021 21:45:08 +0100
Message-ID: <CAPv3WKcgZ9aEx7s6keWMssGefYH=rtdxSp5eiBVibtjY=sctpg@mail.gmail.com>
Subject: Re: [PATCH] arm64: PCI: Enable SMC conduit
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Will Deacon <will@kernel.org>, Vikram Sethi <vsethi@nvidia.com>,
        vidyas@nvidia.com, Thierry Reding <treding@nvidia.com>,
        Jon Masters <jcm@jonmasters.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-pci@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org, ebrower@nvidia.com,
        jcm@redhat.com, Grzegorz Jaszczyk <jaz@semihalf.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,


czw., 25 mar 2021 o 14:19 Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> napisa=C5=82(a):
>
> On Tue, Jan 26, 2021 at 10:53:51PM +0000, Will Deacon wrote:
> > On Tue, Jan 26, 2021 at 11:08:31AM -0600, Vikram Sethi wrote:
> > > On 1/22/2021 1:48 PM, Will Deacon wrote:
> > > > On Fri, Jan 08, 2021 at 10:32:16AM +0000, Lorenzo Pieralisi wrote:
> > > >> On Thu, Jan 07, 2021 at 04:05:48PM -0500, Jon Masters wrote:
> > > >>> On 1/7/21 1:14 PM, Will Deacon wrote:
> > > >>>> On Mon, Jan 04, 2021 at 10:57:35PM -0600, Jeremy Linton wrote:
> > > >>>>> Given that most arm64 platform's PCI implementations needs quir=
ks
> > > >>>>> to deal with problematic config accesses, this is a good place =
to
> > > >>>>> apply a firmware abstraction. The ARM PCI SMMCCC spec details a
> > > >>>>> standard SMC conduit designed to provide a simple PCI config
> > > >>>>> accessor. This specification enhances the existing ACPI/PCI
> > > >>>>> abstraction and expects power, config, etc functionality is han=
dled
> > > >>>>> by the platform. It also is very explicit that the resulting co=
nfig
> > > >>>>> space registers must behave as is specified by the pci specific=
ation.
> > > >>>>>
> > > >>>>> Lets hook the normal ACPI/PCI config path, and when we detect
> > > >>>>> missing MADT data, attempt to probe the SMC conduit. If the con=
duit
> > > >>>>> exists and responds for the requested segment number (provided =
by the
> > > >>>>> ACPI namespace) attach a custom pci_ecam_ops which redirects
> > > >>>>> all config read/write requests to the firmware.
> > > >>>>>
> > > >>>>> This patch is based on the Arm PCI Config space access document=
 @
> > > >>>>> https://developer.arm.com/documentation/den0115/latest
> > > >>>> Why does firmware need to be involved with this at all? Can't we=
 just
> > > >>>> quirk Linux when these broken designs show up in production? We'=
ll need
> > > >>>> to modify Linux _anyway_ when the firmware interface isn't imple=
mented
> > > >>>> correctly...
> > > >>> I agree with Will on this. I think we want to find a way to addre=
ss some
> > > >>> of the non-compliance concerns through quirks in Linux. However..=
.
> > > >> I understand the concern and if you are asking me if this can be f=
ixed
> > > >> in Linux it obviously can. The point is, at what cost for SW and
> > > >> maintenance - in Linux and other OSes, I think Jeremy summed it up
> > > >> pretty well:
> > > >>
> > > >> https://lore.kernel.org/linux-pci/61558f73-9ac8-69fe-34c1-2074dec5=
f18a@arm.com
> > > >>
> > > >> The issue here is that what we are asked to support on ARM64 ACPI =
is a
> > > >> moving target and the target carries PCI with it.
> > > >>
> > > >> This potentially means that all drivers in:
> > > >>
> > > >> drivers/pci/controller
> > > >>
> > > >> may require an MCFG quirk and to implement it we may have to:
> > > >>
> > > >> - Define new ACPI bindings (that may need AML and that's already a
> > > >>   showstopper for some OSes)
> > > >> - Require to manage clocks in the kernel (see link-up checks)
> > > >> - Handle PCI config space faults in the kernel
> > > >>
> > > >> Do we really want to do that ? I don't think so. Therefore we need
> > > >> to have a policy to define what constitutes a "reasonable" quirk a=
nd
> > > >> that's not objective I am afraid, however we slice it (there is no
> > > >> such a thing as eg 90% ECAM).
> > > > Without a doubt, I would much prefer to see these quirks and workar=
ounds
> > > > in Linux than hidden behind a firmware interface. Every single time=
.
> > >
> > > In that case, can you please comment on/apply Tegra194 ECAM quirk tha=
t was rejected
> > >
> > > a year ago, and was the reason we worked with Samer/ARM to define thi=
s common
> > >
> > > mechanism?
> > >
> > > https://lkml.org/lkml/2020/1/3/395
> > >
> > > The T194 ECAM is from widely used Root Port IP from a IP vendor. That=
 is one reason so many
> > >
> > > *existing* SOCs have ECAM quirks. ARM is only now working with the Ro=
ot port IP vendors
> > >
> > > to test ECAM, MSI etc, but the reality is there were deficiencies in =
industry IP that is widely
> > >
> > > used. If this common quirk is not the way to go, then please apply th=
e T194 specific quirk which was
> > >
> > > NAK'd a year ago, or suggest how to improve that quirk.
> > >
> > > The ECAM issue has been fixed on future Tegra chips and is validated =
preSilicon with BSA
> > >
> > > tests, so it is not going to be a recurrent issue for us.
> >
> > (aside: please fix your mail client not to add all these blank lines)
> >
> > Personally, if a hundred lines of self-contained quirk code is all
> > that is needed to get your legacy IP running, then I would say we
> > should merge it.  But I don't maintain the PCI subsystem, and I trust
> > Bjorn and Lorenzo's judgement as to what is the right thing to do when
> > it concerns that code.  After all, they're the ones who end up having
> > to look after this stuff long after the hardware companies have
> > stopped caring.
>
> A discussion was held between me, Will Deacon, Bjorn Helgaas and Jon
> Masters to agree on a proposed solution for this matter, a summary of the
> outcome below:
>
> - The PCI SMC conduit and related specifications are seen as firmware
>   kludge to a long-standing HW compliance issue. The SMC interface does
>   not encourage Arm partners to fix their IPs and its only purpose
>   consists in papering over HW issues that should have been fixed by
>   now; were the PCI SMC conduit introduced at arm64 ACPI inception as
>   part of the standardization effort the matter would have been different
>   but introducing it now brings about more shortcomings than benefits on
>   balance, especially if MCFG quirks can be controlled and monitored (and
>   they will).
>
>   The end-goal is that hardware must be ECAM compliant. An SMC-based
>   solution runs counter to that desire by removing the incentive for ECAM
>   compliance.
>
>   In sum, the SMC conduit solution was deemed to be deficient in these
>   respects:
>
>         * Removes incentive to build hardware with compliant ECAM
>         * Moves quirk code into firmware where it can't sensibly
>           be maintained or updated
>         * Future of the SMC conduit is unclear and has no enforceable
>           phase-out plan
>
>   It was decided that the PCI SMC conduit enablement patches will not be
>   merged for these specific reasons.
>
> - It is not clear why ACPI enablement is requested for platforms that are
>   clearly not compliant with Arm SBSA/SBBR guidelines; there is no
>   interest from distros in enabling ACPI bootstrap on non-SBSA compliant
>   HW, devicetree firmware can be used to bootstrap non-compliant platform=
s.
> - We agreed that Linux will rely on MCFG quirks to enable PCI on ACPI
>   arm64 systems if the relevant HW is not ECAM compliant (and ACPI
>   enablement is requested); non-ECAM compliance must be classified as a H=
W
>   defect and filed in the Linux kernel as an erratum in (or equivalent
>   mechanism TBD):
>
>   Documentation/arm64/acpi-ecam-quirks.rst
>
>   Entries will contain an expected lifetime for the SoC in question and
>   a contact point. When an entry expires, a patch to remove the related
>   MCFG quirk will be proposed and action taken accordingly (either the
>   quirk is removed since support is no longer required or the entry is
>   updated). Details behind the specific mechanism to follow on public
>   mailing lists.
>
> - MCFG quirks will be reviewed by PCI maintainers and acceptance will be
>   granted or refused on a case by case basis; the aim is supporting HW
>   where quirks are self-contained and don't require FW or specifications
>   updates.
>
>   In order to request a MCFG quirk acceptance a relevant errata entry
>   should be filed in the related Linux kernel documentation errata file.
>   This will help detect whether non-ECAM HW bugs that were granted an
>   MCFG quirk are actually fixed in subsequent SoCs.
>
> - As a rule of thumb (that will be drafted in non-ECAM errata guidelines)=
,
>   to be considered for upstream MCFG quirks must not rely on additional
>   ACPI firmware bindings and AML code other than MCFG table and
>   PNP0A08/PNP0A03 ACPI *existing* bindings.
>
>   MCFG quirks suitability for upstream merge will be determined by
>   PCI maintainers only.
>

Thank you for the efforts of keeping arm64 PCI+ACPI world clean. The
discussion and finally the last statement under this patch revived
some old memories and triggered thoughts I'd like to share.

We are close to the 4th anniversary of setting the MCFG quirk embargo.
The merged ones are mostly really nasty, but were lucky to jump on
that train back in the day. MacchiatoBin platform (and the entire
Marvell Armada 7k8k SoC family) was created before that time, but
missed it by only a couple of months with its firmware development. It
has a DWC IP with 3 lines of the required quirk (see DT variant for
the reference: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/lin=
ux.git/tree/drivers/pci/controller/pci-host-generic.c?h=3Dv5.12-rc4#n26)
but we had to politely accept "these are the rules, we will never
convince the vendors to properly adopt to the specs"-NACK.

This hurt badly the first candidate for arm64-PC-like platform, as
effectively blocked the GPU usage with ACPI. Same story with a real
candidate for such device (SolidRun Honeycomb) - similar DWC
controller and the same problems. We want people to use arm64
workstations outside of the passionate-developer-bubble, we want to
standardize (great SystemReady program!), but due to arbitrary
decisions we don't push it forward, least to say. Don't get me wrong,
I would love all HW to use proper IP and "just work" without hacks,
but this takes time and apparently is not that easy, so maybe an
option to mitigate the limitations with SW (to some extent and even
temporary) should be considered. This patch was a chance for that IMO,
without adding a burden of maintaining quirks.

Also I am not in a position to reach out to vendors and convince to
anything, but I read about this need 4 years ago and now I see that
there is a *plan* to do it. DWC is as broken as it was, with a lot new
platforms in the tree, but fully functional in ECAM mode only with
DT...

But I left the best to the end - below are 2 quirks merged despite the emba=
rgo:
Ampere: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/drivers/acpi/pci_mcfg.c?h=3Dv5.12-rc4&id=3D877c1a5f79c6984bbe3f29242=
34c08e2f4f1acd5
Amazon (Annapurna):
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/d=
rivers/acpi/pci_mcfg.c?h=3Dv5.12-rc4&id=3D4166bfe53093b687a0b1b22e5d943e143=
b8089b2
I must admit the second one rose my blood pressure and triggered this
email - it's a quirk for DWC, 1:1 to what was NACKed for Marvell
almost 2 years earlier.

So what we have after 4 years:
* Direct convincing of IP vendors still being a plan.
* Reverting the original approach towards MCFG quirks.
* Double-standards in action as displayed by 2 cases above.
I'm sorry for my bitter tone, but I think this time could and should
have been spent better - I doubt it managed to push us in any
significant way towards wide fully-standard compliant PCIE IP
adoption.

Best regards,
Marcin
