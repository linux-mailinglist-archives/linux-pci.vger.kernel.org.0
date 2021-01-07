Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8472EE701
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jan 2021 21:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbhAGUgY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jan 2021 15:36:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:56510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbhAGUgY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Jan 2021 15:36:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 916D723447;
        Thu,  7 Jan 2021 20:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610051743;
        bh=po85gdl4mbGgQ3zoAKeD43WPxXK5RT1mSTU3OKiNhVs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NVRc3ombNUhTsi7VIIbCgBTp1kgiAL1Ji/eNtcLjti6qYZY+t+QEoPGIH1xW4UdJ9
         25QMgWFqBBAEx6d/Y27Y/Y6n/dwK1ent3pAwLqei9u1HrkCKZv785sqYUepu0/vkta
         69GFvDk9iuqliL0u4s0XeULeOBJttxi40nVtmrGJ8DHrRUn/GB19V6WRf9oOkoqJhk
         Ru+YV6Ypu3rwuv+DRNGTLYkL0D1bowS1u/yZVTRFxaLAv1oaG2mXYeg1/iKrtN2zBc
         Dg9fkEmcQxixmbkCE1hSpcfHPXGK4Z48lpY5eONeAmtM4aPcaNxC9/QArsz6V9EF42
         retcQ/wii/u3A==
Received: by mail-ej1-f43.google.com with SMTP id t16so11433697ejf.13;
        Thu, 07 Jan 2021 12:35:43 -0800 (PST)
X-Gm-Message-State: AOAM533J5B0sDqWMwHaYWr1ugRTL5MI4a9+747DpnWKcBQw+OaTpTKDZ
        beTyP7xBmaYpTkuvCsgrJNM2dh2UtaVCQEmSYA==
X-Google-Smtp-Source: ABdhPJxkDPWtQ0xY3VDDd1hdruQ8+H5GEjOzabJ81Rv/cCTbHLoq+vApHQul7qsNmbmUkHWACC7bpPpeUJc3TjZuEfs=
X-Received: by 2002:a17:907:2111:: with SMTP id qn17mr370152ejb.525.1610051742082;
 Thu, 07 Jan 2021 12:35:42 -0800 (PST)
MIME-Version: 1.0
References: <20210105045735.1709825-1-jeremy.linton@arm.com>
 <CAL_JsqL2ZXrTg9VFwGK4CawvyBbnHehF9W=cgVEJPzCRoM5G9g@mail.gmail.com>
 <bdd563a9-c8d4-307b-617c-139dda3e4984@arm.com> <CAL_Jsq+OUX2ctFwiqcQtM=oswyz8s-iq94eHW247sabYYF5B-A@mail.gmail.com>
 <5d4f85a4-248b-b62e-f976-63c6214bf588@arm.com>
In-Reply-To: <5d4f85a4-248b-b62e-f976-63c6214bf588@arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 7 Jan 2021 13:35:30 -0700
X-Gmail-Original-Message-ID: <CAL_JsqK6eqAJBmC2Txb3GGaRt+_GL2kdSv1m1tCyx1KBheze_w@mail.gmail.com>
Message-ID: <CAL_JsqK6eqAJBmC2Txb3GGaRt+_GL2kdSv1m1tCyx1KBheze_w@mail.gmail.com>
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

On Thu, Jan 7, 2021 at 12:45 PM Jeremy Linton <jeremy.linton@arm.com> wrote=
:
>
> Hi,
>
> On 1/7/21 11:36 AM, Rob Herring wrote:
> > On Thu, Jan 7, 2021 at 9:24 AM Jeremy Linton <jeremy.linton@arm.com> wr=
ote:
> >>
> >> Hi,
> >>
> >>
> >> On 1/7/21 9:28 AM, Rob Herring wrote:
> >>> On Mon, Jan 4, 2021 at 9:57 PM Jeremy Linton <jeremy.linton@arm.com> =
wrote:
> >>>>
> >>>> Given that most arm64 platform's PCI implementations needs quirks
> >>>> to deal with problematic config accesses, this is a good place to
> >>>> apply a firmware abstraction. The ARM PCI SMMCCC spec details a
> >>>> standard SMC conduit designed to provide a simple PCI config
> >>>> accessor. This specification enhances the existing ACPI/PCI
> >>>> abstraction and expects power, config, etc functionality is handled
>
> (trimming)
>
> >>>>
> >>>> +static int smccc_pcie_check_conduit(u16 seg)
> >>>
> >>> check what? Based on how you use this, perhaps _has_conduit() instead=
.
> >>
> >> Sure.
> >>
> >>>
> >>>> +{
> >>>> +       struct arm_smccc_res res;
> >>>> +
> >>>> +       if (arm_smccc_1_1_get_conduit() =3D=3D SMCCC_CONDUIT_NONE)
> >>>> +               return -EOPNOTSUPP;
> >>>> +
> >>>> +       arm_smccc_smc(SMCCC_PCI_VERSION, 0, 0, 0, 0, 0, 0, 0, &res);
> >>>> +       if ((int)res.a0 < 0)
> >>>> +               return -EOPNOTSUPP;
> >>>> +
> >>>> +       arm_smccc_smc(SMCCC_PCI_SEG_INFO, seg, 0, 0, 0, 0, 0, 0, &re=
s);
> >>>> +       if ((int)res.a0 < 0)
> >>>> +               return -EOPNOTSUPP;
> >>>
> >>> Don't you need to check that read and write functions are supported?
> >>
> >> In theory no, the first version of the specification makes them
> >> mandatory for all implementations. There isn't a partial access method=
,
> >> so nothing works if only read or write were implemented.
> >
> > Then the spec should change:
> >
> > 2.3.3 Caller responsibilities
> > The caller has the following responsibilities:
> > =E2=80=A2 The caller must ensure that this function is implemented befo=
re
> > issuing a call. This function is discoverable
> > by calling PCI_FEATURES with pci_func_id set to 0x8400_0132.
> >
> >
> > I guess knowing the version is ensuring, but the 2nd sentence makes it
> > seem that is how one should ensure.
>
> Ok, yes i understand, I will add the check.
>
> >
> > Related, are there any sort of tests for the interface? I generally
> > don't think the kernel's job is validating firmware (a frequent topic
> > for DT), but we should have something. Maybe an SMC unittest module?
> > If nothing else, seems like we should have at least one PCI_FEATURES
> > call to make sure it works. We don't want to add it later only to find
> > that it breaks on some firmware implementations. Though we can just
> > add firmware quirks. ;)
>
> I'm not aware of any unit tests at the moment. My testing so far has
> been against these patches:
> https://review.trustedfirmware.org/q/topic:"Arm_PCI_Config_Space_Interfac=
e"
>
> But given the next version does the PCI_FEATURES calls, that will
> satisfy your concern, right?

Somewhat, but that doesn't replace the need for unittests. We have
PSCI checker, maybe the same thing should be required here. Otherwise,
implementations will only be as good as what Linux currently expects.

Rob
