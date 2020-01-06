Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97E98131280
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2020 14:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgAFNEn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jan 2020 08:04:43 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35230 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbgAFNEn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Jan 2020 08:04:43 -0500
Received: by mail-wm1-f67.google.com with SMTP id p17so15199033wmb.0;
        Mon, 06 Jan 2020 05:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f1SlUZDN16+Hw4sSBCtOG/D+BZxQ/TTwFM07SREKnFo=;
        b=DeDorgOpx3C4lcDFyo9GkzRr59Szn/LwWdUmMSwc2930pdk85z0mR7qnBxqur1PWk8
         5ZNAZGhOKaChzNrOeCGaaBhtTmFDpjscnDb6nX8LSJgCO6t/LjpT2g0r5Jt63Ff6e6gP
         ZZqq6PYnNvIDoWQIFnYHa/b0jcW7O2SvBuwwvnKJvOhlz8WZksto+RCUJdnrZ7j0m4HX
         FfDLR6GfxFRDEZKwdJ+RLVz5MlBKuNfiJYvvFtWihHVdrM8IU2kMxVJmaWmRO2ePTugj
         /7vlA6UfxZ/bc/n6CRkvLohYAwCPB4FLN8No5IqJIUfr9eHjp7MvHabyJHqi9dbD1AS+
         aT3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f1SlUZDN16+Hw4sSBCtOG/D+BZxQ/TTwFM07SREKnFo=;
        b=tW1GSkOAG6KjajD3ymsKwVVQ9YsA60ttM6bvgghoY4n6hXktIGtD8l8DK2xfxVACQN
         Hbj/hYsXW4qFB6qECXVV3DfDibYszcO0n6Ncpl8triQX/BwylOstFk/A+/G6CUBYVNoS
         KYRPB3v76Ufa3tBtZhjN3Foskj9eKoO3DtB3svHtMGpu6pX69zskrW9hTpqnLVZ7negg
         mMNl+JJFlCCRdO158rutt+zVQIC86YTbaEswitTgho+vU3ApJ++W2vQS7xUfnr0l3Kjn
         drA6MHHHvlcyqhZfux78x/XZpwq0ZH2MJZNIwWj2WwOuyOHNhnKfmKk/AyF0XHvvCxzi
         iBlQ==
X-Gm-Message-State: APjAAAWwomHu6QlGD39XB/nWPY4BD4h3LgAHVw8l58GOs3ciBzVwvZ98
        UlkjOcu4bIz8vLO600eeAY0=
X-Google-Smtp-Source: APXvYqwYQiVAy7ZtUBk8Qv2zP+847DcpaQDmGIoG5FymG0IgkuUKC1KDqV4U3cWISyeAqZBsqRzYuA==
X-Received: by 2002:a7b:c183:: with SMTP id y3mr34995190wmi.0.1578315880453;
        Mon, 06 Jan 2020 05:04:40 -0800 (PST)
Received: from localhost (p2E5BEF3F.dip0.t-ipconnect.de. [46.91.239.63])
        by smtp.gmail.com with ESMTPSA id c2sm71998289wrp.46.2020.01.06.05.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 05:04:39 -0800 (PST)
Date:   Mon, 6 Jan 2020 14:04:38 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com, robh+dt@kernel.org,
        jonathanh@nvidia.com, andrew.murray@arm.com, kishon@ti.com,
        gustavo.pimentel@synopsys.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V2 1/5] soc/tegra: bpmp: Update ABI header
Message-ID: <20200106130438.GC1955714@ulmo>
References: <20200103124404.20662-1-vidyas@nvidia.com>
 <20200103124404.20662-2-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="w7PDEPdKQumQfZlR"
Content-Disposition: inline
In-Reply-To: <20200103124404.20662-2-vidyas@nvidia.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--w7PDEPdKQumQfZlR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 03, 2020 at 06:14:00PM +0530, Vidya Sagar wrote:
> Update the firmware header to support uninitialization of UPHY PLL
> when the PCIe controller is operating in endpoint mode and host cuts
> the PCIe reference clock.
>=20
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> V2:
> * Changed Copyright year from 2019 to 2020
>=20
>  include/soc/tegra/bpmp-abi.h | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)

Bjorn, Lorenzo,

subsequent patches in this series depend on this patch, so I think it'd
be best if you took this into the PCI tree along with the DT bindings
and the PCI driver changes, so:

Acked-by: Thierry Reding <treding@nvidia.com>

--w7PDEPdKQumQfZlR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl4TMGYACgkQ3SOs138+
s6F+Zg//TLpFZod96JYrSlXeoed6v2Ljl8ogG72EMMhOZIGLCcKwJWIX7ZYo1SeD
WkkHSPNRbwIIF91AMpanXAmNImq3CSbg63BrTDhYcQXBxGRnAKM19NnI/tXwesm0
Vbw5Xsq1mkVDpw/TmlJDJTB+koeIdwIXI81voGHrpja0jPn6dDWpuR6GWA+lNjKL
7RrsKeRyXeAsND0HX/LHNGc0Muyw+uAOU5kPfzhrTx7xcIpIhPymV2qI4mexMw5h
fbmppZSm/21u53VkeMhhdFBa0Ic+JM7nS7NHWaBgwl8L7RbuT423uaX159qb2KRC
NQbVh4xJGmaNMEpDq7FxSpMHszHgBthvyV3z80kkohVg5jUM1Fno+YsjlBNeFhp2
60zwuPnvqIgg0i7vP7rwYVc/mrIJBkrcUgVzxB0M1/R978xJmVZSeFE9yzVY9oty
XaqjNcwPyL+w+04TbCqOarVCbmKKnGPKmpCjuE4PlhI4LhgDXO/e7afNFR7liMGz
PRI8whwR/49g0ByoOJrNA3r7KPoL3UMfLiWXBZCUnuvwBVdL4ihXg79zVvPE/eFc
HqZOSLfj03/ZcIvi8IigUl6LVGdSanZvyJOaQzKPE5bTIJb8VzxjxxJhq4tCZJ5y
LcsdpM6sTJefSbEf7Gio2ioW6r6yUTxzVoG3Pco1xQm0Szb7UCQ=
=GkrY
-----END PGP SIGNATURE-----

--w7PDEPdKQumQfZlR--
