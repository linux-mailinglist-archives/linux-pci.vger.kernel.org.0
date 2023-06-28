Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDBA2740C3A
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jun 2023 11:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236786AbjF1JC0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jun 2023 05:02:26 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:38122
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230403AbjF1ItW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Jun 2023 04:49:22 -0400
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id EE50A3F732
        for <linux-pci@vger.kernel.org>; Wed, 28 Jun 2023 05:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1687929002;
        bh=3bdC+uUyIZz0PgxeLe6K/fSeIXVXdbQUHA0MK3WxvKU=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=pPiHqZEyXktMSy2OoI57sTRe/hyUS9cEaElGEVt4J9JCmAKSJW62l//HnldyRrB2Z
         YMUq6KVGdWsjnyzmgwEKWwC4ua5odQ4Iw3NVR5F56MDV3BM8Bj7tD9q2lGh19tXt6j
         ZSrgVe5Iov+4ZSSiLzIXEAa8kObaZe7TYUVRj2pC/ZuQrNhEn2Xrlo9jZtCx69i6Gk
         Jras8+ux+HS1jOSJa328v5YZOouXOvOkbLQAFRXqF8CZkJK7E9Uy7hioVKlgenCa8o
         V6F4uYvUqUweEg/+KfffBtZxFMCGnFzhc4iiCKtUH/ijr2oWFiHGmyFFoKW9uSPeTJ
         vMGFUn7sxS9jA==
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3a1bcdd0966so4643960b6e.2
        for <linux-pci@vger.kernel.org>; Tue, 27 Jun 2023 22:10:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687929001; x=1690521001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3bdC+uUyIZz0PgxeLe6K/fSeIXVXdbQUHA0MK3WxvKU=;
        b=dWESd7sJsAhZkptQj9Xu6lXQscrTXxNZsEUYREFFkInbe3lDinuslpzZ7deyFOCdzz
         YNK2yJ9wwZkPTjRxP6yO/gNHJPgm7CixEzRVcCpbIAht9FieIXglVR+YR20jcwmEacax
         4axkbjBAq0TN/4HfTEP4i00ZuIGFPwhTZyyryvWCm9oyCmD71h2fT3x/LIv+1AWNCFE0
         jnBYqfYKH8Js8ezY0wL4B7+sPw3qt3O0RQiCT0ljnrwRwk6Tvn5BcaImD6EOwKir3JwT
         bGgbsu8v+UnzzXiUxjstVjQykuWRb5b7uuJBgc8KejS4A+QEYqh09Gf7ggONBlyixUWg
         8oeQ==
X-Gm-Message-State: AC+VfDzRgg3dpaA9ExVeTCNLsgJpp/uTfEYm5EVAZAa1JTwjgXo88RXO
        3SGHRhUe5tiA7l7FuGG7O59okCnw29+akoFQ6sOg0z6kcerjqRDZEWEYzlrkxIR15kCY/SFnCoV
        o0rd6eGdV3Knl5kUz1aihchuNmMtGBzdSvQoeDj40AHMP5Z2/TU4HyA==
X-Received: by 2002:a05:6808:f11:b0:3a0:663d:fd18 with SMTP id m17-20020a0568080f1100b003a0663dfd18mr20647408oiw.57.1687929001322;
        Tue, 27 Jun 2023 22:10:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ42ji0zs3PoUsCX1nWOxZzCYOQcakZVi3alWc7EDIew9NqDWXdRzRhCW/XfEnOwyZd2T3eG1ytrMp03ePtGO48=
X-Received: by 2002:a05:6808:f11:b0:3a0:663d:fd18 with SMTP id
 m17-20020a0568080f1100b003a0663dfd18mr20647388oiw.57.1687929001077; Tue, 27
 Jun 2023 22:10:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAAd53p4kH7E92++jabBhvsM_+M7Dpyk2JP+aoVdb_sxZn47eyQ@mail.gmail.com>
 <20230627205417.GA366405@bhelgaas>
In-Reply-To: <20230627205417.GA366405@bhelgaas>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed, 28 Jun 2023 13:09:49 +0800
Message-ID: <CAAd53p5YjKbOkzBUmhu=EctusO7d38tHhg_b+zzvfVt97hLuOA@mail.gmail.com>
Subject: Re: [PATCH] PCI/ASPM: Enable ASPM on external PCIe devices
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Limonciello, Mario" <mario.limonciello@amd.com>,
        bhelgaas@google.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Michael Bottini <michael.a.bottini@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-wired-lan@osuosl.org,
        "Neftin, Sasha" <sasha.neftin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+Cc Sasha and Intel Wired Lan]

On Wed, Jun 28, 2023 at 4:54=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Tue, Jun 27, 2023 at 04:35:25PM +0800, Kai-Heng Feng wrote:
> > On Fri, Jun 23, 2023 at 7:06=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.o=
rg> wrote:
> > > On Tue, Jun 20, 2023 at 01:36:59PM -0500, Limonciello, Mario wrote:
> > > > <snip>
> > > > > > A variety of Intel chipsets don't support lane width switching
> > > > > > or speed switching.  When ASPM has been enabled on a dGPU,
> > > > > > these features are utilized and breakage ensues.
> > > > >
> > > > > Maybe this helps explain all the completely unmaintainable ASPM
> > > > > garbage in amdgpu and radeon.
> > > > >
> > > > > If these devices are broken, we need quirks for them.
> > > >
> > > > The problem is which device do you consider "broken"?
> > > > The dGPU that uses these features when the platform advertises ASPM
> > > > or the chipset which doesn't support the features that the device
> > > > uses when ASPM is active?
> > > >
> > > > With this problem I'm talking about the dGPU works fine on hosts
> > > > that support these features.
> > >
> > > Without more details about what's broken and when, I can't say.  What
> > > I *think* is that a device that doesn't work per spec needs a quirk.
> > > Typically it's a device that advertises a capability that doesn't wor=
k
> > > correctly.
> >
> > Many silicon vendors use the same "PCI IP" and integrate it into their
> > own chip. That's one of the reason why the capability doesn't really
> > reflect what actually being support.
> > The vendors then send their private datasheet to system integrator so
> > BIOS can enable what's really supported.
>
> It's perfectly fine for the IP to support PCI features that are not
> and can not be enabled in a system design.  But I expect that
> strapping or firmware would disable those features so they are not
> advertised in config space.
>
> If BIOS leaves features disabled because they cannot work, but at the
> same time leaves them advertised in config space, I'd say that's a
> BIOS defect.  In that case, we should have a DMI quirk or something to
> work around the defect.

That means most if not all BIOS are defected.
BIOS vendors and ODM never bothered (and probably will not) to change
the capabilities advertised by config space because "it already works
under Windows".

>
> > So the logic is to ignore the capability and trust the default set
> > by BIOS.
>
> I think limiting ASPM support to whatever BIOS configured at boot-time
> is problematic.  I don't think we can assume that all platforms have
> firmware that configures ASPM as aggressively as possible, and
> obviously firmware won't configure hot-added devices at all (in
> general; I know ACPI _HPX can do some of that).

Totally agree. I was not suggesting to limiting the setting at all.
A boot-time parameter to flip ASPM setting is very useful. If none has
been set, default to BIOS setting.

>
> It's possible we need some kind of policy that limits ASPM to the BIOS
> config until date X, but I don't want to limit that forever.

Desktop can have very different PCIe cards in the slots so BIOS date
isn't a good indicator for ASPM support.
Let alone BIOS date changes on each BIOS upgrade, this means potential
regression risk.

>
> > > > If you follow my idea of hot added devices the policy follows
> > > > the parent would it work for the i225 PCIe device case?
> > >
> > > That doesn't *sound* really robust to me because even if the default
> > > config after hot-add works, the user can change things via sysfs, and
> > > any configuration we set it to should work as well.  If there are
> > > land-mines there, we need a quirk that prevents sysfs from running
> > > into it.
> >
> > For this case it means driver needs to provide a ASPM callback to flip
> > PTM based on ASPM sysfs.
>
> I'm not sure I follow this, but it sounds like you're saying PTM
> doesn't work correctly with some ASPM configurations.  Is this allowed
> by the PCIe spec or is it a hardware defect?  If the latter, maybe we
> just need a quirk to disable PTM on the device.

I'll leave this one to Intel folks.

>
> I'm not sure PTM is valuable enough to add a generic callback
> mechanism to work around a defect in an individual device.

Agree. Right now the issue is only observed when I225 is in a TBT dock.

Kai-Heng

>
> Bjorn
