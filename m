Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2126F4D82
	for <lists+linux-pci@lfdr.de>; Wed,  3 May 2023 01:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjEBXQm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 May 2023 19:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjEBXQl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 May 2023 19:16:41 -0400
Received: from stravinsky.debian.org (stravinsky.debian.org [IPv6:2001:41b8:202:deb::311:108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BB83C11;
        Tue,  2 May 2023 16:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
        s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pIlHDez9fg0KJ/IKw04KT23xKQ4mxvAUwD5s3LT5ebM=; b=pt6nW2ZSyLhIjB4FLaUWtSVH2O
        IE7qnMOsTBD9u3119UT0y6ItmFW+3lghWW8tqQG5WpthKpNsHJup6+Yr+SvrJT3ZMGhbaYEYATBCX
        P+LhwGePB6+KmYh8MWAoZ7zpHMPZ8Rkf5Yd0z6yChfAcK2fcF3/A2jNwQl3i/7SJ2D1ezyitiwILS
        WK8JMTbklousfpZboFNd5jIMCLHRfsxAop+ny8rpl5eyYOKIoviIj6OLfEguIeZpX8g2sjm2bM+v7
        1KpPVSXtfz93zg80jDaDzdfzXjQE5Zbv2k0C/SsqMEy1LhrX4Iv1XodUm4nDJc7+FbgWku5PLmNLG
        f7LE7w7w==;
Received: from authenticated user
        by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <kibi@debian.org>)
        id 1ptzE2-002xjz-AE; Tue, 02 May 2023 23:16:01 +0000
Date:   Wed, 3 May 2023 01:15:58 +0200
From:   Cyril Brulebois <kibi@debian.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 0/5] PCI: brcmstb: Configure appropriate HW CLKREQ#
 mode
Message-ID: <20230502231558.5zt5tyxczd22ppjz@mraw.org>
Organization: Debian
References: <20230428223500.23337-1-jim2101024@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tnybm5pxv6yz42hv"
Content-Disposition: inline
In-Reply-To: <20230428223500.23337-1-jim2101024@gmail.com>
X-Debian-User: kibi
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--tnybm5pxv6yz42hv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Jim Quinlan <jim2101024@gmail.com> (2023-04-28):
> Note: (a) With this series, all downstream devices should work w/o DT cha=
nges.
>           Only if the user desires L1SS savings and has an L1SS-capable
>           device is a DT change required (brcm,enable-l1ss).

I'm still seeing some problems, but tweaking two things can lead to
massive improvements:
 - setting brcm,enable-l1ss;
 - upgrading the CM4's EEPROM.

Seeing how patch #4 was about the bootloader, I've prepared an updated
test image the following way:
 - Kernel: 76f598ba7d8e2bfb4855b5298caedd5af0c374a8 + this series.
 - Userland: Debian testing as of 2023-05-01.
 - Serial console set as previously.
 - Bootloader: latest release upstream, 1.20230405
   (That is: bootcode.bin, *.dat, *.elf)

Then, seeing how setting brcm,enable-l1ss was helping some test cases,
I've extended testing to be quite systematic, using those components:
 - CM4 IO Board (always the same).
 - 1 CM4 among:
    - CM4 Lite Rev 1.0 (extra test, storage much quicker to deploy)
    - CM4 8/32 Rev 1.0 (as before)
    - CM4 4/32 Rev 1.1 (as before)
 - 1 PCIe card among:
    - 006 =3D SupaHub PCIe->USB adapter, reference PCE6U1C-R02, VER 006
       =E2=86=92 based on Renesas UPD720201/UPD720202
       =E2=86=92=C2=A0CONFIG_USB_XHCI_PCI_RENESAS=3Dm
       =E2=86=92 /lib/firmware/renesas_usb_fw.mem
    - 006S =3D SupaHub PCIe->USB adapter, reference PCE6U1C-R02, VER 006S
       =E2=86=92 based on Renesas UPD720201/UPD720202
       =E2=86=92=C2=A0CONFIG_USB_XHCI_PCI_RENESAS=3Dm
       =E2=86=92 /lib/firmware/renesas_usb_fw.mem
    - VIA =3D Waveshare PCIe-to-multiple-USB adapter (no obvious reference)
       =E2=86=92 based on VIA VL805/806
 - 1 Kingston DataTraveler G4 32G (always the same), plugged on one of the
   USB port of the PCIe card being tested.

I've tested a cold boot with each combination, first without touching the
DTB at all (pristine), then after enabling L1SS. The results are as
follows, legend is below.

                           +----------+----------+----------+
                           |   006    |   006S   |   VIA    |
  +------------------------+----------+----------+----------+
  | 1. CM4 Lite Rev 1.0    |    KP*   |    KP*   |  OK, 72  |
  |    pristine            |          |          |          |
  +------------------------+----------+----------+----------+
  | 2. CM4 Lite Rev 1.0    |  boot +  |  OK, 72  |  OK, 72  |
  |    + brcm,enable-l1ss  | timeouts |          |          |
  +------------------------+----------+----------+----------+
  | 3. CM4 8/32 Rev 1.0    |    KP    |    KP    |    KP    |
  |    pristine            |          |          |          |
  +------------------------+----------+----------+----------+
  | 4. CM4 8/32 Rev 1.0    |  OK, 69  |  OK, 69  |  OK, 69  |
  |    + brcm,enable-l1ss  |          |          |          |
  +------------------------+----------+----------+----------+
  | 5. CM4 4/32 Rev 1.1    |  boot +  |  OK, 69  |  OK, 69  |
  |    pristine            | timeouts |          |          |
  +------------------------+----------+----------+----------+
  | 6. CM4 4/32 Rev 1.1    |  OK, 82  |  OK, 69  |  OK, 69  |
  |    + brcm,enable-l1ss  |          |          |          |
  +------------------------+----------+----------+----------+

Legend:
 - OK, XXX =3D boots fine, memory stick visible, and reading from it using
   `dd if=3D/dev/sda of=3D/dev/null bs=3D8M status=3Dprogress` for a few se=
conds
   gives an XXX MB/s transfer rate.
 - KP =3D kernel panic involving brcm_pcie_probe().
 - KP* =3D probably the same kernel panic; unfortunately, the serial console
   hardly works, but booting for 1 minute, shutting down for 10 seconds,
   in a loop=E2=80=A6 ends up showing excerpts from a trace, one word or so=
metimes
   several lines at a time. Since brcm_pcie_driver_init() or SError
   appeared, getting the same trace looks probable to me. [See also the
   very end of the mail.]
 - boot + timeouts =3D the system boots, the memory stick is not visible
   though, as XHCI timeouts show up, e.g.:

   [   34.144748] xhci_hcd 0000:01:00.0: Timeout while waiting for setup de=
vice command
   [   34.357273] usb 3-1.4: Device not responding to setup address.
   [   34.568429] usb 3-1.4: device not accepting address 6, error -71
   [   34.575730] usb 3-1-port4: unable to enumerate USB device

So it looks like *for these combinations* setting brcm,enable-l1ss is only
helping, even if one particular thing remains not fully fonctional (but
at least boots now): CM4 Lite Rev 1.0 + 006 card.


And since you mentioned the EEPROM topic off-list, I've investigated that
part as well. It turns out that what *seemed* (at least to my non-expert
eyes) sort of related to the hardware revisions=E2=80=A6 could have actuall=
y be
directly linked to the EEPROM version shipped with each Compute Module.

After deploying the relevant tooling, and based on the reported
timestamps, here are the relevant EEPROM filenames in the rpi-eeprom
repository (https://github.com/raspberrypi/rpi-eeprom):
 - CM4 Lite Rev 1.0 [lines 1-2]
    =E2=86=92 firmware/stable/pieeprom-2021-02-16.bin
 - CM4 8/32 Rev 1.0 [lines 3-4]
    =E2=86=92 firmware/stable/pieeprom-2021-02-16.bin
 - CM4 4/32 Rev 1.1 [lines 5-6]
    =E2=86=92 firmware/stable/pieeprom-2021-12-02.bin

Try to upgrade a first CM4 Lite to the latest version (2023-01-11) gave
solid results (which I'm not including in this report as I was only in
exploratory mode, with a slightly different Kingston DataTraveler anyway;
for reference its EEPROM dated back to 2020, and it seemed to have ever
been in some beta state=E2=80=A6), so I decided to replicate all the tests =
above with
the very same 3 CM4, upgraded to 2023-01-11.

In passing: That might explain why it always felt like later revisions
were working =E2=80=9Cbetter=E2=80=9D than the old ones: being designed + m=
anufactured
later, they just ended up being shipped with a newer/better EEPROM?

Upgrade: via usbboot (https://github.com/raspberrypi/usbboot) and the
recovery procedure (which by default deploys the latest stable version).

Results with everyone at 2023-01-11.

                           +----------+----------+----------+
                           |   006    |   006S   |   VIA    |
  +------------------------+----------+----------+----------+
  | 1. CM4 Lite Rev 1.0    |  OK, 83  |  OK, 72  |  OK, 72  |
  |    pristine            |          |          |          |
  +------------------------+----------+----------+----------+
  | 2. CM4 Lite Rev 1.0    |  OK, 82  |  OK, 72  |  OK, 72  |
  |    + brcm,enable-l1ss  |          |          |          |
  +------------------------+----------+----------+----------+
  | 3. CM4 8/32 Rev 1.0    |  OK, 82  |  OK, 69  |  OK, 69  |
  |    pristine            |          |          |          |
  +------------------------+----------+----------+----------+
  | 4. CM4 8/32 Rev 1.0    |  OK, 82  |  OK, 69  |  OK, 69  |
  |    + brcm,enable-l1ss  |          |          |          |
  +------------------------+----------+----------+----------+
  | 5. CM4 4/32 Rev 1.1    |  OK, 82  |  OK, 69  |  OK, 69  |
  |    pristine            |          |          |          |
  +------------------------+----------+----------+----------+
  | 6. CM4 4/32 Rev 1.1    |  OK, 82  |  OK, 69  |  OK, 69  |
  |    + brcm,enable-l1ss  |          |          |          |
  +------------------------+----------+----------+----------+

Takeaways:
 - Upgrading the EEPROM solved all problems;
 - brcm,enable-l1ss (which used to help) is not needed, as mentioned in
   your cover letter.

Now that I'm a little more familiar with the EEPROM tooling:
 - It looks like I'm able to downgrade the EEPROM to an earlier version.
   But I cannot guarantee I can recover exactly the previous state as
   there are two different things at least: the EEPROM itself and what's
   called =E2=80=9Cbootloader config=E2=80=9D in vcgencmd). I've seen at le=
ast the LED
   change behaviour (via POWER_OFF_ON_HALT).
 - Upon downgrading, without brcm,enable-l1ss, the CM4 Lite is indeed
   showing me a black screen/no logs in the serial console again with
   either one of the 006/006S cards.
 - It's possible to specify a boot config file when deploying the EEPROM,
   and I've tried enabling BOOT_UART on the CM4 Lite. Now I'm getting the
   kernel panic on the console!

Where should I go from here?
 - Does it make sense to gather a trace for the kernel panic on say two
   combinations, without brcm,enable-l1ss set:
    + CM4 Lite Rev 1.0 (old EEPROM) + 006 [first KP* in first table]
    + CM4 8/32 Rev 1.0 (old EEPROM) + 006 [first KP in first table]
   then get a trace without your patches, and attach all four resulting
   files?
 - Or should one just consider that the very first thing that each and
   every CM4 user is supposed to do is upgrade their EEPROM?

On a personal side, I'm very fine with being told to just upgrade the
EEPROM already (and that seems to cover any use case I could think of,
and test). But if getting and comparing traces before/after your patches
is helpful to you and the wider community, I'm happy to spend some more
time testing and gathering details.
=20

Cheers,
--=20
Cyril Brulebois (kibi@debian.org)            <https://debamax.com/>
D-I release manager -- Release team member -- Freelance Consultant

--tnybm5pxv6yz42hv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEtg6/KYRFPHDXTPR4/5FK8MKzVSAFAmRRmasACgkQ/5FK8MKz
VSDhWQ//eZJXOnlldXWrTUxJmU6LaLVPt1knTnF8TX2WqP56REqO5ZVmROmcKTQp
0dGOAt9wQ0LoKJKYWHBkSlQN83KfesAbVi32zuBllNx+zb+uLn5WvaHelTkGHhh8
U4LP0V5bRq+qbnOfZraUdsH1vzk/7zRNFjZg/jGJRuoPZZcBslfUoPNDuIBkLMbG
23qrTgITh1jAfshVkKGZe8bTq/Xc///DtKIHlouxcuZ1FQnQQkLbRNHDKkdoH+o2
0R/qb+2C27jCLN+Kv7W7GkEIaQzlKIYfk64q8spu+f4dwg0+r2F6511VzlMu+ikP
3RbtdFwvdCtNclMb4D/tMR2yCCpWuFloKJJPkC2is4u+4ygOEZdqlyNMO7yoXPC7
3doMCNlaryeO+nuCnorRs/QadqOmX24cbbYZ37jEg1FpQYkjceLy1DUcvDtkuRmH
0iXPQgZUOrvv8hscmwc1zFdIOHGqhgU407yJdAGcb58PRT29Mb8/fvTA2pQt2R5D
+cKegIpQG0FDTiU+1czlza3shu2MPyfMp2rD6VECOBW5aiWZm3qcs3DpoLyR4ukM
vl+DHraNMQSrB+Lh24caKwnSMnPe1IgWEWcSCGt18P8MAErJWn00ElFyVOMo0ogs
hZmprOjFO3FDKoAWpLoB3dEQQFK2QrOwuoV3haMTwd8y6twKI94=
=EOzA
-----END PGP SIGNATURE-----

--tnybm5pxv6yz42hv--
