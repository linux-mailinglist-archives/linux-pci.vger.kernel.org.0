Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B0D77FC78
	for <lists+linux-pci@lfdr.de>; Thu, 17 Aug 2023 19:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353806AbjHQREh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Aug 2023 13:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353815AbjHQREW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Aug 2023 13:04:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944A630C2;
        Thu, 17 Aug 2023 10:04:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3260961F16;
        Thu, 17 Aug 2023 17:04:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FA81C433C7;
        Thu, 17 Aug 2023 17:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692291859;
        bh=IUsc1dlDugnr6ByC8ySX3bNJAeDpRdUJA6/XtcW0ZB4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=r3Z+lRPlDnQqU2+3I3DThI66ZNzutA3ShL/STD5dNv27ogS7aOGEkI4XbDU3KrkdM
         uoaavOVO4f2S2hnn1PmSNNovQbcXWx+JtMz0ygn+/JM2GQs/Ih3Q8iQHTZJJ4Ws8bA
         bPZnHSQBoV61Ex+Yerm+n9IV5e+emUPUe875OxlHqhxi4dLbK/o4Jp2CgRL5JB0XBm
         ffx4cBNoUhk4VrX3EncBVzVt19n/z8p2XXV8TFPSzEcsYVwhpiJS+xugEHhLEJfJeB
         BiLNr7ufNOncsadja8vx/OZ+xmxKlZkwgBzS4vIITOg3/UxGoWkwFgB+BkRrUK/TuQ
         SVzxTAX3PmmOQ==
Date:   Thu, 17 Aug 2023 12:04:17 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Achal Verma <a-verma1@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczy_ski <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] PCI: j721e: Add support to build pci-j721e as a
 kernel module
Message-ID: <20230817170417.GA320486@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230817120823.1158766-3-a-verma1@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 17, 2023 at 05:38:23PM +0530, Achal Verma wrote:
> pci-j721e driver can be build as a in-built kernel driver only, which is
> not required as it is not used during boot time in most cases.
> This change add support to build pci-j721e as a kernel loadable module.
>=20
> J721e PCIe controller can work in both host mode and end-point mode.
> In order to enable host mode driver and endpoint driver to be built
> independently either as built-in or kernel module, the pcie-j721e.c driver
> is refactored into following components:
>=20
> 1) pci-j721e-host.c: Driver used when PCIe controller has to be
> initialized in host mode.
>=20
> 2) pci-j721e-ep.c: Driver used when PCIe controller has to be
> initialized in endpoint mode.
>=20
> 3) pci-j721e.c: contains common code required in both modes.

Sounds like at least two commits (I'm not sure what the best order
would be):

  1) Split into separate host mode and endpoint mode drivers

  2) Make both drivers tristate

It looks like you implement both module loading and removal.  Do we
now think removal of these modules is safe?  IIRC there used to be a
question related to irq_desc lifetimes, e.g., there's some discussion
here: https://lore.kernel.org/linux-pci/87k085xekg.wl-maz@kernel.org/

The ability to *load* drivers as modules is definitely useful.  The
ability to *remove* them is useful for developers but not really
useful for users.

But I guess j721e_pcie_remove() already exists, so maybe you're not
changing anything as far as irq_desc lifetimes=06

Since you're splitting into new files, maybe this is an opportunity to
fix my naming mistake of suggesting a "pci-" prefix instead of
"pcie-"?

Bjorn

>  config PCI_J721E_HOST
> -	bool "TI J721E PCIe controller (host mode)"
> +	tristate "TI J721E PCIe controller (host mode)"
>  	depends on OF
>  	select PCIE_CADENCE_HOST
>  	select PCI_J721E
> @@ -56,7 +56,7 @@ config PCI_J721E_HOST
>  	  core.
> =20
>  config PCI_J721E_EP
> -	bool "TI J721E PCIe controller (endpoint mode)"
> +	tristate "TI J721E PCIe controller (endpoint mode)"
>  	depends on OF
>  	depends on PCI_ENDPOINT
>  	select PCIE_CADENCE_EP

> +static struct platform_driver j721e_pcie_ep_driver =3D {
> +	.probe  =3D j721e_pcie_probe,
> +	.remove_new =3D j721e_pcie_remove,
> +	.driver =3D {
> +		.name	=3D "j721e-pcie-ep",
> +		.of_match_table =3D of_j721e_pcie_ep_match,
> +		.suppress_bind_attrs =3D true,
> +	},
> +};

> +static struct platform_driver j721e_pcie_host_driver =3D {
> +	.probe  =3D j721e_pcie_probe,
> +	.remove_new =3D j721e_pcie_remove,
> +	.driver =3D {
> +		.name	=3D "j721e-pcie-host",
> +		.of_match_table =3D of_j721e_pcie_host_match,
> +		.suppress_bind_attrs =3D true,
> +	},
> +};
