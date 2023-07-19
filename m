Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D091075A1E2
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jul 2023 00:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjGSW3F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jul 2023 18:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjGSW3E (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jul 2023 18:29:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF6D1BF0;
        Wed, 19 Jul 2023 15:29:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BB296185C;
        Wed, 19 Jul 2023 22:29:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BE06C433C8;
        Wed, 19 Jul 2023 22:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689805742;
        bh=T0Rl94QpvEH/miwFOS4iHM/IaiFlx/fGh1ZwAtgQHk0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sjwZao8XnSIid5fdLV73IB4OJR0gKp7uKiK5gz743nh82oI+Bz+iJY6GWMEqxYo8U
         z2mD4ayKrLZx5m6/H2lEkZCJPlFQK+ZEQZGIAIQzcVnno5nxJ45Um4XFNSG5jhlYhP
         yFuJHaGmN9GItnIYggqEqzilPXhGEz7kOPEWv2n5CXs6/5iA9PP5uNosuNw6wpdTP9
         sTu5LY+lwiLliIEuIbaxc/+ZiTzW5T87aEk2/IJZ2qR2IYMaLJ4CV4EiQ2CPplawxJ
         tb2h6tnIe+K/Hi34U11CYI7ksnHDknNx16+sZ2vp1FwgD7G9LVNc3pLVJBUPRWfCh+
         A4VN+IjfAPpeQ==
Received: (nullmailer pid 887921 invoked by uid 1000);
        Wed, 19 Jul 2023 22:29:00 -0000
Date:   Wed, 19 Jul 2023 16:29:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Minda Chen <minda.chen@starfivetech.com>
Cc:     Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pci@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>
Subject: Re: [PATCH v1 5/9] dt-bindings: PLDA: Add PLDA XpressRICH PCIe host
 controller
Message-ID: <20230719222900.GA882340-robh@kernel.org>
References: <20230719102057.22329-1-minda.chen@starfivetech.com>
 <20230719102057.22329-6-minda.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719102057.22329-6-minda.chen@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 19, 2023 at 06:20:53PM +0800, Minda Chen wrote:
> Add PLDA XpressRICH host controller dt-bindings. Both Microchip
> PolarFire SoC and StarFive JH7110 SoC are using PLDA XpressRICH
> PCIe host controller IP.
> 
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  .../pci/plda,xpressrich-pcie-host.yaml        | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/plda,xpressrich-pcie-host.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/plda,xpressrich-pcie-host.yaml b/Documentation/devicetree/bindings/pci/plda,xpressrich-pcie-host.yaml
> new file mode 100644
> index 000000000000..10a10862a078
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/plda,xpressrich-pcie-host.yaml
> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/plda,xpressrich-pcie-host.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: PLDA XpressRICH PCIe host controller
> +
> +maintainers:
> +  - Daire McNamara <daire.mcnamara@microchip.com>
> +  - Minda Chen <minda.chen@starfivetech.com>
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-bus.yaml#
> +  - $ref: plda,xpressrich-pcie-common.yaml#
> +  - $ref: /schemas/interrupt-controller/msi-controller.yaml#
> +
> +properties:
> +  compatible:
> +    const: plda,xpressrich-pcie-host

What h/w is this in? I don't see why this is needed. You have the common 
schema for the IP block and then the Microchip and Starfive schemas for 
the 2 implementations.

Rob
