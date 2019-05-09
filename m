Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB3118BA3
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2019 16:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfEIOXf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 May 2019 10:23:35 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46422 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbfEIOXf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 May 2019 10:23:35 -0400
Received: by mail-wr1-f65.google.com with SMTP id r7so2689188wrr.13;
        Thu, 09 May 2019 07:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PJZUM5Yzf4DgDkhawz8DRVuNehkyZlFhjuuNpYn+Lms=;
        b=N7xAjwcVCa1lZ8s+qJHa9upEBlMqoo7sCMAXlzHlls6BwQchOB145qUXKVyoUWEeil
         pzNHeeYYjuxygDTrDf8bQMc5H7Wl8TlvMpI2kYOOHOHYSIEq+BEa7tD5AQMPEHa8alt4
         fOFjwtKPxm7ifKL9vE7GqwJtm+GhqZPqxl0KHvrquQ0hxoSm7/L+gDuANKWa0vVPmLGr
         yP699lLGaVOheEynQDG7qlbGmU8Cmpvzjw6PcROeBDxuc4TIWUYThsIaD/BoG4mGiXls
         LRA5Yx9gdhvzdmyobzdW5ssmwZDIJ3r8BbJcFmhb+BMYIupggTXSs1fq+xeVJ4Qx0Koo
         PjqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PJZUM5Yzf4DgDkhawz8DRVuNehkyZlFhjuuNpYn+Lms=;
        b=T+kHcMUepld9UDNPita98bj+ZNN1TeorBbbvngMql7i4yuywa/wJzzzVkuj7ge+2lv
         9VY4+A2dcgygrxC97Z5hfJ4QvbIHTr2kzO+8e1nd10MkPeFEvOcrCJoNDo4ITlaRzUB5
         3fdmyQh+Oz/Fsg8c12fUn82GkWnPAhrAuL/sFFsDeUmWpeVcLgIsjx+cwFe8JN8WE/yG
         KCU20Jmre7TsEiqYToJS+XYUwJrX58d9dQA+kcEqNfkVwXsLBDu6ewbf/YcWv2IwuGI2
         DGoQFzVsCPG5WdnKIyapNu/XeCJyEuzkOWMTCe0k/hfC9i6ZrL84FGdglDmEMxi4Bhz3
         8mIg==
X-Gm-Message-State: APjAAAUkel73zG05p4X3NpCwBZIeObQbteVPSgk7D0a56AlRSCBYfr7e
        Q1l1xFfU5vMtXT0sX7Aaz20=
X-Google-Smtp-Source: APXvYqxiQB7hIUxKChMqmEdJmmRmdjW0cl6Q8X1R0K7mSegH3ShccOEpzbYWmOt2LUTb8gUKFtJDXA==
X-Received: by 2002:adf:978b:: with SMTP id s11mr3262279wrb.169.1557411813915;
        Thu, 09 May 2019 07:23:33 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id j46sm4759265wre.54.2019.05.09.07.23.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 07:23:33 -0700 (PDT)
Date:   Thu, 9 May 2019 16:23:32 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V2 16/28] PCI: tegra: Set target speed as Gen1 before
 starting LTSSM
Message-ID: <20190509142332.GM8907@ulmo>
References: <20190423092825.759-1-mmaddireddy@nvidia.com>
 <20190423092825.759-17-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+ARLBH93C7pgvpZY"
Content-Disposition: inline
In-Reply-To: <20190423092825.759-17-mmaddireddy@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--+ARLBH93C7pgvpZY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2019 at 02:58:13PM +0530, Manikanta Maddireddy wrote:
> PCIe link up fails with few legacy endpoints if root port advertises both
> Gen-1 and Gen-2 speeds in Tegra. This is because link number negotiation
> fails if both Gen1 & Gen2 are advertised. Tegra doesn't retry link up by
> advertising only Gen1. Hence, the strategy followed here is to initially
> advertise only Gen-1 and after link is up, retrain link to Gen-2 speed.
>=20
> Tegra doesn't support HW autonomous speed change. Link comes up in Gen1
> even if Gen2 is advertised, so there is no downside of this change.
>=20
> This behavior is observed with following two PCIe devices on Tegra,
>  - Fusion HDTV 5 Express card
>  - IOGear SIL - PCIE - SATA card
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> V2: Updated commit log to reflect why this issue is observed on Tegra with
> these particular cards
>=20
>  drivers/pci/controller/pci-tegra.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--+ARLBH93C7pgvpZY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzUN+MACgkQ3SOs138+
s6GQrRAAo+2k8UeW7UF1AajkUxrBvVxbQQRIy+pZSYqFbg6dy6nOnB4ZEDVsnEZS
gfxZhX8qStod8gWagEMF25nctyiVHuQGU+P07GJY3FIcOEx4Y/EYv0wW65H6OACD
gbscLMB5kXRLbVg26nY3SIjB2IZDG/nFXmfdkkDpsOurd4CPulleUAovtp6q1Sfe
BAcbDC4vQ5cov/Ms2oJeEtZMBJICGPCDyFLZRU0D+xhuDyEVvFVnmGWM5vPKGAzM
hfMXyU4uWkm6TYExw9LMUoFiH5n7NPC4FnbQSO+vLw/9JGtnBu/wXVMAn63IwqcF
ezOMxxOeQwGxxbr/aJCF7VGeCNdcxlJvyAlOwESK5nIiAvXHW5mlOAUpuLplIxsS
2cXr75echyXlZlIP4l52qZj8K31E17Y61MWaO0/dwXMw6nEyB9uirZ2pZeSHVFxo
apAO6EJoBjWLbIEzKr8DAaZYWdpzu+IArVwFm1+sbasQ7GDM9ail0Q77gXdg2jP7
GXRgT7qwctB93JPqrDfwM/0i7KkKXs2zkV19ga3/2Ae9F+SoaGCElYSOKsuUKQ+t
yEg+JROfGJik40qUz/Skr/QR2VB4IMBDEGalKdsq22krZuqCaIx+Py4RgQ69L7+G
pJYDV3BBPNdq6RQBP5uC1jyivg75l4kzUOxGMJBhgD2FFyVw0lQ=
=BWzF
-----END PGP SIGNATURE-----

--+ARLBH93C7pgvpZY--
