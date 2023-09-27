Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC887B0836
	for <lists+linux-pci@lfdr.de>; Wed, 27 Sep 2023 17:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbjI0P1r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Sep 2023 11:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbjI0P1r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Sep 2023 11:27:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B8F193;
        Wed, 27 Sep 2023 08:27:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BEECC433C8;
        Wed, 27 Sep 2023 15:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695828466;
        bh=ew1MYjtPQy8sB9eXrgz71lc2ePX2xsFIrzywzE9J6Eo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X0RB2onXT9AYbf8nJ0cuxMqvm5mGl0XlsyhgPLLf4uJaZX61Sq2+yfjJ3PizalktX
         xzZufZ+A/+zvr+/IFMZQO1ds5uWSreoqrlbDoB0APF9yiy35Xhe3C6DF+Fs5jXbCsa
         XaRaEufy+XOcy4uRMCMWhsyOJSdNUHNuwmNSSdRI9+i0/+Iku4VnF0o/v6lI/5Qxfl
         ElAwdnw0pvJHIcGCcJZPm2OJ2CN5QwnjMd9z+FjtxkWf4LBTUYiUd4JjURaGDjSYrQ
         SJjqE2SPmAMwc5v5sKJ6nmpBBDzYpaBPYsm0D5kSyaozBr5Srpb4ZiJR86Lg8gLkXX
         0vZVr08TbygLw==
Date:   Wed, 27 Sep 2023 16:27:41 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: PCI: brcm,iproc-pcie: Drop common
 pci-bus properties
Message-ID: <20230927-fraying-pranker-19ae72ff86a7@spud>
References: <20230926155351.31117-1-robh@kernel.org>
 <20230926155351.31117-2-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GAGv5w0d/anu4Sn5"
Content-Disposition: inline
In-Reply-To: <20230926155351.31117-2-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--GAGv5w0d/anu4Sn5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 26, 2023 at 10:53:41AM -0500, Rob Herring wrote:
> Drop the unnecessary listing of properties already defined in
> pci-bus.yaml. Unless there are additional constraints, it is not
> necessary.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  .../devicetree/bindings/pci/brcm,iproc-pcie.yaml  | 15 ---------------
>  1 file changed, 15 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.yaml b=
/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.yaml
> index 0cb5bd6cffa1..6730d68fedc7 100644
> --- a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.yaml
> @@ -34,13 +34,6 @@ properties:
>      description: >
>         Base address and length of the PCIe controller I/O register space
> =20
> -  interrupt-map: true
> -
> -  interrupt-map-mask: true
> -
> -  "#interrupt-cells":
> -    const: 1
> -
>    ranges:
>      minItems: 1
>      maxItems: 2
> @@ -54,16 +47,8 @@ properties:
>      items:
>        - const: pcie-phy
> =20
> -  bus-range: true
> -
>    dma-coherent: true
> =20
> -  "#address-cells": true
> -
> -  "#size-cells": true
> -
> -  device_type: true
> -
>    brcm,pcie-ob:
>      type: boolean
>      description: >
> --=20
> 2.40.1
>=20

--GAGv5w0d/anu4Sn5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRRJ7QAKCRB4tDGHoIJi
0lP1AQDaCJ6JUfOS07CvDiagWs4i2dBIvfiGnR/4dB4fYNmQBwD8CMisRB8zqfjI
XZRmMkwsvx0bWoQ2dtE878SKFLfoCgw=
=PQD9
-----END PGP SIGNATURE-----

--GAGv5w0d/anu4Sn5--
