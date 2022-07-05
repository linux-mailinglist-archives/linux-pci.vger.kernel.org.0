Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18112567952
	for <lists+linux-pci@lfdr.de>; Tue,  5 Jul 2022 23:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbiGEV2R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Jul 2022 17:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbiGEV2L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Jul 2022 17:28:11 -0400
Received: from hobbes.mraw.org (hobbes.mraw.org [195.154.31.160])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E410186F3;
        Tue,  5 Jul 2022 14:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mraw.org;
        s=mail2022; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=OGrJpv6SgTppBb5LW8Mk4z+j5DsZc2mQk5nWhvhWzYo=; b=r8w7tEMjcXXW1yEYiLOkm3uhZ3
        JVf3r+c6eBFcKgfc5RoreRQH7taHv/FfXGAx4NA3Ar/SF3lo73jSll806L8myiYDChT3nsUIEJ/Rd
        zWxdJdKrsFaOJjPGl7BNkIy9RZyr9/+FHk9tW+MZi4W0bOoVdrWycVRfGjsHSkURoUFCEgsdgxYct
        CycJ98GSkb6BI/ynd06N9S8em0xhMbN6MIfSS/9agkhD2bgyT0B5QQ8Nl8zoDo24MA1txTn1NRfLS
        37NI5CeTZLjdKvxSYTroZJaGRJkwpHukWHBdaDqwTk8cMpHfKFoRt1BKsE6JVojd8y0HOQTuoCTkv
        ZWJm3w6g==;
Received: from 82-64-171-251.subs.proxad.net ([82.64.171.251] helo=mraw.org)
        by hobbes.mraw.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <kibi@debian.org>)
        id 1o8q5T-000w2b-77; Tue, 05 Jul 2022 23:28:03 +0200
Date:   Tue, 5 Jul 2022 23:28:01 +0200
From:   Cyril Brulebois <kibi@debian.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Jim Quinlan <jim2101024@gmail.com>, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v1 0/4] PCI: brcmstb: Re-submit reverted patchset
Message-ID: <20220705212801.u2mq6iyq2dtwzc36@mraw.org>
Organization: Debian
References: <20220701162726.31346-1-jim2101024@gmail.com>
 <1a50e8b0-1453-4561-bc3d-c428bb65288a@gmail.com>
 <20220705205551.phbaqqpgyg3pvtv7@mraw.org>
 <68af8b36-76b7-23d2-c689-d05fd62086b1@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vzxz45xthrsgbxzp"
Content-Disposition: inline
In-Reply-To: <68af8b36-76b7-23d2-c689-d05fd62086b1@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--vzxz45xthrsgbxzp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Florian Fainelli <f.fainelli@gmail.com> (2022-07-05):
> On 7/5/22 13:55, Cyril Brulebois wrote:
> > That happens with current master (v5.19-rc5-56-ge35e5b6f695d2), with
> > or without this patchset.
> >=20
> > That being said, I'm not able to reproduce the showstopper
> > regression that I reported against the initial patchset (booting was
> > breaking in the very first few seconds), so I suppose it's fine to
> > propose the following even if that's somewhat tainted by those mmc
> > issues.
>=20
> Any chance you can bisect the eMMC issues so we can investigate those
> separately? Thanks!

Definitely. I wanted to make sure I wouldn't delay the reintroduction of
this patchset (feeling partly responsible for the revert that happened
in the first place), by providing some feedback regarding a possible
come-back of the regression, as soon as possible.

Now that this is out of the way, I'll try and find time to investigate
those MMC issues. Ditto for DRM, I seem to have completely lost the HDMI
output (that's less of an issue thanks to the serial console that has
been rather reliable to gather kernel logs).

I think I started encountering both issues very early in the devel
cycle (when we were still trying to find some follow-up commits to fix
the regression instead of going for the full-on revert), but I couldn't
afford spending time chasing multiple issues at once. I haven't checked
whether reports exist already for those issues, but that's my next step.


Cheers,
--=20
Cyril Brulebois (kibi@debian.org)            <https://debamax.com/>
D-I release manager -- Release team member -- Freelance Consultant

--vzxz45xthrsgbxzp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEtg6/KYRFPHDXTPR4/5FK8MKzVSAFAmLErN4ACgkQ/5FK8MKz
VSBN8w/+NpLkYZp8RmX6Fs3IM6/B5mUAYmNraZx9jYXAdkm/VBCARJxxDjs3LUWm
/5bPX98tETF0c8its+c5KyUgKG4wnNsgiL8VbvNDPZ3Kj/nKDqAqG+L8DoeL7RNp
x+9lqppkz9ZSsHOBf6DKHRL2W0btCNYqJknSkOh7yxulIG/HQNYq3NmFvKu6/vdO
/EXA4Luy8wdRwJR9/uGwlQEc294KKSOoomIZHey8gbWX5K6rnLqYgbp6CFwwbTDb
sd4c5lFFo679g1ODdog+RTxJfmxfZBQ0TCe0KJoPm4laXrDeLvanZM8kJaHGFE6f
TZ0f1TXZ2m7fwCAmAz5WmfSlL0kgEcbtvg4iYVzoJu/+nQY7nweFfMmQMMj7ksJ2
dETLCi3pD2d/PY1EtWhFyc6vrtoJiRQezTfBe453jVdiJtJZrKMxEBlG568UByXs
3yjpcSj9g5JyPtZ78anqaxjF+aCY74rhis9L8s8Pk6pyKTyvVDfO+N3Zww7l6eUq
oKaqj6hfFgwRYg9IC5VUMJeOdar7T7yGdyWbSp4iMRCi1H7xnoAgLeQmWGSVeTNR
FWaprp2dy3Y2mDlQTg7pLQoWrNo429hI7HPi3FSdVhqYwaTu0RWappOU4GbOZ4Jo
UArW/jnJHu+aWTcMklfnGQcOOXy/DFuNM8njAo3IZEWdT67a+ro=
=nTwC
-----END PGP SIGNATURE-----

--vzxz45xthrsgbxzp--
