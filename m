Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3B6818BA9
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2019 16:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfEIOYa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 May 2019 10:24:30 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38137 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbfEIOYa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 May 2019 10:24:30 -0400
Received: by mail-wr1-f65.google.com with SMTP id v11so3348772wru.5;
        Thu, 09 May 2019 07:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R1zkH+uNvqyoR6ao/ag+iZqyWZI0bXI3moF9zcMrZfQ=;
        b=Q+a9EOcGLnUA4mAa2sgrLt623vGCZsXpq7Fky85GNrsNaU+qRi2lYxk90UW92OPJvg
         7rrLYjZGjQjqRDTwB8LhWh2TD6rUc4HZLhQzWtMjX1PBSfGrecaRMfocvM8OajWiid8f
         5JxK/pef8HbMUTbsXOHDPycLSnGWmyCmkW1dwvXmv74O4i5j2iwIXE0jZ8ywzRnmRNig
         VSrKAzluIedhWXF36GCiNwaD3ed3T77e065VoWiEuRvmKvNjUSG1yWMCfZikcLgNk58U
         +3yQ2HYPNZKwRigiMdi3FNjJUmnnQVSdpQPmp3WJLONdYUcdes7tv9/YMNwpecKDxBds
         HUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R1zkH+uNvqyoR6ao/ag+iZqyWZI0bXI3moF9zcMrZfQ=;
        b=Me+1r/dj6zrg+J0z5b6aPzCXqCFOy9CwoDtF9Xlx/FDOfM7w8jBh2EwFC1qpl2T0hx
         KNBMwm+7cy8UtOGBvE0xSa6lz47Dq7KBBMSxTfq+/HfjcxEsDBCdclhTj4h0eIsSevq6
         T70IOBPDe7xk8CtFZnnErQiqX+Nlyil0dKjxBvkkloTdW0TOWpVh31SQ21/tHj+wyF/1
         OO76AaiUyOFkOxWHdlCcs6PM5DT+sNc0SoauyU7JhAIXTgss2An0ghOFX22exe3oI/o8
         QnmL/+ct6QWOU6a14dh5xuEEqcAdoGPgLYwlIhX0lcEVebga14TWaVreHk0c693CurJU
         Mcbg==
X-Gm-Message-State: APjAAAUwjqsYrl58yk3YnXX+KMWumZVFlCE/6LFGJRWs/bcCwcjcZOJa
        sdtnu8XgAsshqeA0LlaD9Qk=
X-Google-Smtp-Source: APXvYqyBXl5x42GMsP3VnNw5U0sd3Qu2gl0GQ56ycm3uA4I64WCuKnZiIBRo4BAsGONZl0LbOVWqAQ==
X-Received: by 2002:adf:ce07:: with SMTP id p7mr3354185wrn.47.1557411868531;
        Thu, 09 May 2019 07:24:28 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id a5sm3055755wrt.10.2019.05.09.07.24.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 07:24:27 -0700 (PDT)
Date:   Thu, 9 May 2019 16:24:26 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V2 17/28] PCI: tegra: Fix PLLE power down issue due to
 CLKREQ# signal
Message-ID: <20190509142426.GN8907@ulmo>
References: <20190423092825.759-1-mmaddireddy@nvidia.com>
 <20190423092825.759-18-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2+jOUFLb7N+7fooZ"
Content-Disposition: inline
In-Reply-To: <20190423092825.759-18-mmaddireddy@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--2+jOUFLb7N+7fooZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2019 at 02:58:14PM +0530, Manikanta Maddireddy wrote:
> Disable controllers which failed to link up and configure CLKREQ# signals
> of these controllers as GPIO. This is required to avoid CLKREQ# signal of
> inactive controllers interfering with PLLE power down sequence.
>=20
> PCIE_CLKREQ_GPIO bits are defined only in Tegra186, however programming
> these bits in other SoCs doesn't cause any side effects. Program these
> bits for all Tegra SoCs to avoid conditional check.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> V2: Corrected the comment in driver
>=20
>  drivers/pci/controller/pci-tegra.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--2+jOUFLb7N+7fooZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzUOBoACgkQ3SOs138+
s6FxQg/9GCN23PoKSSVWK6D1A6kDYJxTlVQHCvhRE1I8SGKzUdmBGcsZ90xwqrUg
m6AF06HCEFxgXOJAbg9bF9+jwXxom42/C9x8mJ3lq5hXH2vfZvwPZjtUdzc7IcNp
K8C4tLb9fGKcZlPR1AFZuUf2eC6M2WQQtnKrJEr17C+ngdAS0K7b0+1vfzBCHClx
hJy2aYXus4PYne0EwHI990ycRyPSk/MDD/SKlwu8K0TVcVfWWtW0ahio0jhnt42K
cBXLTymRTGk98Gnrp4MunSt3N7QO5A42LMgB2zko6vv9oSHxrf41cggO1x1cSCS3
a0wtLq0REUz2cisatxsNNeVYWTvD9aLeYEti301JqzPHq9MIOa6jIeuTlHKfrpqJ
Ft2P0G6ZfdDydQ9AOBAT/S1LVRGEVsyQwbKKT4a9/6oxuPgWxCl+aTDpjRBezhFy
HuSR2oW4Qwoj99A3ZlFvp1wYIduIeU0Bv69O2YyU+Xr9NuGNXGp3XRrJWL9UqiWz
Az74oT3ooNUVM4684HSMmR6paZ0mIpz7UxtOn55Z43xyWPqPB4Pa5wUda2tc9oYF
tlHQnFtip+2MVbheGZaREowd4FEVWkG504jnbyIVGt63HhI1ErHiNfoDEOOEBUIh
C8fQ9PFFCsDnqrzW/tQdkzFvQ2jzNWJOUCRO2YfzOabV8XzbEK0=
=YoN5
-----END PGP SIGNATURE-----

--2+jOUFLb7N+7fooZ--
