Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCFF33ECDF5
	for <lists+linux-pci@lfdr.de>; Mon, 16 Aug 2021 07:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233001AbhHPFTJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Aug 2021 01:19:09 -0400
Received: from ni.piap.pl ([195.187.100.5]:32894 "EHLO ni.piap.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229523AbhHPFTJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Aug 2021 01:19:09 -0400
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
        by ni.piap.pl (Postfix) with ESMTPSA id 17D8CC3F2A57;
        Mon, 16 Aug 2021 07:18:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl 17D8CC3F2A57
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=piap.pl; s=mail;
        t=1629091114; bh=2echCi4pjmtL2m5KAuC5Qg92knY9kIQM3wV9qOzNp0o=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=EDOypOD/p7sMjPuKr0+ODenT/LCdLqpkh6j+Hi9E79XkdR2lOK6yD8hTByS8UXyjM
         6eJsKElo47zjNzrGoysd6auffOIZoxs6ZFAj2S0ld8TB21+RCWzRlRwx4t9uvlJfAW
         uEU1mEgrpMjFpGQpT2EKAa1VT8K6r9Wl/ROdyi98=
From:   =?utf-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Artem Lapkin <email2tema@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCIe: limit Max Read Request Size on i.MX to 512 bytes
References: <20210813192254.GA2604116@bjorn-Precision-5520>
Sender: khalasa@piap.pl
Date:   Mon, 16 Aug 2021 07:18:33 +0200
In-Reply-To: <20210813192254.GA2604116@bjorn-Precision-5520> (Bjorn Helgaas's
        message of "Fri, 13 Aug 2021 14:22:54 -0500")
Message-ID: <m3wnomynkm.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Lua-Profiles: 165565 [Aug 16 2021]
X-KLMS-AntiSpam-Version: 5.9.20.0
X-KLMS-AntiSpam-Envelope-From: khalasa@piap.pl
X-KLMS-AntiSpam-Rate: 0
X-KLMS-AntiSpam-Status: not_detected
X-KLMS-AntiSpam-Method: none
X-KLMS-AntiSpam-Auth: dkim=pass header.d=piap.pl
X-KLMS-AntiSpam-Info: LuaCore: 454 454 39c6e442fd417993330528e7f9d13ac1bf7fdf8c, {Tracking_Text_ENG_RU_Has_Extended_Latin_Letters, eng}, {Tracking_marketers, three}, {Tracking_from_domain_doesnt_match_to}, piap.pl:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;t19.piap.pl:7.1.1;127.0.0.199:7.1.2
X-MS-Exchange-Organization-SCL: -1
X-KLMS-AntiSpam-Interceptor-Info: scan successful
X-KLMS-AntiPhishing: Clean, bases: 2021/08/16 04:40:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2021/08/15 23:54:00 #17042267
X-KLMS-AntiVirus-Status: Clean, skipped
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bjorn Helgaas <helgaas@kernel.org> writes:

>> TBH I don't think of this as of a "quirk" - all systems have MRRS
>> limits, it just happens that these ones have their limit lower than 4096
>> bytes. This isn't a limitation of a particular PCIe device, this is a
>> common limit of the whole system.
>
> Do you have a reference for this?  I don't see anything in the PCIe
> spec that suggests platforms must limit MRRS, and it seems that only
> these ARM-related controllers have this issue.

I meant there is always a limit - isn't Max_Read_Request_Size a limit?
Device Control Register (Offset 08h) Bit Location 14:12
Max_Read_Request_Size allows for max 4096 bytes, though two values are
reserved, so there is room for some easy extension.

- non-ARM (non-DWC?) systems are limited to 4096 bytes
- DWC-based systems are limited to 128, 256, 512 bytes (are there
  4096-byte ones?)

That's how I understand it, please correct me if I'm wrong.
--=20
Krzysztof "Chris" Ha=C5=82asa

Sie=C4=87 Badawcza =C5=81ukasiewicz
Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
Al. Jerozolimskie 202, 02-486 Warszawa
