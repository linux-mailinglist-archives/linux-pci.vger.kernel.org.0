Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 714CE1A7EDE
	for <lists+linux-pci@lfdr.de>; Tue, 14 Apr 2020 15:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388224AbgDNNwD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Apr 2020 09:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388218AbgDNNv4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Apr 2020 09:51:56 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C103BC061A0C;
        Tue, 14 Apr 2020 06:51:55 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id x4so13060686wmj.1;
        Tue, 14 Apr 2020 06:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FOGDiV0hbJz1HxbN2jXqtj/ZF+6uRGkUpCQ+mfwEdqc=;
        b=rj28FQbuYbXsaqyH1cjVScKGQOVPVLPOqL4vBsWa38E7JDhF/em/0U/N8ugTyZmbB8
         5u3ziNCGseii9Fd6o5GaB0iKq3ryfySrsY0soGUPAi4dSE5vDxp9FwA1vKl6vfph4HkP
         L5JX9Y7Vif/7Ku2NuyK2jtKRwH3sQagbP9LSNEjPkbWldE0cfQmROCBOdzl40wqeJeAa
         3j28uixlqgnT2M3fyB6+uL0f3VVuVFdgvpwrAz/ExM8ffHJO3gpZWHAB7URI7o7A6Qlo
         eeQlzxDaE7Mu+ZiN0WSfPSBuVfL5SkzvL1HLH63DrBJhq7vrdEKNVA1u4GMUlRdVdMCO
         l7cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FOGDiV0hbJz1HxbN2jXqtj/ZF+6uRGkUpCQ+mfwEdqc=;
        b=AJcBX9furE0LrA8XdX6mz4xt8wxpLGzEP5If8ub23pUsxVXQYNbtkQ+s8KfefTWzsR
         Om4SnWcTtD9wfjSHIGHPAZmd/DsdCDmn98hudMfaMeC1LPgvZSkhajkEVEQav1Q1CAPD
         PiNPSYQ/J3+NFnYf2fhW7uXjU8EsWMRN2G39VJsJwC7WBObwEn6ffjJ9nx65YYXgUh/M
         sAYFCU6baBcc679OfDMgflC500ZCa49XiOt5bOfujj5PsbqWeGLhyPWEGqLn2AAUCi/1
         4jrGHekrmhvCgIo0ZIfAnbEowbOl3K7hYjgrHkTvtVHpHNUzg6LZbLYb3c9agJJZybXW
         1OIg==
X-Gm-Message-State: AGi0PuZRrP8UtEBQZx/tpBe4g6XRjkrVeM1aRi9vqy77E3w5DsrF2YyP
        WF+CD2sWELqQd0l+fQgzwWo=
X-Google-Smtp-Source: APiQypLsLZfv2no2RHT1VR4cnHQ8aQ/o1kXW3w8nzIS3t33Jr2bsL3TmOpsURd+K8rYZ/rRKXIOufw==
X-Received: by 2002:a1c:c345:: with SMTP id t66mr25259325wmf.189.1586872314481;
        Tue, 14 Apr 2020 06:51:54 -0700 (PDT)
Received: from localhost (pD9E51D62.dip0.t-ipconnect.de. [217.229.29.98])
        by smtp.gmail.com with ESMTPSA id k23sm18681735wmi.46.2020.04.14.06.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 06:51:53 -0700 (PDT)
Date:   Tue, 14 Apr 2020 15:51:52 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra: Fix reporting GPIO error value
Message-ID: <20200414135152.GA3593749@ulmo>
References: <20200414102512.27506-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
In-Reply-To: <20200414102512.27506-1-pali@kernel.org>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2020 at 12:25:12PM +0200, Pali Roh=C3=A1r wrote:
> Error code is stored in rp->reset_gpio and not in err variable.
>=20
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> ---
>  drivers/pci/controller/pci-tegra.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

With or without Micha=C5=82's suggestion:

Acked-by: Thierry Reding <treding@nvidia.com>

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6Vv/YACgkQ3SOs138+
s6Eamw//c9rjXOHWJcTFLrcwMcrxead/8lDekjEgx85muyvjFplQbZzzOSEImmss
z9vAjmlyGOGOl0mWBqDGl9OHnLxBHjlSYFT2DlZY92dBgfsa0qY9oEAJ2eFaNRnP
iyRDns4lq14wcRNlVqeA7/LgOjcyYhFMWx4fR5kMqECPxDF9BteS7A8Mbxp+oKl1
Zg6e8cBfJ92XzRTX1uR2aHmTZTqIC26xxd0qe40/+8dHTtada4TCrX+C5Cyn1gCF
6pNWvVAWqqcOZqI9tGR5i/7SiMceUxAGcxBLD/owQEKLaIVCQgRmoeKJUo3TJcVk
UlOjB990t1qVtOQLym7gP9T2wOS01kzwoWy9/EvsLO5WALYrmzhLVJ//qH9ph0Xi
FyD5BszkDoaG4O+NG1vq9uDoL4k+cOPhyxleJ/Y1QJ04xdsq4fUPcT5YRWkYJukX
c/SslMaiPeqstf63FNzHmbZuViKcmpFXj+JbRXrdpH8sXVwrchd1PBVXlc0x3o95
ieD1fQTUU+tYYE0lV5Z8qxLeAZiSYjBa9BOOnRGuULAwbJFigGjs6tkyu0AY54kM
id2LnQNrL2PdYRO3pwY9Juaqn/ryAE1U2KEoRKSVWQO8/3PgNAzYW7e3IApkEe+I
6dPJnoqnuebk5fgsoIx3OP6hx5QbcivpaAAdUpHagUEXKdYSgZk=
=JwZT
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
