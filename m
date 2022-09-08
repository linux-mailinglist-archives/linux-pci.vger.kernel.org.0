Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404845B2709
	for <lists+linux-pci@lfdr.de>; Thu,  8 Sep 2022 21:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbiIHToW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Sep 2022 15:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbiIHTno (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Sep 2022 15:43:44 -0400
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE70D2B39;
        Thu,  8 Sep 2022 12:43:06 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id br15-20020a056830390f00b0061c9d73b8bdso13022231otb.6;
        Thu, 08 Sep 2022 12:43:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=J5un3Ml+zWC6SWVRC43OmYblXMOgwS92Fnp68el50+8=;
        b=3tULvDKAgtj6WzrDmbpOwMtlcK53+69l3NJq5653lVgXUbjkGe/K4gkRbeBmH37hqE
         uICXjYOrWn/qWxxjgxlhhnCS2ZKZRFY3sTdkFtTK/5ZeejFfOmzq5cirNZpSQWXnpYAF
         3Pwd746QEe/DB7RddytBoXn+b5rmds16tOC5Yc+c68rp7jO67Ay5csEltQp5VVYtEsvM
         vUjN2dgWOdRCPztdyRwJnBhymwFfX9F0dpPGiXdIdMhsQ4jJp6K3B8CUDunIc4MXfmlp
         l+XLkKkUWLCNX1QAl769pXoUUvkx2w3UwSPz5Pu7n5FX8njPD0/7EwRXK8IeUKrzLLYl
         87FA==
X-Gm-Message-State: ACgBeo0KEm6OPUpSs/gaiiDBt529zrqZw0G7ixChOr8wdzBDePyXvNly
        XQ/6LIHNKZ2tpGeV8pj77A==
X-Google-Smtp-Source: AA6agR4DcNNkZrZjXxttUoiwlL8F8Vcud254YsoQYoquGXCB1fqYi6b5GSYcWx6p9gPu8DPGx4c3rA==
X-Received: by 2002:a05:6830:6999:b0:61d:26f8:94c1 with SMTP id cy25-20020a056830699900b0061d26f894c1mr4137073otb.278.1662666179874;
        Thu, 08 Sep 2022 12:42:59 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b11-20020a9d754b000000b0061d31170573sm8872283otl.20.2022.09.08.12.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 12:42:59 -0700 (PDT)
Received: (nullmailer pid 3217199 invoked by uid 1000);
        Thu, 08 Sep 2022 19:42:58 -0000
Date:   Thu, 8 Sep 2022 14:42:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     l.stach@pengutronix.de, richard.leitner@linux.dev,
        vkoul@kernel.org, shawnguo@kernel.org, bhelgaas@google.com,
        alexander.stein@ew.tq-group.com, linux-phy@lists.infradead.org,
        kernel@pengutronix.de, devicetree@vger.kernel.org,
        linux-imx@nxp.com, p.zabel@pengutronix.de,
        lorenzo.pieralisi@arm.com, marex@denx.de,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 1/7] dt-binding: phy: Add iMX8MP PCIe PHY binding
Message-ID: <20220908194258.GA3217149-robh@kernel.org>
References: <1662109086-15881-1-git-send-email-hongxing.zhu@nxp.com>
 <1662109086-15881-2-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1662109086-15881-2-git-send-email-hongxing.zhu@nxp.com>
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

On Fri, 02 Sep 2022 16:58:00 +0800, Richard Zhu wrote:
> Add i.MX8MP PCIe PHY binding.
> On iMX8MM, the initialized default value of PERST bit(BIT3) of
> SRC_PCIEPHY_RCR is 1b'1.
> But i.MX8MP has one inversed default value 1b'0 of PERST bit.
> 
> And the PERST bit should be kept 1b'1 after power and clocks are stable.
> So add one more PERST explicitly for i.MX8MP PCIe PHY.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Tested-by: Marek Vasut <marex@denx.de>
> Tested-by: Richard Leitner <richard.leitner@skidata.com>
> Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  .../bindings/phy/fsl,imx8-pcie-phy.yaml          | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
