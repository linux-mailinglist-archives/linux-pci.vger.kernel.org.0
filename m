Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908DF508D45
	for <lists+linux-pci@lfdr.de>; Wed, 20 Apr 2022 18:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380566AbiDTQag (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Apr 2022 12:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379855AbiDTQaf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Apr 2022 12:30:35 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29253EB90;
        Wed, 20 Apr 2022 09:27:48 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id r8so2626098oib.5;
        Wed, 20 Apr 2022 09:27:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s0Czcu6TCdRJh3Fx3ESiSoL0ZyRIITOPGEegqcioA0I=;
        b=wGEC3QuW9wpsoJU4eXbH894zW4EBS2VXHTzkrwLWGlHk6JIQpgIMOiD2EsxdcXLW/v
         316zvsYFblFCt+JvVXlwWegE25XDXzdwzKwwZ/HX2XxmrJ/+u9Q+U7kpXLKa/q9Z1J+j
         AyRoUW86ia5kSLKohVz27fJVr+zqMO0BSBEAAl/Fh8PYN6gFbsldPh1xl442weRvIkg3
         p1y+nyFrQP0uUWPzM359eDpDAspw62rgyLtQnB/oCRdafrrDkARciWhcmXEudn+UAECO
         bZYIr4yOARsIMQjjcy3MgbbWhBg6+STbu9QySjoaCNfeD/hdB4lrZlYHxsm/n6jyMVat
         XP8Q==
X-Gm-Message-State: AOAM533Qv7UKra1UV3CywaTwRJStMDPszqubYtLTcs4Muw0nNkm7r6/g
        7jMyb+Z5UuajNhFe+TIRc9MNUCWvUQ==
X-Google-Smtp-Source: ABdhPJyRPm3dclqsf2iFh3UbCM9lc4G9rxreTjcEaDUvEUguNudR6cmXNyCdMlZBbXh2js1oF7+nyQ==
X-Received: by 2002:a05:6808:3010:b0:2f7:3e71:88b2 with SMTP id ay16-20020a056808301000b002f73e7188b2mr2159525oib.102.1650472068176;
        Wed, 20 Apr 2022 09:27:48 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j5-20020a4a7505000000b0033a47bb6a74sm2123535ooc.47.2022.04.20.09.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 09:27:47 -0700 (PDT)
Received: (nullmailer pid 1428607 invoked by uid 1000);
        Wed, 20 Apr 2022 16:27:46 -0000
Date:   Wed, 20 Apr 2022 11:27:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Simon Xue <xxm@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v7 1/4] dt-bindings: pci: remove fallback from Rockchip
 DesignWare binding
Message-ID: <YmA0gokzLKqX7dxP@robh.at.kernel.org>
References: <20220416110507.642398-1-pgwipeout@gmail.com>
 <20220416110507.642398-2-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220416110507.642398-2-pgwipeout@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, 16 Apr 2022 07:05:03 -0400, Peter Geis wrote:
> The snps,dw-pcie binds to a standalone driver.
> It is not fully compatible with the Rockchip implementation and causes a
> hang if it binds to the device.
> 
> Remove this binding as a valid fallback.
> 
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> ---
>  .../devicetree/bindings/pci/rockchip-dw-pcie.yaml    | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
