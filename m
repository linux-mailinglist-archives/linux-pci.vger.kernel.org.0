Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3CF5B5239
	for <lists+linux-pci@lfdr.de>; Mon, 12 Sep 2022 02:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiILAZ3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 11 Sep 2022 20:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiILAZ2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 11 Sep 2022 20:25:28 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D8923BF2;
        Sun, 11 Sep 2022 17:25:26 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id v6so8789224ljj.0;
        Sun, 11 Sep 2022 17:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=h8W2MnZNp3EZmLKRR3GWmvgYqI8g8ANtG+giDN21Mqk=;
        b=NNqmkuzUK6Nd6d3TWklj2yIflQbEKWrbIx+e8qxCgDx+ijBblJrZE8LbkSpQsjeBir
         dOeevbJGBE0HJoQuwEftKsr8b3ofSFhXNQIlrCvb/5t0ZpoL26n3Y1IMvMtNnvcs3VSj
         cJt0zVBGQuaFIrvgsBamWITds+4NK7XBgNikC7U0SjfSrMXUyc9Xrjg2RfLTQ1RhXd0+
         Ku1OnLVJNkf+Di8r4ArtlCVB8gfdz1b5D5Vh40UTuUAh3BEboB6IHzleoQooLLCTw5xO
         s7B1eWexM9w1jxota4iiMOovN43dHP3eDD29YImQ16CqSitnC2sasFQskhKZHcwbPk65
         QVZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=h8W2MnZNp3EZmLKRR3GWmvgYqI8g8ANtG+giDN21Mqk=;
        b=rg07l2baPFjr4yjT8ujIa3UXg+9C7CVgNSKtsOLj3ZGTZ1H3kgxOTT6SsrBaMw1FhG
         3G6oEeMOOTAb8/T1S6fc5bBBFfwIDrlyaJ4+12n8ylkCdaeP26ocmXe8oZj3gV5KdIch
         797tSeXPYsCqOQM7CgqCPNWOpxOltcHbTYAf3yBZjJL0V0JCP/cQ1CDXjfeN8HpPE2sm
         6Q04vh6+xadax12PP03QXCXwe97nEOzqQZOvFEVIozI4bxgdY8H8fI/L2bRzIqwASNJf
         ZlubARWb0gBMOZ+BmuZE8+/hKQBO/iwdgQwFOGwmHMqhOwoF9lAUljWKXtSsxVhdV9na
         sWEA==
X-Gm-Message-State: ACgBeo1OKpQAW8FnvWO4r0ffyioVzID15FJNw0o05DT/lJoj1FmBXCse
        IRm8mkFbd8pc3MbtswhjJ3o=
X-Google-Smtp-Source: AA6agR6fWGbuq1oQIOBjg+4w4n6JqgNzTcJXHVGsGnK7wvUl3teiIllyKwXeUlece/Rd3BsQ6U3+3w==
X-Received: by 2002:a05:651c:160c:b0:264:a5ae:7dd2 with SMTP id f12-20020a05651c160c00b00264a5ae7dd2mr7290892ljq.80.1662942324919;
        Sun, 11 Sep 2022 17:25:24 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id z28-20020a2eb53c000000b0025fe7f33bc4sm820357ljm.49.2022.09.11.17.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 17:25:24 -0700 (PDT)
Date:   Mon, 12 Sep 2022 03:25:22 +0300
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
Message-ID: <20220912002522.arx4vypiv363qcni@mobilestation>
References: <20220822184701.25246-1-Sergey.Semin@baikalelectronics.ru>
 <20220822184701.25246-21-Sergey.Semin@baikalelectronics.ru>
 <YwzbARMkb/69+l2d@lpieralisi>
 <63a54a1b-66ba-9739-8217-13f75e602cd5@arm.com>
 <98179709-1ece-61ab-d43a-fc38a4fd3f67@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98179709-1ece-61ab-d43a-fc38a4fd3f67@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 31, 2022 at 09:54:14AM +0100, Robin Murphy wrote:
> On 2022-08-31 09:36, Robin Murphy wrote:
> > On 2022-08-29 16:28, Lorenzo Pieralisi wrote:
> > [...]
> > > > +static int bt1_pcie_add_port(struct bt1_pcie *btpci)
> > > > +{
> > > > +    struct device *dev = &btpci->pdev->dev;
> > > > +    int ret;
> > > > +
> > > > +    /*
> > > > +     * DW PCIe Root Port controller is equipped with eDMA capable of
> > > > +     * working with the 64-bit memory addresses.
> > > > +     */
> > > > +    ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> > > > +    if (ret)
> > > > +        return ret;
> > > 
> > > Is this the right place to set the DMA mask for the host controller
> > > embedded DMA controller (actually, the dev pointer is the _host_
> > > controller device) ?
> > > 
> > > How this is going to play when combined with:
> > > 
> > > https://lore.kernel.org/linux-pci/1e63a581-14ae-b4b5-a5bf-ca8f09c33af6@arm.com
> > > 
> > > It is getting a bit confusing. I believe the code in the link
> > > above sets the mask so that through the DMA API we are capable
> > > of getting an MSI doorbell virtual address whose physical address
> > > can be addressed by the endpoint; this through the DMA API.
> > > 
> > > This patch is setting the DMA mask for a different reason, namely
> > > setting the host controller embedded DMA controller addressing
> > > capabilities.
> > > 
> > > AFAICS - both approaches set the mask for the same device - now
> > > the question is about which one is legitimate and how to handle
> > > the other.
> > 
> > Assuming the dw-edma-pcie driver is the relevant one, that already sets
> > its own masks on its own device, so I also don't see why this is here.
> 

> Ah, I just found the patch at [1], which further implies that this is indeed
> completely bogus.

Really? Elaborate please. What you said in the comment to that patch
has nothing to do with the change you comment here.

-Sergey

> 
> Robin.
> 
> [1] https://lore.kernel.org/dmaengine/20220822185332.26149-23-Sergey.Semin@baikalelectronics.ru/
