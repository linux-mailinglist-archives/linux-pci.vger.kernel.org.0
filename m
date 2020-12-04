Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4AF02CECBB
	for <lists+linux-pci@lfdr.de>; Fri,  4 Dec 2020 12:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbgLDLHP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Dec 2020 06:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbgLDLHP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Dec 2020 06:07:15 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF8FC0613D1;
        Fri,  4 Dec 2020 03:06:34 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id ga15so8110000ejb.4;
        Fri, 04 Dec 2020 03:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kldJ1dpmgt7DHBI1NtcTNckT3IjniUAs6X6u3gDEU6k=;
        b=tX7zEhkCJUC1oiVlISCuyPIrwW8fWjPk/i5ZVCkZ0KzxI2F7Bv23s9X52YUlsOZ9WK
         sbquRTz8Dqxw4b629HNyoglweZiwuihwJ15ka5nb8c5FqAG/boLlIeV/7jIJcbzM/Ib8
         kZqWwgCLJPL9QaFl+CM6HtIXCFNNzJLDpklsh1/AaCaCgzSYKGzSWXxla7IlnQ8L9oJ2
         zl4VU7Crz0r3eQnHP+dY5hc8rrZtCcAeIhN+/neK3EsuyRCZYANQknxkM8kJgTq7Oump
         oeuLSRmtsp8XQlkPhtwWVBOWWs8WK9NPJ8bTB0cBAOi1WE5JwWJGLAOvIZnBalKR0Ps8
         1z/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kldJ1dpmgt7DHBI1NtcTNckT3IjniUAs6X6u3gDEU6k=;
        b=W1DNu5yGojvXF2uMFsKj0uaXj2WErS1iaLmAoA84GdxJmDp4Ckl4dPl7xxgGovlhiN
         eve98pVAR4GbJkU1Xw61Frn+Zv5oM8mfsLJKu/6WtrXfXWMj8452ZlJUj326vM3slUO/
         4LdNWMC8U/bABF1vaNciY6fmgxUMNW05YW/9J5NCwxdEBYKuysjqYQMSS5byWFVn1nMJ
         eKcyzoP3B6Tz9p2YTr0M87AJl0DEyEYNShXf5E4Xj+0VVcYIHTuJ5BB+8XNNU1FQpB1x
         7rfI5ZPiJIvnEykoT0ZCnQJQuPyJzzWeSvwi1jnaFCv1k5WHEYRCz5tLoYyqtVAxT2EW
         UF7w==
X-Gm-Message-State: AOAM533qC5Ai711/VFZ/dwN5arpsUqTKdqTKbs1UlV7x9wT/MHyt6kDI
        MkV6k/JCHYwNCnU6SOSaAts=
X-Google-Smtp-Source: ABdhPJw78d5cn2EtsUvduOwFk0qMZrhWfQf+zxXB4v0amneCBSbOl6OhWltXtdlumXv2aqcU2Xz2DA==
X-Received: by 2002:a17:906:b56:: with SMTP id v22mr2820904ejg.145.1607079993561;
        Fri, 04 Dec 2020 03:06:33 -0800 (PST)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id x16sm2839368ejo.104.2020.12.04.03.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 03:06:32 -0800 (PST)
Date:   Fri, 4 Dec 2020 12:06:31 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Vidya Sagar <vidyas@nvidia.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krishna Kishore <kthota@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        Vidya Sagar <sagar.tv@gmail.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v3 2/3] PCI/MSI: Move MSI/MSI-X flags updaters to msi.c
Message-ID: <X8oYN8KWqiuaGDDZ@ulmo>
References: <20201203185110.1583077-1-helgaas@kernel.org>
 <20201203185110.1583077-3-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mFBlB9FWkTiJOBtm"
Content-Disposition: inline
In-Reply-To: <20201203185110.1583077-3-helgaas@kernel.org>
User-Agent: Mutt/2.0.2 (d9268908) (2020-11-20)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--mFBlB9FWkTiJOBtm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 03, 2020 at 12:51:09PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
>=20
> pci_msi_set_enable() and pci_msix_clear_and_set_ctrl() are only used from
> msi.c, so move them from drivers/pci/pci.h to msi.c.  No functional change
> intended.
>=20
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/msi.c | 21 +++++++++++++++++++++
>  drivers/pci/pci.h | 21 ---------------------
>  2 files changed, 21 insertions(+), 21 deletions(-)

Ah... I suppose this cleans this up a little more. I have no objection
to these helpers, though I still think they are a bit unnecessary:

Reviewed-by: Thierry Reding <treding@nvidia.com>

--mFBlB9FWkTiJOBtm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl/KGDcACgkQ3SOs138+
s6GFdA/8DQbrQFz/PGTIurlTAZUWC9vzFGNUReh1//jC7qO7V4yzXni5+ri4yAs2
JKfbPkmY3+f8n9LV9++NGa9LMyRDKDOacSttyl9O233QIQmcrejFHUvFD+YDh/IP
B+tgSmyN1kSMwNfIFVqTy+A1KQ6uRCa9m/5DSSOUY4rRPhCpW50nRtkSjrLD0qgj
V79Y09mJ7VYrUCc04QFGsk0xYT1+YO617FZlqy3/9U2lPxcUlyGzF9+Gvgo+ocRY
U7w6s8hVAW+S/7jE+aiutuLRrlfCgkeq0N+qnkNfZUpRSOFIMhAUZq7FT8w9Z91V
KZOHKDqazczcJxZc25mePjtyHBxrH0+dNFsP3zDWOAO3VlL35ljyeIgDUVboEqEn
j593VWO8Qd7n08SUEr4+Gq+wfQuJYXwM6W2l6uPylzs982nrgcPkFcMPclk2wBFw
vy23vx8X42t7sA33YBcu5c5B03SYeFWPfR0p7OUesRGvdJtPAcgVJqXN91vJwc4k
67A22Z8h28F2zb8OCx9tvsr6TXQTqSR3dQL1SjlPt5fy3rmfXO3QcyOkBbuwNX0M
Xm67tj06/09MtrbOaNo6jnp3/5FCuezsILyvFI9Z5CoysP4MF/MK3sIJXFi5qJQ1
oHcU9dIMAVP2d8/WZg8LBPF/YMwkxcDi/vWL+rqNIrayBydSxfs=
=T9+V
-----END PGP SIGNATURE-----

--mFBlB9FWkTiJOBtm--
