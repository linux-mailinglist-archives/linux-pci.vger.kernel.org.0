Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A616C377D
	for <lists+linux-pci@lfdr.de>; Tue, 21 Mar 2023 17:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjCUQ57 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Mar 2023 12:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjCUQ56 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Mar 2023 12:57:58 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC4F1BF8;
        Tue, 21 Mar 2023 09:57:57 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id v17so1828538oic.5;
        Tue, 21 Mar 2023 09:57:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679417876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+NYT6/BKIUKBpZUikL9i2eT/s0p9j2M6TmaP9t/4zBo=;
        b=QdMxpTg61XD1B+W0s08IKfPvfrE8EFjfNeGQyQ7GA1eJnD0q6Co3E8QXzNRCpN+hZA
         HK5IQPfnTtY8kQDkG2q9ytG0cRtQAlSshk84ZC1Q6WtsQLZJ78V2704N3CLzYN6phBxZ
         YVesjTFNvp/OYP7yxUlKcQ4Q+iEONRsUXnO3SmfBmCBhfuXDoWGfFfw0GSfPHfnuNGLT
         u2jBWyQJzBBhJ9+6B8qZJUF7hYXHBhnwZSlXgjg3S9GsLiZVEVtPjwUnwzC62ZnDU6RU
         JGoIVXBqm9DNRKivufnYCDFo+1Azk2+UuspZj5unsLSud2R5bELTvkWv3SG734JsPnip
         ipfQ==
X-Gm-Message-State: AO0yUKVjqPSYY+qoNEko8UKwrkxMFYZQGpQa/iTpCjR9W5pMKjt6csI2
        Yka4bRPjCNHyGcjD+LIyDw==
X-Google-Smtp-Source: AK7set88VFMo3gqa89T6gYa1MXGYZmfk0qMNlofc1ibiXSiDOEWA9mj49rVetrklI2BsjqBMuC9iNA==
X-Received: by 2002:a05:6808:688:b0:387:262c:ef4f with SMTP id k8-20020a056808068800b00387262cef4fmr1030253oig.0.1679417876421;
        Tue, 21 Mar 2023 09:57:56 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a14-20020a9d6e8e000000b00670679748f9sm5404900otr.49.2023.03.21.09.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 09:57:56 -0700 (PDT)
Received: (nullmailer pid 950146 invoked by uid 1000);
        Tue, 21 Mar 2023 16:57:55 -0000
Date:   Tue, 21 Mar 2023 11:57:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jian Yang <jian.yang@mediatek.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        chuanjia.liu@mediatek.com, jieyy.yang@mediatek.com,
        qizhong.cheng@mediatek.com
Subject: Re: [PATCH v2 2/2] PCI: mediatek-gen3: Add power and reset control
 feature for downstream component
Message-ID: <20230321165755.GA942823-robh@kernel.org>
References: <20230306064059.7239-1-jian.yang@mediatek.com>
 <20230306064059.7239-3-jian.yang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306064059.7239-3-jian.yang@mediatek.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 06, 2023 at 02:40:59PM +0800, Jian Yang wrote:
> From: "jian.yang" <jian.yang@mediatek.com>
> 
> Make MediaTek's controller driver capable of controlling power
> supplies and reset pin of a downstream component in power-on and
> power-off flow.
> 
> Some downstream components (e.g., a WIFI chip) may need an extra
> reset other than PERST# and their power supplies, depending on
> the requirements of platform, may need to controlled by their
> parent's driver. To meet the requirements described above, I add this
> feature to MediaTek's PCIe controller driver as a optional feature.

If you have PCI devices with extra stuff that's not standard PCI stuff 
(i.e. what's on a standard connector), then you should be describing 
the PCI device in the DT.

The standard stuff should really be in the root port node rather than 
the host bridge node. That's often omitted too because many host bridges 
only have a single root port.

> 
> Signed-off-by: jian.yang <jian.yang@mediatek.com>
> ---
>  drivers/pci/controller/pcie-mediatek-gen3.c | 86 ++++++++++++++++++++-
>  1 file changed, 85 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> index b8612ce5f4d0..45e368b03ed2 100644
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> @@ -8,6 +8,8 @@
>  
>  #include <linux/clk.h>
>  #include <linux/delay.h>
> +#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/iopoll.h>
>  #include <linux/irq.h>
>  #include <linux/irqchip/chained_irq.h>
> @@ -15,11 +17,14 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/msi.h>
> +#include <linux/of_gpio.h>

This header is getting removed. You shouldn't depend on it.

Rob
