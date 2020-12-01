Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC3042CA586
	for <lists+linux-pci@lfdr.de>; Tue,  1 Dec 2020 15:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730834AbgLAOZJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Dec 2020 09:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729083AbgLAOZI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Dec 2020 09:25:08 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68408C0613CF;
        Tue,  1 Dec 2020 06:24:28 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id y22so3524730edv.1;
        Tue, 01 Dec 2020 06:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rMaczZz3F2b2Ujyj8LLGrM+0aK5nS9GJNY08T7j6uOs=;
        b=o1IEm/1xLUTk3YAvobHtX61owC6BxYTGclPQEvFgRSq6xfI4uv8qbzFwe6PxQcACsp
         sUcsjqELr1CQemk27rLVp5+NT+yhckzvj4sngML0eWVa0b1MNPfq2FzuO1jX9Mk2RGaS
         G+5VHQ3mEqzwWS8n2HNEVEaG03EZR5MuCC9EZ+0LwBOZzMxJmcVH/yLa0xljatwMqrMc
         yrGh451P7i9zivuRLB8EAZCWMmJPObwsqpcgW+4JcQFnlfXL79X8FNWvJjX3Ghg3xfVU
         H3NzL5BGqjjp4euKYwYMwKDNSPwVjTYUzpPI75bImQiUpuzzQpELmd4eJuryCc2bUd4T
         1EVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rMaczZz3F2b2Ujyj8LLGrM+0aK5nS9GJNY08T7j6uOs=;
        b=KrStr8n5Q/hMD0JhYwvhESw3Y9/041Ibu7gCVU2uEE9sRRWV0vs8G9u2P9anw963wp
         EfWm/tXKEVilgoT5akz6MRNYacXMuiK9GVk087UZs+s/6w4D6LDrmpwRNHGiJubZXtCD
         D0r2K8eyqdPYGslRZQ2KCF7ksFopg67kshstc2n1C7FKdATXMxiQGbv8bNxVFEzABmNY
         Fps/qEBbztZAKGC/7gjLF9OM3pmHRuwt1N4idgAOQ7P6HmbZSYkiLtqfiM9zFIWt11rv
         rc25lyFY20VTGK71nLihG5Tp2XYLTFcNHU5hmiLG3VvAOI3yVnZwbnW+U0PA8zMkgaf1
         bEtA==
X-Gm-Message-State: AOAM532DXmAo1iIp9jR8D0OMo+9XpGmmi+/SvDPX2+E2VmaIRd/EuHJ9
        IFa+QGzUHvIY6borFbStqWwgmUmPqxM=
X-Google-Smtp-Source: ABdhPJybpmPSuQPlnJ3jwcOIABm4FhUW/eH3DUAXnaJ0RD4eLrOdJR31u1x095pdnxyp3XsE6H5AtQ==
X-Received: by 2002:aa7:cb4a:: with SMTP id w10mr3226084edt.343.1606832667045;
        Tue, 01 Dec 2020 06:24:27 -0800 (PST)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id t11sm910827ejx.68.2020.12.01.06.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 06:24:25 -0800 (PST)
Date:   Tue, 1 Dec 2020 15:24:24 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Vidya Sagar <vidyas@nvidia.com>, robh+dt@kernel.org,
        bhelgaas@google.com, jonathanh@nvidia.com,
        amanharitsh123@gmail.com, dinghao.liu@zju.edu.cn, kw@linux.com,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V4 4/6] PCI: tegra: Continue unconfig sequence even if
 parts fail
Message-ID: <X8ZSGCdp3lqORsPh@ulmo>
References: <20201109171937.28326-1-vidyas@nvidia.com>
 <20201109171937.28326-5-vidyas@nvidia.com>
 <20201130121007.GC16758@e121166-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8ArMwWOicASd/TWL"
Content-Disposition: inline
In-Reply-To: <20201130121007.GC16758@e121166-lin.cambridge.arm.com>
User-Agent: Mutt/2.0.2 (d9268908) (2020-11-20)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--8ArMwWOicASd/TWL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 30, 2020 at 12:10:07PM +0000, Lorenzo Pieralisi wrote:
> On Mon, Nov 09, 2020 at 10:49:35PM +0530, Vidya Sagar wrote:
> > Currently the driver checks for error value of different APIs during the
> > uninitialization sequence. It just returns from there if there is any e=
rror
> > observed for one of those calls. Comparatively it is better to continue=
 the
> > uninitialization sequence irrespective of whether some of them are
> > returning error. That way, it is more closer to complete uninitializati=
on.
>=20
> Hi Vidya, Thierry,
>=20
> I can apply this series (dropping patches as suggested by Thierry),
> before though I wanted to ask you if this patch is really an
> improvement, it is hard to understand why skipping some error
> codes is OK for device correct operations to continue, maybe it
> is worth describing why some of those failures aren't really
> fatal.
>=20
> Please let me know, thanks.

As explained in the commit message, the idea is to continue tearing
down even if things fail somewhere in the middle, because that ensures
that the hardware gets as close to an "uninitialized" state as possible.
If for example the first reset assert were to fail, then none of the
PHYs get disabled, the regulator stays on and the clocks stays on, all
of which can continue draining power after the controller has already
been torn down.

So yes, I think this is an improvement. It's unclear to me what you're
asking for, though. Would you rather have a comment somewhere near the
tegra_pcie_unconfig_controller() function that states the same thing as
the commit message?

Thierry

--8ArMwWOicASd/TWL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl/GUhUACgkQ3SOs138+
s6GeEBAAlVMVuTOa7hJH0+TLdbBweBhIYaaTZnWzPfk4nkQ6e+KkyABp6qKX9U7x
Jnt+YtAx69WxUTX9tLmVlT/DBrOudl5HEU6H2zzuIa0WKe2e55fb32RmW7aV8qo2
gIPEThyNqn8t6dxXI8wnIID/92NTX0wp2zs+m1lBxRLFn+X+KXuJBC2BIqG0w7wm
LpfMXLVTxWxwZbpQVIzTFxwiN51/c/wXzi3e6rC+L6TRo14j1wpyfpMXbCAqOOWD
KAm/iitS3k2OTGf04Bg3g6+D10nBGWBzj5JKnrWxRdtBHh6K9ZdudG2JDZYulV7b
99RCy9wjAamkFr/TvBq9ZHssB4f7UOWSqdDyLEYTq/P6OU1u2NHCd9uj1Q8VeA35
UAobY84T9cyIYOxYZ45n2m93y5mISbV8NKevwVmPi2HJE1KRLUSxoJ3OfcaliD9+
Slqe+h/+IxXEeBTdnLRDWuD7B2igpxDIK/rUGOtC6XpTvz2uFHfFuUxdte0rXSRV
x04/L0zTOdxQeiHOzp9Jh0ws9XhqxW8456UI/FBNT0PkCXSTPHWRB53kThzhVRfL
VgLC2EoO08huGoP9eWfdstv2IBQNb3B4XiSH5hMPBg0eLOIGG9XCpdKZmgHRCaQU
4Dbq3kz48mTqAPTW1KxvBCrxHd7VhzwvZLYoLr7Hpk+3SVVleUI=
=am4l
-----END PGP SIGNATURE-----

--8ArMwWOicASd/TWL--
