Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0915C18BEB
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2019 16:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbfEIOfx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 May 2019 10:35:53 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37001 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbfEIOfw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 May 2019 10:35:52 -0400
Received: by mail-wr1-f68.google.com with SMTP id a12so3410766wrn.4;
        Thu, 09 May 2019 07:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U4x3+sqtarVOe/iKrBiqWOZZlMRmnd9hUuQk4hXNmeY=;
        b=ANmCfmq8Mq2CS0M2bf93voprX/bTIN3FXowo9m8oiRl43U8IWS64Cj+BzuUztEP2DA
         2KaacKgUGb5x8msFEEvTAJCf29mwrcincmMKZ5egHCeL+mAeJkBSvWO0T5I+44gJYUo7
         OZbNbz0e0c3vb4bDCLV7zwck173RMBtYDjfJhEW1oIMwGCWviT+FMgunmW8K0PHKZ0PB
         BbmkS5itWkMU8APuxEG3M0EHDhaWP9Kb0BDZC6pGXmZVPtlU9GPJSfKWOmhVwYfH02NV
         wxE9n4OTLj4AAvkItqFOTPF77RU52qySX+M5sCYMU/Zui9PHnGEAaBgyqKH4O5/RfJ0w
         0BTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U4x3+sqtarVOe/iKrBiqWOZZlMRmnd9hUuQk4hXNmeY=;
        b=SryohzUW8M8P0TjF0pKSm7BiNaXILhOny2+PUNIvOYu20ZuJyPSDKs73Pet3GnQK3o
         L26i4EQoZPkpsSQGDcVMlWg7jOTRafeJzw2LVGDcqXAU/4AxgITHUXAO5Fc5ngGupRQY
         o6BCfgF3KAFNde8Il9rJ5ozxWqcmE0tYa3jPbg6RulzHd5pOkh+yFo5VoQoxhJAL1zvw
         SZy+PxvaE/dkJcAX8UgAGb16PeD1lnh9SuAmHtwk4PCUZkNRV+ovziWC/z1uxGJezlvA
         HzhwbhMY4MLclWl80s4UbKkn5ClgZE5FiJkcHAk16orsW5SfHt8D5XhCM4K6VhAtUUHT
         6hHg==
X-Gm-Message-State: APjAAAXPZjnxAGW8CdN8QJiFoX0bBPPo2oHIsO3GKte5ExXNpBwmD8ti
        7YXI/0Uyi8u8vZ29mokDVII=
X-Google-Smtp-Source: APXvYqwU7Bu8h8AaFkneEbp8mgE78wVyoxIG+/Vd0Zx71GNLLYvtlkmUVpu16zLpgkIl696xWPCChA==
X-Received: by 2002:a5d:6b46:: with SMTP id x6mr3322857wrw.313.1557412550888;
        Thu, 09 May 2019 07:35:50 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id 17sm3083223wrk.91.2019.05.09.07.35.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 07:35:49 -0700 (PDT)
Date:   Thu, 9 May 2019 16:35:48 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V2 25/28] PCI: tegra: Put PEX CLK & BIAS pads in DPD mode
Message-ID: <20190509143548.GT8907@ulmo>
References: <20190423092825.759-1-mmaddireddy@nvidia.com>
 <20190423092825.759-26-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2mNuWrpDTYoom6W8"
Content-Disposition: inline
In-Reply-To: <20190423092825.759-26-mmaddireddy@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--2mNuWrpDTYoom6W8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2019 at 02:58:22PM +0530, Manikanta Maddireddy wrote:
> In Tegra210 AFI design has clamp value for the BIAS pad as 0, which keeps
> the bias pad in non power down mode. This is leading to power consumption
> of 2 mW in BIAS pad, even if the PCIe partition is powergated. To avoid
> unnecessary power consumption, put PEX CLK & BIAS pads in deep power down
> mode when PCIe partition is power gated.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> V2: Using standard pinctrl functions to apply default and idle states
>=20
>  drivers/pci/controller/pci-tegra.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--2mNuWrpDTYoom6W8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzUOsQACgkQ3SOs138+
s6HXahAAjFPWMpQsvEGOlqVlUTWHSBFAFGhPNDZtZO3/1w3FZLLA7z8jAVhF0ZMU
pM9Izyc84Y9P5MNQGXH++noKX6BilbKw1ku0Bdk0IC/jrXXQ8xfmrPy81IrmniE3
xuylXqcdaFtfmveyrtGLWLSKXQBrO0t+UY7qvPFnZpLUVoo4ghWM1fLlIKYT3vMC
+hz9mOMEO4tH0kFKxUFPiN9fROX9JUq2MDCo3pYD8qxqGwWRxvLTolotHAfSJisf
K43ChvCEI4hdOr+6fyBK50/jKLrMgC77XIizFG/F2adqehFsVN3WKerigb/HqLKo
tHeUs5boX5OB1l52TW9dv2VhJMrIsgURK2zyz1zFd2sHiiJkYwS2MioLDn3/s6rB
VPLIIS6vPU4mK99TTH3R4d80JosZ9V5nkqwMXZGtLQP3QSNyNe0iPWJ0ZPHYnb65
ez2fEeDW/nfJ84bEjxZNIq1cB2GPUgOK52Q/sRmFikXd7eEzVFYhG8MhnBpn9iLp
cxFxuehOzD3rDAhU24OUJOjoZnC2qo3qU4Iytdn1BSTWqvBO2W1kHfDnBxwajtUf
DLeINLvoJg0GrRzN7uEWJC0iuGzERE9oXfZdQYOVdUvI8rF80NQ7pfW/+qp2Pt3g
Om/mWgzq/JhpWDD7+hkblTocp9yQMttDDUY+wzxTfsVwID9z4+g=
=hei3
-----END PGP SIGNATURE-----

--2mNuWrpDTYoom6W8--
