Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A997562241
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jun 2022 20:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234038AbiF3Son (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Jun 2022 14:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbiF3Som (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jun 2022 14:44:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1B430563;
        Thu, 30 Jun 2022 11:44:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7B016B82CF7;
        Thu, 30 Jun 2022 18:44:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 273F8C34115;
        Thu, 30 Jun 2022 18:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656614678;
        bh=4rGXlv8k74zN/Y7peMOFVh60dbAYJIN6nFPI4SXzDuA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k1EIRVbIdINvaCB4xhq1UscRcTCdxcX0d3oVJG3BQ/gT5BsRzK7Jf1/gbd4tc/Jd3
         zJBN8VHjrowJyfr7PFudkMssy/elSDB22E5iuglSPq+Qtr2xD1MtOidPKwPzRnXIkH
         42/GqBVtUSIx74CyeLNAnAKb57p8AgzzkFn1cuQQ8BmFkJBWpAuf+CjQ4iEvd23+cZ
         bPKuz7UPUK/xXDjTFk9Oo/zYWa+nnqFwumlSdjCyuf+lXXIoD1LvVcXJKDbDrqjqkC
         TKe2aE1YCCFLwAul3TfTVUCjrzXftnd5q/hijgB7FyYmbCibnlc53cNLbTSsJeKiCR
         0LdpfkSHdTcCA==
Date:   Thu, 30 Jun 2022 19:44:32 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernelci-results@groups.io, bot@kernelci.org,
        gtucker@collabora.com, Michael Walle <michael@walle.cc>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: next/master bisection: baseline.bootrr.imx6q-pcie-pcie0-probed
 on kontron-pitx-imx8m
Message-ID: <Yr3vEDDulZj1Dplv@sirena.org.uk>
References: <62bdec26.1c69fb81.46bc5.2d67@mx.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Zb69GTb6xvS2/FfO"
Content-Disposition: inline
In-Reply-To: <62bdec26.1c69fb81.46bc5.2d67@mx.google.com>
X-Cookie: Today is what happened to yesterday.
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--Zb69GTb6xvS2/FfO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 30, 2022 at 11:32:06AM -0700, KernelCI bot wrote:

The KernelCI bisection bot identified a failure to probe the PCI bus on
kontron-pitx-imx8m in -next resulting from commit (5a46079a96451 PM:
domains: Delete usage of driver_deferred_probe_check_state()) with at
least an arm64 defconfig+64K_PAGES.

The only logging I see from PCI in the failing boot is:

   <6>[    0.580973] PCI: CLS 0 bytes, default 64

there's none of the host bridge enumeration starting with

  <6>[    2.394399] imx6q-pcie 33800000.pcie: host bridge /soc@0/pcie@33800=
000 ranges:
  <6>[    2.396012] imx6q-pcie 33c00000.pcie: host bridge /soc@0/pcie@33c00=
000 ranges:

that is seen with working boots.

I've left the full bot report below, it's got a Reported-by tag, links
to more details including full boot logs and more.  The bot checked that
reverting the patch seems to fix the problem.

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
> next/master bisection: baseline.bootrr.imx6q-pcie-pcie0-probed on kontron=
-pitx-imx8m
>=20
> Summary:
>   Start:      6cc11d2a17592 Add linux-next specific files for 20220630
>   Plain log:  https://storage.kernelci.org/next/master/next-20220630/arm6=
4/defconfig+CONFIG_ARM64_64K_PAGES=3Dy/gcc-10/lab-kontron/baseline-kontron-=
pitx-imx8m.txt
>   HTML log:   https://storage.kernelci.org/next/master/next-20220630/arm6=
4/defconfig+CONFIG_ARM64_64K_PAGES=3Dy/gcc-10/lab-kontron/baseline-kontron-=
pitx-imx8m.html
>   Result:     5a46079a96451 PM: domains: Delete usage of driver_deferred_=
probe_check_state()
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
>   Target:     kontron-pitx-imx8m
>   CPU arch:   arm64
>   Lab:        lab-kontron
>   Compiler:   gcc-10
>   Config:     defconfig+CONFIG_ARM64_64K_PAGES=3Dy
>   Test case:  baseline.bootrr.imx6q-pcie-pcie0-probed
>=20
> Breaking commit found:
>=20
> -------------------------------------------------------------------------=
------
> commit 5a46079a96451cfb15e4f5f01f73f7ba24ef851a
> Author: Saravana Kannan <saravanak@google.com>
> Date:   Wed Jun 1 00:06:57 2022 -0700
>=20
>     PM: domains: Delete usage of driver_deferred_probe_check_state()
>    =20
>     Now that fw_devlink=3Don by default and fw_devlink supports
>     "power-domains" property, the execution will never get to the point
>     where driver_deferred_probe_check_state() is called before the suppli=
er
>     has probed successfully or before deferred probe timeout has expired.
>    =20
>     So, delete the call and replace it with -ENODEV.
>    =20
>     Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
>     Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
>     Signed-off-by: Saravana Kannan <saravanak@google.com>
>     Link: https://lore.kernel.org/r/20220601070707.3946847-2-saravanak@go=
ogle.com
>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>=20
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 739e52cd4aba5..3e86772d5fac5 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2730,7 +2730,7 @@ static int __genpd_dev_pm_attach(struct device *dev=
, struct device *base_dev,
>  		mutex_unlock(&gpd_list_lock);
>  		dev_dbg(dev, "%s() failed to find PM domain: %ld\n",
>  			__func__, PTR_ERR(pd));
> -		return driver_deferred_probe_check_state(base_dev);
> +		return -ENODEV;
>  	}
> =20
>  	dev_dbg(dev, "adding to PM domain %s\n", pd->name);
> -------------------------------------------------------------------------=
------
>=20
>=20
> Git bisection log:
>=20
> -------------------------------------------------------------------------=
------
> git bisect start
> # good: [d9b2ba67917c18822c6a09af41c32fa161f1606b] Merge tag 'platform-dr=
ivers-x86-v5.19-3' of git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/p=
latform-drivers-x86
> git bisect good d9b2ba67917c18822c6a09af41c32fa161f1606b
> # bad: [6cc11d2a1759275b856e464265823d94aabd5eaf] Add linux-next specific=
 files for 20220630
> git bisect bad 6cc11d2a1759275b856e464265823d94aabd5eaf
> # good: [7391068f14aafb8c5bb9d5aeb07ecfa55c89be42] Merge branch 'drm-next=
' of https://gitlab.freedesktop.org/agd5f/linux
> git bisect good 7391068f14aafb8c5bb9d5aeb07ecfa55c89be42
> # good: [17daf6a2ab5178cf52a20d1c85470ea4638d4310] Merge branch 'next' of=
 git://git.kernel.org/pub/scm/virt/kvm/kvm.git
> git bisect good 17daf6a2ab5178cf52a20d1c85470ea4638d4310
> # bad: [a143ea0f3ce59385089e6e7b71b04fd0b5621bd8] Merge branch 'for-next'=
 of git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git
> git bisect bad a143ea0f3ce59385089e6e7b71b04fd0b5621bd8
> # bad: [57b6609eb7251280cf9f34fdebf1244f10673749] Merge branch 'icc-next'=
 of git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git
> git bisect bad 57b6609eb7251280cf9f34fdebf1244f10673749
> # bad: [eb3fd63a935b759df99bfe4a6b13c820204f81d3] Merge branch 'usb-next'=
 of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
> git bisect bad eb3fd63a935b759df99bfe4a6b13c820204f81d3
> # good: [048914d1bed271f04f726b7f78d0bef8cd1809f5] Merge branch 'for-next=
' of git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-hsi.git
> git bisect good 048914d1bed271f04f726b7f78d0bef8cd1809f5
> # good: [40a959d7042bb7711e404ad2318b30e9f92c6b9b] usb: host: ohci-ppc-of=
: Fix refcount leak bug
> git bisect good 40a959d7042bb7711e404ad2318b30e9f92c6b9b
> # good: [849f35422319a46c2a52289e2d5c85eb3346a921] Merge tag 'thunderbolt=
-for-v5.20-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/westeri/th=
underbolt into usb-next
> git bisect good 849f35422319a46c2a52289e2d5c85eb3346a921
> # bad: [a52ed4866d2b90dd5e4ae9dabd453f3ed8fa3cbc] mwifiex: fix sleep in a=
tomic context bugs caused by dev_coredumpv
> git bisect bad a52ed4866d2b90dd5e4ae9dabd453f3ed8fa3cbc
> # bad: [f516d01b9df2782b9399c44fa1d21c3d09211f8a] Revert "driver core: Se=
t default deferred_probe_timeout back to 0."
> git bisect bad f516d01b9df2782b9399c44fa1d21c3d09211f8a
> # bad: [f8217275b57aa48d98cc42051c2aac34152718d6] net: mdio: Delete usage=
 of driver_deferred_probe_check_state()
> git bisect bad f8217275b57aa48d98cc42051c2aac34152718d6
> # bad: [24a026f85241a01bbcfe1b263caeeaa9a79bab40] pinctrl: devicetree: De=
lete usage of driver_deferred_probe_check_state()
> git bisect bad 24a026f85241a01bbcfe1b263caeeaa9a79bab40
> # bad: [5a46079a96451cfb15e4f5f01f73f7ba24ef851a] PM: domains: Delete usa=
ge of driver_deferred_probe_check_state()
> git bisect bad 5a46079a96451cfb15e4f5f01f73f7ba24ef851a
> # first bad commit: [5a46079a96451cfb15e4f5f01f73f7ba24ef851a] PM: domain=
s: Delete usage of driver_deferred_probe_check_state()
> -------------------------------------------------------------------------=
------
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Groups.io Links: You receive all messages sent to this group.
> View/Reply Online (#28727): https://groups.io/g/kernelci-results/message/=
28727
> Mute This Topic: https://groups.io/mt/92093224/1131744
> Group Owner: kernelci-results+owner@groups.io
> Unsubscribe: https://groups.io/g/kernelci-results/unsub [broonie@kernel.o=
rg]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20
>=20

--Zb69GTb6xvS2/FfO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmK97w8ACgkQJNaLcl1U
h9BaDQf9HIE80aK47qGyUMX8nssfeBETUt+csbFtybVQ8XTCGVG9PcJz9U7ss9wO
9cBRPlOuzaHPMwm8+xC3L5sDZDwabhzSvYJMAPQiByc+kxT4rsGmqdCBkXp8Xa67
dgMvX+4m9ABlQIb3CvSJcsNFRxrJPAU5R8S+uw4vgBwIyUWFa/KE/QDtOA6dyUTe
+4AI2feWrRzMRL99O3GI56umILo0y719CcvHHI0HL8AUbxretvIs39qtT+CNw4Lq
Xcp0r4N0BZbxZHN5VCiC1Gx9BqAWjaptKRsFYqaOtcdwv5mFJJZW1h3n7y0Sx3YZ
CjDGB9C7OCS4xeBExVZutag5slc6+w==
=1IDJ
-----END PGP SIGNATURE-----

--Zb69GTb6xvS2/FfO--
