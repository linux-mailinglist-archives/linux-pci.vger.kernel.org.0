Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9A223EE5B2
	for <lists+linux-pci@lfdr.de>; Tue, 17 Aug 2021 06:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbhHQEaA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Aug 2021 00:30:00 -0400
Received: from ni.piap.pl ([195.187.100.5]:55804 "EHLO ni.piap.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230073AbhHQEaA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Aug 2021 00:30:00 -0400
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
        by ni.piap.pl (Postfix) with ESMTPSA id 3ABF7C3F2A51;
        Tue, 17 Aug 2021 06:29:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl 3ABF7C3F2A51
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=piap.pl; s=mail;
        t=1629174566; bh=wlaIEKAXV27quyxEnzSIG06RF0UZM8Yvm+kUuRMp01o=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=JKYoS05j2iuCyl77xj+x6tJoKUnHp7X+pkuIFIsy+8M/U2OiDhAnoFKbha9/hAiw8
         GWNbSESo0Ug/teijL5CAWsxeAoFA2nEWnDlmiJhZ5BT+Ev4QyQ7XqEufH/nSk6IJXk
         gsyEgqCWgUgPZexfntPTWpa6Oa+8yi4BcPThFhz4=
From:   =?utf-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
To:     Rob Herring <robh@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        PCI <linux-pci@vger.kernel.org>,
        Artem Lapkin <email2tema@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84s?= =?utf-8?Q?ki?= 
        <kw@linux.com>, Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] PCIe: limit Max Read Request Size on i.MX to 512 bytes
References: <m3k0klzl1x.fsf@t19.piap.pl>
        <CAL_Jsq+M7xdqf8bVhs-isHoGCGjLhi6N2q+tm7msWLBy52OsMw@mail.gmail.com>
Sender: khalasa@piap.pl
Date:   Tue, 17 Aug 2021 06:29:26 +0200
In-Reply-To: <CAL_Jsq+M7xdqf8bVhs-isHoGCGjLhi6N2q+tm7msWLBy52OsMw@mail.gmail.com>
        (Rob Herring's message of "Mon, 16 Aug 2021 14:34:00 -0500")
Message-ID: <m3fsv8zobd.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Lua-Profiles: 165596 [Aug 17 2021]
X-KLMS-AntiSpam-Version: 5.9.20.0
X-KLMS-AntiSpam-Envelope-From: khalasa@piap.pl
X-KLMS-AntiSpam-Rate: 0
X-KLMS-AntiSpam-Status: not_detected
X-KLMS-AntiSpam-Method: none
X-KLMS-AntiSpam-Auth: dkim=pass header.d=piap.pl
X-KLMS-AntiSpam-Info: LuaCore: 454 454 39c6e442fd417993330528e7f9d13ac1bf7fdf8c, {Tracking_arrow_text}, {Tracking_Text_ENG_RU_Has_Extended_Latin_Letters, eng}, {Tracking_marketers, three}, {Tracking_from_domain_doesnt_match_to}, piap.pl:7.1.1;t19.piap.pl:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-MS-Exchange-Organization-SCL: -1
X-KLMS-AntiSpam-Interceptor-Info: scan successful
X-KLMS-AntiPhishing: Clean, bases: 2021/08/17 03:39:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2021/08/17 02:51:00 #17049510
X-KLMS-AntiVirus-Status: Clean, skipped
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Rob Herring <robh@kernel.org> writes:

>> +#ifdef CONFIG_ARM
>> +       if (rq > max_pcie_mrrs)
>> +               rq =3D max_pcie_mrrs;
>> +#endif
>
> My objection wasn't having another kconfig option so much as I don't
> think we need one at all here unless Bjorn feels otherwise. It's 2
> bytes of data and about 3 instructions (load, cmp, store).
>
> If we do have a config option, using or basing on the arch is wrong.
> Has nothing to do with the arch. Are the other platforms needing this
> arm32 as well?

Yes,

I can buy the "universal ARM32 kernel" argument, but otherwise it's just
nonfunctional bloat. A small one, yes.
--=20
Krzysztof "Chris" Ha=C5=82asa

Sie=C4=87 Badawcza =C5=81ukasiewicz
Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
Al. Jerozolimskie 202, 02-486 Warszawa
