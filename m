Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C77BCA1B30
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2019 15:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfH2NQJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Aug 2019 09:16:09 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33700 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbfH2NQJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Aug 2019 09:16:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rawSJ8WqZOt1xFgdUKL7EwNF3dfOghqBWQeAlFhn4qs=; b=UiouIcMIoiNSG27CN0vwVzxlZ
        K9ALIpRRxy5rM04Wuj5KBYkzB70+oeses4hQ9YeuGHSFysPJFG2t1r3WvOjvwfmdEVlvSO+VcFzap
        UtcoEqTQQIemW/2mJbD/5q8Ad9BGZIA7XPrzZQRD5ORBN7FhRwQvCXH9kTbyn6XMgSn4Q=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i3KHV-00027U-AE; Thu, 29 Aug 2019 13:16:05 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id A679627428D1; Thu, 29 Aug 2019 14:16:03 +0100 (BST)
Date:   Thu, 29 Aug 2019 14:16:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH 5/5] PCI: iproc: Properly handle optional PHYs
Message-ID: <20190829131603.GF4118@sirena.co.uk>
References: <20190828163636.12967-1-thierry.reding@gmail.com>
 <20190828163636.12967-5-thierry.reding@gmail.com>
 <20190828212655.GG14582@e119886-lin.cambridge.arm.com>
 <20190828214901.GM4298@sirena.co.uk>
 <20190829100933.GH14582@e119886-lin.cambridge.arm.com>
 <20190829111728.GC4118@sirena.co.uk>
 <20190829114603.GB13187@ulmo>
 <20190829120824.GI14582@e119886-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7mxbaLlpDEyR1+x6"
Content-Disposition: inline
In-Reply-To: <20190829120824.GI14582@e119886-lin.cambridge.arm.com>
X-Cookie: Lensmen eat Jedi for breakfast.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--7mxbaLlpDEyR1+x6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2019 at 01:08:35PM +0100, Andrew Murray wrote:
> On Thu, Aug 29, 2019 at 01:46:03PM +0200, Thierry Reding wrote:

> > If regulator_get_optional() returned NULL for absent optional supplies,
> > this could be unified across all drivers. And it would allow treating
> > NULL regulators special, if that's something you'd be willing to do.

> > In either case, the number of abuses shows that people clearly don't
> > understand how to use this. So there are two options: a) fix abuse every
> > time we come across it or b) try to change the API to make it more
> > difficult to abuse.

> Sure. I think we end up with something like:

> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> index e0c0cf462004..67e2a6d7abf6 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c
> @@ -1868,6 +1868,9 @@ struct regulator *_regulator_get(struct device *dev=
, const char *id,
>                 }
> =20
>                 switch (get_type) {
> +               case OPTIONAL_GET:
> +                       return NULL;
> +

Implementing returning NULL is not hard.  How returning NULL discourages
people from using regulator_get_optional() when they shouldn't be using
it in the first place is not clear to me.

--7mxbaLlpDEyR1+x6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1n0BIACgkQJNaLcl1U
h9AUIAf/TKLyre/pWneYFciECece7Uf8p0TYji/CmbnSMXN7BfafwbPZmACSoGly
ZfFaBhmbEkHLtOz7S5GYRQxnDTWQYdjsh4t8NMcaHS8HJiW7lDqzPi+NYVIbJgJH
AY6hE03NQsUzoKyeztbepZbAyG5doZx4r8ScH5hsM8kgR4Mmgdflp/zFjscRwXJc
MtZUrCcr0erz5PMzQSx2Z7D3WGrMnPEDiGo62k8gvIfX60cUDfA/5vG2haLazAw3
cgFmgPP2GZyJsPzbGkn1fVduaTJ2mIOuIpIwFREeqpbfHQJffL3M52PcXH04G4A5
b9K/LDnOavf3XSHPlglM+kkRr1bAMg==
=GRPP
-----END PGP SIGNATURE-----

--7mxbaLlpDEyR1+x6--
