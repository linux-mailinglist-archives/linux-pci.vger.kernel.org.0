Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC87818B34
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2019 16:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfEIOGE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 May 2019 10:06:04 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40238 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbfEIOGE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 May 2019 10:06:04 -0400
Received: by mail-wm1-f65.google.com with SMTP id h11so3351481wmb.5;
        Thu, 09 May 2019 07:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kBXZiAXPK9BIVvjGaDqtr14XwZWAS7nTrdH9Q6YxTeI=;
        b=nSxOaYb0ZoPeUQipzI55dY/Qq5wxXrZNGOd9bj1RqmUrsa62FoNE5Zd1gb22qAjhq5
         rYRKcd2BaHNBFs51yTZ9we/5nWBSOb9EeDlYJSqIZmMH7x75PGOMe9GtJqnRH8dsx/AI
         3PKsb53zcjBEd/MkT5abybO+w5xtDsJP/LCv/pXi5FsFAp8utW8X677Rbgq0dm6OK34y
         3yaPH+lAZ76zvXsW59J8tT/YXmjd6iSP1OzHW0MrYXwP6D5TTJslC9tUsFgeMV0OaX44
         8LjyoAuyVfnkgBLW0J6hLfTZ4ahjyHwC6mB8mzuvI7t89g1E7nWfVU57OO+T6Sv0zCNG
         6g8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kBXZiAXPK9BIVvjGaDqtr14XwZWAS7nTrdH9Q6YxTeI=;
        b=KEysNmvBhH/Liz1Dn1G823I/y96JuoV9/YR4/DiUTdIlRTmRCBy7augv0kPPLjMXYk
         k66fllr72YJsnSn4XizF8JxKSb3mBU1i3pcCzQ3ERyREd/IunZ6XTEc4TyCQt9skr1et
         mIyXWR2zzP/U9cxEt2qbokJiZQ78uxBc1tu6VNjDGc12drlfVtPS+rGmu0UZfurHefo1
         gPAKO+1dOgNC8D0R+xLis58OHbwzHSD+UX+GPpNrUMpXciVQ66+3szCMxzo6RfPDEW9A
         YyqVpUeqKqGsqYho9pI154iaOKADTa4xOxj60EvDmW6Jz05nP3b4RkFJynGXTqnWdqoQ
         AdAQ==
X-Gm-Message-State: APjAAAWw+DQrvNWybyZpzk497QPUI4SPw3Y6kQWdce7xjVXyfZEwyrr6
        lDURuCJq5QD0VFtn15qGSI5SuypsuOM=
X-Google-Smtp-Source: APXvYqyAEE1zt7X4mlRWurw9oiJLwggZyHxe116NC96Na91k9dDziyZcNrsdP6CGUb/XWTmxc7GjWg==
X-Received: by 2002:a7b:c844:: with SMTP id c4mr3044105wml.108.1557410761320;
        Thu, 09 May 2019 07:06:01 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id s10sm3034040wrt.66.2019.05.09.07.06.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 07:06:00 -0700 (PDT)
Date:   Thu, 9 May 2019 16:05:59 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V2 03/28] PCI: tegra: Rearrange Tegra PCIe driver
 functions
Message-ID: <20190509140559.GC8907@ulmo>
References: <20190423092825.759-1-mmaddireddy@nvidia.com>
 <20190423092825.759-4-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="adJ1OR3c6QgCpb/j"
Content-Disposition: inline
In-Reply-To: <20190423092825.759-4-mmaddireddy@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--adJ1OR3c6QgCpb/j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2019 at 02:58:00PM +0530, Manikanta Maddireddy wrote:
> Tegra PCIe has register spec for,
>  - AXI to FPCI(AFI) bridge
>  - Multiple PCIe root ports
>  - PCIe PHY
>  - PCIe pad control
>=20
> Rearrange Tegra PCIe driver functions such that each function programs
> required module only.
>  - tegra_pcie_enable_controller(): Program AFI module and enable PCIe
> controller.
>  - tegra_pcie_phy_power_on(): Bring up PCIe PHY.
>  - tegra_pcie_apply_pad_settings(): Program PCIe REFCLK pad settings.
>  - tegra_pcie_enable_ports(): Program each root port and bring up PCIe
> link.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> V2: This is new patch in V2
>=20
>  drivers/pci/controller/pci-tegra.c | 70 +++++++++++++-----------------
>  1 file changed, 30 insertions(+), 40 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--adJ1OR3c6QgCpb/j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzUM8cACgkQ3SOs138+
s6HBUw/+Nge0hAU4yobAmEA4PrdYseRVfQdBLh5I0sOnjta7vUd8lhBu+ZHXLUxT
sQ1SLFFnDK2iq1dOmxlr98Lzfm+WSZ/uBINcD60pwv+dDxDJCBQg2pbT+FmMZjOl
c2xcpE3aEdO2PhPslMTJkOkZPvjzahB9EZRw++AUb/1cmnJlpbR2vN1W9qpO9Yvf
+SihoeLiDEd8J84z7FASb+6UOtan6YmDfVPXzFuvkRs/ZTVg9Zn8/1SvxYgRkJyy
nHnNxLMiaJ6G1G3vb6jLG/QZ2WRJA7EwnhNB9znJQjOKl5ydZ4BPt5Md4RrQKiwo
PHVi7ujVbKbkgES3plvtt5TVv6jPdCopg/8kMj4zgjZLjp37G8GrToKR9a9rczg1
JQRZ3lK65qDqM97JlywjQViLCRr8eFLWL+fb5fNvKf534nqjTz3pBy7BLpRRTJlw
ZLAnrtR1LR78bKfMyPfiBNnYovrUiOyYWyppKqDWIHXmL4VRJjmXtHcVB48Z334Y
K1Wx5nvBnTHhBbN1tKdTSaw5XyoXddvvG3GtIJrzlEkLhSGj0zjpMAyUpuOo3Juf
1IGY5xIo4MA9Smua3qpUNL7vlTXRV3QBor25ka2m02Ic6oA/ueUZfo4nLJMbHhTR
0lffVkIlyZ7QPm5hSBjREi5Dc6u7UZ5q6RPyVxopflUJCU+pGRQ=
=hZ3Q
-----END PGP SIGNATURE-----

--adJ1OR3c6QgCpb/j--
