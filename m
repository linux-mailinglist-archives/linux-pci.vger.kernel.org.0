Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA8C24CB9
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2019 12:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbfEUKaD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 May 2019 06:30:03 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35210 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfEUKaD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 May 2019 06:30:03 -0400
Received: by mail-wm1-f65.google.com with SMTP id q15so2328714wmj.0;
        Tue, 21 May 2019 03:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rELwzUOME0nlXCIo3VT64vICZ+hEYunauyHNK3UtMYc=;
        b=J49fNcrbf1jjE+Q+vGOqxez9Ao4CNjCedtLwf1SqxU2wwJOJKoEYvdGCMsmwCz5pL9
         xTpqIcvF7Wx3LOP2kDfW7apVSfpppmMEZvS8lMzps3oqI0/3rvePn3lLR5DV5/pjdd2R
         cIuia49ANqKngtTbH9uckKIHfjSSgxKseNLmwXgyp/qTqs/HhIeJ7iNuGtlOUVHxDJ7L
         0ZkLI17STbKVMfw/4ee1VIoJ2g/71jb6CUofBaab+xqeGNXs9keyqznSjYnS5mc60ZGz
         1RUiPGOIK8q5rnIVWhH7x1p00o9689XH6293wxwtIVRo1mYzvo/ZSkz/+qSxvHNcH0vC
         Z5qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rELwzUOME0nlXCIo3VT64vICZ+hEYunauyHNK3UtMYc=;
        b=tQ5hQjtM0lZ1izLfZuNd9Lvm6wDwpECRUdMpGlNgjOap7dKT+7OOTUIZxC+SNmDSaX
         N/DbiGu/RjxFewS7WHbycSTaSnKl3eG3f59kXOPMhWroWfX6XiJ8bm7tXZTSpN1idyW5
         /ekg/G0k+1f7e5/Sdlwf0f4ZOUhQ7Bt7ZS84AorBJ1129bKV3bRr682QVg62cUVtCjoS
         B/x6dLgTpu8RM0rtbPENBTZANtD0a3uqAsztVfrK6ZILmIfloB4zJhJybuzJ/nZCVdov
         tN1lrJ8AkO8kU7xVet/FEwDr25XMk5+eef6QCF5NB4cbUju0E2P4dCRDrf67urw0hvI5
         WmUA==
X-Gm-Message-State: APjAAAUwL8IJ6YpU0WFpENfDMFr7jsWqo2V4cBjdg3HwpZ/wGKfmlXa0
        zIj4Q4/YVwNAk7bHDf4z6J4=
X-Google-Smtp-Source: APXvYqy9UeRYtG1/M1PRspNpKIbKeyoSPzcQxlWSbDUvnaFhZtLU4xlrNZOzT2PDdg4PlNIhhN+Jkg==
X-Received: by 2002:a1c:ef05:: with SMTP id n5mr2922416wmh.149.1558434600856;
        Tue, 21 May 2019 03:30:00 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id h17sm2683157wrq.79.2019.05.21.03.29.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 03:30:00 -0700 (PDT)
Date:   Tue, 21 May 2019 12:29:59 +0200
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
Subject: Re: [PATCH V7 04/15] PCI: dwc: Move config space capability search
 API
Message-ID: <20190521102959.GD29166@ulmo>
References: <20190517123846.3708-1-vidyas@nvidia.com>
 <20190517123846.3708-5-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5p8PegU4iirBW1oA"
Content-Disposition: inline
In-Reply-To: <20190517123846.3708-5-vidyas@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--5p8PegU4iirBW1oA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2019 at 06:08:35PM +0530, Vidya Sagar wrote:
> Move PCIe config space capability search API to common DesignWare file
> as this can be used by both host and ep mode codes.
>=20
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
> Changes since [v6]:
> * Exported dw_pcie_find_capability() API
>=20
> Changes since [v5]:
> * None
>=20
> Changes since [v4]:
> * Removed redundant APIs in pcie-designware-ep.c file after moving them
>   to pcie-designware.c file based on Bjorn's comments.
>=20
> Changes since [v3]:
> * Rebased to linux-next top of the tree
>=20
> Changes since [v2]:
> * None
>=20
> Changes since [v1]:
> * Removed dw_pcie_find_next_ext_capability() API from here and made a
>   separate patch for that
>=20
>  .../pci/controller/dwc/pcie-designware-ep.c   | 37 +----------------
>  drivers/pci/controller/dwc/pcie-designware.c  | 40 +++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-designware.h  |  2 +
>  3 files changed, 44 insertions(+), 35 deletions(-)

Reviewed-by: Thierry Reding <treding@nvidia.com>

--5p8PegU4iirBW1oA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzj0ycACgkQ3SOs138+
s6Et4BAAkzOyahrHoqB04OU7kbCFa+2VAYqoXjgDQvu1RjouQbsh+UdAzNrLWTeX
ChYzsu6i3jeymB0oD/WAOCtHx9SbLP/4YEwlBQ5Y9U5SoHy16bSiC1fJ2+IrTKoj
2G50K3ILtwZHuDFBL9D/NRtwdrGxu4txjtB6ch6sJDKRvr8UbtXvLO1Rija3oaut
31nP2HoCqZ8ZW+Ku7D15BPxdcLYidJJqWELWw251PitQkixGV2JEjv/MYoKBMIhD
jCIo+b5o1yS36PUf5I0Piuz4vbDmiJOUjKsjMbkKniN+l9bBtNwPepBdSxxYl+CN
QbYbDw1mPUBLP/mlhEsMgBGDUp+auR+vMrCsXaK+BQIoLHQeslhKpWwIsGOBZDka
5iNo8zxXK2FC8yHNjgz7sIWI9dfA4dX+8YJEnEVRjuhcQG+aE5B5NXDrqtTMYN1Z
Hoe+q16UNDLmsq2siAD6r7ENyzUVzaCdjg/q/P8v3H7PZWFgPO49v+xZdDq37cqi
j/Z5/gTH0v07hu5dtXQLfQ5+8KszcexKRfkGlYCBYG8BFVTdMmF3sR7XIY4tE2lt
muOCI7ajeYAq/bDP9vibl1O7o7Myry716uTwfGGAB8w9/g+Fm7BKpa+Wj9MuZWtW
CYi8auqMTnAh11SDNQeakXNHranXpLvBhMKpfIBfNYaUDFbjdd8=
=LWc3
-----END PGP SIGNATURE-----

--5p8PegU4iirBW1oA--
