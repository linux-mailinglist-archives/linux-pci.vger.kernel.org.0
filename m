Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D3162D489
	for <lists+linux-pci@lfdr.de>; Thu, 17 Nov 2022 09:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239433AbiKQIAh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Nov 2022 03:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239383AbiKQIAF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Nov 2022 03:00:05 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46538716FF;
        Thu, 17 Nov 2022 00:00:01 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id b3so1553893lfv.2;
        Thu, 17 Nov 2022 00:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hy7NLr5hqE2CbJ9jouBdK1ZIwHDUPfh4zTUfGBjG5As=;
        b=n7y4fRjf6M5mskOzXdXUZu8ArEzlfdQw6BxAnS7gl3FgJm37oY7ADxdez6z4WWtTEk
         GZeTVdJPSVQyNhme1p8tRboH2k51cxTEp8FLujI3ksGvHyel2Gyta3T8gmbGylSm7rwA
         ZKFDykhol1g8+PCoHl1KQi6weDsspBkelXR/lkOk9fV9WD1QVDExKjbRjO/Adltz8PDH
         KljdCHYf+Ok5oN5ZLJ+Dxe9MFmgMQZB7M5h4ZaWFO68V2azjPzkURmfYgBkzoVIJCZjX
         9fU97XTmcsYxdyLWTdI9jmgzKUFNnDrGjZW1+wVIo/BrtSaho6N/nwid7ytf5AzDXNIL
         tbfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hy7NLr5hqE2CbJ9jouBdK1ZIwHDUPfh4zTUfGBjG5As=;
        b=taqWzTGe7++D8kO9uiJNk7eTJt5qvALitUfNrlivLM6Pz9s84Tu88eD8dMAju+VLKR
         Y2WOf+n2Jfrc+Ee6JhkKRWdx2qNHg3RhQUs4fHhZ2oaoEY/sJSPCTcwGNw8k0rBpqBXJ
         sfjp6WBFmK5uom2B49wd2bY7eLHFXa7eDJ0S1FMUrkCvjv44dQOnYd14g38m2ZE1KnzX
         hMthdLR+ChnIiaXzJ2hHj+KCJQIq3KVtBPVQdXNZrtUJckASxQ1pQSCUWf3k2Ma+RPae
         UgA7MPcWPpRxAYTbfj7yGSKEknTE2vwvqQ8eBKYdf+y4MdxPpPE0bY/C7hVnFCejcmD/
         d5zw==
X-Gm-Message-State: ANoB5pln/iMauXgATTQSe5ojv00AmQnwG0u/xevCYZ6DyiMg0lZBtt4b
        GKBvPmN+CNiPueRbQy0F77o=
X-Google-Smtp-Source: AA0mqf5/X/D4OGM7Km0DSNGgRsSX5HuHd40Bn19ehlIO61z4kcYkdVKpjil1rziL0MyeWcAlCyLmvw==
X-Received: by 2002:ac2:4201:0:b0:4b1:7c15:e923 with SMTP id y1-20020ac24201000000b004b17c15e923mr512728lfh.320.1668671999651;
        Wed, 16 Nov 2022 23:59:59 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id b17-20020a196711000000b004a100c21eaesm28532lfc.97.2022.11.16.23.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 23:59:59 -0800 (PST)
Date:   Thu, 17 Nov 2022 10:59:56 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Rob Herring <robh@kernel.org>, Marek Vasut <marex@denx.de>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
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
        NXP Linux Team <linux-imx@nxp.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        caihuoqing <caihuoqing@baidu.com>, Vinod Koul <vkoul@kernel.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 01/20] dt-bindings: imx6q-pcie: Fix clock names for
 imx6sx and imx8mq
Message-ID: <20221117075956.4dw4g7cswr2iamro@mobilestation>
References: <20221113191301.5526-1-Sergey.Semin@baikalelectronics.ru>
 <20221113191301.5526-2-Sergey.Semin@baikalelectronics.ru>
 <20221116203812.GA834519-robh@kernel.org>
 <20221117074318.cd52h5ks7ay4j4wb@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117074318.cd52h5ks7ay4j4wb@mobilestation>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 17, 2022 at 10:43:22AM +0300, Serge Semin wrote:
> On Wed, Nov 16, 2022 at 02:38:12PM -0600, Rob Herring wrote:
> > On Sun, Nov 13, 2022 at 10:12:42PM +0300, Serge Semin wrote:
> > > Originally as it was defined the legacy bindings the pcie_inbound_axi and
> > > pcie_aux clock names were supposed to be used in the fsl,imx6sx-pcie and
> > > fsl,imx8mq-pcie devices respectively. But the bindings conversion has been
> > > incorrectly so now the fourth clock name is defined as "pcie_inbound_axi
> > > for imx6sx-pcie, pcie_aux for imx8mq-pcie", which is completely wrong.
> > > Let's fix that by conditionally apply the clock-names constraints based on
> > > the compatible string content.
> > > 
> > > Fixes: 751ca492f131 ("dt-bindings: PCI: imx6: convert the imx pcie controller to dtschema")
> > > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > > Acked-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > > 
> > > ---
> > > 
> > > Changelog v5:
> > > - This is a new patch added on the v5 release of the patchset.
> > > 
> > > Changelog v7:
> > > - Move the allOf clause to the bottom of the bindings. (@Krzysztof)
> > > - Get back the names to the clock-names property and make sure the
> > >   platform-specific name constraint is applied in the allOf clause.
> > >   (@Rob)
> > > ---
> > >  .../bindings/pci/fsl,imx6q-pcie.yaml          | 46 +++++++++++++++++--
> > >  1 file changed, 42 insertions(+), 4 deletions(-)
> > 
> > We have 2 patches doing the same thing:
> > 
> > https://lore.kernel.org/all/20221109002449.35936-1-marex@denx.de/
> 

> It seems to me that that patch does two things at a time:
> 1. Fixes invalid fourth clock-names entry.
> 2. Fixes the fsl,imx8mm-pcie device having the "pcie_aux" clock name
> required instead of "pcie_phy".
> 
> My patch does only the first part. What about moving my patch to that
> series and converting the Marek' patch to being applicable on top of
> it and fixing the imx8mm part only? That seems reasonable.

BTW, if this patch is moved from here the series will fail the
dt_binding_check procedure.

-Sergey

> 
> -Sergey
> 
> > 
> > Please hash out which one you all want. Both seem to have clock 
> > warnings still...
> > 
> > Reviewed-by: Rob Herring <robh@kernel.org>
