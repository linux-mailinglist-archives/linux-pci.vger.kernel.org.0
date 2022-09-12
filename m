Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919125B5235
	for <lists+linux-pci@lfdr.de>; Mon, 12 Sep 2022 02:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbiILAWP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 11 Sep 2022 20:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiILAWO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 11 Sep 2022 20:22:14 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49DC22B20;
        Sun, 11 Sep 2022 17:22:13 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id v6so8783510ljj.0;
        Sun, 11 Sep 2022 17:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=BbROKlvKimTCtG7eh9QR0zDMaCcYsycCWwuHqVXEhpo=;
        b=gUt4CA6eiysKtaPKwbqc9r5kTRqhKZriS4gyvsrPGnx1Kfea2DK/gy/sV+y6w2Ujfs
         ifbZzNu7aGhFAnE/U2Aw8q4fDHfqlMbfWomx5vPaKz3sm5ltwluiowUskyjFYvWeO8ms
         ZMCwkHVA1J2kiX3r9bcy6joG9xpgDVwbL3jB9tuTSw4cExIlfBUTFFpzBYU5A/fK9D68
         I3OGNMBknIr0TMmxbwFZ/Dq2WJWTiOLLfYdi/HAsIlOMsuqLfmpuIARWSaXlnsVuHj+6
         p5d46AsfMqXKsV0Aa93pHZrfx13jTzFpCKshYN9vVmrc11zLwbcGwYKjBTscaKQlFM9H
         GeLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=BbROKlvKimTCtG7eh9QR0zDMaCcYsycCWwuHqVXEhpo=;
        b=MgfXYUYv/XG+6OUwbkIsCiquy+sZjqMVdTLKY1N/8PgzDojxxC5jSSpdQU0qFTIxA+
         X2is/jGPqflgzUEcOogos41gJDymKsbM69dA6hj2z78reXjYFQ6SDiryC010DVXcBnsQ
         HEnziFqvCtOGBwAkGCzm/FZiQsgkdJqoUjVW+o98yAdMLlhksBU8hzOZW+F4uFLYky0A
         tMDWJdMhvGI4ECHprRMgERZwHEGlkNnZP6arPH4kHb9cq0q/cMQreftcSTPk+/c3kknY
         ShTYfwRUOPtDZrRa75iAUhEAQ0FO+ufbGbBMdyVKkn0kULG60xZpZmvb4FGYcTv9es3y
         TzrQ==
X-Gm-Message-State: ACgBeo2j937uoTxsUPEaRkOzvGDTF+RZqomB4DjZ7dV2I1N+C8ZSIhI+
        Z2LFbqmjWYJgzjPo/M0OwQw=
X-Google-Smtp-Source: AA6agR40usYGJxqEMptpQ5msQ32sy21onQLzaBEYhwWCkj40zwkaLXIIL16zrucAUeRIoRRZz9LbTA==
X-Received: by 2002:a2e:9018:0:b0:26b:defc:2a19 with SMTP id h24-20020a2e9018000000b0026bdefc2a19mr4661377ljg.470.1662942132340;
        Sun, 11 Sep 2022 17:22:12 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id j3-20020ac253a3000000b0049485e2cb91sm766300lfh.231.2022.09.11.17.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 17:22:11 -0700 (PDT)
Date:   Mon, 12 Sep 2022 03:22:09 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, willmcvicker@google.com
Subject: Re: [PATCH v5 20/20] PCI: dwc: Add Baikal-T1 PCIe controller support
Message-ID: <20220912002209.uoaeiuh3dfkpnnnn@mobilestation>
References: <20220822184701.25246-1-Sergey.Semin@baikalelectronics.ru>
 <20220822184701.25246-21-Sergey.Semin@baikalelectronics.ru>
 <YwzbARMkb/69+l2d@lpieralisi>
 <63a54a1b-66ba-9739-8217-13f75e602cd5@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63a54a1b-66ba-9739-8217-13f75e602cd5@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 31, 2022 at 09:36:46AM +0100, Robin Murphy wrote:
> On 2022-08-29 16:28, Lorenzo Pieralisi wrote:
> [...]
> > > +static int bt1_pcie_add_port(struct bt1_pcie *btpci)
> > > +{
> > > +	struct device *dev = &btpci->pdev->dev;
> > > +	int ret;
> > > +
> > > +	/*
> > > +	 * DW PCIe Root Port controller is equipped with eDMA capable of
> > > +	 * working with the 64-bit memory addresses.
> > > +	 */
> > > +	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> > > +	if (ret)
> > > +		return ret;
> > 
> > Is this the right place to set the DMA mask for the host controller
> > embedded DMA controller (actually, the dev pointer is the _host_
> > controller device) ?
> > 
> > How this is going to play when combined with:
> > 
> > https://lore.kernel.org/linux-pci/1e63a581-14ae-b4b5-a5bf-ca8f09c33af6@arm.com
> > 
> > It is getting a bit confusing. I believe the code in the link
> > above sets the mask so that through the DMA API we are capable
> > of getting an MSI doorbell virtual address whose physical address
> > can be addressed by the endpoint; this through the DMA API.
> > 
> > This patch is setting the DMA mask for a different reason, namely
> > setting the host controller embedded DMA controller addressing
> > capabilities.
> > 
> > AFAICS - both approaches set the mask for the same device - now
> > the question is about which one is legitimate and how to handle
> > the other.
> 

> Assuming the dw-edma-pcie driver is the relevant one, that already sets its
> own masks on its own device, so I also don't see why this is here.

No. dw-edma-pcie has nothing to do with this driver.

-Sergey

> 
> Thanks,
> Robin.
