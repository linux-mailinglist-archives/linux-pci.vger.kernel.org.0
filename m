Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 620D318B8D
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2019 16:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfEIOSN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 May 2019 10:18:13 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35447 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfEIOSN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 May 2019 10:18:13 -0400
Received: by mail-wm1-f68.google.com with SMTP id y197so3444047wmd.0;
        Thu, 09 May 2019 07:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pp+8NhUnjeIA54t0o2VOo0ajIosjxU/kYGag39Ml+gk=;
        b=pFBadWt6dqJP0CqiSP7RXzYHs5GXenBtUbD3ldRZHXwOGjgo4k7zr/1suuECtJMnIe
         87nOwNvv+FEU5B5nu52tUfTrQRbsHfSGOZMiG+fABZf4KMlZndyeqT9ZrehKMLclo+Yb
         hRnz824lOZuN/Z98GP2BCSdgO47FIjZxGprnmqml1n2mRqhrl2fOnOs5zh7fiW2tXMY1
         Cg0OjSZK9rKXfKFkfPgjm25czb25Iksyu8Y8VUJn9nmsjtdOeWjGuNv0xu0vchS8j5fw
         /LZUmP4KmawvbS7p9bqt10bRz/SFWtVnV9o8Xf0zIoZJZZtHMgtfCvUyZIkdTj0uCfCI
         radw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pp+8NhUnjeIA54t0o2VOo0ajIosjxU/kYGag39Ml+gk=;
        b=lBiwhbQEIZ598mJZiRMYOq8wPfon4M2yGDxNL5DdN5UWUsKObyPfZxsYih4760FzdS
         cBmJezGu5BAVKGoi14bzEysXl21/+NQ5vPFKt7arC6RmLovQLrdd45YBOqcLHCYfNDD5
         jgxLbrz52ndvBA3vs6JMMjRZJcXkgSJ1bIuou1obVWXzuMzOowzVh47u94PGYa3ljXTl
         NULzyKa9c0XStFzyaMEnybFJNk97+03My/lLr+ijs2xInwxdzaYDc4/FzYA56ye3D0cF
         zKfA1o66x3ZTlATu3GZaK4WvOUozoWfXawxiv1bQ6W0EbLRBs+DUHavqV0Y+WDzGgQlk
         HwUg==
X-Gm-Message-State: APjAAAWFQnUPdHStJJQ7H44JbGAv7e0mGLjfBTd7kyARCU9aAAS0mWOo
        Eix/yVS9wKMMXvKTkzTlJoE=
X-Google-Smtp-Source: APXvYqz5MtgXmeYU5p07dmfWvksGgWZZgYaCN4Ei8+ogPfGoO8MSqLDp2NCeU47W3LLNYwfrusIJ8w==
X-Received: by 2002:a1c:701a:: with SMTP id l26mr3167724wmc.50.1557411491615;
        Thu, 09 May 2019 07:18:11 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id u8sm3543039wmj.27.2019.05.09.07.18.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 07:18:10 -0700 (PDT)
Date:   Thu, 9 May 2019 16:18:09 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V2 08/28] PCI: tegra: Program UPHY electrical settings
 for Tegra210
Message-ID: <20190509141809.GH8907@ulmo>
References: <20190423092825.759-1-mmaddireddy@nvidia.com>
 <20190423092825.759-9-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OpLPJvDmhXTZE4Lg"
Content-Disposition: inline
In-Reply-To: <20190423092825.759-9-mmaddireddy@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--OpLPJvDmhXTZE4Lg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2019 at 02:58:05PM +0530, Manikanta Maddireddy wrote:
> UPHY electrical programming guidelines are documented in Tegra210 TRM.
> Program these electrical settings for proper eye diagram in Gen1 and Gen2
> link speeds.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> V2: Addressed coding style comments
>=20
>  drivers/pci/controller/pci-tegra.c | 107 +++++++++++++++++++++++++++++
>  1 file changed, 107 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--OpLPJvDmhXTZE4Lg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzUNqEACgkQ3SOs138+
s6HI5xAAs1HMkIoleQaWx0jFjF8PsMt6m8fDI1mHrO6miv2T9DBo+Uvo2U8mBzVA
MmGJJsVwtdyAjFZD6Da7Bj7IJz7lHO/kJ206ofLu2QrihW/tihrQ22Z3IikZY+eW
P1Qet1AsjVWRCi9q5bRoRLeewnOeNLMuiCVObQXztya9cM+oFjtuD9JIkO2Otg+L
QX6esV4Hg0b7zL5s7l7dDPenE4PYzA93XSFI/XrBGN6+cdD+rMuaVb7xhMzdKIRQ
eFiyLafjk/Pqmlll3cDSYGJW7gVK0YNG7hqPg2IIO5k87oRrn/yY9NHZwMpty6Dq
ksQqV+ebSPYs1bR32AHlyMISxJAHYk/i4KDA+/5ts6O4+6ntMqnP+R3wzRHw7FuI
suCgVVJUBB4Dm1dnqp63eNtPx0Oq5TlBpxfNl1WoO2Nh+M4OnPEMbsqsYueKGghp
/Wknrnp5MePs+MdAVYPPmxobY0Z/WdxoEU8wXS3Fu2h3pGe32sWYuC/at6BOGjWP
fM6z4J/QJfqe07zvstoigutj0lGQqZuKyJYVE9F8qTqilBj6rMNOfekjCao/lzRL
hAGIpuduucnNCTdRPZsGPWgXR8lH25htra6lxBFl84DxP6xOMxWzJiu2A/kwfoTI
FT2jVnziau/hQvb/EsmaJ6wJIVk8d3GGUof+AZChBL817XxVkpw=
=DMr2
-----END PGP SIGNATURE-----

--OpLPJvDmhXTZE4Lg--
