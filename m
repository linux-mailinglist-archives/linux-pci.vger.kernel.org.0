Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E580A5506
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2019 13:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730442AbfIBLiX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Sep 2019 07:38:23 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34478 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfIBLiX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Sep 2019 07:38:23 -0400
Received: by mail-ed1-f68.google.com with SMTP id s49so15393637edb.1;
        Mon, 02 Sep 2019 04:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Bs2n5sOSnZKXzoAXps0daq+vWvxl2WJKs7rvutsTT4E=;
        b=XPNxsY5QH534cp64SXtvHluzlrL1NvvCKvuVIAkTY6t8H60YdWLXoxqa2sQ9+p2g9k
         xohNmogX3ie67YGH8xuBCV+Hqzmc7IWBYM+OHATG2/QOXCgUkJhk3fzFitBDRVfbVl8L
         VpZqMq2juawGFW8NMF8oWxsmbq7pjO39exiaUGddPAUghztghhwmRu1LrSlApHR0yn4S
         OSmbrQMrA4XfoccFDI1BcOsStlqfjB2uTuVwQUIPpl6GJGr1soNlKLeGiZWdmOyjJZum
         4Ik2TaQFCGNPyB0gVWxonj5gWuISSkbMgOigGQXByeSrtfF9y2AIWzgjLpcey7W7IH4O
         Kh1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Bs2n5sOSnZKXzoAXps0daq+vWvxl2WJKs7rvutsTT4E=;
        b=rsjV20WxKnxjONS+SD6IjtCjVVMBXRIIioUtPXyozuxiJXo/dBOlL7iDbAlWH+tD+o
         3TLOaY/a+Pn07dl0qMEuNlR410Y04SX8U8Nn7+gnZeLbwbJh5WcLbllkbCPYAs9XQ5sJ
         eqRviMumNgo9zJJhgL2TJhDdae8UO7f187D1N/2V+x9++0A4Coi38d49jUY9Ni2/Yuax
         B/3n4i99IkxbvFgeWvUNkRl6SyHwTT1kEVZbcsYDywsbNBBp1M7hgWGunZK+0KJmgpVh
         xtA6BqNQo6EAqjGsjwKKaDiQsHApuVII/uMasqiWGLmZNHBlo7ZpZWpSVc7b/tBXiiJz
         o1pg==
X-Gm-Message-State: APjAAAUoi+F0IAY5JV1AKuwHR4fS8IJRejASgozt8kpjkne/nVStDCRO
        DZ2apMvsiJ0AHIn1dZ5ryJ0=
X-Google-Smtp-Source: APXvYqxmE3s5EZUgIaOzgPLsOpwCF4lBTKm7zDmoM9dVth1ZO/tiUVK+qNUIJarcOaz9ECE9IhEs3Q==
X-Received: by 2002:a17:906:c59:: with SMTP id t25mr23680384ejf.206.1567424300787;
        Mon, 02 Sep 2019 04:38:20 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
        by smtp.gmail.com with ESMTPSA id r10sm2846825edp.25.2019.09.02.04.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 04:38:19 -0700 (PDT)
Date:   Mon, 2 Sep 2019 13:38:18 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com, robh+dt@kernel.org,
        jonathanh@nvidia.com, andrew.murray@arm.com, kishon@ti.com,
        gustavo.pimentel@synopsys.com, digetx@gmail.com,
        mperttunen@nvidia.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V3 1/6] dt-bindings: PCI: tegra: Add sideband pins
 configuration entries
Message-ID: <20190902113818.GD19263@ulmo>
References: <20190828172850.19871-1-vidyas@nvidia.com>
 <20190828172850.19871-2-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LTeJQqWS0MN7I/qa"
Content-Disposition: inline
In-Reply-To: <20190828172850.19871-2-vidyas@nvidia.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--LTeJQqWS0MN7I/qa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2019 at 10:58:45PM +0530, Vidya Sagar wrote:
> Add optional bindings "pinctrl-names" and "pinctrl-0" to describe pin
> configuration information of a particular PCIe controller.
>=20
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> V3:
> * None
>=20
> V2:
> * None
>=20
>  .../devicetree/bindings/pci/nvidia,tegra194-pcie.txt      | 8 ++++++++
>  1 file changed, 8 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--LTeJQqWS0MN7I/qa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl1s/ycACgkQ3SOs138+
s6FLlQ//RFadCCy0+ywuyNwstWFl2JPShvqLv7sExZxKzKf4dNbyo0pVeTDUFWDX
Xs25hc51nQ3J6PSG/U8KFvEhhZjYizZNXlCr0kdFrsaM+NAOejcC2BQ+cArIDb2w
Gq3FBww/kgr1UCbfiDIThGlBgwalXABkZ32vk7pu9TKbDpMZLWyCHPEms6fFwo1g
RhSLQJlMkf7fm4sp1ZFUvzvUjm5lEkqqQreRAfMO7NgVKwziBsrpc2wkNNwHqj9w
XjeQ0hP2pSwKeB6IHGA4JFioQlb1eYhG8dqTAQem7qV0uOV9n2oIE86GgjiBXqea
F3LiggKv47SQFBbyx/0TofZW3UVHWgtPlbZm5dIb/qPreNBX4/CKyAIZhn2Nt073
pj4IZdllTRlPGchj0eW9a6W4PKOz/q/ZksK1kWjbw3yd9oKI7gpePqOoed416ALO
5sVkOi1siz7sIyj/VowG7rRfPC/QqRtoVGVEYHtrdox2cPqjvXb30uCp8hqB9PZ0
gXBVi/b0kWfAzl1S5Bwuh2WcXSkNEaUtSC4mnNLsbgiSA3P4qszsb9g4GZwrVN5T
TlrWTAk7Hsm8AefUMM1SxseUH/VrkHnWDBEuN/K9t620vz8lyWCLcyAj+UdAWzUZ
IXXXM7Jy2zYyR319UK74mkMxGokz1Pue5oJLciykKIyy+g9cDMQ=
=eTUT
-----END PGP SIGNATURE-----

--LTeJQqWS0MN7I/qa--
