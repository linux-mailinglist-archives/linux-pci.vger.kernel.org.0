Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 894504D0D48
	for <lists+linux-pci@lfdr.de>; Tue,  8 Mar 2022 02:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbiCHBIu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Mar 2022 20:08:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344190AbiCHBIs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Mar 2022 20:08:48 -0500
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76321ADA8;
        Mon,  7 Mar 2022 17:07:53 -0800 (PST)
Received: by mail-oo1-f45.google.com with SMTP id x26-20020a4a9b9a000000b003211029e80fso3637901ooj.5;
        Mon, 07 Mar 2022 17:07:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=rxea/dYu/ELTNOWQBZ1ss1F6Twz4ycLAC2ZHEe2uUro=;
        b=qN9Py46ldMhjbS9TpTzWvqrfEaSBVr7QcR6Mo5H3n51p3qKBfGS9b9ZSHlOuHUuRri
         GRCHJWSy5hgMK1Ne/WCm3JEw0Xc83Jg3wOZvXcvxBrVexyfFQz6gTXZ2cV4VA+WxD6jH
         IiMs7H08DC3eBfjIkq7+Pwqb19MpSBn35EAiZsgXyIXtA3qE7bes0nSMlPdP3gHO/tCu
         96O9/fFPZR+1BnBZynjBvIyTKL/OpPnEnjFU13NbtD+ZsXqJx7CH/B8Ua1ypWC8dAkW6
         ETQOxfElgknTlDHTWimzCjOrVdq+t6XdJjRnXEmHxcipn9l6n95ASaExzgIzNTiv/Exl
         hJtQ==
X-Gm-Message-State: AOAM531AJKgYznoYxEpD4y+s6v2xZ2NM0u/E93VAvTf+gJS0SrBB93AP
        AlMZ+oYf1AaoCokIWVLGz1RfYIRgNQ==
X-Google-Smtp-Source: ABdhPJwuxBaYxiksU+rwdZLeIIANxi6L3vYW7ckdeo06O7RfTIGcy0DoTwNbwJESrg/gvsNx+NDLhA==
X-Received: by 2002:a05:6870:60a0:b0:d3:a3f7:8b59 with SMTP id t32-20020a05687060a000b000d3a3f78b59mr1004731oae.94.1646701672984;
        Mon, 07 Mar 2022 17:07:52 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p21-20020a4a2f15000000b00320fca09b74sm1377596oop.1.2022.03.07.17.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 17:07:51 -0800 (PST)
Received: (nullmailer pid 3624778 invoked by uid 1000);
        Tue, 08 Mar 2022 01:07:40 -0000
From:   Rob Herring <robh@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     kernel@pengutronix.de, linux-phy@lists.infradead.org,
        shawnguo@kernel.org, linux-pci@vger.kernel.org,
        alexander.stein@ew.tq-group.com, bhelgaas@google.com,
        linux-arm-kernel@lists.infradead.org, p.zabel@pengutronix.de,
        lorenzo.pieralisi@arm.com, devicetree@vger.kernel.org,
        vkoul@kernel.org, l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <1646644054-24421-3-git-send-email-hongxing.zhu@nxp.com>
References: <1646644054-24421-1-git-send-email-hongxing.zhu@nxp.com> <1646644054-24421-3-git-send-email-hongxing.zhu@nxp.com>
Subject: Re: [PATCH v2 2/7] dt-binding: phy: Add iMX8MP PCIe PHY binding
Date:   Mon, 07 Mar 2022 19:07:40 -0600
Message-Id: <1646701660.888371.3624774.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 07 Mar 2022 17:07:29 +0800, Richard Zhu wrote:
> Add i.MX8MP PCIe PHY binding.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.example.dt.yaml: pcie-phy@32f00000: resets: [[4294967295, 26]] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.example.dt.yaml: pcie-phy@32f00000: reset-names: ['pciephy'] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1601963

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

