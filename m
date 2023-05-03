Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28466F5D96
	for <lists+linux-pci@lfdr.de>; Wed,  3 May 2023 20:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjECSKY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 May 2023 14:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjECSKS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 May 2023 14:10:18 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D330C7
        for <linux-pci@vger.kernel.org>; Wed,  3 May 2023 11:10:14 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f315712406so36102125e9.0
        for <linux-pci@vger.kernel.org>; Wed, 03 May 2023 11:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1683137412; x=1685729412;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fZuRbSmdcdHNgylWteKsNYwiq84EWPRT1poQqJ/BkXY=;
        b=XndPKCMwIPtuXwD64jiYzuCWy+pQDceRimuK03Z8rZroTIbQlSYcBHVUlC/5SiysGc
         M+DE/fh3iBwGQ+fUccUqgG77cmIenLtVQEXQ7Y058+wtd9Qa3EE4j+SOum2DziQDh0MV
         gjV9IEt+PKMS8Su4ErPoyacG4c+HuUDXyckko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683137412; x=1685729412;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fZuRbSmdcdHNgylWteKsNYwiq84EWPRT1poQqJ/BkXY=;
        b=JTueLCZWuh51xh1bQ+9CIqzov7rzB161CmxF2QqHCTJX06QUs0huwYKV1c+VrXvuld
         SJDQV1oZ4jioQ0/aIavXFyw9wc9WMdUIolxjK8f0Tcz/b6B8p67jzGQKIDQ2XgbLv3LX
         4+tgaGgWIXLerjXY3lonhpgQ7tDWpj9UVz4/f6UrzqJtcPrxqKaKOudtgh+dXCUv52n9
         FDFlWvCmW4Cmrktz0kc6R1Jq8p5sUERDtHc2PYz92boZl26yF4sPunFy9AwF9r/NTMq5
         Sq24w6ihj1srPTE4v2vAh3ZdpmlUCwilRHVpX3ebcCFvcyp0XGFIqevlCtxMLamJwPJt
         x42w==
X-Gm-Message-State: AC+VfDz7z82Jd8ZwEMcCHdsSr3GGSdYxvll4LKttHDYbxWcrqgnzrj3M
        g7e9AgasKH4M+T51lt61dDpB5NumaY42IWErYp7bQA==
X-Google-Smtp-Source: ACHHUZ6QVyMzLWwRKsTgB8j4+DS7QQyWR56RH0QIk8C9LJi/3C/bQrPxl8LUQSpWhC5drPrENsUKponaHRBKpoBFPBQ=
X-Received: by 2002:a5d:5304:0:b0:2f8:1305:dce1 with SMTP id
 e4-20020a5d5304000000b002f81305dce1mr579732wrv.19.1683137412463; Wed, 03 May
 2023 11:10:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230428223500.23337-1-jim2101024@gmail.com> <20230502231558.5zt5tyxczd22ppjz@mraw.org>
In-Reply-To: <20230502231558.5zt5tyxczd22ppjz@mraw.org>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Wed, 3 May 2023 14:10:01 -0400
Message-ID: <CA+-6iNzD_YrrhDPfr0J7KA3rotbgDNB+vGOJyyRnW3-7G5vw6Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] PCI: brcmstb: Configure appropriate HW CLKREQ# mode
To:     Cyril Brulebois <kibi@debian.org>
Cc:     Jim Quinlan <jim2101024@gmail.com>, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
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
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000099b52805facdf709"
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--00000000000099b52805facdf709
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 2, 2023 at 7:16=E2=80=AFPM Cyril Brulebois <kibi@debian.org> wr=
ote:
>
> Hi,
>
> Jim Quinlan <jim2101024@gmail.com> (2023-04-28):
> > Note: (a) With this series, all downstream devices should work w/o DT c=
hanges.
> >           Only if the user desires L1SS savings and has an L1SS-capable
> >           device is a DT change required (brcm,enable-l1ss).
>
> I'm still seeing some problems, but tweaking two things can lead to
> massive improvements:
>  - setting brcm,enable-l1ss;
>  - upgrading the CM4's EEPROM.
>
> Seeing how patch #4 was about the bootloader, I've prepared an updated
> test image the following way:
>  - Kernel: 76f598ba7d8e2bfb4855b5298caedd5af0c374a8 + this series.
>  - Userland: Debian testing as of 2023-05-01.
>  - Serial console set as previously.
>  - Bootloader: latest release upstream, 1.20230405
>    (That is: bootcode.bin, *.dat, *.elf)
>
> Then, seeing how setting brcm,enable-l1ss was helping some test cases,
> I've extended testing to be quite systematic, using those components:
>  - CM4 IO Board (always the same).
>  - 1 CM4 among:
>     - CM4 Lite Rev 1.0 (extra test, storage much quicker to deploy)
>     - CM4 8/32 Rev 1.0 (as before)
>     - CM4 4/32 Rev 1.1 (as before)
>  - 1 PCIe card among:
>     - 006 =3D SupaHub PCIe->USB adapter, reference PCE6U1C-R02, VER 006
>        =E2=86=92 based on Renesas UPD720201/UPD720202
>        =E2=86=92 CONFIG_USB_XHCI_PCI_RENESAS=3Dm
>        =E2=86=92 /lib/firmware/renesas_usb_fw.mem
>     - 006S =3D SupaHub PCIe->USB adapter, reference PCE6U1C-R02, VER 006S
>        =E2=86=92 based on Renesas UPD720201/UPD720202
>        =E2=86=92 CONFIG_USB_XHCI_PCI_RENESAS=3Dm
>        =E2=86=92 /lib/firmware/renesas_usb_fw.mem
>     - VIA =3D Waveshare PCIe-to-multiple-USB adapter (no obvious referenc=
e)
>        =E2=86=92 based on VIA VL805/806
>  - 1 Kingston DataTraveler G4 32G (always the same), plugged on one of th=
e
>    USB port of the PCIe card being tested.
>
> I've tested a cold boot with each combination, first without touching the
> DTB at all (pristine), then after enabling L1SS. The results are as
> follows, legend is below.
>
>                            +----------+----------+----------+
>                            |   006    |   006S   |   VIA    |
>   +------------------------+----------+----------+----------+
>   | 1. CM4 Lite Rev 1.0    |    KP*   |    KP*   |  OK, 72  |
>   |    pristine            |          |          |          |
>   +------------------------+----------+----------+----------+
>   | 2. CM4 Lite Rev 1.0    |  boot +  |  OK, 72  |  OK, 72  |
>   |    + brcm,enable-l1ss  | timeouts |          |          |
>   +------------------------+----------+----------+----------+
>   | 3. CM4 8/32 Rev 1.0    |    KP    |    KP    |    KP    |
>   |    pristine            |          |          |          |
>   +------------------------+----------+----------+----------+
>   | 4. CM4 8/32 Rev 1.0    |  OK, 69  |  OK, 69  |  OK, 69  |
>   |    + brcm,enable-l1ss  |          |          |          |
>   +------------------------+----------+----------+----------+
>   | 5. CM4 4/32 Rev 1.1    |  boot +  |  OK, 69  |  OK, 69  |
>   |    pristine            | timeouts |          |          |
>   +------------------------+----------+----------+----------+
>   | 6. CM4 4/32 Rev 1.1    |  OK, 82  |  OK, 69  |  OK, 69  |
>   |    + brcm,enable-l1ss  |          |          |          |
>   +------------------------+----------+----------+----------+

Hello Cyril,

I'm confused by your result table above which has a number of
failures.  Further in your message you say:

Takeaways:
 - Upgrading the EEPROM solved all problems;
 - brcm,enable-l1ss (which used to help) is not needed [...]

May I conclude that if one uses a modern CM4 eeprom that these failures go =
away?
You mentioned in a personal email that at least one of your "CM4" was
running a Beta eeprom image.

I'm much less concerned about folks having problems with old  or
pre-release versions of the CM4 eeprom because (a) most of these folks
are using Raspian Linux anyway and (b) they can just upgrade their
eeprom.
Further, the Rpi eeprom is closed-source and my questions on the Rpi
forum  and Rpi Github have not yet led to any answers  about why a
different eeprom image is changing the behavior of a clkreq signal.

Regards,
Jim Quinlan
Broadcom STB

>
> Legend:
>  - OK, XXX =3D boots fine, memory stick visible, and reading from it usin=
g
>    `dd if=3D/dev/sda of=3D/dev/null bs=3D8M status=3Dprogress` for a few =
seconds
>    gives an XXX MB/s transfer rate.
>  - KP =3D kernel panic involving brcm_pcie_probe().
>  - KP* =3D probably the same kernel panic; unfortunately, the serial cons=
ole
>    hardly works, but booting for 1 minute, shutting down for 10 seconds,
>    in a loop=E2=80=A6 ends up showing excerpts from a trace, one word or =
sometimes
>    several lines at a time. Since brcm_pcie_driver_init() or SError
>    appeared, getting the same trace looks probable to me. [See also the
>    very end of the mail.]
>  - boot + timeouts =3D the system boots, the memory stick is not visible
>    though, as XHCI timeouts show up, e.g.:
>
>    [   34.144748] xhci_hcd 0000:01:00.0: Timeout while waiting for setup =
device command
>    [   34.357273] usb 3-1.4: Device not responding to setup address.
>    [   34.568429] usb 3-1.4: device not accepting address 6, error -71
>    [   34.575730] usb 3-1-port4: unable to enumerate USB device
>
> So it looks like *for these combinations* setting brcm,enable-l1ss is onl=
y
> helping, even if one particular thing remains not fully fonctional (but
> at least boots now): CM4 Lite Rev 1.0 + 006 card.
>
>
> And since you mentioned the EEPROM topic off-list, I've investigated that
> part as well. It turns out that what *seemed* (at least to my non-expert
> eyes) sort of related to the hardware revisions=E2=80=A6 could have actua=
lly be
> directly linked to the EEPROM version shipped with each Compute Module.
>
> After deploying the relevant tooling, and based on the reported
> timestamps, here are the relevant EEPROM filenames in the rpi-eeprom
> repository (https://github.com/raspberrypi/rpi-eeprom):
>  - CM4 Lite Rev 1.0 [lines 1-2]
>     =E2=86=92 firmware/stable/pieeprom-2021-02-16.bin
>  - CM4 8/32 Rev 1.0 [lines 3-4]
>     =E2=86=92 firmware/stable/pieeprom-2021-02-16.bin
>  - CM4 4/32 Rev 1.1 [lines 5-6]
>     =E2=86=92 firmware/stable/pieeprom-2021-12-02.bin
>
> Try to upgrade a first CM4 Lite to the latest version (2023-01-11) gave
> solid results (which I'm not including in this report as I was only in
> exploratory mode, with a slightly different Kingston DataTraveler anyway;
> for reference its EEPROM dated back to 2020, and it seemed to have ever
> been in some beta state=E2=80=A6), so I decided to replicate all the test=
s above with
> the very same 3 CM4, upgraded to 2023-01-11.
>
> In passing: That might explain why it always felt like later revisions
> were working =E2=80=9Cbetter=E2=80=9D than the old ones: being designed +=
 manufactured
> later, they just ended up being shipped with a newer/better EEPROM?
>
> Upgrade: via usbboot (https://github.com/raspberrypi/usbboot) and the
> recovery procedure (which by default deploys the latest stable version).
>
> Results with everyone at 2023-01-11.
>
>                            +----------+----------+----------+
>                            |   006    |   006S   |   VIA    |
>   +------------------------+----------+----------+----------+
>   | 1. CM4 Lite Rev 1.0    |  OK, 83  |  OK, 72  |  OK, 72  |
>   |    pristine            |          |          |          |
>   +------------------------+----------+----------+----------+
>   | 2. CM4 Lite Rev 1.0    |  OK, 82  |  OK, 72  |  OK, 72  |
>   |    + brcm,enable-l1ss  |          |          |          |
>   +------------------------+----------+----------+----------+
>   | 3. CM4 8/32 Rev 1.0    |  OK, 82  |  OK, 69  |  OK, 69  |
>   |    pristine            |          |          |          |
>   +------------------------+----------+----------+----------+
>   | 4. CM4 8/32 Rev 1.0    |  OK, 82  |  OK, 69  |  OK, 69  |
>   |    + brcm,enable-l1ss  |          |          |          |
>   +------------------------+----------+----------+----------+
>   | 5. CM4 4/32 Rev 1.1    |  OK, 82  |  OK, 69  |  OK, 69  |
>   |    pristine            |          |          |          |
>   +------------------------+----------+----------+----------+
>   | 6. CM4 4/32 Rev 1.1    |  OK, 82  |  OK, 69  |  OK, 69  |
>   |    + brcm,enable-l1ss  |          |          |          |
>   +------------------------+----------+----------+----------+
>
> Takeaways:
>  - Upgrading the EEPROM solved all problems;
>  - brcm,enable-l1ss (which used to help) is not needed, as mentioned in
>    your cover letter.
>
> Now that I'm a little more familiar with the EEPROM tooling:
>  - It looks like I'm able to downgrade the EEPROM to an earlier version.
>    But I cannot guarantee I can recover exactly the previous state as
>    there are two different things at least: the EEPROM itself and what's
>    called =E2=80=9Cbootloader config=E2=80=9D in vcgencmd). I've seen at =
least the LED
>    change behaviour (via POWER_OFF_ON_HALT).
>  - Upon downgrading, without brcm,enable-l1ss, the CM4 Lite is indeed
>    showing me a black screen/no logs in the serial console again with
>    either one of the 006/006S cards.
>  - It's possible to specify a boot config file when deploying the EEPROM,
>    and I've tried enabling BOOT_UART on the CM4 Lite. Now I'm getting the
>    kernel panic on the console!
>
> Where should I go from here?
>  - Does it make sense to gather a trace for the kernel panic on say two
>    combinations, without brcm,enable-l1ss set:
>     + CM4 Lite Rev 1.0 (old EEPROM) + 006 [first KP* in first table]
>     + CM4 8/32 Rev 1.0 (old EEPROM) + 006 [first KP in first table]
>    then get a trace without your patches, and attach all four resulting
>    files?
>  - Or should one just consider that the very first thing that each and
>    every CM4 user is supposed to do is upgrade their EEPROM?
>
> On a personal side, I'm very fine with being told to just upgrade the
> EEPROM already (and that seems to cover any use case I could think of,
> and test). But if getting and comparing traces before/after your patches
> is helpful to you and the wider community, I'm happy to spend some more
> time testing and gathering details.
>
>
> Cheers,
> --
> Cyril Brulebois (kibi@debian.org)            <https://debamax.com/>
> D-I release manager -- Release team member -- Freelance Consultant

--00000000000099b52805facdf709
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
mOAplh6h3nMZUZxBguxG3g2p3iD4EgibUYneEzqOQafIQB/naf2uetKb8y9jKgWJxq2Y4y8Jqg2u
uVIO1AyOJjWwqdgN+QhuIlat+qZd03P48Gim9ZPEMDUCAwEAAaOCAdswggHXMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJQYDVR0R
BB4wHIEaamFtZXMucXVpbmxhbkBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYBBQUHAwQwHwYD
VR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFGx/E27aeGBP2eJktrILxlhK
z8f6MA0GCSqGSIb3DQEBCwUAA4IBAQBdQQukiELsPfse49X4QNy/UN43dPUw0I1asiQ8wye3nAuD
b3GFmf3SZKlgxBTdWJoaNmmUFW2H3HWOoQBnTeedLtV9M2Tb9vOKMncQD1f9hvWZR6LnZpjBIlKe
+R+v6CLF07qYmBI6olvOY/Rsv9QpW9W8qZYk+2RkWHz/fR5N5YldKlJHP0NDT4Wjc5fEzV+mZC8A
AlT80qiuCVv+IQP08ovEVSLPhUp8i1pwsHT9atbWOfXQjbq1B/ditFIbPzwmwJPuGUc7n7vpmtxB
75sSFMj27j4JXl5W9vORgHR2YzuPBzfzDJU1ul0DIofSWVF6E1dx4tZohRED1Yl/T/ZGMYICbTCC
AmkCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UE
AxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMSO43VW7D5NP1X/KD
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCC8Iil3n46aTj2OhGOtzYSFrf89zEyX
5Q0GYBO0iKlNJDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMzA1
MDMxODEwMTJaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAdecECVmFfTyZFzL0LZl7dIWrz2SYPOr611Upbf9rVJsVIKdz
q2A7crbBV99Vya2Llvk7PDrqQVgMvNMm/DVvaw8cD+S9k3fT8lvrpul9TyMFPupicaAdmgLdePKC
UZB/LZrqqeR2I8b+5ePns8CwNFjQlnFGQZrme89SOUrXJYqIs1WiW3DvKv6aFIv9S0y9z4ECPPQb
hFXrEE4zHSBpfYKJi6iTGmBD4yJGxmRxLwjDz+BTTzDa2kyH8gKT4HpfeXhYQJY2vl8jbrrYyXCc
0IDQZHZzPuflAYeHg3YrdFyq4+2WeD15gGulKJM6/Tn0jU7APb7KHHPv+enI55M2nA==
--00000000000099b52805facdf709--
