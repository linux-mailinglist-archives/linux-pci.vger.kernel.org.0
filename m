Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB3E53BE8D
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jun 2022 21:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238429AbiFBTSR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jun 2022 15:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238445AbiFBTSQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jun 2022 15:18:16 -0400
Received: from hobbes.mraw.org (hobbes.mraw.org [195.154.31.160])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CD33CFDE;
        Thu,  2 Jun 2022 12:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mraw.org;
        s=mail2022; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=d4XvQZuUNWiiJkWzK1Brb0QRzliyWqwmPdPvqncZkG8=; b=kro9Z27A4pnNzk/523zcxKFZM3
        uJcVdPbhN+y/epB9sf3fbg2Ztaut4regb6t74HySs9ZT27dNtG+/eyI0Edf6PSuPYv2XojG4VPdf6
        ROjZtLX0poOcaVbbPAJx59HUpIfuTsqWauLDZO8/l5nyZuD1XmUpmlQ5RwrFOHuHZ6Ca0JXE9YL87
        7eucgmbEZYtEoKt0hga39vjnNeAoRr7LGJBQmhcLfp5I4m10E5dxtk8Hb7TGh8xiRVuXsEOPcE//3
        vA6hmxXkkz9Vqi3mDagdt+NOrr5+ou4XwLycJk9y5MGWeQ09hbD5gdnaTsoRGw/87Q1Pm8hl4HOJp
        qOsOKKTQ==;
Received: from 82-64-171-251.subs.proxad.net ([82.64.171.251] helo=mraw.org)
        by hobbes.mraw.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <kibi@debian.org>)
        id 1nwqKV-008WAr-7i; Thu, 02 Jun 2022 21:17:59 +0200
Date:   Thu, 2 Jun 2022 21:17:57 +0200
From:   Cyril Brulebois <kibi@debian.org>
To:     Stefan Wahren <stefan.wahren@i2se.com>
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
Subject: Re: [PATCH v2 1/1] PCI: brcmstb: Fix regression regarding missing
 PCIe linkup
Message-ID: <20220602191757.pqictbfarmvlf72f@mraw.org>
Organization: Debian
References: <20220528224423.7017-1-jim2101024@gmail.com>
 <20220528224423.7017-2-jim2101024@gmail.com>
 <20220529011526.4lzuvkv5zclwntce@mraw.org>
 <d7a5a0d8-5d27-548f-bc94-0e7d116cc3f2@i2se.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="e6x3pkp6gefd6bwh"
Content-Disposition: inline
In-Reply-To: <d7a5a0d8-5d27-548f-bc94-0e7d116cc3f2@i2se.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--e6x3pkp6gefd6bwh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Stefan,

Stefan Wahren <stefan.wahren@i2se.com> (2022-05-30):
> i think we should better trust the results based on the v5.18 tag. During
> the merge window, regressions from other subsystems are possible.

Alright, that looks like a great plan.

Before getting your answer, I had tried taking the reboot part out of
the equation, but I found out that even cold boots might fail with the
mmc storage.

I haven't been able to conduct a systematic testing of the patch on top
of the v5.18 tag yet (say, 10 or 20 cold boots, and the same with
reboots) due to strong work constraints these past few days, but that's
definitely still on my short term todo list (hopefully before the end of
the week).

Sorry I didn't manage to get that lined up before Bjorn's pull request.


Cheers,
--=20
Cyril Brulebois (kibi@debian.org)            <https://debamax.com/>
D-I release manager -- Release team member -- Freelance Consultant

--e6x3pkp6gefd6bwh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEtg6/KYRFPHDXTPR4/5FK8MKzVSAFAmKZDOEACgkQ/5FK8MKz
VSAxHw//UqQVStG4n6PM9GwjjAexTX9ACfI8AU1/Hz9oPvhlcB95cjd/LnJUm2yP
y2xSb5A19sNey7lYh3jga7Q2mh6nuu+lw7gqt2NfrHwN4ni/EP+0xrBbleMgEooh
NW7xVd3aF1E7zTGGsIgl8H0CgfI2Mv+EhY/gXdV32iPw3puLYC6x28NICKsVlImr
BoMbMVEK8gWjxT0SLxRiTj11doR+Dccbely2DNSrIe+p/aSiH5nTtAsnagz0eYym
sijizAkR7luWZb+Q8MUpGpD9Ptp0oXITGKsBAPTHPotnrTE2DcF1k9PXLdKm72/L
hJdWamlj3Biuz9q6uOAMqFGFBLxqEr58p/S0ph89CRXuK1w97xpfhUn9lmyGI50W
YsrQhg86cKmRIF7gX2Ax/OceS3WabTXuk77zm+8IhF99DUt8wxWML1H8Xbqo8CMG
09f6Rfa/FOfHVB3avbdqVHJ7LYqb6F9iqW02QLbMwlJmhEKB7VAeSbty1S+dqcHn
JEWLieJ9PRETIzp66BEs5BRrivJGFv0lGD8joDOKFZf3VH2tzLwH71aaAgK4yXA0
jRy6HlGyVt0SLWgFXltuI6MCh771PEmPA7kOmb8uDrM4LmN4h/BYk8XjYDNrUHa+
Hd+XcATSfWkJQSTMuVfNfwFDVFqRVaSwjLy+UwcmTmqCA+wQLC8=
=JkNy
-----END PGP SIGNATURE-----

--e6x3pkp6gefd6bwh--
