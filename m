Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA06222338
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jul 2020 14:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbgGPM7t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Jul 2020 08:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728257AbgGPM7t (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Jul 2020 08:59:49 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA252C061755;
        Thu, 16 Jul 2020 05:59:48 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id d18so4687363edv.6;
        Thu, 16 Jul 2020 05:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pQOZGxTaJl4Wu4T0GxXQ1XQ4sweLDjO8O7bR9W9rXI0=;
        b=BzXkF2Pw2Ez64e9nUXzyvcQB85t0xYz1OsnzJ4iz4EZGtdgWLMqRj3PirK+XwbUUoA
         +vCXjHV+TfG1TXi4civEpOKv6gvPEJeB3Ib2og0CtA+0U5PSLdGV/RIR5ka1XA2kOzYk
         JiwHeO8+YlRv3aQJ2TBhpOoYhXaeOC3ysC4exkLIcY55ddFQbdR2GQlVNbShrrYOCxDF
         qDME8ajZG8baCSTFsxXS2/439qsHzHuXdEoWR9QDcDOIdxMfpPlL6Fg4l1G2+KC0361X
         DRVNxdIe/cPA4yUi8HfCGR89DT4XMihjmfOsbRDN9yb1bWbbFXNP52es8EZGeoKUCbLE
         J48g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pQOZGxTaJl4Wu4T0GxXQ1XQ4sweLDjO8O7bR9W9rXI0=;
        b=og1VzPV5RnU8ZaqHPfDUhmfOWk6x6m2Xd+GKyHygEIRzvcBZfnBlx8cQ29IgnW5k/Y
         yxNq9ABF3Mp0OloPzXOBFKIffoWqYOQumvBFjB/QeM79OWfcJd7C4elBDcbih3/mZnGf
         sMBrr+XxFa7Pl8peDDyYxNIoNHRZkWkMPYi5979MHu8UqGtiwu5nBQKjHht1wBQzKMYs
         ErM+wJVVMBLDZ9B310w4hup75oLUdBdZYNxx54RP3k6YZRJ5pbzOs+0XAnKCnMFiF/LB
         nmjxHBViDqfHW8zCr5uaOFEB+m88uNOhHF0+ETschmQov9kXh4j82yO3twJ0dlFtNoG6
         tsPw==
X-Gm-Message-State: AOAM532VVblkb3wLjbaM4T4SMxdSaTWwA5smB/IIrmGdmNQQTg+YPtVN
        LzubyhtIAODKnFKyZcE7OEfdbdcI
X-Google-Smtp-Source: ABdhPJwrYs0NpL45FHuM2mG+iBXEXKvzRO8k/BROdQZg3A65Xk31k1sanxTYhikFK3yN7IwZw34BlA==
X-Received: by 2002:aa7:da8a:: with SMTP id q10mr4383546eds.139.1594904387362;
        Thu, 16 Jul 2020 05:59:47 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id n9sm5398605edr.46.2020.07.16.05.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 05:59:46 -0700 (PDT)
Date:   Thu, 16 Jul 2020 14:59:45 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Jon Hunter <jonathanh@nvidia.com>, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: pci: tegra: Remove PLL power supplies
Message-ID: <20200716125945.GD535268@ulmo>
References: <20200623145528.1658337-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KdquIMZPjGJQvRdI"
Content-Disposition: inline
In-Reply-To: <20200623145528.1658337-1-thierry.reding@gmail.com>
User-Agent: Mutt/1.14.4 (2020-06-18)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--KdquIMZPjGJQvRdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2020 at 04:55:27PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>=20
> The XUSB pad controller, which provides access to various USB, PCI and
> SATA pads (or PHYs), needs to bring up the PLLs associated with these
> pads. In order to properly do so, it needs to control the power supplied
> to these PLLs.
>=20
> Remove the PLL power supplies from the PCIe controller because it does
> not need direct access to them. Instead it will only use the configured
> pads provided by the XUSB pad controller.
>=20
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Hi Rob,
>=20
> I already made this change as part of the conversion series, but wanted
> to send this out as part of this subseries since it addresses a fairly
> long-standing issue that I'd like to clean up irrespective of the DT
> binding conversion. Since it looks like the conversion series will take
> a bit longer, I think it makes sense to send this out separately.
>=20
> Thierry
>=20
>  .../devicetree/bindings/pci/nvidia,tegra20-pcie.txt  | 12 ------------
>  1 file changed, 12 deletions(-)

Hi Rob, any feedback on this?

Thanks,
Thierry

> diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.tx=
t b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
> index 7939bca47861..d099f3476ccc 100644
> --- a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
> @@ -112,28 +112,16 @@ Power supplies for Tegra124:
>  - Required:
>    - avddio-pex-supply: Power supply for analog PCIe logic. Must supply 1=
=2E05 V.
>    - dvddio-pex-supply: Power supply for digital PCIe I/O. Must supply 1.=
05 V.
> -  - avdd-pex-pll-supply: Power supply for dedicated (internal) PCIe PLL.=
 Must
> -    supply 1.05 V.
>    - hvdd-pex-supply: High-voltage supply for PCIe I/O and PCIe output cl=
ocks.
>      Must supply 3.3 V.
> -  - hvdd-pex-pll-e-supply: High-voltage supply for PLLE (shared with USB=
3).
> -    Must supply 3.3 V.
>    - vddio-pex-ctl-supply: Power supply for PCIe control I/O partition. M=
ust
>      supply 2.8-3.3 V.
> -  - avdd-pll-erefe-supply: Power supply for PLLE (shared with USB3). Must
> -    supply 1.05 V.
> =20
>  Power supplies for Tegra210:
>  - Required:
> -  - avdd-pll-uerefe-supply: Power supply for PLLE (shared with USB3). Mu=
st
> -    supply 1.05 V.
>    - hvddio-pex-supply: High-voltage supply for PCIe I/O and PCIe output
>      clocks. Must supply 1.8 V.
>    - dvddio-pex-supply: Power supply for digital PCIe I/O. Must supply 1.=
05 V.
> -  - dvdd-pex-pll-supply: Power supply for dedicated (internal) PCIe PLL.=
 Must
> -    supply 1.05 V.
> -  - hvdd-pex-pll-e-supply: High-voltage supply for PLLE (shared with USB=
3).
> -    Must supply 3.3 V.
>    - vddio-pex-ctl-supply: Power supply for PCIe control I/O partition. M=
ust
>      supply 1.8 V.
> =20
> --=20
> 2.27.0
>=20

--KdquIMZPjGJQvRdI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl8QTz4ACgkQ3SOs138+
s6FeQg/8CaFK3+6Kkic0c11leZZI9E0xjgiAmN+q72Hw95NEPMk8ylPzMpsmm772
MFJF0I7jtjlRt4mU0tt68B6xZT9itW7XiaHmvOxXZBaHp7MZsRVYHShaHMt1NM8Z
FIN6RCgVOHxKiKKf04oj03kGwcQY/7HIimM3Jwf2xp75Nd2pfloJV1vj7m70t52A
hUbazU4yJkliasOVz8i1zMbI2sgfOvHYVszO9OBme/hMH6mvPPrAoI3v6LZ90T+H
n34YptT8gR5ZC/9RsxClClLgchqycHVKoB+WG17Au9B6ezbOHlwSyMQSJDDJG5N5
z1lwVrTaM2ccPhc1FOHd6TFRWiImwg4CobXN1jeo+h6akSUwCC7K5n3mNnl5c3pq
jiMy4CgWi8byYeCXkEA5SgZptpdQ36vhpTpU8pTnM2m4hEMjTSOcb/te7l0EDa2K
voN+XuapYTAKjALdspqU6SVOiTtJsRNl6jpSn96K1888CZfnZsT3/JPMHgttNrF4
6i6TwNPCytFkG81IwuOMYVFyUjyaYtJpBsiBGDkFiMVngf1pIDZ3q44Pm1Ehs9wi
DpIKYQNyKZNKLHa13zCSHNel9mG5Mnb5pJVo/KC+NdC0gBoKZ/BAi0pCfHYmVhqA
3EEe5p4eSIBeh8dC2hrXXQSfjHSm/WAxtf+hgO9rORcIlf8MgPE=
=j1RD
-----END PGP SIGNATURE-----

--KdquIMZPjGJQvRdI--
