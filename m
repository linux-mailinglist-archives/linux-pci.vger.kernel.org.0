Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4B494A287
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2019 15:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729450AbfFRNkp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jun 2019 09:40:45 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53951 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729425AbfFRNkp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jun 2019 09:40:45 -0400
Received: by mail-wm1-f67.google.com with SMTP id x15so3333698wmj.3;
        Tue, 18 Jun 2019 06:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gGoQF903xajEy0xkunHDtifMQsc8+u2wIV0u4JqdboM=;
        b=jj9zP0IMnrW9W/zdyCzNSg7l/xEX+z30MYXl4/xgqvlsw1K1S3rPf6m1ZvHF145NG+
         wng6t9Kh6MC1glEV68oJiIDuNwq3QGNBKjfEPlwraLpmKBnhHI7/cRomeR8drY1FBD9V
         lbnfY+aZMzwgpszW28NNgML1vHdO/NqA5YMRymu1yvawTRGfkUGzI6qeSxKbn71nSPMd
         S2dt4z6reqI09hB+OujoQljQ4JeK2ghZPNS0YA1Ro3Aky9htpFP3qrk5gJp5GhSkGVBt
         VXsDzkjOU9kojFx/yMVDOO00F9EuLYhOLCTAmMN7awzk8hzz2Xo3w2FkUs63icF11ShM
         tUcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gGoQF903xajEy0xkunHDtifMQsc8+u2wIV0u4JqdboM=;
        b=FpEh/UXB7cgdDP6Eps3+8qiY1rG+osUTlUjwQAugjVB6ImYlREQPdn84grH5wxMYUj
         DGw+ny50lZUyJKco9IDSUvqo6TvZLYU3lBgW1gKOFSksRiWozmPx+P5RC10YtYoILwti
         xYw0sVJFiR+Bm1akvuKIdBn6On6gJQDfeSMd2k66x07tCR/dq4czx+Oq7GHELpcBVR9Z
         ViWcyIfX3HzRYqZqGzxEjCn3k/CqSNLhY+KUHu4tmNXkVWTfJJElgaAJ6HXGEwddcf50
         Xp9FTkHBw48krtj6MIQ4Q7roufPeWC4Oj3EOj+yvBTYeQ1XMcyTzxoHA7RmeqIqRrYiL
         dY9Q==
X-Gm-Message-State: APjAAAVi+hF0dqdXgb8TrLB80u93QjBhH43Swyv5H9Dz3SrePUNiPpXH
        9018XfinXptN4ckHmSVrsOY=
X-Google-Smtp-Source: APXvYqzpOjlP12JIPOfbvAcSLN3hMT/lUksG1yq+Kfy5J01mp3WiMgpIBigO59abtE2wUB2KV+YSKw==
X-Received: by 2002:a1c:7c11:: with SMTP id x17mr3519561wmc.22.1560865240466;
        Tue, 18 Jun 2019 06:40:40 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id o8sm15083762wrj.71.2019.06.18.06.40.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 06:40:39 -0700 (PDT)
Date:   Tue, 18 Jun 2019 15:40:38 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        robh+dt@kernel.org, mark.rutland@arm.com, jonathanh@nvidia.com,
        vidyas@nvidia.com, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH V4 22/28] PCI: tegra: Access endpoint config only if PCIe
 link is up
Message-ID: <20190618134038.GA1397@ulmo>
References: <09bcc121-eaca-3866-d0ef-7806503e883f@nvidia.com>
 <ca34eb24-8696-576f-26bc-8d6141f81a41@nvidia.com>
 <20190613143946.GA30445@e121166-lin.cambridge.arm.com>
 <20190613154250.GA32713@ulmo>
 <a523a19c-fdfa-01f7-6f6d-2ca367a10a50@nvidia.com>
 <20190617114745.GL508@ulmo>
 <20190617193024.GC13533@google.com>
 <a7e0472d-f4a7-ed63-836a-b5e8b1360645@nvidia.com>
 <20190618104918.GA28892@ulmo>
 <9c0fb01f0dc6a193265297eaa100a35ff25413e7.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
In-Reply-To: <9c0fb01f0dc6a193265297eaa100a35ff25413e7.camel@sipsolutions.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2019 at 02:32:59PM +0200, Johannes Berg wrote:
> I got to this thread really late I guess :-)
>=20
> On Tue, 2019-06-18 at 12:49 +0200, Thierry Reding wrote:
>=20
> > > > > > > > > > 1. WiFi devices provides power-off feature for power sa=
ving
> > > > > > > > > > in mobiles.  When WiFi is turned off we shouldn't power=
 on
> > > > > > > > > > the HW back without user turning it back on.
>=20
> But why would you disconnect the PCIe device just to power it down?!

It's a side-effect of asserting that W_DISABLE pin that the bus link
basically goes down. We've had a similar case recently, one that we
haven't quite solved either, where an RTL8169 Ethernet controller is
hooked up to a GPIO that controls the ISOLATEB (I think that was the
name) pin. If that pin is asserted, according to the documentation,
the device stops sampling/driving the PCI signals. So for all intents
and purposes it becomes disconnected.

We could kind of deal with this if the ISOLATEB was deasserted at probe
time, because that would mean that the device is at least enumerated on
PCI. Then when we go into some power down mode (for example when the
interface is taken down), the NIC driver could assert the GPIO and on
resuming from the power down mode deassert it again. Logically the
device would stay around, we just couldn't talk to it over PCI until the
driver has deasserted the ISOLATEB GPIO.

The problem is that it's not exactly defined what the status of the pin
would be at probe time. If it is asserted, the NIC will never show up on
the PCI bus and hence no driver would be registered that could deassert
the ISOLATEB signal. Well, unless we somehow created a "placeholder" PCI
device based on a device tree node (containing a reference to the GPIO)
so that the device would be enumerated (and probed) regardless of the
PCI link. There's no infrastructure to do that currently, but perhaps
worth investigating.

I think the W_DISABLE is somewhat similar. From what Manikanta was
saying, the PCI link also goes down when the pin is asserted, so we
loose any means of communicating with it over PCI.

The issue that Manikanta was trying to solve with this particular patch
was that since the PCI device is part of the PCI device hierarchy, some
userspace tools (X server, for example) will see it and try to discover
whether it's a GPU or not. This in turn causes errors from the PCI host
controller because it's trying to access a device behind a link that's
down. That, I assume, could also happen for the ISOLATEB case that I was
describing above, though it hasn't been brought up, I think.

> > > > > > > The problem that Manikanta is trying to solve here occurs in
> > > > > > > this situation (Manikanta, correct me if I've got this wrong):
> > > > > > > on some setups, a WiFi module connected over PCI will toggle a
> > > > > > > power GPIO as part of runtime suspend. This effectively causes
> > > > > > > the module to disappear from the PCI bus (i.e. it can no long=
er
> > > > > > > be accessed until the power GPIO is toggled again).
> > > > > >=20
> > > > > > GPIO is toggled as part of WiFi on/off, can be triggered from
> > > > > > network manager UI.
>=20
> That's kinda icky, IMHO.

Isn't that kind of the point of rfkill? I seem to remember having a
notebook where this was done exactly the same way. There was also a
button/switch that you could push which would result in the WiFi device
either going away completely or at the least loosing the WiFi link. It
seems like that's exactly what Manikanta is describing.

> > > > > > Correct, rfkill switch should handle the GPIO.
> > > > > > Sequence will be,
> > > > > >  - WiFi ON
> > > > > >    - rfkill switch enables the WiFi GPIO
> > > > > >    - Tegra PCIe receives hot plug event
> > > > > >    - Tegra PCIe hot plug driver rescans PCI bus and enumerates =
the device
> > > > > >    - PCI client driver is probed, which will create network int=
erface
> > > > > >  - WiFi OFF
> > > > > >    - rfkill switch disables the WiFi GPIO
> > > > > >    - Tegra PCIe receives hot unplug event
> > > > > >    - Tegra PCIe hot plug driver removes PCI devices under the b=
us
> > > > > >    - PCI client driver remove is executed, which will remove
> > > > > >      network interface
> > > > > > We don't need current patch in this case because PCI device is =
not
> > > > > > present in the PCI hierarchy, so there cannot be EP config acce=
ss
> > > > > > with link down.  However Tegra doesn't support hot plug and unp=
lug
> > > > > > events. I am not sure if we have any software based hot plug ev=
ent
> > > > > > trigger.
>=20
> Looks reasonable to me.
>=20
> I guess if you absolutely know in software when the device is present or
> not, you don't need "real" PCIe hotplug, just need to tickle the
> software right?

Right.

> > > > How does rfkill work?  It sounds like it completely removes power f=
rom
> > > > the wifi device, putting it in D3cold.  Is there any software
> > > > notification other than the "Slot present pin change" (which looks
> > > > like a Tegra-specific thing)?
>=20
> Well, they said above it's a GPIO that controls it, so the software
> already knows and doesn't really need an event?

We still need to communicate from rfkill to the PCI host controller that
something happened, since they are two different entities.

> > > The rfkill subsystem provides a generic interface for disabling any r=
adio
> > > transmitter in the system. WiFi M.2 form factor cards provide W_DISAB=
LE
> > > GPIO to control the radio transmitter
>=20
> But it depends on the hardware how this is handled, Intel NICs for
> example just trigger an IRQ to the host and don't turn off much, for
> them the W_DISABLE pin is just a GPIO in input mode, with edge triggered
> interrupt to the driver.

Okay, so does this mean you have some input device connected to the WiFi
device that will be used (without software intervention) to disable the
transmitter and then the WiFi device will signal using the W_DISABLE pin
that the transmitter was indeed disabled?

> > > and I have seen some cards provide
> > > control to turn off complete chip through this GPIO.=20
>=20
> I never heard of this. Which NICs are we talking about?
>=20
> > Perhaps what we need here is some sort of mechanism to make rfkill and
> > the PCI host controller interoperate? I could imagine for example that
> > the PCI host controller would get a new "rfkill" property in device
> > tree that points at the rfkill device via phandle.
>=20
> But you don't know which the rfkill device is, do you?
>=20
> I mean, fundamentally, you just have a GPIO that turns on and off the
> W_DISABLE pin. NICs will not generally disappear from the bus when
> that's turned on, so you need a NIC driver integration.

I think that's the main problem that we're trying to solve. In our case
it does seem like the device completely disappears from the bus.

> I guess you also have an rfkill-gpio driver assigned to this GPIO, which
> gets assigned there via DT/platform code?

Yes, I think that's correct. Manikanta, please confirm.

> Ah, but then I guess you could have a phandle in the DT or so that ties
> the W_DISABLE-GPIO with the PCIe slot that it controls.

Right, that's what I was thinking.

> > The driver could then get a reference to it using something like:
> >=20
> > 	rfkill =3D rfkill_get(dev);
> > 	if (IS_ERR(rfkill)) {
> > 		...
> > 	}
> >=20
> > and register for notification:
> >=20
> > 	err =3D rfkill_subscribe(rfkill, callback);
> > 	if (err < 0) {
> > 		...
> > 	}
> >=20
> > rfkill_unsubscribe() and rfkill_put() would then be used upon driver
> > unload to detach from the rfkill.
>=20
> This I don't understand.

This was just an example of what I was imagining. The network driver
would get an rfkill (looked up via device tree phandle) and subscribe to
receive events from it, so that it could be notified when the rfkill is
"blocked" and rescan the bus to get the WiFi device unplugged. Once
unblocked it would be notified again and rescan the bus so that the
device would reappear.

> > I noticed that there's an rfkill-gpio driver (net/rfkill/rfkill-gpio.c)
> > that already does pretty much everything that we need, except that it
> > doesn't support DT yet, but I suspect that that's pretty easy to add.
>=20
> Oh, good point, no DT support here - so how *do* you actually
> instantiate the rfkill today??

I suspect that we've got downstream patches for that. The patch here is
part of a series to upstream support for this. I haven't seen the patch
for rfkill-gpio, but perhaps that's queued for later.

> > Johannes, any thoughts on this. In a nutshell what we're trying to solve
> > here is devices that get removed from/added to PCI based on an rfkill-
> > type of device. The difference to other implementations is that we have
> > no way of detecting when the device has gone away (PCI hotplug does not
> > work). So we'd need some software-triggered mechanism to let the PCI
> > host controller know when the device is presumably going away or being
> > added back, so that the PCI bus can be rescanned and the PCI device
> > removed or added at that point).
>=20
> Right.
>=20
> So, I'm not even sure we need the *driver* to do anything other than say
> "I know the device will drop off the bus when rfkill is enabled", right?
>=20
>=20
> But do we actually need rfkill to be involved here?
>=20
> I mean, let's say first we make rfkill-gpio DT-aware, rather than just
> ACPI. This should be simple. Then it drives a GPIO (it can actually
> drive two and a clock, not sure I know why).
>=20
> Now, next we need something that says that the device should be treated
> as hotplug/unplug. We could make this in the driver somehow like you
> suggested, but that seems like a lot of effort?
>=20
> Couldn't we put this into the *GPIO* subsystem instead?
>=20
> I mean - conceivably there could be GPIOs that just power down a device
> for example. Not even through something like W_DISABLE, but just having
> a GPIO hooked up to a transistor on the voltage pin of the device. That
> would have very similar semantics?
>=20
> So why not just attach the PCIe device/port to the GPIO, and have the
> GPIO implementation here call the detach/attach (or detach/rescan?) when
> they are toggled?
>=20
> Not that I'd mind having it in rfkill! But it seems like a special case
> to have it there, when you can do so much more with GPIOs.

Yeah, that's where things become a little muddy. For the ISOLATEB case
there was initially a similar proposal. The problem is that on one hand
we can have different semantics for these pins. On one platform this
could be a kind of "power" GPIO, on others it could be ISOLATE/DISABLE,
and on yet others it would be more like a reset. In order to make the
PCIe port aware of the differences we'd have to expose multiple GPIOs in
DT for context.

The other problem with this is that, in order to avoid the chicken-and-
egg problem, we need to associate these GPIOs with the root ports,
because those are the only ones that exist at probe time. All downstream
devices may not be available because the power/reset/disable pin is not
asserted/deasserted yet. Now, you could potentially have a switch in the
downstream hierarchy, so it becomes completely unclear what exact device
the GPIO is associated with.

Related to that, a GPIO like this is really only useful if you can make
use of it. For example you want to assert/deassert this GPIO in order to
put the WiFi/Ethernet/whatever device into a low-power mode when it is
not used, right? But in order to do so, the driver for that device needs
to be able to handle the GPIO, because it is the only one that knows the
right point in time to toggle it. Conversely, if this was associated
with the root port, the only point in time where the root port driver
could toggle it is on a suspend/resume of the entire bus, which makes it
rather useless.

But then we're back to square one where we basically have to associate
the GPIO with the specific device. I think that's the right thing to do
because, well, that's what reality is. The GPIO is directly routed to a
pin on the chip. It's not something that goes over the PCI connector or
anything. However, we're also back to the chicken-and-egg problem since
without toggling the GPIO the device might not even get enumerated.

rfkill-gpio has the advantage that it decouples this and gets us out of
the chicken-and-egg situation. It also has fairly well-defined semantics
and fits the use-case, so it's a very appealing option.

Thierry

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl0I6dQACgkQ3SOs138+
s6GrhQ//aZZfzjN+jK/1v3z29oq2Lq4ZbmARXPXSwE7Ai9TkPLC9MGyA7tnwYb7l
NsHBH0m2SgvGyD1tk0YJgra9mrwDMirJR6nInteNgpndzyxoyQcRRbGLNFeSgfcj
T1WeR9Mmm49WbyjFUl6dQv4iN189p1xXQPkE3RHxvSFWTogSvWbLQdH/zKAeGCFl
9KDttJTBubVLoTtjuixRluklK/wh6ayltILZHsFz636rhn4agzmuiop0ozMAlTUR
nDOTjId8otqAonAaLzQxZ9U8WY2/fvlhg/3erwo+MUPh7v2GzqeugsVCqP4Yv//L
2lOlUi8mUAhWTol9Th25pPsOBVpWmrPKTBGooRYF8JY7ApEiBq5rZipiQdSDImJi
pwpOC/dSyZIsSsscq5hbCRr3TaJNCJ99l6YyU1Vvdfks0h+5erC5R1uEvE0JVh3D
gFdx/0VDfsm/WCIgSo9VHMvkJBmQ5/PHD/24W9pVgKZqWX+Dp4FIFlijz0VG4a4G
4S+Dqu7u3fn7pDQ3JE66UdWnN/2bhBcYLg+WOio55Ssoy5eYAteTtoXLDhLIbIY1
RLGbLFQnKwDdQjvaUzPtmmFDMfIk/J7kQknBND7hSOzCt0K9rM7Ac0pQUzGnnxRN
T0oFgP/uJQ/OoMWFD3H9761vMp1aiwdAYfP8A4qOIGxQQ1CaEU0=
=pkGp
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
