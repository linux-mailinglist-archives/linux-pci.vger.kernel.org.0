Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD82918B27
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2019 16:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfEIOCx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 May 2019 10:02:53 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43917 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbfEIOCw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 May 2019 10:02:52 -0400
Received: by mail-wr1-f66.google.com with SMTP id r4so3207589wro.10;
        Thu, 09 May 2019 07:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HNoXaNV1qBkGpwMuiuD1EF2zj1FqN5YTgxnrdjR1Y+E=;
        b=bNk0zLrzPxvNcqvQqsw3NvvN9mgFKnowH0hYYdX6XYHkVI+3YFifVzAhJ0drkgyhnq
         3kjkoClOiBLQs/+1fuPOF+TmF3+CF8Ob8gkMKs3gNuHBHRza+0BSioY1aG6KIFxBdx2n
         F/wN5t40/VEpseSXgkhUt8pjds9r/B95uhbyuaWRdu6iEivreOgiQlcMtGuBU0chREe2
         xD4c4D6zZvUyijF4ye+mbfQWpbGDxn9TpXTZaEgz5x4pdh5dw6r0ms7d/pcsq5HCsq+q
         suEzRvahGD/yowYPK85yL+rllrjlpXjsM5KKGeSlCJxxcLIoC1lWkAfz6ayYZQcu/aBQ
         +1Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HNoXaNV1qBkGpwMuiuD1EF2zj1FqN5YTgxnrdjR1Y+E=;
        b=WMaK2KzD/Y3N7qUc78rZ5fRAeumcZOihqU/T+R6S4J8js96o+/nYdrERpc279skCQi
         0DYUwsIwerZS1RLXZMK8lG2PhvBaAmDu9W7g10LNm6EsxaiYwhKCQMjlhTlczz8qlGnW
         ilMI6LMxg7ifx3k+1qkFSC8leLDsn3O9TMbtu6b9kobW6ce9aKc8RI8aA1XWchp/FSZs
         I0vWuY06jyWLow3BSjT0XZSseZxuCYCkBhERY4WRIROD1YMtGFBwAEFXm/2JbUvmGgRN
         uIa9VqUCCQ9WUhxwqzHS0HHSaNt/5DuTmtDpV1AgDvvvOTJymRHr003KnSLeQpL1+fLt
         mV4g==
X-Gm-Message-State: APjAAAUwooxgxqy9WUJwJY54QIkjrHG4CjlEt8vGqdUqWORmSoki88zw
        7w3TXY+QruJPiSkT/sZPZyNI8fBSk0U=
X-Google-Smtp-Source: APXvYqzKnLJvIGU4e9eAFYPHSnEi/qYg6RE6Ka6v+mvu7EKyv0TYR/v3G9p6bU+FfqJ7VAUMezmUjg==
X-Received: by 2002:adf:f488:: with SMTP id l8mr1636437wro.287.1557410570267;
        Thu, 09 May 2019 07:02:50 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id y7sm7338385wrg.45.2019.05.09.07.02.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 07:02:48 -0700 (PDT)
Date:   Thu, 9 May 2019 16:02:47 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, jonathanh@nvidia.com,
        lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V2 01/28] soc/tegra: pmc: Export
 tegra_powergate_power_on()
Message-ID: <20190509140247.GA8907@ulmo>
References: <20190423092825.759-1-mmaddireddy@nvidia.com>
 <20190423092825.759-2-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
In-Reply-To: <20190423092825.759-2-mmaddireddy@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2019 at 02:57:58PM +0530, Manikanta Maddireddy wrote:
> tegra_powergate_sequence_power_up() powers up partition and also enables
> clock & reset. However, if a controller like PCIe have multiple clocks
> & resets and they need to be enabled in a sequence, driver must use
> standalone function tegra_powergate_power_on() to power up partition.
>=20
> Export tegra_powergate_power_on() to allow Tegra controller drivers to
> unpower gate partition independent to clock & reset.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> V2: No change
>=20
>  drivers/soc/tegra/pmc.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
> index 0c5f79528e5f..cb3de81348bd 100644
> --- a/drivers/soc/tegra/pmc.c
> +++ b/drivers/soc/tegra/pmc.c
> @@ -701,6 +701,7 @@ int tegra_powergate_power_on(unsigned int id)
> =20
>  	return tegra_powergate_set(pmc, id, true);
>  }
> +EXPORT_SYMBOL(tegra_powergate_power_on);
> =20
>  /**
>   * tegra_powergate_power_off() - power off partition

If the sequence for the PCI power partition is becoming non-standard,
this is going to hamper our efforts to move to generic PM domains. But
it is what it is, so let's do this for now. We might need to revise this
later on if/when we come up with a better solution.

Bjorn, do you want to pick this up as part of this series, given the
build dependency? If so:

Acked-by: Thierry Reding <treding@nvidia.com>

Alternatively I could provide a stable branch for you to pull in. But I
don't think it'd be necessary, the PMC driver is a fairly slow-moving
target these days.

Thierry

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzUMwMACgkQ3SOs138+
s6HprA/9F4gXqL3jv8cXkVNJm079C4WLCBNlKQk0065YfmbsRGwyqJgSkMQcQybk
N9At6Dmh4fAUPh5xwJ8yQ5eOphdPtbpci1cPMJk6Ze/tuQTtObDjHeggFz3Zx6M7
+R/AmRcbiyBomUrcey7bO398IFSF6bhpaKXxmJxzwlNY2JAzRS77jo1JcCnYolh2
2WZypuJmC6Vp9Z9yC8u+nGdZRu2ca9VYDezV9yVrTN0mG+YYN/eFyjUcuRypLScF
lm2hoAXu5M3RywjACzJltQgJd1+y2looqmrTlBxXm5xlNq7DdHK8d7KVLrtb2Qn5
ml3BtQ540YQmzaWyeukbP3XGxJ2/gIkKhjQ249u0AV8Op+LcDuaduHzhTUjeIFTL
1o/Vhc5FO+uqlyF7ete2R3jejJF99dPIbB2qq3E1H7Wt2EBiNpMVeCYD4cwRH9R+
xsgEb9SjshqMoAbr3sx+9AumfGchj33Mf0WIDCmZYXzk2L4pERBMi4PtMABd2NY5
XHbKEBy7iYnQCmDnKqcf+3+8Y+EZx6voh9ntDQiZBcCEhpaPKVOFiUuP9naEar8K
ue23LYfeIOFjZyeI6Cbj9FmS3JDtSNcciymoVOGdby3n6rDh+2FrHkhpbkbA9C+3
fA0BNLhVJl7lQJ8SwdQqEbIbiVzw5lNlvPFW8CthRf12SmR7keI=
=Bhb3
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
