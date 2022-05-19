Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68BE552CC29
	for <lists+linux-pci@lfdr.de>; Thu, 19 May 2022 08:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiESGsP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 May 2022 02:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiESGsN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 May 2022 02:48:13 -0400
Received: from hobbes.mraw.org (hobbes.mraw.org [195.154.31.160])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3928664E5
        for <linux-pci@vger.kernel.org>; Wed, 18 May 2022 23:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mraw.org;
        s=mail2022; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ZVh+YAaKcOaOd7PiCqP4FzS+Ls8WRX7rEJkHNugStCY=; b=0ZTHZoGZj0MH9tvsJKcYCkycgM
        3N/0HfQuGk+iG6Um+lXucbzHdAA4tVZc0o+IC9iHXHChafFLgJGyBAymlOjjbiIyaeF6mrwHvkYHu
        IQzMDlHJh1ACTv5fB57AGqsR2mUkqkq2zbxoxbhHannNTC5LmADXLE2Nu8n0XLPqFK+iP+9qb9XiV
        oRFSXw271jzUsZ0B92J5x2AdwgwLh8nP5gzl67NM9nO68IdjlId36Uy0W099C72ifZaSG0M6WviVz
        kJ8rDnJO/1uv2oRwuhlIxCMH0J7JIq5KFucko7XNRTn9HG4KPyXwpegWLyDQ1w0MHHZ/UfsluLZV4
        qI5RoI9g==;
Received: from 82-64-171-251.subs.proxad.net ([82.64.171.251] helo=mraw.org)
        by hobbes.mraw.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <kibi@debian.org>)
        id 1nrZwv-000kNM-QQ; Thu, 19 May 2022 08:47:53 +0200
Date:   Thu, 19 May 2022 08:47:51 +0200
From:   Cyril Brulebois <kibi@debian.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jim Quinlan <jim2101024@gmail.com>, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, james.dutton@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] PCI: brcmstb: Fix regression regarding missing PCIe
 linkup
Message-ID: <20220519064751.ttyfj6tyd3n5pm25@mraw.org>
Organization: Debian
References: <20220518194211.20143-1-jim2101024@gmail.com>
 <20220518221830.GA12467@bhelgaas>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="v22k724qk4fbdqwj"
Content-Disposition: inline
In-Reply-To: <20220518221830.GA12467@bhelgaas>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--v22k724qk4fbdqwj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Bjorn Helgaas <helgaas@kernel.org> (2022-05-18):
> Cyril, if you have a chance to test this and verify that it fixes the
> regression, we may still be able to squeeze this into v5.18.
>=20
> I can add the Reported-by and Tested-by tags myself.

That looks good to me (some details below), and if that's no trouble
please use those:

  Reported-by: Cyril Brulebois <cyril@debamax.com>
  Tested-by: Cyril Brulebois <cyril@debamax.com>

> Jim Quinlan <jim2101024@gmail.com> (2022-05-18):
> > Please do not accept this commit until someone with a CM4 has tested
> > this solution; I have only emulated the problem and fix on different
> > platform.

Applying this patch on top of v5.18-rc7-48-gf993aed406ea, testing with a
CM4 mounted on a Compute Module 4 IO Board, the boot is fine again.

With an empty PCIe slot:

    root@rpi4-20220428:~# dmesg|grep -i pci
    [    0.158519] PCI: CLS 0 bytes, default 64
    [    3.374963] shpchp: Standard Hot Plug PCI Controller Driver version:=
 0.4
    [    3.375959] brcm-pcie fd500000.pcie: host bridge /scb/pcie@7d500000 =
ranges:
    [    3.375994] brcm-pcie fd500000.pcie:   No bus range found for /scb/p=
cie@7d500000, using [bus 00-ff]
    [    3.376042] brcm-pcie fd500000.pcie:      MEM 0x0600000000..0x0603ff=
ffff -> 0x00f8000000
    [    3.376096] brcm-pcie fd500000.pcie:   IB MEM 0x0000000000..0x003fff=
ffff -> 0x0400000000
    [    3.376837] brcm-pcie fd500000.pcie: PCI host bridge to bus 0000:00
    [    3.376864] pci_bus 0000:00: root bus resource [bus 00-ff]
    [    3.376886] pci_bus 0000:00: root bus resource [mem 0x600000000-0x60=
3ffffff] (bus address [0xf8000000-0xfbffffff])
    [    3.376950] pci 0000:00:00.0: [14e4:2711] type 01 class 0x060400
    [    3.377057] pci 0000:00:00.0: PME# supported from D0 D3hot
    [    3.379455] pci 0000:00:00.0: bridge configuration invalid ([bus 00-=
00]), reconfiguring
    [    3.698799] brcm-pcie fd500000.pcie: link down
    [    3.700816] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to=
 01
    [    3.700855] pci 0000:00:00.0: PCI bridge to [bus 01]
    [    3.701216] pcieport 0000:00:00.0: PME: Signaling with IRQ 51
    [    3.701621] pcieport 0000:00:00.0: AER: enabled with IRQ 51
    [    3.702134] pci_bus 0000:01: busn_res: [bus 01] is released
    [    3.702417] pci_bus 0000:00: busn_res: [bus 00-ff] is released

With a PCIe=E2=86=92quad-USB extension board, and keyboard + USB stick on i=
t:

    root@rpi4-20220428:~# dmesg|grep -i pci|grep -v input:
    [    0.157680] PCI: CLS 0 bytes, default 64
    [    3.374070] shpchp: Standard Hot Plug PCI Controller Driver version:=
 0.4
    [    3.375080] brcm-pcie fd500000.pcie: host bridge /scb/pcie@7d500000 =
ranges:
    [    3.375116] brcm-pcie fd500000.pcie:   No bus range found for /scb/p=
cie@7d500000, using [bus 00-ff]
    [    3.375166] brcm-pcie fd500000.pcie:      MEM 0x0600000000..0x0603ff=
ffff -> 0x00f8000000
    [    3.375211] brcm-pcie fd500000.pcie:   IB MEM 0x0000000000..0x003fff=
ffff -> 0x0400000000
    [    3.375946] brcm-pcie fd500000.pcie: PCI host bridge to bus 0000:00
    [    3.375972] pci_bus 0000:00: root bus resource [bus 00-ff]
    [    3.375993] pci_bus 0000:00: root bus resource [mem 0x600000000-0x60=
3ffffff] (bus address [0xf8000000-0xfbffffff])
    [    3.376057] pci 0000:00:00.0: [14e4:2711] type 01 class 0x060400
    [    3.376164] pci 0000:00:00.0: PME# supported from D0 D3hot
    [    3.428109] brcm-pcie fd500000.pcie: link up, 5.0 GT/s PCIe x1 (SSC)
    [    3.428175] pci 0000:01:00.0: [1106:3483] type 00 class 0x0c0330
    [    3.428219] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00000fff 6=
4bit]
    [    3.428346] pci 0000:01:00.0: PME# supported from D0 D3cold
    [    3.430673] pci 0000:00:00.0: BAR 14: assigned [mem 0x600000000-0x60=
00fffff]
    [    3.430706] pci 0000:01:00.0: BAR 0: assigned [mem 0x600000000-0x600=
000fff 64bit]
    [    3.430742] pci 0000:00:00.0: PCI bridge to [bus 01]
    [    3.430761] pci 0000:00:00.0:   bridge window [mem 0x600000000-0x600=
0fffff]
    [    3.430976] pcieport 0000:00:00.0: enabling device (0000 -> 0002)
    [    3.431150] pcieport 0000:00:00.0: PME: Signaling with IRQ 51
    [    3.431552] pcieport 0000:00:00.0: AER: enabled with IRQ 51
    [    3.431765] pci 0000:01:00.0: enabling device (0000 -> 0002)

Both keyboard and storage on USB work fine.

> > commit 830aa6f29f07 ("PCI: brcmstb: Split brcm_pcie_setup() into two
> > funcs")
> >=20
> > as the first failing commit.  This commit is a regression, but is
> > unrelated and was fixed by a subsequent commit in the original
> > patchset.

For completeness, since the original patchset was merged before
v5.17-rc1, I verified that the latest release from the linux-5.17.y
branch (i.e. v5.17.9) is also broken in the same way (not surprising
but I thought I'd check anyway):

    [    1.952374] Kernel panic - not syncing: Asynchronous SError Interrupt

Testing this patch on top of v5.17.9, it also fixes the boot there (with
or without the extension board on the PCIe slot), so it looks to me this
patch could get cc'ed to stable for inclusion into the linux-5.17.y
branch.


Please let me know if you need more testing/feedback.


Cheers,
--=20
Cyril Brulebois (kibi@debian.org)            <https://debamax.com/>
D-I release manager -- Release team member -- Freelance Consultant

--v22k724qk4fbdqwj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEtg6/KYRFPHDXTPR4/5FK8MKzVSAFAmKF6BMACgkQ/5FK8MKz
VSBu/Q/+OLEWl2ywF6zYxLHTZD9LXRhfhgV7pvcAMJJerJOiFmfza3cOzhAw3yZv
7c9klGFWjmdseLLxeLdFboMAnuQ/f1GhJiBmoT1K2lahNHe76R38vt3Up4SqWpVY
9XAP/nM00cdH8DJ0T4k+0li4bGoXA4o4Ihnmq3NNObdooJHqw9qFFrFB8ZW4Kq9I
+lsBBSAA9Alf3OBypYJsFnTpc2sCjGtafaEjCdVZwmj772EcEpbrS03ygh2WWjH9
RYmWme5sCgH+a9y9LexdpKG9fjGFuhwRFYWg7dwVd2IgJEXd+0dTye4JO6PpqFix
5BWvAopZyCWgMqbA/B4brcooKWCBxLqGmEO+/m9B7Mg/CGe1RcLGlVIu6eeaRUOo
jylQgtDcm7b4pvMpMawxC8uYaRqfowpa7cmTe3EWviOkzdKPSzir3Jx8m6YNfNUN
O7zx3aSb3VWxIFIc7R4DUO7M5X/EIHX2roHKgrQlUG0qpvpl3B1SIdG9hwADuYuO
XkNszzfQjpIbKfdaqoT5B7CGTuN6USty6niqSNgQxthI6zbc4XdTzKA5ZzWNBdta
Uwnz07lju/OOcOKBo/i1NoMDkBTOG9Mj9WtexEL1I6SeFgoPo4PX/+0h0Pn8nCnT
UQlZjezFYP/WQNOnx2SlwAschTpvsJbZWqsk9AEa859A8NYzgaU=
=Z39r
-----END PGP SIGNATURE-----

--v22k724qk4fbdqwj--
