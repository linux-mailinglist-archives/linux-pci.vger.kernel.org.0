Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8700495A9E
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jan 2022 08:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343489AbiAUHYz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jan 2022 02:24:55 -0500
Received: from ni.piap.pl ([195.187.100.5]:57256 "EHLO ni.piap.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245477AbiAUHYz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Jan 2022 02:24:55 -0500
X-Greylist: delayed 603 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Jan 2022 02:24:55 EST
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
        by ni.piap.pl (Postfix) with ESMTPSA id 6440DC3F3EDF;
        Fri, 21 Jan 2022 08:14:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl 6440DC3F3EDF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=piap.pl; s=mail;
        t=1642749288; bh=gGNbanSwWXMu21C4JkM/lsSy+zDuwl4CRiCXbsqVfmw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Q/ilh0KrCSi27knvkHT5j4nsmPCKPV3JhfpDhjXZWEUlYFvyQUkVDj4lLxsdFHdMJ
         RjOJE8LrY/+XcKk+VSYuaDZdp/cWySbVc21ULLmQkm1ihOAwo3mLVhsc8d2t94FftL
         ZSzj1L7Gsbs36QBHfkX5nJaR5DF+vozJro4dsUjg=
From:   =?utf-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: PCI: Race condition in pci_create_sysfs_dev_files (can't boot)
References: <20220120230050.GA1077958@bhelgaas>
Sender: khalasa@piap.pl
Date:   Fri, 21 Jan 2022 08:14:46 +0100
In-Reply-To: <20220120230050.GA1077958@bhelgaas> (Bjorn Helgaas's message of
        "Thu, 20 Jan 2022 17:00:50 -0600")
Message-ID: <m3bl05zhjt.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-KLMS-Rule-ID: 3
X-KLMS-Message-Action: skipped
X-KLMS-AntiSpam-Status: not scanned, whitelist
X-KLMS-AntiPhishing: not scanned, whitelist
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, not scanned, whitelist
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn, Krzysztof,

Bjorn Helgaas <helgaas@kernel.org> writes:

> On Fri, Jul 30, 2021 at 10:18:44AM +0200, Krzysztof Ha=C5=82asa wrote:
>> I'm encountering a problem booting an i.MX6-based device (Gateworks
>> Ventana SBC). This is apparently a known issue:
>> https://lkml.org/lkml/2020/7/16/388

> Hi Krzysztof, is this still an issue?

Well... I'm still using i.MX6 with 5.14 and Krzysiek Wilczy=C5=84ski's "PCI:
Race condition in pci_create_sysfs_dev_files (can't boot)" patch (which
fixes the problem). It seems parts of this patch are now in mainline,
but most of it is still missing. So I guess the problem isn't fixed.

Perhaps because the DEC Alpha part of the patch is not yet ready?
Krzysztof?

> e1d3f3268b0e ("PCI/sysfs: Convert "config" to static attribute") and
> similar patches appeared in v5.13,

Right, but they hadn't fixed the problem. 5.13 was released in June, and
I have started using the patch in August (apparently with pre-5.14
first, then with final 5.14).
--=20
Krzysztof "Chris" Ha=C5=82asa

Sie=C4=87 Badawcza =C5=81ukasiewicz
Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
Al. Jerozolimskie 202, 02-486 Warszawa
