Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D58416A722
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2020 14:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbgBXNRz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Feb 2020 08:17:55 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35130 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbgBXNRy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Feb 2020 08:17:54 -0500
Received: by mail-wm1-f66.google.com with SMTP id b17so9363562wmb.0;
        Mon, 24 Feb 2020 05:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r19NRFzZN4kRbe89ETt7zD9XwxtDHTmRBtVVXHTzcgo=;
        b=LTGNvrJnlUxiwdP+18A+r8fdxWzdrYv8AVdSnMRMHPDx+kz4ky1EWBLIn3JpiLdg6M
         uI32ymQleUhetUn4w7BITEwL4XNf4mabQCsyBOAEYYwXly/7v6mQllPNgWiionbwG9xh
         wNfV9OPN8pTx9vdRUrRPRt3ap6avuigeMeT4qvyIOmgnuIlBk3vanCI4HOh3Er/nQz3F
         bck58Ujy7v5DQ7vSBWt9BMMo5uINRLfSaAkMd3qynvUlMTEablQLnxom+iDgqSUXmoic
         mHtHuzch0FQXx90F6EQHDrMh2UYTHBocHRp/TMHZOIwwFNi4mgKRJrlxYN1Atbr5at5u
         1Kpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r19NRFzZN4kRbe89ETt7zD9XwxtDHTmRBtVVXHTzcgo=;
        b=JJM8cSkf+ZQ/bbhrwFq5+r911CoNbr1XqN/Z8PzJwkxMGAIGJ/Aus/xUS5xIdbm9ke
         6cKQKFkeg1n9PHMelqr+u0oULjE9ifzLZkOVEc+gSt1iw++DaqXK/IjRR9SgXwZ6jC4z
         nsto+A/7CqE16fWuv/fbCbbmPnrAS/88C34SYiwLIdKNsEhwBL0lyKaOGl2ZLdkHy5PK
         qLYb1mMELFBbNTx+b5ZmwABSKAzrOS1rOAeGjFFZKvxOkGgk94z1HfjfEo6sKx4YnSSs
         LegMvMonMn5LvVfbAlSdl2ygP3a+8XcIUvEaABH2wMiNF9pEZwLLABpbzXtY6nU3plH7
         vGUg==
X-Gm-Message-State: APjAAAXGAzFSWL4Q9QODR5Smo675gzVSBLXrs3Gf3+xn+ls1raOU9C68
        i+Y9+/Qov4o+2g2x8HTz9aziqzuV
X-Google-Smtp-Source: APXvYqyGicDI5Qic8PkNg4+/QhCD2DvmypaeXZ/7/ZFHN3KogtE1n98FjKJNsTM54Dp7PymJKaix1Q==
X-Received: by 2002:a05:600c:295d:: with SMTP id n29mr22078118wmd.101.1582550272799;
        Mon, 24 Feb 2020 05:17:52 -0800 (PST)
Received: from localhost (pD9E516A9.dip0.t-ipconnect.de. [217.229.22.169])
        by smtp.gmail.com with ESMTPSA id q3sm17342925wmj.38.2020.02.24.05.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 05:17:51 -0800 (PST)
Date:   Mon, 24 Feb 2020 14:17:50 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra: Use pci_parse_request_of_pci_ranges()
Message-ID: <20200224131750.GA2209519@ulmo>
References: <20191028225136.22289-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
In-Reply-To: <20191028225136.22289-1-robh@kernel.org>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2019 at 05:51:36PM -0500, Rob Herring wrote:
> Convert Tegra PCI host driver to use the common
> pci_parse_request_of_pci_ranges().
>=20
> This allows removing the DT ranges parsing, PCI resource handling, and
> private storage of resources from the driver.
>=20
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Andrew Murray <andrew.murray@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: linux-tegra@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Here's one more conversion to use pci_parse_request_of_pci_ranges. It's
> dependent on my prior series, specifically this patch[1].
>=20
> Compile tested only.
>=20
> Rob
>=20
> [1] https://patchwork.ozlabs.org/patch/1185555/
>=20
>  drivers/pci/controller/pci-tegra.c | 187 +++++++----------------------
>  1 file changed, 46 insertions(+), 141 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl5TzPkACgkQ3SOs138+
s6Hb8RAAuBDCgCf7ITjK0QRvKFK25IIEygzPe1+E4wb2eHC0zeX2C0x1bgF1w+Gs
rqijPm12ur/NDaHhpgNKVJYr4P3zBsyDsM4fcdz90g2lbFU93ARE1RkWJ3yB4b/K
qETz7iqTHYNva268HT/CZjPA1au3Yjy/aY4l1lJBdVK4t6g7QeWm3Imze6F/LMb5
qdvrZidTY/Qv/8VXu7ICE6c8XrngCzkqWcC6TBbIXN/6m5ceEYSuuHFIf+M7+X5z
PFjTDuV3A0lULO5XQkxvu5fNmSW6zfxBdxPoI/LnF9YlbAdmVCqikjWCEI2cS/sT
bB83jaqcx+04i6d17eVEiZ4qciysoB9d+K8VK1TH6ffH/wXhIOEdWdRpvd0PxAKL
8AcvR9H8skNkpqbzNvt6ncl06pxc35DJD345Y7fVCUCah0xkS1w7u4aigcQy3QeA
FlXLszvV0+8BNPThj4o+YhpIOfSsOd1xfS3spmNu00PJ1iGWwOYVZNgqHrFIuF6J
DOfTN14zUY/TvyBlfydgYr2bHf2vTHVODeW5C366TCEHeanru2Nhe6fdRE5uzn1R
SrzNaP0DQezNjL/epz2UKZ9559uTw75eWSyM0M8vdow0WnG1AthZSoEWPzYklTDb
whWqkdO+8mG0eL+cCheKkulg2DZa8sfQH5PxWdilpGFx/d6FAZE=
=GutB
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
