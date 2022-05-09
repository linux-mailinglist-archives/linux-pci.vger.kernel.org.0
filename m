Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0A54520459
	for <lists+linux-pci@lfdr.de>; Mon,  9 May 2022 20:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240103AbiEISVX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 May 2022 14:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240134AbiEISVW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 May 2022 14:21:22 -0400
X-Greylist: delayed 1903 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 09 May 2022 11:17:26 PDT
Received: from hobbes.mraw.org (hobbes.mraw.org [195.154.31.160])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E614526C4D6
        for <linux-pci@vger.kernel.org>; Mon,  9 May 2022 11:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mraw.org;
        s=mail2022; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=/AbJu07AVkebdRbVb4cnZuMPRRUQJilRZfHMvZ/Ym3A=; b=tu2gB7shXKWudKlpO8TnnE9pFL
        Jh3Dt9LhBeURa+2PkUYhHXac5+PDfdPOstlpPX2OGPV30en6k0Kz/gS4slV+RT3NqrocFr1/eBuro
        locXQhrY7hk6Ge0bF5r2QU4lYYyCC/knCX6AfgBqiA+1SZqyZVr7gV8HEnfgPHA/lQBpkL8+6LbM6
        EefCU82YLf0au678XpADXCwhO5iBU73wzuu9ffQ1MkTftGF5APp9FcupTYrB/kJ7g7hqG1Dbb5OO3
        iWrsPdyjOl5alRo3lEh0HAo2tDS2hli3lCnoCkpJtKbcnczDTDdBg2seVR5Ag7aNpPN4INntpf92B
        7Jv0ii/g==;
Received: from 82-64-171-251.subs.proxad.net ([82.64.171.251] helo=mraw.org)
        by hobbes.mraw.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <kibi@debian.org>)
        id 1no7Rp-003fbK-8u; Mon, 09 May 2022 19:45:29 +0200
Date:   Mon, 9 May 2022 19:45:27 +0200
From:   Cyril Brulebois <kibi@debian.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Jim Quinlan <jim2101024@gmail.com>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Linux PCI <linux-pci@vger.kernel.org>, bjorn@helgaas.com
Subject: Re: [Bug 215925] New: PCIe regression on Raspberry Pi Compute Module
 4 (CM4) breaks booting
Message-ID: <20220509174527.zoqhmaxfwo7udezo@mraw.org>
Organization: Debian
References: <3aa008b9-e477-3e6d-becb-13e28ea91f10@leemhuis.info>
 <20220509170708.GA604646@bhelgaas>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fm7uldoigioq6ukb"
Content-Disposition: inline
In-Reply-To: <20220509170708.GA604646@bhelgaas>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--fm7uldoigioq6ukb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Bjorn,

Bjorn Helgaas <helgaas@kernel.org> (2022-05-09):
> Cyril, 830aa6f29f07 ("PCI: brcmstb: Split brcm_pcie_setup() into two
> funcs") reverts cleanly as of 57ae8a492116.  Does reverting it avoid
> the regression?

I didn't even try and revert this commit before you suggested doing so
since it was supposed to be some preliminary work. Quoting a part of
its commit message:

    In future commits the brcm_pcie_linkup() function will be called
    indirectly by pci_host_probe() as opposed to the host driver
    invoking it directly.


Anyway, the patch can indeed be reverted on top of v5.18-rc4 or
v5.18-rc6 but the build fails due to the former function being removed,
while being still called from other places:

      CC      drivers/pci/controller/pcie-brcmstb.o
    drivers/pci/controller/pcie-brcmstb.c:199:12: warning: =E2=80=98brcm_pc=
ie_linkup=E2=80=99 used but never defined
      199 | static int brcm_pcie_linkup(struct brcm_pcie *pcie);
          |            ^~~~~~~~~~~~~~~~
    =E2=80=A6
    aarch64-linux-gnu-ld: drivers/pci/controller/pcie-brcmstb.o: in functio=
n `brcm_pcie_add_bus':
    /home/kibi/hack/linux.git/drivers/pci/controller/pcie-brcmstb.c:527: un=
defined reference to `brcm_pcie_linkup'


See for example:

    commit 93e41f3fca3d4a0f927b784012338c37f80a8a80
    Author: Jim Quinlan <jim2101024@gmail.com>
    Date:   Thu Jan 6 11:03:29 2022 -0500
   =20
        PCI: brcmstb: Add control of subdevice voltage regulators

(And that one cannot be trivially reverted.)


Cheers,
--=20
Cyril Brulebois (kibi@debian.org)            <https://debamax.com/>
D-I release manager -- Release team member -- Freelance Consultant

--fm7uldoigioq6ukb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEtg6/KYRFPHDXTPR4/5FK8MKzVSAFAmJ5UzIACgkQ/5FK8MKz
VSD5Hw//RC0xiVTWjeHCHLECJ2DqOpmSZrswB7wQcMF8leixZxYdcy9YVdGpwTaC
nyQ/t1LhXor7iDlQkn0o6YncDR/LKHp1TrKjNVbjF4I838V+859INYgyKp7rsWaB
tXQVK8GB3Haw1bEWIkzPlTliqAN41Yl+JY77qhWWwxw/VDsmjCoq9II8frIR7/KF
lChgPY7FXZcIpBWcHABld/mW/qWWZH6CwOxPQidfXebsXmeC8cVqG0kWN/psI4NQ
FNOPRZC1FwydTiZZb1kaXxfxxlRaPh5txG4jJTshn7WhZArdN92NPZ2z1Btt/SuG
+NQyGH6HTY4X5HOv9DN4PRpQN/1VEg91D6cSt/G1CMJsjZvVUr+RF0Wr/LjyndtQ
a+7+IX01wK52UaMpg+BaRt5RT7I5+x5j9CDgOiBzn+kbUhSYY0jBdhCtayPUR6Zx
v/ICrNpGT1HPMggKHBYKTh1b1KFFaJ6vhPQbPwcVvgYiOkms7+yRlYUGQyfkP570
lJhFj07MgWTNZpGt1JKXVQqe6vhw0tHf2mmwLQLndH6949cAqaI8Rx2/d6H//QEx
XZwTuAp2Mod/FMXYr9xCnUj4O70YgaiH+QINZ6aq9MDz4eh881SYrFIfkjfcijz6
+eFIM+/LtPBrjmwrY05gsfKq2rtUsaRWAfJocdEHCLCqCn/bDww=
=jOW6
-----END PGP SIGNATURE-----

--fm7uldoigioq6ukb--
