Return-Path: <linux-pci+bounces-22611-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFD2A48EE9
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 03:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 966D216CE93
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 02:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB795155C97;
	Fri, 28 Feb 2025 02:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kw7X9zWj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F6F14B08C;
	Fri, 28 Feb 2025 02:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740711359; cv=none; b=FrFNIs/C0VtpspsWQz7BXQt73AVAyOtLBmK+H1rfNOXZyDVq0qrbT8ZyVkX0NTLxIJONGtY6Z8KTio5LIJVY6s8RjY4H8S3ai0l3MIMyryorEqvS4xpcR0mtNVPi30FKL6L4i7qGNkt4awkl0MY2TZjnR6pimuauFpsLenBvpfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740711359; c=relaxed/simple;
	bh=I1/xcbFJC3HSyBWc+4j7W30X6O94YSZBulfVFB0oh7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ss9HX6QDD9y7+AE0wqkw+yhiB2ZT97vXHC2nYXbcfeeM/3RQ2goqNcnbDqtpI1gyI49FNZdhmbaAiWZ/WOFy4bSLD//2QIiLY4cFaI38C0NOmBDutDw7hBl2amim2vmaayEv52RvBgEF6QUBpg4pB6CGr8URS7DLyn4Zro+VBZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kw7X9zWj; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-86b2cc89e4aso1371014241.1;
        Thu, 27 Feb 2025 18:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740711357; x=1741316157; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AGn4rKTdBk5HKxvPDHH9uJs1yMB7cBfnVPDys6cM10g=;
        b=Kw7X9zWjC3k78utubEMqfRUELGFAzN/WLnaIFqJley5X4pn2DmmvjjjhCrd1IU/EqC
         M6/pO78kRzPXrYNB+hlN+6uUupWSjls9/A6ikEHUtXxzUv9bj4AZSLXeUl1ym4kJcv0q
         sArNupq7kqNOt/xSPISWVGhpgT4OLW8D77atX8T0vI8ZZVbeVGVCjeRxBXUzrLwjZQjL
         QQ+gmSjKorD/2Xf4mAVtJnm6pBbtwKYaP1v+90lJ9EiqS9F1B1z8hIfZM7fR6/Om29ci
         9Dr4PEUo8OrppjgEZ4OLK1XzZaacdjZhjVbUnaBC2/hcP7wcVP26nrOLz8lLVNkAQ5lt
         m82w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740711357; x=1741316157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AGn4rKTdBk5HKxvPDHH9uJs1yMB7cBfnVPDys6cM10g=;
        b=Y0UN+lf2Xa7KCpz1IEc9UM7MsDAQAHE8BZ5oJVq0baViVfS5nJ7PeFYm9IdE95QHv9
         m9ZRVfEFlqnH86giKHsF+j393V3MXTdfNsTEQcmqQK0LjeULDec2mZ4oSLEGJ1IgnRMr
         8Dkfoozlv6c9yxD3ctgqg3YlejUc/aHDTljQH5eXdmZnofLzNoum2x5vovSe6KW2bLoF
         GJMK8KsvRU0cNFYEjl5iypJrMkZtUNLtGdW42t8qsSU5mlvG824W0YV+BXYEP+v4pfHG
         0hZTo461zfIE8owgjhm/UdYbZxkGsbtwDaLzPo7vinP/lEQ2SVol0zJ7m5f2r6Pp3YVG
         XajQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvUxjo9eLlm8KYjliGkbnRGbrY3oNIU7Vy3ncuEYuXT47FMH4lsHZXS4BVvgAvgtHHN1maIrBmpXmBTTyN@vger.kernel.org, AJvYcCVjTtKEH7OaVBw/iIqNoxmraaNMVmp0QzXUME9Is0tHTVUtaDn7eOMuj3eQB9x2cgng/1XjzpdoRnU=@vger.kernel.org, AJvYcCWhX5mIqw/7CPZSIj0YkNkplgRdOSwohMcUpxutPZGcB+FtNdnlvptegQwU8IZ5Fep+Y4hl+82R+Doo@vger.kernel.org, AJvYcCXXOtRHXB6F4UUPZX1et5a/foNgr5MRSH93SAKXUHYrEPPG2kwU3yZ9QD22J/PqZigHZmFeCfIc1r9WnoZSQAU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3GM3On4zTJIorr5mgf9zYeCaeU+wbioKYgrjzCDo+9Bv50e30
	DP3h6N3kOwZXrZpoIBoTPlb3N/QSruoNA7XMyIL2haS0gwqXxKpp1Ug00Rfq7ySmOQIkF4f5S45
	YnrYHvzhGEtZz7hfX0ez5e+GOSAc=
X-Gm-Gg: ASbGncvxrrbfLVzFkacYMProZrFvQEnaD8F8PeFkutx2gMbGJrdtzLSURrP3KEjtjc0
	aH4oaIMAVS19vI3oPo2f9JF836uZRTZln1W2y4NeQr+w1oM4xT77vj/8BHWSY+WJ0+LwGXLws+T
	xxRQrN3Icre81IKOct78Gu8/SSNbGGJCk3FCU8
X-Google-Smtp-Source: AGHT+IHiapB/UUcFu9hFjcY/cUs29Mtt19zxe41utXVYHpU2oYfeJ88Se07WQSOUWErtg75cxWmDszk3zaBuP97Y3mI=
X-Received: by 2002:a05:6102:3a12:b0:4ba:7469:78ce with SMTP id
 ada2fe7eead31-4c044db63bamr1554109137.21.1740711356575; Thu, 27 Feb 2025
 18:55:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227030952.2319050-1-alistair@alistair23.me>
 <20250227030952.2319050-10-alistair@alistair23.me> <2025022717-dictate-cortex-5c05@gregkh>
 <Z8DqZlE5ccujbJ80@wunner.de> <2025022748-flock-verbalize-b66a@gregkh>
In-Reply-To: <2025022748-flock-verbalize-b66a@gregkh>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 28 Feb 2025 12:55:30 +1000
X-Gm-Features: AQ5f1JpFXJofcDVcy80IppecV3ITUqFzrG39gNXopCxE2waKC9axpurrWB9MS6k
Message-ID: <CAKmqyKMHMo7_EeZ1fvSKKE0i1nm1QS5x4PYJBe1Yx8r4nqwpgA@mail.gmail.com>
Subject: Re: [RFC v2 09/20] PCI/CMA: Expose in sysfs whether devices are authenticated
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Lukas Wunner <lukas@wunner.de>, Alistair Francis <alistair@alistair23.me>, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com, 
	Jonathan.Cameron@huawei.com, rust-for-linux@vger.kernel.org, 
	akpm@linux-foundation.org, boqun.feng@gmail.com, bjorn3_gh@protonmail.com, 
	wilfred.mallawa@wdc.com, aliceryhl@google.com, ojeda@kernel.org, 
	a.hindborg@kernel.org, tmgross@umich.edu, gary@garyguo.net, 
	alex.gaynor@gmail.com, benno.lossin@proton.me, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 11:41=E2=80=AFAM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Thu, Feb 27, 2025 at 11:42:46PM +0100, Lukas Wunner wrote:
> > On Thu, Feb 27, 2025 at 03:16:40AM -0800, Greg KH wrote:
> > > On Thu, Feb 27, 2025 at 01:09:41PM +1000, Alistair Francis wrote:
> > > > The PCI core has just been amended to authenticate CMA-capable devi=
ces
> > > > on enumeration and store the result in an "authenticated" bit in st=
ruct
> > > > pci_dev->spdm_state.
> > > >
> > > > Expose the bit to user space through an eponymous sysfs attribute.
> > > >
> > > > Allow user space to trigger reauthentication (e.g. after it has upd=
ated
> > > > the CMA keyring) by writing to the sysfs attribute.
> > > >
> > > > Implement the attribute in the SPDM library so that other bus types
> > > > besides PCI may take advantage of it.  They just need to add
> > > > spdm_attr_group to the attribute groups of their devices and amend =
the
> > > > dev_to_spdm_state() helper which retrieves the spdm_state for a giv=
en
> > > > device.
> > > >
> > > > The helper may return an ERR_PTR if it couldn't be determined wheth=
er
> > > > SPDM is supported by the device.  The sysfs attribute is visible in=
 that
> > > > case but returns an error on access.  This prevents downgrade attac=
ks
> > > > where an attacker disturbs memory allocation or DOE communication
> > > > in order to create the appearance that SPDM is unsupported.
> > >
> > > I don't like this "if it's present we still don't know if the device
> > > supports this", as that is not normally the "sysfs way" here.  Why mu=
st
> > > it be present in those situations?

I do think there are 4 situations

 1. Device supports authentication and was authenticated
 2.
  a) Device supports authentication, but the certificate chain can't
be authenticated
  b) Device supports authentication, but the communication was interrupted
 3. Device doesn't support authentication

Case 1 and 3 are easy

Case 2 (a) means that the kernel doesn't trust the certificate. This
could be for a range of reasons, including the user just hasn't
installed the cert yet. So it makes sense to pass that information to
the user as they can act on it. I think it's a different case to 3
(where there is no action for the user to take).

> >
> > That's explained above.
>
> Not really, you just say "downgrade attacks", which is not something
> that we need to worry about, right?  If so, I think this bit is the
> least of our worries.
>
> > Unfortunately there is no (signed) bit in Config Space which tells us
> > whether authentication is supported by a PCI device.  Rather, it is
> > necessary to exchange several messages with the device through a
> > DOE mailbox in config space to determine that.  I'm worried that an
> > attacker deliberately "glitches" those DOE exchanges and thus creates
> > the appearance that the device does not support authentication.
>
> That's a hardware glitch, and if that happens, then it will show a 0 and
> that's the same as not being present at all, right?  Otherwise you just
> pound on the file to try to see if the glitch was not real?  That's not
> going to go over well.
>
> > Let's say the user's policy is to trust legacy devices which do not
> > support authentication, but require authentication for newer NVMe drive=
s
> > from a certain vendor.  An attacker may manipulate an authentication-ca=
pable
> > NVMe drive from that vendor, whereupon it will fail authentication.
> > But the attacker can trick the user into trusting the device by glitchi=
ng
> > the DOE exchanges.
>
> Again, are we now claiming that Linux needs to support "hardware
> glitching"?  Is that required somewhere?  I think if the DOE exchanges
> fail, we just trust the device as we have to trust something, right?

This is case 2 (b) above. If an attacker could flip a bit or drop a
byte in the communication path they could cause the authentication to
stop.

The process to authenticate a device involves sending a lot of data,
so it's not impossible that an attacker could interrupt some of the
traffic.

If the DOE exchange fails I don't think we want to trust the device,
as that's the point of SPDM. So being able to communicate that to
userspace does seem really useful.

>
> > Of course, this is an abnormal situation that users won't encounter
> > unless they're being attacked.  Normally the attribute is only present
> > if authentication is supported.
> >
> > I disagree with your assessment that we have bigger problems.
> > For security protocols like this we have to be very careful
> > to prevent trivial circumvention.  We cannot just shrug this off
> > as unimportant.
>
> hardware glitching is not trivial.  Let's only worry about that if the
> hardware people somehow require it, and if so, we can push back and say
> "stop making us fix your broken designs" :)

Hardware glitching is hard to do, but SPDM is designed to protect
against a range of hard attacks. The types of attacks that nation
states would do. So I think we should do our best to protect against
them.Obviously there is only so much that software can do to protect
against a hardware glitch, but this seems like a good in between.

I don't think the design is overall broken though. At some point when
all devices support SPDM it becomes a non issue as you just fail if
authentication fails, but in the mean time we need to handle devices
with and without authentication.

>
> > The "authenticated" attribute tells user space whether the device
> > is authenticated.  User space needs to handle errors anyway when
> > reading the attribute.  Users will get an error if authentication
> > support could not be determined.  Simple.
>
> No, if it's not determined, it shouldn't be present.

That doesn't allow us to differentiate the cases I mentioned above though.

Another option is we could create multiple attributes "spdm",
"authenticated" and "spdm_err" for example to convey the information
with just yes/no attributes?

>
> > > What is going to happen to suddenly
> > > allow it to come back to be "alive" and working while the device is
> > > still present in the system?
> >
> > The device needs to be re-enumerated by the PCI core to retry
> > determining its authentication capability.  That's why the
> > sysfs documentation says the user may exercise the "remove"
> > and "rescan" attributes to retry authentication.
>
> But how does it know that?  remove and recan is a huge sledgehammer, and
> an amazing one if it even works on most hardware.  Don't make it part of
> any normal process please.
>
> > > I'd prefer it to be "if the file is there, this is supported by the
> > > device.  If the file is not there, it is not supported", as that make=
s
> > > things so much simpler for userspace (i.e. you don't want userspace t=
o
> > > have to both test if the file is there AND read all entries just to s=
ee
> > > if the kernel knows what is going on or not.)
> >
> > Huh?  Read all entries?  The attribute contains only 0 or 1!
> >
> > Or you'll get an error reading it.
>
> It's the error, don't do that.  If an error is going to happen, then
> don't have the file there.  That's the way sysfs works, it's not a
> "let's add all possible files and then make userspace open them all and
> see if an error happens to determine what really is present for this
> device" model.  It's a "if a file is there, that attribute is there and
> we can read it".
>
> > > > Alternatively, authentication success might be signaled to user spa=
ce
> > > > through a uevent, whereupon it may bind a (blacklisted) driver.
> > >
> > > How will that happen?
> >
> > The SPDM library can be amended to signal a uevent when authentication
> > succeeds or fails and user space can then act on it.  I imagine systemd
> > or some other daemon might listen to such events and do interesting thi=
ngs,
> > such as binding a driver once authentication succeeds.
>
> That's a new user/kernel api and should be designed ONLY if you actually
> need it and have a user.  Otherwise let's just wait for later for that.
>
> > Maybe you have better ideas.  Be constructive!  Make suggestions!
>
> Again, have the file there only if this is something that the hardware
> supports.  Don't fail a read just because the hardware does not seem to
> support it, but it might sometime in the future if you just happen to
> unplug/plug it back in.
>
> > > > +         This prevents downgrade attacks where an attacker consume=
s
> > > > +         memory or disturbs communication in order to create the
> > > > +         appearance that a device does not support authentication.
> > >
> > > If an attacker can consume kernel memory to cause this to happen you
> > > have bigger problems.  That's not the kernel's issue here at all.
> > >
> > > And "disable communication" means "we just don't support it as the
> > > device doesn't say it does", so again, why does that matter?
> >
> > Reacting to potential attacks sure is the kernel's business.
>
> Reacting to real, software attacks is the kernel's business.  Reacting
> to possible hardware issues that are just theoretical is not.

Generally I would agree, but the idea of SPDM is to react to hardware
attacks, so it's something that the kernel should be conscious of

>
> > > > +         The reason why authentication support could not be determ=
ined
> > > > +         is apparent from "dmesg".  To re-probe authentication sup=
port
> > > > +         of PCI devices, exercise the "remove" and "rescan" attrib=
utes.
> > >
> > > Don't make userspace parse kernel logs for this type of thing.  And
> > > asking userspace to rely on remove and recan is a mess, either show i=
t
> > > works or not.
> >
> > I'd say looking in dmesg to determine whether the user is being attacke=
d
> > is perfectly fine, as is requiring the user to explicitly act on a
> > potential attack.
> >
> >
> > > > --- a/drivers/pci/cma.c
> > > > +++ b/drivers/pci/cma.c
> > > > @@ -171,8 +171,10 @@ void pci_cma_init(struct pci_dev *pdev)
> > > >  {
> > > >   struct pci_doe_mb *doe;
> > > >
> > > > - if (IS_ERR(pci_cma_keyring))
> > > > + if (IS_ERR(pci_cma_keyring)) {
> > > > +         pdev->spdm_state =3D ERR_PTR(-ENOTTY);
> > >
> > > Why ENOTTY?
> >
> > We use -ENOTTY as return value for unsupported reset methods in the
> > PCI core, see e.g. pcie_reset_flr(), pcie_af_flr(), pci_pm_reset(),
> > pci_parent_bus_reset(), pci_reset_hotplug_slot(), ...
> >
> > We also use -ENOTTY in pci_bridge_wait_for_secondary_bus() and
> > pci_dev_wait().
> >
> > It was used here to be consistent with those existing occurrences
> > in the PCI core.
> >
> > If you'd prefer something else, please make a suggestion.
>
> Ah, didn't realize that was a pci thing, ok, nevermind.
>
> > > > +static ssize_t authenticated_store(struct device *dev,
> > > > +                            struct device_attribute *attr,
> > > > +                            const char *buf, size_t count)
> > > > +{
> > > > + void *spdm_state =3D dev_to_spdm_state(dev);
> > > > + int rc;
> > > > +
> > > > + if (IS_ERR_OR_NULL(spdm_state))
> > > > +         return PTR_ERR(spdm_state);
> > > > +
> > > > + if (sysfs_streq(buf, "re")) {
> > >
> > > I don't like sysfs files that when reading show a binary, but require=
 a
> > > "magic string" to be written to them to have them do something else.
> > > that way lies madness.  What would you do if each sysfs file had a
> > > custom language that you had to look up for each one?  Be consistant
> > > here.  But again, I don't think you need a store function at all, eit=
her
> > > the device supports this, or it doesn't.
> >
> > I'm not sure if you've even read the ABI documentation in full.
> >
> > The store method is needed to reauthenticate the device,
> > e.g. after a new trusted root certificate was added to the
> > kernel's .cma keyring.
>
> Why not have a different file called "reauthentication" that only allows
> a write to it of a 1/Y/y to do the reauthentication.  sysfs is a "one
> file per thing" interface, not a "parse a command and do something but
> when read from return a different value" interface.

That works for me as well

Alistair

>
> Let's keep it dirt simple please.
>
> thanks,
>
> greg k-h

