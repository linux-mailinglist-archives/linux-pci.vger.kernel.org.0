Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5BB053341C
	for <lists+linux-pci@lfdr.de>; Wed, 25 May 2022 01:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbiEXX40 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 May 2022 19:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiEXX4Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 May 2022 19:56:25 -0400
Received: from hobbes.mraw.org (hobbes.mraw.org [195.154.31.160])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A3315A01;
        Tue, 24 May 2022 16:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mraw.org;
        s=mail2022; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=gqCLtPa2Zzz2oEdqi3oj2xUKzoRcEUhnAmWGh8qOxXY=; b=yy2Kp0nLeoG5AeQGjfDVrGhQ+y
        pEiZi9XROenv64p5mfS5GascFcVo2s/tCfVLYCgvnF3pRUOs7+BVEFfdAmao18gKYjCtebxa/JS3e
        IcoqNGCZkcYT75K9Hbf2VdouOIHG2PIgPhlMT5zHs8EjoTy7OyektrI5a7jP6WCrP3DNVbd+R7Wpv
        TvQR8FyqLbRYID50wuxE43ROx7cJ4Hp0qLU2hAlEeGLn7CQKk84Nj8fqp22q6nx/Xc/cisb4m/aMB
        CVHVYgm1DCal2/sM4xnmGO+AuAbHiJQUvALG3xktns1r4XdOVvSR1VWjW7gZnXsihKD6LqDPxv6Xg
        5HuC7ieQ==;
Received: from 82-64-171-251.subs.proxad.net ([82.64.171.251] helo=mraw.org)
        by hobbes.mraw.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <kibi@debian.org>)
        id 1nteNj-003nRz-K7; Wed, 25 May 2022 01:56:07 +0200
Date:   Wed, 25 May 2022 01:56:05 +0200
From:   Cyril Brulebois <kibi@debian.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        James Dutton <james.dutton@gmail.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v1] PCI: brcmstb: Fix regression regarding missing PCIe
 linkup
Message-ID: <20220524235605.rz3cyw7akw3327ip@mraw.org>
Organization: Debian
References: <CANCKTBvqp7_MSG3aMpp6pmNoPUnYpH0c+8-r7Pzgebuzb4sZPA@mail.gmail.com>
 <20220523221036.GA130515@bhelgaas>
 <CANCKTBsEjkbdWCB4D22iamPr7YP0qUX=M1dZNNgxkfk1EwjjZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gj63ap2kyrcnvzrr"
Content-Disposition: inline
In-Reply-To: <CANCKTBsEjkbdWCB4D22iamPr7YP0qUX=M1dZNNgxkfk1EwjjZQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--gj63ap2kyrcnvzrr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jim,

Jim Quinlan <jim2101024@gmail.com> (2022-05-24):
> Yes. One repo did not have this node (Cyril/debina?), one did
> (https://github.com/raspberrypi/firmware/tree/master/boot).
> Of course there is nothing wrong with omitting the node; it should
> have pcie linkup regardless.

I work/debug stuff on Debian systems, but Debian's just shipping what's
in mainline. Raspberry people maintain their own vendor DTBs.

> Unless you object, I plan on sending you a v2 of my regression fix
> which will correct the commit message, change the "if (busno =3D=3D 1)"
> conditional to only guard the pcie linkup call, and add further
> comments.
>=20
> I have noted and will also address your other concerns and suggestions
> in a future patchset as I think it is best that I get my hands on a
> CM4 board before I submit any more changes.

For the record, I'm still happy to be cc'ed so that I spend time testing
further patches, be it the short-term regression fix (for inclusion in
master, but also checking it fixes linux-5.17.y and now linux-5.18.y,
if stable maintainers would welcome the extra testing), or the future
patchset.

I can't guarantee you'll have an answer in a few hours like that
happened during the past few days (during which I prioritized testing
over anything else so as not to be a blocker in case it could be
squeezed into v5.18). But I'm still willing to allocate some time to
make sure the CM4 keeps working, even if you don't get your hands on
such systems right away.


Cheers,
--=20
Cyril Brulebois (kibi@debian.org)            <https://debamax.com/>
D-I release manager -- Release team member -- Freelance Consultant

--gj63ap2kyrcnvzrr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEtg6/KYRFPHDXTPR4/5FK8MKzVSAFAmKNcI8ACgkQ/5FK8MKz
VSCfFw/9ExgzEXqJQAACsMXdquRjdNCULhvZUtAQFLvLgusQmQ//RL+XzP5k8z6F
j8WS/0fQMMoA9uIySXgLHFKJ5LXBgt3TG/x8KQqpYwM4Kir6XiG+g1iOnuLaTzRv
xRVe31HhOSHP5XdrQqRgzjZRKBxP/llg/NNzbn4ZwL2M+TTNyMsZg/B5pLyGs+yp
62ip+XyiIZtYMb63K3/rEH0gKNY+6P+XjRMfW55gPbz+hoXafuuJuElrlXaWeGj8
i4DEOQNFH9Mqiy783Fm2+FpEMNC5sWlgg5DO8zzTUILKDMpi+IB9BxCD4M494ycD
CWmJWx88mu4iKu62DIViW8Vb1Oi9PyZm0JauLGqjK/jQ/vljQgSr0sBpHc/vW9Lr
sOy/b6ZhikOaYto/MgNkct2DE1Vlx/SOIsZPg3v7GDDBAw/j5pkEEghJFu8grpQp
hyhI98GTEghoWOOHSZsxZ8xYCsXC4b6KcF4D6FBeyWygZtE+L4PPx/lLUl5z8N/G
u7vvGdlFk/Eko5QOp7rR6qo+daaFhrAhUgDbRFL8Drgpawfze6XnebsgZV6t9mEs
uwFOmPUaovWWRqCa65CEBJd6oqeL5LfSMPrvn6j2gLmwouMEzBAgN3O46WvOOYNn
HxH7rCEK6s+Rxq2XcfUtez2tCNurBGRQCACaNBV8rElb/4nLJZE=
=zXtQ
-----END PGP SIGNATURE-----

--gj63ap2kyrcnvzrr--
