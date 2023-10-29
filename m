Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A2B7DB0E5
	for <lists+linux-pci@lfdr.de>; Mon, 30 Oct 2023 00:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbjJ2XWV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 29 Oct 2023 19:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbjJ2XWE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 29 Oct 2023 19:22:04 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9BC4EBF7
        for <linux-pci@vger.kernel.org>; Sun, 29 Oct 2023 16:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=date:from:to:cc:subject:message-id
        :references:mime-version:content-type:in-reply-to; s=k1; bh=4LqK
        zsyzMPK0zG6jKlZssYlLz/JHO+MhlunhgtJzoZo=; b=ZaHoVgojOIkrRRSx+KOd
        dVlhRZ6Ob907FHX3inRvUAEQiHcpGd+45mPtvGQyIk1lhpKiyemRLyBypmxVZgOP
        SWmlKxXq1Ki4BKlCRZXUrTYt6FBtHseSamajnqNbiR97wXmcb/Cc/xv0yD3TxAkl
        zd07/zAUl4r5szjNNfGSbpZVQaska9llvX4vbcBvObSdyRZTZisLk3l35Fb0FEE/
        IzFbNMotuxys1TSVKZpg9xwg4xl0pIr3BxbyY3arfjWUFKgwra48lYCY6EUiMH2j
        /Ff69Bhoy9SJn/So0CC79ffsi8mSv90CAZdZvrXrg/4G9P/hp8CSOXczjAc73kbh
        VA==
Received: (qmail 3928351 invoked from network); 30 Oct 2023 00:15:55 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 30 Oct 2023 00:15:55 +0100
X-UD-Smtp-Session: l3s3148p1@YKl3GuMICKVehhre
Date:   Mon, 30 Oct 2023 00:15:54 +0100
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH v5 0/2] PCI: rcar: support regulators for PCIe
Message-ID: <ZT7nqrxadWzhrhU9@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
References: <20230921132624.5664-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VK2a64zn4LDxDZm+"
Content-Disposition: inline
In-Reply-To: <20230921132624.5664-1-wsa+renesas@sang-engineering.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--VK2a64zn4LDxDZm+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 21, 2023 at 03:26:22PM +0200, Wolfram Sang wrote:
> Here are the patches to make PCIe cards work in slot CN15 on a Renesas
> KingFisher board. Please apply.
>=20
> Changes since v4:
> * rebased to 6.6-rc2
> * added ack from Mani (Thanks!)

Did this slip through the cracks maybe?

>=20
> Wolfram Sang (2):
>   dt-bindings: PCI: rcar-pci-host: add optional regulators
>   PCI: rcar-host: add support for optional regulators
>=20
>  .../devicetree/bindings/pci/rcar-pci-host.yaml   | 11 +++++++++++
>  drivers/pci/controller/pcie-rcar-host.c          | 16 +++++++++++++++-
>  2 files changed, 26 insertions(+), 1 deletion(-)
>=20
> --=20
> 2.35.1
>=20

--VK2a64zn4LDxDZm+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmU+56oACgkQFA3kzBSg
KbZksQ//ZTQLV9AZwNEEizqnTqfYg+QukBAMZ/kogfa/L/jSlsS7Gbh0ki0wQBG9
nwLAdJWr17bzAqAtkaOezJ5+4QsE5PtfhDZ2kSdJd2sxKJ5FUc0g2Wrqe1EmOlez
zTEzOvJeXhi3IV8kp4kAA2856rVcxfFIAD3+42vfZLHP5xsTL4L/rDMshRL4Pwf/
69Q0LjTkQyhNHocQGduT/j6K7XCq9uLVfEcNu7ViCbzLbxzjoIy74b33nCK7KCCi
/Ci2R6Tr7U5Mui4Z4AyHvUgqKiVe+BTzCjWmDUznQRC5KmE5302dI7Oq/PRt3ret
F+SnXI+TrO/AwSlg1eC7V03gVGOqibVQfAATLhxPc+E3bKvrFd1jrzDSZHiT8dic
ZsR+jpf86vW/1G58PB7ZRIpePPhoskJ9o8u7JP29HuVd1xUG3TH8TokrSStn3Pdb
I5x87wcYaIWNXoludxC/CLMZoQ8k2KqGfg9SXav2YO4eeWuYZf6ozhpsHP84qQzE
CUIewC5etAevv1Y2cQ/ETuql08sOsfQVsDenJ0Uz67dXhs+xBC0fCjLI0Jctra8Y
tHq5JJs35qM2sZSrsKFS+4gaw6zFECNpf5CGeonMu2Qj6F+0MsL4eUpwyOofUAk5
/Nf6JQdEs2drjfJQGe+REja9S5AelI5F4jrRHaRosy4DtJ3o2nE=
=6C7y
-----END PGP SIGNATURE-----

--VK2a64zn4LDxDZm+--
