Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4B1377FB
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2019 17:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbfFFPcV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jun 2019 11:32:21 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45353 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729045AbfFFPcV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jun 2019 11:32:21 -0400
Received: by mail-wr1-f68.google.com with SMTP id f9so2872809wre.12;
        Thu, 06 Jun 2019 08:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HX3M9WP/yryEwh7vX9+9JslPgp+IEmjuwN20Escc6kI=;
        b=EiUYU8vhWxjAAxHOvDowkjzPhStcE3hELrYCWJ27QKnAI3cJFbwKgtz7SyV1Nlh3G7
         aKbxXLDNqFCQSrvPmzI/x3zqIs0RocRokH+TItX8e6zy93V4TnYyK/nIP2w2Y6S7lRVo
         oZJ4TEeNTAS/ojkuEzag0RiCf4oljXXX0x2UYQCurM8wg06qcdiQEy4if80rprzE6bxU
         SF6cJPZYyqtGEpnSdRQA6IUtwIspXawWvs1aJfxPF+HOkXeQWSXbgX0pIGKa/VFQ8tlQ
         pzv9iGs8JLuDdIXwcI5hSvQC4MriQbkxesUfvwPoK6G4JUCi/wGL16z5n3RcdBgnCrVT
         fEVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HX3M9WP/yryEwh7vX9+9JslPgp+IEmjuwN20Escc6kI=;
        b=UYjgwLOgIz+h36gk6C625AoevCIxXiuHNhYHAGaZGsdQ5o+UdUwBUnotpQYOWqg+6x
         eNHDqahnTc1o2wcET2a7jWSL9NtSJ2ELO1rjavMzIMD9MfC2eOqG4zApAgM7q12oL8Hk
         KH7N/oMYbs9DSDy3y+emap2sctTveeULzJVMMDiY1vAxXYTlLTb0XmQt9q//fehN6Oe2
         9kAiycEXt58uRmmibC4vuLvWJXFZyWC8u5cMhRB6VuXLoegwGzdQApsG+ag5+9HAFbeZ
         04YgKeDSxQeKC/NLyDsYzPcPPKrt69NMCEzkphqfpOCABav7f4mOjHWvf6MHg/Yfztuc
         i6wQ==
X-Gm-Message-State: APjAAAUiypPM1X5SjUtWiT5Iqc+N5dSs87JAFaf4L5pHLcCOK91YvUPx
        7Rsy3usGdQ+SF1LZuvX+t2o=
X-Google-Smtp-Source: APXvYqxRHVyiOMsBJdAL9QEQxw+Px16GqdTmA3UJBr61U49dfLm6pC0vNkSsniND2XvWP2wLGn5EWw==
X-Received: by 2002:adf:9dcc:: with SMTP id q12mr3836539wre.93.1559835139048;
        Thu, 06 Jun 2019 08:32:19 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id c129sm2082954wma.27.2019.06.06.08.32.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 06 Jun 2019 08:32:18 -0700 (PDT)
Date:   Thu, 6 Jun 2019 17:32:16 +0200
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
Subject: Re: [PATCH V8 05/15] PCI: dwc: Add ext config space capability
 search API
Message-ID: <20190606153216.GA3338@ulmo>
References: <20190526043751.12729-1-vidyas@nvidia.com>
 <20190526043751.12729-6-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
In-Reply-To: <20190526043751.12729-6-vidyas@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 26, 2019 at 10:07:41AM +0530, Vidya Sagar wrote:
> Add extended configuration space capability search API using struct dw_pc=
ie *
> pointer
>=20
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
> Changes since [v7]:
> * Changed data types of return and arguments to be inline with data being=
 returned
>   and passed.
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
> * This is a new patch in v2 series
>=20
>  drivers/pci/controller/dwc/pcie-designware.c | 41 ++++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-designware.h |  1 +
>  2 files changed, 42 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlz5MfsACgkQ3SOs138+
s6GApw//TPvpvgBzP5P9ZA+voryvcGrZFDGOvZN3Ue1+gcsGJLKWkkyfdki8Xn4K
pkOboAWOYl3FVFstorO6OlL+sToBPM7KSW3d1y8Xf4lCJG6pl6Wguq01rQiL+lgC
SiHzhKaumTJ6cIiZICbExS0cnWwgNvglaMRV1enwe3SfAdqpiSBJYsJy/OFgUHMX
e8P0PX0CY6pK+lGGi610SRhzorXOne+ukTGgm+qrAU/9XsJWkF9uwyaJF7BprSfq
fjPGMQlZ+ezB9sZn+RAJT8qZpNsovOTLDWV6P4b+bR6hBbHNM3uOFlnpOUsKfiLL
YJIBU00ZlbIIOMMCK/78Xg2i9GsndiLKmAF8XYeNcGKfHOyivoABLViL4eL98yZl
VMEUTSMw97RhAoZ9DgD5M5ESFEAbD0qvy5GoGW7OcJ3JyvJam6hr2nFDIqyAuq5G
W5w/opznB6oYuiyvTWbH2BYTKdpZv1IMZTLRsq1o8yQHCRt/L7GemvXGWm+7UhNJ
hPIFoLR7bvYE/wHvnplHw72iXh55j3/Ku2oBCgs9Ikx8Q64XWDSJQBwqNXwT5pW4
2qcCVbs9kcdOmuhadUJNE+Aeyz32+7GC9JS5PIrtgvCrS9GlYWg6pjGDqMy4lzJ0
fVfLAxMTiKwPO9jr2SOY8TIfObb7fXzKGB31sBPvCV2tRUpK0OE=
=DlKq
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
