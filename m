Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64F9E18B2D
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2019 16:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfEIOFE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 May 2019 10:05:04 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34886 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbfEIOFD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 May 2019 10:05:03 -0400
Received: by mail-wm1-f66.google.com with SMTP id y197so3387001wmd.0;
        Thu, 09 May 2019 07:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6hgeJ62/5JFbBGb2/BWU28kBEHsth09slafCht0x0wo=;
        b=WJt7uuUzFuKTlQRMdvIpwSaf32naqFr4VvilZWL6a27LRMNcYV8pJv5aj3l0ux0p1Y
         xNPsItpStkyMclbh2Y8E+PcxhpkWEJHJJDTM6PhFgZ5QydcS4z6K7zuJvZnW7XGGGDwd
         UQDJhMjLY626tRubOFJWD058vYTUi9Zah4clVTeCk37oLHC+RFJMpyH1py4sQqnpGa2l
         8sktwtcnJHt6WGYQkA3M8QscgFXmrXDH9q7p2lLQtNwTOiiw/XRcr5rMYlSpMfjR1s48
         xDdE5polTl5pvZAd6JMIZr8DZCr2G3vv3b8e4GxbY+1yiUyw4Rbx3a7WVQu7qFhYPghm
         E8sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6hgeJ62/5JFbBGb2/BWU28kBEHsth09slafCht0x0wo=;
        b=eT9Bn9qPER4UGIgOPkc+miyQbQXyz8SBMqW8BA29aftbYyKLncawXaSQcxXnEl531c
         cD1RZQTrIZGE6RGsgyb0zZ2VblMmMW5IXoGpS+K+HepxB98LxEXA1ZfDgGi4k//iwcrH
         +Z/ie4wdIPhbuDKwduDbvtZ5pNCikoeBDGjgRDwCGREJihe/Cc0eP7Lp0M3VVE3Tw2Zu
         7x6PlXx5RY9F/Dk0MhbS/wy5xUFWCG2rPcY2KeW4pWhkfkrmH/QK//IbKHStU6vMdm9+
         m9uz8OjCiFJMknmwDfusd5aH5agovdL/R4Um2Ko+ZxNTTxcZEowuVS2Rm/SD2vsV4ZIQ
         /NYg==
X-Gm-Message-State: APjAAAWeBHGK8Q+auMn5/9GM/WZvZokxLA57T6+vGu0S/jzLrwgj8rOh
        DXvQ4Sf64HrNXyCFiqOqyA4=
X-Google-Smtp-Source: APXvYqz4w6jdewKvKIODfziharE3s9njqqXb8/bD39yig/yHhir3cTSq3qnBHXJMTyLO5EdeuR0Ltg==
X-Received: by 2002:a1c:67c1:: with SMTP id b184mr3077490wmc.12.1557410701498;
        Thu, 09 May 2019 07:05:01 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id n4sm4929184wmb.22.2019.05.09.07.05.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 07:05:00 -0700 (PDT)
Date:   Thu, 9 May 2019 16:04:59 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V2 02/28] PCI: tegra: Handle failure cases in
 tegra_pcie_power_on()
Message-ID: <20190509140459.GB8907@ulmo>
References: <20190423092825.759-1-mmaddireddy@nvidia.com>
 <20190423092825.759-3-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CdrF4e02JqNVZeln"
Content-Disposition: inline
In-Reply-To: <20190423092825.759-3-mmaddireddy@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--CdrF4e02JqNVZeln
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2019 at 02:57:59PM +0530, Manikanta Maddireddy wrote:
> Unroll the PCIe power on sequence if any one of the steps fail in
> tegra_pcie_power_on().
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> V2: New patch to handle error cleanup in tegra_pcie_power_on().
>=20
>  drivers/pci/controller/pci-tegra.c | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--CdrF4e02JqNVZeln
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzUM4sACgkQ3SOs138+
s6G6vw//ZlsjzvQq+kNiozjqfF+5tWoDBYISiX4LL5kIRZ7AuoP5rk/FWwBP1QAl
ONLeFgXNzcbxXlIwvbWyEF1ls+zM3Tjo9cd//0nUOvdRr44nvSvT4XAXv3QwhyPj
XO4yZonLvXL5fh2YxXkrX/vvG6dEfTk+aY+nrBil8Aojq9kwczLgK6pnTDuDQRNf
gECbdjKmlRHLMamLb2hqnzSjWDV0cNdF3y0c8lsjeo+unSDRx2zJ5MJp6VOHyRj4
8/MpuUfsV+ozusZeUYtWJPp2Vxdc3v/4SM9zOx9rDEB3kdZuO4WnEE4FKD39viAm
4lekg9IvtK1VBG3MyS9wCxlHAu+WvFoxe2asFmy51zsps0Zc1UzXnPRp5hU1q+C5
1JGArhghofw6a229Ki2IaV/u68DglkUR6QivB4yxdHODxO5/w21S1CC9IU9Rn4OO
n0qq51KSGqZbN8dQaRUo2EOEFxxIZ1i3mJqltKOIJ4gutkQ7GJR2gX02KwFT6/x0
j7GLq/qqGAV686hQAFVkoYiurwbMmz2MlsnHJ4ZdqWcqjj8Is+jtHpCBiIPPI29u
94WIPIiy0I0IhJz0WuV7f18zFY3DShrrTffuy5Bdchll444OD/a9OV7gSl/J7zrk
9yPlgGbxzgHBjqEsvmX9OrcEe0YTcQ0rlaXNtFME9NwuzrLmzaI=
=ENnA
-----END PGP SIGNATURE-----

--CdrF4e02JqNVZeln--
