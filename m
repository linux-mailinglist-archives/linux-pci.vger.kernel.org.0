Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106F2536F08
	for <lists+linux-pci@lfdr.de>; Sun, 29 May 2022 03:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbiE2BPt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 28 May 2022 21:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbiE2BPs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 28 May 2022 21:15:48 -0400
Received: from hobbes.mraw.org (hobbes.mraw.org [195.154.31.160])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148EC58385;
        Sat, 28 May 2022 18:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mraw.org;
        s=mail2022; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=0q0jjHmO2F9yFv6pl7uCBFIu94o+xtmk513vQjnF8tA=; b=B+NFVmVrwkU47aJHKGQ4eKnN/6
        8Vin7B16iWS++ckLpHbckjOU2r2GLewm8l9QTLIeBiyhY9ifw+gL9pct0saxdQ/4cuOuGnQq3peYu
        nKbwcS5rx8F4S03BJt7Z9L2rp7Xh88slFyNayhsBt/OUJByW4O95lyLeM8CZw7f59xwqxSvhux7V9
        6KyWcQpjZEh6uv/8dCy+wb+dkJj1tUO9YsWK2AnGzFtPoS3v3HMqp0fp4Gpxur2ImFTeMnQxJlYr4
        89F82QSA9GPQnMvtFGWHDIPuzt0SB0PvaRI872ud2VNKUiwBOihEaqLRHh+esd9yjOCoqBK6xaTnt
        VgJW9EFQ==;
Received: from 82-64-171-251.subs.proxad.net ([82.64.171.251] helo=mraw.org)
        by hobbes.mraw.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <kibi@debian.org>)
        id 1nv7Wi-005yWO-7a; Sun, 29 May 2022 03:15:28 +0200
Date:   Sun, 29 May 2022 03:15:26 +0200
From:   Cyril Brulebois <kibi@debian.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-pci@vger.kernel.org,
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
Subject: Re: [PATCH v2 1/1] PCI: brcmstb: Fix regression regarding missing
 PCIe linkup
Message-ID: <20220529011526.4lzuvkv5zclwntce@mraw.org>
Organization: Debian
References: <20220528224423.7017-1-jim2101024@gmail.com>
 <20220528224423.7017-2-jim2101024@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p7efc27cc6hucg6p"
Content-Disposition: inline
In-Reply-To: <20220528224423.7017-2-jim2101024@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--p7efc27cc6hucg6p
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jim,

Jim Quinlan <jim2101024@gmail.com> (2022-05-28):
> commit 93e41f3fca3d ("PCI: brcmstb: Add control of subdevice voltage regu=
lators")
>=20
> introduced a regression on the PCIe RPi4 Compute Module.  If the PCIe
> root port DT node described in [2] was missing, no linkup would be attemp=
ted,
> and subsequent accesses would cause a panic because this particular PCIe =
HW
> causes a CPU abort on illegal accesses (instead of returning 0xffffffff).
>=20
> We fix this by allowing the DT root port node to be missing, as it behaved
> before the original patchset messed things up.
>=20
> In addition, two small changes are made:
>=20
>   1. Having pci_subdev_regulators_remove_bus() call
>      regulator_bulk_free() in addtion to regulator_bulk_disable().
>   2. Having brcm_pcie_add_bus() return 0 if there is an
>      error in calling pci_subdev_regulators_add_bus().
>      Instead, we dev_err() and turn on our refusal mode instead.
>=20
> It would be best if this commit were tested by someone with a Rpi CM4
> platform, as that is how the regression was found.  I have only emulated
> the problem and fix on different platform.

Testing is less flawless than it was with the earlier version, but this
might be related to the fact master has moved a lot since then (from
v5.18-rcX to open merge window).

Overall, it's still a net win over the status quo (broken boot).


Applying your patch on 664a393a2663a0f62fc1b18157ccae33dcdbb8c8 and
performing cold boots is mostly fine:
 - without anything on the PCIe slot;
 - with a PCIe=E2=86=92quad-USB extension board, a USB keyboard and a USB s=
tick
   (both work fine).

However, with an empty PCIe slot, I'm no longer able to perform the
following (which was rock solid, and has been used in all my testing up
to now):
 - boot the exact same Debian stable image as before (running v5.10.y if
   that matters);
 - deploy the patched kernel;
 - enable serial console;
 - reboot into the patched kernel.

PCI-related messages, a call trace, and broken storage:

    [    3.425331] brcm-pcie fd500000.pcie: host bridge /scb/pcie@7d500000 =
ranges:
    [    3.425353] brcm-pcie fd500000.pcie:   No bus range found for /scb/p=
cie@7d500000, using [bus 00-ff]
    [    3.425388] brcm-pcie fd500000.pcie:      MEM 0x0600000000..0x0603ff=
ffff -> 0x00f8000000
    [    3.425420] brcm-pcie fd500000.pcie:   IB MEM 0x0000000000..0x003fff=
ffff -> 0x0400000000
    [    3.426229] brcm-pcie fd500000.pcie: PCI host bridge to bus 0000:00
    [    3.426243] pci_bus 0000:00: root bus resource [bus 00-ff]
    [    3.426255] pci_bus 0000:00: root bus resource [mem 0x600000000-0x60=
3ffffff] (bus address [0xf8000000-0xfbffffff])
    [    3.426303] pci 0000:00:00.0: [14e4:2711] type 01 class 0x060400
    [    3.426398] pci 0000:00:00.0: PME# supported from D0 D3hot
    [    3.428797] pci 0000:00:00.0: bridge configuration invalid ([bus 00-=
00]), reconfiguring
    [    3.745909] brcm-pcie fd500000.pcie: link down
    [    3.747915] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to=
 01
    [    3.747944] pci 0000:00:00.0: PCI bridge to [bus 01]
    [    3.748294] pcieport 0000:00:00.0: PME: Signaling with IRQ 23
    [    3.748691] pcieport 0000:00:00.0: AER: enabled with IRQ 23
    [    3.749201] pci_bus 0000:01: busn_res: [bus 01] is released
    [    3.749462] pci_bus 0000:00: busn_res: [bus 00-ff] is released
    =E2=80=A6
    [    5.617308] irq 35: nobody cared (try booting with the "irqpoll" opt=
ion)
    [    5.617335] CPU: 0 PID: 127 Comm: systemd-udevd Not tainted 5.18.0+ =
#1
    [    5.617350] Hardware name: Raspberry Pi Compute Module 4 Rev 1.0 (DT)
    [    5.617358] Call trace:
    [    5.617362]  dump_backtrace+0xc0/0x130
    [    5.617386]  show_stack+0x24/0x70
    [    5.617396]  dump_stack_lvl+0x68/0x84
    [    5.617415]  dump_stack+0x18/0x34
    [    5.617426]  __report_bad_irq+0x54/0x16c
    [    5.617436]  note_interrupt+0x324/0x41c
    [    5.617445]  handle_irq_event+0xc0/0x180
    [    5.617460]  handle_fasteoi_irq+0xc8/0x1fc
    [    5.617468]  generic_handle_domain_irq+0x38/0x50
    [    5.617481]  gic_handle_irq+0x68/0xa0
    [    5.617489]  call_on_irq_stack+0x2c/0x60
    [    5.617500]  do_interrupt_handler+0x88/0x90
    [    5.617511]  el0_interrupt+0x58/0x124
    [    5.617526]  __el0_irq_handler_common+0x18/0x2c
    [    5.617538]  el0t_64_irq_handler+0x10/0x20
    [    5.617549]  el0t_64_irq+0x18c/0x190
    [    5.617558] handlers:
    [    5.617563] [<(____ptrval____)>] sdhci_irq [sdhci] threaded [<(____p=
trval____)>] sdhci_thread_irq [sdhci]
    [    5.617613] Disabling IRQ #35
    =E2=80=A6
    [   15.581894] mmc0: Timeout waiting for hardware cmd interrupt.
    [   15.581914] mmc0: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D SDHCI =
REGISTER DUMP =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
    [   15.581920] mmc0: sdhci: Sys addr:  0x00000000 | Version:  0x00001002
    [   15.581931] mmc0: sdhci: Blk size:  0x00000000 | Blk cnt:  0x00000000
    [   15.581937] mmc0: sdhci: Argument:  0x00000c00 | Trn mode: 0x00000000
    [   15.581944] mmc0: sdhci: Present:   0x1fff0000 | Host ctl: 0x00000001
    [   15.581951] mmc0: sdhci: Power:     0x0000000f | Blk gap:  0x00000080
    [   15.581957] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00007d07
    [   15.581964] mmc0: sdhci: Timeout:   0x00000000 | Int stat: 0x00018000
    [   15.581971] mmc0: sdhci: Int enab:  0x00ff1003 | Sig enab: 0x00ff1003
    [   15.581976] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000001
    [   15.581982] mmc0: sdhci: Caps:      0x45ee6432 | Caps_1:   0x0000a525
    [   15.581988] mmc0: sdhci: Cmd:       0x0000341a | Max curr: 0x00080008
    [   15.581996] mmc0: sdhci: Resp[0]:   0x00000000 | Resp[1]:  0x00000000
    [   15.582001] mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
    [   15.582005] mmc0: sdhci: Host ctl2: 0x00000000
    [   15.582011] mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x00000000
    [   15.582016] mmc0: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

This last part gets repeated over and over, and storage (external SD
card) never comes up. I can share fuller logs if that's desirable. I can
also test booting with irqpoll if that's desirable. Or anything else that
might help.


I did check that applying the same patch on top of the v5.18 tag gives
good results (cold boots and reboots are fine, with or without an empty
PCIe slot, as that was the case during earlier test sessions), so I'd
guess something changed since then, and makes reboots more brittle than
they used to be.

I can also check applying the v1 patch on top of master and compare
results, to give a different perspective.

But I'd also be happy to get some directions as to which test(s) would
be most beneficial, which would help me cut down on combinatorics.


Cheers,
--=20
Cyril Brulebois (kibi@debian.org)            <https://debamax.com/>
D-I release manager -- Release team member -- Freelance Consultant

--p7efc27cc6hucg6p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEtg6/KYRFPHDXTPR4/5FK8MKzVSAFAmKSySkACgkQ/5FK8MKz
VSDi/RAApdbMY6UGFIX+s1J8BXr54OMaVLaP6bEgvGZYCZvlrkEMdWJkQc0tm0T+
2++odGWE4kSrOtj/j6wp95WS6WC3P6BZvUteKCt1ExXQ3V5ELk7emAv2/oXP7YYZ
TKp+RVJ/krtjwDAOj8Q4OTcVCrFS4AdbhC699E9Ok3yzQbJu5XWKZU/tV+4LwrMo
xzKIT3qn0D6fzMKCX7/Xial+PpUkx1aKGW5P25a9QJeuNd1hygZvjV0TxshLEY/K
ZZAMW9UEuHaA4ZFuu9waUxjwYMx+QihRF5uAaGcrEtoWae8wx7gdH0YLr84wYWCi
w14FpbMxB2oVPbpiRz1w1VPV4/7NldEPShHu+ssHmoCtZ7h7F1CpMPEwlSkSQW1h
ZaNndiJRAYTNvGqUZfCXlQRYil3vOFxzfiBRPhRg8Gj1oIOB5dUmB4JLYVPOUDKj
Mj/MbFhEqrXSPmlLPx0a6knjQkyC2oVfMfFLHYSLMgCFXQWeGS9aoLL2U7Sc1gLf
aVvzwlJa4yEk4+JhP1rnYrMjIOn1L6Yx2CBi7MHTt08oWjrQr1HvCJmToEU+/3Um
RnfdPomyBjHD0OhjeC+ORxfcaM8v/NV+kZrhrrJnic7Zf5ka56k3TULRvoKcqHQ8
xwd9GX0yQA3bwgPh/ObMVlaZwlTCv85l09goDtXeg2QI5TeBfT8=
=k+pB
-----END PGP SIGNATURE-----

--p7efc27cc6hucg6p--
