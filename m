Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59CC7A1F02
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2019 17:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbfH2PZS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Aug 2019 11:25:18 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52892 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbfH2PZS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Aug 2019 11:25:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=o5PQfJZQOG8oHG5cpK/3gJqdk0ZYueCvQ61l57g6XrA=; b=xyOUxJK2Zo/3/THWf1I4GGv4J
        1yCJoSjeiB0gFOyijzZLDBgRrZ0X1OuF94JoFEI4DeWBFnXKyBBKIxkfQEMf3UhRnc+dPNJY92LkB
        TiVdJE64mNT+UzkABbmvNFWDfJKl44QWW4H+0I8+l8FMsHJra9BI9X/YnO1O4AwRtshEY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i3MIU-0002M7-DG; Thu, 29 Aug 2019 15:25:14 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 988BD27428D1; Thu, 29 Aug 2019 16:25:12 +0100 (BST)
Date:   Thu, 29 Aug 2019 16:25:12 +0100
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
Message-ID: <20190829152512.GG4118@sirena.co.uk>
References: <20190828163636.12967-1-thierry.reding@gmail.com>
 <20190828163636.12967-5-thierry.reding@gmail.com>
 <20190828212655.GG14582@e119886-lin.cambridge.arm.com>
 <20190828214901.GM4298@sirena.co.uk>
 <20190829100933.GH14582@e119886-lin.cambridge.arm.com>
 <20190829111728.GC4118@sirena.co.uk>
 <20190829114603.GB13187@ulmo>
 <20190829120824.GI14582@e119886-lin.cambridge.arm.com>
 <20190829131603.GF4118@sirena.co.uk>
 <20190829134345.GL14582@e119886-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bO4vSxwwZtUjUWHo"
Content-Disposition: inline
In-Reply-To: <20190829134345.GL14582@e119886-lin.cambridge.arm.com>
X-Cookie: Lensmen eat Jedi for breakfast.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--bO4vSxwwZtUjUWHo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 29, 2019 at 02:43:46PM +0100, Andrew Murray wrote:

> Where they are not specified, because there is really no reason for them to
> be described in the DT - then these drivers should use regulator_get and
> be happy with a dummy regulator. This gives a benefit as if another hardware
> version uses the same driver but does have a regulator that needs software
> control then we can be confident it will work.

The common use case for this is that some boards have flexible power
control which allows them save energy by powering off chips that are not
in use, the driver doesn't super care if it actually gets powered off or
not but it's nice to be able to do so.

> Where regulators are really optional, then regulator_get_optional is used
> and -ENODEV can be used by the caller to perform a different course of action
> if required. (Does this use-case actually exist?)

Yes.  There are two main use cases.  One is for things like MMC where
there's optional supplies that can be used for some more advanced use
cases but their use needs to be negotiated between the host and device,
these typically enable lower power or higher performance modes at the
cost of complexity.  The other is for devices which have the option of
using an internal regulator but can use an external one.  This is
typically used either for performance reasons (the external regulator
might perform better but will increase board cost) or if some systems
need multiple devices to be operating with the same reference voltage.

> I guess I interpreted _optional as 'it's OK if you can't provide a regulator',
> whereas the meaning is really 'get me a regulator that may not exist'.

> Is my understanding correct? If so I guess another course of action would

Yes.

> be to clean-up users of _optional and convert them to regulator_get where
> appropriate?

Yes, I keep doing that intermittently (hence my frustration with more
usages continually popping up in graphics drivers).

--bO4vSxwwZtUjUWHo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1n7lcACgkQJNaLcl1U
h9A35gf8DS7xbyN6h2S9SOYy3eBqyQ5S4wdKhIQDLxtMqcIU4yV1YLi7hcJGgLbT
z0FDwq9Hpt/C3JiG8sRn5eh2ige+VfR1ijaXdnZGhTHoGC/qlF1dg8DG1A4ekRWI
h+ay7fHG8JtMNclqECh1iLAcjUqQ+eKqRKqEWzJcZAWMDJJRyYdrVVno1lNgK95h
ZdlR9GY5jCGwKfUVAPPeNwKe1JCtPUbmylS70VT5L1UOqNpETRrLVDgJTr+EuhrT
a3g4yQ0GYzkR1KBrNr7MqPufvUkukDwqb79jIMQZi0mt5TrcuAfLj9nuYYjMP/uS
LAn050FwAG9od3fUQpVk+wmraD0yJQ==
=PdwP
-----END PGP SIGNATURE-----

--bO4vSxwwZtUjUWHo--
