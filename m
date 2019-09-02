Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B336FA551B
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2019 13:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730767AbfIBLkE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Sep 2019 07:40:04 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34667 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfIBLkE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Sep 2019 07:40:04 -0400
Received: by mail-ed1-f65.google.com with SMTP id s49so15397769edb.1;
        Mon, 02 Sep 2019 04:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=19JF+f4JLTae925R7+YX2DVuxawWCqQAPMge5Gu5oHw=;
        b=X2esWECaq2DkfG1LPPXs1Ig8CeBBiRTiStBw0egxO+PPZm+f6teGFn33ECnAWGeihV
         ZXwj2NT+ZnbaXd+/Li16HXLCzm2eJn6eqV4MPvtDBiQvp0MiDs/srCuzk1AglsxZxf2c
         G9bodG0ZtADatATr/zkfoTpqJXUsKMMgyjrpyK0Z5mxF7G0eQ6VoJAsU0pjqOKhsxcUc
         s1B0Xh/fx1XeZj+9WoHJ7YcF5ovkNNZu7CJ46OYWy74mE7DEiTCrTh+1wDEmtiI7V6jw
         vxk70fAeRnleMPFlzSuka4TwCvmT0/NZd92RnMtlBkkzECYLo8jZxDi9u65vRF1xI+69
         ag0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=19JF+f4JLTae925R7+YX2DVuxawWCqQAPMge5Gu5oHw=;
        b=kae1ik5IqBMprNssKSlxRXZ5BQ4pMkbXboBgIjKt/tlIpszLr1BB2JQznWIBXzP8rf
         aMysAEfzusAIsp6OdrOVHeInrZNFyG6PilqiUnSCiwEYLU4EGaAwWiFCjmbhfvd1tuHN
         AiJPrGOPzLhsrO8hPotYBApu344EuIXAL7sAgd4gH1AuIrXLYIcMzKHT9c1rz3F5sNMM
         EZgpTAmDBLyDCpkZHR1OTu2fTBWaI39zivCpq3v+pZTklv/OwouAfvj05E/3IYjk56zE
         qDcWXu32qC9Z0Lbppl+bIhFTM0U1mGQe/avnbkz34AdAujgmHjHxFfAjLxHUoyZ7kZcM
         N8fg==
X-Gm-Message-State: APjAAAXPPThq0UqG5f6ZFOQCFxop01mZ+l7haCEBRe6lajE2VQ4pFJ8F
        +5wbNZIp+AN/1XmbW3JarOk=
X-Google-Smtp-Source: APXvYqxkySTv/vbJWnKDsK+uWOXBxEWirXQJTF0Li6dUXZGlewF3Be8Bt2SBdS+jnmoYyPG08pgI5w==
X-Received: by 2002:aa7:da54:: with SMTP id w20mr23290367eds.52.1567424402711;
        Mon, 02 Sep 2019 04:40:02 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
        by smtp.gmail.com with ESMTPSA id v8sm911608ejk.29.2019.09.02.04.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 04:40:01 -0700 (PDT)
Date:   Mon, 2 Sep 2019 13:40:00 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com, robh+dt@kernel.org,
        jonathanh@nvidia.com, andrew.murray@arm.com, kishon@ti.com,
        gustavo.pimentel@synopsys.com, digetx@gmail.com,
        mperttunen@nvidia.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V3 4/6] PCI: tegra: Add support to enable slot regulators
Message-ID: <20190902114000.GG19263@ulmo>
References: <20190828172850.19871-1-vidyas@nvidia.com>
 <20190828172850.19871-5-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9/eUdp+dLtKXvemk"
Content-Disposition: inline
In-Reply-To: <20190828172850.19871-5-vidyas@nvidia.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--9/eUdp+dLtKXvemk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2019 at 10:58:48PM +0530, Vidya Sagar wrote:
> Add support to get regulator information of 3.3V and 12V supplies of a PC=
Ie
> slot from the respective controller's device-tree node and enable those
> supplies. This is required in platforms like p2972-0000 where the supplies
> to x16 slot owned by C5 controller need to be enabled before attempting to
> enumerate the devices.
>=20
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> V3:
> * Added a dev_err() print for failure case of tegra_pcie_get_slot_regulat=
ors() API
> * Modified to make 100ms sleep valid only if at least one of the regulato=
r handles exist
>=20
> V2:
> * Addressed review comments from Thierry Reding and Andrew Murray
> * Handled failure case of devm_regulator_get_optional() for -ENODEV clean=
ly
>=20
>  drivers/pci/controller/dwc/pcie-tegra194.c | 83 ++++++++++++++++++++++
>  1 file changed, 83 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--9/eUdp+dLtKXvemk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl1s/5AACgkQ3SOs138+
s6GrjA/+MtsbQCfp8LKNLtXIAB9YZZ4egzdAnTHcT5Q8avyAv+spu6XTF4QUYTXr
ddGsqMuqZb6GFzPuALVW538dPpZJNbxKj2SAYXX8R+peSTCLi7q2iYbVRLXy87LX
bfa1a2ZvUB6QCbUyjtrVrGxJ7qMznfRH8GRaIkRPzvYhs9vceoSdUMstxfwdV+lo
5BO0x3mbWxm1EclBwHt+6DG0DYSLn7jmXYKJMc2Vly9Kuw3tApOyM2iHuiAs8zTO
9BmHFzKa88QsF/7Uk11rpFc2AnCbsn8nSTXbyRwebGhOMbosBVLgGhlt43trzHiM
uuYjh7UNfeHKQ2I9qmbaze/TaDC8kJcbCsNyxZkFBpiGmtFYyt8t59sEDVlm8gtl
bq0UQGhV5hn77I8KY5j0nQoRAlcZUrfg959QvIvTq3wq7YXnPXxmbniSEJceAzuL
aU2PJ2hbygWQgjmeuvB8lTXxEMhv/RfzIUVS1NnPSq02vjOGihf7prSN8F6VAoom
HoUXgjQVEAdU/lo3nBuJt977fv5zVH7cOEgG6aJMpqPbFNvk4rm+QuYB5ED8+mDY
Dvssm1YWsZe64dSgdY8XpD7/Vvbe0RTHu1dSXsC5KjhfTKkHlfjJm3xia/HyjDwD
OYJPDbss7TA8RH64Wgczu1N7WQVfvDv2q5wdqHmA/f9EasuG4j8=
=UhQc
-----END PGP SIGNATURE-----

--9/eUdp+dLtKXvemk--
