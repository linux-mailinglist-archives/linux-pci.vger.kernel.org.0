Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0F1218B90
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2019 16:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbfEIOUH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 May 2019 10:20:07 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33453 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfEIOUG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 May 2019 10:20:06 -0400
Received: by mail-wr1-f68.google.com with SMTP id e11so3346228wrs.0;
        Thu, 09 May 2019 07:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B3Q6qA7phHwnAY6uaFSoHnqoBf68Sleu+NkQLDpPvd0=;
        b=vJFsNXaBLxd9Q8PkINoaiTWjhVauc1RBJvFNfT/xh5JgnbYPTqelzZ+CFBRrebMuyK
         I+nGV3g2xZHEFxkuxZxurU/nFeOfU5hoQYCVqYn32SfXQMsSbufID80iD4x/cg4LAqQo
         pXiVMN/aiqZovDK4Rh4mQfDGMpVairFuFG4SUiwRQJh5zYgvG4tuazR9XmM7xmNIR+0v
         xa9MJYGySZ/nDQVojJ4y10e8XaBovC+lrtFSgq5hbA61/drykjBp0QF6PMErx99jkTwW
         8V7Cpbrt7Jfl1Fc9Ll149+rQosd7/J+dF5K118giTjVuiT/ga/UDykqHfizL5CeyIH/a
         q20g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B3Q6qA7phHwnAY6uaFSoHnqoBf68Sleu+NkQLDpPvd0=;
        b=i2pbNogmCqtiKB3aNG/ei5+3mrsKAkZBvMc4F2Wf+CaqRfBIBrgYRGFSn4wXhe/qtH
         WCx6Hc2OJ7dQfpZp+QP9K+2g8lI41I/VOUExQxNOJqmOAuN6GJ7T2o0NigJEf+tUvYLo
         WC37MCNrz/N/qSxlY/2599dthe24J3DPTlL6MROZzfVEkPSkfHnjtT0siXP9JAXx2lse
         6DnX/7AoQSt5kBndsngktep7AlnW8NhjRUOg23rCHycZud7fOBDUNkMUZBhTxFSR03sh
         pwORuuNndMyWY9ateLUEO2iFXixXR07YQhMUZSG2eJso0eC0vR5I/V02JyoTz2JVJh5J
         pMbA==
X-Gm-Message-State: APjAAAUVUeBaSQZAFBpohiMrVc7LnzltchCGWethgLCJal6wqZo8NwlC
        Sa3Hff5FeCw4sgAgIdEKPHw=
X-Google-Smtp-Source: APXvYqx/k/2wVP7qSHChD5Dj+m7VY/9WObS16QpcTiNEzLRQwT6dNXcwIkUPu4qDsJnbxpaKUfmLJA==
X-Received: by 2002:a5d:6684:: with SMTP id l4mr3341231wru.208.1557411604778;
        Thu, 09 May 2019 07:20:04 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id r10sm1642221wml.10.2019.05.09.07.20.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 07:20:03 -0700 (PDT)
Date:   Thu, 9 May 2019 16:20:02 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V2 12/28] PCI: tegra: Enable PCIe xclk clock clamping
Message-ID: <20190509142002.GI8907@ulmo>
References: <20190423092825.759-1-mmaddireddy@nvidia.com>
 <20190423092825.759-13-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YhFoJY/gx7awiIuK"
Content-Disposition: inline
In-Reply-To: <20190423092825.759-13-mmaddireddy@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--YhFoJY/gx7awiIuK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2019 at 02:58:09PM +0530, Manikanta Maddireddy wrote:
> Enable xclk clock clamping when entering L1. Clamp threshold will
> determine the time spent waiting for clock module to turn on xclk after
> signaling it. Default threshold value in Tegra124 and Tegra210 is not
> enough to turn on xclk clock. Increase the clamp threshold to meet the
> clock module timing in Tegra124 and Tegra210. Default threshold value is
> enough in Tegra20, Tegra30 and Tegra186.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> V2: Took care of typos in commit log and coding style comments.
>=20
>  drivers/pci/controller/pci-tegra.c | 30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--YhFoJY/gx7awiIuK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzUNxIACgkQ3SOs138+
s6HO2xAAkvI5x63ZPIRP0XJqegRNMwVI8Q8Qq2ywkDegjbNJew4Ddqf8HLiSUIep
m0P0+nFUC3ueZxsTalaA00w6Tfs+6E64PCWYmtbjoXMzX13Zkk2G657odg66eL7D
whjb0PIRMba0+nIdrN/YSRm8OU45+ZzBRQBMby25u6ijvMv8gV8856M13IrDPXUo
y5d29VHhYmt5FsVY7Oqnkw5q0NvTdmm4RdrrpGiTjoZDSc1j08QNM012dVOVC7iv
+LXvlZvE7FZ52A3nK/KVpIScxjHrkm5nNisI3kh9mP21sIPcxluMpZU2/w3nIjl8
yR7TAiSRKhg6E0bLO08/zNEsUS3PEMjeEkvfF4sNCHlBqqWjxZl7pj5lgTdY0bQ7
1CY8703sR9fb9G+O7m4uGTSGwJzz0pbmijyRzgD7jLdo3n/qi8jxF6tjuufTfnEp
yN9hdaUF6AdX5fRglNXQZdB5ZNXOMHFhdf24vfQSMe6vt0YA7EtiQOYpiy97zsGw
qTiDwPQAxhXuQhhhrpCnDOP8b0+Kyu5CpCIRiAAn8Ev50u8ypWzYmE35qSsLfNLa
evSdqYvzkxJ7l0/9L6WwV4vx1w4w4McVVe2gqiO4lRvLZPqj3Cp65Iu47AjQc8ZS
6aaOQNGSIlLjx5t7DmsMACpsBdqsiZh8XoOlkyMQoRr/RLnVQZ4=
=9Ujd
-----END PGP SIGNATURE-----

--YhFoJY/gx7awiIuK--
