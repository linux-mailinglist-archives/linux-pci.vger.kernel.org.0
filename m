Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE84B19F192
	for <lists+linux-pci@lfdr.de>; Mon,  6 Apr 2020 10:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgDFI1g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Apr 2020 04:27:36 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:33203 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726514AbgDFI1g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Apr 2020 04:27:36 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 273DE5800E5;
        Mon,  6 Apr 2020 04:27:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 06 Apr 2020 04:27:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=f9JBRr+XhbC+CvGSQhNRe2L/ERw
        IGY84ZpI4+IQemfM=; b=pIMXjGrj8l2gSjLhTowqJmg7cVKQfqQQNt7JH5RcSJm
        525J+EbU3EjWe1RfHZKli13PSS+kuMRl5UmgyAJRLT04uiEAyCW992YS77jZJQlv
        +rKHmvMMkkGM323eZBDxE0i4KejgnvxwFTbtvOvn8eYeBx6Vt9roYtaYeFxuwwGR
        ntELBKF5gXG5ZFAPe9Xmh5NpT3VEX5qWzW4gHRUctnBFfq6EsvA7IzvLvKi5f6ft
        Th/J7u+AO8wvG7KJbt8VE2/IU7GPJ0KWU5ObV7oy6HqN6N4l/T2JuV5SjXCOZqVI
        I3aarBglXwIs3TCwi1S8a+0o+57zuOqHlrI8z++kiTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=f9JBRr
        +XhbC+CvGSQhNRe2L/ERwIGY84ZpI4+IQemfM=; b=Fyyi3KV32nrPIy5vKGKxZS
        IPq6wIkkMSPOYi3wHBbzrFi4xMfDJAt/HL21FD4ZqqqX6Kp3SA+KCmXewcLFFhni
        wzcg+bdztWsQlxbLIa85taJokNN+PvZ2+Yv+aQZi202x7Krrdysg1/2TkwGR1Qxy
        dBF8NCoTdTClJP7bRojjClayTFD2NfEw+0NwRD6Xc4x4jWej7NLBkyVsBdq2GGL3
        bLa4oLsOB5xpPkLlRybtCT5Q8TyFf2Ul+UbWSnrtg+o3+YeRgxPs0bMdt8juNDJJ
        DoUsKIC7NTC+1wQxL+qrq8gqgzCkUjvr/ikPXG5io3scq/dpdfq8NT0xNpN1I7Mw
        ==
X-ME-Sender: <xms:9ueKXgHAd-e8n3CVwVMaAsGp9RwZEzFn6T02Txh1Tcs6FfzeXmoyCg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudefgddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucffohhmrghinh
    epghhithhhuhgsrdgtohhmpdgrrhhmsghirghnrdgtohhmnecukfhppeeltddrkeelrdei
    kedrjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:9ueKXjTHNe2AxKtGcT-xwXSuJYwf7qgEPNS-ODthj-q8CV2sROePSw>
    <xmx:9ueKXgez-eoeh12lrwjYhPKHWA_mlW6Bc9RvN24HMxqMYGVEJ_WtXQ>
    <xmx:9ueKXokawD1_rDrtS5Bt-hUvRn2gDnrKqpoU4Qjg4wlFb56TEBgIqQ>
    <xmx:9-eKXoLhLrHQKi8juWiUQl6jMggIZQ8QIY1ToWq_i4HFyzgrZ2cd2g>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id E8DB8328005D;
        Mon,  6 Apr 2020 04:27:33 -0400 (EDT)
Date:   Mon, 6 Apr 2020 10:27:32 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [RFC PATCH] PCI: dwc: add support for Allwinner SoCs' PCIe
 controller
Message-ID: <20200406082732.nt5d7puwn65j4nvl@gilmour.lan>
References: <20200402160549.296203-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bxu46sevqgfhv5v4"
Content-Disposition: inline
In-Reply-To: <20200402160549.296203-1-icenowy@aosc.io>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--bxu46sevqgfhv5v4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Fri, Apr 03, 2020 at 12:05:49AM +0800, Icenowy Zheng wrote:
> The Allwinner H6 SoC uses DesignWare's PCIe controller to provide a PCIe
> host.
>
> However, on Allwinner H6, the PCIe host has bad MMIO, which needs to be
> workarounded. A workaround with the EL2 hypervisor functionality of ARM
> Cortex cores is now available, which wraps MMIO operations.
>
> This patch is going to add a driver for the DWC PCIe controller
> available in Allwinner SoCs, either the H6 one when wrapped by the
> hypervisor (so that the driver can consider it as an ordinary PCIe
> controller) or further not buggy ones.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> There's no device tree binding patch available, because I still have
> questions on the device tree compatible string. I want to use it to
> describe that this driver doesn't support the "native Allwinner H6 PCIe
> controller", but a wrapped version with my hypervisor.
>
> I think supporting a "para-physical" device is some new thing, so this
> patch is RFC.
>
> My hypervisor is at [1], and some basic usage documentation is at [2].
>
> [1] https://github.com/Icenowy/aw-el2-barebone
> [2] https://forum.armbian.com/topic/13529-a-try-on-utilizing-h6-pcie-with-virtualization/

I'm a bit concerned to throw yet another mandatory, difficult to
update, component in the already quite long boot chain.

Getting fixes deployed in ATF or U-Boot is already pretty long, having
another component in there will just make it worse, and it's another
hard to debug component that we throw into the mix.

And this prevents any use of virtualisation on the platform.

I haven't found an explanation on what that hypervisor is doing
exactly, but from a look at it it seems that it will trap all the
accesses to the PCIe memory region to emulate a regular space on top
of the restricted one we have?

If so, can't we do that from the kernel directly by using a memory
region that always fault with a fault handler like Framebuffer's
deferred_io is doing (drivers/video/fbdev/core/fb_defio.c) ?

Maxime

--bxu46sevqgfhv5v4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXorn9AAKCRDj7w1vZxhR
xdV6AP4y+CTh2KPAJf/qouRZrEmCvj19E23Xp9w67VLU9qZHBQD7BVzW6hD0E0oG
LnBT9kYGbeef7keRU4XuDbLzxH3hzQc=
=0eCj
-----END PGP SIGNATURE-----

--bxu46sevqgfhv5v4--
