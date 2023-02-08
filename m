Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A883368EE34
	for <lists+linux-pci@lfdr.de>; Wed,  8 Feb 2023 12:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjBHLou (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Feb 2023 06:44:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjBHLot (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Feb 2023 06:44:49 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5599B442F1;
        Wed,  8 Feb 2023 03:44:48 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id qw12so50553132ejc.2;
        Wed, 08 Feb 2023 03:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pqBkYIBK1hoc+q0fmTaYVvMN7XPCuKZqqpnhWJ7rdH8=;
        b=cyZc3HzsVQsKEzq7oFQGbWktkPeTpE8zfRKrl+jjhgB1IIVGRKJlachTAAswT/104d
         vW0i+kclRr5iOsWeUAo+ZBAkxT55Z6hU6F/pxjbrC3+pnaNQ1si8+goMTY/XpjoUrgql
         o+SkTs9Z5PGp0M2kMIRHErxn0p5NnPHiO1ZwzqPvlbZdAh74YxJo5lJ2AyPjJPjdlNLn
         5Hx7u5K/RCntYtnd2fMQdUHjayTpLIeWNezITpUcmaYmXmKee3mNNSZVhkl8r+M+dolJ
         ripc071jh1lBXdEcNn7oaSTwIRdneO1h3fiRTCxQ2Jir7ocVKzsVaPZoVre8ZATtIpZw
         HJAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pqBkYIBK1hoc+q0fmTaYVvMN7XPCuKZqqpnhWJ7rdH8=;
        b=T+agEDWHxhOGPo42mYTB5UGgCjghuWgd0q4fPlCyE4FNSGn74SLX4cO5CVKWm7jlsm
         iAZvKqs/ClGs8yBcOQogpoBoEDNH1kKM/rTe16tVRTzW/pRbA3YSt9OVZPZwEyKvbOIZ
         LUADrm+OPZkA9/d1xFaCvhbnZn5ncoikTFw0geFP6eXgCdLYve7tcAUjqquobZujC3eT
         MDFWCZZxd3iRvukGssNJanSRIY8k6XZdT8TYx4gWApykCTBLMVDwYpf5EzV1T5W6alYB
         MHUizbVghyfNBlhAWVKS4ydztugKg2ZOM8vwCl7Hgivo8/8VHC8B4z2I73lgoeCKMH4F
         OCPQ==
X-Gm-Message-State: AO0yUKUC9fjzqhlu/DV4YfdFOoMRj4VBwmMil3QIN2H0pPaGCNQJsQb7
        cRQjHBKT+6mx1tSZN/tfdws=
X-Google-Smtp-Source: AK7set/Fj+mCU2u4KpkhWtzcdvqobaDl8+gyFyBgNpzfIpZ6MLCkfdwxMdPlPtLuO5Me2NOmhTxAlA==
X-Received: by 2002:a17:907:1c83:b0:884:c45f:1c04 with SMTP id nb3-20020a1709071c8300b00884c45f1c04mr10573906ejc.2.1675856686825;
        Wed, 08 Feb 2023 03:44:46 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ke28-20020a17090798fc00b0088991314edesm8123593ejc.7.2023.02.08.03.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 03:44:46 -0800 (PST)
Date:   Wed, 8 Feb 2023 12:44:44 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     bhelgaas@google.com, petlozup@nvidia.com,
        rafael.j.wysocki@intel.com, lpieralisi@kernel.org, robh@kernel.org,
        jeffy.chen@rock-chips.com, krzysztof.kozlowski+dt@linaro.org,
        jonathanh@nvidia.com, dmitry.osipenko@collabora.com,
        viresh.kumar@linaro.org, gregkh@linuxfoundation.org,
        steven.price@arm.com, kw@linux.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        vidyas@nvidia.com
Subject: Re: [RFC,v14 2/5] of/irq: Adjust of_pci_irq parsing for multiple
 interrupts
Message-ID: <Y+OLLMrHqMCrHxLB@orome>
References: <20230208111645.3863534-1-mmaddireddy@nvidia.com>
 <20230208111645.3863534-3-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="v95VmpPpGmMBEVze"
Content-Disposition: inline
In-Reply-To: <20230208111645.3863534-3-mmaddireddy@nvidia.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--v95VmpPpGmMBEVze
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 08, 2023 at 04:46:42PM +0530, Manikanta Maddireddy wrote:
> From: Jeffy Chen <jeffy.chen@rock-chips.com>
>=20
> Currently we are considering the first irq as the PCI interrupt pin,
> but a PCI device may have multiple interrupts(e.g. PCIe WAKE# pin).
>=20
> Only parse the PCI interrupt pin when the irq is unnamed or named as
> "pci".
>=20
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
>=20
> Changes in v14:
> Address Rob's comment on using of_property_match_string().
>=20
> Changes in v13: None
> Changes in v12: None
> Changes in v11:
> Address Brian's comments.
>=20
> Changes in v10: None
> Changes in v9: None
> Changes in v8: None
> Changes in v7: None
> Changes in v6: None
> Changes in v5: None
> Changes in v3: None
> Changes in v2: None
>=20
>  drivers/pci/of.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 196834ed44fe..ff897c40ed71 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -429,9 +429,17 @@ static int of_irq_parse_pci(const struct pci_dev *pd=
ev, struct of_phandle_args *
>  	 */
>  	dn =3D pci_device_to_OF_node(pdev);
>  	if (dn) {
> -		rc =3D of_irq_parse_one(dn, 0, out_irq);
> -		if (!rc)
> -			return rc;
> +		int index =3D 0;

No need to initialize to 0 here since you're assigning to it immediately
below.

Otherwise, looks good, so with that initialization dropped, this is:

Reviewed-by: Thierry Reding <treding@nvidia.com>

--v95VmpPpGmMBEVze
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmPjiywACgkQ3SOs138+
s6FFWBAAjd2UbNIacqzrXJOtdU+WBjvCkgGerX8q/xOzDljt+WqdwHORW+tt9gCq
vglBKd9huBKGPu+CiVuRmTxfczpIc1QFORetj7N8oJUlgi9upg6OwXCOBftU0ywa
cU96BM9XqENm+00xCO70qZu893pE1805QHLpeMb2ydYSFORoxKSZQb4TgQLe6Sbp
nmp4bndWeBjfeiWTn+3Ot04N3VBInz9+Lby+WrFs7s/Gr1wrrCAQTMbnIDB+O448
NDZBsSe6DJ2ONPTGiO65dJ1NAZJXcdlxPqSEwXKA3gp3BbUB4MJHvZ6AeED0EVVd
UUziz1tTCxoxsNmbN5Pw2AxX7gmt6hDRF4MlEL9nk9v3rY2sb7kOv3fFYp44b+F2
ebtxH9fZOsmm9VbPqGelqKx7sJy+7BBEZpKFldo59p3ENiSl5Tt3v6rM9hw51QuF
v/6/wzfkxarm2aXUoGjuXGPBNyIbkmGxrZPSEb1tMCx6JBKRVYxrOH+cA/T4FuLt
T6Gf67tjzYUyWZyRnUAnHq0awcOg2jIsYK5n0HhTJiB8iFHUXkuaMqCikxkAdL4p
QUbksIk5s0ai8T6G8yvXNdGMBjl7W8kv6y8Z/Dok8+wMRAMEIVfCt0CWEp1r9Ji0
Ly8iZHMYmoxHjAG1JtzBaI6NN/Y8RcSOaBosEmFv9euM/MmiYHY=
=7+YZ
-----END PGP SIGNATURE-----

--v95VmpPpGmMBEVze--
