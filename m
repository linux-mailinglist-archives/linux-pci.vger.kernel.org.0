Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9DD613927
	for <lists+linux-pci@lfdr.de>; Mon, 31 Oct 2022 15:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbiJaOnC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Oct 2022 10:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbiJaOnB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Oct 2022 10:43:01 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E880138A9;
        Mon, 31 Oct 2022 07:43:00 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-13ae8117023so13658222fac.9;
        Mon, 31 Oct 2022 07:43:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+B+bKwkZajw9wqTsexpQ+swmijNJ09uQIWw31o7PxQ=;
        b=4y6k4Lhfg6ZVnRQ2R8Wr4WqaCRQWwUyzWtRfnvb8AcaeHs6NoIU3PjeN9v34WRDBha
         J7hmfXjp/Siutu5+eKBJNMhu+9im5RlXfNRGegsTlw0Ob9nvc0qe/Cj7PPUEGmGEw9HE
         fG+K9fqExwQzHiHLpTLvY15g2Tx3iqFKBrhKf6neWLlMBwIWyaqsgqnRBYnG7Q0G4TzW
         kNxf/j/rtGndtj03zc4l63pzDN3pcVc9zSL1O76Itvz3sfMkOy04Tvw7Dss+8qXfzhJz
         WUvHoLtPXp3lzQN6kaoWfkS5tgUBVIn5PLHCP8COsRwM8fyZ1mxH836kcFoyKUQtMutj
         0Zsw==
X-Gm-Message-State: ACrzQf2F/vlOWdmt98FKPKeGoqgFZbiOR1vBVLMbnz7UFXFTty3azjMW
        zxVNf56/+jeKZz/dYX8BiQ==
X-Google-Smtp-Source: AMsMyM6r3n78WWlzNtMmHub5yrpP5yHb6caca/SxmRCN8GdJrio1xlSLZskM2+oZwdb8CDa0AodveQ==
X-Received: by 2002:a05:6870:c88d:b0:137:11e7:12e9 with SMTP id er13-20020a056870c88d00b0013711e712e9mr7713557oab.220.1667227380162;
        Mon, 31 Oct 2022 07:43:00 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g10-20020a4a250a000000b00480fd5b0d6bsm178938ooa.22.2022.10.31.07.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 07:42:59 -0700 (PDT)
Received: (nullmailer pid 2857339 invoked by uid 1000);
        Mon, 31 Oct 2022 14:43:01 -0000
Date:   Mon, 31 Oct 2022 09:43:01 -0500
From:   Rob Herring <robh@kernel.org>
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     linux-mediatek@lists.infradead.org,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/2] dt-bindings: PCI: mediatek-gen3: add SoC based
 clock config
Message-ID: <20221031144301.GA2856406-robh@kernel.org>
References: <20221029175806.14899-1-frank-w@public-files.de>
 <20221029175806.14899-2-frank-w@public-files.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221029175806.14899-2-frank-w@public-files.de>
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

On Sat, Oct 29, 2022 at 07:58:05PM +0200, Frank Wunderlich wrote:
> The PCIe driver covers different SOC which needing different clock
> configs. Define them based on compatible.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> v2:
> - fix typo in mediatek,mt8192-pcie
> v3:
> - remove contains to match only if compatible is no fallback
>   tested with series "Add driver nodes for MT8195 SoC" and mt7986
>   pcie-nodes, dtbs_check is now clean
> ---
>  .../bindings/pci/mediatek-pcie-gen3.yaml      | 47 ++++++++++++++-----
>  1 file changed, 35 insertions(+), 12 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
