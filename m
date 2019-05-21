Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0F1A24D40
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2019 12:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbfEUKw3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 May 2019 06:52:29 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40921 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727817AbfEUKw0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 May 2019 06:52:26 -0400
Received: by mail-wr1-f67.google.com with SMTP id f10so2637361wre.7;
        Tue, 21 May 2019 03:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HRbTjVTN8OoB545citX2qhVa2c0AvJYcHqIgYxkmq9A=;
        b=gkkqBAtxeAPYYG/Bk54hkH9W9k40R8uawvVI3nn1dXeSJIdx/0BCghDn7ppDeHy6kc
         1x4Kj9pDY90TqhbyxR++oZHu8pwSewYJrFIxFsz9FdXkXh+jIniud+n3yXsT6VL3l5Eo
         UGQ/KSJ4OvIGeCP/jH/8MXWbg/0mnp9LSdquQwLKvvosZZn4c2re21swy87R4nDoA1H6
         dMD9CsR71iXzoaUsfgtnS2dh+3mcASZHM/OsAZC8tqFPbzhwB8TzayFS8SnvKWoeoytB
         U6klf3SUPvPyHoT8EABXmdCYtoaLA0kiRvJw8nmMR0O+ZD3ty8UJL6sUYET3+6ATBAPL
         lnyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HRbTjVTN8OoB545citX2qhVa2c0AvJYcHqIgYxkmq9A=;
        b=QfuWyoyieRcxxR/SIBw9CPAzN/6AfBITL/0S3murF2JY2sp9uCZamdmBJAwm+EW5hZ
         SArvSV0wu94NRP+ulAVM82K2pr6PLl8rZbjzK5XWhf6zRXbcErLq/N+jYK6Il/eQFd7S
         8pYirZ7QRcOvDui1/alUlaPj0J/UWLvPSDzw0R3fyPybb08VlCLqFc5Md3wdlVeGUfKB
         1+hTX/vBKbXZqbIycXmBGZsOnEZR8scmrf7bGJ5+uixTVOEKYeFqrrS//uOrHOIZgcKJ
         4b96moBg4L5CxLPAk1k787+G4osnsApvUK6gWFGxgu9EnX1I9w7CVXDmAPTIdgF/jwGl
         DAeQ==
X-Gm-Message-State: APjAAAVrgo4KDb7qH67zOJlEjNsDRmFzqbNRCsO8zt6T1e+SIUfwLZV8
        2IU/MFdPAD+TVaVC0MBjMsA=
X-Google-Smtp-Source: APXvYqxpXXLjrUYm+9Ks93ImeKkcYxcdmkZsVwnotPqTe6hEInxRQZ9jQBFI3jur5GF4T/OAdMh/zg==
X-Received: by 2002:adf:cc8e:: with SMTP id p14mr34392325wrj.82.1558435944596;
        Tue, 21 May 2019 03:52:24 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id a22sm2545601wma.41.2019.05.21.03.52.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 03:52:23 -0700 (PDT)
Date:   Tue, 21 May 2019 12:52:22 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com, robh+dt@kernel.org,
        mark.rutland@arm.com, jonathanh@nvidia.com, kishon@ti.com,
        catalin.marinas@arm.com, will.deacon@arm.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, mperttunen@nvidia.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V7 10/15] dt-bindings: PHY: P2U: Add Tegra194 P2U block
Message-ID: <20190521105222.GJ29166@ulmo>
References: <20190517123846.3708-1-vidyas@nvidia.com>
 <20190517123846.3708-11-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yhze8HlyfmXt1APY"
Content-Disposition: inline
In-Reply-To: <20190517123846.3708-11-vidyas@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--yhze8HlyfmXt1APY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2019 at 06:08:41PM +0530, Vidya Sagar wrote:
> Add support for Tegra194 P2U (PIPE to UPHY) module block which is a glue
> module instantiated one for each PCIe lane between Synopsys DesignWare co=
re
> based PCIe IP and Universal PHY block.
>=20
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> Changes since [v6]:
> * None
>=20
> Changes since [v5]:
> * Added Sob
> * Changed node name from "p2u@xxxxxxxx" to "phy@xxxxxxxx"
>=20
> Changes since [v4]:
> * None
>=20
> Changes since [v3]:
> * None
>=20
> Changes since [v2]:
> * Changed node label to reflect new format that includes either 'hsio' or
>   'nvhs' in its name to reflect which UPHY brick they belong to
>=20
> Changes since [v1]:
> * This is a new patch in v2 series
>=20
>  .../bindings/phy/phy-tegra194-p2u.txt         | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-tegra194-p2=
u.txt

Acked-by: Thierry Reding <treding@nvidia.com>

--yhze8HlyfmXt1APY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzj2GYACgkQ3SOs138+
s6GkRBAAsTNXxZRflg9TNJMUocJhYJyNf2p2I3MYeL/Es4lheCSur4dpFNxLS4d4
8ovi/gHEn583zazth7fZmKLKRA1uowxBAY3GIeOwHDUjUPUM4EoskrdGiIHqyb1Q
RwheHqBMllkYHAUoqNYKAMqW6HScTa2rp6cRs/MoK2KEGK1lK2gutkLSx81RwVcN
A4hDk+lJBT7cBgAiF+qbl/S/5K6JA/4ZAJWFIj5reM13zItYRg2X8ybijky1enbX
kGhxxq5IphzpFPEOQxEDjKu+0XtnKZkh9Uc9zgWZeniV+GNQWNu/KdznSrh88hgU
qiCF1Oneyu638SdA6sBGLqD4MC/Lkz80oJmtYlCAwdkHuUM4NmpLMn7MbXt1ztdG
v8FvlB9j98nL4fRSB5cUhryuFACwCRmO/oZ873PfHSmcaku6OHjTrYEGqO+wM3UK
ejpHA4w5kWmE9PSNvuBee3InEwvIRiBGCio5es1G0OH1NDUmoxCdv4uif+cHm+DB
sQdkoV/9/XKEk2qU9uYr7gPcO9pm0X/aqa5nRV5Nj8QO9yUMqI8AyWGgqUP922gm
CC7w7PYMch9sjOvNKdZZ5GjdRrUrTh6D7qpr8IfZ3ryxmzBE0o2Kqi1Rx6C5OBOr
5f1joAV9ke0zZ8c0923NrFnKAdo6FeB2epvM1qyTQUBM7V0QyNA=
=n2S2
-----END PGP SIGNATURE-----

--yhze8HlyfmXt1APY--
