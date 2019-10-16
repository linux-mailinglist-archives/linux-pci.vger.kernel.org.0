Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB90D96F1
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2019 18:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404130AbfJPQT5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Oct 2019 12:19:57 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35892 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388413AbfJPQT5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Oct 2019 12:19:57 -0400
Received: by mail-wr1-f68.google.com with SMTP id y19so28793556wrd.3;
        Wed, 16 Oct 2019 09:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h9IW++BRSCNxbhtWy0+HMRJFW/nVXeIQcj8HcjgdNbY=;
        b=dhdBgUIWoG0Q6FjxOVwxi5mUVfLXYZdImiZzS4VnexZpFnTvELNjCSoPRub6BjyjPX
         QL5SGLNmHCdeFbG/uQdNZIuTYM0ccOnlkC58gmmeYy5vrZJj97GW3fq3oMIOEtCOuNkd
         1BXI99+UIdcWygw6Bptg/7fmuM3bul01qMVVcmzY59Csr0XgprCo6RcvIMRw1jScTlSP
         3YpvHsFVmiI9COwGRh7r54hv2ocRq+tUY4wbKNbfCq4JsDVehfhfZeDxsGcOKNeo/GBI
         XS9WbRQTvS2HcLbW7QZW/t/sVibICSFKqIfcK7fFuIRt4y+4REnbiTTTJviWU+B1g6Vh
         cB/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h9IW++BRSCNxbhtWy0+HMRJFW/nVXeIQcj8HcjgdNbY=;
        b=oR93YsftRixWSTl97XQM1OSdm5vLCD9q18gDmkwux5FshisneL77ET0mDfkFpWp6Dk
         LHPVkPRI4ye/tZIZnfR6RU6HTGWdVm032P7/8QGFSeqCGBR74sn5Uh6/M9zaYAJ5ua9e
         Jp6sWVSrofLzsA1M/xiPWWqzV5IPXKBDST1Nwu3/olqHTWYKexZXkRZtZZQE5qjsQqsA
         xEPf5VJGVPR4hCyFaJ5bYD+P8A7H1pa1l7ZJU8Yp+9n5S/qOop6rqtgPFXQJJSlazTsx
         z79dPzUE/0b0WAUiDlGhUoXxVOZtuSUKo7BksY8M30B/jHA3BZMhwEBbIoAdCbBi8pKE
         +1ww==
X-Gm-Message-State: APjAAAXZffXYsHZRtdklXRbphVUfrSNXDUjl7s/XhDLCWzOl/nauXWmx
        xdQIUNDn7zMcc7tJLLQ5eqI=
X-Google-Smtp-Source: APXvYqyw+hlPiIThyc4HMTeX2noy1aYYoJVRKLh1zberL1OrlN+vywZ7st0nieD+jJH2oLZYGdL1Dg==
X-Received: by 2002:a5d:43c1:: with SMTP id v1mr3545837wrr.91.1571242794848;
        Wed, 16 Oct 2019 09:19:54 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id v11sm2941372wml.30.2019.10.16.09.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 09:19:53 -0700 (PDT)
Date:   Wed, 16 Oct 2019 18:19:52 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com, robh+dt@kernel.org,
        jonathanh@nvidia.com, andrew.murray@arm.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH 2/2] arm64: tegra: Assume no CLKREQ presence by default
Message-ID: <20191016161952.GB2526111@ulmo>
References: <20191005164212.3646-1-vidyas@nvidia.com>
 <20191005164212.3646-2-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KFztAG8eRSV9hGtP"
Content-Disposition: inline
In-Reply-To: <20191005164212.3646-2-vidyas@nvidia.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--KFztAG8eRSV9hGtP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 05, 2019 at 10:12:12PM +0530, Vidya Sagar wrote:
> Although Tegra194 has support for CLKREQ sideband signal and P2972
> has routing of the same till the slot, it is the case most of the time
> that the connected device doesn't have CLKREQ support. Hence, it makes
> sense to assume that there is no CLKREQ support by default and it can
> be enabled on need basis when a card with CLKREQ support is connected.
>=20
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra194.dtsi | 6 ------
>  1 file changed, 6 deletions(-)

Applied to for-5.5/arm64/dt, thanks.

Thierry

> diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/d=
ts/nvidia/tegra194.dtsi
> index a312c051448b..11220d97adb8 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> @@ -1186,7 +1186,6 @@
> =20
>  		nvidia,bpmp =3D <&bpmp 1>;
> =20
> -		supports-clkreq;
>  		nvidia,aspm-cmrt-us =3D <60>;
>  		nvidia,aspm-pwr-on-t-us =3D <20>;
>  		nvidia,aspm-l0s-entrance-latency-us =3D <3>;
> @@ -1232,7 +1231,6 @@
> =20
>  		nvidia,bpmp =3D <&bpmp 2>;
> =20
> -		supports-clkreq;
>  		nvidia,aspm-cmrt-us =3D <60>;
>  		nvidia,aspm-pwr-on-t-us =3D <20>;
>  		nvidia,aspm-l0s-entrance-latency-us =3D <3>;
> @@ -1278,7 +1276,6 @@
> =20
>  		nvidia,bpmp =3D <&bpmp 3>;
> =20
> -		supports-clkreq;
>  		nvidia,aspm-cmrt-us =3D <60>;
>  		nvidia,aspm-pwr-on-t-us =3D <20>;
>  		nvidia,aspm-l0s-entrance-latency-us =3D <3>;
> @@ -1324,7 +1321,6 @@
> =20
>  		nvidia,bpmp =3D <&bpmp 4>;
> =20
> -		supports-clkreq;
>  		nvidia,aspm-cmrt-us =3D <60>;
>  		nvidia,aspm-pwr-on-t-us =3D <20>;
>  		nvidia,aspm-l0s-entrance-latency-us =3D <3>;
> @@ -1370,7 +1366,6 @@
> =20
>  		nvidia,bpmp =3D <&bpmp 0>;
> =20
> -		supports-clkreq;
>  		nvidia,aspm-cmrt-us =3D <60>;
>  		nvidia,aspm-pwr-on-t-us =3D <20>;
>  		nvidia,aspm-l0s-entrance-latency-us =3D <3>;
> @@ -1420,7 +1415,6 @@
>  		interrupt-map-mask =3D <0 0 0 0>;
>  		interrupt-map =3D <0 0 0 0 &gic GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
> =20
> -		supports-clkreq;
>  		nvidia,aspm-cmrt-us =3D <60>;
>  		nvidia,aspm-pwr-on-t-us =3D <20>;
>  		nvidia,aspm-l0s-entrance-latency-us =3D <3>;
> --=20
> 2.17.1
>=20

--KFztAG8eRSV9hGtP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2nQygACgkQ3SOs138+
s6GU5Q/+LV/SE++KyetHQKYMnNis8n7U2swfFXdv1B7ZJkbmd+LW7O2E1lRq8z+1
JJ+KsZwWs3tOXEezWuNL0Q8s5x6y+OrdPJ0GComdlBZ5bXOcQTf4+XbE6tYRwsmp
EV8/uSFQr0AHVCJBffDk+IAbPH0tjCWKo7NQkIXTX6Bf4LR5gfYdTkYuiYGFkmPz
yissUISHDcM0XGn135Hft6t/fpGiNOGwfBSWr/XsPDsT3WMs7/5UnK0aimMNTQdU
Uvz0CCC1dJmNudilYczX3fZ1gJ3kDm/o/ioq3/SZER+xgOkEZG58YBTJP+WJln1R
cKQXbCKCex/AQWq1L9FQAt+Rky1+iyuHE6nGLZO8c3k+dYKIQ7rAe4Vz88VyCu34
n6VRr/tYNK6p3aSgWIrOYPI6XmQoT7+KzniccBXkUUTEOV+XnPfP65DEbmJ1cCDl
d/X398HrO9O+YOp1A9v7nLf6ksM/yN/nQd2b7zW/CjrMMzRxtfC+7ThI0syMHCsO
vHXbgMWi1niBEoVp7Bse6hs2X2VGrbmmdmRD1phA6h+I5uVtW8LL14HuX0WKF5ar
VWio3vWpdP2Vy8Z44I+wE8y6ILxBVV0a9aW4KVBM4CvAg3ZvFadDSMkP1oHLoIqj
uSYxjyoKeuUWOpxaTkzEQuE/MB+DTZegGjlj1omMSWw9Y4u9n84=
=dgRG
-----END PGP SIGNATURE-----

--KFztAG8eRSV9hGtP--
