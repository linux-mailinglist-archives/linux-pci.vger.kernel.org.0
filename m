Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 551D42ED5C5
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jan 2021 18:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbhAGRhs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jan 2021 12:37:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:58644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbhAGRhr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Jan 2021 12:37:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DAEC1233FB;
        Thu,  7 Jan 2021 17:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610041027;
        bh=W8Sz3wrq8nz0i3FXZOdUqghbLht4+0EwsMoYMeRXPaY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZhPCBL/H1Ne6spP9NfQpPG2Rk7t7+CMQuWfj3k0aFk/LeJjc4imZBd68O79X2FFmq
         wPUUlV3Q20DxMPBrnsj0vYn4TAPm9fo7CyyibUD36m3Aq9cU/vWBKJKyzvZRGwr9/c
         hCw0NaP3l1VZx+8QjRVFEv7wzqxGklBq3ES5m+a9ob70egJzbltdGsfqN4OshE/C2d
         AQJDhQ8gG2yTSRZjUIAHEdXk0Ly6EYpyoxryEG0Y5ydkde9JGWrzz55Dy77jKIX8wi
         QvGG72aamrHLxN41m7INBY1K9ZUgk1HZua6jh0pXIVEBpK6A9OFHta/MPb/xh/c0ha
         lvtZkCiStslTQ==
Received: by mail-qv1-f41.google.com with SMTP id p5so3108105qvs.7;
        Thu, 07 Jan 2021 09:37:06 -0800 (PST)
X-Gm-Message-State: AOAM531uvDtLkwTKSBST50+OU2gwiQz7DFxK0gGY/taMzBk05abQXSGg
        p0iIhbCRIymDBZbeaO3quQYb5gFGYEX/+//bIw==
X-Google-Smtp-Source: ABdhPJzURj++TxosCxNiS9vlUB76midDLxNdvQtTqewOJTwH+v7wz9NYeiovBs2vgzJFIHz8aO6WNDW1+ZyOsbn9gKw=
X-Received: by 2002:ad4:4c8c:: with SMTP id bs12mr9730295qvb.11.1610041025928;
 Thu, 07 Jan 2021 09:37:05 -0800 (PST)
MIME-Version: 1.0
References: <20210105045735.1709825-1-jeremy.linton@arm.com>
 <CAL_JsqL2ZXrTg9VFwGK4CawvyBbnHehF9W=cgVEJPzCRoM5G9g@mail.gmail.com> <bdd563a9-c8d4-307b-617c-139dda3e4984@arm.com>
In-Reply-To: <bdd563a9-c8d4-307b-617c-139dda3e4984@arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 7 Jan 2021 10:36:53 -0700
X-Gmail-Original-Message-ID: <CAL_Jsq+OUX2ctFwiqcQtM=oswyz8s-iq94eHW247sabYYF5B-A@mail.gmail.com>
Message-ID: <CAL_Jsq+OUX2ctFwiqcQtM=oswyz8s-iq94eHW247sabYYF5B-A@mail.gmail.com>
Subject: Re: [PATCH] arm64: PCI: Enable SMC conduit
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        PCI <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 7, 2021 at 9:24 AM Jeremy Linton <jeremy.linton@arm.com> wrote:
>
> Hi,
>
>
> On 1/7/21 9:28 AM, Rob Herring wrote:
> > On Mon, Jan 4, 2021 at 9:57 PM Jeremy Linton <jeremy.linton@arm.com> wr=
ote:
> >>
> >> Given that most arm64 platform's PCI implementations needs quirks
> >> to deal with problematic config accesses, this is a good place to
> >> apply a firmware abstraction. The ARM PCI SMMCCC spec details a
> >> standard SMC conduit designed to provide a simple PCI config
> >> accessor. This specification enhances the existing ACPI/PCI
> >> abstraction and expects power, config, etc functionality is handled
> >> by the platform. It also is very explicit that the resulting config
> >> space registers must behave as is specified by the pci specification.
> >
> > If we put it in a document, they must behave.
> >
> >> Lets hook the normal ACPI/PCI config path, and when we detect
> >> missing MADT data, attempt to probe the SMC conduit. If the conduit
> >> exists and responds for the requested segment number (provided by the
> >> ACPI namespace) attach a custom pci_ecam_ops which redirects
> >> all config read/write requests to the firmware.
> >>
> >> This patch is based on the Arm PCI Config space access document @
> >> https://developer.arm.com/documentation/den0115/latest
> >
> >  From the spec:
> > "On some platforms, the SoC may only support 32-bit PCI configuration
> > space writes. On such platforms, calls to this function with access
> > size of 1 or 2 bytes may require the implementation of this function
> > to perform a PCI configuration read, following by the write. This
> > could result in inadvertently corrupting adjacent RW1C fields. It is
> > the implementation responsibility to be aware of these situations and
> > guard against them if possible."
> >
> > First, this contradicts the above statement about being compliant with
> > the PCI spec. Second, Linux is left to just guess whether this is the
> > case or not? I guess it would be pointless for firmware to advertise
> > this because it could just lie.
>
> Thanks for taking a look at this.
>
> Right, to clarify. The result of the SMC calls must appear to be
> compliant, but the underlying hardware of course may not be.
>
> The RW1C discussion during the spec reviews was extensive, but as you
> can see from the language the intention is that the results appear
> compliant. But IMHO, considering that ECAM is a configuration mechanism
> not an operational one, if one looks at the results of the existing
> alignment quirks in the kernel & the DT host bridge drivers, its not
> particularly problematic. In the case that there is a problem with a
> particular adapter, its the firmware's responsibility to deal with it.
> If that isn't possible then of course the machine is neither ECAM or
> compatible with this specification, same as what happens if there is a
> fundamental issue with the MMIO mapping. Its also not unheard of for
> cards to simply be incompatible with machines due to lack of optional
> features like PIO.
>
>
> >
> > I would like to know how to 'guard against them' so I can implement
> > that in the kernel accessors.  >
> >> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> >> ---
> >>   arch/arm64/kernel/pci.c   | 87 +++++++++++++++++++++++++++++++++++++=
++
> >>   include/linux/arm-smccc.h | 26 ++++++++++++
> >>   2 files changed, 113 insertions(+)
> >>
> >> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> >> index 1006ed2d7c60..56d3773aaa25 100644
> >> --- a/arch/arm64/kernel/pci.c
> >> +++ b/arch/arm64/kernel/pci.c
> >> @@ -7,6 +7,7 @@
> >>    */
> >>
> >>   #include <linux/acpi.h>
> >> +#include <linux/arm-smccc.h>
> >>   #include <linux/init.h>
> >>   #include <linux/io.h>
> >>   #include <linux/kernel.h>
> >> @@ -107,6 +108,90 @@ static int pci_acpi_root_prepare_resources(struct=
 acpi_pci_root_info *ci)
> >>          return status;
> >>   }
> >>
> >> +static int smccc_pcie_check_conduit(u16 seg)
> >
> > check what? Based on how you use this, perhaps _has_conduit() instead.
>
> Sure.
>
> >
> >> +{
> >> +       struct arm_smccc_res res;
> >> +
> >> +       if (arm_smccc_1_1_get_conduit() =3D=3D SMCCC_CONDUIT_NONE)
> >> +               return -EOPNOTSUPP;
> >> +
> >> +       arm_smccc_smc(SMCCC_PCI_VERSION, 0, 0, 0, 0, 0, 0, 0, &res);
> >> +       if ((int)res.a0 < 0)
> >> +               return -EOPNOTSUPP;
> >> +
> >> +       arm_smccc_smc(SMCCC_PCI_SEG_INFO, seg, 0, 0, 0, 0, 0, 0, &res)=
;
> >> +       if ((int)res.a0 < 0)
> >> +               return -EOPNOTSUPP;
> >
> > Don't you need to check that read and write functions are supported?
>
> In theory no, the first version of the specification makes them
> mandatory for all implementations. There isn't a partial access method,
> so nothing works if only read or write were implemented.

Then the spec should change:

2.3.3 Caller responsibilities
The caller has the following responsibilities:
=E2=80=A2 The caller must ensure that this function is implemented before
issuing a call. This function is discoverable
by calling PCI_FEATURES with pci_func_id set to 0x8400_0132.


I guess knowing the version is ensuring, but the 2nd sentence makes it
seem that is how one should ensure.

Related, are there any sort of tests for the interface? I generally
don't think the kernel's job is validating firmware (a frequent topic
for DT), but we should have something. Maybe an SMC unittest module?
If nothing else, seems like we should have at least one PCI_FEATURES
call to make sure it works. We don't want to add it later only to find
that it breaks on some firmware implementations. Though we can just
add firmware quirks. ;)

Rob
