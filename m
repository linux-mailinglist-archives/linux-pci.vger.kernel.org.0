Return-Path: <linux-pci+bounces-6087-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A08328A024B
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 23:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5595928401C
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 21:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5D5181D17;
	Wed, 10 Apr 2024 21:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bGraRTPP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7269913CF86;
	Wed, 10 Apr 2024 21:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712785318; cv=none; b=u3W/hJmb6Z6wG8MBLW4u4p3XlStnMyhUuK+4AXbnl8cYkoFeiNEF6R0XQ4l+av8+MFvtPk2xxs9hNyoNDCcU66cRqmi9RyNkNzsGKoB+RLeKAojYrzZECShOj+HRlRgZhWZnnxpzv3lB2yAsKBprfS+gNaz0/QybpTlr1xO2x1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712785318; c=relaxed/simple;
	bh=v5VKIxAHNdPaciK1cCZY42INz6c1J/uhVWupzoP4eOw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=alOjoaATnapTJ5c2tw32uhKeOkocbQHPqrKU3tzcc0ColdGKm86mWolPSvROqNOnG5n0it3kUVRFWtDhxtjhkWGHS9EqN8Ozz5ID9dMAl8ZlyP+VI3eMiQ6bUKEXO1v1Y9dDAiTv7qThb2EjAiFAJL1WOK2K5iXNletufaGC/CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bGraRTPP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED367C433A6;
	Wed, 10 Apr 2024 21:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712785318;
	bh=v5VKIxAHNdPaciK1cCZY42INz6c1J/uhVWupzoP4eOw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bGraRTPP7OUzda/NQ/Ze4jPU38N01xy3avM9SkfUdRPU7c8do3DNYhhB8OWFgTFlq
	 FSyqEdWLklMMbWHqM9/3EfDcHAlwaJUhiQc5eD4z8Q3f82uSG7E5LdybkxahQ/0W1o
	 PCRLE67SAzkw4ziQBp2iqHc7htKTClOPV65bCwowdYiKqTT1248SEg0FYbUNOkpmTN
	 K6y3PicyjuK7n+1aGTkiWYfdkH7WIIXmc9y+YGEjkoRG96LORJZ37aSkrxcYdAgA/h
	 ecURbVcv0fTCw/yX9n++VOVYAMWyoWWtoez/x+VIo6f1FvWFr47tz8fGiXqLs6feo0
	 atrjlBZJ+Ls+A==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-516d1ecaf25so7778111e87.2;
        Wed, 10 Apr 2024 14:41:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUBInXUVDaZIeJcYo4Fl/1B+SYQcnHppXKqBhNJvSTMXbDykVKGVhooOMhbsLRuEfk95HM13dmJwXMF6b3FsDjbV7XRGCAn+ojg0DugnDPNQhMxwIHT31+5HToanx7P2KpGH1UGIaT9
X-Gm-Message-State: AOJu0YxzlDNB4PQh9TJ63DqKiuR2XamaW8qERUc/oApSkOCOV62F110r
	1e8LpKiVr287TVsvgON3Asyd66zZhWpWgSeZVGlxgK+u/amXRTIE6+Z7sXa+5DluH0Gg0apkfZQ
	fsl6rEm7Vi8lkTADWI6N+enlijg==
X-Google-Smtp-Source: AGHT+IEigZA7pTO077Z8kSR1QMNpUnpfScYWexE4LyZTUa3vOium71t/lXHTN2AIKYqGgnzLIsbc/QbOGLrMjme6c2M=
X-Received: by 2002:ac2:4c29:0:b0:516:a115:4a4d with SMTP id
 u9-20020ac24c29000000b00516a1154a4dmr2075888lfq.68.1712785316184; Wed, 10 Apr
 2024 14:41:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215145207.0cf098e5@bootlin.com> <20240319152513.GA1227721@bhelgaas>
 <20240319173404.019b424a@bootlin.com>
In-Reply-To: <20240319173404.019b424a@bootlin.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 10 Apr 2024 16:41:43 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJOgkJtOipzskWc_NzUYUE1g0VsTT3eyPbbKw=NZO_4aQ@mail.gmail.com>
Message-ID: <CAL_JsqJOgkJtOipzskWc_NzUYUE1g0VsTT3eyPbbKw=NZO_4aQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Attach DT nodes to existing PCI devices
To: Herve Codina <herve.codina@bootlin.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Lizhi Hou <lizhi.hou@amd.com>, 
	Max Zhen <max.zhen@amd.com>, Sonal Santan <sonal.santan@amd.com>, 
	Stefano Stabellini <stefano.stabellini@xilinx.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, PCI <linux-pci@vger.kernel.org>, 
	Allan Nielsen <allan.nielsen@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>, 
	Steen Hegelund <steen.hegelund@microchip.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 11:34=E2=80=AFAM Herve Codina <herve.codina@bootlin=
.com> wrote:
>
> Hi Bjorn,
>
> On Tue, 19 Mar 2024 10:25:13 -0500
> Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> > [+cc Krzysztof]
> >
> > On Fri, Dec 15, 2023 at 02:52:07PM +0100, Herve Codina wrote:
> > > On Mon, 4 Dec 2023 07:59:09 -0600
> > > Rob Herring <robh@kernel.org> wrote:
> > > > On Mon, Dec 4, 2023 at 6:43=E2=80=AFAM Herve Codina <herve.codina@b=
ootlin.com> wrote:
> > > > > On Fri, 1 Dec 2023 16:26:45 -0600
> > > > > Rob Herring <robh@kernel.org> wrote:
> > > > > > On Thu, Nov 30, 2023 at 10:57=E2=80=AFAM Herve Codina <herve.co=
dina@bootlin.com> wrote:
> > > > > > ...
> >
> > > > > > --- a/drivers/pci/of.c
> > > > > > +++ b/drivers/pci/of.c
> > > > > > @@ -31,6 +31,8 @@ int pci_set_of_node(struct pci_dev *dev)
> > > > > >                 return 0;
> > > > > >
> > > > > >         node =3D of_pci_find_child_device(dev->bus->dev.of_node=
, dev->devfn);
> > > > > > +       if (!node && pci_is_bridge(dev))
> > > > > > +               of_pci_make_dev_node(dev);
> > > > > >         if (!node)
> > > > > >                 return 0;
> > > > >
> > > > > Maybe it is too early.
> > > > > of_pci_make_dev_node() creates a node and fills some properties b=
ased on
> > > > > some already set values available in the PCI device such as its s=
truct resource
> > > > > values.
> > > > > We need to have some values set by the PCI infra in order to crea=
te our DT node
> > > > > with correct values.
> > > >
> > > > Indeed, that's probably the issue I'm having. In that case,
> > > > DECLARE_PCI_FIXUP_HEADER should work. That's later, but still befor=
e
> > > > device_add().
> > > >
> > > > I think modifying sysfs after device_add() is going to race with
> > > > userspace. Userspace is notified of a new device, and then the of_n=
ode
> > > > link may or may not be there when it reads sysfs. Also, not sure if
> > > > we'll need DT modaliases with PCI devices, but they won't work if t=
he
> > > > DT node is not set before device_add().
> > >
> > > DECLARE_PCI_FIXUP_HEADER is too early as well as doing the DT node cr=
eation
> > > just before the device_add() call.
> > > Indeed, in order to fill the DT properties, resources need to be assi=
gned
> > > (needed for the 'ranges' property used for addresses translation).
> > > The resources assignment is done after the call to device_add().
> >
> > Do we need to know the actual address *value* before creating the
> > sysfs file, or is it enough to know that the file should *exist*, even
> > if the value may be changed later?
>
> I think, the problematic file is 'of_node'.
> This file is a symlink present in the device directory pointing to the
> node in a device-tree subdir.
>
> How can we create this of_node symlink without having the device-tree
> subdir available ?
>
> >
> > > Some PCI sysfs files are already created after adding the device by t=
he
> > > pci_create_sysfs_dev_files() call:
> > >   https://elixir.bootlin.com/linux/v6.6/source/drivers/pci/bus.c#L347
> > >
> > > Is it really an issue to add the of_node link to sysfs on an already
> > > present device ?
> >
> > Yes, I think this would be an issue.  We've been trying to get rid of
> > pci_create_sysfs_dev_files() altogether because there's a long history
> > of race issues related to it:
> >
> >   https://lore.kernel.org/r/1271099285.9831.13.camel@localhost/ WARNING=
: at fs/sysfs/dir.c:451 sysfs_add_one: sysfs: cannot create duplicate filen=
ame '/devices/pci0000:00/0000:00:01.0/slot'
> >   https://lore.kernel.org/r/19461.26166.427857.612983@pilspetsen.it.uu.=
se/ [2.6.35-rc1 regression] sysfs: cannot create duplicate filename ... XVR=
-600 related?
> >   https://lore.kernel.org/r/20200716110423.xtfyb3n6tn5ixedh@pali/ PCI: =
Race condition in pci_create_sysfs_dev_files
> >   https://lore.kernel.org/r/m3eebg9puj.fsf@t19.piap.pl/ PCI: Race condi=
tion in pci_create_sysfs_dev_files (can't boot)
> >   https://bugzilla.kernel.org/show_bug.cgi?id=3D215515 sysfs: cannot cr=
eate duplicate filename '.../0000:e0'
> >
> > And several previous attempts to fix them:
> >
> >   https://lore.kernel.org/r/4469eba2-188b-aab7-07d1-5c77313fc42f@gmail.=
com/ Guard pci_create_sysfs_dev_files with atomic value
> >   https://lore.kernel.org/r/20230316103036.1837869-1-alexander.stein@ew=
.tq-group.com PCI/sysfs: get rid of pci_sysfs_init late_initcall
> >   https://lore.kernel.org/r/1702093576-30405-1-git-send-email-ssengar@l=
inux.microsoft.com/ PCI/sysfs: Fix race in pci sysfs creation
> >
>
> I am not sure we are facing in the same kind of issues.
> The ones you mentioned are related to some sysfs duplication.
> In the of_node case, the issue (if any) is that the symlink will be creat=
ed
> after the other device's file. Not sure that it can lead to some file
> duplication.

Again, if you notify userspace and it wants to make some decisions
based on of_node, then it has to be there when the notification
happens. As Greg says frequently, you've raced with userspace and
lost.

I imagine Bjorn won't like it, but may we need another fixup point?

Rob

