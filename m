Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2226425B74
	for <lists+linux-pci@lfdr.de>; Thu,  7 Oct 2021 21:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243899AbhJGTZI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Oct 2021 15:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243891AbhJGTZI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Oct 2021 15:25:08 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF417C061570;
        Thu,  7 Oct 2021 12:23:13 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id u18so22330092wrg.5;
        Thu, 07 Oct 2021 12:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jKCYo7elbfN+8Lo9BJJiNFtvdPlRlQgGyDD+hhfOf40=;
        b=d0dkuNNipB4R+OTaIs1kQfjnZ24jPRymUVjwKt4l6BIgSLjdhH30LPkaG6S9ik5axn
         Biu2rz5ZCzOVw5gTs+1IZd97T7gUR1otVgyjL+ndg8/kVF3arFWi8qqVRKjhRsgF+M62
         ketDfIfLDywghXB1AGHBlkRG4V+3h7X9vioozBPllV2YbsdaCqKv++N7Fwi4wSuiwVRc
         ZXw5O4EfOocbF4cEIQ+CM2Vc48Ky/E5QxkAagZbsp3Qvx6Y5wOlue1pl5CASf4KA+ISW
         CcsCkR4A5Wwnh8FLHbRLKYz+L1I+9SG+QhjF3IByCRi0bzjtfG3zhf1glEH9QGNsU2aJ
         HQAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jKCYo7elbfN+8Lo9BJJiNFtvdPlRlQgGyDD+hhfOf40=;
        b=Af1jiIVE4dCWfBG1QOnaH1YjIanU1OgfF8aCZ7ERqSfTlsKw5bkkxYHhf97cNXvVWT
         0rFwpRgd0TiDMDzN9J2Uxrdkcc5eBAMaUAzLkmIiCy3Sv4PTMTVgxfnQIUcn2Wwr2CNp
         nH4hYHcmCAsi06FWYtGXho0iQ0U/m4IY9cXmRpzqdY2MKQ0RWadfuHwCDpoUFWg4TBkA
         reLbm8gBe7LFAz3WwZqb33knK2mzK+0MjiMVaZ2D/L4Z5gOjPsiMDRq0z3Nvt5GqSuUu
         zBbxqoxIYzfrN27MX7ZIXJBibbYzVCT5GzeQ/xc04UKFiVmWhAjqovVINS0n1VYQGgTt
         dQjA==
X-Gm-Message-State: AOAM532J/trbOB9D/nRgABoN4AdEdcdavDb0Cxh6ytWCAlGuIK1y/RJW
        BAgNHdcMKZvZSxg4a/jhLFA=
X-Google-Smtp-Source: ABdhPJyqOVTW/HIi/ICquQaOPPDSGWhlYbd6fygN3jqI+8q43cGrGaR+0T8etAnCTt4TF7FXO+kDJg==
X-Received: by 2002:a1c:cc0f:: with SMTP id h15mr6528641wmb.37.1633634592523;
        Thu, 07 Oct 2021 12:23:12 -0700 (PDT)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id i3sm245065wrn.34.2021.10.07.12.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 12:23:11 -0700 (PDT)
Date:   Thu, 7 Oct 2021 21:23:10 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, linuxarm@huawei.com,
        mauro.chehab@huawei.com, Bjorn Helgaas <bhelgaas@google.com>,
        JC Kuo <jckuo@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sameer Pujar <spujar@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH v5 5/5] dt-bindings: arm64: tegra: fix pcie-ep DT nodes
Message-ID: <YV9JHsFyu+zTxrcN@orome.fritz.box>
References: <cover.1626608375.git.mchehab+huawei@kernel.org>
 <15cf5067c0567614d5b186d006ebd88395d56b63.1626608375.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hvtSaJRi+eMRsZbD"
Content-Disposition: inline
In-Reply-To: <15cf5067c0567614d5b186d006ebd88395d56b63.1626608375.git.mchehab+huawei@kernel.org>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--hvtSaJRi+eMRsZbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 18, 2021 at 01:40:52PM +0200, Mauro Carvalho Chehab wrote:
> As defined by Documentation/devicetree/bindings/pci/pci-ep.yaml,
> PCIe endpoints match this pattern:
>=20
> 	properties:
> 	  $nodename:
> 	    pattern: "^pcie-ep@"
>=20
> Change the existing ones in order to avoid those warnings:
>=20
> 	arch/arm64/boot/dts/nvidia/tegra194-p3509-0000+p3668-0001.dt.yaml: pcie_=
ep@14160000: $nodename:0: 'pcie_ep@14160000' does not match '^pcie-ep@'
> 		From schema: Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
> 	arch/arm64/boot/dts/nvidia/tegra194-p3509-0000+p3668-0001.dt.yaml: pcie_=
ep@14180000: $nodename:0: 'pcie_ep@14180000' does not match '^pcie-ep@'
> 		From schema: Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
> 	arch/arm64/boot/dts/nvidia/tegra194-p3509-0000+p3668-0001.dt.yaml: pcie_=
ep@141a0000: $nodename:0: 'pcie_ep@141a0000' does not match '^pcie-ep@'
> 		From schema: Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
> 	arch/arm64/boot/dts/nvidia/tegra194-p3509-0000+p3668-0000.dt.yaml: pcie_=
ep@14160000: $nodename:0: 'pcie_ep@14160000' does not match '^pcie-ep@'
> 		From schema: Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
> 	arch/arm64/boot/dts/nvidia/tegra194-p3509-0000+p3668-0000.dt.yaml: pcie_=
ep@14180000: $nodename:0: 'pcie_ep@14180000' does not match '^pcie-ep@'
> 		From schema: Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
> 	arch/arm64/boot/dts/nvidia/tegra194-p3509-0000+p3668-0000.dt.yaml: pcie_=
ep@141a0000: $nodename:0: 'pcie_ep@141a0000' does not match '^pcie-ep@'
> 		From schema: Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
> 	arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dt.yaml: pcie_ep@14160000=
: $nodename:0: 'pcie_ep@14160000' does not match '^pcie-ep@'
> 		From schema: Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
> 	arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dt.yaml: pcie_ep@14180000=
: $nodename:0: 'pcie_ep@14180000' does not match '^pcie-ep@'
> 		From schema: Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
> 	arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dt.yaml: pcie_ep@141a0000=
: $nodename:0: 'pcie_ep@141a0000' does not match '^pcie-ep@'
> 		From schema: Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
>=20
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  .../devicetree/bindings/pci/nvidia,tegra194-pcie.txt        | 2 +-
>  arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts          | 2 +-
>  arch/arm64/boot/dts/nvidia/tegra194-p3509-0000.dtsi         | 2 +-
>  arch/arm64/boot/dts/nvidia/tegra194.dtsi                    | 6 +++---
>  4 files changed, 6 insertions(+), 6 deletions(-)

Sorry for the delayed response, this fell through the cracks. Applied
now, thanks.

Thierry

--hvtSaJRi+eMRsZbD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmFfSRwACgkQ3SOs138+
s6FMVg//VA84RbAyFnRKV7Qf21suROrf13xD4bw8a6iFEvSedSMiqMJupJ6cW5Df
xAdQxmivmNfwEtsVgrO7bw0MR6yrIU6eRxWPV89qAoIAOFMpIupcu6I+MZSNLin/
vDBRvVw+R+zN95mHW7W4Edf76NwVjsFcLpDyxpTgdBYGc4CmTuUi15yGcfsnLWj1
8phTiwa/U7/cf7qWTAy2PMhtseEoVRjXZT2FtubC9Y6YSfAE3gz86rKBUxE8ZZIg
WcqO92HeOLtXxs/TAGkEkOfQWkRe4aHHzpC61V+c4ECs0emhbrXjQmePmcEWzW9n
9zEjUANnaEiYbYcSGx1m34TtCWVuGtaIaHQZur/ClgB0FjwWV9k4MxbWnfU/2+ww
M3LZgDLQh5wtx2wzq304FT1Jyoo1ekrBRHh5+jqVCcHKCTUMJquwpA1oDp9PI50W
il6Ju775R2Q/Dj6p4P2c0YU6ZJ4qMK9JFuwLb7JBxDGNTvdJh2bGv63DZ+g86Mwq
YCAKf5aQfcWf12GdRU04ttJ/n8rW6+33dw+iELC+HvxZChX/Yp3zwn4HbDt9Do/9
lfW4QVBrF0QneD2zqEAmknoog7dU7MOih1RND/lZPF1rwRafxRGGZm7ys3rWZkVJ
/U1CuNlPkdeEzLBHEvDSIVxKZgA81BxWRDSiiSs+Wg+AXSomY5I=
=8l0Y
-----END PGP SIGNATURE-----

--hvtSaJRi+eMRsZbD--
