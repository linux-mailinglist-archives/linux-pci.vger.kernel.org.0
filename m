Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63F642C52F8
	for <lists+linux-pci@lfdr.de>; Thu, 26 Nov 2020 12:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389065AbgKZLaM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Nov 2020 06:30:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388808AbgKZLaM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Nov 2020 06:30:12 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE60C0613D4;
        Thu, 26 Nov 2020 03:30:11 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id s8so1748077wrw.10;
        Thu, 26 Nov 2020 03:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Xg3ChPxHBLzC8XSHVd6gyVWVYNsBjJ8+ii6EObsboRw=;
        b=vLhO5gc72sNDeMLmAyYhqT0Ah94gB76AqnxnDR/7M96dW3ASzUSktS0WK0J8s0/k4N
         BMyJT8yC8soDPtgJ9bUfgBSbCBzuwA6zTwRS+S4NARX2JVlBGrk+nhLBeep1X6lGX1eG
         ehwRW8+HTVFOzuEZtpElTi2MZPrTlERjgz+nOgjnl/NhKuU2Sb14T+cqspIuZsNPQFMx
         dRkIcQCQE4rtE+mn9RK5ppupwC/LvWppkMCIyvXR90C62EcL5Tp2ikok42I+Vtc+e2Rd
         XX0cJ3Rh/4828sKoZ8DdWTQVgegFsu9LMdfvGnjUmG+Dn076Q6wOzEAgIKxYN+d8wj/R
         qzPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xg3ChPxHBLzC8XSHVd6gyVWVYNsBjJ8+ii6EObsboRw=;
        b=b0BGM7nZXzIsbNDlA8mH8O5Mgxwf8CI89Lito6Hg6if/6nLs+I74f/N7nH8OEISVr9
         k8gb4EwsTlVcb9ov6eHovF9AQBTf5zPrlZca00R4uFAZgoJaSmI7nAN9xq3IA5Km7VWZ
         j7viFFjDy3PXkW4Yvf2B1+f4NWm31jh9d1/+cfFUZd+Qfzc5Jf3TVLVw5muEicNArHP6
         gaTY+opfrVzDjeRmEVL2Hfv32TCkCTX5CbSiIpjH+WKb5HODarCXCCIh3KWOyQgufxrL
         s4SO70ro0XnPIpX9Jh0iopIQPdlriJqmhFOOdWcVHZcVtnLQ4w2aJSJq+PoTlGwPypKW
         G9ng==
X-Gm-Message-State: AOAM531fnmRkjMrS8HtA5s7INTYb8sfa99mSosZNr+zszO7qNJiCUfPC
        ot/tsF7YdWI5TPVR7CZ7n9wnCTUTmK0=
X-Google-Smtp-Source: ABdhPJyWAMOkzlh2+FXquc7q0hVfUCgbmPH8Kn7rvnJu071pXWCM+0BnQFjABEXy+VnkqFHpr8mPYg==
X-Received: by 2002:adf:dec3:: with SMTP id i3mr3242324wrn.263.1606390210598;
        Thu, 26 Nov 2020 03:30:10 -0800 (PST)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id h20sm7916651wmb.29.2020.11.26.03.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 03:30:09 -0800 (PST)
Date:   Thu, 26 Nov 2020 12:30:07 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lorenzo.pieralisi@arm.com, robh@kernel.org, bhelgaas@google.com,
        jonathanh@nvidia.com, jingoohan1@gmail.com, kw@linux.com,
        gregkh@linuxfoundation.org, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH] PCI: tegra: Move "dbi" accesses to post common DWC
 initialization
Message-ID: <X7+Rv8iK84k/lWlc@ulmo>
References: <20201125192234.2270-1-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uRpyf/ZCw+A6MDI4"
Content-Disposition: inline
In-Reply-To: <20201125192234.2270-1-vidyas@nvidia.com>
User-Agent: Mutt/2.0.2 (d9268908) (2020-11-20)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--uRpyf/ZCw+A6MDI4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 26, 2020 at 12:52:34AM +0530, Vidya Sagar wrote:
> commit a0fd361db8e5 ("PCI: dwc: Move "dbi", "dbi2", and "addr_space"
> resource setup into common code") moved the code that sets up dbi_base
> to DWC common code thereby creating a requirement to not access the "dbi"
> region before calling common DWC initialization code. But, Tegra194
> already had some code that programs some of the "dbi" registers resulting
> in system crash. This patch addresses that issue by refactoring the code
> to have accesses to the "dbi" region only after common DWC initialization.
>=20
> Fixes: a0fd361db8e5 ("PCI: dwc: Move "dbi", "dbi2", and "addr_space" reso=
urce setup into common code")
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
>  drivers/pci/controller/dwc/pcie-tegra194.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)

This, together with your other patch fixes Tegra194 PCI on top of
next-20201126 for me, so:

Tested-by: Thierry Reding <treding@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>

--uRpyf/ZCw+A6MDI4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl+/kbsACgkQ3SOs138+
s6Fk1w/+Mq+/FnR7JB8L8JAdeYVHpnSPDhRK2/CIhYAjkL8BC5MOu6+d/0f3yeE/
UV4jBmvKO+bGV386mBWMtCYxEDPgMh5D6Fem3EVs2y5siekXvDSiIsH0vbcPAbNM
B4XU0eTzINlrQN+la5MWHCVbb/RapCbdL8F1ygKbMxVXNKfnzEP03QQpYNhvRjTX
ys5TJY0ds3ILTL3mQ2aCy8Rk8c+wYafNk5yqgxDTvMTkYVfGeSuUECyM23rFe3Le
6TpOPQ/ZpaSa7jjxzkkGLAkVnJB2MPv4FyguMrrRy9pUGQfqxvyrpRlQ8l9y5dyK
O6hGQclhyAM5biNuCntcGZpr2mLvCp43lYiZs0QVNPsiiZeC1Xgt9TtkiEyb64Ko
azW8gwo4O8zGTGOq6YKeQXpUOrcOSqysaldxQKB4cyLtrL5K5digBTdzLL9LdOXd
ZbuyeTQeGElYMjKGCniriofPmI1TLYiTMPLm83kk6SAFKrAa1a4aVyp/6VyRENou
U/fC2ko6cWQo/r6Hvr/is6d8QB89f4ekj4e2YEnpX4//t6GqixM7Qmxe31u3kR0F
PQjaeUpmk1r3qdYH9O3fYSjwhZMj+sy+zNzOy8NHZD0EHUdCpqXHfB6bVUxC98jq
IsctYY9Ij52LNQW8d9EW8+XFrhgluiWuUepM545GsYLSZKce07Y=
=qg65
-----END PGP SIGNATURE-----

--uRpyf/ZCw+A6MDI4--
