Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79D304CC8D
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2019 13:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731663AbfFTLDT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jun 2019 07:03:19 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52337 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731638AbfFTLDS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jun 2019 07:03:18 -0400
Received: by mail-wm1-f68.google.com with SMTP id s3so2624443wms.2;
        Thu, 20 Jun 2019 04:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VSz5A8epBUVmpw04i+7PmcLUxz8iUrkIJ6W9aJ7sNBE=;
        b=MFwhnOXLZ9GpiBBqLEqgfUgzF9H/T5lernAK18SVhj8NxXDQFPuD9JGtL0gZ6gbMKf
         SLubkvRBu88LJI4iW9/byraIUBJrQrskeK0CjVhVfsI/Fb1lcyytEQVgcGSKTB9vnQs0
         YaGGYz2vRetRoUvgZpuwBFdmITslKVXqNr9vPQDyvnFp0q0xHvwYp3esf/bNp9dgR1+v
         JkXPZPGh2uZW5LaHvTgFrS5HMBta5HsSD4RfNKF1QSdISKM9larovbZSm3opX5ZpAn1n
         GJTTeB7GvFKBULMmrQWAMue/EV3yOOLgC21WQXUbGFjJLmLuUyOR1kG4dVw7vpsQcaC2
         8hUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VSz5A8epBUVmpw04i+7PmcLUxz8iUrkIJ6W9aJ7sNBE=;
        b=QH3jRKiyeMueHlCwDYSb0HkOIwFay/1earfrGn9FyIctYMjgv1jGBQGYqpw4f+08Vt
         70KW0nxi2+YA5hIl/UUBwIpj37uAVyx/ZdmsTTP7Ur1gxlEUVxFXQ3ZQuvq5OpMV2dgo
         Z/M0UtOxKyayvOGJDlfrO90/G0E0Fs4sp7weiKe5Wl9UZejpYRSVOGByb/pkDWl7xM9N
         rFXmkvpebePO8uUBTpIkuj2GwREMQaJ1Y7QuRYxIj9suPUcI615KCvdGIDY5YRMX6sXg
         0OPg6I2RZ+SwBISLYWXFwXOJtRjWHcit6Qf1N5mVMX1YhuBjWnzfybVJgEtOwefxDVtt
         IruQ==
X-Gm-Message-State: APjAAAXT4Z+aJ9lqQIgG4+brr4bNQuYDcPl7AViDuXW9IzKRXixDJ8qF
        B2q3MvVAV7rvtyN+xKtjnas=
X-Google-Smtp-Source: APXvYqxNm1K3WSG5KtignpG+L+f5Z30baasXSgC4QDQcxHwU0lotsXxcZhOn1TedVwCsHtN2jLY3KA==
X-Received: by 2002:a1c:8049:: with SMTP id b70mr2364726wmd.33.1561028596768;
        Thu, 20 Jun 2019 04:03:16 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id s10sm5934353wmf.8.2019.06.20.04.03.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 04:03:15 -0700 (PDT)
Date:   Thu, 20 Jun 2019 13:03:14 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com, robh+dt@kernel.org,
        mark.rutland@arm.com, jonathanh@nvidia.com, kishon@ti.com,
        catalin.marinas@arm.com, will.deacon@arm.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, digetx@gmail.com,
        mperttunen@nvidia.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V10 15/15] arm64: Add Tegra194 PCIe driver to defconfig
Message-ID: <20190620110314.GC15892@ulmo>
References: <20190612095339.20118-1-vidyas@nvidia.com>
 <20190612095339.20118-16-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LwW0XdcUbUexiWVK"
Content-Disposition: inline
In-Reply-To: <20190612095339.20118-16-vidyas@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--LwW0XdcUbUexiWVK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2019 at 03:23:39PM +0530, Vidya Sagar wrote:
> Add PCIe host controller driver for DesignWare core based
> PCIe controller IP present in Tegra194.
>=20
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> Changes since [v9]:
> * None
>=20
> Changes since [v8]:
> * None
>=20
> Changes since [v7]:
> * None
>=20
> Changes since [v6]:
> * None
>=20
> Changes since [v5]:
> * None
>=20
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
> * Changed CONFIG_PCIE_TEGRA194 from 'y' to 'm'
>=20
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)

Applied to for-5.3/arm64/defconfig, thanks.

Thierry

> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index bb0705e1f52e..6462a4dbac87 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -192,6 +192,7 @@ CONFIG_PCIE_QCOM=3Dy
>  CONFIG_PCIE_ARMADA_8K=3Dy
>  CONFIG_PCIE_KIRIN=3Dy
>  CONFIG_PCIE_HISI_STB=3Dy
> +CONFIG_PCIE_TEGRA194=3Dm
>  CONFIG_UEVENT_HELPER_PATH=3D"/sbin/hotplug"
>  CONFIG_DEVTMPFS=3Dy
>  CONFIG_DEVTMPFS_MOUNT=3Dy
> --=20
> 2.17.1
>=20

--LwW0XdcUbUexiWVK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl0LZ/IACgkQ3SOs138+
s6HnVQ//V0AiVK2T4Zt26dMdZRhdje5rcfQvqSvS26yAWlB19a4K+KnSpeO7nTt8
i6xPCg/PJR7n4dZixeneI2T9CbseVldNr3S1pYDhZkauq6BjAdC83QHLsp9Qi7tX
DEFCr7Q7S5Kydzm2qWiHqEH0RkU4uS3aHLYqmQgjwegLS70jCaQZ6YKbgOcPbukl
O8+1Dh62jUJWf4aQrk2td+MtfjSkY3/w+J/ath9tZ2mUgyU3DnLXcX8bl2p2iL3e
v/fxv6TunUNh4qfxNoPxe+RKYV58eYgYdTx4/iYWWBvmuqGGfDsPibgO/PB2aueu
7GZu7HlOyAww4ZZyJZq+V59eusRVVdfOmBYNH0V7s4cZ5uylcXjo0OyVxcPaLagc
+4QAQvFvffG8dJ/EtbECoLMp2Yztw1Uq1SVLnt8MBod7DbAYL022NVBIjMB86lLj
JiWpkweF8hOdUS1adn+j5gsgRVBMR62wBKtkQ8qYx8f4pX0Vl1VEIY2ZnEq44Q7E
e1uqUuVaLcwszTaFO+CEsPDrdvWqUKyu8F01G+Qx+xC8rgh/g6b8AqDNK/y/x1q9
z+3DzwdYbUtxw9G2iL4jk76dNnJnGDAKKiDeEmxeO1qYsxEIHdBgySs/eNHvdoRh
Z1TuJN879ifWwPHgEOB95zZ8Ed5CByYQXa+JT+eDqZuumu8eU2w=
=BWCx
-----END PGP SIGNATURE-----

--LwW0XdcUbUexiWVK--
