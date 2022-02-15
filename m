Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7706D4B639F
	for <lists+linux-pci@lfdr.de>; Tue, 15 Feb 2022 07:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiBOGfr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Feb 2022 01:35:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234572AbiBOGfo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Feb 2022 01:35:44 -0500
Received: from ni.piap.pl (ni.piap.pl [195.187.100.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7255FB152C;
        Mon, 14 Feb 2022 22:35:31 -0800 (PST)
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
        by ni.piap.pl (Postfix) with ESMTPSA id 12541C3F2A51;
        Tue, 15 Feb 2022 07:35:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl 12541C3F2A51
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=piap.pl; s=mail;
        t=1644906929; bh=c5b+LcvuGmpR0VUI74j1aAULUejbVi0ii7vQKTAYMwE=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=iQEABUQoh9Dbxeg1eolGietOPCW+nkb0hUE+Dj/adG9m+mVzjJs/d7mGxhLxPAEWQ
         orCvf1iycDOJ7Bxhvze/1ZCXDuLwKTTW+KiE0rqysmMab9KmxWwgZ+hNskZrZMm1Op
         VT5+9rD1Xl028mBIqxtm94ziOOIdbHs3/Xjf+np0=
From:   =?utf-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Koen Vandeputte <koen.vandeputte@citymesh.com>,
        Dexuan Cui <dexuan.linux@gmail.com>
Subject: Re: PCI: Race condition in pci_create_sysfs_dev_files (can't boot)
References: <20220208234023.GA505306@bhelgaas>
Sender: khalasa@piap.pl
Date:   Tue, 15 Feb 2022 07:35:28 +0100
In-Reply-To: <20220208234023.GA505306@bhelgaas> (Bjorn Helgaas's message of
        "Tue, 8 Feb 2022 17:40:23 -0600")
Message-ID: <m3czjovdqn.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-KLMS-Rule-ID: 3
X-KLMS-Message-Action: skipped
X-KLMS-AntiSpam-Status: not scanned, whitelist
X-KLMS-AntiPhishing: not scanned, whitelist
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, not scanned, whitelist
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Bjorn Helgaas <helgaas@kernel.org> writes:

> Koen collected some interesting logs at
> https://lore.kernel.org/all/cd4812f0-1de3-0582-936c-ba30906595af@citymesh=
.com/
> They're from v5.10, which was before all of Krzysztof W's nice work
> converting to static attributes, but Koen's log shows the error
> happening in the pci_sysfs_init() initcall, which is *after*
> imx6_pcie_probe():
>
>   imx6_pcie_probe                # probably device initcall (level 6)
>     ...
>       pci_create_sysfs_dev_files
>
>   pci_sysfs_init                 # late initcall (level 7)
>     pci_create_sysfs_dev_files
>       "sysfs: cannot create duplicate filename"

Well, imx6_pcie_probe() is called indirectly by
platform_driver_register(). I guess it doesn't know about the initcall
ordering, after it's registered.

It looks like the problem is the imx6_pcie_probe() (via
dw_pcie_host_init() -> pci_host_probe()) is interfering with
pci_sysfs_init(). This may eventually cause some invalid memory access
as well.

BTW I thought for a moment that maybe 5.14 is free from this. I was
wrong. The problem doesn't manifest itself on my custom i.MX6 device
(using Tinyrex CPU module from Voipac/Fedevel, perhaps because I don't
use any PCI devices there). It does on Ventana SBC from Gateworks,
though. BTW the above (and below) is v5.16.

It goes like this:
[0.096212] do_initcall_level: 6
[0.105625] imx6_pcie_init
[0.106106] imx6_pcie_probe       <<<<<<<<<<<<<<<<<<<<<
[0.106412] imx6q-pcie 1ffc000.pcie: host bridge /soc/pcie@1ffc000 ranges:

[0.322613] imx6q-pcie 1ffc000.pcie: Link up
[0.322776] imx6q-pcie 1ffc000.pcie: PCI host bridge to bus 0000:00
[0.322790] pci_bus 0000:00: root bus resource [bus 00-ff]

[0.405251] do_initcall_level: 6 ENDs but imx6_pcie_probe() still active
[0.405262] do_initcall_level: 7

[0.410393] pci_sysfs_init        <<<<<<<<<<<<<<<<<<<<<
[0.410423] pci 0000:00:00.0: pci_create_sysfs_dev_files

[0.410532] [<8068091c>] (pci_create_sysfs_dev_files)
[0.410551] [<80918710>] (pci_sysfs_init)
[0.410568] [<8010166c>] (do_one_initcall)

[0.410717] pci_sysfs_init END    <<<<<<<<<<<<<<<<<<<<<

[0.533843] [<803f1c74>] (pci_bus_add_devices)
[0.533862] [<803f574c>] (pci_host_probe)
[0.533879] [<80414310>] (dw_pcie_host_init)
[0.533895] [<80681ac8>] (imx6_pcie_probe)
[0.533915] [<8045e9e4>] (platform_probe)
(Repeats multiple times, I guess for each PCI device)

[0.543893] imx6_pcie_probe END   <<<<<<<<<<<<<<<<<<<<<

[0.692244] do_initcall_level: 7 END
--=20
Krzysztof "Chris" Ha=C5=82asa

Sie=C4=87 Badawcza =C5=81ukasiewicz
Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
Al. Jerozolimskie 202, 02-486 Warszawa
