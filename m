Return-Path: <linux-pci+bounces-10085-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E675B92D4B4
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 17:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D3B128624F
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 15:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FFF194090;
	Wed, 10 Jul 2024 15:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LewGopmc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B4719306A
	for <linux-pci@vger.kernel.org>; Wed, 10 Jul 2024 15:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720624162; cv=none; b=XRWHtGrCX8ioSOZjhuxyUkCrA3kQFi/PrTJTZ3YjnMTaFlR0Kuc77Vr58Sx0lKFLaRYZGv6o+msjD2A5orpyESpN1C/oSQ9a3/JTwKfde0tpDASAxfpwEcmKMimqvmwZ+Y1FzJUeyMJBlZQGR6YBSQKXifxmsHdUaiXmBdnZb5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720624162; c=relaxed/simple;
	bh=W5Qb+dcqh4oCAFNgsrRCVEZ0CxssIgHT2pXbyWol0+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VasGqs1/xTd76FeRLDm5HpSgDY1wyX685jturAQWGNzzouHwR0fi7lqSE1P0dZt3VLlyZUBOtStciB/GyqWr+ddyEI0Ngc/hMn/Zw5/3u9x66B9PPk3srtbGLb8ckelkJ4vRGzGd9V1EDD7LFm0/Qt5aC3l77g7QLRIEx4WE5R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LewGopmc; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-595856e2332so2313956a12.1
        for <linux-pci@vger.kernel.org>; Wed, 10 Jul 2024 08:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720624159; x=1721228959; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4XAx6Sn0YTFV2cc6+dOGYCTHn11SvsaL/idVw9oChw8=;
        b=LewGopmcKMbQpL8XEbpA/6RWERE63PoQ88EQIloCQ2RazFusZFbsoLU6zR/V/Wf7UL
         697gP3ghhmXSTQ4cZOGgIpLZUXg0CF43fm6PCuxbSIUZHcEou34DmtJ/nZHS41o342KN
         aP8b4Dggwn3XvsUGFREneVP+hYsRxWRujJn20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720624159; x=1721228959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4XAx6Sn0YTFV2cc6+dOGYCTHn11SvsaL/idVw9oChw8=;
        b=ViqGFV5/gEZ+lVHLUvz4gvRHgFgLeYGqCuk+nxozzZre+Q13tBQD80VDnHztw0xkFE
         J82bRfHpzz7Mrpp6qzSKt0yR42aFvi0mmzn4tUI4ENhRrLK/bfxNmzGemKWuvGBcxbVy
         UuwzohkR7I0AGiQI+12I+wlTW3qgB4XhktI7eG3WQLDZ5hbGUYXQrMBl9ViCsz2Vt+WC
         T3xCCP7CDNbFW9M5R/h647KlIl4DeTIDsA/R99UOIm0FPtJJcXwiqaDVAJWm9W70vwI4
         gg2wW5uImLjlROug5QDEEqbms+YTyaXjfsXHFp7d5yiwNwYmWLDFsgKkrb0/UKPx6T17
         Dk6w==
X-Forwarded-Encrypted: i=1; AJvYcCW3dpkz4Tzop+wXd/RNWo8IxH8FW7KmTud++8QE606gb9MmTGOPD86HnQ7q5ottIKCQvuxIGsg5UhHLOC5FS8wnXBTf7PnoeCV1
X-Gm-Message-State: AOJu0YyQcHGaf0bqIhBTOt+Sjy5W+SAgItXI1M0iYn7ot0Ccio65e4SN
	S9im/YYhUaUQNYIKj6i66lT+/uyMCzj5Ht/Sln5yjKRTRch8MdfaC/IP8NsHG9JDxT9JgcmTzzP
	g5NHcjNtWQne1RqQsPqVOtSZPQRhpNcllDqSD
X-Google-Smtp-Source: AGHT+IFkoATHPds5XCsl0LyzFdirEBfxh7cRVDWfNpPEtYmJFTd/OoyhW7vOVd1mE4GxBjfB4T1thnbWKxCJcwZz/mE=
X-Received: by 2002:a17:906:3710:b0:a77:cf9d:f49b with SMTP id
 a640c23a62f3a-a780b8802fbmr359916566b.54.1720624159129; Wed, 10 Jul 2024
 08:09:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708172339.GA139099@bhelgaas> <e1ed82cb-6d20-4ca8-b047-4a02dde115a8@gmail.com>
In-Reply-To: <e1ed82cb-6d20-4ca8-b047-4a02dde115a8@gmail.com>
From: George-Daniel Matei <danielgeorgem@chromium.org>
Date: Wed, 10 Jul 2024 17:09:08 +0200
Message-ID: <CACfW=qpNmSeQVG_qSeYpEdk9pf_RTAEEKp+OiBYrRFd3d6HOXg@mail.gmail.com>
Subject: Re: [PATCH] PCI: r8169: add suspend/resume aspm quirk
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, nic_swsd@realtek.com, netdev@vger.kernel.org, 
	Bjorn Helgaas <helgaas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

>> Added aspm suspend/resume hooks that run
>> before and after suspend and resume to change
>> the ASPM states of the PCI bus in order to allow
>> the system suspend while trying to prevent card hangs
>
> Why is this needed?  Is there a r8169 defect we're working around?
> A BIOS defect?  Is there a problem report you can reference here?
>

We encountered this issue while upgrading from kernel v6.1 to v6.6.
The system would not suspend with 6.6. We tracked down the problem to
the NIC of the device, mainly that the following code was removed in
6.6:
> else if (tp->mac_version >=3D RTL_GIGA_MAC_VER_46)
>         rc =3D pci_disable_link_state(pdev, PCIE_LINK_STATE_L1_2);
For the listed devices, ASPM L1 is disabled entirely in 6.6. As for
the reason, L1 was observed to cause some problems
(https://bugzilla.kernel.org/show_bug.cgi?id=3D217814). We use a Raptor
Lake soc and it won't change residency if the NIC doesn't have L1
enabled. I saw in 6.1 the following comment:
> Chips from RTL8168h partially have issues with L1.2, but seem
> to work fine with L1 and L1.1.
I was thinking that disabling/enabling L1.1 on the fly before/after
suspend could help mitigate the risk associated with L1/L1.1 . I know
that ASPM settings are exposed in sysfs and that this could be done
from outside the kernel, that was my first approach, but it was
suggested to me that this kind of workaround would be better suited
for quirks. I did around 1000 suspend/resume cycles of 16-30 seconds
each (correcting the resume dev->bus->self being configured twice
mistake) and did not notice any problems. What do you think, is this a
good approach ... ?

>> +             //configure device
>> +             pcie_capability_clear_and_set_word(dev, PCI_EXP_LNKCTL,
>> +                                                PCI_EXP_LNKCTL_ASPMC, 0=
);
>> +
>> +             pci_read_config_word(dev->bus->self,
>> +                                  dev->bus->self->l1ss + PCI_L1SS_CTL1,
>> +                                  &val);
>> +             val =3D val & ~PCI_L1SS_CTL1_L1SS_MASK;
>> +             pci_write_config_word(dev->bus->self,
>> +                                   dev->bus->self->l1ss + PCI_L1SS_CTL1=
,
>> +                                   val);
> Updates the parent (dev->bus->self) twice; was the first one supposed
> to update the device (dev)?
Yes, it was supposed to update the device (dev). It's my first time
sending a patch and I messed something up while doing some style
changes, I will correct it. I'm sorry for that.

> This doesn't restore the state as it existed before suspend.  Does
> this rely on other parts of restore to do that?
It operates on the assumption that after driver initialization
PCI_EXP_LNKCTL_ASPMC is 0 and that there are no states enabled in
CTL1. I did a lspci -vvv dump on the affected devices before and after
the quirks ran and saw no difference. This could be improved.

> What is the RTL8168 chip version used on these systems?
It should be RTL8111H.

> What's the root cause of the issue?
> A silicon bug on the host side?
I think it's the ASPM implementation of the soc.

> ASPM L1 is disabled per default in r8169. So why is the patch needed
> at all?
Leaving it disabled all the time prevents the system from suspending.

Thank you,
George-Daniel Matei





On Tue, Jul 9, 2024 at 12:15=E2=80=AFAM Heiner Kallweit <hkallweit1@gmail.c=
om> wrote:
>
> On 08.07.2024 19:23, Bjorn Helgaas wrote:
> > [+cc r8169 folks]
> >
> > On Mon, Jul 08, 2024 at 03:38:15PM +0000, George-Daniel Matei wrote:
> >> Added aspm suspend/resume hooks that run
> >> before and after suspend and resume to change
> >> the ASPM states of the PCI bus in order to allow
> >> the system suspend while trying to prevent card hangs
> >
> > Why is this needed?  Is there a r8169 defect we're working around?
> > A BIOS defect?  Is there a problem report you can reference here?
> >
>
> Basically the same question from my side. Apparently such a workaround
> isn't needed on any other system. And Realtek NICs can be found on more
> or less every consumer system. What's the root cause of the issue?
> A silicon bug on the host side?
>
> What is the RTL8168 chip version used on these systems?
>
> ASPM L1 is disabled per default in r8169. So why is the patch needed
> at all?
>
> > s/Added/Add/
> >
> > s/aspm/ASPM/ above
> >
> > s/PCI bus/device and parent/
> >
> > Add period at end of sentence.
> >
> > Rewrap to fill 75 columns.
> >
> >> Signed-off-by: George-Daniel Matei <danielgeorgem@chromium.org>
> >> ---
> >>  drivers/pci/quirks.c | 142 ++++++++++++++++++++++++++++++++++++++++++=
+
> >>  1 file changed, 142 insertions(+)
> >>
> >> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> >> index dc12d4a06e21..aa3dba2211d3 100644
> >> --- a/drivers/pci/quirks.c
> >> +++ b/drivers/pci/quirks.c
> >> @@ -6189,6 +6189,148 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, =
0x56b0, aspm_l1_acceptable_latency
> >>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56b1, aspm_l1_accepta=
ble_latency);
> >>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c0, aspm_l1_accepta=
ble_latency);
> >>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c1, aspm_l1_accepta=
ble_latency);
> >> +
> >> +static const struct dmi_system_id chromebox_match_table[] =3D {
> >> +    {
> >> +            .matches =3D {
> >> +                    DMI_MATCH(DMI_PRODUCT_NAME, "Brask"),
> >> +                    DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
> >> +            }
> >> +    },
> >> +    {
> >> +            .matches =3D {
> >> +                    DMI_MATCH(DMI_PRODUCT_NAME, "Aurash"),
> >> +                    DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
> >> +            }
> >> +    },
> >> +            {
> >> +            .matches =3D {
> >> +                    DMI_MATCH(DMI_PRODUCT_NAME, "Bujia"),
> >> +                    DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
> >> +            }
> >> +    },
> >> +    {
> >> +            .matches =3D {
> >> +                    DMI_MATCH(DMI_PRODUCT_NAME, "Gaelin"),
> >> +                    DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
> >> +            }
> >> +    },
> >> +    {
> >> +            .matches =3D {
> >> +                    DMI_MATCH(DMI_PRODUCT_NAME, "Gladios"),
> >> +                    DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
> >> +            }
> >> +    },
> >> +    {
> >> +            .matches =3D {
> >> +                    DMI_MATCH(DMI_PRODUCT_NAME, "Hahn"),
> >> +                    DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
> >> +            }
> >> +    },
> >> +    {
> >> +            .matches =3D {
> >> +                    DMI_MATCH(DMI_PRODUCT_NAME, "Jeev"),
> >> +                    DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
> >> +            }
> >> +    },
> >> +    {
> >> +            .matches =3D {
> >> +                    DMI_MATCH(DMI_PRODUCT_NAME, "Kinox"),
> >> +                    DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
> >> +            }
> >> +    },
> >> +    {
> >> +            .matches =3D {
> >> +                    DMI_MATCH(DMI_PRODUCT_NAME, "Kuldax"),
> >> +                    DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
> >> +            }
> >> +    },
> >> +    {
> >> +            .matches =3D {
> >> +                    DMI_MATCH(DMI_PRODUCT_NAME, "Lisbon"),
> >> +                    DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
> >> +            }
> >> +    },
> >> +    {
> >> +                    .matches =3D {
> >> +                    DMI_MATCH(DMI_PRODUCT_NAME, "Moli"),
> >> +                    DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
> >> +            }
> >> +    },
> >> +    { }
> >> +};
> >> +
> >> +static void rtl8169_suspend_aspm_settings(struct pci_dev *dev)
> >> +{
> >> +    u16 val =3D 0;
> >> +
> >> +    if (dmi_check_system(chromebox_match_table)) {
> >> +            //configure parent
> >> +            pcie_capability_clear_and_set_word(dev->bus->self,
> >> +                                               PCI_EXP_LNKCTL,
> >> +                                               PCI_EXP_LNKCTL_ASPMC,
> >> +                                               PCI_EXP_LNKCTL_ASPM_L1=
);
> >> +
> >> +            pci_read_config_word(dev->bus->self,
> >> +                                 dev->bus->self->l1ss + PCI_L1SS_CTL1=
,
> >> +                                 &val);
> >> +            val =3D (val & ~PCI_L1SS_CTL1_L1SS_MASK) |
> >> +                  PCI_L1SS_CTL1_PCIPM_L1_2 | PCI_L1SS_CTL1_PCIPM_L1_2=
 |
> >> +                  PCI_L1SS_CTL1_ASPM_L1_1;
> >> +            pci_write_config_word(dev->bus->self,
> >> +                                  dev->bus->self->l1ss + PCI_L1SS_CTL=
1,
> >> +                                  val);
> >> +
> >> +            //configure device
> >> +            pcie_capability_clear_and_set_word(dev, PCI_EXP_LNKCTL,
> >> +                                               PCI_EXP_LNKCTL_ASPMC,
> >> +                                               PCI_EXP_LNKCTL_ASPM_L1=
);
> >> +
> >> +            pci_read_config_word(dev, dev->l1ss + PCI_L1SS_CTL1, &val=
);
> >> +            val =3D (val & ~PCI_L1SS_CTL1_L1SS_MASK) |
> >> +                  PCI_L1SS_CTL1_PCIPM_L1_2 | PCI_L1SS_CTL1_PCIPM_L1_2=
 |
> >> +                  PCI_L1SS_CTL1_ASPM_L1_1;
> >> +            pci_write_config_word(dev, dev->l1ss + PCI_L1SS_CTL1, val=
);
> >> +    }
> >> +}
> >> +
> >> +DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_REALTEK, 0x8168,
> >> +                      rtl8169_suspend_aspm_settings);
> >> +
> >> +static void rtl8169_resume_aspm_settings(struct pci_dev *dev)
> >> +{
> >> +    u16 val =3D 0;
> >> +
> >> +    if (dmi_check_system(chromebox_match_table)) {
> >> +            //configure device
> >> +            pcie_capability_clear_and_set_word(dev, PCI_EXP_LNKCTL,
> >> +                                               PCI_EXP_LNKCTL_ASPMC, =
0);
> >> +
> >> +            pci_read_config_word(dev->bus->self,
> >> +                                 dev->bus->self->l1ss + PCI_L1SS_CTL1=
,
> >> +                                 &val);
> >> +            val =3D val & ~PCI_L1SS_CTL1_L1SS_MASK;
> >> +            pci_write_config_word(dev->bus->self,
> >> +                                  dev->bus->self->l1ss + PCI_L1SS_CTL=
1,
> >> +                                  val);
> >> +
> >> +            //configure parent
> >> +            pcie_capability_clear_and_set_word(dev->bus->self,
> >> +                                               PCI_EXP_LNKCTL,
> >> +                                               PCI_EXP_LNKCTL_ASPMC, =
0);
> >> +
> >> +            pci_read_config_word(dev->bus->self,
> >> +                                 dev->bus->self->l1ss + PCI_L1SS_CTL1=
,
> >> +                                 &val);
> >> +            val =3D val & ~PCI_L1SS_CTL1_L1SS_MASK;
> >> +            pci_write_config_word(dev->bus->self,
> >> +                                  dev->bus->self->l1ss + PCI_L1SS_CTL=
1,
> >> +                                  val);
> >
> > Updates the parent (dev->bus->self) twice; was the first one supposed
> > to update the device (dev)?
> >
> > This doesn't restore the state as it existed before suspend.  Does
> > this rely on other parts of restore to do that?
> >
> >> +    }
> >> +}
> >> +
> >> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_REALTEK, 0x8168,
> >> +                     rtl8169_resume_aspm_settings);
> >>  #endif
> >>
> >>  #ifdef CONFIG_PCIE_DPC
> >> --
> >> 2.45.2.803.g4e1b14247a-goog
> >>
>

