Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB3743EBBEE
	for <lists+linux-pci@lfdr.de>; Fri, 13 Aug 2021 20:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbhHMSTQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Aug 2021 14:19:16 -0400
Received: from ni.piap.pl ([195.187.100.5]:51452 "EHLO ni.piap.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229607AbhHMSTN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Aug 2021 14:19:13 -0400
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
        by ni.piap.pl (Postfix) with ESMTPSA id BE5DDC3694D5;
        Fri, 13 Aug 2021 20:18:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl BE5DDC3694D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=piap.pl; s=mail;
        t=1628878724; bh=NVDSKyv7tsdrcUXHfz6e7Pjm4BQy3eCLcMPq+7bG+QY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=HOnuku6JPKA6MWjtgUGeLPiplT1hrqdebmpQ1L248/WnCCH3acRboIN29aMxPBdAX
         dfourjF86DBozXkyC7lnb5vCaSTP7J1p1pZv9HMKCUQ6g9LK3dzZs13xjzTtXw3RUM
         0orltoHrHsu7NInM0/MwW3lFQJaV9IOWvsvRIXA4=
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
Subject: Re: [PATCH] PCIe: limit Max Read Request Size on i.MX to 512 bytes
References: <m37dgp20cr.fsf@t19.piap.pl>
        <CAL_JsqL1bPwbPB-3y6s0d6XoNkjrSzpbx=p7BcTq8UyTbh8pvw@mail.gmail.com>
Sender: khalasa@piap.pl
Date:   Fri, 13 Aug 2021 20:18:44 +0200
In-Reply-To: <CAL_JsqL1bPwbPB-3y6s0d6XoNkjrSzpbx=p7BcTq8UyTbh8pvw@mail.gmail.com>
        (Rob Herring's message of "Fri, 13 Aug 2021 08:45:43 -0500")
Message-ID: <m3v949ky2j.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Lua-Profiles: 165564 [Aug 13 2021]
X-KLMS-AntiSpam-Version: 5.9.20.0
X-KLMS-AntiSpam-Envelope-From: khalasa@piap.pl
X-KLMS-AntiSpam-Rate: 0
X-KLMS-AntiSpam-Status: not_detected
X-KLMS-AntiSpam-Method: none
X-KLMS-AntiSpam-Auth: dkim=pass header.d=piap.pl
X-KLMS-AntiSpam-Info: LuaCore: 454 454 39c6e442fd417993330528e7f9d13ac1bf7fdf8c, {Tracking_arrow_text}, {Tracking_Text_ENG_RU_Has_Extended_Latin_Letters, eng}, {Tracking_marketers, three}, {Tracking_from_domain_doesnt_match_to}, t19.piap.pl:7.1.1;piap.pl:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-MS-Exchange-Organization-SCL: -1
X-KLMS-AntiSpam-Interceptor-Info: scan successful
X-KLMS-AntiPhishing: Clean, bases: 2021/08/13 14:41:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2021/08/13 16:28:00 #17028567
X-KLMS-AntiVirus-Status: Clean, skipped
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Rob,

Rob Herring <robh@kernel.org> writes:

>> +++ b/drivers/pci/Kconfig
>> @@ -34,6 +34,9 @@ config PCI_DOMAINS_GENERIC
>>  config PCI_SYSCALL
>>         bool
>>
>> +config NEED_PCIE_MAX_MRRS
>
> We don't need a config option for this. It's not much code and it will
> effectively always be enabled with multi-platform kernels.

But... non-ARM kernels?
Then perhaps #if CONFIG_ARM?
--=20
Krzysztof "Chris" Ha=C5=82asa

Sie=C4=87 Badawcza =C5=81ukasiewicz
Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
Al. Jerozolimskie 202, 02-486 Warszawa
