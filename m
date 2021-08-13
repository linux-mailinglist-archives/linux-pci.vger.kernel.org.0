Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C36683EB503
	for <lists+linux-pci@lfdr.de>; Fri, 13 Aug 2021 14:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240046AbhHMMKZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Aug 2021 08:10:25 -0400
Received: from ni.piap.pl ([195.187.100.5]:53930 "EHLO ni.piap.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239977AbhHMMKY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Aug 2021 08:10:24 -0400
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
        by ni.piap.pl (Postfix) with ESMTPSA id 82D2FC36953E;
        Fri, 13 Aug 2021 14:09:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl 82D2FC36953E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=piap.pl; s=mail;
        t=1628856591; bh=sb8e8PT14BLA3aZ+YBy/mSlODk/x4ypFarC/P08hpFM=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Uve5ELBJeZgsyoJ2Ut+4X/C+QpRBdvI63X/vA04veCIK3dUhgW5oBz5lCL47VMBcN
         WX0GCobXQzVxcBEAnDArn/K40nlItSEKDWTFqMs3QbRQRm1+p5N25Pf84i7H8U3yuG
         YYjIhY/1OnDO69X0/EZdqHjVEiWaBF/zplryHGP8=
From:   =?utf-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Artem Lapkin <email2tema@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCIe: limit Max Read Request Size on i.MX to 512 bytes
References: <m37dgp20cr.fsf@t19.piap.pl> <20210813101305.GA598827@rocinante>
Sender: khalasa@piap.pl
Date:   Fri, 13 Aug 2021 14:09:51 +0200
In-Reply-To: <20210813101305.GA598827@rocinante> ("Krzysztof =?utf-8?Q?Wil?=
 =?utf-8?Q?czy=C5=84ski=22's?=
        message of "Fri, 13 Aug 2021 12:13:05 +0200")
Message-ID: <m31r6x1r74.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Lua-Profiles: 165559 [Aug 13 2021]
X-KLMS-AntiSpam-Version: 5.9.20.0
X-KLMS-AntiSpam-Envelope-From: khalasa@piap.pl
X-KLMS-AntiSpam-Rate: 0
X-KLMS-AntiSpam-Status: not_detected
X-KLMS-AntiSpam-Method: none
X-KLMS-AntiSpam-Auth: dkim=pass header.d=piap.pl
X-KLMS-AntiSpam-Info: LuaCore: 454 454 39c6e442fd417993330528e7f9d13ac1bf7fdf8c, {Tracking_Text_ENG_RU_Has_Extended_Latin_Letters, eng}, {Tracking_marketers, three}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;piap.pl:7.1.1;127.0.0.199:7.1.2;t19.piap.pl:7.1.1
X-MS-Exchange-Organization-SCL: -1
X-KLMS-AntiSpam-Interceptor-Info: scan successful
X-KLMS-AntiPhishing: Clean, bases: 2021/08/13 11:35:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2021/08/13 05:50:00 #17026350
X-KLMS-AntiVirus-Status: Clean, skipped
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Krzysztof, :-)

> Would it be possible to implement this particular MRRS fix as a quirk
> only for the i.MX6 controller?  Unless this is something that we need in
> the core, a quirk would be preferred over something that changes the PCI
> core.

I have briefly considered it, but I think it would be *much* more
complicated and error-prone. It also appears that there are more
platforms which need it - the old CNS3xxx, which currently subverts the
PCIE_BUS_PEER2PEER, the loongson, keystone, maybe all DWC PCIe.
Multiplication of the "quirk" code doesn't really look good to me.

TBH I don't think of this as of a "quirk" - all systems have MRRS
limits, it just happens that these ones have their limit lower than 4096
bytes. This isn't a limitation of a particular PCIe device, this is a
common limit of the whole system.

Also I'm not exactly sure the loongson fixup is complete.
It's only done at pci-enable*() time (e.g. for devices which have bigger
MRRS after power-up), while e.g. the r8169 driver changes MRRS well
after pci-enable*().

This means it needs to stay in/below pcie_get_readrq(), and while it
could mean going to ops->write*, it would be a real mess parsing the
devices, PCIE capabilities etc.
Now it's basically a few lines in a seldom called routine in pci.c, and
the loongson case (and others) can be made simpler (and really fixed) as
well.
--=20
Krzysztof "Chris" Ha=C5=82asa

Sie=C4=87 Badawcza =C5=81ukasiewicz
Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
Al. Jerozolimskie 202, 02-486 Warszawa
