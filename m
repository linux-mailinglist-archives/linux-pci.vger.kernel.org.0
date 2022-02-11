Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44494B267A
	for <lists+linux-pci@lfdr.de>; Fri, 11 Feb 2022 13:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbiBKMvL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Feb 2022 07:51:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350310AbiBKMvI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Feb 2022 07:51:08 -0500
X-Greylist: delayed 600 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Feb 2022 04:51:04 PST
Received: from ni.piap.pl (ni.piap.pl [195.187.100.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F17E60;
        Fri, 11 Feb 2022 04:51:04 -0800 (PST)
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
        by ni.piap.pl (Postfix) with ESMTPSA id A03BFC3F3EF3;
        Fri, 11 Feb 2022 13:31:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl A03BFC3F3EF3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=piap.pl; s=mail;
        t=1644582669; bh=vrnOCz2NomAXmrx0f/P+Vxs/1qaeoeQZUYqZcethPZM=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ioDj6vgYLexSO6/P/YS7xj5X+MHUqhZNuyqqDndPm1CEV3MAZON2EKMc8eIr0Zpon
         jCb8D2vB8Ae5Ic8G+8qbRdXdaqz0MSD1hkfm7kOEk9BbKJnDeZTWucfU4Jm7IyjxLX
         +Vj4Qe78Vc2PEobT1c8qXg71qAeZm1iSYHdK3oSg=
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
Date:   Fri, 11 Feb 2022 13:31:08 +0100
In-Reply-To: <20220208234023.GA505306@bhelgaas> (Bjorn Helgaas's message of
        "Tue, 8 Feb 2022 17:40:23 -0600")
Message-ID: <m3o83dvb3n.fsf@t19.piap.pl>
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

Bjorn,

> Krzysztof, you're running v5.14, which includes Krzysztof W's work,
> but that shouldn't affect the imx6_pcie_probe()/pci_sysfs_init()
> ordering.  Your log shows the error in imx6_pcie_probe().
>
> Would you mind adding the patch below and attaching a complete dmesg
> log to the bugzilla?

Sure. In fact I was using 5.16-rc4 (with the media tree) lately, without
the fix from the other Krzysztof, and, as I can now see, it worked
without the problem in question.

I switched it to 5.14 I was using previously, reverted the fix, added
your patch, and tried again. It booted 100+ times without experiencing
the problem, too.

I will try again with the previous 5.14-rc3+ (which needed the fix) next
week. Perhaps it was an unrelated bug affecting 5.14-rc only (fixed
before final 5.14)? I haven't checked back then if 5.14 needed the fix,
most probably I've simply rebased from rc3+ to final.

The other possibility is changed .config. Or, I don't know, the gcc
versions. We will see.
--=20
Krzysztof "Chris" Ha=C5=82asa

Sie=C4=87 Badawcza =C5=81ukasiewicz
Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
Al. Jerozolimskie 202, 02-486 Warszawa
