Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A258F12BFE
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2019 13:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbfECLHg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 May 2019 07:07:36 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44552 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbfECLHg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 May 2019 07:07:36 -0400
Received: by mail-wr1-f66.google.com with SMTP id c5so7320931wrs.11;
        Fri, 03 May 2019 04:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YpAYu2aGgmHElV09nPrKKKpHaRIZFfJTu8xyr7w6FJ0=;
        b=caBhdS/8I0WX4MnHOx4k7w/1pPNo2BgsqRuKhIyi5451TY2FeTuE9X4avsaYGkO7Pz
         a6lp9CxLKUK/Np/D15pRUinhgeXHS1eI1wTV5Igoica47BnsseYsiz4EELf1x/sXyB+/
         vcznVD1pptRAQEYkF/78qb2T7ekuFgcxGDVgrjtV85uOa99WDnAQ2/G0VLNpvR732Kx0
         Kh0Oprx11ReIMvFT7iNeBA0dwD1PSy6ffKV2U7/L0XXFGq0ZG/l/lOvK1CuK1F/r+jX+
         Y1NUdNk3ozGc/AtqN1MO51lgZQfqrI/b4vBwnesiFmjwxPd8aWciWvg+NQGMtyrF61Xt
         DaTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YpAYu2aGgmHElV09nPrKKKpHaRIZFfJTu8xyr7w6FJ0=;
        b=IH+Wqar6AW32O7LmvODZ6lCJ1fKh9/RaRpH8A3wi5FKsLcXRK1YBp15N+sf776Fnkh
         kRePmc4DDiZhLhcKP9YORQRwn7K7YSdUomQS+SECgnBUPstS8QezC55DL8uQ2s+MsT9f
         QqbMou2s2Vy8ADA2eXLKJXqc1ttIeRGSzCSz58zd3lin0C9kz99zZLgFdPpXl3lDby/D
         +1wIyUNlRsOWSQJNKy0rqerJJ1VHrAuPjqfRNUvlss6eKpeQ417bQT7DQznYvGPCrGav
         CkvV5M7A5V6JBDEBlgCGtD+/N2wklsNKfL4lVmtszbEL+QdRENpr5+npvA4R22zM2EcA
         kPuw==
X-Gm-Message-State: APjAAAXfyi8lBWnNKKfYcyBOSdkHy9KKSRJ0f+en3cNTuOwyXX1N/dFt
        umfOZZvzq6tvMXQDvhv97KU=
X-Google-Smtp-Source: APXvYqzjiQa8Q7+aDDyQPZIshcqUe8xFgkRxo6KKN6IKWW0PaiXZLSdZpkK0irkKsMNSsQieQ0Zlsg==
X-Received: by 2002:a5d:6341:: with SMTP id b1mr6600866wrw.28.1556881654652;
        Fri, 03 May 2019 04:07:34 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id j190sm2404085wmb.19.2019.05.03.04.07.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 May 2019 04:07:33 -0700 (PDT)
Date:   Fri, 3 May 2019 13:07:32 +0200
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
Subject: Re: [PATCH V5 03/16] PCI: Export pcie_bus_config symbol
Message-ID: <20190503110732.GC32400@ulmo>
References: <20190424052004.6270-1-vidyas@nvidia.com>
 <20190424052004.6270-4-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="R+My9LyyhiUvIEro"
Content-Disposition: inline
In-Reply-To: <20190424052004.6270-4-vidyas@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--R+My9LyyhiUvIEro
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2019 at 10:49:51AM +0530, Vidya Sagar wrote:
> Export pcie_bus_config to enable host controller drivers setting it to a
> specific configuration be able to build as loadable modules
>=20
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> Changes since [v4]:
> * None
>=20
> Changes since [v3]:
> * None
>=20
> Changes since [v2]:
> * None
>=20
> Changes since [v1]:
> * This is a new patch in v2 series
>=20
>  drivers/pci/pci.c | 1 +
>  1 file changed, 1 insertion(+)

It doesn't look to me like this is something that host controller
drivers are supposed to change. This is set via the pci kernel command-
line parameter, meaning it's a way of tuning the system configuration.
Drivers should not be allowed to override this after the fact.

Why do we need to set this?

Thierry

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index f5ff01dc4b13..731f78508601 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -94,6 +94,7 @@ unsigned long pci_hotplug_mem_size =3D DEFAULT_HOTPLUG_=
MEM_SIZE;
>  unsigned long pci_hotplug_bus_size =3D DEFAULT_HOTPLUG_BUS_SIZE;
> =20
>  enum pcie_bus_config_types pcie_bus_config =3D PCIE_BUS_DEFAULT;
> +EXPORT_SYMBOL_GPL(pcie_bus_config);
> =20
>  /*
>   * The default CLS is used if arch didn't set CLS explicitly and not
> --=20
> 2.17.1
>=20

--R+My9LyyhiUvIEro
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzMIPQACgkQ3SOs138+
s6GSnA/9HdsbQNxtdYHMx36I9O7XPCiJpWTqbqCG5v80y6wwm85gZ7gKZ3tnpqoG
AVff+CvhQQwIIW7t5OxkdDNvNz/65YPCYRngILQIIgQbXppF/tMu3YMQVPWGNY6R
LuV8/SkicRqGoyYvEhNY8oxObL191X964tV6roAy2zaPCk4FuNCqJPlRPpu7fXlG
u9H5zlpi/gVtvZNyJyOJLb/zG9cXIaO4lJCN43thTSD/vVCtytgvQRNWHWT9r7lR
wqy5o69fRtUXowCRNjlVR/nYJfguU1Eh+9YVr8l0Hen9XgKyNv6ebrzWSeZx76nS
xTj3bgbOrGm4yWM4EbQZNiGzM1d1+Ggz08osM7n6dqymSMP1zjAHAvb/S+7AulfC
J2b9VwKf/VnRzdU5fkbQEHtPsoOAwA7t70z5qwukraNLVgE7BO0R4A+Wca1kRRJ+
2NMhLmTFJJoR42ZI80UGH6KjixdU7p8cAup1ftb6YqxAWxIthSjb+xhka9s0cPV0
/XcAjoNMXXV9LRk/VoiuNhPMNs17u19NwVZ4O4f/l6qiSvI4BsjMs5B/70UXJgET
aAw4RI207uObGTDCKFKEXNVKf3WPwjiCRBv8X06OfKReDdnPobVETv4boTZFfreZ
WNKJYDqWndqUkSMR46sxPEUnfXNr+he7XCyzGLhOs3lAxGEsdPE=
=F/Ew
-----END PGP SIGNATURE-----

--R+My9LyyhiUvIEro--
