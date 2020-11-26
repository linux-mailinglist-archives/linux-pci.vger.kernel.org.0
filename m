Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42F4A2C531B
	for <lists+linux-pci@lfdr.de>; Thu, 26 Nov 2020 12:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389421AbgKZLfF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Nov 2020 06:35:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389343AbgKZLfF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Nov 2020 06:35:05 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED34C0613D4;
        Thu, 26 Nov 2020 03:35:03 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id z7so1789046wrn.3;
        Thu, 26 Nov 2020 03:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z19SPR6q6e8Z9xOoOmzg+BC0gL5sGSxj/oGtziiuYnk=;
        b=l7Izq4ml+1f2ymIxiuDN4cgzVb9JASeqNvJpmeMOUNV2iqF147AgiaO+5sD/7fs55V
         SrfZsFc+tpUi+BVtQ0zKRjH2WTPSPahCAYsdbfQ3hy1ZuGuEB2HSiDoQRo2GG997o2BB
         AMoMixXRvuksK99nWzp8/WbDQFOk5V6EIQclCUhtzzPdslHswGP9EaBjxicPJZdrZyuT
         garek/Te++SZZO3lDs074Et1dWpNLEdQRUaQ5QujE6mxeuAxawHjSm5gdPUZl8N6I9SW
         mWIlkxMrGmGlcaSdJLG2mjRwW9sSDqQdjtqQR32E6gtRDXTRPjZF5kA/E2YK8PTTbaEz
         X75g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z19SPR6q6e8Z9xOoOmzg+BC0gL5sGSxj/oGtziiuYnk=;
        b=dD6vY9/7xOJiyG2TOTOg69gFRdVufM3Saa+hAqhr4FN/9TCSnUhMpaqWkOW+US2KFN
         q5hQLjlrheJK9v+H/ts3ZcklUQZa8tN5rqdqJ6yAZIgo1AXWt22PGoYjbwNz99YH00WL
         WAeCIHqUGIssslf7Tb5+MUXFasfmFjS6+beS2zYyj1954BvE8meslTirYQCEQGrh1xgn
         qzIKcmNfWeFN4eOidil33rBbxgctr8DBmWWKxwu2yvOXDjAuiAqPliDpINjqhPsxbYAK
         7N5zhSulM1/nWNutF3WD5kChyTZZKl7kBtKniHtf7FddKF6pbwZ7gNNhs+tE/AmEiZf+
         Imbg==
X-Gm-Message-State: AOAM5312hv2GaYk8gcI8lD+kiH22y6OKyIZgtvL0tQepBMbYgV8Ckour
        P5gFEIUxe8QjZvrIU9OJDeQ=
X-Google-Smtp-Source: ABdhPJwZXHg4ZJWcakRzIulaHmsv4hAGkYwZ41zkrRjyhjdWAfGZONYO6etLS0xyYGoR8ShgdGLHFQ==
X-Received: by 2002:adf:e544:: with SMTP id z4mr3401462wrm.83.1606390502518;
        Thu, 26 Nov 2020 03:35:02 -0800 (PST)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id 2sm10188934wrq.87.2020.11.26.03.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 03:35:01 -0800 (PST)
Date:   Thu, 26 Nov 2020 12:34:59 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lorenzo.pieralisi@arm.com, robh+dt@kernel.org, bhelgaas@google.com,
        jonathanh@nvidia.com, amanharitsh123@gmail.com,
        dinghao.liu@zju.edu.cn, kw@linux.com, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V4 6/6] PCI: tegra: Disable LTSSM during L2 entry
Message-ID: <X7+S4zQhxaS8tAcd@ulmo>
References: <20201109171937.28326-1-vidyas@nvidia.com>
 <20201109171937.28326-7-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DJczW5l7OJTAN39l"
Content-Disposition: inline
In-Reply-To: <20201109171937.28326-7-vidyas@nvidia.com>
User-Agent: Mutt/2.0.2 (d9268908) (2020-11-20)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--DJczW5l7OJTAN39l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 09, 2020 at 10:49:37PM +0530, Vidya Sagar wrote:
> PCIe cards like Marvell SATA controller and some of the Samsung NVMe
> drives don't support taking the link to L2 state. When the link doesn't
> go to L2 state, Tegra194 requires the LTSSM to be disabled to allow PHY
> to start the next link up process cleanly during suspend/resume sequence.
> Failing to disable LTSSM results in the PCIe link not coming up in the
> next resume cycle.
>=20
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> V4:
> * New patch in this series
>=20
>  drivers/pci/controller/dwc/pcie-tegra194.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)

Tested-by: Thierry Reding <treding@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>

--DJczW5l7OJTAN39l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl+/kuMACgkQ3SOs138+
s6FZFRAAoKuhItsnD+04VnXQVd9OUoqSlKDlETyOKeRM2QXoffIKz2Ls9oK8hjCq
ff8dclM/AMZYYklT/Qg3VQrU2Duq2VDapMXyswUernO5cTSk62tciOF/pPc+BuBA
ZRSs9swDi5O4LhcCmWpMYaP+fx3ZqexPczpVc/GYOMZYF/mGr0U8grZpONmCeX0K
x1uc85AWb5ClCkBpe/MVxNlfCoiMJW8hIG7SndaJUxLxS+ggAVpARW8IcSGqyS0z
9OwyB/II4sb3bHBFXlg2g/g4wO43i8XQTO/ufGrBRnvTRCGWDu1GSIvDdKvU6udV
9MkNKXRROJMLK5d5VXLn5xHR8sDX0RhGv2zjJT/UF8fn9xoJewsLJbemogI1O0j9
1nFOwGyWgQ+wPvbLtHSY2J2VjI3mVB8oraNpAlN9o47wScKKHMOGKfVDL+UA4LBx
mRGH9XlLdx3blfmN0w6X5bMTupyEtHsOx7mKxugos7fv1+z9QQbR+zEuoSV3U6av
jU6aHu0uxUL0jVgFJkg+Wjut+XAXGbZekpy6HL6vF4I0tABqSNM5np59J79qzUEm
n1SLWEJgu3YlFfAvMicDHo1Sglo3V49By4gNG7rRUY2eGQBi7M4CAezg6Zrx9s7A
BCyoqf/xl0zQJYHTVrSRmGvrnP1QUAtDa4k6ptHBIafpc0j6H5A=
=p4tA
-----END PGP SIGNATURE-----

--DJczW5l7OJTAN39l--
