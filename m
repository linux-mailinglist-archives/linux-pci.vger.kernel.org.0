Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214B96E1024
	for <lists+linux-pci@lfdr.de>; Thu, 13 Apr 2023 16:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjDMOjo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Apr 2023 10:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjDMOjo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Apr 2023 10:39:44 -0400
Received: from stravinsky.debian.org (stravinsky.debian.org [IPv6:2001:41b8:202:deb::311:108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3FE5241;
        Thu, 13 Apr 2023 07:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
        s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Yzic6zI3YNlW0bPd7Q9GpkS5SQuLmLYQ99sWX79o590=; b=cX/p+TjBBoumVnVFED9UxSNoxw
        KUP1oyyldwaiscfrNaRXxuiGTz0FkB0avCn718k348CFryRny7uCvJBPHDGB+UfFX7+YpCtmf6wHY
        W5DCWrLzN4eaR8de66SLCuWd//s3QIcXDcm2CGQ+X1kBpuTIKSygvkL5PAn18tu3v7ZFEjfCBPSmj
        LeC3Iu1Tn82swFfomLMSTAtEM+XUW95TsjH5yBBOmjQVVNUvgUEfJFrJBv2EGsUHQbGDFRBpimY1Y
        2C+8Gjec2DWrrKPQY2YsgtZECrj17V6yANjNTL+Cm9iOhLSNNWEq5+Jo2oJZvqQl9t4P4aUW6KfTp
        eieliyLA==;
Received: from authenticated user
        by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <kibi@debian.org>)
        id 1pmy6s-000UoX-Ax; Thu, 13 Apr 2023 14:39:39 +0000
Date:   Thu, 13 Apr 2023 16:39:35 +0200
From:   Cyril Brulebois <kibi@debian.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] PCI: brcmstb: CLKREQ# accomodations of downstream
 device
Message-ID: <20230413143935.pmbyjk2boxl3rwne@mraw.org>
Organization: Debian
References: <20230411165919.23955-1-jim2101024@gmail.com>
 <20230411165919.23955-3-jim2101024@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lzs5lyynabvj7rjw"
Content-Disposition: inline
In-Reply-To: <20230411165919.23955-3-jim2101024@gmail.com>
X-Debian-User: kibi
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--lzs5lyynabvj7rjw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jim,

Jim Quinlan <jim2101024@gmail.com> (2023-04-11):
> [=E2=80=A6]
> This property has already been in use by Raspian Linux, but this
> immplementation adds more details and discerns between (a) and (b)
  ^^^^^^^^^^^^^^^
  implementation

> automatically.
>=20
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217276
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>

Sorry, it seems like my initial tests with v1 (applied on top of
v6.3-rc5-137-gf2afccfefe7b) weren't thorough enough, and I'm seeing the
same problems with v2 (applied on top of v6.3-rc6-46-gde4664485abb):
 - same setup as in https://bugzilla.kernel.org/show_bug.cgi?id=3D217276
 - the kernel panic is indeed gone;
 - a USB keyboard connected on that SupaHub PCIe-to-multiple-USB adapter
   isn't seen by the kernel;
 - a USB memory stick connected on the same adapter isn't seen by the
   kernel either;
 - of course both USB devices are confirmed to work fine if they're
   plugged directly on the CM4's USB ports.

Logs with v2:

    root@cm4:~# dmesg|grep -i pci
    [    0.610997] PCI: CLS 0 bytes, default 64
    [    1.664886] shpchp: Standard Hot Plug PCI Controller Driver version:=
 0.4
    [    1.672083] brcm-pcie fd500000.pcie: host bridge /scb/pcie@7d500000 =
ranges:
    [    1.679125] brcm-pcie fd500000.pcie:   No bus range found for /scb/p=
cie@7d500000, using [bus 00-ff]
    [    1.688279] brcm-pcie fd500000.pcie:      MEM 0x0600000000..0x0603ff=
ffff -> 0x00f8000000
    [    1.696463] brcm-pcie fd500000.pcie:   IB MEM 0x0000000000..0x00ffff=
ffff -> 0x0400000000
    [    1.705282] brcm-pcie fd500000.pcie: PCI host bridge to bus 0000:00
    [    1.711629] pci_bus 0000:00: root bus resource [bus 00-ff]
    [    1.717172] pci_bus 0000:00: root bus resource [mem 0x600000000-0x60=
3ffffff] (bus address [0xf8000000-0xfbffffff])
    [    1.727653] pci 0000:00:00.0: [14e4:2711] type 01 class 0x060400
    [    1.733768] pci 0000:00:00.0: PME# supported from D0 D3hot
    [    1.740235] pci 0000:00:00.0: bridge configuration invalid ([bus 00-=
00]), reconfiguring
    [    1.855826] brcm-pcie fd500000.pcie: CLKREQ# ignored; no ASPM
    [    1.863666] brcm-pcie fd500000.pcie: link up, 5.0 GT/s PCIe x1 (SSC)
    [    1.870115] pci 0000:01:00.0: [1912:0014] type 00 class 0x0c0330
    [    1.876205] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00001fff 6=
4bit]
    [    1.883177] pci 0000:01:00.0: PME# supported from D0 D3hot
    [    1.888881] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to=
 01
    [    1.895581] pci 0000:00:00.0: BAR 14: assigned [mem 0x600000000-0x60=
00fffff]
    [    1.902707] pci 0000:01:00.0: BAR 0: assigned [mem 0x600000000-0x600=
001fff 64bit]
    [    1.910279] pci 0000:00:00.0: PCI bridge to [bus 01]
    [    1.915293] pci 0000:00:00.0:   bridge window [mem 0x600000000-0x600=
0fffff]
    [    1.922412] pcieport 0000:00:00.0: enabling device (0000 -> 0002)
    [    1.928633] pcieport 0000:00:00.0: PME: Signaling with IRQ 23
    [    1.934609] pcieport 0000:00:00.0: AER: enabled with IRQ 23
    [    1.940340] pci 0000:01:00.0: enabling device (0000 -> 0002)
    [    6.946090] pci 0000:01:00.0: xHCI HW not ready after 5 sec (HC bug?=
) status =3D 0x1801
    [    6.954026] pci 0000:01:00.0: quirk_usb_early_handoff+0x0/0x968 took=
 4896180 usecs

Please let me know what I can do to help.


Cheers,
--=20
Cyril Brulebois (kibi@debian.org)            <https://debamax.com/>
D-I release manager -- Release team member -- Freelance Consultant

--lzs5lyynabvj7rjw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEtg6/KYRFPHDXTPR4/5FK8MKzVSAFAmQ4FCQACgkQ/5FK8MKz
VSCn1g//bgrbJCd8aP3H59jBAPUa2gZdqBlqLxO20cmhLmn6rXSfvOsxW1X/W6GV
EKggzAwPVHMRwLiyqXfso/pCZaDimcYVvdCJCgPAgfNRZyxxA/lEQDYt/cL9W1DZ
WRrEPyjLUBcrVxLfWhRAo/S6QfvjYb8qoD2aA93rrmfccfKFdng6c36eK8QolV4J
p7iC5MdDx9r6acUaKXu3M/3ggckDdEJndArcqPWoHfAjoijTHVVgz4LAryY7kptl
MPo2NCKESA+ZQNhdoo8dlkaqYM9/z9X6Xx/pvTUFIgZmg+XGrNnruhS/ac9pgCt5
wimQpLhoSH42WwVeid6/GwUQSpDh3/pJ5AED1ThkxANFlTJcwgwfH+XuCsrLC/rD
a+u4ZcVRurVd+fgWuVl3MHt5zeVC7/sdUw81s868aEMJLpRq/i8rld0DNINhsNBK
n+nJA49pCbgUh+phV6kj6qnQA+bynk+OtSLBdcSNLKqXwvK1tE0nFixwOwX3H3WQ
jYwNsI9Pf5tNAG73PE0lieMtlg5UhDL6rmuQoh4lXsFf8RsblgDKWFqzqSQNv4SE
oKfJJyqrATdJM6JiIVo5rWjM9q5C8lU5k7mha0GfSTShB0va9TuEwrk09cM75uDi
2K9m3Q4wBDL/DRrwFN3RaTxiY5Kn6/ik03VwD0ZkA7a+gkIE8Jc=
=avfM
-----END PGP SIGNATURE-----

--lzs5lyynabvj7rjw--
