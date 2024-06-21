Return-Path: <linux-pci+bounces-9082-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4EC912A8E
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2024 17:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9503F2867B0
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2024 15:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005F615A87E;
	Fri, 21 Jun 2024 15:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XuG/A2u9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3569415A85C;
	Fri, 21 Jun 2024 15:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718984745; cv=none; b=BDe3PGT4hDvmE/42QgJuWE9Y4KLLLLRQigqER28d2/LVcaAWsgkzPSEfKvcRdLpc3TE6cz6aFfyK53FZGXoJMj4Q3hJRr21xyFmTeXolso3e7Tdn557HwUFxM7uV9F0IzMNlT3kJs/O2vjjTfwcFFzHuc8RzGT8EVcOlDic7TgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718984745; c=relaxed/simple;
	bh=HOSCZ2vrhvGoFP2iw1Ql/Hz/mDzmyBgbdC959qExCDk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kE+KO56hhwx8mv0s3QBGzllCZtHVjBhRnFF6WMCvC9LyNwd8IsVFj7h4mrEeihi2/tjQINipJF6neUbU2VKqdcdbTlBbiNvhLEIQODEf82ANmH8fbFj5T799dI6QT3mHfFdjr6YWKbqRgnuLEY6gHsMabFe4GFuPQS3NWZ5neI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XuG/A2u9; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a6f21ff4e6dso302754366b.3;
        Fri, 21 Jun 2024 08:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718984742; x=1719589542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4CvXaD0p8juFHM/mj9mpOHYuq+vuwl0xPPEP0shwFI=;
        b=XuG/A2u9OpJtRpPAM5mP7DY2cdn+s7cd7jq28VaTgI2un7In6lh6Z4mbdte580yI98
         70Grq8EJjXkLFfTONjSn/GOz3Pic1ejLZzF4r3OW4IrCRDOb9dsP2eHtV6ORHbdFRSdm
         /Z1izixViC4T10HqMKBQvZ8sZtuTjuV/DVqYcNjE2xMRz81bGEJFM1d8TUmCSMYvuLRi
         aodVgmaK42d9B/5MbMbg+LScbsmE4nbWTw5fbwbSG+/sH4V+TBxnAwMLdUiijTK16DZn
         RX+obBfORID0lFpxKSXpH/9HzGXR/lYmARMAQZruq6aWPzZyq0JkX9GxCDkCkTDnoVqf
         5uYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718984742; x=1719589542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p4CvXaD0p8juFHM/mj9mpOHYuq+vuwl0xPPEP0shwFI=;
        b=WIXnDV6FMcnQ9PJNpsLMlSiG7jZz7k9+4lVkT4cJcR+rcAjdalIAR8IfqrzlVtqjJi
         NAMeiiiHtBjs1zbaHMXMKHPBxMnnI93V6K2tJ1oLTQSyd9aw9UP4GEKeKIr2fuouDExY
         1h3Nd4xwuCFdEEdbLC5IZciGVlCWhdGJuAHWUUYPI/pZJag7ulnJBoK2vDfzwc+Uo8QS
         kA0JcTMNUYvA+m8OtFRpbAU9A6GkIePGKSWjs60eyiw82fcX/PXQFmW+2PLI15zULxgA
         /faVgSddHZjP9MxoH2qLfweUQCQ0nOiKpedocHVdzzb8BcEF8MJvol1+mqVPCOkksH1G
         dE4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVTH7ozIHaxrtH7yHjnYm90dvbnOjBUVv2xSPj/ibVTYywH6wV2oUN95ntxNG4Q5itRlnOx/hrlngU28hBjgH+m65AYQjUKFIREPdVsm9I3N3pFUz2Ka8/WmDADj6yiVNcFt+bGud8Y3nPGwPi2taWNFk0IJ2Y3RjhonscUN0P1kHp6L50VWsRZtzj5E0OgphiY3OaWmbVTmymiVA==
X-Gm-Message-State: AOJu0Yz0rPReYIt/0vVAU6rSciVLIeBclft/rODZpus3t+XJQPVnLml3
	0R8tGgGBqerIA8O94QJv2v5Krc1m3ITqaGtCbC8rFrXTc889vSGOO34WH4ocpyaIe0mLmVeAjif
	Iwx/glhhXBGOwq3yQEnWdnAYH6wc=
X-Google-Smtp-Source: AGHT+IGQG2/pFic6ghI58imlJHEBDuzmWT1uMrn79oh0Id6ZdT6X4Yy9HwZWFVL2JJuDF6fSk19Bw5MO37t5DdaeuQk=
X-Received: by 2002:a17:907:7a94:b0:a6f:b58f:ae3c with SMTP id
 a640c23a62f3a-a6fb58fba03mr436111266b.26.1718984742083; Fri, 21 Jun 2024
 08:45:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527161450.326615-1-herve.codina@bootlin.com>
 <20240527161450.326615-19-herve.codina@bootlin.com> <ZmDJi__Ilp7zd-yJ@surfacebook.localdomain>
 <20240620175646.24455efb@bootlin.com> <CAHp75VdDkv-dxWa60=OLfXAQ8T5CkFiKALbDHaVVKQOK3gJehA@mail.gmail.com>
 <20240620184309.6d1a29a1@bootlin.com> <20240620191923.3d62c128@bootlin.com>
In-Reply-To: <20240620191923.3d62c128@bootlin.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 21 Jun 2024 17:45:05 +0200
Message-ID: <CAHp75VdeoNXRTmMoK-S6qecU1nOQWDZVONeHU+imFiwcTxe8xg@mail.gmail.com>
Subject: Re: [PATCH v2 18/19] mfd: Add support for LAN966x PCI device
To: Herve Codina <herve.codina@bootlin.com>
Cc: Simon Horman <horms@kernel.org>, Sai Krishna Gajula <saikrishnag@marvell.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Lee Jones <lee@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Horatiu Vultur <horatiu.vultur@microchip.com>, 
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Saravana Kannan <saravanak@google.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Lars Povlsen <lars.povlsen@microchip.com>, 
	Steen Hegelund <Steen.Hegelund@microchip.com>, Daniel Machon <daniel.machon@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, netdev@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	Allan Nielsen <allan.nielsen@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 7:19=E2=80=AFPM Herve Codina <herve.codina@bootlin.=
com> wrote:
> On Thu, 20 Jun 2024 18:43:09 +0200
> Herve Codina <herve.codina@bootlin.com> wrote:
> > On Thu, 20 Jun 2024 18:07:16 +0200
> > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > On Thu, Jun 20, 2024 at 5:56=E2=80=AFPM Herve Codina <herve.codina@bo=
otlin.com> wrote:
> > > > On Wed, 5 Jun 2024 23:24:43 +0300
> > > > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > > > Mon, May 27, 2024 at 06:14:45PM +0200, Herve Codina kirjoitti:

...

> > > > > > +   if (!dev->of_node) {
> > > > > > +           dev_err(dev, "Missing of_node for device\n");
> > > > > > +           return -EINVAL;
> > > > > > +   }
> > > > >
> > > > > Why do you need this? The code you have in _create_intr_ctrl() wi=
ll take care
> > > > > already for this case.
> > > >
> > > > The code in _create_intr_ctrl checks for fwnode and not an of_node.
> > > >
> > > > The check here is to ensure that an of_node is available as it will=
 be use
> > > > for DT overlay loading.
> > >
> > > So, what exactly do you want to check? fwnode check covers this.
> > >
> > > > I will keep the check here and use dev_of_node() instead of dev->of=
_node.
> > >
> > > It needs to be well justified as from a coding point of view this is =
a
> > > duplication.
>
> On DT based system, if a fwnode is set it is an of_node.
> On ACPI, if a fwnode is set is is an acpi_node.
>
> The core PCI, when it successfully creates the DT node for a device
> (CONFIG_PCI_DYNAMIC_OF_NODES) set the of_node of this device.
> So we can have a device with:
>  - fwnode from ACPI
>  - of_node from core PCI creation

Does PCI device creation not set fwnode?

> This driver needs the of_node to load the overlay.
> Even if the core PCI cannot create a DT node for the PCI device right
> now, I don't expect this LAN855x PCI driver updated when the core PCI
> is able to create this PCI device DT node.

If it's really needed, I think the correct call here is is_of_node()
to show exactly why it's not a duplication. It also needs a comment on
top of this call.

...

> > > > > > +static struct pci_device_id lan966x_pci_ids[] =3D {
> > > > > > +   { PCI_DEVICE(0x1055, 0x9660) },
> > > > >
> > > > > Don't you have VENDOR_ID defined somewhere?
> > > >
> > > > No and 0x1055 is taken by PCI_VENDOR_ID_EFAR in pci-ids.h
> > > > but SMSC acquired EFAR late 1990's and MCHP acquired SMSC in 2012
> > > > https://elixir.bootlin.com/linux/latest/source/drivers/net/ethernet=
/microchip/lan743x_main.h#L851
> > > >
> > > > I will patch pci-ids.h to create:
> > > >   #define PCI_VENDOR_ID_SMSC PCI_VENDOR_ID_EFAR
> > > >   #define PCI_VENDOR_ID_MCHP PCI_VENDOR_ID_SMSC
> > > > As part of this patch, I will update lan743x_main.h to remove its o=
wn #define
> > > >
> > > > And use PCI_VENDOR_ID_MCHP in this series.
> > >
> > > Okay, but I don't think (but I haven't checked) we have something lik=
e
> > > this ever done there. In any case it's up to Bjorn how to implement
> > > this.
>
> Right, I wait for Bjorn reply before changing anything.

But we already have the vendor ID with the same value. Even if the
company was acquired, the old ID still may be used. In that case an
update on PCI IDs can go in a separate change justifying it. In any
case, I would really want to hear from Bjorn on this and if nothing
happens, to use the existing vendor ID for now to speed up the series
to be reviewed/processed.


--=20
With Best Regards,
Andy Shevchenko

