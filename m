Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 797E83AB1A5
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jun 2021 12:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbhFQKzZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Jun 2021 06:55:25 -0400
Received: from ni.piap.pl ([195.187.100.5]:58618 "EHLO ni.piap.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229716AbhFQKzZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Jun 2021 06:55:25 -0400
X-Greylist: delayed 470 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Jun 2021 06:55:24 EDT
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ni.piap.pl (Postfix) with ESMTPSA id 19B44262D06;
        Thu, 17 Jun 2021 12:45:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl 19B44262D06
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=piap.pl; s=mail;
        t=1623926725; bh=/GAGTzsVQ3rF3Gd4CVbH6kccb4OO46+ILGDCeTVqfYw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=fDhncHNjoaOWAxniEJMvu0J23jSNXPYu9LxgCb/NI9b4HXmcoQlboVO7v7Ab6SFap
         TYO1RoaQadmzg9uQjWk6qXavN3xSIfS3lwQ58WGTb9+qxF6YOwrOKt0N8eJ3gNa3Vu
         POMPSJAdgYS1uiQbiAvpRKUzPp9MGZmRt/qWGKig=
From:   =?utf-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Imre Kaloz <kaloz@openwrt.org>,
        Zoltan HERPAI <wigyori@uid0.hu>,
        Raylynn Knight <rayknight@me.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "John W. Linville" <linville@redhat.com>
Subject: Re: [PATCH v6] PCI: ixp4xx: Add a new driver for IXP4xx
References: <20210615232425.1253281-1-linus.walleij@linaro.org>
        <20210616151953.GA2973960@bjorn-Precision-5520>
        <CACRpkdZJTnrRwaDk+FB2Pzsytz0My0C+SdxdYjTn5YENQP5UoQ@mail.gmail.com>
Sender: khalasa@piap.pl
Date:   Thu, 17 Jun 2021 12:45:24 +0200
In-Reply-To: <CACRpkdZJTnrRwaDk+FB2Pzsytz0My0C+SdxdYjTn5YENQP5UoQ@mail.gmail.com>
        (Linus Walleij's message of "Thu, 17 Jun 2021 11:42:04 +0200")
Message-ID: <m37dis7osb.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-KLMS-Rule-ID: 4
X-KLMS-Message-Action: skipped
X-KLMS-AntiSpam-Status: not scanned, whitelist
X-KLMS-AntiPhishing: not scanned, whitelist
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, not scanned, whitelist
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Linus Walleij <linus.walleij@linaro.org> writes:

> I have tried to find these users but it seems they do not exist.
> users need to set IXP4XX_INDIRECT_PCI to make use of it
> and the only existing userspace for IXP4XX is OpenWrt and
> they do not enable this.

Right. OpenWrt =3D mostly routers and they're less likely to use such
peripherals.

> Krzysztof Halasa talks about using it for a VGA card at one
> point:

Right. It was some 10(+?) years ago, and it was more an experiment
than a regular use.

> The plan is to locate these users (if I can) and in case they
> need this use an idea from Linville for indirect PCI access,
> if they can provide testing (I have nothing to test on
> unfortunately...) I can't find Linville's patch right now but Arnd
> pointed it out to me.

I guess I could theoretically test it (I mean I still have the hardware,
somewhere) - but I would be extremely surprized if anyone needs it.

IXP4xx can address max 256 MB of RAM. Max 667 MHz single ARMv5TE core
(most CPUs in the 266 - 533 MHz range). This isn't hardware for doing
graphics (and it never was).

Chris.

--=20
Krzysztof Ha=C5=82asa

Sie=C4=87 Badawcza =C5=81ukasiewicz
Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
Al. Jerozolimskie 202, 02-486 Warszawa
