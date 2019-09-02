Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3315A550E
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2019 13:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730252AbfIBLik (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Sep 2019 07:38:40 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46394 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfIBLik (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Sep 2019 07:38:40 -0400
Received: by mail-ed1-f66.google.com with SMTP id i8so1621810edn.13;
        Mon, 02 Sep 2019 04:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=A1jU8Kd8kaSBOirwnCIVWK0+MxxtP3zKULey0yqf3Fs=;
        b=kmAUcOKMUugD/IszxroNxks32yx1nKZbnpoX4l3389KhNbSRtiSEEp8d1CVXS7TdiK
         m+Ege9ha5mPyS0c02pzMrdwWiLq8Pw4TJlw1F5AGaJbSi9dDFw5sA0j6SdgbqRbhyrZt
         zp/dAcsQQ0ta1MHVi9G3XCY7xp3vBquRO9ERvWO5naYz/1+45quUwj2ybrb6Y4cP7utU
         WOuZiXwh/Iw2PdhnqEZblqQQWW+VFz4GmfweVBjHWo7U9tJYlZTvKcG2C7Ss4zg0Nre5
         hJgumzeWHb3arPUgnwVrfRY4WCQ2rLEQ4s+mj/fhmw8xsEc2kHxxzbZaWfxZ9WvBYWuc
         DQmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A1jU8Kd8kaSBOirwnCIVWK0+MxxtP3zKULey0yqf3Fs=;
        b=d1zthXjGXQMSM6GI8qH/rSy+prVxeTAhb/H3tFr+YI7MfZwr1wjzfIUmaQtfKAWNkc
         3qOi8h4hrRjuY6tZRaeFjLgXSa0bxUIMYA2ieTJ3r1XcjyuI6fH0eYJg3o7wABgzLiBq
         MaGYf4ZcV+gWEUUdshL7ybSpwPB9G+CohMFBFNaP+4Hlt1zLXT6JxdzQvpu4ODKp7FRj
         BtE+J7+7t4yZ5MYSg5wbfl316Q8aZ7a/ruQT5Wf8tDfzlvlmzdyCKiM5YkXSBiH/BhFI
         fv3NY3DU0OHNSpnViiLEdHa/+7ZUDJI1YHVfPNZWFIMrmoaoE+22ENQKhckZMjsJdYO8
         RC4g==
X-Gm-Message-State: APjAAAVFdrT4I5TVI05Sjub5LoVF69b4pA0+FZ+iOHXFsYR6dACuVDnt
        c6ENNsVqost17bvxZlO5YwI=
X-Google-Smtp-Source: APXvYqyQPT8NxW+hvmY9U01+tXAZ5YfgoV3MfxbzA8OX3sMJ570CdsXTtchI1DDsOQXnq1onRbztWg==
X-Received: by 2002:aa7:da54:: with SMTP id w20mr23284871eds.52.1567424318209;
        Mon, 02 Sep 2019 04:38:38 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
        by smtp.gmail.com with ESMTPSA id f24sm2859546edt.82.2019.09.02.04.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 04:38:37 -0700 (PDT)
Date:   Mon, 2 Sep 2019 13:38:35 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com, robh+dt@kernel.org,
        jonathanh@nvidia.com, andrew.murray@arm.com, kishon@ti.com,
        gustavo.pimentel@synopsys.com, digetx@gmail.com,
        mperttunen@nvidia.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V3 2/6] dt-bindings: PCI: tegra: Add PCIe slot supplies
 regulator entries
Message-ID: <20190902113835.GE19263@ulmo>
References: <20190828172850.19871-1-vidyas@nvidia.com>
 <20190828172850.19871-3-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6e7ZaeXHKrTJCxdu"
Content-Disposition: inline
In-Reply-To: <20190828172850.19871-3-vidyas@nvidia.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--6e7ZaeXHKrTJCxdu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2019 at 10:58:46PM +0530, Vidya Sagar wrote:
> Add optional bindings "vpcie3v3-supply" and "vpcie12v-supply" to describe
> regulators of a PCIe slot's supplies 3.3V and 12V provided the platform
> is designed to have regulator controlled slot supplies.
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

--6e7ZaeXHKrTJCxdu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl1s/zsACgkQ3SOs138+
s6FOWA/+L0+vUUclgoY9YfwR5cI+nK0iPHLC/9XLC8xZsVkBaeLEZPWXWlem7QsU
CpdhO7J9sCK8TEW1h8MVKzIhn88paNynYuOLRhjBVJM7hoGCsRNS2/laeeulEvy0
bgf7qphguM9m/sXkCcoj/wHfEyNcTrl71ZyYybG5OGxKMgawwLhdAh9iqNEHRHZX
iR1TfnjIZSANuXcQsEnfHNkFwozF+NDdv7gr11mJm0BrHBmT8XwSZm3xVdPPCXeT
m7rNkB+jtW3jCuxdfXSeUP1qptQT/ZtOdJuN+NudSaJOnV9KZ8CwNRoqWvWH3BFa
1NbR4A1FxlOPLZg9SK2ya8HJQ4xpqXmQBwoPTgDFyypCyouBIC9XK/zLBvhrEfkc
SRWS0nufk/ciXkMAJspPFmFpafr1TuMKlgLfQEQDoiaFBWozVSu3csBsg3917ejc
GimoR1APSzLYU0L85BLekUF+nth7RpGz+VY+eKMSfCUS18mcmUTjpiPw1klrbzex
UFQFCbbf6Sua5Ct5U5nL/uZmZFxj960SQo2d9I/HYbRSuS91D6t7SJvOtyeR1eRz
HVFc6AIBV1J64ogQ6oZsa73b1mvkY+vOuMaqdcEdUn2xrilg3x+LGCpj7Ph6drXU
wFBgvboTaI8RRMp1yZNvsv4HIX62CYDf3fLPVpYxuPr3ipMy6yU=
=3vWd
-----END PGP SIGNATURE-----

--6e7ZaeXHKrTJCxdu--
