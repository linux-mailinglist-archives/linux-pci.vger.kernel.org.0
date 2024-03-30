Return-Path: <linux-pci+bounces-5452-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C277C892A55
	for <lists+linux-pci@lfdr.de>; Sat, 30 Mar 2024 11:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60429B21D2D
	for <lists+linux-pci@lfdr.de>; Sat, 30 Mar 2024 10:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960F8171B0;
	Sat, 30 Mar 2024 10:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="dgf4SOTj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5EDB67F;
	Sat, 30 Mar 2024 10:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711793663; cv=none; b=csdI/Z3+UjHhtwK+J4v0EgTSRwcVl1o+9WPXq5d9bGrPTNABGak4dS3YF0TDMaPpjx3luRNAy9WtAeYfwjyUqEuYHcspILX65DlzjiHuc/NOf2BAffyKbBSvgEhEgQshPUmVEMglKQFOfeQDIBmLpSDCI+mJS22/5SqkybI0IBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711793663; c=relaxed/simple;
	bh=YtQ2ax9Ae5sMRC6JoihMdusDlRlfsEbpRvytIGtk9ps=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=YO7BgaB1RCWUxmCHEC6hvOW55sYabFydFCI9g4a49QW8GCBnQC1ePH2zn1iYFVcGbf33BlulVW+S4yo5T32pB1ZDf/rlSqlo7Tf0OXUNMp84bjyjgth9mkLellxCWNEmyTjcGrsUilLvfFuTn0QZZsbTt55fz8DbV3NB76fLXfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=dgf4SOTj; arc=none smtp.client-ip=185.70.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1711793651; x=1712052851;
	bh=0knzfQfMaLa+thbpbFS7QbzPqAlwcHi6glSRC2JkZjQ=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=dgf4SOTjV4L90VBXGCrShg9WhInL4mliVEIXpFQUHiYDFMNHrXlzOqSdK5ginRdVY
	 cm20DqSgFQRYq0EVPJ9rNd1jrrBm3ReJz6YoiasdLkkz7S6MeLqeOkiPZt/jJIkGlh
	 SqKGsLN8k5L78JdvHtRMVbtTty26RunJ1VYHRHyg6idSdoZ1A7qfWQwOAbpzCozTZf
	 T8yldfGprl4C8wOJ7r+24/YDjLLqYEcUpDMywvo4uh+ycr9IVlDGGi/bKzgP/zKAY2
	 2j74/YpKW9fhf6W88Iz4jMJLOCxCIo2tK/uR11LDKJxLJDyCVXbkC455WFe1XFzkjH
	 ybfnrs4Y4THjw==
Date: Sat, 30 Mar 2024 10:14:06 +0000
To: helgaas@kernel.org, o-takashi@sakamocchi.jp, alex.williamson@redhat.com, linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
From: "edmund.raile" <edmund.raile@proton.me>
Subject: Re: [PATCH v2] PCI: Mark LSI FW643 to avoid bus reset
Message-ID: <nmmp42qhsajsxs2inzpmir7k7goeqlm36tfbjhvzuu4uevdcyu@zpatg2zmwd2b>
Feedback-ID: 45198251:user:proton
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> Please mind that current software stack to operate your device does not
> support this kind of operation, as I've already sent to you several times=
.
> Users should cancel any type of communication on IEEE 1394 bus, then
> unplug devices from the bus (or power them off), finally operate
> suspending.

Yes I know, that's what I meant by it having "good cause to produce a trace=
".
I only meant ot demonstrate that sudo for tee is not potent enough here, wh=
ich might also
be a reason why you get no kernel message.
I'm assuming the unbind indeed produces no kernel trace for you.
su -c 'echo -n "0000:03:00.0" > /sys/bus/pci/drivers/firewire_ohci/unbind'

> The power management method Apple uses to cut power to the FireWire
> controller, Thunderbolt controller and discrete GPU is nonstandard.
I sincerely hope any implementation for Apple PCs wouldn't hinder normal
operation of FW643 add-in-cards.

> In the meantime, or maybe as a permanent solution, Edmund can make use
> of the reset_method interface in pci-syfs to restrict the available
> reset methods for the device rather than risk removing a reset
> mechanism identified as working by other users.=20

> Revert 29a43dc130ce until we figure out a better solution.  In the
> meantime, we can use the sysfs "reset_method" interface to restrict the
> available reset methods.

I tried your suggestion:
Instead of the patch:
DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATT, 0x5901, quirk_no_bus_reset);
To avoid bus reset, as root, I ran:
echo -n "pm"> /sys/devices/pci0000:00/0000:00:1c.1/0000:03:00.0/reset_metho=
d
Which reduced reset_methods from 'pm bus' to just 'pm', according to
cat /sys/devices/pci0000:00/0000:00:1c.1/0000:03:00.0/reset_method

Then to bind the FW643 to vfio-pci:
echo -n "fw1.0" > /sys/bus/firewire/drivers/snd_fireface/unbind
echo -n "0000:03:00.0" > /sys/bus/pci/drivers/firewire_ohci/unbind
At this point, no kernel message, so I assume unbind worked fine!

modprobe vfio_pci
modprobe vfio_iommu_type1
modprobe vfio_pci
then strangely binding to vfio-pci returned an error
echo -n "0000:03:00.0" > /sys/bus/pci/drivers/firewire_ohci/bind
echo: write error: no matching device found.
so I used
echo 11c1 5901 > /sys/bus/pci/drivers/vfio-pci/new_id

Finally running qemu with '-device vfio-pci,host=3D03:00.0' produces these =
kernel messages:
pcieport 0000:00:1c.1: broken device, retraining non-functional downstream =
link at 2.5GT/s
pcieport 0000:00:1c.1: retraining failed
pcieport 0000:00:1c.1: broken device, retraining non-functional downstream =
link at 2.5GT/s
pcieport 0000:00:1c.1: retraining failed
vfio-pci 0000:03:00.0: not ready 1023ms after bus reset; waiting
vfio-pci 0000:03:00.0: not ready 2047ms after bus reset; waiting
vfio-pci 0000:03:00.0: not ready 4095ms after bus reset; waiting
vfio-pci 0000:03:00.0: not ready 8191ms after bus reset; waiting
vfio-pci 0000:03:00.0: not ready 16383ms after bus reset; waiting
vfio-pci 0000:03:00.0: not ready 32767ms after bus reset; waiting
vfio-pci 0000:03:00.0: not ready 65535ms after bus reset; giving up
twice, then:
vfio-pci 0000:03:00.0: Unable to change power state from D0 to D3hot, devic=
e inaccessible
vfio-pci 0000:03:00.0: Unable to change power state from D3cold to D0, devi=
ce inaccessible

So the quirk_no_bus_reset does more than just setting reset_method manually=
.

So how can I use it then?

Zooming out, might this not be a general issue with bus reset not working o=
n Z690?
Who do I turn to?


