Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E83EB49E93
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2019 12:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729593AbfFRKtZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jun 2019 06:49:25 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33157 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729369AbfFRKtX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jun 2019 06:49:23 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so13452258wru.0;
        Tue, 18 Jun 2019 03:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JE8RQaiAr0Z2eARC+Cm0bFIvlUVoIV3pxeRrd6DbvIo=;
        b=Ul9fYxuL82J90Hi/W+Sr/ipNh7LBYBaTroA+1UvfwsdtKgJ+KHOibTtOkazvkc3ywW
         rur8qSELFmpKmuib2LTkBZBqaqNcyRSm2xSS6ROUg9k6QaAvwFeqCiO+yEeBQ8bh0h3X
         wlXqCZP1dsJYHZpqTnv0TMq97+5LaHfDwWMR2eudoDKyXL57jpR3+Fveh1NbPC+UPV+a
         tdBO3GMscgRB5/TTvVC2phCXwGek8HPiPaxWXSdhpaw6qVGqveplt3Z2Z/7+J3zEozJo
         Jv/PrV4OZN/kJeRAoH1Ubqn+bb8zQvPhnsb0uzHztEy/VxGYM/x7USFgt47Pd0VINVMv
         8uPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JE8RQaiAr0Z2eARC+Cm0bFIvlUVoIV3pxeRrd6DbvIo=;
        b=QcNt7bF8VRYG4N0PSLp4CIjfKg37+C6AQjYX8QmRk4UVrP8AQiH4WuNgYwi/o8Is0g
         D7prba4olSGpoOiJJhW5rgCUd1RptnGNGcS+s4kXobnqZnyQsihVtI+VvfIw/HRL0RNa
         76OK0XUhwGhO8mwHx4tntrSBVTMWnfQN+EnSU+/dUivwmpPx5d5f4FyFq/sNwunvxUdx
         5kjsQIWjgiXJM91kRixdk7g7+lxO7AYX5kvo31wPC4P6nxAh/aPaPBtILQ2ChLlC5kJx
         2CkyPyoJRtHX99uZ/9IOZqm7ZRy5oZHsZjvJJ9g5+vOyYs3aDse/n1QgL/9BSKClQM7n
         I+sA==
X-Gm-Message-State: APjAAAVnr3cK/s75Lowe2YVtoyyYEthd2IbI9LyyVWv55HxLiRE0v0bu
        oQNkp7qGgrq23eFa1KjVdJQ=
X-Google-Smtp-Source: APXvYqxU3b7dJYqXOhT95bBhqf4VXLQCeU9w8l5nocTrDwPKiUhlNpSae8bueYTDkHUuk1CnjVqK1A==
X-Received: by 2002:adf:ce8f:: with SMTP id r15mr69551595wrn.122.1560854960962;
        Tue, 18 Jun 2019 03:49:20 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id u25sm1476883wmc.3.2019.06.18.03.49.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 03:49:19 -0700 (PDT)
Date:   Tue, 18 Jun 2019 12:49:18 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        robh+dt@kernel.org, mark.rutland@arm.com, jonathanh@nvidia.com,
        vidyas@nvidia.com, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH V4 22/28] PCI: tegra: Access endpoint config only if PCIe
 link is up
Message-ID: <20190618104918.GA28892@ulmo>
References: <20190516055307.25737-23-mmaddireddy@nvidia.com>
 <20190604131436.GS16519@ulmo>
 <09bcc121-eaca-3866-d0ef-7806503e883f@nvidia.com>
 <ca34eb24-8696-576f-26bc-8d6141f81a41@nvidia.com>
 <20190613143946.GA30445@e121166-lin.cambridge.arm.com>
 <20190613154250.GA32713@ulmo>
 <a523a19c-fdfa-01f7-6f6d-2ca367a10a50@nvidia.com>
 <20190617114745.GL508@ulmo>
 <20190617193024.GC13533@google.com>
 <a7e0472d-f4a7-ed63-836a-b5e8b1360645@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
In-Reply-To: <a7e0472d-f4a7-ed63-836a-b5e8b1360645@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2019 at 11:06:44AM +0530, Manikanta Maddireddy wrote:
>=20
> On 18-Jun-19 1:00 AM, Bjorn Helgaas wrote:
> > [+cc Rafael, linux-pm, in case they have insights on how rfkill works]
> >
> > On Mon, Jun 17, 2019 at 01:47:45PM +0200, Thierry Reding wrote:
> >> On Mon, Jun 17, 2019 at 03:31:38PM +0530, Manikanta Maddireddy wrote:
> >>> On 13-Jun-19 9:12 PM, Thierry Reding wrote:
> >>>> On Thu, Jun 13, 2019 at 03:39:46PM +0100, Lorenzo Pieralisi wrote:
> >>>>> On Mon, Jun 10, 2019 at 10:08:16AM +0530, Manikanta Maddireddy wrot=
e:
> >>>>>> On 04-Jun-19 7:40 PM, Manikanta Maddireddy wrote:
> >>>>>>> On 04-Jun-19 6:44 PM, Thierry Reding wrote:
> >>>>>>>> On Thu, May 16, 2019 at 11:23:01AM +0530, Manikanta Maddireddy w=
rote:
> >>>>>>>>> Few endpoints like Wi-Fi supports power on/off and to leverage =
that
> >>>>>>>>> root port must support hot-plug and hot-unplug. Tegra PCIe does=
n't
> >>>>>>>>> support hot-plug and hot-unplug, however it supports endpoint p=
ower
> >>>>>>>>> on/off feature as follows,
> >>>>>>>>>  - Power off sequence:
> >>>>>>>>>    - Transition of PCIe link to L2
> >>>>>>>>>    - Power off endpoint
> >>>>>>>>>    - Leave root port in power up state with the link in L2
> >>>>>>>>>  - Power on sequence:
> >>>>>>>>>    - Power on endpoint
> >>>>>>>>>    - Apply hot reset to get PCIe link up
> >>>>>>>>>
> >>>>>>>>> PCIe client driver stops accessing PCIe endpoint config and
> >>>>>>>>> BAR registers after endpoint is powered off. However,
> >>>>>>>>> software applications like x11 server or lspci can access
> >>>>>>>>> endpoint config registers in which case host controller
> >>>>>>>>> raises "response decoding" errors. To avoid this scenario,
> >>>>>>>>> add PCIe link up check in config read and write callback
> >>>>>>>>> functions before accessing endpoint config registers.
> >>>>>>>>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> >>>>>>>>> ---
> >>>>>>>>> V4: No change
> >>>>>>>>>
> >>>>>>>>> V3: Update the commit log with explanation for the need of this=
 patch
> >>>>>>>>>
> >>>>>>>>> V2: Change tegra_pcie_link_status() to tegra_pcie_link_up()
> >>>>>>>>>
> >>>>>>>>>  drivers/pci/controller/pci-tegra.c | 38 ++++++++++++++++++++++=
++++++++
> >>>>>>>>>  1 file changed, 38 insertions(+)
> >>>>>>>> This still doesn't look right to me conceptually. If
> >>>>>>>> somebody wants to access the PCI devices after the kernel
> >>>>>>>> has powered them off, why can't we just power the devices
> >>>>>>>> back on so that we allow userspace to properly access the
> >>>>>>>> devices?
> >>>>>>> 1. WiFi devices provides power-off feature for power saving
> >>>>>>> in mobiles.  When WiFi is turned off we shouldn't power on
> >>>>>>> the HW back without user turning it back on.
> >>>>>>> 2. When ever user process tries to access config space, it'll
> >>>>>>> end up in these functions. We cannot have is_powered_on check
> >>>>>>> in config read/write callbacks.
> >>>>>>> 3. WiFi power on/off is device specific feature, we shouldn't
> >>>>>>> handle it in PCI subsystem or host controller driver.
> >>>>>>>> Or if that's not what we want, shouldn't we add something to
> >>>>>>>> the core PCI infrastructure to let us deal with this? It
> >>>>>>>> seems like this is some general problem that would apply to
> >>>>>>>> every PCI device and host bridge driver. Having each driver
> >>>>>>>> implement this logic separately doesn't seem like a good
> >>>>>>>> idea to me.
> >>>>>>> This should be handled by hotplug feature, whenever endpoint
> >>>>>>> is powered-off/ removed from the slot, hot unplug event
> >>>>>>> should take care of it. Unfortunately Tegra PCIe doesn't
> >>>>>>> support hotplug feature.
> >>>>>> I thought about your comment in
> >>>>>> https://patchwork.ozlabs.org/patch/1084204/ again.  What if I
> >>>>>> add link up check in tegra_pcie_isr() and make "response
> >>>>>> decoding error" as debug print? EP Config access will happen
> >>>>>> when link is down, but "Response decoding error" print comes
> >>>>>> only if debug log is enabled.  This way we can avoid race
> >>>>>> issue in config accessors and we get prints when debug logs
> >>>>>> are enabled.
> >>>> The problem that Manikanta is trying to solve here occurs in
> >>>> this situation (Manikanta, correct me if I've got this wrong):
> >>>> on some setups, a WiFi module connected over PCI will toggle a
> >>>> power GPIO as part of runtime suspend. This effectively causes
> >>>> the module to disappear from the PCI bus (i.e. it can no longer
> >>>> be accessed until the power GPIO is toggled again).
> >>> GPIO is toggled as part of WiFi on/off, can be triggered from
> >>> network manager UI.
> >>>> This is fine from a kernel point of view because the kernel keeps tr=
ack
> >>>> of what devices are suspended. However, userspace will occasionally =
try
> >>>> to read the configuration space access of all devices, and since it
> >>>> doesn't have any knowledge about the suspend state of these devices,=
 it
> >>>> doesn't know which ones to leave alone. I think this happens when the
> >>>> X.Org server is running.
> >>> This is fine from a kernel point of view because PCI client driver
> >>> doesn't initiate any PCIe transaction until network interface
> >>> is up during WiFi on.
> >>>
> >>>> One thing that Manikanta and I had discussed was that perhaps
> >>>> the device should be hot-unplugged when it goes into this
> >>>> low-power state. However, we don't support hotplug on Tegra210
> >>>> where this is needed, so we'd need some sort of software-induced
> >>>> hot-unplug. However, this low power state is entered when the
> >>>> WiFi interface is taken down (i.e. ip link set dev <interface>
> >>>> down). If we were to remove the PCI device in that case, it
> >>>> means that the interface goes away completely, which is
> >>>> completely unexpected from a user's perspective. After all,
> >>>> taking a link down and up may be something that scripts are
> >>>> doing all the time. They'd fall over if after taking the
> >>>> interface down, the interface completely disappears.
> >>>> It's also not entirely clear to me how we get the device back
> >>>> onto the bus again after it is in low power. If we hot-unplug
> >>>> the device, then the driver will be unbound. Presumably the
> >>>> driver is what's controlling the power GPIO, so there won't be
> >>>> any entity that can be used to bring the chip back to life.
> >>>> Unless we deal with that power GPIO elsewhere (rfkill switch
> >>>> perhaps?).
> >>> Correct, rfkill switch should handle the GPIO.
> >>> Sequence will be,
> >>>  - WiFi ON
> >>>    - rfkill switch enables the WiFi GPIO
> >>>    - Tegra PCIe receives hot plug event
> >>>    - Tegra PCIe hot plug driver rescans PCI bus and enumerates the de=
vice
> >>>    - PCI client driver is probed, which will create network interface
> >>>  - WiFi OFF
> >>>    - rfkill switch disables the WiFi GPIO
> >>>    - Tegra PCIe receives hot unplug event
> >>>    - Tegra PCIe hot plug driver removes PCI devices under the bus
> >>>    - PCI client driver remove is executed, which will remove
> >>>      network interface
> >>> We don't need current patch in this case because PCI device is not
> >>> present in the PCI hierarchy, so there cannot be EP config access
> >>> with link down.  However Tegra doesn't support hot plug and unplug
> >>> events. I am not sure if we have any software based hot plug event
> >>> trigger.
> >>> I will drop current patch and pursue if above sequence can be
> >>> implemented for Tegra.
> >> I just recalled that we have these messages in the kernel log:
> >>
> >> 	# dmesg | grep tegra-pcie
> >> 	[    1.055761] tegra-pcie 1003000.pcie: 4x1, 1x1 configuration
> >> 	[    2.745764] tegra-pcie 1003000.pcie: 4x1, 1x1 configuration
> >> 	[    2.753073] tegra-pcie 1003000.pcie: probing port 0, using 4 lanes
> >> 	[    2.761334] tegra-pcie 1003000.pcie: Slot present pin change, sign=
ature: 00000008
> >> 	[    3.177607] tegra-pcie 1003000.pcie: link 0 down, retrying
> >> 	[    3.585605] tegra-pcie 1003000.pcie: link 0 down, retrying
> >> 	[    3.993606] tegra-pcie 1003000.pcie: link 0 down, retrying
> >> 	[    4.001214] tegra-pcie 1003000.pcie: link 0 down, ignoring
> >> 	[    4.006733] tegra-pcie 1003000.pcie: probing port 1, using 1 lanes
> >> 	[    4.015042] tegra-pcie 1003000.pcie: Slot present pin change, sign=
ature: 00000000
> >> 	[    4.031177] tegra-pcie 1003000.pcie: PCI host bridge to bus 0000:00
> >>
> >> These "slot present pin change" message do look a lot like hotplug
> >> related messages. Could we perhaps use those to our advantage for this
> >> case? Do you see these when you run on the platform where WiFi is
> >> enabled/disabled using rfkill?
> >>
> >> Given that rfkill is completely decoupled from PCI, I don't see how we
> >> would trigger any software-based hotplug mechanism. Perhaps one thing
> >> that we could do is the equivalent of this:
> >>
> >> 	# echo 1 > /sys/bus/pci/rescan
> >>
> >> from some script that's perhaps tied to the rfkill somehow. I'm not su=
re
> >> if that's possible, or generic enough.
> > How does rfkill work?  It sounds like it completely removes power from
> > the wifi device, putting it in D3cold.  Is there any software
> > notification other than the "Slot present pin change" (which looks
> > like a Tegra-specific thing)?
> >
> > If the device is in D3cold, it won't respond to any PCI transactions,
> > and there's no standard PCI mechanism to wake it up.  Probably the
> > cleanest way to handle this is to make it a hot-unplug.
> >
> > If this were an ACPI system, the rfkill might be visible as some sort
> > of ACPI power management event, and there might be a corresponding way
> > for software to bring the device back to D0 temporarily.  That would
> > make lspci and X config reads work.  But I don't think this system has
> > ACPI.
>=20
> "Slot present pin change" interrupt is triggered based on the programming
> of PRSNT_MAP bit field in PCIE2_RP_PRIV_MISC controller register and
> they are not triggered when EP is hot plugged/unplugged. Tegra PCIe
> controller doesn't have capability to detect EP hot plug and unplug.
> Consider that WiFi off equivalent to SW aware EP hot unplug event.
>=20
> The rfkill subsystem provides a generic interface for disabling any radio
> transmitter in the system. WiFi M.2 form factor cards provide W_DISABLE
> GPIO to control the radio transmitter and I have seen some cards provide
> control to turn off complete chip through this GPIO. Here we are talking
> about second case where device is put in D3cold state. This GPIO can be
> registered to rfkill subsystem and rfkill commands (like "rfkill unblock
> wifi") can be used to turn on radio transmitter during WiFi on.

Perhaps what we need here is some sort of mechanism to make rfkill and
the PCI host controller interoperate? I could imagine for example that
the PCI host controller would get a new "rfkill" property in device
tree that points at the rfkill device via phandle.

The driver could then get a reference to it using something like:

	rfkill =3D rfkill_get(dev);
	if (IS_ERR(rfkill)) {
		...
	}

and register for notification:

	err =3D rfkill_subscribe(rfkill, callback);
	if (err < 0) {
		...
	}

rfkill_unsubscribe() and rfkill_put() would then be used upon driver
unload to detach from the rfkill.

I noticed that there's an rfkill-gpio driver (net/rfkill/rfkill-gpio.c)
that already does pretty much everything that we need, except that it
doesn't support DT yet, but I suspect that that's pretty easy to add.

Johannes, any thoughts on this. In a nutshell what we're trying to solve
here is devices that get removed from/added to PCI based on an rfkill-
type of device. The difference to other implementations is that we have
no way of detecting when the device has gone away (PCI hotplug does not
work). So we'd need some software-triggered mechanism to let the PCI
host controller know when the device is presumably going away or being
added back, so that the PCI bus can be rescanned and the PCI device
removed or added at that point).

Thierry

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl0IwasACgkQ3SOs138+
s6Fj7g/9G1lRG58MJ4zqkZ7tkSvqarrt5PbzS2K77o2stFw98TVVcV3dBRpXrmEX
yCFrjgYCB7pnS6QKFAN6ndfJ22fw2akOkoEq0EkBNjoYDzbDRM4NObfULPJC0Kdt
hiPy23Sj+RtgsSzAR9nXhZoP2zw0DRKCWJ2F5w5N9WDtDnWgqx8WJkmPDc7wKGP0
hLXw6R1b9T//DkFMTwzOZQUqQLh+TAm/UShLnLTWreOZ7XI14WoKWDLIir9TaRf+
YnMXLi+hq1PoIjtD4fABcZPzpUu2xqXgGW44/YJjXmMZN/zbrqbhCeUQ6CDpAdpg
4wQS20iznWMy6YL3RJrSHOJjJMmUp25z2skwXMIzf6hyWfn57I0oht5fNZaQA5Rm
+N3Y/BB/fJiRfVWzjfjO1XZywi9c6E8JESGz3Kgm5i+DeS17XmSFOh0r7GnnxM5n
kqrQQPTy22DHHKkdv5mx/bRRiXIjGMA8fFNWVf6cO6p6b1lwJigt3ZuPqtBJQ/Qn
KCHrxRPnlsve6Bi5Y3s3mV8UscEz4wck2vGbSQYrsnTJuep2n4tOh7C0UnnNIrG7
Tn02jbRalxlr25xCOW7NtjgWrfsMhYZb3NFmKTGWjmo92qQN1VGX0TXBr3if8XnW
SblTI1h1iRUIVAQo+1yRDiJNIijbYesMCFI1qnwPlmksXNbNitY=
=wxfs
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
