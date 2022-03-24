Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E95B4E6816
	for <lists+linux-pci@lfdr.de>; Thu, 24 Mar 2022 18:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbiCXRx7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Mar 2022 13:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234287AbiCXRx6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Mar 2022 13:53:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C277E986D8
        for <linux-pci@vger.kernel.org>; Thu, 24 Mar 2022 10:52:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B6A561A39
        for <linux-pci@vger.kernel.org>; Thu, 24 Mar 2022 17:52:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB822C340F0;
        Thu, 24 Mar 2022 17:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648144344;
        bh=6C6kqkrSj83XASrBRBfrMBGXN/Z258n6P63FqsAcTlc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lnrTV2cEY/dMjSRfFN9F8MLFbQll91PsXMrCuKF7yZEJLFZYH/Q5KyGlqhkhledYD
         N0HOsXovhFKc8uyefW/gm+eXF612x2Rp6KZRVhHNPGrAsm+4UVq+WjFwQbcvPeafWe
         S7Z49a08rlWFAzc+H5t1hMiid2ZR+k6h/+6DCtJ9yLw9BM8VwycUbQSrHgG6znJ+nW
         wFIZaagNdc+iZLDYHeRN6g3ATXIAQRb9Be4BjWHyGntXKTATb67ms+X8dOkksdcZbZ
         UtviZskt/lwKUQE0wVd27npfnA3J5SnRdvVMa0qgX9EUZVHuq2UTuPwVJdF0X2c1hh
         S6p152ZDhSFgg==
Date:   Thu, 24 Mar 2022 17:52:19 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     kernelci-results@groups.io, bot@kernelci.org,
        gtucker@collabora.com, linux-pci@vger.kernel.org
Subject: Re: next/master bisection: baseline.login on asus-C523NA-A20057-coral
Message-ID: <Yjyv03JsetIsTJxN@sirena.org.uk>
References: <623c13ec.1c69fb81.8cbdb.5a7a@mx.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VOPCQCCs3M3Urbn/"
Content-Disposition: inline
In-Reply-To: <623c13ec.1c69fb81.8cbdb.5a7a@mx.google.com>
X-Cookie: Orders subject to approval.
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--VOPCQCCs3M3Urbn/
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 23, 2022 at 11:47:08PM -0700, KernelCI bot wrote:

The KernelCI bisection bot has identified commit 5949965ec9340cfc0e
("x86/PCI: Preserve host bridge windows completely covered by E820")
as causing a boot regression in next on asus-C523NA-A20057-coral (a
Chromebook AIUI).  Unfortunately there's no useful output when starting
the kernel.  I've left the full report below including links to the web
dashboard.

The last successful boot in -next had this log:

   https://storage.kernelci.org/next/master/next-20220310/x86_64/x86_64_def=
config+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C523NA-A20057-cora=
l.html

I'd also note that the machine hp-x360-12b-n4000-octopus appears to have
started failing at the same time with similar symptoms, failing log:

   https://storage.kernelci.org/next/master/next-20220324/x86_64/x86_64_def=
config+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-12b-n4000-octop=
us.html

and passing log:

   https://storage.kernelci.org/next/master/next-20220310/x86_64/x86_64_def=
config+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-12b-n4000-octop=
us.html

though we didn't get a bisect for that yet.  That's also a Chromebook.

> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> * This automated bisection report was sent to you on the basis  *
> * that you may be involved with the breaking commit it has      *
> * found.  No manual investigation has been done to verify it,   *
> * and the root cause of the problem may be somewhere else.      *
> *                                                               *
> * If you do send a fix, please include this trailer:            *
> *   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
> *                                                               *
> * Hope this helps!                                              *
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
>=20
> next/master bisection: baseline.login on asus-C523NA-A20057-coral
>=20
> Summary:
>   Start:      f8833a2b2356 Add linux-next specific files for 20220322
>   Plain log:  https://storage.kernelci.org/next/master/next-20220322/x86_=
64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C523N=
A-A20057-coral.txt
>   HTML log:   https://storage.kernelci.org/next/master/next-20220322/x86_=
64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C523N=
A-A20057-coral.html
>   Result:     5949965ec934 x86/PCI: Preserve host bridge windows complete=
ly covered by E820
>=20
> Checks:
>   revert:     PASS
>   verify:     PASS
>=20
> Parameters:
>   Tree:       next
>   URL:        https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-=
next.git
>   Branch:     master
>   Target:     asus-C523NA-A20057-coral
>   CPU arch:   x86_64
>   Lab:        lab-collabora
>   Compiler:   gcc-10
>   Config:     x86_64_defconfig+x86-chromebook
>   Test case:  baseline.login
>=20
> Breaking commit found:
>=20
> -------------------------------------------------------------------------=
------
> commit 5949965ec9340cfc0e65f7d8a576b660b26e2535
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Thu Mar 3 18:03:30 2022 -0600
>=20
>     x86/PCI: Preserve host bridge windows completely covered by E820
>    =20
>     Many folks have reported PCI devices not working.  It could affect any
>     device, but most reports are for Thunderbolt controllers on Lenovo Yo=
ga and
>     Clevo Barebone laptops and the touchpad on Lenovo IdeaPads.
>    =20
>     In every report, a region in the E820 table entirely encloses a PCI h=
ost
>     bridge window from _CRS, and because of 4dc2287c1805 ("x86: avoid E820
>     regions when allocating address space"), we ignore the entire window,
>     preventing us from assigning space to PCI devices.
>    =20
>     For example, the dmesg log [2] from bug report [1] shows:
>    =20
>       BIOS-e820: [mem 0x000000004bc50000-0x00000000cfffffff] reserved
>       pci_bus 0000:00: root bus resource [mem 0x65400000-0xbfffffff windo=
w]
>       pci 0000:00:15.0: BAR 0: no space for [mem size 0x00001000 64bit]
>    =20
>     The efi=3Ddebug dmesg log [3] from the same report shows the EFI memo=
ry map
>     entries that created the E820 map:
>    =20
>       efi: mem47: [Reserved |   |WB|WT|WC|UC] range=3D[0x4bc50000-0x5ffff=
fff]
>       efi: mem48: [Reserved |   |WB|  |  |UC] range=3D[0x60000000-0x60fff=
fff]
>       efi: mem49: [Reserved |   |  |  |  |  ] range=3D[0x61000000-0x653ff=
fff]
>       efi: mem50: [MMIO     |RUN|  |  |  |UC] range=3D[0x65400000-0xcffff=
fff]
>    =20
>     4dc2287c1805 ("x86: avoid E820 regions when allocating address space")
>     works around issues where _CRS contains non-window address space that=
 can't
>     be used for PCI devices.  It does this by removing E820 regions from =
host
>     bridge windows.  But in these reports, the E820 region covers the ent=
ire
>     window, so 4dc2287c1805 makes it completely unusable.
>    =20
>     Per UEFI v2.8, sec 7.2, the EfiMemoryMappedIO type means:
>    =20
>       Used by system firmware to request that a memory-mapped IO region be
>       mapped by the OS to a virtual address so it can be accessed by EFI
>       runtime services.
>    =20
>     A host bridge window is definitely a memory-mapped IO region, and EFI
>     runtime services may need to access it, so I don't think we can argue=
 that
>     this is a firmware defect.
>    =20
>     Instead, change the 4dc2287c1805 strategy so it only removes E820 reg=
ions
>     when they overlap *part* of a host bridge window on the assumption th=
at a
>     partial overlap is really register space, not part of the window prop=
er.
>    =20
>     If an E820 region covers the entire window from _CRS, assume the _CRS
>     window is correct and do nothing.
>    =20
>     [1] https://bugzilla.redhat.com/show_bug.cgi?id=3D1868899
>     [2] https://bugzilla.redhat.com/attachment.cgi?id=3D1711424
>     [3] https://bugzilla.redhat.com/attachment.cgi?id=3D1861407
>    =20
>     BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=3D206459
>     BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=3D214259
>     BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1868899
>     BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1871793
>     BugLink: https://bugs.launchpad.net/bugs/1878279
>     BugLink: https://bugs.launchpad.net/bugs/1931715
>     BugLink: https://bugs.launchpad.net/bugs/1932069
>     BugLink: https://bugs.launchpad.net/bugs/1921649
>     Fixes: 4dc2287c1805 ("x86: avoid E820 regions when allocating address=
 space")
>     Link: https://lore.kernel.org/r/20220228105259.230903-1-hdegoede@redh=
at.com
>     Based-on-patch-by: Hans de Goede <hdegoede@redhat.com>
>     Link: https://lore.kernel.org/r/20220304035110.988712-4-helgaas@kerne=
l.org
>     Reported-by: Benoit Gr=E9goire <benoitg@coeus.ca>   # BZ 206459
>     Reported-by: wse@tuxedocomputers.com              # BZ 214259
>     Tested-by: Matt Hansen <2lprbe78@duck.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>     Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>     Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> diff --git a/arch/x86/kernel/resource.c b/arch/x86/kernel/resource.c
> index 7378ea146976..90203217c359 100644
> --- a/arch/x86/kernel/resource.c
> +++ b/arch/x86/kernel/resource.c
> @@ -39,6 +39,21 @@ void remove_e820_regions(struct device *dev, struct re=
source *avail)
>  		e820_start =3D entry->addr;
>  		e820_end =3D entry->addr + entry->size - 1;
> =20
> +		/*
> +		 * If an E820 entry covers just part of the resource, we
> +		 * assume E820 is telling us about something like host
> +		 * bridge register space that is unavailable for PCI
> +		 * devices.  But if it covers the *entire* resource, it's
> +		 * more likely just telling us that this is MMIO space, and
> +		 * that doesn't need to be removed.
> +		 */
> +		if (e820_start <=3D avail->start && avail->end <=3D e820_end) {
> +			dev_info(dev, "resource %pR fully covered by e820 entry [mem %#010Lx-=
%#010Lx]\n",
> +				 avail, e820_start, e820_end);
> +
> +			continue;
> +		}
> +
>  		resource_clip(avail, e820_start, e820_end);
>  		if (orig.start !=3D avail->start || orig.end !=3D avail->end) {
>  			dev_info(dev, "clipped %pR to %pR for e820 entry [mem %#010Lx-%#010Lx=
]\n",
> -------------------------------------------------------------------------=
------
>=20
>=20
> Git bisection log:
>=20
> -------------------------------------------------------------------------=
------
> git bisect start
> # good: [5628b8de1228436d47491c662dc521bc138a3d43] Merge tag 'random-5.18=
-rc1-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/crng/random
> git bisect good 5628b8de1228436d47491c662dc521bc138a3d43
> # bad: [f8833a2b23562be2dae91775127c8014c44d8566] Add linux-next specific=
 files for 20220322
> git bisect bad f8833a2b23562be2dae91775127c8014c44d8566
> # bad: [d2de72259f3d22054272217eac92e624835bfc3b] Merge branch 'master' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
> git bisect bad d2de72259f3d22054272217eac92e624835bfc3b
> # bad: [5920db3e4b50218dcf2101f3d87c3b69a1120981] Merge branch 'for-next'=
 of git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git
> git bisect bad 5920db3e4b50218dcf2101f3d87c3b69a1120981
> # bad: [b579dc07dce4637b7f2a3fb84394ebbd6666a81f] Merge branch 'for-next'=
 of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git
> git bisect bad b579dc07dce4637b7f2a3fb84394ebbd6666a81f
> # bad: [b5475dd9fab03e6867abad00ecb98e0d3827ad31] Merge branch 'for-next'=
 of git://git.armlinux.org.uk/~rmk/linux-arm.git
> git bisect bad b5475dd9fab03e6867abad00ecb98e0d3827ad31
> # good: [7b72f3bb0907319e15765ae9dcf1f15fdd112bcf] Merge remote-tracking =
branch 'asoc/for-5.17' into asoc-linus
> git bisect good 7b72f3bb0907319e15765ae9dcf1f15fdd112bcf
> # bad: [077dc6bc0658177057bfd69ef3a990e6d8d32146] Merge branch 'gpio/for-=
current' of git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git
> git bisect bad 077dc6bc0658177057bfd69ef3a990e6d8d32146
> # good: [fd11727eec0dd95ee1b7d8f9f10ee60678eecc29] crypto: hisilicon/qm -=
 fix memset during queues clearing
> git bisect good fd11727eec0dd95ee1b7d8f9f10ee60678eecc29
> # good: [646b907e1559f006c79a752ee3eebe220ceb983d] Merge tag 'asoc-v5.18'=
 of https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound into for-=
linus
> git bisect good 646b907e1559f006c79a752ee3eebe220ceb983d
> # bad: [f8ed0b7c999405bd12ab9ebb0765e2baa7eb6184] Merge branch 'for-linus=
' of git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
> git bisect bad f8ed0b7c999405bd12ab9ebb0765e2baa7eb6184
> # good: [9fd75b66b8f68498454d685dc4ba13192ae069b0] ax25: Fix refcount lea=
ks caused by ax25_cb_del()
> git bisect good 9fd75b66b8f68498454d685dc4ba13192ae069b0
> # good: [3fd177beee75eb2d7e5b19992e8c90eb1a141432] Merge branch 'for-linu=
s' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
> git bisect good 3fd177beee75eb2d7e5b19992e8c90eb1a141432
> # good: [09005bef55291a99b491a47ce676dfb4f40f8edd] Merge branch 'for-linu=
s' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
> git bisect good 09005bef55291a99b491a47ce676dfb4f40f8edd
> # good: [d13f73e9108a75209d03217d60462f51092499fe] x86/PCI: Log host brid=
ge window clipping for E820 regions
> git bisect good d13f73e9108a75209d03217d60462f51092499fe
> # bad: [5949965ec9340cfc0e65f7d8a576b660b26e2535] x86/PCI: Preserve host =
bridge windows completely covered by E820
> git bisect bad 5949965ec9340cfc0e65f7d8a576b660b26e2535
> # first bad commit: [5949965ec9340cfc0e65f7d8a576b660b26e2535] x86/PCI: P=
reserve host bridge windows completely covered by E820
> -------------------------------------------------------------------------=
------
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Groups.io Links: You receive all messages sent to this group.
> View/Reply Online (#25006): https://groups.io/g/kernelci-results/message/=
25006
> Mute This Topic: https://groups.io/mt/89994186/1131744
> Group Owner: kernelci-results+owner@groups.io
> Unsubscribe: https://groups.io/g/kernelci-results/unsub [broonie@kernel.o=
rg]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20
>=20

--VOPCQCCs3M3Urbn/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmI8r9IACgkQJNaLcl1U
h9DQpgf/XkkDet0208MTy6XNIaZZFLVp71ngQ+3FWdXDRnlx+CP2nJgrcqPhNMxT
YqNziFjGE2nCCCRrT/OwrNrO4XvuCVgpBdKeW3Kaf2A1FRtCqArgEOYP5gaTe4hp
7kowTJIiMRGUAd4Sl5FFubzfPXxybAcY8yAjbvbnzvvBKyK3elIwMfR9pvJe+s53
+bOV4GWj68bblGjLNn9bo38/Ncr1bWQaIQfRHFhKtZSmVc6aG0EZ2f901djXeeZP
qYtACEQke5Rtw0J0DC7nUzZLSpgQp8ql7gWnb5nAVEuO0DeH52d+8JC1sBfjsoF2
qi+vkzO7kXAQFZP6BopYWDPjjvRr0Q==
=OJ5x
-----END PGP SIGNATURE-----

--VOPCQCCs3M3Urbn/--
