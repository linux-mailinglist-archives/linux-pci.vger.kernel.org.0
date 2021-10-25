Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B70A34394B8
	for <lists+linux-pci@lfdr.de>; Mon, 25 Oct 2021 13:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbhJYL0N (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Oct 2021 07:26:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:57490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232400AbhJYL0M (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Oct 2021 07:26:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 337096044F;
        Mon, 25 Oct 2021 11:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635161030;
        bh=+p7rkc0Hnr1XlWm38ovQIiGOePLW/z/cRiuHpI+hXbM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=os6AxgM0IbkYIq01HavJrnq/lAQAjOur9Lv3r9w8MYwN67ieLVpN9FjfKxrJjgoOU
         1i5PUoponyhOsd4mSI1ky+r1ZNmzYQN6d4pOA8p2UAL85Wrz8qDeJSiizpt/Be0Fqe
         tTlkxzLRztwSkvBvbYWLVvoIOrlheCW5GwppgH4vNvQoyToqAv4oR7uzbUmDBCY79l
         aPCs/45BOV68Y8bXKVtl8iRLS3TETOghtFnsBMjSOKohqNx3WU+RN6ioNOAB5G5wrQ
         Ya+ZNkhnE5AbnQv5m6HYvNwNVuQ1/r1uLgofdOegw4p5Koq9j3vQ/tF+wiYZPn+Kqh
         YtfOXMQj1FEOQ==
Date:   Mon, 25 Oct 2021 12:23:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Francesco Dolcini <francesco.dolcini@toradex.com>
Cc:     Richard Zhu <hongxing.zhu@nxp.com>, l.stach@pengutronix.de,
        bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        jingoohan1@gmail.com, linux-pci@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH v3 3/7] PCI: imx6: Fix the regulator dump when link never
 came up
Message-ID: <YXaTxDJjhpcj5XBV@sirena.org.uk>
References: <1634886750-13861-1-git-send-email-hongxing.zhu@nxp.com>
 <1634886750-13861-4-git-send-email-hongxing.zhu@nxp.com>
 <20211025111312.GA31419@francesco-nb.int.toradex.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CF3LIB8sPBws0Sny"
Content-Disposition: inline
In-Reply-To: <20211025111312.GA31419@francesco-nb.int.toradex.com>
X-Cookie: From concentrate.
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--CF3LIB8sPBws0Sny
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 25, 2021 at 01:13:12PM +0200, Francesco Dolcini wrote:

> Hello Richard,
> please see this comment from Mark,  https://lore.kernel.org/all/YXaGve1ZJq0DGZ9l@sirena.org.uk/.

> > +		if (imx6_pcie->vpcie
> > +		    && regulator_is_enabled(imx6_pcie->vpcie) > 0)
> > +			regulator_disable(imx6_pcie->vpcie);
> >  		return ret;

I should probably also say that the check for the regulator looks buggy
as well, regulators should only be optional if they can be physically
absent which does not seem likely for PCI devices.  If the driver is not
doing something to reconfigure the hardware to account for a missing
supply this is generally a big warning sign.

I really don't understand why regulator support is so frequently
problematic for PCI controllers.  :(

--CF3LIB8sPBws0Sny
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmF2k8MACgkQJNaLcl1U
h9DE0Qf+JIeGIKboM2eraQaTERFYEtpEhAYiAfvGMwJeGuGFajDRoTyusV2T2/nt
cShDRqgDs31/79zCMl82FADAnvoSK/U7W0+1u3OwvDyUxlZnVur56srCviCHnhqT
7iUvZGT6eeyfkFga56fRe6NIBSEYfDI2/fn2lE1tbAfGbGV0uN809p6DG98g9djP
1lBrQLeGAFdxTchlin5LTKqM5NiFRW2NP+K5XgE9bgj3gUtBMXwhBtAOOJ/TBIoz
eaab9w7nqL38aHx6C+D/Ph0e/WAnIO/1lvY07ntz43PWfk94OS7hixsUS+M7FHPI
hfZMtefyYkk35GlgEpKagbtnP1v91Q==
=p3vs
-----END PGP SIGNATURE-----

--CF3LIB8sPBws0Sny--
