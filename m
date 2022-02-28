Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E994C6AC8
	for <lists+linux-pci@lfdr.de>; Mon, 28 Feb 2022 12:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235910AbiB1Ljt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Feb 2022 06:39:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235901AbiB1Ljq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Feb 2022 06:39:46 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353394FC71;
        Mon, 28 Feb 2022 03:39:07 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id h15so17145415edv.7;
        Mon, 28 Feb 2022 03:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0R1g/497q0dQleECorPMMse003Wri8L14vlThYCB5qU=;
        b=fwIGkks5zR/CacLDWsAb6PLTwups60q6KGsyXa5lsUR2GGiprP5uD9R3hdGaLzOzqI
         eDOTqnlOaMvFQyr5V+jq9ophH+EuxdLDVZDYqWzonNT21QTbBNLXnX2tbfxf+6QsLYwS
         fl6z/DJg7o7ltAaXzjhI01/ls99OaaGuuEKD8/z6p+gZVrRz6Z+yc9Gh61SmqEtuAV9+
         4bFH+vKk1aGSUQam3SCIY2FaS7kNocom3aZ5v9TfF51nNXTiPnGCWGFXQcFI341koJbB
         tAIB74jbX0shWE2k31VBvpF/TDtVHSPrpTUxe9/9sfYCyzSVtf9aj/erLlan6tZTbT/8
         XsDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0R1g/497q0dQleECorPMMse003Wri8L14vlThYCB5qU=;
        b=o2LRdhqEDLz3703QULMg9ZpEuFn7i3IqA5edL8Gb6BokVSHtMN5jNXG0ZFbsltOfvp
         nb8zC0bly7Wd6D52zerg95hEU9Xp0U5w1deWcHIplKKdnCrLCJvL8GmaKSom4MoJIyhe
         x4h3hFlNGNMEiabWrh9OV0kRTq08OJZGras0NacHPTt+AR49dOSQ1A6TuoBFvPIQRTrt
         +/JSEmE0r0zP0GvKd2WGRjQYUJA3si4pTuiD61KP66SEJxecp72oLgF+0646fEl2ewll
         Q5aBCH28BbJnZ+S7K/DUxKf9cS7y2buatZ3PPCZU5Sn24KvnLzHEzAO22gI1iDJ26199
         zCxQ==
X-Gm-Message-State: AOAM531zR+/RwU7BSybGNGvWCmnwXmWTmOzG/kwKAsy8hBG4asMVQqud
        5HDXLdvG1CYC5XPLJfiAW2JTMJfH7yYm91ro03U=
X-Google-Smtp-Source: ABdhPJya+oa/C+KISol4o9GENLWFEr+pbVWx325TSmODYC6jgIQMrwtXWYjjzH7ps4fAFo48asTefPxEpyV/5+NduAc=
X-Received: by 2002:a05:6402:17d4:b0:413:2f6b:23c1 with SMTP id
 s20-20020a05640217d400b004132f6b23c1mr18725886edy.377.1646048345646; Mon, 28
 Feb 2022 03:39:05 -0800 (PST)
MIME-Version: 1.0
References: <20211126083119.16570-1-kishon@ti.com> <20211126083119.16570-6-kishon@ti.com>
In-Reply-To: <20211126083119.16570-6-kishon@ti.com>
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
Date:   Mon, 28 Feb 2022 12:38:54 +0100
Message-ID: <CAH9NwWd9K=JmsBQkt9rJShTY8zVpTashq7HGfsgc5k=ZcCyQSg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] PCI: keystone: Set DMA mask and coherent DMA mask
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi all.

Am So., 28. Nov. 2021 um 18:12 Uhr schrieb Kishon Vijay Abraham I
<kishon@ti.com>:
>
> Set DMA mask and coherent DMA mask such to indicate the device
> can address the entire address space (32-bit in the case of
> K2G and 48-bit in the case of AM654).
>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/controller/dwc/pci-keystone.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index 73e6626a0d8f..80dbab267f7b 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -1224,6 +1224,11 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
>                 return ret;
>         }
>
> +       if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(48))) {
> +               dev_err(dev, "Cannot set DMA mask\n");
> +               return -EINVAL;
> +       }
> +
>         ret = of_property_read_u32(np, "num-lanes", &num_lanes);
>         if (ret)
>                 num_lanes = 1;
> --
> 2.17.1
>

Can this single patch (from the whole series) be merged?

-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
