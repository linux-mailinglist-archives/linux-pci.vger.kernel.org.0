Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5184A4671
	for <lists+linux-pci@lfdr.de>; Mon, 31 Jan 2022 12:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350536AbiAaL6X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jan 2022 06:58:23 -0500
Received: from ni.piap.pl ([195.187.100.5]:39372 "EHLO ni.piap.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1359597AbiAaL4Z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 31 Jan 2022 06:56:25 -0500
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
        by ni.piap.pl (Postfix) with ESMTPSA id 75D85C3F3EF4;
        Mon, 31 Jan 2022 12:56:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl 75D85C3F3EF4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=piap.pl; s=mail;
        t=1643630179; bh=/+mLaOy/51TWJQwY1+C7KvOgFe0ubYBePwOJGJ3IXvM=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=K+tGCoIgRmsF/33DcDBfv/wNu/hz4XBXLkxRSRFqEW6E63nPRc0p6iDVzVdTshPh1
         BCnvamxWBw//dw2/YT4ba8wjG8vTi+/7VcWQvj5cDJxSM+TJaCjdGU2woAy3i3DH0D
         dO9wt1A+6X704q43Qdcts9vm6LXH99S5Q8oyRXhY=
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
References: <20220121165707.GA1129091@bhelgaas>
Sender: khalasa@piap.pl
Date:   Mon, 31 Jan 2022 12:56:18 +0100
In-Reply-To: <20220121165707.GA1129091@bhelgaas> (Bjorn Helgaas's message of
        "Fri, 21 Jan 2022 10:57:07 -0600")
Message-ID: <m38ruwxgnx.fsf@t19.piap.pl>
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

Bjorn Helgaas <helgaas@kernel.org> writes:

> Thanks.  e1d3f3268b0e and related patches converted individual files
> ("config", "rom", "vpd", etc) to static attributes, but since the
> problem you're seeing is with a directory, it's likely different.
>
> I opened this bugzilla report to try to keep this from getting lost:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D215515

Ok, thanks.
--=20
Krzysztof "Chris" Ha=C5=82asa

Sie=C4=87 Badawcza =C5=81ukasiewicz
Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
Al. Jerozolimskie 202, 02-486 Warszawa
