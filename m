Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6454CCC2
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2019 13:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfFTLS7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jun 2019 07:18:59 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36700 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbfFTLS7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jun 2019 07:18:59 -0400
Received: by mail-wr1-f66.google.com with SMTP id n4so1410243wrs.3;
        Thu, 20 Jun 2019 04:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2lpe6E9tXVVeESpscH/giYrYfLGFJPAT5WRHM8Dv1/k=;
        b=WNtQcJkvY3TNGGyEYHnKQ430tdbmPJEvXiVdRIKWHMu48K8QxVfgy4nmBqY3cQBswM
         P6A9qC9kas4Ev931ZjUOJsoJxT0MTgRMHiEjU/TZXDkhjoOcRiuMO1yAp+uPXz2u+53X
         oMLRo/6bzWlNmyrAedNIsxbghClZT7or3Z2RCziIGWmbzJ685LpTza/DJXkmY/lQ6l6f
         /AO7Wm9WVypwTg1F2APPhbHgSQNoo/xAipp5syJknxrYvw9PIwwJMkh1KPCUaEFSnVUv
         bCpaQt39gVhFkGcsBapo3k8KR3GINRo9MGhGCcN53jsWCl1WJgJkMQBj+5cZGTd09vdE
         ZR1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2lpe6E9tXVVeESpscH/giYrYfLGFJPAT5WRHM8Dv1/k=;
        b=ErdWOzYmStWoN8LIjc8EDQxxqisqn6dfH+vURxUXHq/yIo33cBYnTzxpeISTefvDnD
         /MRKeIqrvs4YmspHBL4CqiQsvKhUVZPc5jGQ3aU/0aJLNx3b/+2559UXVxt5F0pvOdym
         tiOXI9d3ceEpe9+TIOSu0xhHvpkKA/d89lI30x0Rq72sxILFtRyVkYW1pF4BHf23uFsQ
         sOQ3vXpoK/VqVXSjK1ArtGDC3Fxs+bHpBah7Zj4pRXsouPslglaxdJd1u8bf1GUBszwM
         Vt7QypGACA9VV3LJAUChusNcWvUxdnAH6OE/YAKIOTbIBuDe0BbKnLtZaIwYmVY2d59/
         zIdg==
X-Gm-Message-State: APjAAAUkA4YtNRZV+oDFugDrqW0NOeCFrUE/HWV/UPgA092ciLj1eGqW
        yfhtJaHFLlLJiZfXblAN05Q=
X-Google-Smtp-Source: APXvYqyIlXFiqsbFHBRrw4Ml6BY/Jl7jegBaLVnl65bT1IDxMkWnAXc1oxNCxAP/JfctHhFFtBvFYg==
X-Received: by 2002:adf:de02:: with SMTP id b2mr14622267wrm.349.1561029536490;
        Thu, 20 Jun 2019 04:18:56 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id u18sm14342934wrr.11.2019.06.20.04.18.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 04:18:55 -0700 (PDT)
Date:   Thu, 20 Jun 2019 13:18:54 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     bhelgaas@google.com, lorenzo.pieralisi@arm.com, treding@nvidia.com,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH] PCI: tegra: Enable Relaxed Ordering only for Tegra20 &
 Tegra30
Message-ID: <20190620111854.GA15501@ulmo>
References: <20190618073810.30270-1-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
In-Reply-To: <20190618073810.30270-1-vidyas@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2019 at 01:08:10PM +0530, Vidya Sagar wrote:
> Currently Relaxed Ordering bit in the configuration space is enabled for
> all devices whereas it should be enabled only for root ports for Tegra20
> and Tegra30 chips to avoid deadlock in hardware.
>=20
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
>  drivers/pci/controller/pci-tegra.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl0La54ACgkQ3SOs138+
s6F/Tw//d+ZSmk6kGHKUYfh/VTlkJagRwc7isKAQNizExQyGKbGILHaij9+0s88Z
UczRCiIOsNAVEuwyVbOr9n69KgJ/VMe06O0SIMUAF4xl5IR2EO6t9J1BW7YRjr1O
ai//BOxbzwAfcukY7NXDOHPvY0HdEH4OZebafA21iYPrrdlsCjDQwEXmDdNjCFiB
hjAcjmxTUEqmPJyORnzr6rtnO+vvTEdugHD7dEpQIqfbULoGwFHnqT6P9lKicT/w
hN6VWJaMJazAskUdQT/49SX2565IgYFYEPyTWU0inE2wLzzmvSCi5w3VhJI6XArz
OZBHTIQ50SYFHpLGvXhUleK3SLnhiJ7t/8rbxVVA6V0m2nM5lMzpqwcGPqUa8DX0
gClCErzJA2Jd+2Yy1r0uJ1L0BKGcQoVJWlYiFoUst0UftvwZ+rPKF8r5JHZsk+L4
f7RMlmM/xzAzPpVo0MaRh+cR5efM16fNFiKc7zv6LQNLwAyufrAmRF0QG5RbkujI
wZmAay/vw1uwUk4x0laijmShiU0H/9gtDojHsM9H/qCL3POWVYLugq9OMnK1e1vE
Me5ltYssDA2DELFJTv1FSZMI5kOo0xQyuWfSxMGBf3vfz8ONy1mjXbMpqe6oS0vJ
aSZkjw9U0f9bj1Zc0UO2cm2YZcMNxinLF+x3fukWThwwGAhTYCw=
=5Y91
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
