Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51AB94CCAC
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2019 13:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbfFTLOa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jun 2019 07:14:30 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35203 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfFTLO3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jun 2019 07:14:29 -0400
Received: by mail-wm1-f66.google.com with SMTP id c6so2767264wml.0;
        Thu, 20 Jun 2019 04:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Xc1nWAHhQ2GG/t3+rU+FbM/8TKa2OA/1DXvWS/SQYRY=;
        b=kErXHNtMhxoZPvJr6kF4uJ0EMqs1oYD5lIIT3y8wDhoOCvB/hFUVyZv38owWC+A/Bu
         az/20Oi3gNSpVx6LiMAjayqMhXiIsi3qG9H6CDz6KVlGI3kzwOjLyEYB640m15NTHt2E
         QT/Uhb8yyqEQ9z+H9qLaO6FpBkb9FDhXLwmqXBCrlwj/ff+PLWLOM08HGYTChw7Am93F
         iiDNY/KjxArzw6JWQOyx18Cs7PgHKdSvclMzakISEAIzBw51xFwvDOwNz07YRJHp+ugN
         o7a0dQgMWSb+sl1n6nKQVN1d9yFnfg7+71o/ATxnLgttORWWcttfnIScnoCygkybOx4T
         Iuww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xc1nWAHhQ2GG/t3+rU+FbM/8TKa2OA/1DXvWS/SQYRY=;
        b=S8hhxxkr1AsYEo5na347L76ulYaAcB9Ij7S+bXDUZ6tj8gxy8gYnYVncwK0yCyO9gg
         wnx33qtUSONbzxQmI6LDc4YSpFyngzyzo/hgG912mVqOytXsKiDrCDuZe85E3SZNhwSx
         shFbjQxAdfGg2tIijeMaoi16ZOG/lE9Eyo12J5qBWW1kubznD31TQr+CGGGVJZacs7PH
         xJJsoIDGdYVhNTrAcdFIzpe81ZtNEzXif0ILACNWbWM3qSZohWNWHwuqjcHZvDtVVFMH
         0e7Ar5cVjEcRZ96110FuhieIEXC6aOc4wo9Jkzn++YxaYp+JjnRLxEXIOCFu9Yqq4vWi
         qBJw==
X-Gm-Message-State: APjAAAVfEiGRouNDvQvcFO00TZjWhXCgC4FxI5zwDtFQFJpAjnRmPoFY
        Q2zfEpjTbOHZe6XSXr7cFxY=
X-Google-Smtp-Source: APXvYqz6Qi+Lnau5mw0sOkJBhgxoMZ9IN5Gd9xbua3JIQsMDUR0v3H0TnzE/MdpetN7YQsIGjgW1lw==
X-Received: by 2002:a7b:c356:: with SMTP id l22mr2484455wmj.97.1561029266894;
        Thu, 20 Jun 2019 04:14:26 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id o20sm27793599wro.65.2019.06.20.04.14.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 04:14:26 -0700 (PDT)
Date:   Thu, 20 Jun 2019 13:14:25 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        robh+dt@kernel.org, mark.rutland@arm.com, jonathanh@nvidia.com,
        vidyas@nvidia.com, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH V6 00/27] Enable Tegra PCIe root port features
Message-ID: <20190620111425.GA1000@ulmo>
References: <20190618180206.4908-1-mmaddireddy@nvidia.com>
 <20190620102552.GB28703@ulmo>
 <20190620105301.GA23729@e121166-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
In-Reply-To: <20190620105301.GA23729@e121166-lin.cambridge.arm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2019 at 11:53:01AM +0100, Lorenzo Pieralisi wrote:
> On Thu, Jun 20, 2019 at 12:25:52PM +0200, Thierry Reding wrote:
> > On Tue, Jun 18, 2019 at 11:31:39PM +0530, Manikanta Maddireddy wrote:
> > > This series of patches adds,
> > > - Tegra root port features like Gen2, AER, etc
> > > - Power and perf optimizations
> > > - Fixes like "power up sequence", "dev_err prints", etc
> > >=20
> > > This series of patches are tested on Tegra186 based Jetson-TX2, Tegra=
210
> > > based Jetson-TX1, T124 based Jetson-TK1, Tegra20 and Tegra30 platform=
s.
> > >=20
> > > Changes from V5 to V6:
> > >   - Patch [V4, 20/27]: Replaced pcie_pme_disable_msi() with no_msi qu=
irk
> > >=20
> > > Changes from V4 to V5:
> > >  - Patch [V4, 4/28]: Added blank line before block style comment
> > >  - Patch [V4, 22/28]: "Access endpoint config only if PCIe link is up"
> > > patch is dropped
> > >  - Patch [V4, 27/28]:
> > > * Updated reset gpio toggle logic to reflect active low usage
> > > * Replaced kasprintf() with devm_kasprintf()
> > > * Updated commit message with more information.
> > >=20
> > > Changes from V3 to V4:
> > >  - Patch [V3,27/29] is dropped
> > >  - Patch [V3,28/29]: devm_gpiod_get_from_of_node() is directly used in
> > >    pci-tegra driver instead of of_get_pci* wrapper function defined in
> > >    Patch [V3,27/29].
> > >=20
> > > Manikanta Maddireddy (27):
> > >   soc/tegra: pmc: Export tegra_powergate_power_on()
> > >   PCI: tegra: Handle failure cases in tegra_pcie_power_on()
> > >   PCI: tegra: Rearrange Tegra PCIe driver functions
> > >   PCI: tegra: Mask AFI_INTR in runtime suspend
> > >   PCI: tegra: Fix PCIe host power up sequence
> > >   PCI: tegra: Add PCIe Gen2 link speed support
> > >   PCI: tegra: Advertise PCIe Advanced Error Reporting (AER) capability
> > >   PCI: tegra: Program UPHY electrical settings for Tegra210
> > >   PCI: tegra: Enable opportunistic UpdateFC and ACK
> > >   PCI: tegra: Disable AFI dynamic clock gating
> > >   PCI: tegra: Process pending DLL transactions before entering L1 or =
L2
> > >   PCI: tegra: Enable PCIe xclk clock clamping
> > >   PCI: tegra: Increase the deskew retry time
> > >   PCI: tegra: Add SW fixup for RAW violations
> > >   PCI: tegra: Update flow control timer frequency in Tegra210
> > >   PCI: tegra: Set target speed as Gen1 before starting LTSSM
> > >   PCI: tegra: Fix PLLE power down issue due to CLKREQ# signal
> > >   PCI: tegra: Program AFI_CACHE* registers only for Tegra20
> > >   PCI: tegra: Change PRSNT_SENSE IRQ log to debug
> > >   PCI: tegra: Disable MSI for Tegra PCIe root port
> > >   PCI: tegra: Add AFI_PEX2_CTRL reg offset as part of soc struct
> > >   dt-bindings: pci: tegra: Document PCIe DPD pinctrl optional prop
> > >   arm64: tegra: Add PEX DPD states as pinctrl properties
> > >   PCI: tegra: Put PEX CLK & BIAS pads in DPD mode
> > >   PCI: Add DT binding for "reset-gpios" property
> > >   PCI: tegra: Add support for GPIO based PERST#
> > >   PCI: tegra: Change link retry log level to debug
> >=20
> > Hi Lorenzo, Bjorn,
> >=20
> > There's a build-time dependency from the PCI patches on patch 1 of this
> > series. I've already Acked that, so I think you should take it through
> > the PCI tree along with the rest of the series.
> >=20
> > The only patch that I picked up is the DT change in patch 23, which is
> > decoupled from the others via DT, though the data that it adds to DT
> > will be used in patch 24.
> >=20
> > Does that sound good to you?
>=20
> Yes, I will drop patch 20 too as requested. Is there a merge ordering
> dependency between patch 23 and 24 ? If yes we should let Bjorn know
> or you drop patch 23 and I will merge it via PCI, let us know.

Nope, I don't think there are any issues with ordering. Patch 23
basically just adds the DT content that will be used by patch 24 to
dynamically change the pinmux options. Without patch 24, the default
state will be applied, which is what the state will be on boot anyway.
Patch 24 without patch 23 would mean that the PCI driver will try to
select a pinctrl state which does not exist, but this is already handled
gracefully in pinctrl_pm_select_state().

Thierry

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl0LaooACgkQ3SOs138+
s6HJPhAAjLhryaflH8uX3P6GIMNMIXi/tejz0MLtvqPqHRQU/DEIJaVg1KpUKgGB
sS35X3nSVxmaVX+dcLwirdCQkHUlNefx00vtkUxgWYxrW9bokm6GLoAFt5p4k3iz
CKdyz+WfSbek22kCJPidmHBcjQtMfS+GFSxvA9TTH0+dtw02cXkNSy1ySDBVNBH4
rqhWsqFssy/QGCarz47nc0RjUJW0RrHJXYtRk1mDWpQzt3zBkEjiv3gDrTO6gPzV
PFxIYGY8lxQl//PkZ2JtHI6Y2e+u0hf8HbC+4XKNp+jM4ZusEvKYSj6KMPphpxD0
Mx5XXZT8bBjxsGrthPeRQSX9vpFMV0P6Q7S7D+reoWD1OVbz5UQv1Yg9PID71bgv
XTPOkoklqud06pTzzKbzToXHQEUDaRdnEiwdyeQ3N21uh5027YJyo8rwcewJ3aMC
ht10cqe30IS1PDiepOasOrx4AxxGjdSWVwqVa82sE62aNSfydcVbfw5sptiqNv/x
utM1MMRT+fC2/XIZcfpbfcG8d02rCldCi+s4ToQ5lhz7n/vNdDZNgEwz70wwbqEy
WQUBIsLRKTmAuRyuhiCAgaDGwWGbsx9r7D9wGBKQFBJlL14OdI/7tqjEsWP0Eb+i
CCtvGG0B5Ii3IZZwmlUDKWDQgxntahFJYMgn2XkGWtpSWNkl0QM=
=1uKr
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
