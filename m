Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF1C22C5316
	for <lists+linux-pci@lfdr.de>; Thu, 26 Nov 2020 12:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389098AbgKZLei (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Nov 2020 06:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729812AbgKZLeh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Nov 2020 06:34:37 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA2BC0613D4;
        Thu, 26 Nov 2020 03:34:37 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id a186so1848142wme.1;
        Thu, 26 Nov 2020 03:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LHMrZYQSpBWE8KyWLwu7SZUG92Z521sLF1XKsVV5/ZQ=;
        b=Akn8QULDOMymmpBvL4moJ0rUwM4KzBv7vR9/bMxB6j4BP8EnR0RT4vM2YYL6c+YR1D
         tLP1q0Ovqzwxfzc1OvYn42PmgjR/rW2fPwSRXA05kpf9FHJ+OGQ1jdSJL1AY8tUQxO6P
         9gi2xmW4zhFzOyIccmNMCtHJRUM6RBZO1ob3ceEV9bvqWWsjQNttjK5MBLeVAUYCKp/R
         c9bfoxqL9NH2Lc1/m5+EmLgsyDZ6V7oK1uEzkPbZ/6wbX3b63ELjLKbXA+pAMVlc5sdg
         a4som28Qx2ZkzXaJGY6IiHjXKdCkfP6yuugyBcziyknf7bL/3yHy6uZZnAEf/AWfWZVt
         2Rbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LHMrZYQSpBWE8KyWLwu7SZUG92Z521sLF1XKsVV5/ZQ=;
        b=HD8OK9/Gd//bZ63cJAZAQoY1ynlEhkzumGe0j5+jg9qKZzqhX5GxFDDwy8oGj0WTQG
         ubrkT93yVrrQufVOvSa+i6n6+IMQ7E/f94Hj5AQFSiuK0n1D2uCyR5rvLgctpaAb2bRX
         LvS/BBrqd4uo5wSa8UK/1NS8U/0jw9wT8uW0XZX4VG+qc1q6GRzwZ+TKbCMZ3LF1fun9
         u3UUGFJxAQ6wOcW/1Inafy8XMAyrgS8HR043NdhWsLXFs4PRUpj7SsgQCMXPR6TSgcA9
         pNkIDi+rOJp1s4bhEiIhijji+yciV7cEqrlsDDtlYwGTNFOSUR4K4A+mmBII0eeT78as
         8f+Q==
X-Gm-Message-State: AOAM5308hiW5AvYQ20OYtkpKpJTvOmINVDbUytPsPZ8UQpwlSeF6nnKG
        M9wZrhxjBeWTKsr9nSVoM/A=
X-Google-Smtp-Source: ABdhPJwB+AJVfv9TVZ+zFl+NJsUna1+N0PrJ72whTkDQZqf4JR/DfSQPvcavy97tLCcphPqNxTze6A==
X-Received: by 2002:a05:600c:218c:: with SMTP id e12mr2906036wme.28.1606390475985;
        Thu, 26 Nov 2020 03:34:35 -0800 (PST)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id s2sm8189990wmh.37.2020.11.26.03.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 03:34:34 -0800 (PST)
Date:   Thu, 26 Nov 2020 12:34:33 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lorenzo.pieralisi@arm.com, robh+dt@kernel.org, bhelgaas@google.com,
        jonathanh@nvidia.com, amanharitsh123@gmail.com,
        dinghao.liu@zju.edu.cn, kw@linux.com, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V4 4/6] PCI: tegra: Continue unconfig sequence even if
 parts fail
Message-ID: <X7+SyTFHOaAchPMo@ulmo>
References: <20201109171937.28326-1-vidyas@nvidia.com>
 <20201109171937.28326-5-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="88F82UcEPkRGOirN"
Content-Disposition: inline
In-Reply-To: <20201109171937.28326-5-vidyas@nvidia.com>
User-Agent: Mutt/2.0.2 (d9268908) (2020-11-20)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--88F82UcEPkRGOirN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 09, 2020 at 10:49:35PM +0530, Vidya Sagar wrote:
> Currently the driver checks for error value of different APIs during the
> uninitialization sequence. It just returns from there if there is any err=
or
> observed for one of those calls. Comparatively it is better to continue t=
he
> uninitialization sequence irrespective of whether some of them are
> returning error. That way, it is more closer to complete uninitialization.
>=20
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> V4:
> * None
>=20
> V3:
> * Modified subject as per Bjorn's suggestion
> * Removed tegra_pcie_init_controller()'s error checking part and pushed
>   a separate patch for it
>=20
> V2:
> * None
>=20
>  drivers/pci/controller/dwc/pcie-tegra194.c | 39 +++++++++-------------
>  1 file changed, 15 insertions(+), 24 deletions(-)

Tested-by: Thierry Reding <treding@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>

--88F82UcEPkRGOirN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl+/kskACgkQ3SOs138+
s6FRXxAAkGRigbdoBOKnM0ls2I7F3/4agtBW4wMRk2OxpVb8iIIjSKZw7Aqd/0Y8
Z2erjVDK8e0okun22p9Irf0oieq5z2orh8X5S1T0izOKXCFsGu97Vk9UKfWZI0/e
PGfERH4L5yVgkiHYSwl9byksmf454fvHRPQdbT/UjXmqlpbgqdPIMeBxsxn+p6pj
3zkaJ1BjsT7Tw5NUaw756NEOsKtm/K7uXDFZwGklGBfhA5vi6J0ABTOWzoHpOrXr
OOa+nY780Aq5xY355ZKc641f6FfgPvmUDYfKBCh1Vv2/OGm1bOM2ejG02Bn+aOzX
71mGBNgeZWvVGDZMvyn+iLRlLCe3Mf6JpTkFYzQOQK1AdYO71gK8DClzQsehE23V
IZKBJ22MluSDRzQH0RpmHFZeKPY+zCG836XXqJTlxSUSUdVpAoWA3r5RyR7YiHXb
gL9VrsBSstob/zS4jkkWEkwITGBBD1Yix67XMWDLp30MnembSbPKqUmJxZQ8XLCj
VDCBEaUrVKwOXlNKQcZKTabhHM1pgCVPSHNmqlaqhpgY3tvkprxA5pguHlQKa26f
Irtp4gxqtOAKdSzWIB78VnicWie4dDRSCu3qY/tvwA13panBzDJPds+bJUxO4ayO
H7PqzzmIK5NaVUCM0e2wSSQzgBuU9NKZKqaI9A4i8xJ+Ng8lN2c=
=zAZa
-----END PGP SIGNATURE-----

--88F82UcEPkRGOirN--
