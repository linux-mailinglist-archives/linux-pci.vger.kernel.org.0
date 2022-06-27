Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F2655D4BC
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 15:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242622AbiF0Wbt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jun 2022 18:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242616AbiF0Wbr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Jun 2022 18:31:47 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5841F603;
        Mon, 27 Jun 2022 15:31:46 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id j21so19107194lfe.1;
        Mon, 27 Jun 2022 15:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ebUPv2y8CKJXtjGQGMNXRZnKdkcl00JDd47Ea+foYmc=;
        b=K6AMMbAMeQ0+NMpEomZFp6AbmHXEFoMmYYFCd0RU6AdSfWQxPR6hdaiBq190z5fNeZ
         sCkPerzqxyZHWsCYq+gM8iLSBAqHq0rHnV5KWJ4ISa1VumxngUWz4XsvQ1HTPNw7Q+AO
         7D7LlqiiHSulXyBT18mF8QjRi0uozC396gXB6JksX88HAzn6fq7U/avuT7PrqWFa6HYt
         ZCNr360StzxQdELNfprZkQJ3M0hPWFXbojGuCSh/jRsANiZSdxaRCfeaay3QwlGL67YK
         7BtRcG9iZct1DCzmofz7rE2CqxwDUovuCiQzKNJ2/S9lrTCtQT+0nC8uduCVWQobCPkX
         TtmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ebUPv2y8CKJXtjGQGMNXRZnKdkcl00JDd47Ea+foYmc=;
        b=5VTTG4kqQ8HnidXZ4Rkll0mslOn15YPr39KhliUg28ykAt9/SYvxz+ypxpaPNF66kR
         CeQnOIIYo4CRdnPUvI+QTMI9VtvVH19pNdDamLasAjwEkywrg5ibW1keVZuBQxCy/QzW
         p1PFWe/gQyyHAxzzjxp074ixXNg8ApKElr805vAHVXyvDVkNiH81Ae6kHVbyLvUPfKJV
         /wRFpoqob93zer0VhjX7a40OunWs+H6p2pRS+mKi5j2A12Wlz/ntwlCvwVCbXHaqvXLw
         UQ2X2LoeSWwLCJ7OggU9jJInAolthHTe6Bo3OLvXBFRepptgRLoyrw9Dry5q9oz7uFuE
         5bYQ==
X-Gm-Message-State: AJIora9s74i9kOHDjjSIUE1dft61fQUuwdy9zPaf5nAkBG/mYbuXmNHc
        JRasdcKSYhGpubeEG76r4ik=
X-Google-Smtp-Source: AGRyM1s7XDkWVNzlUNN4DZn+jHKm7XYpwR+3m/xsLRQtn9qkeFvGbQAXIsBTu7qObrs/crW128MTDA==
X-Received: by 2002:a05:6512:2629:b0:47d:b9cd:1d1d with SMTP id bt41-20020a056512262900b0047db9cd1d1dmr9590870lfb.82.1656369104462;
        Mon, 27 Jun 2022 15:31:44 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id z14-20020a056512376e00b0047f9dca3708sm1957298lft.51.2022.06.27.15.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 15:31:43 -0700 (PDT)
Date:   Tue, 28 Jun 2022 01:31:41 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH RESEND v4 07/15] PCI: tegra194: Drop manual DW PCIe
 controller version setup
Message-ID: <20220627223141.qzi4unrloj23v5jt@mobilestation>
References: <20220624143947.8991-1-Sergey.Semin@baikalelectronics.ru>
 <20220624143947.8991-8-Sergey.Semin@baikalelectronics.ru>
 <48b2c4c2-3032-a90b-07c1-f03b3a84df3a@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48b2c4c2-3032-a90b-07c1-f03b3a84df3a@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 27, 2022 at 01:29:33PM +0530, Vidya Sagar wrote:
> 
> 
> On 6/24/2022 8:09 PM, Serge Semin wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > Since the DW PCIe common code now supports the IP-core version
> > auto-detection there is no point in manually setting the version up for the
> > controllers newer than v4.70a. Seeing Tegra 194 PCIe Host and EP
> > controllers are based on the DW PCIe v4.90a IP-core we can freely drop the
> > dw_pcie.version field initialization.
> > 
> > Suggested-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > 
> > ---
> > 
> > Folks, I don't have Tegra 194 PCIe hw instance to test it out. Could you
> > please make sure this patch doesn't brake anything?
> 

> Hi,
> I tried to apply the series
> https://patchwork.kernel.org/project/linux-pci/list/?series=653624 on top of
> linux-next and ran into conflicts. Could you please tell me the minimum set
> of patches to be taken?

Hi.
As the cover letter says it is supposed to be applied on top of the
next series *:
https://lore.kernel.org/linux-pci/20220624143428.8334-1-Sergey.Semin@baikalelectronics.ru/
* Currently latest patchset version is v5.

Then - the resent series what you are referring to.

-Sergey

> 
> Thanks,
> Vidya Sagar
> 
> > 
> > Changelog v3:
> > - This is a new patch create as a result of the discussion:
> >    https://lore.kernel.org/linux-pci/20220503214638.1895-6-Sergey.Semin@baikalelectronics.ru/
> > ---
> >   drivers/pci/controller/dwc/pcie-tegra194.c | 1 -
> >   1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> > index f24b30b7454f..e497e6de8d15 100644
> > --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> > +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> > @@ -1979,7 +1979,6 @@ static int tegra194_pcie_probe(struct platform_device *pdev)
> >          pci->ops = &tegra_dw_pcie_ops;
> >          pci->n_fts[0] = N_FTS_VAL;
> >          pci->n_fts[1] = FTS_VAL;
> > -       pci->version = DW_PCIE_VER_490A;
> > 
> >          pp = &pci->pp;
> >          pp->num_vectors = MAX_MSI_IRQS;
> > --
> > 2.35.1
> > 
