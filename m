Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE31355A6D
	for <lists+linux-pci@lfdr.de>; Tue,  6 Apr 2021 19:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbhDFRcl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Apr 2021 13:32:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:55826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229459AbhDFRci (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Apr 2021 13:32:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C3AEE613D2;
        Tue,  6 Apr 2021 17:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617730350;
        bh=l7ZORsHdTMCrLBnQ9+hAv3mWIjTfuNAKq8QmXDtsC1I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tCUb2XK4f21ACck/w8OUtFM+7LCE5RPjVquaCt1zuHy6/I1z+NTUeBuaH3jAVL9pS
         TMRyrYZcji5gKhbzOuqftA04iCWDufVxp8D3l150Z0qip8rUQegnMf2kpdR0JrzxxZ
         rbBvW+ElJqnB74RD7e8TwjX4qV2Fj1+0qBILcD9wGQdAkr8m6ZvSHSVAaKjDjKufXl
         LlSsSuiG0EIbshdjg8l0oRukEdXkQ0Qnrt/L4lVNAjO3m+zSwGYmPKa/fqhYlsQWkN
         n3YsVD2g4KJdCSK7HfIkiI6h5ut+HlWKyORE59FITOss5VEwk0fAHYnp7jOhV5y7aE
         9T/NbawySqKUA==
Date:   Tue, 6 Apr 2021 18:32:11 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh@kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/6] dt-bindings: PCI: Add bindings for Brcmstb
 endpoint device voltage regulators
Message-ID: <20210406173211.GP6443@sirena.org.uk>
References: <20210401212148.47033-1-jim2101024@gmail.com>
 <20210401212148.47033-3-jim2101024@gmail.com>
 <20210406164708.GM6443@sirena.org.uk>
 <CANCKTBsiujTkOdh60etBqF_hE8exg6m9TDxkGHVVAGVS2SFCcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XFI+TFG+M3u0jUjZ"
Content-Disposition: inline
In-Reply-To: <CANCKTBsiujTkOdh60etBqF_hE8exg6m9TDxkGHVVAGVS2SFCcQ@mail.gmail.com>
X-Cookie: BARBARA STANWYCK makes me nervous!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--XFI+TFG+M3u0jUjZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 06, 2021 at 01:26:51PM -0400, Jim Quinlan wrote:
> On Tue, Apr 6, 2021 at 12:47 PM Mark Brown <broonie@kernel.org> wrote:

> > No great problem with having these in the controller node (assming it
> > accurately describes the hardware) but I do think we ought to also be
> > able to describe these per slot.

> Can you explain what you think that would look like in the DT?

I *think* that's just some properties on the nodes for the endpoints,
note that the driver could just ignore them for now.  Not sure where or
if we document any extensions but child nodes are in section 4 of the
v2.1 PCI bus binding.

--XFI+TFG+M3u0jUjZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBsmxsACgkQJNaLcl1U
h9ACywf+KdfAcRIo9HqlXhzf7hzuIYFQXCWFSHKxpQ7dqGhH0scIPouum9B1SCZ9
utspOixjsm62QU3xLf22B52P5Tz94BqNP6IdvMfRCpwiWd0k8fIWc1kf3tu8MX2e
amdXE1Gm7B63eEnIOOGMbqI50uAQ7zShGlJCvWqOTnw/87wE55XR8aqR5hrXnYja
6D4v7aplC2vryKQRWr6jXIg98bxgxLgzlxr6Qd1hZJ0p1sXJTAR6ZzxCyc6QlbwE
S4KKrFn6at+6x/ctz33dVAz3nXuNmy4ibWA0zbjnXQKe14vTspxEgsM1nyRE449o
wl9ZQ1IbxUr6LkxUkU9HxdSq1K1c7g==
=sxfG
-----END PGP SIGNATURE-----

--XFI+TFG+M3u0jUjZ--
