Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E010C52252B
	for <lists+linux-pci@lfdr.de>; Tue, 10 May 2022 22:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbiEJUH1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 May 2022 16:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbiEJUH0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 May 2022 16:07:26 -0400
Received: from hobbes.mraw.org (hobbes.mraw.org [195.154.31.160])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6FA50E22
        for <linux-pci@vger.kernel.org>; Tue, 10 May 2022 13:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mraw.org;
        s=mail2022; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=xxllNxSYnBGocEg304pIBtFocb85+IfXJze12rpGvDw=; b=WJqJBQ85jse11tH0ssMiQnN/C8
        JwvI3/nX2ajpjDflQjB3YefDYGwqm6BwjuQCptMxI6jbor17HtjXZyAbkdD2z5m8SvnUhtQyWeWLO
        TqWI5w4nhHCXu08uuk7vbcNVNPDk0BrEmmAdDQuQaaV3O07VlylHIqpnNeovu0TU58YgzJJ09Wowr
        JduZaof9nsPXzCu2U5JOAhDl4r/Cm/Sv0UiarQbp3VbOS/mNjC6D6CWwx5jhIYfp0Yn+M/YdVxMBH
        /wNL4i1CMvrqkGLzNCzHxX/AgQek3G4vgOdkD3K8J3NgB1HuWHVikqRkjjTWVdDOSyzd50qElyM3H
        KE6m+7gg==;
Received: from 82-64-171-251.subs.proxad.net ([82.64.171.251] helo=mraw.org)
        by hobbes.mraw.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <kibi@debian.org>)
        id 1noW8V-004Fui-1k; Tue, 10 May 2022 22:07:11 +0200
Date:   Tue, 10 May 2022 22:07:09 +0200
From:   Cyril Brulebois <kibi@debian.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Jim Quinlan <jim2101024@gmail.com>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Linux PCI <linux-pci@vger.kernel.org>, bjorn@helgaas.com
Subject: Re: [Bug 215925] New: PCIe regression on Raspberry Pi Compute Module
 4 (CM4) breaks booting
Message-ID: <20220510200709.vudemjipdvm2tpkq@mraw.org>
Organization: Debian
References: <20220509174527.zoqhmaxfwo7udezo@mraw.org>
 <20220510172243.GA684299@bhelgaas>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yxzemvw5bqlaizir"
Content-Disposition: inline
In-Reply-To: <20220510172243.GA684299@bhelgaas>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--yxzemvw5bqlaizir
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Bjorn Helgaas <helgaas@kernel.org> (2022-05-10):
> What if you revert 830aa6f29f07 and the subsequent brcmstb patches?
>=20
>   11ed8b8624b8 ("PCI: brcmstb: Do not turn off WOL regulators on suspend")
>   93e41f3fca3d ("PCI: brcmstb: Add control of subdevice voltage regulator=
s")
>   67211aadcb4b ("PCI: brcmstb: Add mechanism to turn on subdev regulators=
")
>   830aa6f29f07 ("PCI: brcmstb: Split brcm_pcie_setup() into two funcs")
>=20
>   $ git revert 11ed8b8624b8 93e41f3fca3d 67211aadcb4b 830aa6f29f07
>=20
> I did that on current upstream: 9be9ed2612b5 ("Merge tag
> 'platform-drivers-x86-v5.18-4' of
> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86")
> and it built fine on x86.

I've done exactly that, and it boots again. Comparing kernel messages
against an older version (5.10.106), I'm getting the same output on that
bare CM4 on CM4 IO Board setup:

    # dmesg|grep -i pcie
    [    3.368620] brcm-pcie fd500000.pcie: host bridge /scb/pcie@7d500000 =
ranges:
    [    3.368654] brcm-pcie fd500000.pcie:   No bus range found for /scb/p=
cie@7d500000, using [bus 00-ff]
    [    3.368703] brcm-pcie fd500000.pcie:      MEM 0x0600000000..0x0603ff=
ffff -> 0x00f8000000
    [    3.368748] brcm-pcie fd500000.pcie:   IB MEM 0x0000000000..0x003fff=
ffff -> 0x0400000000
    [    3.421094] brcm-pcie fd500000.pcie: link up, 5.0 GT/s PCIe x1 (SSC)
    [    3.421341] brcm-pcie fd500000.pcie: PCI host bridge to bus 0000:00

And with a PCIe =E2=86=92 quad-USB board plugged in, I'm getting those
additional lines:

    [    3.426842] pcieport 0000:00:00.0: enabling device (0000 -> 0002)
    [    3.427072] pcieport 0000:00:00.0: PME: Signaling with IRQ 51
    [    3.427472] pcieport 0000:00:00.0: AER: enabled with IRQ 51

(It seems to be consistently IRQ 51 with 5.18.0-rc6+ while it seems to
be consistently IRQ 52 on 5.10.106, but the output is very similar in
both cases.)

And plugging a keyboard on one of those USB ports works fine:

    [   13.406351] input: Logitech USB Keyboard as /devices/platform/scb/fd=
500000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/usb1/1-1/1-1.2/1-1.2:1.0/0=
003:046D:C31C.0001/input/input0
    [   13.510144] input: Logitech USB Keyboard Consumer Control as /device=
s/platform/scb/fd500000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/usb1/1-1/=
1-1.2/1-1.2:1.1/0003:046D:C31C.0002/input/input2
    [   13.591345] input: Logitech USB Keyboard System Control as /devices/=
platform/scb/fd500000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/usb1/1-1/1-=
1.2/1-1.2:1.1/0003:046D:C31C.0002/input/input3


Wrapping up: it boots again (with or without PCIe equipment plugged in),
and PCIe seems functional.

I'm happy to test more patches (e.g. trying to fix the actual issue
without going for a set of reverts).


Cheers,
--=20
Cyril Brulebois (kibi@debian.org)            <https://debamax.com/>
D-I release manager -- Release team member -- Freelance Consultant

--yxzemvw5bqlaizir
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEtg6/KYRFPHDXTPR4/5FK8MKzVSAFAmJ6xeIACgkQ/5FK8MKz
VSAGQA//ZeZ9CY1WC8nnMlgYKICJQZiftTiIe0jRCFE6Q5h+hGAgHzhOzB6f63aF
l0GA/og3JOCz2M3q94Yd1nJUT8PCgQ4o/S2hojhb9GXbdd8hmgC5/D2Zf5QcP8xk
+oHjF//f/Q5s1yGdB5y4EiopF70/MONgIL6stEo8Tjv/7pBOp7ejJ1MMXI2KDzOy
Ro/3kZTd1W36Od2SK2DpBMaYXv2pNRbXRDaE9RfMthDXzzkAKnzB4w5h564hQUgt
IJtPQa8s6E/8OlD9sYkuykffhi0yJHQyuogll7ZUrpiZSYJxIrk1EUkQcCA7howN
+bN6vaP1v74ny8W/YjCNi6ca2ctIuNYiGqLF36C755vxitivwOzwo/MF2HMTb5Ei
8/ENRlhJ54Pkxdype04c5q/XslE/ZldnrZYDj/5+6s6AfanRUqI6VWyGWDcrL0ZS
h/hrYAi3t+Q7eqPB/8SaXdFlLGgtYnpCnbEF1/25Ze2ob8QGZTVBbnXbGOUlEP2U
Jzr1yeoq3XrZGBPt1Id6WtE5nLBzJleaAgy/N96SpIrKKhxJ5aPyGryDExyC6FJp
qHioyg0ELzSQTIvNNvvBPhpGro3mriZ7ioL811vX0E12h4z+bsvwHSoZ2wXRLgTt
pNtW57JPK+rkKxv0dpR/AdKrz/ARydXt4H+RYHuuwWqkdylpy3I=
=Gsr5
-----END PGP SIGNATURE-----

--yxzemvw5bqlaizir--
