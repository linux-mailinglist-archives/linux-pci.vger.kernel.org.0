Return-Path: <linux-pci+bounces-43113-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A45AFCC416D
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 17:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87FD3308861B
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 15:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E758342CB3;
	Tue, 16 Dec 2025 11:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j2vD1Uj4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEEE342C99
	for <linux-pci@vger.kernel.org>; Tue, 16 Dec 2025 11:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765885468; cv=none; b=XLfUV7LCRXA9/CJoxzLNS8WHoaiV4ZcQi6sw5J+9sVaecIQWBBYhAGfdWfEnVHMsMAZzB8VsgBcFR19Fge8+taxBO3B5lJsxh1ZSPQril2EvrXmNLm0lF4RYYo7MVk9Z89iMec9anJ75qSAcVKCuOjFJbhRaGlqbW63wuyqhNTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765885468; c=relaxed/simple;
	bh=V+Ig9wtQvBhFyj5MsDMbxlNrXbL15A3XOBp08Hy+2P4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lqqtw46U9p1/Z2Jmb/xptLBVzuZBnIR8Z50e8LoDzRf4dEKO4lChiq581bIlUAcOecpfNROxlbT99loTThiKe14ENemJpKGbU3B7C5nCEhsrNKpMbz/tKo3xRw8PBrrHDCaNPXQTqNx/0eeskfETV/wYbDHZwnu6IsWHwVtjsKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j2vD1Uj4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99948C4CEF5
	for <linux-pci@vger.kernel.org>; Tue, 16 Dec 2025 11:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765885467;
	bh=V+Ig9wtQvBhFyj5MsDMbxlNrXbL15A3XOBp08Hy+2P4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=j2vD1Uj4KjqjJgf/wUtgZploDmbNusAmdaa7uYk+rmKl72AkrPsozoGnFn+YoZxkx
	 8wRggwYK7txNf2+DhQtF8lyo7Ie7P4c19sk1BkAq3XgucReaT0PdjBO5l8RbodX7fL
	 GFQgE0kqD5Gc0tNF2RDE6/rDc1wIzjWQ0aDbYcPH64vrUQU3q01Jja+WjayXXyAqKr
	 rqdgcT/JaDGJX8Cfu6apx2OntdsljC4wk4Fm5VQnGsw6kzD3pUwI68ltXJBtwJXOhI
	 JHv3TUTlSVUF6LKxi22gp45SnrvWKgdIJGjI/cbIJkM1AMmlQBCmbI8qu37OV27X72
	 4OLWn+CTNKq+A==
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7c6dbdaced8so3696256a34.1
        for <linux-pci@vger.kernel.org>; Tue, 16 Dec 2025 03:44:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXjjX7/EG2u5pdrArPaS+qQdteYuuByTaq3q8jxAiBj+0TosdsByf0e7ST91LI7qWTe8YhBJQ5+FEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxikAuh7fqN73FT8vDEvFBuAHaQL3B8eEeB49pdYcZQqT89xgw
	WPdJxZDtxngszy3+qlYqMuf3Lxo7Ynz8Z8/elp53EVNjYfabMEgu81QDzKKrqrKoMADBAdmVI/T
	PyegFpYytz78JdRuiewR9jx0F8mnJ1io=
X-Google-Smtp-Source: AGHT+IG6tA39ggKCdpQ17QbCNI/UgIcN/dbkX4W4xcxXgNTAFB3r0qXtcBurU159VWm12DcnuqkxokrQ2ps15Vegi2w=
X-Received: by 2002:a05:6820:f02e:b0:659:9a49:8ef9 with SMTP id
 006d021491bc7-65b4511f800mr6549417eaf.10.1765885466645; Tue, 16 Dec 2025
 03:44:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7888874.EvYhyI6sBW@rafael.j.wysocki> <9550709.CDJkKcVGEf@rafael.j.wysocki>
 <eca84784-c96a-4666-8f12-b0e6b70dbf76@amd.com>
In-Reply-To: <eca84784-c96a-4666-8f12-b0e6b70dbf76@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 16 Dec 2025 12:44:15 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jTktnW9Ju==n+9BQ0EvFiipOc8JGm=wq0fuFhwMNJhJA@mail.gmail.com>
X-Gm-Features: AQt7F2pScLWfpiRnBIsWsBtCkb905nidRrcY5HfSu1F-SbqZdiwxgQ97QhcCDUk
Message-ID: <CAJZ5v0jTktnW9Ju==n+9BQ0EvFiipOc8JGm=wq0fuFhwMNJhJA@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] ACPI: PNP: Drop PNP0C01 and PNP0C02 from acpi_pnp_device_ids[]
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Chen Yu <yu.c.chen@intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Linux PCI <linux-pci@vger.kernel.org>, 
	Alex Hung <alexhung@gmail.com>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	platform-driver-x86@vger.kernel.org, AceLan Kao <acelan.kao@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2025 at 10:18=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 12/15/25 7:34 AM, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > There is a long-standing problem with ACPI device enumeration that
> > if the given device has a compatible ID which is one of the generic
> > system resource device IDs (PNP0C01 and PNP0C02), it will be claimed
> > by the PNP scan handler and it will not be represented as a platform
> > device, so it cannot be handled by a platform driver.
> >
> > Drivers have been working around this issue by "manually" creating
> > platform devices that they can bind to (see the Intel HID driver for
> > one example) or adding their device IDs to acpi_nonpnp_device_ids[].
> > None of the above is particularly clean though and the only reason why
> > the PNP0C01 and PNP0C02 device IDs are present in acpi_pnp_device_ids[]
> > is to allow the legacy PNP system driver to bind to those devices and
> > reserve their resources so they are not used going forward.
> >
> > Obviously, to address this problem PNP0C01 and PNP0C02 need to be
> > dropped from acpi_pnp_device_ids[], but doing so without making any
> > other changes would be problematic because the ACPI core would then
> > create platform devices for the generic system resource device objects
> > and that would not work on all systems for two reasons.  First, the
> > PNP system driver explicitly avoids reserving I/O resources below the
> > "standard PC hardware" boundary, 0x100, to avoid conflicts in that rang=
e
> > (one possible case when this may happen is when the CMOS RTC driver is
> > involved), but the platform device creation code does not do that.
> > Second, there may be resource conflicts between the "system" devices an=
d
> > the other devices in the system, possibly including conflicts with PCI
> > BARs.  Registering the PNP system driver via fs_initcall() helps to
> > manage those conflicts, even though it does not make them go away.
> > Resource conflicts during the registration of "motherboard resources"
> > that occur after PCI has claimed BARs are harmless as a rule and do
> > not need to be addressed in any specific way.
> >
> > To overcome the issues mentioned above, use the observation that it
> > is not actually necessary to create any device objects in addition
> > to struct acpi_device ones in order to reserve the "system" device
> > resources because that can be done directly in the ACPI device
> > enumeration code.
> >
> > Namely, modify acpi_default_enumeration() to add the given ACPI device
> > object to a special "system devices" list if its _HID is either PNP0C01
> > or PNP0C02 without creating a platform device for it.  Next, add a new
> > special acpi_scan_claim_resources() function that will be run via
> > fs_initcall() and will walk that list and reserve resources for each
> > device in it along the lines of what the PNP system driver does.
> >
> > Having made the above changes, drop PNP0C01 and PNP0C02 from
> > acpi_pnp_device_ids[] which will allow platform devices to be created
> > for ACPI device objects whose _CID lists contain PNP0C01 or PNP0C02,
> > but the _HID is not in acpi_pnp_device_ids[].
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >   drivers/acpi/acpi_pnp.c |    2
> >   drivers/acpi/scan.c     |  115 ++++++++++++++++++++++++++++++++++++++=
++++++++--
> >   2 files changed, 111 insertions(+), 6 deletions(-)
> >
> > --- a/drivers/acpi/acpi_pnp.c
> > +++ b/drivers/acpi/acpi_pnp.c
> > @@ -126,8 +126,6 @@ static const struct acpi_device_id acpi_
> >       /* apple-gmux */
> >       {"APP000B"},
> >       /* system */
>
> It might be a little bit confusing to have a comment for /* system */
> still here but have dropped all the IDs that previously corresponded to i=
t.
>
> Maybe lose the comment too?

Sure, missed that.  I'll remove it when applying the patch.

> > -     {"PNP0c02"},            /* General ID for reserving resources */
> > -     {"PNP0c01"},            /* memory controller */
> >       /* rtc_cmos */
> >       {"PNP0b00"},
> >       {"PNP0b01"},
> > --- a/drivers/acpi/scan.c
> > +++ b/drivers/acpi/scan.c
> > @@ -42,6 +42,7 @@ static LIST_HEAD(acpi_scan_handlers_list
> >   DEFINE_MUTEX(acpi_device_lock);
> >   LIST_HEAD(acpi_wakeup_device_list);
> >   static DEFINE_MUTEX(acpi_hp_context_lock);
> > +static LIST_HEAD(acpi_scan_system_dev_list);
> >
> >   /*
> >    * The UART device described by the SPCR table is the only object whi=
ch needs
> > @@ -2203,19 +2204,48 @@ static acpi_status acpi_bus_check_add_2(
> >       return acpi_bus_check_add(handle, false, (struct acpi_device **)r=
et_p);
> >   }
> >
> > +struct acpi_scan_system_dev {
> > +     struct list_head node;
> > +     struct acpi_device *adev;
> > +};
> > +
> > +static const char * const acpi_system_dev_ids[] =3D {
> > +     "PNP0C01", /* Memory controller */
> > +     "PNP0C02", /* Motherboard resource */
> > +     NULL
> > +};
> > +
> >   static void acpi_default_enumeration(struct acpi_device *device)
> >   {
> >       /*
> >        * Do not enumerate devices with enumeration_by_parent flag set a=
s
> >        * they will be enumerated by their respective parents.
> >        */
> > -     if (!device->flags.enumeration_by_parent) {
> > -             acpi_create_platform_device(device, NULL);
> > -             acpi_device_set_enumerated(device);
> > -     } else {
> > +     if (device->flags.enumeration_by_parent) {
> >               blocking_notifier_call_chain(&acpi_reconfig_chain,
> >                                            ACPI_RECONFIG_DEVICE_ADD, de=
vice);
> > +             return;
> >       }
> > +     if (match_string(acpi_system_dev_ids, -1, acpi_device_hid(device)=
) >=3D 0) {
> > +             struct acpi_scan_system_dev *sd;
> > +
> > +             /*
> > +              * This is a generic system device, so there is no need t=
o
> > +              * create a platform device for it, but its resources nee=
d to be
> > +              * reserved.  However, that needs to be done after all of=
 the
> > +              * other device objects have been processed and PCI has c=
laimed
> > +              * BARs in case there are resource conflicts.
> > +              */
> > +             sd =3D kmalloc(sizeof(*sd), GFP_KERNEL);
> > +             if (sd) {
> > +                     sd->adev =3D device;
> > +                     list_add_tail(&sd->node, &acpi_scan_system_dev_li=
st);
> > +             }
> > +     } else {
> > +             /* For a regular device object, create a platform device.=
 */
> > +             acpi_create_platform_device(device, NULL);
> > +     }
> > +     acpi_device_set_enumerated(device);
> >   }
> >
> >   static const struct acpi_device_id generic_device_ids[] =3D {
> > @@ -2571,6 +2601,83 @@ static void acpi_scan_postponed(void)
> >       mutex_unlock(&acpi_dep_list_lock);
> >   }
> >
> > +static void acpi_scan_claim_resources(struct acpi_device *adev)
> > +{
> > +     struct list_head resource_list =3D LIST_HEAD_INIT(resource_list);
> > +     struct resource_entry *rentry;
> > +     unsigned int count =3D 0;
> > +     const char *regionid;
> > +
> > +     if (acpi_dev_get_resources(adev, &resource_list, NULL, NULL) <=3D=
 0)
> > +             return;
> > +
> > +     regionid =3D kstrdup(dev_name(&adev->dev), GFP_KERNEL);
> > +     if (!regionid)
> > +             goto exit;
> > +
> > +     list_for_each_entry(rentry, &resource_list, node) {
> > +             struct resource *res =3D rentry->res;
> > +             struct resource *r;
> > +
> > +             /* Skip disabled and invalid resources. */
> > +             if ((res->flags & IORESOURCE_DISABLED) || res->end < res-=
>start)
> > +                     continue;
> > +
> > +             if (res->flags & IORESOURCE_IO) {
> > +                     /*
> > +                      * Follow the PNP system driver and on x86 skip I=
/O
> > +                      * resources that start below 0x100 (the "standar=
d PC
> > +                      * hardware" boundary).
> > +                      */
> > +                     if (IS_ENABLED(CONFIG_X86) && res->start < 0x100)=
 {
> > +                             dev_info(&adev->dev, "Skipped %pR\n", res=
);
> > +                             continue;
> > +                     }
> > +                     r =3D request_region(res->start, resource_size(re=
s), regionid);
> > +             } else if (res->flags & IORESOURCE_MEM) {
> > +                     r =3D request_mem_region(res->start, resource_siz=
e(res), regionid);
> > +             } else {
> > +                     continue;
> > +             }
> > +
> > +             if (r) {
> > +                     r->flags &=3D ~IORESOURCE_BUSY;
> > +                     dev_info(&adev->dev, "Reserved %pR\n", r);
> > +                     count++;
> > +             } else {
> > +                     dev_info(&adev->dev, "Could not reserve %pR\n", r=
es);
>
> Shouldn't this be louder?  Like warn?  Or do you think there will be
> normal conditions we see this happening?

This happens on all systems I have, so ...

Also the PNP system driver doesn't make a fuss about this, but I may
as well copy the relevant comment from there to here.

