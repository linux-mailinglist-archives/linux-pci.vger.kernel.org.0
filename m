Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6292C5313
	for <lists+linux-pci@lfdr.de>; Thu, 26 Nov 2020 12:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389294AbgKZLeV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Nov 2020 06:34:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389236AbgKZLeU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Nov 2020 06:34:20 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845DFC0613D4;
        Thu, 26 Nov 2020 03:34:20 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id l1so1774880wrb.9;
        Thu, 26 Nov 2020 03:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ulDq7v7lHLWv1M0V9rz/VFpKInkpDq7zaTGoD0ZV3yI=;
        b=lUXu9yb2rAuSDcFKmyiYYxWhxRz4KtKWDQhznWdQkA5DRO85+Ig9Ityj4NXIhvgb6V
         1nFTLFpV5qjaGwXlTLHGEOe1nk2HeVGYdzoFZO0H+Xj2vcsvtiDRZF7trMEFfm5sRMqd
         ydvdwMY9kMeRjUdHycR+AMoGR7Zyl8BN5uApLZMcxaayy/YhRHS5j0m7MubrtSVCo6JH
         CK2FuzLOcXWeFBHRJ50GQJd3nL3q5svnbtL4ocAW3ZazGDgsKoKTYe+69yXPtCnGP2rm
         0xjMy+JXISXsZ68Z4/BbdMiEMwK78yjfZ80Kyq99POlkBiKOqbu4p3maF8qBwn6cyWhX
         3kTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ulDq7v7lHLWv1M0V9rz/VFpKInkpDq7zaTGoD0ZV3yI=;
        b=ZAzudz51cPCuxye6WiMz0Wne06XWEhnGf9pUHVy9EgS9B6jyC9gtFrSZR3i/qPTKq6
         U0WUtpLjXRaT4x/k4MuKxhW2kdPEdQSnchFc+ErzNjxDtADr8wgHWkPfTLdctYnA0N+j
         xMN3kLH/NHR6TZgd4IQGqGBg92gLHigy9SRyHsh8hk4s8GM6KWNfzzORMpDIzOPT6lC9
         Dsl7j7EROHiF5Mk8mjRx/O90JgLHk+e5IvgwsVBbZlHn/Xw6/WNxC5z86slvEAexwMFP
         YqMNpYDtk1yjD7zbB62eq8uNGmnx/nSNTTtyIT+HChLyXHPHKJ8WlS0X5J7PKaDnQYbP
         1xpg==
X-Gm-Message-State: AOAM5326IbvbrMIjPH+suOQ4nZdhwWnHVn/Bn4gm+SZNa8vXdL7GKTjK
        mvPIA0nCOpfWkhVC+qDY7TQ=
X-Google-Smtp-Source: ABdhPJxpLKdEI/oe1ECAimu6ipEAGjBp89pCdc3PnrXO7vRRQlBHv9zwb3g0MPUkPe4XoWF4iPHRrA==
X-Received: by 2002:adf:f2d2:: with SMTP id d18mr3424555wrp.302.1606390459322;
        Thu, 26 Nov 2020 03:34:19 -0800 (PST)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id v64sm8302145wme.25.2020.11.26.03.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 03:34:18 -0800 (PST)
Date:   Thu, 26 Nov 2020 12:34:16 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lorenzo.pieralisi@arm.com, robh+dt@kernel.org, bhelgaas@google.com,
        jonathanh@nvidia.com, amanharitsh123@gmail.com,
        dinghao.liu@zju.edu.cn, kw@linux.com, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V4 3/6] PCI: tegra: Set DesignWare IP version
Message-ID: <X7+SuDlQT8KsjWhJ@ulmo>
References: <20201109171937.28326-1-vidyas@nvidia.com>
 <20201109171937.28326-4-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EAzNrQ/ljAbTysXt"
Content-Disposition: inline
In-Reply-To: <20201109171937.28326-4-vidyas@nvidia.com>
User-Agent: Mutt/2.0.2 (d9268908) (2020-11-20)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--EAzNrQ/ljAbTysXt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 09, 2020 at 10:49:34PM +0530, Vidya Sagar wrote:
> Set the DesignWare IP version for Tegra194 to 0x490A. This would be used
> by the DesigWare sub-system to do any version specific configuration
> (Ex:- TD bit programming for ECRC).
>=20
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> V4:
> * None
>=20
> V3:
> * None
>=20
> V2:
> * None
>=20
>  drivers/pci/controller/dwc/pcie-tegra194.c | 1 +
>  1 file changed, 1 insertion(+)

Tested-by: Thierry Reding <treding@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>

--EAzNrQ/ljAbTysXt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl+/krgACgkQ3SOs138+
s6F7iw//XsOlSVzGY1ZP79AjdtGhyXCoUjzn6FUjoucQ18Ow33vKJ+9v7R5ghRul
np5dppe6nDcFulKhJoUbSIklsuEnculX7T6Ec1G2TdY0azxrvRFaotpyKSN5JHmY
4LX0OtWlgj6OAE5d4zr+fsTV5jxy90/VfvKEJWPZPbQU3Om+uzVUcTRIBgeWsowo
FBRm/QPcmkN8YM+Q9ZXzIX4Lx/k7zdZjxYOkYvPl5Mn/lMIXA2L7ae+4e7Axa/Tq
//y9/e07nhWRwU51aGEU/La8n9dFrfNlqDTrNTCiLtdaCQl6DhHPEuLP7bHqSZgN
5aGtCfFpsgqqlE2YtJ5UfvA3wl4z0GYG6FKtEBwcwrTI6DXreVLEkxMquWCqE4mS
FKV8GdDE55cwlONu/vvfCGjZQyyAnptQlIFjgZ1JAI2RvpcYUHCk/Ef3yR4Qzn3N
ZSlYYthdMhE3CiJnAyVdzUUQa75Wm9PDpxWh27zfwsdkWQkc1QdaIvzXMxv9QLuj
vvH+tSUpi3s7TVcqd2Z4t5dfvNyLEnBwOQ5Ph6WKgG2L7h1Iv+lOY8Zv2h/fSkoS
glbOpw1JhutEFKmmBSzMcxiHknWL8+r45HKysEhhWQy7tsoVpBxwecjB3sqn/pRx
jv220JSJqXYfOlSJ489tWH+C8S4Xzb4+m9ABKqXA3sQOAPE4OlY=
=qg8p
-----END PGP SIGNATURE-----

--EAzNrQ/ljAbTysXt--
