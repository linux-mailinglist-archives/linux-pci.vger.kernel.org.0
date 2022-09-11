Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03335B50C7
	for <lists+linux-pci@lfdr.de>; Sun, 11 Sep 2022 21:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiIKTJY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 11 Sep 2022 15:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiIKTJX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 11 Sep 2022 15:09:23 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A0F1F615;
        Sun, 11 Sep 2022 12:09:22 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id a14so6098849ljj.8;
        Sun, 11 Sep 2022 12:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=tCTaMrborU0W8DBPmUqi2wECvse4LZM0hNK6zHRPblk=;
        b=CQOG14kLShfz067g8CLXUqGTlYcBnrmTafneZhZRjF2M/dyQkoyardlfBdPjguD/2z
         NL+h0t1dDpd/yFZsT/Xq5JnnnnJdgBJ7I0+JvNtbJsOJbG/B55EM+FyfeRL7BZ5Lu3Yk
         E8PPiLDrfUZ0IvfUQRBdy1vhAMUTpTVVcRS/axT57tcF1SXjSSCqOs+4W86pZrqbDrGs
         e7BshBNz8kNV6FY0SivQ4al94xoofoQTguU8B1QsoWjOz1EddLS6zFMB1GXmJbTVL60l
         ZkZYCCahkdQO/FzXWpRZRtnboYAkCGwJOJgDEPUrI/rjliXrYmEo/khE5dld112B+QdF
         fiVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=tCTaMrborU0W8DBPmUqi2wECvse4LZM0hNK6zHRPblk=;
        b=57rLsxkkWP8/BRfbtNSVeYWsapWfNk4JYBtp5wZrBywrKYBOwKysDHfPEoq1UKbNvT
         zul1Hao6KZ9Vx04f67MnroiKx/6CRk4NHE6ISRYLrqZeEzNNf4JlZagvvvosda042BZb
         TfmIl2AGTnDOnOEv4znqieT2v7ij/fPOfcyTPFRsL8ZYCnjb4gr59b8obSaUYnFNZq4+
         8PgEcWezSYZR6RS8g5oTb2Ku1M0ZoyLK10m6tjth4pX3QOCFeR4M/JPdtG5RANabevwW
         piF9HMzuVW8ai0lEZGSTZjHZ82mzXF102ubePzL1q0KwJJiSSPyrMXmWkbEfuIAyVPSk
         l6ew==
X-Gm-Message-State: ACgBeo3cdmKKmJXmtB1hEtjY17dzM0iSlQFsfw7+zZotdzCAt8KCci9z
        BBVtxS5E4m5ru2FJTwOPfT0=
X-Google-Smtp-Source: AA6agR6aFTDeIPxByx6Mn+MttrU/7Yrh3SmMHHG0l9rhKcA/COwzC2Q90BLB8vsDYVUwm2G+6umORA==
X-Received: by 2002:a2e:9c1a:0:b0:26b:2bf7:9154 with SMTP id s26-20020a2e9c1a000000b0026b2bf79154mr5398729lji.417.1662923361212;
        Sun, 11 Sep 2022 12:09:21 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id s9-20020a05651c048900b0026aca137046sm737794ljc.120.2022.09.11.12.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 12:09:20 -0700 (PDT)
Date:   Sun, 11 Sep 2022 22:09:18 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v5 13/20] dt-bindings: PCI: dwc: Apply common schema to
 Rockchip DW PCIe nodes
Message-ID: <20220911190918.foo2ccfmo4fhyyac@mobilestation>
References: <20220822184701.25246-1-Sergey.Semin@baikalelectronics.ru>
 <20220822184701.25246-14-Sergey.Semin@baikalelectronics.ru>
 <20220831212631.GA277851-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831212631.GA277851-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 31, 2022 at 04:26:31PM -0500, Rob Herring wrote:
> On Mon, Aug 22, 2022 at 09:46:54PM +0300, Serge Semin wrote:
> > As the DT-bindings description states the Rockchip PCIe controller is
> > based on the DW PCIe RP IP-core thus its DT-nodes are supposed to be
> > compatible with the common DW PCIe controller schema. Let's make sure they
> > are evaluated against it by referring to the snps,dw-pcie.yaml schema in
> > the allOf sub-schemas composition.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > 
> > ---
> > 
> > Changelog v3:
> > - This is a new patch created on v3 lap of the series.
> > 
> > Changelog v5:
> > - Apply snps,dw-pcie.yaml instead of the snps,dw-pcie-common.yaml schema.
> > ---
> >  Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> 

> Shouldn't this come before/after patch 7?

It must be applied after the patch
[PATCH v5 11/20] dt-bindings: PCI: dwc: Add clocks/resets common properties
and after the rest of the resource-related patches submitted before
that one.

-Sergey

> 
> Reviewed-by: Rob Herring <robh@kernel.org>
