Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 356F634892
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2019 15:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbfFDNW7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jun 2019 09:22:59 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56111 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbfFDNW7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jun 2019 09:22:59 -0400
Received: by mail-wm1-f68.google.com with SMTP id 16so20234wmg.5;
        Tue, 04 Jun 2019 06:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yTXjE3DyGnzh3mUQCwTWjsUXUr+7mBrootKOJ/1rR7Y=;
        b=Kk38JklNyGB2JU3VCr8PV9QIp6qB/aOd5e3AVfnbIVfXvhEH3oMEElGdErgmCdQ95g
         3sr3wKmDNqP0jU/CnFogQhZ12DPGDvaO+h+q3dNeN/ghR9hiJWzGtRXovOsDuh4Wnq+w
         /7Vb7EfPFBTyXYNTBOnthe/9xQQzCjKlkO65fljVUtNEMDtSyO0GBJWTmHCRj5mLy4Cj
         X9C/cSLppes07D3kHXA6WefpE1q/elBLYL+3nNFWTVxIjRhw8pXv/ZvzPIx//dwtlolD
         0lCAj/z4JPg+p2Y17KxCRHXfR9C+W7nkKpxZrGk3WISOcCE4ZhpOuieEytV09DyqnAmz
         fmiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yTXjE3DyGnzh3mUQCwTWjsUXUr+7mBrootKOJ/1rR7Y=;
        b=J2f0RFYSXInmpWPC4Mm2hNwdjHuFwnq4/Ta0FMbiiifHfvSU8wXyJtE7NuTSSu8LAt
         HqPu9y/33yuH+r+sjgV6pcMyW+l3Vk3IxuIyqGpDUOIILQdPUzteqcoJifBJA+h5N6s/
         K0fpK52cseeBzFC3ii6gg6xQ1/gxIc+Mqnr9njKPTP0kTwshgGUkgEjIrfwj5zVxAEx5
         8I4YE9Mo7qOY4Ld6j0/DrE9TZqEuLWJBsWSHSvjuTko9noWRBChBPf6UmGcX3Ih/sYVY
         REiH1bBKLbncGsMkisPkXxfR0lHYZLDnCNRlrZ74NwaCCgwDHCZpvCpOR1FGPwA7pgrj
         JmfQ==
X-Gm-Message-State: APjAAAXmBO3Halg7Q1cy33Z3JRoS/0yVW6u3pLFeFGZEooMBdxol2Vqg
        fooiaygAG0E7ISXojRJ4LT+N9Aax
X-Google-Smtp-Source: APXvYqz04o0c48ru37D9lXxMyiFeP8r3dkJ2gUAm1fe9Q/3v4SP3QZMwTy3fJI0QKfftHcJYDpVO6A==
X-Received: by 2002:a1c:7ec8:: with SMTP id z191mr5985020wmc.66.1559654576723;
        Tue, 04 Jun 2019 06:22:56 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id z17sm10507895wru.21.2019.06.04.06.22.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 04 Jun 2019 06:22:55 -0700 (PDT)
Date:   Tue, 4 Jun 2019 15:22:54 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V4 28/28] PCI: tegra: Change link retry log level to debug
Message-ID: <20190604132254.GU16519@ulmo>
References: <20190516055307.25737-1-mmaddireddy@nvidia.com>
 <20190516055307.25737-29-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kSOhxpxUsM1s2qz/"
Content-Disposition: inline
In-Reply-To: <20190516055307.25737-29-mmaddireddy@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--kSOhxpxUsM1s2qz/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2019 at 11:23:07AM +0530, Manikanta Maddireddy wrote:
> Driver checks for link up three times before giving up, each retry attempt
> is printed as an error. Letting users know that PCIe link is down and in =
the
> process of being brought up again is for debug, not an error condition.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> V4: No change
>=20
> V3: Changed dev_err to dev_dbg
>=20
> V2: Updated commit log
>=20
>  drivers/pci/controller/pci-tegra.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--kSOhxpxUsM1s2qz/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlz2cK4ACgkQ3SOs138+
s6HOaQ//aYSYk26RIhZPjP4NCUdL8P7gXfov4RmSEnWQWJ21VBAHzfBdmcpKd9S/
JiEiYtnCpR9gHrKHOqR5TTbFaOcCZ4mgHfp58iXJvchMKvrxPSbaoN17TFl0nDy/
oMS3gCBsI9AMF9D+c1P/98jFydG1Wjr26fg+ROtG9+jZ93Cc9bdBp2IgHG5OLKvC
B5ZpOP0DVW1b98xovgUpWFOXnOke86owLa6oLVsoFhc+SnRuqzERycHcEBuRvFph
Q7d8UfWPhdS5JONqb1hs8qF3LFWSgFoHS4sgR7Lm+eoXl+pV33pNhsHF6Ab2LdBo
JTLbJCrmFkAWGy8DIk06GO25wdURUutKgDKCV1+hzLc+S4QHvtnaQta5R2LcPLul
/RoXgppX/8oKwWtVlNJtDRwyutA2tNEindB5WftJEnuPo1jvFCb2Wba7gEROuSxp
4tHWivdeRdgINTiSFE4jo4dkY6grXvwwcupZnTH9i4yu1UQs4cMF1qAIf1Smz5bX
3lkdp+ZLNQi7VLs86e6mAZIPJUz13WQPZPnamiiJucmCiXUbUWHW80qUb1Wn2oW+
qlPWd6k/pB3r36j5gVCyvdeJQAdSxIU0yd5oIifqYUG6WPrwyFUJC0Kk8L9oy4lf
66GaZEHYX+iH7IOlQ7e+ceANSlcCfGe1+M1EUr+4ijJ1amNHV+A=
=0bFR
-----END PGP SIGNATURE-----

--kSOhxpxUsM1s2qz/--
