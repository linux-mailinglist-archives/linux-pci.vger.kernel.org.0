Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC9918C39
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2019 16:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfEIOrI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 May 2019 10:47:08 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43491 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfEIOrI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 May 2019 10:47:08 -0400
Received: by mail-wr1-f65.google.com with SMTP id r4so3421396wro.10;
        Thu, 09 May 2019 07:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3qSrGTC+JV2uaYni94KF+pZS9GCXHAgTfo2SZugTPJ0=;
        b=EzDhYgDtx+OKVkKhShHaZ/uLVXhRC0Uw4Bvy0JEWF+lESG9ZmO1gnpwzYYDixgRxZL
         pQuieVJIb6wxZw4d6ZE4rhCoBxmYWyb4sjVNBqvecsz40W1YICFlmnRPJahxDoUBSxFM
         Dfv8PsLlJSeCXYDWbNcHYLje+UYYfa8Bgk3YUdnLeo5sz7jztcR5aXf15KyVOTDQBEtG
         23uc1G7neGrvAB4KYIVwkCvPtgybmjiBLMRJNQhyJepaZiXEjY/AyKksq3T/2rvH8IS/
         FZct9fxDw7qiQioVvx6ggj+9P8Tx+k+/ssiNitJckHchJUKJpkGPB7zJ5OWmzLndrt48
         tvJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3qSrGTC+JV2uaYni94KF+pZS9GCXHAgTfo2SZugTPJ0=;
        b=W8StDheg/A9sGW5L6xU/1F5PFWZOPuC65TdCY/wlmfetVeIR46Dg3LIEon4H7uj1FF
         hjnVM0fN5zFAHLLRpIfyXtkWR3dkYg+edJ6xKD4nlHicaNBHX6Ehz5nDktz++HvhYsTY
         sqtgfCG5Zk3+zep6tOTIawkoHM7ayqLsDCbFDASKmSTpqD0uwqqhq/VOnxb56c7pFZu6
         JVt+kQU2gE8ea23JpkrL+id/W2KjbfM9kjFH91ufIJdlhC/zT8OSmIcST6pbjWgT0Xa1
         tfdSeufKyOxjl6LfjdMUDvkDQ33pWeTDFcbIN+k1a5lopjZlPPAafsPOw8rphN8b9mSm
         6Oqw==
X-Gm-Message-State: APjAAAUqmPdYUHj8P7na9OMneOaxw+XuOij1FN+cB5eaXAhNudXrHKZO
        Xwy8IKDnz+2eLNccldBTqlU=
X-Google-Smtp-Source: APXvYqwU114KfJ0QWd3p8Fkp9iLvig51ZODyGNgY31i458To+zTlUuuImMi+ngyggbY6X2ushw56/g==
X-Received: by 2002:a5d:4648:: with SMTP id j8mr692752wrs.53.1557413226089;
        Thu, 09 May 2019 07:47:06 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id x5sm1458094wrt.72.2019.05.09.07.47.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 07:47:05 -0700 (PDT)
Date:   Thu, 9 May 2019 16:47:04 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V2 28/28] PCI: tegra: Change link retry log level to info
Message-ID: <20190509144704.GY8907@ulmo>
References: <20190423092825.759-1-mmaddireddy@nvidia.com>
 <20190423092825.759-29-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pM5zeTSooDOHDhuH"
Content-Disposition: inline
In-Reply-To: <20190423092825.759-29-mmaddireddy@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--pM5zeTSooDOHDhuH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2019 at 02:58:25PM +0530, Manikanta Maddireddy wrote:
> Driver checks for link up three times before giving up, each retry attempt
> is printed as an error. Letting users know that PCIe link is down and in =
the
> process of being brought up again is informational, not an error conditio=
n.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> V2: Updated commit log
>=20
>  drivers/pci/controller/pci-tegra.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I wonder if we even need the informational message at all. Is there any
information in there that's useful to know? Do we care about how often
the link-up was tried if it ends up being brought up in the end?

Thierry

>=20
> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/=
pci-tegra.c
> index 09b3b3e847c5..563958104dd0 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -2370,7 +2370,7 @@ static bool tegra_pcie_port_check_link(struct tegra=
_pcie_port *port)
>  		} while (--timeout);
> =20
>  		if (!timeout) {
> -			dev_err(dev, "link %u down, retrying\n", port->index);
> +			dev_info(dev, "link %u down, retrying\n", port->index);
>  			goto retry;
>  		}
> =20
> --=20
> 2.17.1
>=20

--pM5zeTSooDOHDhuH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzUPWgACgkQ3SOs138+
s6HFBg/9FC/ijtApzxY1VYwus5Z6wQc45LtkkBKwv0pdSYFIcXr8Rovhvgx4AcRa
U1FqT63dzWlBatO9/aWj6vVBUuzIin0DG0RRn58wWezKP/Qhtdyzu0sp8I2CsCpY
zuvS9KB5phGJ45g/Dyzw3n1CDtyzw45UJV0WeZjdqOfG9Sa4uGoEUe0ZWNX1yHRl
jl6yTcGQG2yfHz71dZeEVUHDY0hURW/ByXsfvI4NNKv5nG99C9Z2Xo2tZNWwrJ4+
hTxt6qJKkxRWPhZIXGFAVwuutLRKD+jGvg+eEqIuooZ2pLPU+94BnRgskaXOyIrh
xbix299OBhjWuTkeRjBFdD9g0d9BHGD+YQeeK1cvjdaSckvcc9ZD7LQnEiso1Zfz
Z42/AFT85vy1UViS6AabxW8yjaCvaQq5clcO6c6hH6Lm2wi283Y8s6EX5Xm1slxR
Osj6OmxXpbWpmM8wU1iWuQOnEkd9/mmTldWIJJH7+og6t5Ys1vSDtPQPLcVubKmA
sPgpz5Mv/SHDeqz7mJVNvkcb51zPbOM+9Vusv4kAgezvjuyeCGvkmI0aub3VsRQk
w20Dip7BIbmnYpuGy/YzEgUWqpnW48Y7z1oOZcvrvwOr9IPVdNU5d0KbJ2ONBb9M
0WTiqlsuTpA6RgUQB/M24Bv8zAXYZyBtr8MMUbeqsBRGmAhWWgo=
=vEwq
-----END PGP SIGNATURE-----

--pM5zeTSooDOHDhuH--
