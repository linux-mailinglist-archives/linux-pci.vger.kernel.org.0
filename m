Return-Path: <linux-pci+bounces-13586-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2FE4987B2A
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2024 00:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0127E1C209A5
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2024 22:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB413192D6E;
	Thu, 26 Sep 2024 22:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OjjHZJo6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95065192D6C
	for <linux-pci@vger.kernel.org>; Thu, 26 Sep 2024 22:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727389846; cv=none; b=rtVBpjXLto7+ydQOXHdWdeD11i4gcmDW3+CRW6defdAvegDIBCA19Fuml+YU0QkKptz5xMWMPu30LGuS4EylVc+3mAm5275aAs/oDPomkNIBdT/wb9zs7VeQo6rOG75Ux3QoBaL9sAqLt6nun+ZCEl4svbtNgrbJ+HKeyVvv97c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727389846; c=relaxed/simple;
	bh=ChPMpukDUEPdGZNvOZkwgF1nHIW3cKJRYKC58W2U2y0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PU/Q+wVe2z5hfNRoo9UqTRa+JrW2MAvz8vvRT8pYaQFabfgslwKdfi95JoywW0gqCcHzrH1t2+0/l+1NNSGfySaUs5d3Z1gLl4PyUorWlKedXyqrWQNSgiQQ67+Crm2Qeum7O2rg+gU6RCqmJCDQpVhqX4POeBYtq9l5IWtvp7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OjjHZJo6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAC90C4CEC5;
	Thu, 26 Sep 2024 22:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727389846;
	bh=ChPMpukDUEPdGZNvOZkwgF1nHIW3cKJRYKC58W2U2y0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=OjjHZJo63zxhKOEiITEpVKRgNM2nIR3Phdu4A6KCeUGzQQgWCtI/3j9vUk3bZYsCB
	 fipsdHd8DiwibPAeD2GSVMpo0AOA+9OmXbx7Dgpwismhb6AqkELiuZIaF3cyFhCz45
	 oObkp2HpdMZaXa6QJQMkJ6D/TwkM3LBwmntKFbABncfhkts92QHeU4zHkxiqiUI2l3
	 99rVmd2xuEP0gHaR4c0KwRp94CdKqX1NbKqVdUfcv+vajf/pEfvh2EdJZo/ajYrvao
	 k0bY7WWfJp1UlQF87jgq9xWHycXfGDkqQnAPSMGOWMHt7fCzNpWzpfUuFwaZmJPwVH
	 4jExr9fuZ2AOA==
Date: Thu, 26 Sep 2024 17:30:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Frank Li <frank.li@nxp.com>, Hongxing Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>
Subject: Re: legacy PCI device behind a bridge not getting a valid IRQ on imx
 host controller
Message-ID: <20240926223043.GA57913@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+vNU1KM+yWHR-rfQrwNryrnoayfqWCffbUfgQy8qN9y+PDgA@mail.gmail.com>

[+cc Rob since I'm not a DT expert]

On Mon, Sep 23, 2024 at 10:56:18AM -0700, Tim Harvey wrote:
> On Thu, Sep 12, 2024 at 4:28 PM Tim Harvey <tharvey@gateworks.com> wrote:
> > On Tue, Sep 10, 2024 at 4:04 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Tue, Sep 10, 2024 at 09:50:02AM -0700, Tim Harvey wrote:
> > > > On Fri, Sep 6, 2024 at 12:58 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > On Fri, Sep 06, 2024 at 12:37:42PM -0700, Tim Harvey wrote:
> > > > > > ...
> > > > >
> > > > > > I have the hardware in hand now as well as the out-of-tree driver
> > > > > > that's being used. I can say there is nothing wrong here with legacy
> > > > > > PCI interrupt mapping, if I write a skeleton driver that uses
> > > > > > pci_register_driver(struct pci_driver) its probe is called with an
> > > > > > interrupt and request_irq on that interrupt succeeds just fine.
> > > > > >
> > > > > > The issue here is with the vendor's out-of-tree driver which instead
> > > > > > is using pci_get_device() to scan the bus which returns a struct
> > > > > > pci_dev * that doesn't have an irq assigned (like what is described
> > > > > > in
> > > > > > https://www.kernel.org/doc/html/v5.5/PCI/pci.html#how-to-find-pci-devices-manually).
> > > > > > When using pci_get_device() when/how does pci_assign_irq() get
> > > > > > called to assign the irq to the device?
> > > > >
> > > > > Hmmm.  pci_get_device() is strongly discouraged because it subverts
> > > > > the driver model (it skips the usual driver probe/claim model so it
> > > > > allows multiple drivers to operate the device simultaneously which can
> > > > > obviously cause conflicts), and it doesn't play well with hotplug
> > > > > (hotplug events automatically cause driver .probe() methods to be
> > > > > called, but users of pci_get_device() have to roll their own way of
> > > > > doing this).
> > > > >
> > > > > So I'm not aware of a documented/supported way to set up the INTx
> > > > > interrupts in the pci_get_device() case.
> > > >
> > > > Makes sense to me. Perhaps some changes to Documentation/PCI/pci.rst
> > > > could explain this.
> > >
> > > Yeah, that would be a good idea.
> > >
> > > > Thanks for the help here, glad to find there is nothing broken here. I
> > > > think there could have been some confusion by the user here because
> > > > they were used to x86 assigning irq's without using
> > > > pci_resister_driver() but they were also using a kernel param of
> > > > pci=routeirq which looks like its an x86 only temporary workaround
> > > > that may have made this work on that architecture.
> > >
> > > I wondered about "pci=routirq", but I lost the trail and couldn't
> > > figure out how that would lead to pci_assign_irq() or something
> > > functionally equivalent.
> >
> > Hi Bjorn and Frank,
> >
> > While switching to pci_register_driver() resolves the request_irq
> > issue I find that legacy IRQ's fire on the imx8mm/imx8mp only when the
> > device is not behind a bridge:
> >
> > Again this specific device is a DDK BU-69092S1 which has a TI XIO2001
> > PCIe-to-PCI bridge with a PCI device behind it.
> >
> > Here is an example of a GW72xx (which has a PI7C9X2G404E 4-port PCIe
> > switch) with an imx8mm:
> > root@noble-venice:~# uname -r
> > 6.6.8-gc6ef8b5e47a0
> > root@noble-venice:~# lspci -n
> > 00:00.0 0604: 16c3:abcd (rev 01)
> > 01:00.0 0604: 12d8:b404 (rev 01)
> > 02:01.0 0604: 12d8:b404 (rev 01)
> > 02:02.0 0604: 12d8:b404 (rev 01)
> > 02:03.0 0604: 12d8:b404 (rev 01)
> > 04:00.0 0604: 104c:8240
> > 05:00.0 0780: 4ddc:1a00 (rev 10)
> > 05:01.0 0780: 4ddc:1a00 (rev 10)
> > 06:00.0 0200: 1055:7430 (rev 11)
> > root@noble-venice:~# lspci -s 05:00 -vvv | grep Interrupt
> >         Interrupt: pin A routed to IRQ 206
> > root@noble-venice:~# grep 206 /proc/interrupts
> > 206:          0          0          0          0     GICv3 157 Level
> >   PCIe PME
> > ^^^ makes sense... driver has probed and requested the IRQ but nothing
> > has made it fire yet
> > root@noble-venice:~# ./tester
> > Testing.....Registers Passed test.
> > Testing.....Ram Passed 1234 test.
> > Testing.....Ram Passed aaaa test.
> > Testing.....Ram Passed aa55 test.
> > Testing.....Ram Passed 55aa test.
> > Testing.....Ram Passed 5555 test.
> > Testing.....Ram Passed ffff test.
> > Testing.....Ram Passed 1111 test.
> > Testing.....Ram Passed 8888 test.
> > Testing.....Ram Passed 0000 test.
> > Testing.....Interrupt Test Failure,  NO IRQ!!!
> > Testing.....Protocol Test RTL Function Failure-> Function not supported.
> > Testing.....Vector Test RTL Function Failure-> Function not supported.
> > EXIT: tester
> > ^^^ this app causes the device to fire an IRQ and verifies its been
> > caught; fails due to no irq firing
> > root@noble-venice:~# grep 206 /proc/interrupts
> > 206:          0          0          0          0     GICv3 157 Level
> >   PCIe PME
> > ^^^ 0 interrupts
> >
> > Here is an example of the same device on a GW71xx (which has no
> > switch) with an imx8mm:
> > root@noble-venice:~# uname -r
> > 6.6.8-gc6ef8b5e47a0
> > root@noble-venice:~# lspci -n
> > 00:00.0 0604: 16c3:abcd (rev 01)
> > 01:00.0 0604: 104c:8240
> > 02:00.0 0780: 4ddc:1a00 (rev 10)
> > 02:01.0 0780: 4ddc:1a00 (rev 10)
> > root@noble-venice:~# lspci -s 02:00 -vvv | grep Interrupt
> >         Interrupt: pin A routed to IRQ 204
> > root@noble-venice:~# grep 204 /proc/interrupts
> > 204:          0          0          0          0     GICv3 157 Level
> >   PCIe PME
> > root@noble-venice:~# ./tester
> > Testing.....Registers Passed test.
> > Testing.....Ram Passed 1234 test.
> > Testing.....Ram Passed aaaa test.
> > Testing.....Ram Passed aa55 test.
> > Testing.....Ram Passed 55aa test.
> > Testing.....Ram Passed 5555 test.
> > Testing.....Ram Passed ffff test.
> > Testing.....Ram Passed 1111 test.
> > Testing.....Ram Passed 8888 test.
> > Testing.....Ram Passed 0000 test.
> > Testing.....Interrupt Occurred, Passed test.
> > Testing.....Protocol Test RTL Function Failure-> Function not supported.
> > Testing.....Vector Test RTL Function Failure-> Function not supported.
> > EXIT: tester
> > root@noble-venice:~# grep 204 /proc/interrupts
> > 204:          1          0          0          0     GICv3 157 Level
> >   PCIe PME
> >
> > I believe this issue is likely the same thing I enquired about over a
> > year ago [1] showing with an ath9k device which uses legacy IRQ's
> > which I've also never resolved.
> >
> > Any ideas here?
> 
> Bjorn and Frank, any ideas here?
> 
> I neglected to point to the other email which referenced what I
> believe to be the same issue:
> https://www.spinics.net/lists/linux-wireless/msg233763.html

[ad-free permalink: https://lore.kernel.org/all/CAJ+vNU0TuNA26F+hFwTRGc2pVvW34-7Sc7oQ9EW8V+2cVFgcag@mail.gmail.com/]

> I believe that legacy interrupts do not work on imx8m{m,p} when behind
> a bridge. I believe the interrupts are getting swizzled when they
> should not as it's a PCIe bridge (Int A/B/C/D should be mapped based
> on dt and thus should not change depending on downstream slot).

I assume that INTx swizzling for everything below the host bridge is
specified by the PCI spec and the only place DT is relevant is at the
host bridge itself?

What's the specific DT in question here?

I don't know enough about DT to have any ideas yet, maybe Rob does?

If I had to try to figure this out in my ignorance, I would start with
debug like below (probably overkill for people who know how this
works), and look at the DT and the driver and try to figure out what's
going wrong.  Wish I knew enough to suggest something smart ;)

diff --git a/drivers/pci/irq.c b/drivers/pci/irq.c
index 4555630be9ec..47cf77d29211 100644
--- a/drivers/pci/irq.c
+++ b/drivers/pci/irq.c
@@ -79,6 +79,11 @@ void pci_free_irq(struct pci_dev *dev, unsigned int nr, void *dev_id)
 }
 EXPORT_SYMBOL(pci_free_irq);
 
+static inline char pin_name(u8 pin)
+{
+	return 'A' + pin - 1;
+}
+
 /**
  * pci_swizzle_interrupt_pin - swizzle INTx for device behind bridge
  * @dev: the PCI device
@@ -93,13 +98,17 @@ EXPORT_SYMBOL(pci_free_irq);
 u8 pci_swizzle_interrupt_pin(const struct pci_dev *dev, u8 pin)
 {
 	int slot;
+	u8 swizzled_pin;
 
 	if (pci_ari_enabled(dev->bus))
 		slot = 0;
 	else
 		slot = PCI_SLOT(dev->devfn);
 
-	return (((pin - 1) + slot) % 4) + 1;
+	swizzled_pin = (((pin - 1) + slot) % 4) + 1;
+	pci_dbg(dev, "%s: swizzle INT%c -> INT%c (slot %d)\n",
+		__func__, pin_name(pin), pin_name(swizzled_pin), slot);
+	return swizzled_pin;
 }
 
 int pci_get_interrupt_pin(struct pci_dev *dev, struct pci_dev **bridge)
@@ -115,6 +124,7 @@ int pci_get_interrupt_pin(struct pci_dev *dev, struct pci_dev **bridge)
 		dev = dev->bus->self;
 	}
 	*bridge = dev;
+	pci_dbg(dev, "%s: INT%c\n", __func__, pin_name(pin));
 	return pin;
 }
 
@@ -135,6 +145,7 @@ u8 pci_common_swizzle(struct pci_dev *dev, u8 *pinp)
 		dev = dev->bus->self;
 	}
 	*pinp = pin;
+	pci_dbg(dev, "%s: INT%c\n", __func__, pin_name(pin));
 	return PCI_SLOT(dev->devfn);
 }
 EXPORT_SYMBOL_GPL(pci_common_swizzle);
@@ -168,6 +179,9 @@ void pci_assign_irq(struct pci_dev *dev)
 		if (hbrg->swizzle_irq)
 			slot = (*(hbrg->swizzle_irq))(dev, &pin);
 
+		pci_dbg(dev, "%s: swizzled INT%c slot %d\n",
+			__func__, pin_name(pin), slot);
+
 		/*
 		 * If a swizzling function is not used, map_irq() must
 		 * ignore slot.

