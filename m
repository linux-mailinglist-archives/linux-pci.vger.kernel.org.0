Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 704F947B84C
	for <lists+linux-pci@lfdr.de>; Tue, 21 Dec 2021 03:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbhLUCP3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Dec 2021 21:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbhLUCP2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Dec 2021 21:15:28 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D91C06173E
        for <linux-pci@vger.kernel.org>; Mon, 20 Dec 2021 18:15:28 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id v19so9510840plo.7
        for <linux-pci@vger.kernel.org>; Mon, 20 Dec 2021 18:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=X+5KJ9FrJYpXfb1+tuCUi6hpFU6+4UtQHAwnNGrR4/o=;
        b=KagCj61S1LX4enjBUzsD6fJGJkjFyCdxAOOc9OilFY2u1L6VTwjBkdFdJZNKL9bKqS
         VVK1mfraxHm3cRYauqN+m9HyRLJhdtDLuRZDcVrXvohy1zfINatoyAVzAQl2ohhZ/FkI
         M0D6/YLK6/DHmGT4JD/ZGsOl5+K6T6GP1T4aq71dgraebxpUfwENVFOWDUxoZeHqdHjD
         R3K4a6DQCfavA13Uk6Hh8VT8aR6uRseVOIv/Q21DlSDy5QM/GE693wvI8WgUeL/Dynji
         rhQFxEn5aU6O8iKqI8VDAvSrkOrPZeiYQTgYKP6+h0QwZJnBgz4ZQTaxdh9UIui6X7ks
         Ds/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=X+5KJ9FrJYpXfb1+tuCUi6hpFU6+4UtQHAwnNGrR4/o=;
        b=zZTnZ4oN05cyZTpvns6eDaIVlbCb2mMbfrBg0ia3GteGDDEVb0OAh5mQ6hb4WzuIlK
         6vainbatKOkuP0+3KwTmD0aLlcJTJ1QoFj/TO4nUJC3GjpHCYd2xKHAXMIIE+FNUHiX8
         kcXq7Emb3HvJWU6kjQVZ6UqVOC8HG4rLC8GtaFqJt7d1FLgKQLPPv1/ZvqFwCSpQIv5n
         +LqqTdmobJ+v/3FjTdHHe0v/ZJeQYGF9vCUJRoJzUCvd3iLevsrwPxz/GawpO4lFrWg+
         mxKtzAhKgLM3DkRaF/+HH1tvplGuamrHa1tzTD5ykVpmqEs8vVMc1cDLC/WXVUoGcCLe
         3dtg==
X-Gm-Message-State: AOAM532zQcdS8wgn3r2w4H6OHaqpOmEt+4v7nzGZbUv7JlQaJOjauKij
        sowqkoHJGiDFCmTlj9smDaq5Ks2zJ5suPc76LAPoXg==
X-Google-Smtp-Source: ABdhPJwKm3e9be+Fqg47PD3bhsyNITwsQegdqowooDGUF8BzYrntsDSKbybFuZ0ttGIv0lt1kkxbwY+ch0cFoSVT82Q=
X-Received: by 2002:a17:90b:3716:: with SMTP id mg22mr1169196pjb.173.1640052927425;
 Mon, 20 Dec 2021 18:15:27 -0800 (PST)
MIME-Version: 1.0
References: <20211220172848.GA1006510@bhelgaas> <e87a297cc74cca02fa1a8f5aa9562489a4db26b3.camel@linux.intel.com>
In-Reply-To: <e87a297cc74cca02fa1a8f5aa9562489a4db26b3.camel@linux.intel.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Mon, 20 Dec 2021 18:14:51 -0800
Message-ID: <CACK8Z6F812_DYVr=sxRXxhtPxyCw206U=jW6CFt6T-MyKJXMgQ@mail.gmail.com>
Subject: Re: [PATCH V4 2/2] PCI: vmd: Override ASPM on TGL/ADL VMD devices
To:     david.e.box@linux.intel.com
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        francisco.munoz.ruiz@linux.intel.com, nirmal.patel@linux.intel.com,
        jonathan.derrick@linux.dev, lorenzo.pieralisi@arm.com,
        hch@infradead.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, michael.a.bottini@linux.intel.com,
        rafael@kernel.org, me@adhityamohan.in, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

On Mon, Dec 20, 2021 at 3:06 PM David E. Box
<david.e.box@linux.intel.com> wrote:
>
> Hi Born,
>
> So you know this patch comes from our platform power management team to a=
ddress several VMD bugs
> affecting power. The VMD driver developers are already cc'd but also addi=
ng Francisco from the VMD
> team who can maybe help clarify.
>
> On Mon, 2021-12-20 at 11:28 -0600, Bjorn Helgaas wrote:
> > On Thu, Dec 16, 2021 at 01:24:00PM -0800, David E. Box wrote:
> > > On Thu, 2021-12-16 at 11:26 -0600, Bjorn Helgaas wrote:
> > > > On Wed, Dec 15, 2021 at 09:56:00PM -0800, David E. Box wrote:
> > > > > From: Michael Bottini <michael.a.bottini@linux.intel.com>
> > > > >
> > > > > On Tiger Lake and Alder Lake platforms, VMD controllers do not ha=
ve ASPM
> > > > > enabled nor LTR values set by BIOS. This leads high power consump=
tion on
> > > > > these platforms when VMD is enabled as reported in bugzilla [1]. =
 Enable
> > > > > these features in the VMD driver using pcie_aspm_policy_override(=
) to set
> > > > > the ASPM policy for the root ports.
> > > > > ...
> >
> > > > > To do this, add an additional flag in VMD features to specify
> > > > > devices that must have their respective policies overridden.
> > > >
> > > > I'm not clear on why you want this to apply to only certain VMDs
> > > > and not others.  Do some BIOSes configure ASPM for devices below
> > > > some VMDs?
> > >
> > > Not currently. But the plan is for future devices to move back to
> > > having BIOS do the programming.
> >
> > Since this is apparently a BIOS design choice, it seems wrong to base
> > the functionality on the Device ID instead of some signal that tells
> > us what the BIOS is doing.
>
> I don't know if there is another way to tell what the BIOS is _not_ doing=
. DID is tied to the SoC so
> it's our best method of inferring this. We know the firmware team has sai=
d they will not support
> programming these values for the mentioned platforms so there's no BIOS u=
pdate coming to change
> this.

I'd like to mention here that ChromeOS also runs linux kernel on TGL
and ADL platforms, and we may run a different BIOS altogether, so yes,
we'd greatly appreciate if you do not assume BIOS setting from device
ID / SOC ID, if the setting is *not tied to device ID / SOC ID*.
Perhaps you use ACPI or device trees to convey what BIOS has or hasn't
configured?

> But to be sure, we can add a check first to confirm that these values hav=
e not been programmed
> (ASPM is disabled and LTRs are 0).

Yes, reading the ASPM configuration from hardware sounds OK to me.

>
> >
> > > > > + * Override the BIOS ASPM policy and set the LTR value for PCI s=
torage
> > > > > + * devices on the VMD bride.
> > > >
> > > > I don't think there's any BIOS "policy" here.  At this point BIOS
> > > > is no longer involved at all, so all that's left is whatever ASPM
> > > > config the BIOS did or did not do.

Should the Policy override really take place if aspm_policy =3D
POLICY_DEFAULT which seems to suggest we leave it to whatever BIOS
left it at?

Perhaps for this override to take place, aspm_policy needs to be the
policy needs to be POLICY_POWERSAVE?

#define POLICY_DEFAULT 0        /* BIOS default setting */
#define POLICY_PERFORMANCE 1    /* high performance */
#define POLICY_POWERSAVE 2      /* high power saving */
#define POLICY_POWER_SUPERSAVE 3 /* possibly even more power saving */


> > > >
> > > > Why only storage?
> > >
> > > Only storage devices will be on these root ports.
> >
> > How do you know this?  You say below that there's an M.2 slot, so
> > surely the slot could contain a non-storage device?  Couldn't somebody
> > build a platform with a VMD root port connected to a regular PCIe x4
> > slot?
>
> In VMD mode the root ports under the VMD bridge are used specifically to =
manage storage devices. So
> only storage devices should be attached to these ports.

Bjorn: from https://www.intel.com/content/www/us/en/architecture-and-techno=
logy/intel-volume-management-device-overview.html
"Intel=C2=AE Volume Management Device (Intel=C2=AE VMD) is specifically des=
igned
for enterprise-grade management of NVMe SSDs connected to Intel=C2=AE Xeon=
=C2=AE
CPUs."

I think what David means is that any other device other than an NVME
SSD showing up under VMD might be an error / bad device.


>
> >   Couldn't such a slot support hotplug?
>
> The answer I just learned is yes. It may be possible to have a switch too=
. So both of those would
> need to be addressed though I'm note quite sure how yet.
>
> >
> > It would be very unusual to hard-code topology knowledge like this
> > into the kernel, since plug-and-play has always been a major goal of
> > PCI.
> >
> > > > > +static int vmd_enable_aspm(struct pci_dev *pdev, void *userdata)
> > > > > +{
> > > > > +       int features =3D *(int *)userdata, pos;
> > > > > +
> > > > > +       if (!(features & VMD_FEAT_QUIRK_OVERRIDE_ASPM) ||
> > > > > +           pdev->class !=3D PCI_CLASS_STORAGE_EXPRESS)
> > > > > +               return 0;
> >
> > > > > +       pci_write_config_word(pdev, pos + PCI_LTR_MAX_SNOOP_LAT, =
0x1003);
> > > > > +       pci_write_config_word(pdev, pos + PCI_LTR_MAX_NOSNOOP_LAT=
, 0x1003);
> > > >
> > > > 1) Where did this magic 0x1003 value come from?  Does that depend
> > > > on the VMD device?  The endpoint?  The circuit design?  The path
> > > > between endpoint and VMD?  What if there are switches in the path?
> > >
> > > The number comes from the BIOS team. They are tied to the SoC. I
> > > don't believe there can be switches in the path but Nirmal and
> > > Jonathan should know for sure. From what I've seen these root ports
> > > are wired directly to M.2 slots on boards that are intended for
> > > storage devices.
> >
> > I guess you're saying that 0x1003 is determined by the SoC.  If so, I
> > think this value should be in your .driver_data (which would mean
> > converting it from a scalar to a struct, as many other drivers do).
> > The current code suggests that 0x1003 is the correct value for *all*
> > VMDs and all configurations.
>
> Okay
>
> >
> > I don't understand LTR well enough to be convinced that this static
> > value would be the correct value for all possible hierarchies and
> > devices that could appear below a VMD root port.  I would love to be
> > educated about this.
>
> I am not an LTR expert either, but LTRs are "conglomerated" per spec. Swi=
tches subtract their own
> latency from the minimum LTR of the downstream ports and report this cong=
lomerated value upstream.
> So the value will decrease as needed to account for latency in the hierar=
chy.
>
> PCI 5.0 Version 1.0, Section 6.18 (pg 611)

As described here and as much as I understand, I think these LTR
values (0x1003 here) depend on the platform topology. So what works
for David's platform may not work for another one that may have
Switched for e.g., or for perhaps for another NVME that is hotplugged
later (and has different characteristics than what is on board).
Technically tying the LTR values to a SOC or VID/DID sounds incorrect
to me, and instead should be tied to the platform. Ideally I *thiink*
they should come from ACPI or device tree. However, I wouldn't protest
putting them in driver_data for now given that there aren't any other
users. We may have to find a solution once there are more platforms
that begin to use this driver. I think this is a bigger problem that
needs to be addressed w.r.t. ASPM in general.

Thanks & Best Regards,

Rajat


>
> Thanks
>
> David
>
> >
> > Bjorn
>
>
