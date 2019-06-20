Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37CCA4CB9C
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2019 12:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbfFTKOx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jun 2019 06:14:53 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52789 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfFTKOx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jun 2019 06:14:53 -0400
Received: by mail-wm1-f67.google.com with SMTP id s3so2471797wms.2;
        Thu, 20 Jun 2019 03:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HPGqRV7rOEUmIiSVtD5jDMDuo6VzSp8RvNIR3IGT5hI=;
        b=HZ41KNhFKIEN1grTwzRIzbStW6DUntTVHQ4Bl8rEYKZzY/O7fTUcGi2D74m8VBbUE1
         WO2EduKokcZkn5Ghc2LDdsMI7EQL5QEBSqoWXsy25t+8dRG5hLK6vKgYo1DEbaFUrCxv
         n7jXCrlxmqFqYcHyVblRGJVcVcUTH6frtRW+8r0xjS8r5t4/KFT6OLClC0Y2xHD6DOAs
         Se2RgUhee/yz2wkiVw6/vuKGLlqsSGhnB0Nk/ysbu4Cf4Tn985htXaiivHkrkJEb435Q
         cT8qzCC1VOVDftku5fxXDwvH4ebFuuu4DSkYuP7Z55VQGPACZ2SjA+VbVzLSg/xQDZip
         nVLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HPGqRV7rOEUmIiSVtD5jDMDuo6VzSp8RvNIR3IGT5hI=;
        b=FcUfC1MdNbYeFxNlOaRgngo+8AZvm/kpgR0+uj6Mrrcj4AkWNex9iJdzKI8iyBh3d8
         k1oLxkaFadtycoDVkcMjhbWfpejuk/OFp4mhM//wrm1HA57BgLZD3WZaN3hhxPCKzRc2
         YeJYbrHoWq3tTyG6iJxjlMEpWm0I0uMzimJsWNKzDzFQ/X7fnjr8R9dn0lAuytgiDoS5
         JtMqmmTX39M/MkRzb/SzIzr2DISZxnx2l1on/HzW0wsZDVyM101PhCcdlimHYDF1OZAd
         kKSV/i+1i7pRcItD6ulpNbVTji8RLxbcYxYAcJThivPdjfUaaA9rnxNoqnXttR2kt+J5
         sPZg==
X-Gm-Message-State: APjAAAXu+PQcEzp7Qwg968vTJckpJmRHXWFnyDiLjKwC1mDCsljO7+BB
        77MW8/Eo387SwxV6nQxDeWI=
X-Google-Smtp-Source: APXvYqyPevWpvgE+vuuR++TovGp8RNqztfXMYzlbfUnRtCPYTYWI5/vpMhZLFgoDzROa/mfDxXqYdA==
X-Received: by 2002:a1c:1f06:: with SMTP id f6mr2329541wmf.60.1561025690769;
        Thu, 20 Jun 2019 03:14:50 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id a64sm7944482wmf.1.2019.06.20.03.14.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 03:14:49 -0700 (PDT)
Date:   Thu, 20 Jun 2019 12:14:48 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V6 23/27] arm64: tegra: Add PEX DPD states as pinctrl
 properties
Message-ID: <20190620101448.GA28703@ulmo>
References: <20190618180206.4908-1-mmaddireddy@nvidia.com>
 <20190618180206.4908-24-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
In-Reply-To: <20190618180206.4908-24-mmaddireddy@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2019 at 11:32:02PM +0530, Manikanta Maddireddy wrote:
> Add PEX deep power down states as pinctrl properties to set in PCIe drive=
r.
> In Tegra210, BIAS pads are not in power down mode when clamps are applied.
> To set the pads in DPD, pass the PEX DPD states as pinctrl properties to
> PCIe driver.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> V6: No change
>=20
> V5: No change
>=20
> V4: No change
>=20
> V3: No change
>=20
> V2: Using standard pinctrl names, default and idle
>=20
>  arch/arm64/boot/dts/nvidia/tegra210.dtsi | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

Applied to for-5.3/arm64/dt, thanks.

Thierry

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl0LXJMACgkQ3SOs138+
s6F/mA//fJQuFOTfEgBtJKU2ttaAA4tljAjtpXw+rmm4/rRxiamPODEAxhM5h/mt
YG9YYN0Q0BJQcFOQVa34OOIVhkkf1UZDWrOhfYDuEqXyhjlS1rysGSmsGH1W9+fM
CKbNflkRjMWt50+XsrN+izdmtJop6OVJB3T9644ERt2N8s9sc46P3gPlPoXL9rXL
w5yB2IvEG5wgRBCXYZzjiK2BBbaKb8EgXy/nhtd8UJZQbNx2YVWf/v8DGtmOUfbJ
aTy0LvMJwFDkpf88+6Cgg4Ouh+n2PBZHifMCWdJy3WOTLMVx40NCbq5BAIu1Ziot
nBSEs0Lvc1fOI5iEqdRV/bFBnbC8h88sWljznaqVBT/fKL/g8Te8a+hBmym4SlkY
ULN/CZmcpbzDEcPLXwje3sK62OEEL3hAXBaxQ/DrugTT3B9svrg42unVCn3ByCyC
TGcTqE9uA75PFT7nyCEXLXXJ2vzV5GZKaPYbv//J56UWiuSO2Ly7d4l4n76ppvz7
gM3Nl25OnKvyWT38/cD9HxNjRxYjqYLVXDFw13BBhKNgpxFXpivdKpAiPIMq63Kg
eCjZMcVWnBgo/wQ5sgjnk7ri7g3t4vCcjQE+9ClaU4OMi7eaWH+18iR8csNoa4ZD
Anh9dzE/ZKXPjU1uw5vUNkO91oipN7x82nFbGojSZz/aer0XlnY=
=W9FW
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
