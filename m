Return-Path: <linux-pci+bounces-438-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 968AD804245
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 00:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 406B11F21353
	for <lists+linux-pci@lfdr.de>; Mon,  4 Dec 2023 23:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E48823749;
	Mon,  4 Dec 2023 23:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jjZ23m4b"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E68423745
	for <linux-pci@vger.kernel.org>; Mon,  4 Dec 2023 23:03:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC6F9C433CA;
	Mon,  4 Dec 2023 23:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701731016;
	bh=tXDxkojyxkL25p9KkCy1ONmXm0F3Hq4hBfCV6xY7ulc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jjZ23m4bGHUCkel/wk+iwxFLkCbsg8aQehe6yjfAVRzAhDwtCB86d/QAZ8CPye/+g
	 PDmNtQYWag+HBhLxEu/lbbd2cm6Wpw9Nl1soPFiWQ82X8sx1JwtMyZezdQX5YuWZ7t
	 ZKVzLrMHnyY44Vcd5muBROIzT8erf1cIkW2ktCmvSFsWfR+XlhCNia2ZK0mkSaqrTU
	 1/kuuXz7gu6jTuF75u5gyGdWp5gWBzFZL+XJDpKle/YEJo0JGmxxJb9s68un8REvFN
	 2sBCincUk89Z4HW6/Ujq77JCdtru4OQfnyXP71excZQpAq9Vqd0l4gVR993+XywZan
	 YqHF0Xn+xkjIw==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ca0715f0faso18105371fa.0;
        Mon, 04 Dec 2023 15:03:35 -0800 (PST)
X-Gm-Message-State: AOJu0Ywhie+kfAhRb7bnEj+ZXc7d8Dr6NhITXkKio3niJxOlJMghOULK
	d1fj8cElb7nBLIKA49xv9/bG35+b5UfcqOfMXA==
X-Google-Smtp-Source: AGHT+IGs0wl8QNfz9xjZnCehX4iFt/UVwFsn+3nrDnHOhsK8X9CM0fox8fXurNpH3Nz3X+rynn9BhePwcX3YPH/IlvA=
X-Received: by 2002:a05:6512:40c:b0:50c:180:2163 with SMTP id
 u12-20020a056512040c00b0050c01802163mr222632lfk.26.1701731014049; Mon, 04 Dec
 2023 15:03:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130165700.685764-1-herve.codina@bootlin.com>
 <CAL_JsqJvt6FpXK+FgAwE8xN3G5Z23Ktq=SEY-K7VA7nM5XgZRg@mail.gmail.com>
 <20231204134335.3ded3d46@bootlin.com> <CAL_JsqLtCS3otZ1sfiPEWwrWB4dyNpu4e0xANWJriCEUYr+4Og@mail.gmail.com>
 <20231204163014.4da383f2@bootlin.com>
In-Reply-To: <20231204163014.4da383f2@bootlin.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 4 Dec 2023 17:03:21 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJJ64513pyQggU71agTzawNWPpm6ZpWMB6e0zu-tWL8yw@mail.gmail.com>
Message-ID: <CAL_JsqJJ64513pyQggU71agTzawNWPpm6ZpWMB6e0zu-tWL8yw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Attach DT nodes to existing PCI devices
To: Herve Codina <herve.codina@bootlin.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lizhi Hou <lizhi.hou@amd.com>, Max Zhen <max.zhen@amd.com>, 
	Sonal Santan <sonal.santan@amd.com>, Stefano Stabellini <stefano.stabellini@xilinx.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, PCI <linux-pci@vger.kernel.org>, 
	Allan Nielsen <allan.nielsen@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>, 
	Steen Hegelund <steen.hegelund@microchip.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 9:30=E2=80=AFAM Herve Codina <herve.codina@bootlin.c=
om> wrote:
>
> Hi Rob,
>
> On Mon, 4 Dec 2023 07:59:09 -0600
> Rob Herring <robh@kernel.org> wrote:
>
> [...]
>
> > > > diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> > > > index 9c2137dae429..46b252bbe500 100644
> > > > --- a/drivers/pci/bus.c
> > > > +++ b/drivers/pci/bus.c
> > > > @@ -342,8 +342,6 @@ void pci_bus_add_device(struct pci_dev *dev)
> > > >          */
> > > >         pcibios_bus_add_device(dev);
> > > >         pci_fixup_device(pci_fixup_final, dev);
> > > > -       if (pci_is_bridge(dev))
> > > > -               of_pci_make_dev_node(dev);
> > > >         pci_create_sysfs_dev_files(dev);
> > > >         pci_proc_attach_device(dev);
> > > >         pci_bridge_d3_update(dev);
> > > > diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> > > > index 51e3dd0ea5ab..e15eaf0127fc 100644
> > > > --- a/drivers/pci/of.c
> > > > +++ b/drivers/pci/of.c
> > > > @@ -31,6 +31,8 @@ int pci_set_of_node(struct pci_dev *dev)
> > > >                 return 0;
> > > >
> > > >         node =3D of_pci_find_child_device(dev->bus->dev.of_node, de=
v->devfn);
> > > > +       if (!node && pci_is_bridge(dev))
> > > > +               of_pci_make_dev_node(dev);
> > > >         if (!node)
> > > >                 return 0;
> > >
> > > Maybe it is too early.
> > > of_pci_make_dev_node() creates a node and fills some properties based=
 on
> > > some already set values available in the PCI device such as its struc=
t resource
> > > values.
> > > We need to have some values set by the PCI infra in order to create o=
ur DT node
> > > with correct values.
> >
> > Indeed, that's probably the issue I'm having. In that case,
> > DECLARE_PCI_FIXUP_HEADER should work. That's later, but still before
> > device_add().
> >
> > I think modifying sysfs after device_add() is going to race with
> > userspace. Userspace is notified of a new device, and then the of_node
> > link may or may not be there when it reads sysfs. Also, not sure if
> > we'll need DT modaliases with PCI devices, but they won't work if the
> > DT node is not set before device_add().
>
> Ok, we can try using DECLARE_PCI_FIXUP_HEADER.
> On your side, is moving from DECLARE_PCI_FIXUP_EARLY to DECLARE_PCI_FIXUP=
_HEADER
> fix your QEMU unittest ?

No...

And testing the bridge part crashes. That's because there's a
dependency on the bridge->subordinate to write out bus-range and
interrupt-map. I think the fix there is we should just not write those
properties. The bus range isn't needed because the kernel does its own
assignments. For interrupt-map, it is only needed if "interrupts" is
present in the child devices. If not present, then the standard PCI
swizzling is used. Alternatively, I think the interrupt mapping could
be simplified to just implement the standard swizzling at each level
which isn't dependent on any of the devices on the bus. I gave that a
go where each interrupt-map just points to the parent bridge, but ran
into an issue that the bridge nodes don't have a phandle. That should
be fixable, but I'd rather go with the first option. I suppose that
depends on how the interrupts downstream of the PCI device need to get
resolved. It could be that the PCI device serves as the interrupt
controller and can resolve the parent interrupt on its own (which may
be needed for ACPI host anyways).

> We have to note that between the pci_fixup_device(pci_fixup_header, dev) =
call
> and the device_add() call, the call to pci_set_msi_domain() is present.
> MSIs are not supported currently but in the future ...

MSI's aren't ever described in PCI nodes. Only the host bridge. So I
don't think we should have problems there.

> Related to DT modaliases, I don't think they are needed.
> All drivers related to PCI device should be declared as pci_driver.
> Correct me if I am wrong but I think that the core PCI will load the corr=
ect
> module without any DT modalias.

Yes, you are probably right.

Rob

