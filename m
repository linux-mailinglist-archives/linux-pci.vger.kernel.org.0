Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00D69A5513
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2019 13:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730648AbfIBLjF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Sep 2019 07:39:05 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39529 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfIBLjF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Sep 2019 07:39:05 -0400
Received: by mail-ed1-f66.google.com with SMTP id u6so9480569edq.6;
        Mon, 02 Sep 2019 04:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dJABXDobIWh1nooLsy7S53th7Uqr+4tppXx8bmIrX/E=;
        b=srxps2g4NXpNgtJjDKxOu1fYmUhRVg5OTVtujqKbouQgKQhe7bdE7m37VmUsCLuLtb
         YQ6IhHchMua1pC1YoY2mPAjvrgunUN+5WNBdMjbiumFxlPihFjJFAjIMcNwOuTSmq30o
         PnlHAmwICgb+4iYJn73ht147Gy0J0E5QhjhqAh41AXsZbKS+bhymS0lDiqJWoh9kSRij
         i1z5TgsmnU0LNtlk+Zmfv/NLPKYnO9lrmEMF4nszPyk7OdJjLyBj6F4FarGCurD28rM1
         BlGFYJd3drJ+gSwsZ+HhLkT85Ye7cI0ekuKVnJgfFM5h9w4b3Ev3nV4bTvkeMI5lbgSL
         ywIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dJABXDobIWh1nooLsy7S53th7Uqr+4tppXx8bmIrX/E=;
        b=f+p2Kr/tr3Pn0mnzNGBASKrYEC1jk0oNKYIyl7P3/FU421WohT6hJCe58+bki2VWSJ
         y1UKaYO8yW9LVGTNMYT78yjwWtx+ZvXTIvAsJVdd/Grzpm9sLXj6zBTXoAx0zJR4WoPl
         q77No+SqwpzBcnQKgHHLxYidhUCvNFChXD82+pazG0UG0sIRBdohNv9QAUxdKok3vrpr
         L8pHP99K+SVBti7PSkkds5Dc7SH2KVFUbjnntXBaOF/F331+oFUsKeb3/RH1od7d0Io5
         aBwnCbEsnsoPian+i40UEHnfI4GSL1CAnDfbLZMGoQb8PHTz5igMlGX5kp2c8JVKcnSK
         Ax6w==
X-Gm-Message-State: APjAAAU1Q+u1rN11xUoWs1aYw267Y/xWLyABOYZx7WxgX4DodtRBXFwQ
        mINogqTWoBflEUIAysNMqP0=
X-Google-Smtp-Source: APXvYqxD0OTk4zunuo+zB+jioNUHxiTrPa/e6jRWtgJj83asCZF0rf+8ALlsOJheTmDEANFXKtyzNg==
X-Received: by 2002:aa7:c81a:: with SMTP id a26mr15644204edt.26.1567424342732;
        Mon, 02 Sep 2019 04:39:02 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
        by smtp.gmail.com with ESMTPSA id c1sm1938836ejm.85.2019.09.02.04.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 04:39:00 -0700 (PDT)
Date:   Mon, 2 Sep 2019 13:38:59 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com, robh+dt@kernel.org,
        jonathanh@nvidia.com, andrew.murray@arm.com, kishon@ti.com,
        gustavo.pimentel@synopsys.com, digetx@gmail.com,
        mperttunen@nvidia.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V3 3/6] PCI: tegra: Add support to configure sideband pins
Message-ID: <20190902113859.GF19263@ulmo>
References: <20190828172850.19871-1-vidyas@nvidia.com>
 <20190828172850.19871-4-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="924gEkU1VlJlwnwX"
Content-Disposition: inline
In-Reply-To: <20190828172850.19871-4-vidyas@nvidia.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--924gEkU1VlJlwnwX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2019 at 10:58:47PM +0530, Vidya Sagar wrote:
> Add support to configure sideband signal pins when information is present
> in respective controller's device-tree node.
>=20
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> V3:
> * Used 'dev' instead of 'pcie->dev'
>=20
> V2:
> * Addressed review comment from Andrew Murray
> * Handled failure case of pinctrl_pm_select_default_state() cleanly
>=20
>  drivers/pci/controller/dwc/pcie-tegra194.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--924gEkU1VlJlwnwX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl1s/1MACgkQ3SOs138+
s6GwEQ/8DQfqPImwI/sN8KkGlUTrymHeb5p1LcJjyObL3s5FzC1VNuPP6ztRPNMj
XUJ3C0LOyCBrPharGw9CyUpDmhzkhQaMqVmCekuocA6xMEQmG3ggIHaEW3wPwGwt
3evIIRgTAwoYT84m/q2cy/zOvLq8omwFGwuknOWcQCy6upDCKJt1hQAcnfg4+GQN
E/iGl21g1hfsZUlyGd9NAYZ2F9ZWbKaymoV+LmKRnB2R6U+D0dJb30w5oLnC+Gp/
2vtjAAa4c7re7ZG4j3/rzdOqzPjpJFa5KLHDV1I05lZi7rmyxmclmrhbrT0Fvwht
8l8lkb9WWcvAdpCv4aVPEqp/ocDN40uIPhqIwzjpbRmc28Z8/6Nc26Ps7xzn9WX1
yj7nQSQWkczWQPbNADrAlPCDpDBke/tzpNpjEX3IY7ltLvdCbV9p1LP3BU+aqCiV
nKcZIG1DMv70fmQ5ZZ9ln0ylERYt4c/69nGXiowdUNfwZ7/zD8tEhsmU332JHEOP
SGdAkxiz3K5m2MZ3DzyECyBcASTwZTWWzHsYmgqM2yFEOa1k1Ih7joY+nmd3xrAe
DnvcfZKW8dug/2zwdraLt/Dkju2bczWXHLVLhJpISEh8he9H1jsuZho7u+2wacQJ
2LZA7HIIANTX/M06bh+sbv6UG+WL7AImXDhDVpUqpuqmqDk3uaI=
=eL6G
-----END PGP SIGNATURE-----

--924gEkU1VlJlwnwX--
