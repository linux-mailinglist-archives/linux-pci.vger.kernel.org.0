Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A580177FAFE
	for <lists+linux-pci@lfdr.de>; Thu, 17 Aug 2023 17:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353239AbjHQPlD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Aug 2023 11:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353255AbjHQPks (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Aug 2023 11:40:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914FC2D6D;
        Thu, 17 Aug 2023 08:40:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CFE0638D5;
        Thu, 17 Aug 2023 15:40:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7971DC433C7;
        Thu, 17 Aug 2023 15:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692286846;
        bh=pRxsif8JlKAfLdB+T3fZbbIPVAzSOFHuTHn7rX4RoCU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l2U5bSFfaCme7/htqAE8HVLKhvoYU3uG8Ad18CUyTuFe2UB+1oS4/cxLXDXhT5/r1
         VIQGH0tiY59nii3muBz8mp4fwX07Gkmp/7LYZcA378c2/I3s8zDtzmpbh0dfjmF4TF
         /RPNHHmE1aorPjscN47GlNUm+h97rE5aNO4grTyed5a3eatGRo4JnRCNumivOnvR8V
         GDoXofYoqDUyh4sc6A6tRxXUAn2ChJjFTiIoThukqm6W7hUB39yr1oLXpQZdAn1vkh
         hJ1Moww2mLezp7Teu0pPdoXFf/CsXtuRrK963zZMpO3+JQgwS9o6pAlb6xSzpuz+Gk
         sOvu3T7arDXBg==
Received: (nullmailer pid 1138046 invoked by uid 1000);
        Thu, 17 Aug 2023 15:40:43 -0000
Date:   Thu, 17 Aug 2023 10:40:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     Minda Chen <minda.chen@starfivetech.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        linux-riscv@lists.infradead.org,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v3 01/11] dt-bindings: PCI: Add PLDA XpressRICH PCIe host
 common properties
Message-ID: <169228684231.1137777.15649817865540406129.robh@kernel.org>
References: <20230814082016.104181-1-minda.chen@starfivetech.com>
 <20230814082016.104181-2-minda.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814082016.104181-2-minda.chen@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On Mon, 14 Aug 2023 16:20:06 +0800, Minda Chen wrote:
> Add PLDA XpressRICH PCIe host common properties dt-binding doc.
> Microchip PolarFire PCIe host using PLDA IP.
> Move common properties from Microchip PolarFire PCIe host
> to PLDA files.
> 
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../bindings/pci/microchip,pcie-host.yaml     | 55 +-------------
>  .../pci/plda,xpressrich3-axi-common.yaml      | 75 +++++++++++++++++++
>  2 files changed, 76 insertions(+), 54 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/plda,xpressrich3-axi-common.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

