Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA2DC30DBB8
	for <lists+linux-pci@lfdr.de>; Wed,  3 Feb 2021 14:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbhBCNsj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Feb 2021 08:48:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:47924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232170AbhBCNru (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Feb 2021 08:47:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E501C64E36;
        Wed,  3 Feb 2021 13:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612360029;
        bh=IsUgXomeNp/1DGOHqfSSLc4znx0drWy8FvO9N7bp848=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bCL9ixA2RBf9S/jDNygs2Q3o10TvABw+g4gApdPzd9IT4GxK0mXKTxAYHAH8KDcyK
         ElYUom2CXU5iALJ1gD+bZPJF5K9SkZXxJLepORTY1BRXJAfMWVkA3lVT5rqy/UlczK
         5j8al5UB3OxVyiUbCvFLmkYr2vLctUZREY8Ub1WrsXwAe5IQFWRLq+FgLNnQOBrEYG
         RokpEFyQ1K3OXMJfIW1QyJmuKhgNsyCPfZcO9nv8q9VMojavdccWdYvf6Z2+BNl1Qj
         A7uJ7f+b0OpTQF3XT2OvRo1c5v4XWtTtwKFoDhHlv0a0c1m/UAoKRHaAvG39zfQSQW
         dhgsr5vWI2ggQ==
Date:   Wed, 3 Feb 2021 13:46:20 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 09/11] PCI: dwc: pcie-kirin: allow using multiple
 reset GPIOs
Message-ID: <20210203134620.GE4880@sirena.org.uk>
References: <cover.1612335031.git.mchehab+huawei@kernel.org>
 <4fb97b1fc3fe6df9a2fea8f96bdef433e75463a6.1612335031.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zaRBsRFn0XYhEU69"
Content-Disposition: inline
In-Reply-To: <4fb97b1fc3fe6df9a2fea8f96bdef433e75463a6.1612335031.git.mchehab+huawei@kernel.org>
X-Cookie: Who was that masked man?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--zaRBsRFn0XYhEU69
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 03, 2021 at 08:01:53AM +0100, Mauro Carvalho Chehab wrote:

> +	reg = devm_regulator_get_optional(dev, "pci");
> +	if (IS_ERR_OR_NULL(reg)) {
> +		if (PTR_ERR(reg) == -EPROBE_DEFER)
> +		    return PTR_ERR(reg);
> +	} else {
> +		ret = regulator_enable(reg);

This is still misuse of regulator_get_optional() for the same reason.

--zaRBsRFn0XYhEU69
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAaqSsACgkQJNaLcl1U
h9DCKAf/fhZGpW2GymYrExkqL7V0WXt/lzd0cIz9uLBciSnaG7ffrNwNwldbL/x4
GKofFl/RbxIDWTBdNHcZ1uVFG25lJqHX6H+bVwxBS8dsuAWHOTLWV4KxWf45rPGs
Rud1saSyfttl967Jf5X0xcA/9Ckx5D0eWzdIUFZEQ1C4GJd8yR0oD21arwj5H2bS
uZuBNb60Mf8cUEwtJDg88gt3abU8YWYzXLFflW6TJ9ZhhHGSkuSU2GDUrYSyQ7RG
QNWAzloYWQ/HQgPj1MJHLodUrQ4xk8pEQCTAbTcwN2p9PQkYeBbeY5NtA+IqbmB7
dqighPpO0laQZMM3cht9uR4obHsAdQ==
=Io+1
-----END PGP SIGNATURE-----

--zaRBsRFn0XYhEU69--
