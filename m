Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A016D7CFD
	for <lists+linux-pci@lfdr.de>; Wed,  5 Apr 2023 14:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238076AbjDEMzO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Apr 2023 08:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237957AbjDEMzI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Apr 2023 08:55:08 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F88659F2;
        Wed,  5 Apr 2023 05:55:05 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id w9so140847337edc.3;
        Wed, 05 Apr 2023 05:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680699303;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H4tYbZenNBkxV/FQRg+S7v7n3Mdw3SCk0TngrP6puJI=;
        b=eCW2LWCImKLG5aOQZZGbDSM1LV6ho4g+la4QiFIZcs/lhY2Nl4o8Ir+NCvJKWHn6iV
         43HL2brd+yUUviB1ugm1UlHsvqGeDSkEYfZnGS8+jtcH+x20iSLxr0bF1CVoEPBJYUhh
         tAnEhj9J9E+qMd/lWJqVjo+pyB6/kADIHmoI8TVfJAhwqKQQjssspAdscYclQHOzxE52
         84jrYYsaZsTmCgBDXzOGDWvsO+lQE+vh8SzwHruLsbSuLD/eGsCTdf3FyxINekwZwIyR
         2mvP8dj70Q7NqwsK4VlVkax/Ajk8TPqMx4PfxEKukrRldiMBcoSdlxMljXGuEYwYUtwR
         JlCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680699303;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H4tYbZenNBkxV/FQRg+S7v7n3Mdw3SCk0TngrP6puJI=;
        b=sLvD+hbXF7LoMQODcPjyVgckqDb+jSUKzv8T4ALpKS7kNDfZ32V4/l0IgtYCW61CGC
         QaxN1nj1coggIPz3anZsJzFNXb7wAD7kaEZpwjAIiGXFzBcg15sgg3lARqHbPKXeWinG
         ossnLnBEBNrfuY0GebSRA+b+CfY2cXThMFJEh5F6aVsLlPiq7COGTi8/sY0hq+5Ypi/w
         DKghhUGmk1/fdccxuk7IHlMR0ASQHM4C2xdiP4QiWnKrMUd9kQMMYf3uCL7rthilb6sV
         p2VO7YTHyh5xuOzh2On9rWVrJbBs0Q11I2gH3sW49PVkpUkUE+tvZJF7GLmYyHdAJTbn
         u1QA==
X-Gm-Message-State: AAQBX9fLOJhQ0NAihTghZSmAv6ipkiB0MqRC6iGZLPZ7osrYzIYd8xPS
        q0WnHMBIrULwM1JsUWwPcvY=
X-Google-Smtp-Source: AKy350YS4PSOZvCF5BvFFMUjCIDyAM5G+I54ziVSBDSouJcPLsBCfOtfctRr24S/oA//wxQ89MZv1w==
X-Received: by 2002:a17:906:c005:b0:947:55ce:1217 with SMTP id e5-20020a170906c00500b0094755ce1217mr2711864ejz.73.1680699303642;
        Wed, 05 Apr 2023 05:55:03 -0700 (PDT)
Received: from orome (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id a10-20020a1709065f8a00b00947c0df0fc4sm6871792eju.19.2023.04.05.05.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 05:55:03 -0700 (PDT)
Date:   Wed, 5 Apr 2023 14:55:01 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Mikko Perttunen <cyndis@kapsi.fi>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: tegra194: Handle errors in BPMP response
Message-ID: <ZC1vpXRoHb3H2alF@orome>
References: <20230208142735.3218707-1-cyndis@kapsi.fi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uk3AIlB7GyEsN23u"
Content-Disposition: inline
In-Reply-To: <20230208142735.3218707-1-cyndis@kapsi.fi>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--uk3AIlB7GyEsN23u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 08, 2023 at 04:27:35PM +0200, Mikko Perttunen wrote:
> From: Mikko Perttunen <mperttunen@nvidia.com>
>=20
> The return value from tegra_bpmp_transfer indicates the success or
> failure of the IPC transaction with BPMP. If the transaction
> succeeded, we also need to check the actual command's result code.
> Add code to do this.
>=20
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  drivers/pci/controller/dwc/pcie-tegra194.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)

Lorenzo asked whether the error check could be incorporated into
tegra_bpmp_transfer() in reply to an earlier version of this. It would
be possible, but I think it has the downside of loosing some context.
The end result would still be the same, but it would make it impossible
for the caller to distinguish between a failure of tegra_bpmp_transfer()
and a failure of the message transaction.

For example the cpufreq driver checks for msg.rx.ret =3D=3D -BPMP_EINVAL and
if that's returned will mark the given cluster as not available. This is
special behavior that only makes sense within the context of cpufreq. It
wouldn't be possible to make these decisions if tegra_bpmp_transfer()
did some automated conversion and effectively rolled the message error
into the function return error.

So I think this will need to stay as-is to make sure we can handle these
errors correctly.

Acked-by: Thierry Reding <treding@nvidia.com>

--uk3AIlB7GyEsN23u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmQtb6MACgkQ3SOs138+
s6EQag//SeOpJ8NPsSwZEk/4IYWE/s7a21ssZ/jZ+ZPty3DnS2IqhT7rD0om8eBe
X3s7zT5xt35Qwi2i4+aaTVkimdt+zdYM5oDapFX/dOiC5irW1PCpaScroTvbObYP
N3dQ8wztuJagGolWvt1SyiuwXMt5wuIAYo/RcnlDg9iozvgo72KoEnEmfrMfEPcb
pLwmFOAP5I6abuzeHDBtirw6AZvWcgcmnngFQN0ZEa6q7QmXw4qiuYBN6yZsIw/U
H5ecgOqEOtZKO4nN/xsIRbnvXIXsTA4Y05jMlGR+1xEWKhUaJQ+z2RpbeUG8+U/h
sAR2TxJVVUeyj7UNOayxFNf/oO98GZfQi/FycYPUJqr0h9IH3vAk4vh9QchiFHCb
tOi1K6geT+doP1lkOFcQ3eizqu6T5ocFY0f2NFbakPXaFMkb3pJNYK7Wm6/F9O03
slL82TZALrVbEwRuwdLclSqB0+rwp5mCiytwE19TVzQp7dIxQLjkTB9bX/vTbgkv
r/7Mt/p5n8NmTWYIMYmHlzgeBF0EHDVeGB6znLbQ4ZSPBDN/mZWFLJ8XpE5Nlli1
1h8t/M/W/IA0ZSW8gW2dcXXd678DAC+p2C3bcCA56zYh6Jqh/WPDM2StL5aBLZo5
pG8lg2/rtzbnIqx5O33oqoUpcwArJtGiaYqox8r5lH10p9i+ZH4=
=Hkx5
-----END PGP SIGNATURE-----

--uk3AIlB7GyEsN23u--
