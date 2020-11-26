Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5C02C5300
	for <lists+linux-pci@lfdr.de>; Thu, 26 Nov 2020 12:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731040AbgKZLbe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Nov 2020 06:31:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729472AbgKZLbd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Nov 2020 06:31:33 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA22C0613D4;
        Thu, 26 Nov 2020 03:31:33 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id a3so2046580wmb.5;
        Thu, 26 Nov 2020 03:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vitVgv2STuOYlxqbEl11/l+sgXUzy5dAUOEvNT+FW/0=;
        b=nwU1Eow9z1N/TNfexJop1MXHGRgUw3s/de1DYiGvvq7I670mwDmLzs/1KDYHrM5kXM
         5YJkH8vTfhv6L+PY1XYgqP8NPHZ+eQBCxRpn6gzhrIDByObFblI4VDuoNcjGJYeIJuVB
         iAsoIpGhfS3mqy7lDKQ6YPavfTQbUTil0vMVhSYCQPjxxFJZRRNoqEQvOOq6z6yozeHu
         HVPsKfHb6M0MfVEzVb04My59stINld5cU2313AkBNGdWYzC7+y8tRyeRL9jcSkDJvX7q
         ed4p6zzUQtmNWxO4iAGglvTy6Y7KqoEIJ5u4Wiqo1n1oNSkTCZgrmpWHpbW5VJq/j/or
         1Gfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vitVgv2STuOYlxqbEl11/l+sgXUzy5dAUOEvNT+FW/0=;
        b=DuaJPFvTo4McJnlBRM27s0dJmtkqGGkq5WU9/N0OSQj1RgyTR1EQFdVZqABqzPzcS3
         zJyrZLQRDzq+LolyyDKhMGD1TlwP/EqscWObNIrNx4yIBNQ21wLwCuqaI3gYAkWAm0Cb
         JM58mJJpsXsyWGNPK9R5a4mmdmmQjrRLlqvKDNZk+Ukl9mvG+oL/L2qvK3DE7VgLAD1F
         yq1snZOJguSsloMul11g7jzTZcw2kaLCy5YGm4imrdQYvNUm2PCEkbxQA9zh7RBCDUMg
         4yPLV6cAutoZjzgsyu8Eznl1986ssBlkvf9nUlKPwylc30pITlkFQG45gLkP+Wug9v6i
         Jutg==
X-Gm-Message-State: AOAM531v7Gelmd300IM+uaL1QLLwFC498I/FeuNS2+XJHDpMj+0LHiPS
        swQr3IWKvMlMxxs4iPnQaQw=
X-Google-Smtp-Source: ABdhPJyDX5AJRi4EVTu8NxF/kpdcG7XfJaDjD2bZqJVzUmL1PJbQBsHzqSodRqdHl3szZW//7vzhjw==
X-Received: by 2002:a7b:c409:: with SMTP id k9mr2847798wmi.157.1606390292033;
        Thu, 26 Nov 2020 03:31:32 -0800 (PST)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id w186sm8316316wmb.26.2020.11.26.03.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 03:31:30 -0800 (PST)
Date:   Thu, 26 Nov 2020 12:31:29 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "amanharitsh123@gmail.com" <amanharitsh123@gmail.com>,
        "dinghao.liu@zju.edu.cn" <dinghao.liu@zju.edu.cn>,
        "kw@linux.com" <kw@linux.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Krishna Thota <kthota@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        "sagar.tv@gmail.com" <sagar.tv@gmail.com>
Subject: Re: [PATCH V4 0/6] Enhancements to Tegra194 PCIe driver
Message-ID: <X7+SEXxnfVoqmRxM@ulmo>
References: <20201109171937.28326-1-vidyas@nvidia.com>
 <20201125175709.GA1274379@ulmo>
 <9291ac83-0f14-88df-8c1d-81f57b0340ee@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3jjmqs5g1xMO8Dtt"
Content-Disposition: inline
In-Reply-To: <9291ac83-0f14-88df-8c1d-81f57b0340ee@nvidia.com>
User-Agent: Mutt/2.0.2 (d9268908) (2020-11-20)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--3jjmqs5g1xMO8Dtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 26, 2020 at 01:21:44AM +0530, Vidya Sagar wrote:
>=20
>=20
> > -----Original Message-----
> > From: Thierry Reding <thierry.reding@gmail.com>
> > Sent: Wednesday, November 25, 2020 11:27 PM
> > To: Vidya Sagar <vidyas@nvidia.com>
> > Cc: lorenzo.pieralisi@arm.com; robh+dt@kernel.org; bhelgaas@google.com;
> > Jonathan Hunter <jonathanh@nvidia.com>; amanharitsh123@gmail.com;
> > dinghao.liu@zju.edu.cn; kw@linux.com; linux-pci@vger.kernel.org; linux-
> > tegra@vger.kernel.org; linux-kernel@vger.kernel.org; Krishna Thota
> > <kthota@nvidia.com>; Manikanta Maddireddy <mmaddireddy@nvidia.com>;
> > sagar.tv@gmail.com
> > Subject: Re: [PATCH V4 0/6] Enhancements to Tegra194 PCIe driver
> >=20
> > On Mon, Nov 09, 2020 at 10:49:31PM +0530, Vidya Sagar wrote:
> > > This series of patches do some enhancements and some bug fixes to the
> > > Tegra194 PCIe platform driver like
> > > - Fix Vendor-ID corruption
> > > - Map DBI space correctly
> > > - Update DWC IP version
> > > - Continue with uninitialization sequence even if parts fail
> > > - Check return value of tegra_pcie_init_controller()
> > >
> > > V4:
> > > * Added a new patch to address link-up issues with some of the cards
> > >
> > > V3:
> > > * Addressed Bjorn's review comments
> > > * Split earlier patch-4 into two
> > >   - Continue with the uninitialization sequence even if some parts fa=
il
> > >   - Check return value of tegra_pcie_init_controller() and exit
> > > accordingly
> > >
> > > V2:
> > > * Addressed Rob's comments. Changed 'Strongly Ordered' to 'nGnRnE'
> > >
> > > Vidya Sagar (6):
> > >   PCI: tegra: Fix ASPM-L1SS advertisement disable code
> > >   PCI: tegra: Map configuration space as nGnRnE
> > >   PCI: tegra: Set DesignWare IP version
> > >   PCI: tegra: Continue unconfig sequence even if parts fail
> > >   PCI: tegra: Check return value of tegra_pcie_init_controller()
> > >   PCI: tegra: Disable LTSSM during L2 entry
> > >
> > >  drivers/pci/controller/dwc/pcie-tegra194.c | 78
> > > +++++++++++-----------
> > >  1 file changed, 39 insertions(+), 39 deletions(-)
> >=20
> > I was going to test this series, but then I noticed that PCI is causing=
 a crash on
> > linux-next (as of fairly recently).
> I root caused the crash issue to the following commit
> a0fd361db8e5 ("PCI: dwc: Move "dbi", "dbi2", and "addr_space" resource se=
tup
> into common code")
>=20
> I also pushed the following two patches to fix this issue for review
>=20
> http://patchwork.ozlabs.org/project/linux-pci/patch/20201125192234.2270-1=
-vidyas@nvidia.com/
> http://patchwork.ozlabs.org/project/linux-pci/patch/20201125192554.5401-1=
-vidyas@nvidia.com/

Great, those fix Tegra194 PCIe on next-20201126 for me!

> > So I tried applying this on top of v5.10-rc1, but
> > that gives me the following:
> >=20
> > 	[    3.595161] ahci 0001:01:00.0: version 3.0
> > 	[    3.595726] ahci 0001:01:00.0: SSS flag set, parallel bus scan disa=
bled
> > 	[    4.609923] ahci 0001:01:00.0: controller reset failed (0xffffffff)
> > 	[    4.610343] ahci: probe of 0001:01:00.0 failed with error -5
> >=20
> > So the device enumerates fine, but it's not able to reset the SATA cont=
roller.
> > That said, this seems to happen regardless of this patch series, so pla=
in v5.10-rc1
> > also shows the above.
> This was also a known issue and we need the following commit to make thin=
gs
> work (FWIW, it is already accepted)
> 9fff3256f93d PCI: dwc: Restore ATU memory resource setup to use last entry
>=20
> Otherwise, v5.10-rc3 can be used which has working state of PCIe on
> Tegra194.

Okay, I see that now. Thanks for following up on those.

Thierry

--3jjmqs5g1xMO8Dtt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl+/khEACgkQ3SOs138+
s6FHLRAAv6S0ylHnM7wt8zuwQeodXGTP1ShqTB61Fthp8CpEXrxJujUthzkNXdPY
z1qIl9Wmbsf/0RV1nZaepkmubdT2XDMFnZZu9OShATDLSBxVib9IxG5rNsmCoRA6
C7WZ34CdBzXt4DqQZpdtKsDAMdjsTyvIDLhB2dtC4t1gHlfDojY+oTbphLkrQ/cV
YjoNwQEQwMX/4kAQ3tNgkAa7IT3f0s5tVj8mzi6JF/ffcmX5v1lRs1jB9CtnwHUJ
3IBVR8Q7ZZVT3lcFcpiDntMk/WVUjwGmqEl9E8GQDppbdrvLDmRH8qxNZAq8h0fn
bS/sZsDIrQNpGHzCZDzs+54coFpRqfYDjdTaJjRB/gId0rz9U58RQ+qCEgqckwxq
1a1cFyb46pPKbrUb07csEHAw8zfci+eC1zhfzIJyu0MV7RkiXLpW15r3chAYM92P
qwIP2roySBnQJe3EG5COpzmKf4fx4CFNOk7r51gtTMiRBz5nIZzcuODPZrBKT3oy
GXRNucDQsnQ9XG+bRQu50ga1FLD9Dh+bL1NetgAsMfGMgXUrbX4VfrwXCw0hvQs6
9MVEIbImy1Ewq58oN49mjFkVyumoZ5v2pWk5NrCXfSRUABSEnzLfXWLUlE3Rqf79
6PFp14OrLV25oPyz9aq6wLxo7ULfGZY7W8UkNej2VmzxRkQB9F0=
=yKVJ
-----END PGP SIGNATURE-----

--3jjmqs5g1xMO8Dtt--
