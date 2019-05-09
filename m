Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD67918B96
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2019 16:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfEIOUr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 May 2019 10:20:47 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37936 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbfEIOUr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 May 2019 10:20:47 -0400
Received: by mail-wm1-f67.google.com with SMTP id f2so3453428wmj.3;
        Thu, 09 May 2019 07:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TRjkWTdbZ2jIBPqRoOqTvU7bJ/B6sIXeDMePqywnoCM=;
        b=kPM3HgMT63yzV2v+GhXKso2ySUKYa+bRsOAhSfpK9dmAbyOh0QYOXxpLOq6af92kDx
         WcZCafxUJHpQDBrlmI43tIWlooE74rEi0YhNb7ThsDLE8ntjy782dY7Nm8z7bHO74C4i
         GKaj5GecEqYt3UVYHDT4im1ehn4KSfWcCcgBBnAgQp44UbYV0FsTvgsxA2rOavlpIibP
         HwGqk7l83yWzqhj7Fq2Esb0fE/TF6z7DLgDzBIw4SuFObQ0XR25yXLJdOaSakplE4MLo
         KZVkkNBTnq8UEGjyOoiK8f1+Zco2aJgyYZJKhtZPnkNiMkO4SvTjCxacZWulJvBlcWzV
         z/cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TRjkWTdbZ2jIBPqRoOqTvU7bJ/B6sIXeDMePqywnoCM=;
        b=nqscuqjWfOq/1FBvSetpqzPZCrwGeSg4vDoj8cy++q0eGfmdxA+qBVJGtqNH+qk07i
         jGhnMInsUTW9/S9PTK8V1yRZmEIrLrIBpi7RDvSv8kfDs0t9Io8z5JA9/9KwyD+/NcUp
         sIMQm2GN8o7U4Pw92MHEKi7znpWNuvVNQbESNuM+Ui9bSpwszdK9sUucOUcUEkE+CvSa
         N9beKDnSWztPbuUDPlwRMZ/fkLtHGaowBXfyB3jRxivMVDb1Y1WP9F2MJwqhZfb691H4
         oxhRLPi9UnT51heJhW9Bv/qxgtxKrXZySIPD0SgPbdCvIDnJ181fW6ROqwEwlrIppruE
         z9FA==
X-Gm-Message-State: APjAAAWk8VZAOVllk4UlMTZBSXuKHNy6W/vksONe2ItBJ5t4xjThKp84
        UcaikoWfsW9eZX1NfcWVnm0=
X-Google-Smtp-Source: APXvYqzcAm3j8bVI0rG1eNG2nviugi25yNWtFw8e8c/RiJSp2bozM+bS6bMt8IdjKBLn7QySriRd4w==
X-Received: by 2002:a1c:2dd2:: with SMTP id t201mr3345912wmt.10.1557411644771;
        Thu, 09 May 2019 07:20:44 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id r9sm1484480wrv.82.2019.05.09.07.20.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 07:20:43 -0700 (PDT)
Date:   Thu, 9 May 2019 16:20:42 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V2 13/28] PCI: tegra: Increase the deskew retry time
Message-ID: <20190509142042.GJ8907@ulmo>
References: <20190423092825.759-1-mmaddireddy@nvidia.com>
 <20190423092825.759-14-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="T4IYkFBVPN84tP7K"
Content-Disposition: inline
In-Reply-To: <20190423092825.759-14-mmaddireddy@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--T4IYkFBVPN84tP7K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2019 at 02:58:10PM +0530, Manikanta Maddireddy wrote:
> Sometimes link speed change from Gen2 to Gen1 fails due to instability
> in deskew logic on lane-0 in Tegra210. Increase the deskew retry time
> to resolve this issue.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> V2: Took care of typos in commit log and coding style comments.
>=20
>  drivers/pci/controller/pci-tegra.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--T4IYkFBVPN84tP7K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzUNzoACgkQ3SOs138+
s6GFyw//UjWRcuBbosKqkaMjHIMkH+D9IMOPWLBt4TunKV+QiMrpK8z3IZD33n5V
u3rtlzCNksCAxMKprzcpJts1SVN+SI5NzyHnHUYmBC6PmVjycFdKGyste020q9Fn
5A0kow40Pi91FW69J3fYL2BkiqWFti6KskJcloxJHBgiLhNhlveBdWAYsPDuLqev
YsgRrIzXF2KpvgCq/M1HK6fi6J/sLuxFWVNVlp7BbAz1CwwQfIFF/n2VivI6S3mX
93+M1pZbmr3nfsG0JyF4CPdLL+bIp23/BJFMKMTbpBNyTPQ3VSQGrpC7PV/mH93k
l5pd0HY9m0Rs1WbdsZN19Qrx1ydo5BwOipM2PI5C7JTYy2flbJlJrG6/2TZ4rxqu
rTjqLYxznMYIg41dG5oJvt+cDtIeGoS0hOHjBnAhpet7RUbnZnMiTdNPch9XeNgd
jiDiVrcdLVOx8wy/QBGPeUMW7FmXqLXdWWfVw/hHJTRI3lzoi/nd5liZOfa5ozBS
83JzXf1HIg5pJgf1thwysmLe6c9791DmsVnM2R4z1p1GECI+O6BjVVAi6QqJHSW6
/bsVo2IOBUJUJF59xiCjHNxppsghQxj6LIlD6T3Z8/U0cMcUOAT+zXAJtLEa5woc
TUK6oXIVySs3SRnIJe/AopYXFS1uzwKze3HITVOSvjf5nfxzlak=
=7+t6
-----END PGP SIGNATURE-----

--T4IYkFBVPN84tP7K--
