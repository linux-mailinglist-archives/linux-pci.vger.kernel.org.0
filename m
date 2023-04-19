Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3086E7EF9
	for <lists+linux-pci@lfdr.de>; Wed, 19 Apr 2023 17:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbjDSP5x (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Apr 2023 11:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbjDSP5x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Apr 2023 11:57:53 -0400
Received: from stravinsky.debian.org (stravinsky.debian.org [IPv6:2001:41b8:202:deb::311:108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2240B19A6;
        Wed, 19 Apr 2023 08:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
        s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kDbJlrgL3sjXj3G+1OO7np5Xsz4+mKZQ6I14H0THhkc=; b=aXLiIj2Fq44PA3oRVyjSzdJsSl
        U78F+oLK669QslhXPSbUOrvkxKfFOQ+fkdZVr4U3xqjJnvh8L3pWM5GBiSnujq1b32CKGFqlmoqFv
        yWGUjlYOZqaup1qUCZVcYuEa5EpE5FnppaiLFquv92r619fdk/k75AZ0kgzc/ZQrMjOzC/9U/wdPZ
        rFxgRH5Wnv1/ROhWprkMP23aYcBh2l15TrJhZimWaSxRa/pcRZahbUxZcBZ4Sfnoceqbu2HHhekLM
        YGmC3WmS6nmL5P0t2eJWKElqtL4aHieYhpSo0M3Kn3hhkrQ9Z9QKo+6Z57B33a8v3fCO6RT3c8ran
        /SUeMPzA==;
Received: from authenticated user
        by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <kibi@debian.org>)
        id 1ppABl-005q5R-T2; Wed, 19 Apr 2023 15:57:47 +0000
Date:   Wed, 19 Apr 2023 17:57:43 +0200
From:   Cyril Brulebois <kibi@debian.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
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
Message-ID: <20230419155743.j7lwvgkhdxz2zkrk@mraw.org>
Organization: Debian
References: <20230411165919.23955-1-jim2101024@gmail.com>
 <20230411165919.23955-3-jim2101024@gmail.com>
 <20230413143935.pmbyjk2boxl3rwne@mraw.org>
 <CANCKTBtXKAYf1LxR4qN+dVyxsWgyDztUVB4EdG=xhHbuhNCq5w@mail.gmail.com>
 <20230413200646.ddgsoqgmaae343nl@mraw.org>
 <CANCKTBuZ=Hxy9WgnjbauhHqXGx4QU_t8pgX=3che2K89=2BT9A@mail.gmail.com>
 <85a1cca1-f59b-6a0c-dee3-9d9ed5d6b6d1@gmail.com>
 <20230414161907.zfd2ibshfx4rz56j@mraw.org>
 <CANCKTBsgkv-8cCMi+H=3xYrdgVcDVTRNczg667L7b=DH2J76Bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3kfu6luykgorwo37"
Content-Disposition: inline
In-Reply-To: <CANCKTBsgkv-8cCMi+H=3xYrdgVcDVTRNczg667L7b=DH2J76Bw@mail.gmail.com>
X-Debian-User: kibi
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--3kfu6luykgorwo37
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jim,

It might take a few days before getting back to you regarding the
various questions you asked. To be on the safe side, I'll probably run
a cold boot for each setup a number of times (e.g. 10), so that any
possible outlier can be spotted/rejected. And maybe share results off
list once we have a better understanding of what's going on. Does that
make sense to you?

I'll cover a particular topic right away though.

Jim Quinlan <jim2101024@gmail.com> (2023-04-19):
> Second, you say that you used a different "CM4" from the one used in
> the Bugzilla  report -- what do you mean by that?   Are you referring
> to the CM4 module proper, whose only change was going from 4GB to 8GB,
> or the IO board being used?  My  testing is done with a standard RPi
> CM4 and standard RPi IO board.  Before this patch series, the only way
> this standard configuration can work for most hobbyist PCI cards (i.e.
> floating CLKREQ# pin) is by using Raspian AND adding
> "brcm,enable-l1ss" to the DT node.

Regarding the IO Board, I'm using the official Compute Module 4 IO
Board: https://www.raspberrypi.com/products/compute-module-4-io-board/

I've been using the very same IO Board for all my testing, and what I'm
changing is the standard RPi CM4 plugged on it.

> I'm guessing that you are using the configuration that you described
> to me in  a personal email: "[the] chip is embedded directly on the
> modified PCB, as opposed to plugged into the PCIe slot on the official
> CM4 IO Board".  If true, you are testing on a configuration that (a)
> is unique to you and your group and (b) must be doing something with
> the CLKREQ# signal so that your "before" case does not panic.  Is this
> the case?

That's definitely not the case.

True, as mentioned in a personal mail, we've seen problems with a custom
PCB, derived from the CM4 IO Board design, but of course there could be
some faulty design at work there=E2=80=A6 So we've first researched whether=
 the
same problem could be produced with consumer grade products, and once
we've verified that, I opened #217276 on Bugzilla.


Since Florian's testing seems overwhelmingly positive, and since I'm
seeing definitive improvement with at least one CM4, maybe it would make
sense not to block the patch series on the kernel panic I'm seeing with
the other CM4, and track that particular issue via a separate bug?


Cheers,
--=20
Cyril Brulebois (kibi@debian.org)            <https://debamax.com/>
D-I release manager -- Release team member -- Freelance Consultant

--3kfu6luykgorwo37
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEtg6/KYRFPHDXTPR4/5FK8MKzVSAFAmRAD3MACgkQ/5FK8MKz
VSCfFw//Xgtk24Lz36LgywgbE/sUr33MfyGt97IY+kXL/ODVySpZ1vKIGol4Yv7g
5DuvpJuJTbJjfGEL+LLcw9nMk9Ea+s7X//EMM6PAonKyu34ozQ1itOzkSZ1oDQQA
AElqaYCmmyfrH48/85okdcIAcGEwACpoUY5EuS8JLdXlRtF1GvdyHdN0WvZBO39V
Lnv97ZtBixmePnW15OkolViaA8W8Oft1/7qaCfsa0V1+14IiGxqNU2m0vmvm0qsz
82iKWzxaZIKJqq6WAzsQwY1b3J/fwWTMp3jd8ccFIdsMFSQEyzmB8O2x/Ue2FwPQ
RJCecXhWTGrr2gax56fZwkeq/ZLVDB6hYy1wvwOlkZesR2NJ1TrnBmL4R7NRIiCh
vnU4qlhmNZ1/Th4k9DM2llZ7Yt9d6KZHudR4XZYAYBhIWLzji9LJheG+FXpd89My
UBujmcT5FwLo1Tg3+79MSP9XCB29a5fB3axUXcR/IGbuuP+pj7v6pwOkMQTE+KO0
4u1UFwGzcKAT0Ffib6o7juOSJMWZZqH6SauZOLS+YwVAYbwKumi8GimK5Gm6BVOh
/OH6Fdp+Q+ulS1VX1/Xv8UISJTOe6jt4TkHPk/WcDJct81m0oGuo5bYFpTGtllrq
ahVxNYBmNcOsSdRYwPIjZ7hdJPFkelV3+F/54rK37NUc8diJ35Y=
=pvP0
-----END PGP SIGNATURE-----

--3kfu6luykgorwo37--
