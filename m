Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B43646AA4
	for <lists+linux-pci@lfdr.de>; Thu,  8 Dec 2022 09:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiLHIhC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Dec 2022 03:37:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiLHIg6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Dec 2022 03:36:58 -0500
X-Greylist: delayed 1200 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 08 Dec 2022 00:36:56 PST
Received: from 1.mo582.mail-out.ovh.net (1.mo582.mail-out.ovh.net [46.105.56.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A086152D
        for <linux-pci@vger.kernel.org>; Thu,  8 Dec 2022 00:36:56 -0800 (PST)
Received: from player697.ha.ovh.net (unknown [10.110.208.144])
        by mo582.mail-out.ovh.net (Postfix) with ESMTP id 96F9024818
        for <linux-pci@vger.kernel.org>; Thu,  8 Dec 2022 08:00:34 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player697.ha.ovh.net (Postfix) with ESMTPSA id 7D1F931921173;
        Thu,  8 Dec 2022 08:00:28 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-110S004ff2807f7-48d3-4120-947a-b1207af02d21,
                    19B3A878FA17504FBB3C403E8DC678432673C166) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
Date:   Thu, 8 Dec 2022 09:00:17 +0100
From:   Stephen Kitt <steve@sk2.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, Jan Rueth <rueth@comsys.rwth-aachen.de>
Subject: Re: [PATCH] PCI/ASPM: Call pcie_aspm_sanity_check() as late as
 possible
Message-ID: <20221208090017.132db7bd@heffalump.sk2.org>
In-Reply-To: <20221207215608.GA1471870@bhelgaas>
References: <20221006115950.821736-1-steve@sk2.org>
        <20221207215608.GA1471870@bhelgaas>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/54uwlIozM3+gCERQun4.JqT";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Ovh-Tracer-Id: 11070410835136448134
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrudelgdduudejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfofggtgesghdtreerredtjeenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecuggftrfgrthhtvghrnhepvdeftdfhtddvueegfeehteehfeegteegieeljefgkeduffduudefuefgfeejgfffnecuffhomhgrihhnpehsthgrtghkvgigtghhrghnghgvrdgtohhmpdhkvghrnhgvlhdrohhrghenucfkphepuddvjedrtddrtddruddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeoshhtvghvvgesshhkvddrohhrgheqpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheekvddpmhhouggvpehsmhhtphhouhht
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--Sig_/54uwlIozM3+gCERQun4.JqT
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Bjorn,

On Wed, 7 Dec 2022 15:56:08 -0600, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Thu, Oct 06, 2022 at 01:59:50PM +0200, Stephen Kitt wrote:
> > In pcie_aspm_init_link_state(), a number of checks are made to
> > determine whether the function should proceed, before the result of
> > the call to pcie_aspm_sanity_check() is actually used. The latter
> > function doesn't change any state, it only reports a result, so
> > calling it later doesn't make any difference to the state of the
> > devices or the information we have about them. But having the call
> > early reportedly can cause null-pointer dereferences; see
> > https://unix.stackexchange.com/q/322337 for one example with
> > pcie_aspm=3Doff (this was reported in 2016, but the relevant code hasn't
> > changed since then). =20
>=20
> Thanks, Stephen!
>=20
> That stackexchange report doesn't have much information, but it looks
> similar to this old report from Jan Rueth, which I'm sorry to say I
> never got resolved:
>=20
>   https://bugzilla.kernel.org/show_bug.cgi?id=3D187731
>   https://lore.kernel.org/all/4cec62c2-218a-672b-8c12-d44e8df56aae@comsys=
.rwth-aachen.de/#t
>=20
> And Jan's patch is almost identical to yours :)
>=20
> I hope to get this resolved, but I don't have time to work on it
> before the upcoming merge window, which will probably open Sunday.
> And then it's holiday time, so it may be January before I get back to
> it.  I'm just dropping the links here as breadcrumbs for picking this
> back up.

Thanks for the update! I was somewhat bemused by the dereference here, I=E2=
=80=99m
reassured to see I=E2=80=99m not the only one. Unfortunately I don=E2=80=99=
t have hardware
which exhibits this problem, I submitted the patch because it seemed
reasonably sensible even though as you say there is probably something else
going on here. Of course if this approach is useful, Jan=E2=80=99s patch sh=
ould go in
rather than mine.

Anyway, it=E2=80=99s been six years, so a few more weeks won=E2=80=99t make=
 any difference
;-).

Enjoy the holiday season!

Regards,

Stephen

--Sig_/54uwlIozM3+gCERQun4.JqT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEnPVX/hPLkMoq7x0ggNMC9Yhtg5wFAmORmZEACgkQgNMC9Yht
g5wMVBAAkKmuNdMy+6QQttrjVSs3BPg1OPk8e+W9dohUTKGrp7PQZ0wNF+h0SVfA
X3gwuCmtufAiifeJYQqzP513wPS267IAcs0RYOboARy6aDeRT0QD+ZyZ04AIVqKG
V0chguSgQ7u/OzYZ7G6K/JO1yx6H/qUN51afAEktmIzx+D6tVJYClhYNFi6JzkHF
sslKMC1fzGrGDSpSqK5QgYjKoQMlSJEzp1SCv+5sposy+KCLmeMn+B27omy14k72
qNbU5l2TmddGycvgoBhBuimiLj0XiHzGkhvgDdyi/03egwnov4l4c7Ug3egmOwYh
NQzW6xQ0eIMT1ji+L2GBPJ4m357BWB+uojo+S/iqo77NwP9B5r1PNL3nkBulXPZw
5Lez9VwWky1rfULDfq3sTasV5iOULaPqhOoTdqvFjDoc3aVM3vrRkZbxrVKRLrkq
shhMkB3of/3SkT7UTBaJ5iMaDgAxd4+7dFnymyeRe53wbZWSIA7/C2FYfQmfhWuO
C7vuGxefRsbcJcS9eHv3rkjgbIv8QdEKZTnxfOVt76je3YvF5X0IU9hsKba5WjEU
HFZJ35AqL0h2nWEf0tOnemy1N0XYAnNhjo/nXYu1qNnowVl6lGxEDuGF/Y4SBO7D
lT6yf1/eVQVMfqXJD6c8LP1/nlg0OiCbHZ60SMEQhCnjH6FhKCE=
=6ZRr
-----END PGP SIGNATURE-----

--Sig_/54uwlIozM3+gCERQun4.JqT--
