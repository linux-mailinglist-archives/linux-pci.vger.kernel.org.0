Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7144441D76
	for <lists+linux-pci@lfdr.de>; Mon,  1 Nov 2021 16:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbhKAPjN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Nov 2021 11:39:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:56200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230261AbhKAPjN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Nov 2021 11:39:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A464D60F56;
        Mon,  1 Nov 2021 15:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635780999;
        bh=KD8dXGIgMAq6degzFf4Q3Y1ZSbzbId9yWYU7Ix02i+w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KVA1LU/HARUi6XzLplgiP2qCqmN+fW1p/SNSd9VeK9rwnRL7ddfahy+ZQzacPBgsd
         51a7NAiYnBz1twGsfUwpgCp+TfzzGxo2+J6w/J8Vsb7Yk3p3ijWYiatV291LWC9Ycv
         gO0zej7hgmiZ4e38n/tHsPSKOk9QclGluk3qjkQqqfgnxfDaBGs13InZgmPMbv4f2F
         jq2VQNox9lAKbNO9lxcUwwk0/4LdG/ZHUrZUyGRNuub3IskfgCOT+kPkikx8GPYH+9
         QhisQe3dxa+9JKdlZ3MqsICG/Wkf86SpoSCDJU4HGfi3Eyh6QVHGdGhtQAyQz3pJJh
         fgq0GJlxbdp4g==
Date:   Mon, 1 Nov 2021 15:36:34 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     l.stach@pengutronix.de, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, jingoohan1@gmail.com,
        linux-pci@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH v4 5/6] PCI: imx6: Fix the regulator dump when link never
 came up
Message-ID: <YYAJglJlR6bVbQ/L@sirena.org.uk>
References: <1635747478-25562-1-git-send-email-hongxing.zhu@nxp.com>
 <1635747478-25562-6-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UhufA6iKSde21dpx"
Content-Disposition: inline
In-Reply-To: <1635747478-25562-6-git-send-email-hongxing.zhu@nxp.com>
X-Cookie: Don't Worry, Be Happy.
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--UhufA6iKSde21dpx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 01, 2021 at 02:17:57PM +0800, Richard Zhu wrote:

> When PCIe PHY link never came up and vpcie regulator is present, there
> would be following dump when try to put the regulator.
> Add a new host_exit() callback for i.MX PCIe driver to disable this
> regulator and fix this dump when link never came up.

This looks like a good improvement, though it still looks like there are
issues given the checks for the regulator being NULL.  This might be
better fixed as a separate patch though.

--UhufA6iKSde21dpx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGACYEACgkQJNaLcl1U
h9B7NAf9GgzzucQ+0irq/DERGpVAY0vuLGY5/KSlf63hKoxBO6EtbGqhcDRlV4z5
HIDjTO6iiPfo0dUbRBjpwbmTN2Y9i2k/VnW8Lm1tfgub5/139tYPQv6Aw0FKS+Ql
KPOGD+OOOvrdQ9ZLhJ0dd7sIqvEJGef9CP9B6RHdh+K3LZWNBN8JlUWlQHAgQQAz
nk8RLGTHHpsEY4C8tqFGB+ugf6aQJCQltHJD6PO+eX4JByiDo9g9qUlDtvTn+Y5t
bFzFVisrPBxbZMS75nxQNDNNW4LkDulyiIC5AauzL69d/c1HawWddlVtDGrlVNEU
qyDWkDcEgPv5TcXnQ6smRfpARv7R7w==
=lWlW
-----END PGP SIGNATURE-----

--UhufA6iKSde21dpx--
