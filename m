Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9AC153AE57
	for <lists+linux-pci@lfdr.de>; Wed,  1 Jun 2022 22:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiFAUpp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Jun 2022 16:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiFAUpW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Jun 2022 16:45:22 -0400
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5025426271D;
        Wed,  1 Jun 2022 13:32:21 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id v22so4924389ybd.5;
        Wed, 01 Jun 2022 13:32:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Mi2KakMLN5Oolk1j9IuMk3Qtihd6Doqcyb4Wzf1iGb8=;
        b=61Z+F7FfX1RTSXCWowX8VUIC3KzVuBfD3m75Cjl5bQltO0Fil4mRfmnTo0Ma5V4qfX
         EUGQtT7wY/alYb72p/8asn23T25AzM+Lc5dCWeZ+HU2oE8+hgoSatWujwq5F5etLwTDN
         IcDL76auIF23Fx53sZOwmeArmsy2b24aeSLN/Yti43TA6KtQDTLMk0z0fIX3ci/oSyxQ
         tsTBiNa4riZNh93yb+fHzGoebmOXYG/0md/TUfxKra/28X95f3qQw1886NOtqUgKiW3g
         2Tdx2XxU6kqpDitpkmLVVgfis5FF7lkfjJhHQSL8FDYiIkw+e5k5gUk5q6BLJYhdWpYH
         zEHQ==
X-Gm-Message-State: AOAM532w1UEJk5CU4x2IJvlfGkNlJ0P/BwZewF1Rdn6zkJEkD3OHDLMS
        Qxm941MIh+PVqUknpcL0LOzq0MLVHQ==
X-Google-Smtp-Source: ABdhPJwqckOQJ3oMBSt13P0tpXRYlnNBp7YUsO7ydUCg7j9OhqxwYVxJIbSGKXig+2EFQEhRTAc4tw==
X-Received: by 2002:a05:6830:45:b0:60b:196a:c0d7 with SMTP id d5-20020a056830004500b0060b196ac0d7mr637703otp.314.1654113324745;
        Wed, 01 Jun 2022 12:55:24 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v1-20020a056830090100b00605fd407259sm1228404ott.3.2022.06.01.12.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 12:55:24 -0700 (PDT)
Received: (nullmailer pid 328210 invoked by uid 1000);
        Wed, 01 Jun 2022 19:55:23 -0000
Date:   Wed, 1 Jun 2022 14:55:23 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        michals@xilinx.com, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: PCI: xilinx-cpm: Fix reg property order
Message-ID: <20220601195523.GA328031-robh@kernel.org>
References: <20220516102217.25960-1-bharat.kumar.gogada@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516102217.25960-1-bharat.kumar.gogada@xilinx.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 16 May 2022 15:52:17 +0530, Bharat Kumar Gogada wrote:
> All existing vendor DTSes are using "cpm_slcr" reg followed by "cfg" reg.
> 
> This order is also suggested by node name which is pcie@fca10000 which
> suggests that cpm_slcr register should be the first.
> 
> Driver itself is using devm_platform_ioremap_resource_byname() for both
> names that's why there is no functional change even on description which
> are using current order.
> 
> But still prefer to change order to cover currently used description.
> Fixes: e22fadb1d014 ("PCI: xilinx-cpm: Add YAML schemas for Versal CPM Root Port")
> 
> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> ---
>  .../devicetree/bindings/pci/xilinx-versal-cpm.yaml     | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 

Applied, thanks!
