Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE86177784
	for <lists+linux-pci@lfdr.de>; Tue,  3 Mar 2020 14:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbgCCNjc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Mar 2020 08:39:32 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43248 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbgCCNjc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Mar 2020 08:39:32 -0500
Received: by mail-wr1-f67.google.com with SMTP id h9so3418034wrr.10;
        Tue, 03 Mar 2020 05:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+2psQteAP/nChvPm4YDjqHGqV1kWBdJs4ADtRdquZxs=;
        b=A3/O6Qe3YL74ggE/tBVJn2xsBwRBx1ddjGOkVocGqwWHBKhdObohxPUmr/JEKlfmxk
         OOXFWehica28U0mEv4PDia7ATqU9HsutGekW9r5tf2X12sijBxYwIfS6U9UDT11Bl2cT
         pGhWOmGChZ2o0ES/Y6cu8GDDrYFGaVLe3NPfdl4MWu5rX42u78erSW6hxwS7UUpz5nMi
         U1bq5XTA+BYaEn87u1eTlKFZ3mcBKizbolAqyJ3EMYsTP6oHPd8U24uIHRG9p7kxYTwG
         BFozbtgJlN69ENWI/VVCgN9dwlPGkEMyzddOfulCcyVtii2gXZ7rADxSyEDMGUGhD3gM
         BUTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+2psQteAP/nChvPm4YDjqHGqV1kWBdJs4ADtRdquZxs=;
        b=I2LZPY5tFND7nQW3ioELr6l9D/fAhcLHds4oW3J0HxjMdrY/uamIm2BlnZaJFrlExq
         ZiU+zDtfnONuoNXCsqOpCSMmfQdocUDbfxSVDH6wqWpteZqpgXelF9XSdJPcp67ov48R
         0fH1e8BhMN8X6SEBUwxhPy6aWL8wd0v6sZlVSI1BEWIjwL9uvRQyWY9O4zdbxglxBscW
         /3Nhi8yoq46540FadKcQf4c6rVR/ka5uG3BnRTZg3tQuCI5uWbAZU4mc48g+KitqX8Jj
         H0+EyVzhlM2jYxg2ft69Ldwo70YT3c8bGS7rpxcKCHOPTyTRQ5AAKPkvQUOEk3Nb9DHw
         XjXg==
X-Gm-Message-State: ANhLgQ19uHhDrAUUq7Y1v423ZSaI3EkbVRcGrhmMqra/MjGrBSjxYgIx
        gAVAQxReJSdbaiOR2LAopdQ=
X-Google-Smtp-Source: ADFU+vutRvNdL1/dEDudvF8N+CkmzoT8gckzelnvWhW1WAzJKLNYT0qdmOl0ljzsq2Th5yGHHvM4XQ==
X-Received: by 2002:adf:fe4f:: with SMTP id m15mr5432015wrs.223.1583242770266;
        Tue, 03 Mar 2020 05:39:30 -0800 (PST)
Received: from localhost (pD9E516A9.dip0.t-ipconnect.de. [217.229.22.169])
        by smtp.gmail.com with ESMTPSA id z12sm7023019wrs.43.2020.03.03.05.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 05:39:28 -0800 (PST)
Date:   Tue, 3 Mar 2020 14:39:27 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com, robh+dt@kernel.org,
        jonathanh@nvidia.com, andrew.murray@arm.com, kishon@ti.com,
        gustavo.pimentel@synopsys.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V4 2/5] dt-bindings: PCI: tegra: Add DT support for PCIe
 EP nodes in Tegra194
Message-ID: <20200303133927.GB2854899@ulmo>
References: <20200303105418.2840-1-vidyas@nvidia.com>
 <20200303105418.2840-3-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="s2ZSL+KKDSLx8OML"
Content-Disposition: inline
In-Reply-To: <20200303105418.2840-3-vidyas@nvidia.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--s2ZSL+KKDSLx8OML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 03, 2020 at 04:24:15PM +0530, Vidya Sagar wrote:
> Add support for PCIe controllers that can operate in endpoint mode
> in Tegra194.
>=20
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> V4:
> * None
>=20
> V3:
> * Added Reviewed-by: Rob Herring <robh@kernel.org>
>=20
> V2:
> * Addressed Thierry's review comments
> * Merged EP specific information from tegra194-pcie-ep.txt to tegra194-pc=
ie.txt itself
> * Started using the standard 'reset-gpios' for PERST GPIO
> * Added 'nvidia,refclk-select-gpios' to enable REFCLK signals
>=20
>  .../bindings/pci/nvidia,tegra194-pcie.txt     | 125 ++++++++++++++----
>  1 file changed, 99 insertions(+), 26 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--s2ZSL+KKDSLx8OML
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl5eXg8ACgkQ3SOs138+
s6EM9A/8DAyhoERGWyWFLzxgSdVvezOO0qahisCaxcwAdXVDTshl55YSf2n8j1fq
s03XQ1gqN27mUy1TrBNjlhQt3ghcCr+s3KJZuRjgrlxq8wgUFdBdkGtHoc42sUm5
I4NYbmWEiDaiYeUSPbw1O8mgl4kzFixGoBACEvWV1C/CI7DHUJFZ+c8YWaEvwARu
pOjH1IjmBbXPzrF9474jMIYzdNA38Vq2AmhPKqWEflNspTAPg9Tag33N8AUoBGSg
x5H/tWnggOIO9uzgyffIW1jbjy+6NiibjtmC1lAaFo/UNb41bwZgRd5wSvcg78ku
VRMtb4Vet7czoXs2u6EMXgfIX3+30Oad8l9BVz0kYmLlIN0fRrqxQYAv1NNCAAd0
ETqPNWgH1UQsMCl8kNOoESwKNwe+GYzcYDjEawYscvz2qvDuHDrgMvgC9CcI09sM
Uqak29cyLLhBxJ/7Tu0sOe458kybGMoDbvIM1VMC+kQEfowo76GqHeURlHJ2Uq9m
DKO0HlgV0lavxI4byOQcZ+lNF7u/CSKXbBjbZ7/WKAqTtLpehfcV1XAhXVdR93Tf
pKx7GXBF+UOJhF++E4ykFn116wbcYjtTf6lGnEhGnOIKz7CpxB4OmAxk/P0EQWDH
/VTNpkD/7dz77uH+ZFPxD447zAyK20qoeeRtgBSQwC1rgL2k+yY=
=A2Ef
-----END PGP SIGNATURE-----

--s2ZSL+KKDSLx8OML--
