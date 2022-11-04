Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89ADB61A3C4
	for <lists+linux-pci@lfdr.de>; Fri,  4 Nov 2022 22:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiKDV7m (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Nov 2022 17:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiKDV7l (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Nov 2022 17:59:41 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9998D31DD6;
        Fri,  4 Nov 2022 14:59:39 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id r83so6566007oih.2;
        Fri, 04 Nov 2022 14:59:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g8HWz9kiwP2ArMvVVBjsIPOdlOe9gKH5fjfr8UxkpAI=;
        b=5Smqpf3/BTrox1yUYdm2j+Yod/W/LVl34HSCYP2uCab97bo1rWXv7dXn0q8e1QChVY
         LbY5iiAiOz27IouScKCDvYToTMGRXFhD07ApIFFimlZ5rpwOQ0HQO9jkfYaUTBlqmVSn
         MxXDdqBmSGJADTIWMr7dW/lF6wrDlZaj9sTxpB/NZl8uk90urNsnMWTQLaluxb48od+e
         HXQAT0vDm8V1Ap4gQjJnE20l/rns2vky9ISrWwx01NWbSUGK6HnDYLtktZR4W/wB935O
         xhg/dwvt+Yo4Nxgk9QaJG7GC8K5a658lm2gbb+P/DSlmhIUJb7qCRmfptMiN9K1UN7ws
         kmmA==
X-Gm-Message-State: ACrzQf1yFN0Uyq74GQ4au9EXB1QNKTvzFvbe/hjS9OWPGm+ZtoB2BKB8
        TgzsftdyfBqq6CT4y8Vm4A==
X-Google-Smtp-Source: AMsMyM44JC4DHyZ3R5J0DsTWv8pZFFqZoZE6Jfx8IiWT3Y+Ce49KnN+aGjyJNEo2KWZSJ4NSxSPzrA==
X-Received: by 2002:a05:6808:1642:b0:331:567c:54e1 with SMTP id az2-20020a056808164200b00331567c54e1mr19705073oib.232.1667599178815;
        Fri, 04 Nov 2022 14:59:38 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o22-20020a9d5c16000000b0066756fdd916sm192116otk.68.2022.11.04.14.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 14:59:38 -0700 (PDT)
Received: (nullmailer pid 2900136 invoked by uid 1000);
        Fri, 04 Nov 2022 21:59:40 -0000
Date:   Fri, 4 Nov 2022 16:59:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Tinghan Shen <tinghan.shen@mediatek.com>
Cc:     Jianjun Wang <jianjun.wang@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-pci@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Ryder Lee <ryder.lee@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] dt-bindings: PCI: mediatek-gen3: Support mt8195
Message-ID: <166759917936.2900079.7086690867814056235.robh@kernel.org>
References: <20221103025656.8714-1-tinghan.shen@mediatek.com>
 <20221103025656.8714-2-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103025656.8714-2-tinghan.shen@mediatek.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On Thu, 03 Nov 2022 10:56:54 +0800, Tinghan Shen wrote:
> From: Jianjun Wang <jianjun.wang@mediatek.com>
> 
> In order to support mt8195 pcie node, update the yaml to support new
> properties of iommu and power-domain, and update the reset-names
> property to allow only one 'mac' name.
> 
> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> Signed-off-by: TingHan Shen <tinghan.shen@mediatek.com>
> ---
>  .../devicetree/bindings/pci/mediatek-pcie-gen3.yaml | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
