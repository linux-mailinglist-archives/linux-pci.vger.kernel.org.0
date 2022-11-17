Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A5062D44C
	for <lists+linux-pci@lfdr.de>; Thu, 17 Nov 2022 08:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234668AbiKQHn3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Nov 2022 02:43:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234607AbiKQHn1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Nov 2022 02:43:27 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAECEF6;
        Wed, 16 Nov 2022 23:43:23 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id l12so1482658lfp.6;
        Wed, 16 Nov 2022 23:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nNAXKBtGSeRWoeTA7vve2sl147mbg/EYPDhDH8dLOgc=;
        b=CRZk9rEK6s7SNtff/bWseZb5knLL5lebeP9aso16FoCExHgCUWAraboRWFhJU6zkvg
         t4LLhCu3XMWnJY0m39qHYrNOHesCpgx1Ld2rXxBqGWmwB/jcU+gEX3cF5AcDo46pvdhK
         +UPmNSgxNzMALBLNfrdA9ZScaK/5ir/QglDIDwkPjkLslZkVGMG96jEDf6Bl5SWDs/In
         9oQpRiAgpxMOdZwsbq5zzNeLwdplem3n3i3J79+A189xNRLQjSluCPs9RjNd7Bch3zb3
         u2APYGEtMc5E/1K/qqRU5w/2kSwQOIlkd0nyjf0QcqoIcF4SprXVsAiFpGmlu1k/vsDv
         QVTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nNAXKBtGSeRWoeTA7vve2sl147mbg/EYPDhDH8dLOgc=;
        b=7QUlxycQ1i4SigcOUNV/CfbNbzeLJj+rSoIIEOURHTZWroiyi/9VWR9p0oMQ58UNeL
         bPNsTMbzzrTXkLx/GMLq7+KRQoQZ/TWu1UjrbulexIOa5b2IfAKS8rPKkAA/PNz7gQsW
         kispVjCEmHIXIemNaZHldtFyanC+Ru4xnaA/eKkkDnRnGub0Oq59yEGbrm4vYZKwXaUH
         Enltj+OlA94fbYr3RlYVpk7SsBYpm6u2lZaJcthkA8L4llVP+puJyK1FdM5FVEhZLlYF
         VydITSh6/iL2I/1BDFvh+hrzmEZdR4/G5nBuphzHMniwgoeQO9cwaa0iYmUR/fr2QSQI
         YviA==
X-Gm-Message-State: ANoB5pmJryEowNmsfk72Z5IujBeNxmr3JmlEscTczXNpZam3qGe30HSW
        TgXQ03V9MqQxMRJ59vXQ3vU=
X-Google-Smtp-Source: AA0mqf7IepfQFcb3diG+BAtuWDc5M//Q/p7NePZuD734IrU4330b95+BMtbtDyD6306P2XTryefO6w==
X-Received: by 2002:a05:6512:3e2a:b0:4ab:534b:1b2c with SMTP id i42-20020a0565123e2a00b004ab534b1b2cmr443337lfv.426.1668671001885;
        Wed, 16 Nov 2022 23:43:21 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id w8-20020a2e9bc8000000b0026e00df2ed0sm53607ljj.30.2022.11.16.23.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 23:43:21 -0800 (PST)
Date:   Thu, 17 Nov 2022 10:43:18 +0300
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
Message-ID: <20221117074318.cd52h5ks7ay4j4wb@mobilestation>
References: <20221113191301.5526-1-Sergey.Semin@baikalelectronics.ru>
 <20221113191301.5526-2-Sergey.Semin@baikalelectronics.ru>
 <20221116203812.GA834519-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116203812.GA834519-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 16, 2022 at 02:38:12PM -0600, Rob Herring wrote:
> On Sun, Nov 13, 2022 at 10:12:42PM +0300, Serge Semin wrote:
> > Originally as it was defined the legacy bindings the pcie_inbound_axi and
> > pcie_aux clock names were supposed to be used in the fsl,imx6sx-pcie and
> > fsl,imx8mq-pcie devices respectively. But the bindings conversion has been
> > incorrectly so now the fourth clock name is defined as "pcie_inbound_axi
> > for imx6sx-pcie, pcie_aux for imx8mq-pcie", which is completely wrong.
> > Let's fix that by conditionally apply the clock-names constraints based on
> > the compatible string content.
> > 
> > Fixes: 751ca492f131 ("dt-bindings: PCI: imx6: convert the imx pcie controller to dtschema")
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > Acked-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > 
> > ---
> > 
> > Changelog v5:
> > - This is a new patch added on the v5 release of the patchset.
> > 
> > Changelog v7:
> > - Move the allOf clause to the bottom of the bindings. (@Krzysztof)
> > - Get back the names to the clock-names property and make sure the
> >   platform-specific name constraint is applied in the allOf clause.
> >   (@Rob)
> > ---
> >  .../bindings/pci/fsl,imx6q-pcie.yaml          | 46 +++++++++++++++++--
> >  1 file changed, 42 insertions(+), 4 deletions(-)
> 
> We have 2 patches doing the same thing:
> 
> https://lore.kernel.org/all/20221109002449.35936-1-marex@denx.de/

It seems to me that that patch does two things at a time:
1. Fixes invalid fourth clock-names entry.
2. Fixes the fsl,imx8mm-pcie device having the "pcie_aux" clock name
required instead of "pcie_phy".

My patch does only the first part. What about moving my patch to that
series and converting the Marek' patch to being applicable on top of
it and fixing the imx8mm part only? That seems reasonable.

-Sergey

> 
> Please hash out which one you all want. Both seem to have clock 
> warnings still...
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
