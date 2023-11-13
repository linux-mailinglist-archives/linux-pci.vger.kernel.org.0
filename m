Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844547EA4DF
	for <lists+linux-pci@lfdr.de>; Mon, 13 Nov 2023 21:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjKMUdG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Nov 2023 15:33:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjKMUdF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Nov 2023 15:33:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7B81A7;
        Mon, 13 Nov 2023 12:33:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 949D9C433C8;
        Mon, 13 Nov 2023 20:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699907582;
        bh=HTy1zq9rC/Vx1G5H3T/5br1lMB5SOiNtHA9DI+oJ31E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iQvmwOf24DxLrWf8qLdj+pX8NI/C42LkWzICY9wd2YUhe+Gt9V2VjlDJWc5PvEggx
         ZdZi73TwzXFSCdPAm/5pn/QJcIQ/H0OWRxcLq+oMrdW31cn1yIpRQYyzPIb+LKV5gx
         sAm96JnUke1kpfOuUATieNff1TJvjsFAsUq/eApJBVX67mmEDBIrkZNtTCwyZKSv7Y
         5F20yS/DIjWLMjz9m7I5SAu0mERyM1BEShadUAfNSP+fuOK9MPXt8kRXnjRVPysc73
         X5Ye3/QyJFBa7i0Z/TDiuJeuzzP+Y8XGdn1nBbZLl9ew5gh+dLkWiem0eLYl/qZgWU
         rI+T/mjO4grqg==
Date:   Mon, 13 Nov 2023 20:32:58 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Jim Quinlan <jim2101024@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 1/2] dt-bindings: PCI: brcmstb: Add property
 "brcm,clkreq-mode"
Message-ID: <20231113-penny-clustered-8c644c62e7b8@squawk>
References: <20231113185607.1756-1-james.quinlan@broadcom.com>
 <20231113185607.1756-2-james.quinlan@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vUWcHB+vBWOxwK3W"
Content-Disposition: inline
In-Reply-To: <20231113185607.1756-2-james.quinlan@broadcom.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--vUWcHB+vBWOxwK3W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 13, 2023 at 01:56:05PM -0500, Jim Quinlan wrote:
> The Broadcom STB/CM PCIe HW -- a core that is also used by RPi SOCs --
> requires the driver to deliberately place the RC HW one of three CLKREQ#
> modes.  The "brcm,clkreq-mode" property allows the user to override the
> default setting.  If this property is omitted, the default mode shall be
> "default".
>=20
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor

--vUWcHB+vBWOxwK3W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVKH9gAKCRB4tDGHoIJi
0gKfAQCTvDoteqQb99OtMk4+Gjxaopj2xehQwOiWMPMKuY+wpwD2KmEB+sAA5km0
ipVsb7LLp95HyxiOeMUWdgboJrVRDw==
=AQKG
-----END PGP SIGNATURE-----

--vUWcHB+vBWOxwK3W--
