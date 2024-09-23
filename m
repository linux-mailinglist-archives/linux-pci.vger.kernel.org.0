Return-Path: <linux-pci+bounces-13383-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E94C497F008
	for <lists+linux-pci@lfdr.de>; Mon, 23 Sep 2024 19:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAD7F1C20C17
	for <lists+linux-pci@lfdr.de>; Mon, 23 Sep 2024 17:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C1119F122;
	Mon, 23 Sep 2024 17:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b="lQUiA3Gg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA7D195F04
	for <linux-pci@vger.kernel.org>; Mon, 23 Sep 2024 17:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727114192; cv=none; b=c8etQxRCAUB/G5CU1FzR47W97DnDkKBLF2G4Cq8cvdVc2l8To6rMgegmbndInhanQLiSnZ0DP0WuFg/FGrdZrRk4pyQUAG6/PtfT91e7lXQPeQPT6t1DSBr00DuPC8qjd1zCIGY9z32cfHFTX/C0cyK7G/my2lo9WNx/C17iwdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727114192; c=relaxed/simple;
	bh=6zmFJyIxFrxJ+d1XkGs44JPMBJUeXR/RPmubYYNFBDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MX8bM2RThHUwXQa1R9oqOxAHqluwbDivE1PYnnq7w/8JHG2FHSyuRRLaBt4MZVVQ3zBTnHr/MPN4Y4lk/NGBRP+5PTv/LJdoMcJkfMYbrb6ffQWavvFWFg0m9ijG80Oj99F3g25/sjc/Gv9ecQcU1Tt3TuF1DuuSOrATo22+5NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b=lQUiA3Gg; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6dbc9a60480so38444657b3.0
        for <linux-pci@vger.kernel.org>; Mon, 23 Sep 2024 10:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks.com; s=google; t=1727114189; x=1727718989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v08S02qxPENb7zYWJDL3DgsWoVF7sXmMIBA4C15vyzE=;
        b=lQUiA3GglOoUUV9AvnwG0ArjzvdQFXToDRTkckgN5U0D4eskYYJFPjREhLry9yw8f4
         Nka4xezx7klf3QNCluqzVoCMZe62eQ9uIO60yCM/sxNuNFeMA/SyzdmAO3dmIQUHutsl
         W+JhTyvP7z7/fBpztbJgCnr1xbMuVGbrniMwJ8zb/uEJsXa87MYvuGwxDOQc6WVeiq0p
         /MEU5v9LdOVq+gCZEO3U4GicjE0rCeU6p62FEYPdEuom1Qet/nJ3nJH3S/7bHyMmCBy2
         +kX06OCsPtrGhBazihKEW9lU5H+lavDkuO+KIGxjlsxgKOk7PhXoKrjm7mXxjOLimcg6
         Qd7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727114189; x=1727718989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v08S02qxPENb7zYWJDL3DgsWoVF7sXmMIBA4C15vyzE=;
        b=qm4Y+oYHAh9VmKuDf5qQcnsZDwSlw58N08qFh+HMDwHF67sSrwfMQdyBEpwG1x3duv
         NLHB8W9c4pIxHO35RhjIWVbmLcrBPkqw7ezFZE23GcoER5C485oWxbVME3B4faxyKfD/
         ZB7oofNAGB9JBNckBvaMjBjbOZQ+/0FN71qOq2pzZMsJQfkxPfI+pVDarN0sZvTwRNQL
         cqOrdPQeZvZT3vrciRdjzUy0MUXyWoqxOVXKebSp8iSu5t/8CxjSUIFwiU/cTCdI+uOJ
         ikokb5FM3fSnMjCbt63vTDb4veXx6FdO8tHZRstehSuy0QvaLDfgw65EzwEGmT+JMnyp
         IYZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBCfVgOEH54KYSm4ayQBatCbqR5vZe8oB1JN9d0GvoAA3/vMwzR5Mx3gz7lvabGgivL+jhgvmYfPI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/7lWitxgfDXzm6cE2OOfdtGpUMiu3yrJilokl1sy44r2xlIOw
	aAzT+PmueeUvIciyjZ1swCjZtvHzV+0vmu4oARLGbv9YMA8HgULQsHDY2AZQj6IjCbhEP5aimxx
	V/+4CKaZdhCQNqWeA6NzcBo09k0dmONSjjZctYk3/8LC8+egYlAQlXg==
X-Google-Smtp-Source: AGHT+IEb1naAQJ/eiRrc2LqDFu2ZHbx/V5plVw0LnmW8P3x+ZNzurJzi8zHcUvPQYhOt5oxAs97KbhCyNDguLoui2fI=
X-Received: by 2002:a05:690c:270b:b0:6db:b5b2:53c with SMTP id
 00721157ae682-6dfeeed0d94mr76708007b3.32.1727114189241; Mon, 23 Sep 2024
 10:56:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJ+vNU0fuoBtpmKSs4hgi9=deBazML+KSJy+cqkou6mPumjwvQ@mail.gmail.com>
 <20240910230455.GA608446@bhelgaas> <CAJ+vNU3mgmFuGjDC_LGSvEUVZJ9AXKG++zXc9VCNQ1=hEXW8GQ@mail.gmail.com>
In-Reply-To: <CAJ+vNU3mgmFuGjDC_LGSvEUVZJ9AXKG++zXc9VCNQ1=hEXW8GQ@mail.gmail.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Mon, 23 Sep 2024 10:56:18 -0700
Message-ID: <CAJ+vNU1KM+yWHR-rfQrwNryrnoayfqWCffbUfgQy8qN9y+PDgA@mail.gmail.com>
Subject: Re: legacy PCI device behind a bridge not getting a valid IRQ on imx
 host controller
To: Bjorn Helgaas <helgaas@kernel.org>, Frank Li <frank.li@nxp.com>
Cc: Hongxing Zhu <hongxing.zhu@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 4:28=E2=80=AFPM Tim Harvey <tharvey@gateworks.com> =
wrote:
>
> On Tue, Sep 10, 2024 at 4:04=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org=
> wrote:
> >
> > On Tue, Sep 10, 2024 at 09:50:02AM -0700, Tim Harvey wrote:
> > > On Fri, Sep 6, 2024 at 12:58=E2=80=AFPM Bjorn Helgaas <helgaas@kernel=
.org> wrote:
> > > > On Fri, Sep 06, 2024 at 12:37:42PM -0700, Tim Harvey wrote:
> > > > > ...
> > > >
> > > > > I have the hardware in hand now as well as the out-of-tree driver
> > > > > that's being used. I can say there is nothing wrong here with leg=
acy
> > > > > PCI interrupt mapping, if I write a skeleton driver that uses
> > > > > pci_resister_driver(struct pci_driver) its probe is called with a=
n
> > > > > interrupt and request_irq on that interrupt succeeds just fine.
> > > > >
> > > > > The issue here is with the vendor's out-of-tree driver which inst=
ead
> > > > > is using pci_get_device() to scan the bus which returns a struct
> > > > > pci_dev * that doesn't have an irq assigned (like what is describ=
ed
> > > > > in
> > > > > https://www.kernel.org/doc/html/v5.5/PCI/pci.html#how-to-find-pci=
-devices-manually).
> > > > > When using pci_get_device() when/how does pci_assign_irq() get
> > > > > called to assign the irq to the device?
> > > >
> > > > Hmmm.  pci_get_device() is strongly discouraged because it subverts
> > > > the driver model (it skips the usual driver probe/claim model so it
> > > > allows multiple drivers to operate the device simultaneously which =
can
> > > > obviously cause conflicts), and it doesn't play well with hotplug
> > > > (hotplug events automatically cause driver .probe() methods to be
> > > > called, but users of pci_get_device() have to roll their own way of
> > > > doing this).
> > > >
> > > > So I'm not aware of a documented/supported way to set up the INTx
> > > > interrupts in the pci_get_device() case.
> > >
> > > Makes sense to me. Perhaps some changes to Documentation/PCI/pci.rst
> > > could explain this.
> >
> > Yeah, that would be a good idea.
> >
> > > Thanks for the help here, glad to find there is nothing broken here. =
I
> > > think there could have been some confusion by the user here because
> > > they were used to x86 assigning irq's without using
> > > pci_resister_driver() but they were also using a kernel param of
> > > pci=3Drouteirq which looks like its an x86 only temporary workaround
> > > that may have made this work on that architecture.
> >
> > I wondered about "pci=3Droutirq", but I lost the trail and couldn't
> > figure out how that would lead to pci_assign_irq() or something
> > functionally equivalent.
> >
>
> Hi Bjorn and Frank,
>
> While switching to pci_resister_driver() resolves the request_irq
> issue I find that legacy IRQ's fire on the imx8mm/imx8mp only when the
> device is not behind a bridge:
>
> Again this specific device is a DDK BU-69092S1 which has a TI XIO2001
> PCIe-to-PCI bridge with a PCI device behind it.
>
> Here is an example of a GW72xx (which has a PI7C9X2G404E 4-port PCIe
> switch) with an imx8mm:
> root@noble-venice:~# uname -r
> 6.6.8-gc6ef8b5e47a0
> root@noble-venice:~# lspci -n
> 00:00.0 0604: 16c3:abcd (rev 01)
> 01:00.0 0604: 12d8:b404 (rev 01)
> 02:01.0 0604: 12d8:b404 (rev 01)
> 02:02.0 0604: 12d8:b404 (rev 01)
> 02:03.0 0604: 12d8:b404 (rev 01)
> 04:00.0 0604: 104c:8240
> 05:00.0 0780: 4ddc:1a00 (rev 10)
> 05:01.0 0780: 4ddc:1a00 (rev 10)
> 06:00.0 0200: 1055:7430 (rev 11)
> root@noble-venice:~# lspci -s 05:00 -vvv | grep Interrupt
>         Interrupt: pin A routed to IRQ 206
> root@noble-venice:~# grep 206 /proc/interrupts
> 206:          0          0          0          0     GICv3 157 Level
>   PCIe PME
> ^^^ makes sense... driver has probed and requested the IRQ but nothing
> has made it fire yet
> root@noble-venice:~# ./tester
> Testing.....Registers Passed test.
> Testing.....Ram Passed 1234 test.
> Testing.....Ram Passed aaaa test.
> Testing.....Ram Passed aa55 test.
> Testing.....Ram Passed 55aa test.
> Testing.....Ram Passed 5555 test.
> Testing.....Ram Passed ffff test.
> Testing.....Ram Passed 1111 test.
> Testing.....Ram Passed 8888 test.
> Testing.....Ram Passed 0000 test.
> Testing.....Interrupt Test Failure,  NO IRQ!!!
> Testing.....Protocol Test RTL Function Failure-> Function not supported.
> Testing.....Vector Test RTL Function Failure-> Function not supported.
> EXIT: tester
> ^^^ this app causes the device to fire an IRQ and verifies its been
> caught; fails due to no irq firing
> root@noble-venice:~# grep 206 /proc/interrupts
> 206:          0          0          0          0     GICv3 157 Level
>   PCIe PME
> ^^^ 0 interrupts
>
> Here is an example of the same device on a GW71xx (which has no
> switch) with an imx8mm:
> root@noble-venice:~# uname -r
> 6.6.8-gc6ef8b5e47a0
> root@noble-venice:~# lspci -n
> 00:00.0 0604: 16c3:abcd (rev 01)
> 01:00.0 0604: 104c:8240
> 02:00.0 0780: 4ddc:1a00 (rev 10)
> 02:01.0 0780: 4ddc:1a00 (rev 10)
> root@noble-venice:~# lspci -s 02:00 -vvv | grep Interrupt
>         Interrupt: pin A routed to IRQ 204
> root@noble-venice:~# grep 204 /proc/interrupts
> 204:          0          0          0          0     GICv3 157 Level
>   PCIe PME
> root@noble-venice:~# ./tester
> Testing.....Registers Passed test.
> Testing.....Ram Passed 1234 test.
> Testing.....Ram Passed aaaa test.
> Testing.....Ram Passed aa55 test.
> Testing.....Ram Passed 55aa test.
> Testing.....Ram Passed 5555 test.
> Testing.....Ram Passed ffff test.
> Testing.....Ram Passed 1111 test.
> Testing.....Ram Passed 8888 test.
> Testing.....Ram Passed 0000 test.
> Testing.....Interrupt Occurred, Passed test.
> Testing.....Protocol Test RTL Function Failure-> Function not supported.
> Testing.....Vector Test RTL Function Failure-> Function not supported.
> EXIT: tester
> root@noble-venice:~# grep 204 /proc/interrupts
> 204:          1          0          0          0     GICv3 157 Level
>   PCIe PME
>
> I believe this issue is likely the same thing I enquired about over a
> year ago [1] showing with an ath9k device which uses legacy IRQ's
> which I've also never resolved.
>
> Any ideas here?
>

Bjorn and Frank, any ideas here?

I neglected to point to the other email which referenced what I
believe to be the same issue:
https://www.spinics.net/lists/linux-wireless/msg233763.html

I believe that legacy interrupts do not work on imx8m{m,p} when behind
a bridge. I believe the interrupts are getting swizzled when they
should not as it's a PCIe bridge (Int A/B/C/D should be mapped based
on dt and thus should not change depending on downstream slot).

Best Regards,

Tim

