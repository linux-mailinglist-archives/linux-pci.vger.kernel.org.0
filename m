Return-Path: <linux-pci+bounces-13137-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34073977593
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 01:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58D8F1C24274
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 23:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7181C2DB6;
	Thu, 12 Sep 2024 23:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b="aw1tyfJc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB85C1C2DA6
	for <linux-pci@vger.kernel.org>; Thu, 12 Sep 2024 23:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726183756; cv=none; b=nUFW8/xSv9JDwNes/Xo8IsT/k9cxjW2/QWPePl+frmlcWEXBeWSmV9suN7IIBlANjdG+odf0iz8NxkRJr0lym+a8+gsmJmS2lQymNSYJJxPg9HXinGXIou0IPa3tWzLl73+s8Mc8FSMQcSrCqgNP8qzf0sLxuMQ37mGv5OJ2XEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726183756; c=relaxed/simple;
	bh=HhxpyaW+whjotHMJl57RFh14KQA5qk5rq8Y556Gb+Kc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MkCjqU0bldYLTZc/nIeGyhwHMK7SyKLBsU/prkC3i0U48sMKH2mandnj4pyFhurUJfUaw3qqZTxTgofCsthJX8eccDt1hWGEF0acWltQpOKfkGPDZcQMaZ+jxGS9A2+psmH2Jq0FOF7RXaaoOeh5F4LZ1akE8aWwCTbHaYWa7A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b=aw1tyfJc; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5365b71a6bdso414401e87.2
        for <linux-pci@vger.kernel.org>; Thu, 12 Sep 2024 16:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks.com; s=google; t=1726183752; x=1726788552; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zN4GgZ5xvoTsamybHhpkrFhWAKxaSJiVHiLtqJDOook=;
        b=aw1tyfJc2Z2o26Ni9tftFpbl8/BpTZAYzSuGP91GndSm06xQkY2+ZEBbqMQRt/iuOY
         pPnm8EnPNp2cGEtRb7mnB6QKs4ICsdTDkrG59lRY9hpw89qvWSgXNnDW15xHARzLSve5
         0GDr+yceVWh7d7pMeI5b3J+UuFtEIH8t3GAsSoh11mQB+dS14j+CLfzZCvMyLKjGI9pH
         xlWeG1Q+4GbfihncWaW5+7757hwCnfP/aM3Qx5px39o/86fF0QJVp7m3giA9pvVgpart
         GwwhQ9UiA8Jlz4eilzCCWvBqCJL773CeHMF9N43doFHVoW5ZF9ri9yStzvFmlrs2LPq9
         /8AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726183752; x=1726788552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zN4GgZ5xvoTsamybHhpkrFhWAKxaSJiVHiLtqJDOook=;
        b=EAcWJp33uhRXD0iO30HcJ2wKRzAy6tenZ1ltWiqrSjT1vL9+HRz3aJ2p2SWgAioM5q
         7h5uwuFz1yfJiuuG/6MeQSHyNGBAozPEhHEB3/Q/aer9nxl3x8/P54okOhId1h0SDBYy
         U8mRXYr4u/+hjg9SFMpiYlW5orrJREFkmp3S1SUpSM+nRc9HS4Cp7bJ5JFn3zQiaKE/h
         gqmezQn2BP3RhadWWGof4O8NAVfUTIVydtZV7Zyd0zAkM4d9gwNZqeXLTFvrlsX8qPI7
         5aj63QsZMdBSyRkA6tpyd6IIGR2FGh257KrfSpR+8FCKuzhhL9qJa57aAE3EICCsfXmB
         elRg==
X-Forwarded-Encrypted: i=1; AJvYcCUHLA0IK1pzzAhxLMx7B3Z9z0wqMnuInRfrHHoN+YtHzAZo8UqKKCej6kQR3rFqz1V0MLT78bKIaPg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+l/a8SypgcqZxhcAtT0xRuODXFMW0ny3H+1Ucr1IeS/iih4R2
	IcUQCi0jYV4kPLs7aFv9fSx1XuL9pRtZhm9nKc4y0Ej9VDC2CVIglFn6Kwfcc/EAPfHZDniVKSs
	E3qzrfa73HjmX5OsmhDcxtPm1DGHql86QVyffNg==
X-Google-Smtp-Source: AGHT+IE4ALpAtxevSed5Gp8YYoIFZqMr70i7OSTJ7WN9loENPCw0Ljcsa4oqUfT0zWV2xp9pDeefCxyY+6RGoXxbi30=
X-Received: by 2002:a05:6512:3e1d:b0:535:45d2:abf6 with SMTP id
 2adb3069b0e04-5367ff24b67mr435757e87.48.1726183750877; Thu, 12 Sep 2024
 16:29:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJ+vNU0fuoBtpmKSs4hgi9=deBazML+KSJy+cqkou6mPumjwvQ@mail.gmail.com>
 <20240910230455.GA608446@bhelgaas>
In-Reply-To: <20240910230455.GA608446@bhelgaas>
From: Tim Harvey <tharvey@gateworks.com>
Date: Thu, 12 Sep 2024 16:28:59 -0700
Message-ID: <CAJ+vNU3mgmFuGjDC_LGSvEUVZJ9AXKG++zXc9VCNQ1=hEXW8GQ@mail.gmail.com>
Subject: Re: legacy PCI device behind a bridge not getting a valid IRQ on imx
 host controller
To: Bjorn Helgaas <helgaas@kernel.org>, Frank Li <frank.li@nxp.com>
Cc: Hongxing Zhu <hongxing.zhu@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 4:04=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Tue, Sep 10, 2024 at 09:50:02AM -0700, Tim Harvey wrote:
> > On Fri, Sep 6, 2024 at 12:58=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.o=
rg> wrote:
> > > On Fri, Sep 06, 2024 at 12:37:42PM -0700, Tim Harvey wrote:
> > > > ...
> > >
> > > > I have the hardware in hand now as well as the out-of-tree driver
> > > > that's being used. I can say there is nothing wrong here with legac=
y
> > > > PCI interrupt mapping, if I write a skeleton driver that uses
> > > > pci_resister_driver(struct pci_driver) its probe is called with an
> > > > interrupt and request_irq on that interrupt succeeds just fine.
> > > >
> > > > The issue here is with the vendor's out-of-tree driver which instea=
d
> > > > is using pci_get_device() to scan the bus which returns a struct
> > > > pci_dev * that doesn't have an irq assigned (like what is described
> > > > in
> > > > https://www.kernel.org/doc/html/v5.5/PCI/pci.html#how-to-find-pci-d=
evices-manually).
> > > > When using pci_get_device() when/how does pci_assign_irq() get
> > > > called to assign the irq to the device?
> > >
> > > Hmmm.  pci_get_device() is strongly discouraged because it subverts
> > > the driver model (it skips the usual driver probe/claim model so it
> > > allows multiple drivers to operate the device simultaneously which ca=
n
> > > obviously cause conflicts), and it doesn't play well with hotplug
> > > (hotplug events automatically cause driver .probe() methods to be
> > > called, but users of pci_get_device() have to roll their own way of
> > > doing this).
> > >
> > > So I'm not aware of a documented/supported way to set up the INTx
> > > interrupts in the pci_get_device() case.
> >
> > Makes sense to me. Perhaps some changes to Documentation/PCI/pci.rst
> > could explain this.
>
> Yeah, that would be a good idea.
>
> > Thanks for the help here, glad to find there is nothing broken here. I
> > think there could have been some confusion by the user here because
> > they were used to x86 assigning irq's without using
> > pci_resister_driver() but they were also using a kernel param of
> > pci=3Drouteirq which looks like its an x86 only temporary workaround
> > that may have made this work on that architecture.
>
> I wondered about "pci=3Droutirq", but I lost the trail and couldn't
> figure out how that would lead to pci_assign_irq() or something
> functionally equivalent.
>

Hi Bjorn and Frank,

While switching to pci_resister_driver() resolves the request_irq
issue I find that legacy IRQ's fire on the imx8mm/imx8mp only when the
device is not behind a bridge:

Again this specific device is a DDK BU-69092S1 which has a TI XIO2001
PCIe-to-PCI bridge with a PCI device behind it.

Here is an example of a GW72xx (which has a PI7C9X2G404E 4-port PCIe
switch) with an imx8mm:
root@noble-venice:~# uname -r
6.6.8-gc6ef8b5e47a0
root@noble-venice:~# lspci -n
00:00.0 0604: 16c3:abcd (rev 01)
01:00.0 0604: 12d8:b404 (rev 01)
02:01.0 0604: 12d8:b404 (rev 01)
02:02.0 0604: 12d8:b404 (rev 01)
02:03.0 0604: 12d8:b404 (rev 01)
04:00.0 0604: 104c:8240
05:00.0 0780: 4ddc:1a00 (rev 10)
05:01.0 0780: 4ddc:1a00 (rev 10)
06:00.0 0200: 1055:7430 (rev 11)
root@noble-venice:~# lspci -s 05:00 -vvv | grep Interrupt
        Interrupt: pin A routed to IRQ 206
root@noble-venice:~# grep 206 /proc/interrupts
206:          0          0          0          0     GICv3 157 Level
  PCIe PME
^^^ makes sense... driver has probed and requested the IRQ but nothing
has made it fire yet
root@noble-venice:~# ./tester
Testing.....Registers Passed test.
Testing.....Ram Passed 1234 test.
Testing.....Ram Passed aaaa test.
Testing.....Ram Passed aa55 test.
Testing.....Ram Passed 55aa test.
Testing.....Ram Passed 5555 test.
Testing.....Ram Passed ffff test.
Testing.....Ram Passed 1111 test.
Testing.....Ram Passed 8888 test.
Testing.....Ram Passed 0000 test.
Testing.....Interrupt Test Failure,  NO IRQ!!!
Testing.....Protocol Test RTL Function Failure-> Function not supported.
Testing.....Vector Test RTL Function Failure-> Function not supported.
EXIT: tester
^^^ this app causes the device to fire an IRQ and verifies its been
caught; fails due to no irq firing
root@noble-venice:~# grep 206 /proc/interrupts
206:          0          0          0          0     GICv3 157 Level
  PCIe PME
^^^ 0 interrupts

Here is an example of the same device on a GW71xx (which has no
switch) with an imx8mm:
root@noble-venice:~# uname -r
6.6.8-gc6ef8b5e47a0
root@noble-venice:~# lspci -n
00:00.0 0604: 16c3:abcd (rev 01)
01:00.0 0604: 104c:8240
02:00.0 0780: 4ddc:1a00 (rev 10)
02:01.0 0780: 4ddc:1a00 (rev 10)
root@noble-venice:~# lspci -s 02:00 -vvv | grep Interrupt
        Interrupt: pin A routed to IRQ 204
root@noble-venice:~# grep 204 /proc/interrupts
204:          0          0          0          0     GICv3 157 Level
  PCIe PME
root@noble-venice:~# ./tester
Testing.....Registers Passed test.
Testing.....Ram Passed 1234 test.
Testing.....Ram Passed aaaa test.
Testing.....Ram Passed aa55 test.
Testing.....Ram Passed 55aa test.
Testing.....Ram Passed 5555 test.
Testing.....Ram Passed ffff test.
Testing.....Ram Passed 1111 test.
Testing.....Ram Passed 8888 test.
Testing.....Ram Passed 0000 test.
Testing.....Interrupt Occurred, Passed test.
Testing.....Protocol Test RTL Function Failure-> Function not supported.
Testing.....Vector Test RTL Function Failure-> Function not supported.
EXIT: tester
root@noble-venice:~# grep 204 /proc/interrupts
204:          1          0          0          0     GICv3 157 Level
  PCIe PME

I believe this issue is likely the same thing I enquired about over a
year ago [1] showing with an ath9k device which uses legacy IRQ's
which I've also never resolved.

Any ideas here?

Best Regards,

Tim

