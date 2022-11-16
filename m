Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3739762CB2A
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 21:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbiKPUiN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 15:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiKPUiM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 15:38:12 -0500
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21584CE1C;
        Wed, 16 Nov 2022 12:38:12 -0800 (PST)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-13b6c1c89bdso21466420fac.13;
        Wed, 16 Nov 2022 12:38:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HnRJq35FU5K24iT24xDh+k9lk7y71HZpwcz02Kh7y6Q=;
        b=5KZ0Bl8iLmn4yQOpsEV9X3s0uKBiHZCs8qAunv6F+ecYzd539vXhKdLfZQohuGf41j
         2v5U++XNu89bX1Hu9dJ40lvgrcCRipz2pptxYqR6gB1xo+rz/jE7WLwHZKexTB6OsUbi
         EUtLVRmeLVix0+2fkePt2TiccwszQRHdkBVVC4+U10c/uHlWqe5BON1J7/jYAI7bg6Q/
         AFjoh2iCQI34Rfk9ZiouL/1+h8Ai7iU+bNYCgMSYSrgfNFpFinseHXiDYpKoJ54h4xte
         mPDTnJ5VOzIm8kur4U2cBu5NnM22CcUjUUMW4x6K8Xdvss6ej+u8Mk5h5hqMm7fYIKtV
         Rf9Q==
X-Gm-Message-State: ANoB5pm9WxQP/FNHXXW2lZjr2JTSDSdX7EAm82Lp4+v9FfqxkpSW0Qrs
        sMV6sYna1k2fCbX91UhAPw==
X-Google-Smtp-Source: AA0mqf52E+J+ZVB9pFbQk8/8PdLI5NNCFohvwi6r1HMLDxt2gQKSZNLlLScuDKeTerUJmBdidzgYQw==
X-Received: by 2002:a05:6870:d69c:b0:13b:ac28:c61a with SMTP id z28-20020a056870d69c00b0013bac28c61amr2733059oap.219.1668631091289;
        Wed, 16 Nov 2022 12:38:11 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z9-20020a4ade49000000b0049eedb106e2sm6490658oot.15.2022.11.16.12.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 12:38:10 -0800 (PST)
Received: (nullmailer pid 845059 invoked by uid 1000);
        Wed, 16 Nov 2022 20:38:12 -0000
Date:   Wed, 16 Nov 2022 14:38:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Robin Murphy <robin.murphy@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        caihuoqing <caihuoqing@baidu.com>, Vinod Koul <vkoul@kernel.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-arm-kernel@lists.infradead.org, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v7 01/20] dt-bindings: imx6q-pcie: Fix clock names for
 imx6sx and imx8mq
Message-ID: <20221116203812.GA834519-robh@kernel.org>
References: <20221113191301.5526-1-Sergey.Semin@baikalelectronics.ru>
 <20221113191301.5526-2-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221113191301.5526-2-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Nov 13, 2022 at 10:12:42PM +0300, Serge Semin wrote:
> Originally as it was defined the legacy bindings the pcie_inbound_axi and
> pcie_aux clock names were supposed to be used in the fsl,imx6sx-pcie and
> fsl,imx8mq-pcie devices respectively. But the bindings conversion has been
> incorrectly so now the fourth clock name is defined as "pcie_inbound_axi
> for imx6sx-pcie, pcie_aux for imx8mq-pcie", which is completely wrong.
> Let's fix that by conditionally apply the clock-names constraints based on
> the compatible string content.
> 
> Fixes: 751ca492f131 ("dt-bindings: PCI: imx6: convert the imx pcie controller to dtschema")
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Acked-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> 
> ---
> 
> Changelog v5:
> - This is a new patch added on the v5 release of the patchset.
> 
> Changelog v7:
> - Move the allOf clause to the bottom of the bindings. (@Krzysztof)
> - Get back the names to the clock-names property and make sure the
>   platform-specific name constraint is applied in the allOf clause.
>   (@Rob)
> ---
>  .../bindings/pci/fsl,imx6q-pcie.yaml          | 46 +++++++++++++++++--
>  1 file changed, 42 insertions(+), 4 deletions(-)

We have 2 patches doing the same thing:

https://lore.kernel.org/all/20221109002449.35936-1-marex@denx.de/

Please hash out which one you all want. Both seem to have clock 
warnings still...

Reviewed-by: Rob Herring <robh@kernel.org>
