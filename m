Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A27837826
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2019 17:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729242AbfFFPg7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jun 2019 11:36:59 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35309 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728871AbfFFPg7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jun 2019 11:36:59 -0400
Received: by mail-wm1-f66.google.com with SMTP id c6so433893wml.0;
        Thu, 06 Jun 2019 08:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DyRXAwIkACrL75qrkaIpiaUyXrFK4zgAUD6OMPn5KbE=;
        b=g3S2sTxqBXi5WyyBC3kSqRB4jy1/u8zRu8CaUu9B6m1YAV7H2ngfPZ/1L/yjfJqfG4
         Rcg1ScXJJlGFN5bz+QrAH0iXCJ4VfvP5L9a5ehiumq51US+TgIvDDkrOZ+lCxaMXj3bJ
         +bKu0U37sa7xvVg0BHrevd6nIQZjEwe/Pt3VltHUfBlZb4NuxEFlF+J0Y6rn/8vm5r7d
         d9brNEt7L7LPi7f54EQAw7mqjZHbrI9oaQ0UpV0gIbPhnBUnxrCfFj+4/H+RcldEqBbA
         J7IFnBVF48uPXmLNIEvshA9A4XJIfT4tSfCb2sSjwpRmrq0Jeg7fwUZzzcwBMKLnwqRt
         z+hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DyRXAwIkACrL75qrkaIpiaUyXrFK4zgAUD6OMPn5KbE=;
        b=aT1n4/xsKy6uXywBhDxbQruPkiIYceGdK99ksHZpPvmSeGfgBnVYzzjkYaqxZ+6dsM
         NHuKjKQ4Oy9JnPHxXIF5Q75cXXNPqbjVEXlVFoH/rWrXYtnZ/DpF1PUJvJVXDX9/PWDk
         lKtq4EDY2IDOM69BD0oBu1m4geqrMgbPug11LeiwYJM53VdkGr20vVz1WuQBTzaQfw1f
         0IO+8lx04/noI+KDGGwXhuK8BIA0515/laOrB9h4f2DbQmdZ3kmpOsWBqimzWptTCNWl
         DtlBZxyG6lKXWw+X1F/iXhVq+SCkkavwnJMa1nvfpRBYixvvRzA1H3mcOkhQ/BeJUOwR
         909Q==
X-Gm-Message-State: APjAAAV3le4ImTk7pf2uSPtpfeKx3Dl/StNke0IKK+2dNFrHG0RySQK5
        gC/fFC59CHo/1vS5HjnyAjM=
X-Google-Smtp-Source: APXvYqzoIc0HCuMlyYira3wL7A3WbV0QPNSbcpXOCeVTl1Ab6mMnqDsM2t7fldaeLqrPRCvQdP5yOw==
X-Received: by 2002:a1c:c706:: with SMTP id x6mr456960wmf.162.1559835417018;
        Thu, 06 Jun 2019 08:36:57 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id s11sm1697185wro.17.2019.06.06.08.36.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 06 Jun 2019 08:36:56 -0700 (PDT)
Date:   Thu, 6 Jun 2019 17:36:55 +0200
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
Subject: Re: [PATCH V8 14/15] PCI: tegra: Add Tegra194 PCIe support
Message-ID: <20190606153655.GC3338@ulmo>
References: <20190526043751.12729-1-vidyas@nvidia.com>
 <20190526043751.12729-15-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bAmEntskrkuBymla"
Content-Disposition: inline
In-Reply-To: <20190526043751.12729-15-vidyas@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--bAmEntskrkuBymla
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 26, 2019 at 10:07:50AM +0530, Vidya Sagar wrote:
> Add support for Synopsys DesignWare core IP based PCIe host controller
> present in Tegra194 SoC.
>=20
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> Changes since [v7]:
> * Addressed review comments from Thierry
>=20
> Changes since [v6]:
> * Removed code around "nvidia,disable-aspm-states" DT property
> * Refactored code to remove code duplication
>=20
> Changes since [v5]:
> * Addressed review comments from Thierry
>=20
> Changes since [v4]:
> * None
>=20
> Changes since [v3]:
> * None
>=20
> Changes since [v2]:
> * Changed 'nvidia,init-speed' to 'nvidia,init-link-speed'
> * Changed 'nvidia,pex-wake' to 'nvidia,wake-gpios'
> * Removed .runtime_suspend() & .runtime_resume() implementations
>=20
> Changes since [v1]:
> * Made CONFIG_PCIE_TEGRA194 as 'm' by default from its previous 'y' state
> * Modified code as per changes made to DT documentation
> * Refactored code to address Bjorn & Thierry's review comments
> * Added goto to avoid recursion in tegra_pcie_dw_host_init() API
> * Merged .scan_bus() of dw_pcie_host_ops implementation to tegra_pcie_dw_=
host_init() API
>=20
>  drivers/pci/controller/dwc/Kconfig         |   10 +
>  drivers/pci/controller/dwc/Makefile        |    1 +
>  drivers/pci/controller/dwc/pcie-tegra194.c | 1621 ++++++++++++++++++++
>  3 files changed, 1632 insertions(+)
>  create mode 100644 drivers/pci/controller/dwc/pcie-tegra194.c

Acked-by: Thierry Reding <treding@nvidia.com>

--bAmEntskrkuBymla
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlz5MxcACgkQ3SOs138+
s6G/ZhAAjpmV/vx2RYEnxlLLhgYrDv+eJ4c99U63vbP5N/OjnWh9s51GJWF26MbS
y2mW0FgYxsUXm+M3WFBBs7l38iCwYp8bTAahH7i3kEyw+Eb0nv/UMq0DF2t6ESOR
zxA76mLckgzZ0rn7wXGqYVLPU7M0eTw1SGJhz5YTPmR3ghTfE837R1vkfXKV3bYo
zr8V8p6ZsZ5AgaYg781zLnxIhc84iuXMGSpt0n4Bw9T0IX9TBoZvnOKa9kPujQdk
R53voGhAVATSx/c/MuA6TLc3SdKedKdaP8V2POGWZbffTbYT74wa7TxC+p5SlYQu
KcmedzYUsiqAqjG/uIiIG2X2zOqGBgp4Z1zmizaEC6mzaJWEPfZBWz2MXZqNPhq8
l4P2JgOfB8TwF7Qtw18IaIYa26L1Uaxt/604YnSpJJeQxHpXJVgHQ4K+cgENneLI
EWc4RYCr5O0M4q6P6IIyZypKXBtzMd4eCVM0pDlPz6HRInNGNzgFa6DPENWMExc1
V15xEZXmXGwhVwhuqoMmXN7Rd0p+5wSWQFWxKETXf1NETlN5L89s3hoEZ+O9eDBU
tHb1eaY9+wuq56jwySzGst3np9/8VGx+p9u5xE0coTDHSlQbb7XpSe8cfhDSXp0n
3k5kNWWMNn6SGUe3H8P7mquhingQDwZ30PCGTCpfvwnxM7q9o68=
=8lND
-----END PGP SIGNATURE-----

--bAmEntskrkuBymla--
