Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9B8024CEF
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2019 12:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbfEUKi2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 May 2019 06:38:28 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37605 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727408AbfEUKi2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 May 2019 06:38:28 -0400
Received: by mail-wr1-f66.google.com with SMTP id e15so18013618wrs.4;
        Tue, 21 May 2019 03:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5cHZAThEhwYXg0mdwF8qSQfljsG3YRHFcTgp/N5AQao=;
        b=qkXnY8AKr9vUsT95SCGCcXRgoMuebbIIgTalyt6CCBhB7kw2gOcWMYB17h4wjCtjxe
         /VeYphbYeG1vkS5JGAOZfn8xicSlANIH/2gIc0WVz7a7MUjLRrJS6g/77vlvAaha4F7+
         xHmfOBxlmIV+674x1v7O4wnulkYfHlTfh/VwYJOhj7WixVc/B1oP9AKrDn4ihC5cx17l
         ye6yP6LZmalDEj3DUkyYvxuzfRbiAYUy/PC1OFXL6OzKkABpUQagVfSSlU/8Y/9Zcuq1
         2rYUy96MCpCR9rx7A+3NmDcJKlx+zyZy3pCsgSG68PB9mAUx7rN3E/hkfnBWpowbVUL0
         b0Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5cHZAThEhwYXg0mdwF8qSQfljsG3YRHFcTgp/N5AQao=;
        b=ZsNJCvb7R7EGaspOeuL6vZaDRdicVg7x6EveSRUXKNhitL6AVLxWOuaSCgiTbakqYi
         2ck7BHJlMw3vSKY569gUpwZdNy/n1ODmcK/zIOoSIhcD0WsNTwpu4oDPuO1pd3uGkkdH
         xxFmqOyW64+w4mnwkMhlNo4P/RifQgDDGiD3rm4RjYZXxcwm3J+VQekovGApHx7NS9AT
         dPMhjESt/BLwi0h3HXopgy4CB4YwjgfhQKrokfida7Ovf6lXXgYSQ/23GVyjZX62+8Ut
         P96rgpIFNL9iO7oOatfFiRnxkHzKIIGTAwgY69fOxnf2wrK1oqMgurzak4qgEL6NVYFf
         LHww==
X-Gm-Message-State: APjAAAW4EIEpyjZvM558d6j8egEFJUoGoKhv4y8u2NrJsiIBG6IeyzHo
        Dg+mR/uF5RbOTSGrPSQiEBw=
X-Google-Smtp-Source: APXvYqzZKh2+vlDE2a1Mrz0XQxxaUOnMxe2hSuwIkeRzhNSIVh2DUrUxliLVNc217oqmX8bwpz643A==
X-Received: by 2002:a5d:4b07:: with SMTP id v7mr21489249wrq.106.1558435106456;
        Tue, 21 May 2019 03:38:26 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id i9sm1529322wmf.43.2019.05.21.03.38.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 03:38:25 -0700 (PDT)
Date:   Tue, 21 May 2019 12:38:24 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com, robh+dt@kernel.org,
        mark.rutland@arm.com, jonathanh@nvidia.com, kishon@ti.com,
        catalin.marinas@arm.com, will.deacon@arm.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, mperttunen@nvidia.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V7 07/15] PCI: dwc: Add support to enable CDM register
 check
Message-ID: <20190521103824.GG29166@ulmo>
References: <20190517123846.3708-1-vidyas@nvidia.com>
 <20190517123846.3708-8-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rV8arf8D5Dod9UkK"
Content-Disposition: inline
In-Reply-To: <20190517123846.3708-8-vidyas@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--rV8arf8D5Dod9UkK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2019 at 06:08:38PM +0530, Vidya Sagar wrote:
> Add support to enable CDM (Configuration Dependent Module) register check
> for any data corruption based on the device-tree flag 'snps,enable-cdm-ch=
eck'.
>=20
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
> Changes since [v6]:
> * Changed "enable-cdm-check" to "snps,enable-cdm-check"
>=20
> Changes since [v5]:
> * None
>=20
> Changes since [v4]:
> * None
>=20
> Changes since [v3]:
> * None
>=20
> Changes since [v2]:
> * Changed code and commit description to reflect change in flag from
>   'cdm-check' to 'enable-cdm-check'
>=20
> Changes since [v1]:
> * This is a new patch in v2 series
>=20
>  drivers/pci/controller/dwc/pcie-designware.c | 7 +++++++
>  drivers/pci/controller/dwc/pcie-designware.h | 9 +++++++++
>  2 files changed, 16 insertions(+)

Reviewed-by: Thierry Reding <treding@nvidia.com>

--rV8arf8D5Dod9UkK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzj1SAACgkQ3SOs138+
s6FzehAAj26+Vd/E7W30W6r5t7V5VvOWhcFf3Jmp59yLidN65C8DRR41Qhw7YEyK
/2glrrtwu+zYgwWKSDLqCrfiQ+DhsYH+XP6S8t/YVwRN6uMF9IcYK216kVu2vAS0
ielsNNQOzGWWOWZPzhNZMpApcyeD7X+MyNGpaEfE0ddLHTxmnhDj4V2jOH1d5Ax7
1hnpU64dNMX0eH0zjA746QXoAhtrwtGwSBMQMkxEhkGmt0UKJFKabWXgvk3zhZX3
8U6Beasycz9+hkm0GEpyXcb+S30lVxQWen+i5ZvyfhHQ7+RsREY/SQu1go997YEs
yLsYeRtsd3wNliiJu1l4PNhJY9bI1i1OthM+NuH08cbAHBm9s0+eTX/Ko4s0gf3n
ICptVCYsVN6o6QkKnj14uWpbZ0Z2vQ4VeP4bs6vqy7sGruFWGuA9iZ85MQe+bEjU
AcaosScNT/X3g7TRgVQTGuZixEpGJg2Llv4fbYdkA3JRDiJxw2ewSxoLGpZnlGM2
Toodt5B961wBAOfv3p2gXTPqliyDJwCYGYkt8uTuSMiwfn3GyQSamFQWuLz8uRrA
LFiU26ht43GDUFhwjXCYJ1uIZRoyzl7HuM+WxySx2hYevDz3L4EdGiJf6qe8SBHH
RYMmHHYHxRbwR3Mfpm+sBCQgIFKDokaptNjuxiMkwVlgtGuW8hc=
=GXch
-----END PGP SIGNATURE-----

--rV8arf8D5Dod9UkK--
