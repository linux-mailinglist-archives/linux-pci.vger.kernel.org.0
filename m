Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80C6748C746
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jan 2022 16:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354613AbiALPgk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jan 2022 10:36:40 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:33490 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349515AbiALPgh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jan 2022 10:36:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94E656193B;
        Wed, 12 Jan 2022 15:36:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AA45C36AE5;
        Wed, 12 Jan 2022 15:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642001796;
        bh=uTJTttzqqqZPjkI09aLeLUGr5DSV9ce4+aCAyJpdblg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ciqaKSgWS61sGO2OnlkX7fx3671UexqzZ4lde/1MqfCw1iI993dDInBqtdsCXa+4M
         7TPX6Rm3fX4DN6fPAoCtsxjp1vC2kn9JygQvJekjHEvEz2nr8+5ZzDbOT2S3OQSe3c
         a68ALXvVY/3rUSM+ZaKNoRpMWiaV5keEYodwMNhrEd79PpPCWcKmK4Zz6Qz88Jr2mg
         QRckd5LUZGxhtuSsH2e19G1QRuQxI20df10iVx2eD19TYiXJMBVqM/v0x6MQ0XM6Ys
         3qfye7VZ+xByWF7p/JkMCN5xXjzYCfKw6VMw3SNpmdOxD+mKwl1sxfIDO6R/09UmOD
         ojL06gyv6hllw==
Date:   Wed, 12 Jan 2022 16:36:27 +0100
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 09/11] dt-bindings: PCI: mvebu: Update information
 about intx interrupts
Message-ID: <20220112163627.4e975d24@thinkpad>
In-Reply-To: <20220112151814.24361-10-pali@kernel.org>
References: <20220105150239.9628-1-pali@kernel.org>
        <20220112151814.24361-1-pali@kernel.org>
        <20220112151814.24361-10-pali@kernel.org>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 12 Jan 2022 16:18:12 +0100
Pali Roh=C3=A1r <pali@kernel.org> wrote:

> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/pci/mvebu-pci.txt | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pci/mvebu-pci.txt b/Docume=
ntation/devicetree/bindings/pci/mvebu-pci.txt
> index 24225852bce0..6d022a9d36ee 100644
> --- a/Documentation/devicetree/bindings/pci/mvebu-pci.txt
> +++ b/Documentation/devicetree/bindings/pci/mvebu-pci.txt
> @@ -81,6 +81,11 @@ and the following optional properties:
>  - reset-gpios: optional GPIO to PERST#
>  - reset-delay-us: delay in us to wait after reset de-assertion, if not
>    specified will default to 100ms, as required by the PCIe specification.
> +- interrupt-names: list of interrupt names, supported are:
> +   - "intx" - interrupt line triggered by one of the legacy interrupt
> +- interrupts or interrupts-extended: List of the interrupt sources which
> +  corresponding to the "interrupt-names". If non-empty then also additio=
nal
> +  'interrupt-controller' subnode must be defined.
> =20
>  Example:
> =20

Empty commit message. At least add something like this:

Document the following additional properties in the mvebu-pci DT
binding:
- interrupt-names
- interrupts / interrupts-extended


Marek
