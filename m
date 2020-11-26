Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16BA22C52FD
	for <lists+linux-pci@lfdr.de>; Thu, 26 Nov 2020 12:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389123AbgKZLa2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Nov 2020 06:30:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388808AbgKZLa1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Nov 2020 06:30:27 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4143EC0613D4;
        Thu, 26 Nov 2020 03:30:27 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id i2so1768579wrs.4;
        Thu, 26 Nov 2020 03:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oJ5exO3r5MZ1avSVhNH5NwIHa53W9nUtxsUnryyrsgs=;
        b=TActbMnX2dpTcVKatuGk+0yAv0HJDv8f1F9aBrbckJV14yn9ZohobmbgjtfH85tkC/
         MM3EWtyVveDUmkXbfu+fLE3jgS0yumMS0XX8yoepuRaOKgyk9ALzUTFWPxAFr7mHA1fE
         uc9vqTO71G56aXvMyFAD8FEloZx82Yeo2lnztzy19Z+xCU6CuCT8Y3sFG+MwdRR1809p
         yEJGBGM2I1sz27sH7gyMxdD+SRJM+hDjUS/29y9TCMfnD8SV1Fv6NdDsoNtO3ijRI/nj
         MfQxEZDA36O5RSNSMVme4P/ja5Isf/wThilfwRuJjGvYplL5x861+tJqP2pc8J8/DMPO
         +7ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oJ5exO3r5MZ1avSVhNH5NwIHa53W9nUtxsUnryyrsgs=;
        b=bY+pweAkkQ8joCaj7Y8whtx5oAvbuCzizotYkV9BfcuZ8jVqp34N0juDIbhyQq/nMQ
         VhtjyZK9LlkjWBldzVuwd5Fj058u8Z/DIZI9+1BtKNq/ooxuXHzvf8SznPD4Ixmic1dq
         iW8k+qDayArGRbcXp7z4KDPkMzsEBypvqW6Z0tiMi9yxblLOvv/wRkF52QkzkYxVbogy
         +xgtSnCT1Jz421hDUcx+bDpQZ0koF9I/3g4SSLahHxhwePhgx7Ek99mf/iAldz4eNHFC
         rTk01yHsas7af0G40TRs/vSQQ6xF5qlfcpWbRjLWOZv8j8H8tms0qv+zDjeyhYgvB1y/
         iSxg==
X-Gm-Message-State: AOAM5311NU/itwdLtl8Y2tK5YMv8VYdoC+4o2eRtAVyYMBWPn3FA7swk
        Yi3rkJGr6ahHFrEqjA6lUMU=
X-Google-Smtp-Source: ABdhPJzyNSfoaOVjakl6Dz4Ajv+65cvV9w+NfPSIlgD7XqX6mUYAF0Q40YExm2ZYoiFafgUBQRPOKw==
X-Received: by 2002:a05:6000:1006:: with SMTP id a6mr3185772wrx.367.1606390225975;
        Thu, 26 Nov 2020 03:30:25 -0800 (PST)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id a144sm8710564wmd.47.2020.11.26.03.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 03:30:24 -0800 (PST)
Date:   Thu, 26 Nov 2020 12:30:23 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lorenzo.pieralisi@arm.com, robh@kernel.org, bhelgaas@google.com,
        jonathanh@nvidia.com, jingoohan1@gmail.com, kw@linux.com,
        amanharitsh123@gmail.com, gregkh@linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH] PCI: tegra: Read "dbi" base address to program in
 application logic
Message-ID: <X7+Rz4lvlj6P50NF@ulmo>
References: <20201125192554.5401-1-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="//RXht02A0QUFTjI"
Content-Disposition: inline
In-Reply-To: <20201125192554.5401-1-vidyas@nvidia.com>
User-Agent: Mutt/2.0.2 (d9268908) (2020-11-20)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--//RXht02A0QUFTjI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 26, 2020 at 12:55:54AM +0530, Vidya Sagar wrote:
> PCIe controller in Tegra194 requires the "dbi" region base address to be
> programmed in one of the application logic registers to enable CPU access
> to the "dbi" region. But, commit a0fd361db8e5 ("PCI: dwc: Move "dbi",
> "dbi2", and "addr_space" resource setup into common code") moved the code
> that reads the whereabouts of "dbi" region to the common code causing the
> existing code in pcie-tegra194.c file to program NULL in the application
> logic registers. This is causing null pointer dereference when the "dbi"
> registers are accessed. This issue is fixed by explicitly reading the
> "dbi" base address from DT node.
>=20
> Fixes: a0fd361db8e5 ("PCI: dwc: Move "dbi", "dbi2", and "addr_space" reso=
urce setup into common code")
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
>  drivers/pci/controller/dwc/pcie-tegra194.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Tested-by: Thierry Reding <treding@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>

--//RXht02A0QUFTjI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl+/kc8ACgkQ3SOs138+
s6GZcBAAoY4Nqbq7gKfaQbDed8Xk1c8+IaOEkq5u7nZq+YZ+CXogL4atxCGkrNIs
XGk7XUNEzB8T7KiVLQmTW6K4ZhE6J4z8BRZB+H7SyOOp3Go+VRGobOjTbv4+lb9s
uAQQzd1XJ1Cw+KhAfgAR1sirTTAUDIrsTHakYimdybMwcfVH/5Nka/f0WSk0NvCv
wzWOAV4jk4s4fSRVLbJnc2u1PNGjsD6z7DlHwGVxl/zo6KTk0MjFE1tR2l7briqt
nuW0q0ACoHI6IvYb+bKkSgesE/WyVAbV2F/FULixHttvhiHCeLjasXD2XgSYHqkQ
rrBkJvZafbii5rhW7IJs2qk8QSxFkFJ6ESD7qzc6dQlJ741HOLtSU2FdWyRd3kwl
nRyfvA8b/ZhaLN5ivOQBjTTgwvf95Wsk1Bs/BGcvCJ4p1M6HnSbgwVXvF0IxrS6L
GqKMyKzh5y6zGVytc7mIuebCYuP92EVdHBkDeapJf7bR8u7o8lurHPrlFDWALuD8
ftjYqdTA4qEhXA+ITGy75T5Ba5Dz+OV0qWJf6l5sdlLx3Y/27Eec/m3YlJmqaHO0
pAt2RhA442E8haNsRrvFoIzyHy4ubFH6qIC3wWySw7H+S1VpsvFgVm/g7kVbi+B9
t/rDBF+DQQ3L8MWut7T7oTg6dg9GglXZoakNnxyAEoj3ZlG5Jd0=
=j3Wn
-----END PGP SIGNATURE-----

--//RXht02A0QUFTjI--
