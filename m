Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 137F518BB4
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2019 16:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbfEIO1a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 May 2019 10:27:30 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45151 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbfEIO1a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 May 2019 10:27:30 -0400
Received: by mail-wr1-f67.google.com with SMTP id s15so3314059wra.12;
        Thu, 09 May 2019 07:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2od0gnLiJAnv9MbbO3xboZolmr9MLU7nMdqbTYgIviI=;
        b=R+928rXvuc5Q2m+VMfit48CCAYHSKIxf3abjoUbc1mebj0grj8jaYfwGbD1Ii89Zj7
         4TsOl2CJW0QB/6UPFN0Iua7M/uup2NHJ9SJQewiy89AfSFrFxNfj+28/wksyFq+4KwoY
         +xZOG0SAC1L7aY7p+dsWbH2vpkFP5E1VfA1kxd7KnDn2bFKBblYjmyl1uEV3mdzgraMB
         rM0pRXVllhlmHt7PSOkt8VygtFYNrSOqCIsG1VrsMJlFWodcZ9QDRoLpu45KFYXfIv2W
         0oC3lqiZDPmRHK37/SQceRvBph/ivYCOAsdxr7dp+qiONAduuYrJnJulqxMxUeNfwDsF
         nZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2od0gnLiJAnv9MbbO3xboZolmr9MLU7nMdqbTYgIviI=;
        b=sHCYFRevNval9P8u9kJz7BtXWZPLJqMuyUloFri4H6SlQ+3SGpDCdM1yYK/9Tq4vMU
         CISDSMzL4L4MW/blDZvdDCsi2qAC3jFo1k3fkHWLi9JaWcLWso3wxfliXSdisn+51DKF
         e5OvY1tQ14dV4jfzF4I9CR8GM87I/wipJhp/CsVdKrpZl4DQO5EZsS6RDK8GUbeO++6C
         rV7622vWorS2nEuiK8/FAi3jO1YsEKjZ/e/WVp0e5+DnEUwPLgsAoS3pgJpkhFF10m7M
         2NAUbD2TQQvnuwyyDB+iBvLDth2NCwWOhORVZyqUVLiOwhmZg4M40LDArgLB7iY9DKYu
         QIzQ==
X-Gm-Message-State: APjAAAVVuNE9rWJev91qTT6lSdrB+2q/I8ZCPdubQe0Temd5tYj5tpok
        bQNk5YGeGdNipSsRShZutHxugZZli3Y=
X-Google-Smtp-Source: APXvYqzeqsM0YpkZGcGyqcQFMiXNOVe2XVaZZjYXSv9BSQ47McBL8wmjnbJA6Yf8wW9bcCsz8j4D7w==
X-Received: by 2002:adf:eb8e:: with SMTP id t14mr3609159wrn.113.1557412048646;
        Thu, 09 May 2019 07:27:28 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id q22sm2303461wmj.35.2019.05.09.07.27.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 07:27:27 -0700 (PDT)
Date:   Thu, 9 May 2019 16:27:26 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V2 19/28] PCI: tegra: Change PRSNT_SENSE irq log to debug
Message-ID: <20190509142726.GP8907@ulmo>
References: <20190423092825.759-1-mmaddireddy@nvidia.com>
 <20190423092825.759-20-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="88pBQ1/6ie/nQzMF"
Content-Disposition: inline
In-Reply-To: <20190423092825.759-20-mmaddireddy@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--88pBQ1/6ie/nQzMF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2019 at 02:58:16PM +0530, Manikanta Maddireddy wrote:
> PRSNT_MAP bit field is programmed to update the slot present status.
> PRSNT_SENSE irq is triggered when this bit field is programmed, which is

s/irq/IRQ/

> not an error. Add a new if condition to trap RSNT_SENSE code and print it

s/RSNT_SENSE/PRSNT_SENSE/

With that:

Acked-by: Thierry Reding <treding@nvidia.com>

> with debug log level.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> V2: If-else to switch-case conversion patch is dropped, this patch is
> rebased to stay with if-else statements
>=20
>  drivers/pci/controller/pci-tegra.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/=
pci-tegra.c
> index 9b841b0392ac..72634ce6d3da 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -864,7 +864,7 @@ static irqreturn_t tegra_pcie_isr(int irq, void *arg)
>  	 * do not pollute kernel log with master abort reports since they
>  	 * happen a lot during enumeration
>  	 */
> -	if (code =3D=3D AFI_INTR_MASTER_ABORT)
> +	if (code =3D=3D AFI_INTR_MASTER_ABORT || code =3D=3D AFI_INTR_PE_PRSNT_=
SENSE)
>  		dev_dbg(dev, "%s, signature: %08x\n", err_msg[code], signature);
>  	else
>  		dev_err(dev, "%s, signature: %08x\n", err_msg[code], signature);
> --=20
> 2.17.1
>=20

--88pBQ1/6ie/nQzMF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzUOM4ACgkQ3SOs138+
s6HB4A/+K7pEVq/DuzHX5RWv32RH9lVyZOyq6vRSg5PZ8VSd7rbHZxXmOIH0q4Hr
oOtqrtelIuPE1UHVb/fltfYWVfiLPWO2US5BDBupHowvrc60WsMyx+IpI3S+ah8W
cNEH0YdwTXv1AoJGf8TdhKFIppiJOyxUwzJKkebJPrFwy9Q7U7sZc9jba2PPaqbd
04yUuvzJbkN7naV5Zevh3fze1Z3ilQMx3jfyvmTtfqZvv7Q8+84tLfa+clsa7MlV
LMDjscbamy/vFg3K33GXO8xRmGiep4pAW9qffqntL+BMTMC6fQD4TrOOz4y7uvd8
SYGkLuZ0foPwCwR+By08y0bZ107WB6BRiFJ6hEOGyPxvzcEpOmP1dQr/UoWh5YJ+
1BzsL2bAXDg0X4MEQzA2YUMGv8Dtx6WH/k4HxOrt5GoJQMkivjoS+ZiOkh59Rdtf
AUL3NlnD6LyPCq/Nk9JJWFLvTJvvcpSI3V8I8Jp70ToQREBXxqOjcc2ZfBfY2gcw
eKqaxDmKKll+II0BrNjLV2cMIjsYsaByYr1t+3KLX1TQe9KPjKst2+iPDgvJWeIr
jGO0wIlLjTvl7vkREGzcmCh9arXdVvA9ZIGRPo45haM6w2Ae++xoBNIyJm/7ox+e
j83yvLmRJFv4fIjkTz0O45iXEdKM8iJdw35H+GpXhku/2yGfb1U=
=bers
-----END PGP SIGNATURE-----

--88pBQ1/6ie/nQzMF--
