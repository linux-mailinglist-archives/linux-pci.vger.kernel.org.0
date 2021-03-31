Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6101134FFAC
	for <lists+linux-pci@lfdr.de>; Wed, 31 Mar 2021 13:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235268AbhCaLrU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 Mar 2021 07:47:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:57718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235205AbhCaLrE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 31 Mar 2021 07:47:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 546F961983;
        Wed, 31 Mar 2021 11:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617191223;
        bh=MEHIAOJCnD5NSU7ULLzWpFbC8P2mR31ilMdQBMXtbOc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bmP1RP5T5z4hKGvW98EtdBNRGmgIe9dzS3auzf3Op2eraqOzCajqJGuQ5s7AXikt6
         emDr2FxSiK3XVUN5PvSID7n1dl0bjmDjzb+d8JlDLUqd5RjjodFV3qv7wcoegBb8CE
         7/XW1HSWHbO+YtwlWiePfNvEvGB0HLOGWkr/afsbG+eAhWoW4FEQ/3EAMrcWAbv9bl
         XhIFWjSF2s+CavpXg0zQkiZUi155OuXnICXwL8e9RL5dxd1PhtrvLeVsKB/NBfwY+F
         T5483A70ZZLzjIgWOcz1ojyqZri9NkgTyhRdKsY+bx98ympZhlrw1MRdi8SBsGS7Vd
         CmiyU4xF6JsOw==
Date:   Wed, 31 Mar 2021 12:46:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/6] dt-bindings: PCI: Add bindings for Brcmstb EP
 voltage regulators
Message-ID: <20210331114650.GA4758@sirena.org.uk>
References: <20210326191906.43567-1-jim2101024@gmail.com>
 <20210326191906.43567-2-jim2101024@gmail.com>
 <20210330150816.GA306420@robh.at.kernel.org>
 <20210330153023.GE4976@sirena.org.uk>
 <CANCKTBvDdkLk0o4NboaOTZ26vfwJjPAfnXK3ay4v9E91G2gYOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
In-Reply-To: <CANCKTBvDdkLk0o4NboaOTZ26vfwJjPAfnXK3ay4v9E91G2gYOQ@mail.gmail.com>
X-Cookie: You can't take damsel here now.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 30, 2021 at 12:23:35PM -0400, Jim Quinlan wrote:
> On Tue, Mar 30, 2021 at 11:30 AM Mark Brown <broonie@kernel.org> wrote:

> > For a soldered down part I'd expect we'd want both (if the host even
> > cares) - for anything except a supply that I/O or something else shared
> > is referenced off there's no great reason why it has to be physically
> > the same supply going to every device on the bus so each device should
> > be able to specify separately.

> Our developer and reference boards frequently have Mini and half-mini
> PCIe sockets (a few exceptions), whereas production boards are mostly
> soldered down.

On reflection I think the above probably also applies to sockets - you'd
just have to have a socket visible in the DT.

> If I resubmit this pullreq  so that it  looks for "vpcie12v-supply"
> and "vpcie3v3-supply" in the host node, will that be acceptable for
> both of you?

I think you will need both (assuming the controller actually physically
gets the supplies) - like I say the sockets/devices may not all share
the same 12V and 3.3V rails.

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBkYSoACgkQJNaLcl1U
h9AzZwf+IHeeyiF1l7tnQ0F0NICTUvUfGXdva6I5FzgczPxucf1w9Y/VIHGfrFi4
E09OZWs/FH0fFgUQWO+bqeaXYInpMnGsMCdXZSEYsABgQoMTtvoCQr+o1QKvJ/Ye
5IR1iPxdigor4QKIXvTIi0sIC/iFvMVo6wFfIInf7qzmsLnZE/uuJmHh3Sq2I1JW
urO6SiyAzZkdn6ZVA5Asu/8MeUmIMCC7Cidc25fBedch6a8+dqewQds0uZCJC40k
k8rsYDdF1E8DuKITqLcNiYDS677bgx/F+0DXWRrVMYawSiOxmrLTk+fBYq3EzYq3
8I/egyMtNle4xXbSt4WSpuODegtakw==
=YqRz
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
