Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67FB65EA967
	for <lists+linux-pci@lfdr.de>; Mon, 26 Sep 2022 17:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235423AbiIZPBR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Sep 2022 11:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235412AbiIZPAj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Sep 2022 11:00:39 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD041A231;
        Mon, 26 Sep 2022 06:31:15 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id k10so10869228lfm.4;
        Mon, 26 Sep 2022 06:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=SI15L9xHCEWA851Opghsz+363OIT/vbIz5f6igSr7hc=;
        b=Ox3tbAhHG8fwzuFvqJo/QT5Rjh4Oa0Yrl3Epog6+kv8fGE+YJcBjPpIT8e/VoUpIQJ
         4jc0ODhZ0ILVm0BzM5txGR2rIaoG8KfbGh0hlIR3SwwLz8XeHJVy5OfWd5nmpOWvXq14
         JCb7vvjVvlzr+mbTS98jjaXCe+G7aavXt2PWRS3UgTUIXIq7IOdgWhfWI7OtGp/CQ4PW
         +bnbXAh6Ky09xWhKVPyaqIMA+W/t3fAY+ASaEzIhT/wH+1qgQX/UCnRcpWdxOPV70MYT
         UA9Hc14jGuYd9A0MHWxMcUq73PXIKOJ+Yq0xTBc19cLpJCZy/NL9YdycRqIFbjmxdonF
         YHvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=SI15L9xHCEWA851Opghsz+363OIT/vbIz5f6igSr7hc=;
        b=60cES9zcoToMoJPmDskSyS3J49ENYXHgAI/HaIBF9va5RZD2gH+fj4tc99AA9/A3ph
         NAqKqLFYEkPsrX+7NjRKyJO527MP72lQQ2h/c8kefzgUC7InewBlNn+0S6EQ0JUkqEv/
         sYBV1r3GqizLStOouIxuB5o1lBuCiw3mj0J+fNHYGtnntR9RDYJnmCx4bRuCos1oO9Vo
         0ubj0dEf3ZjhkMhtH18E+sHLBzX55OWJGms7io3zmCmiqGoUeh/MQ1LdH9nZk0rmKOr5
         1v3HzE1Er2NmRB5Sh2M3e0oaLbl/3+A/3sPRot5Ww2bQAgh0sYK7PP8LVCod0gukkk06
         OYeg==
X-Gm-Message-State: ACrzQf0xNlaHgy7XIbOeZiR0B0VHEO0zdFA4HqDmyr+WCnASnT7Q+Gr2
        4tHvce4fo6YeoDrve8hhR6w=
X-Google-Smtp-Source: AMsMyM5z3BYvpGdMxaAg/m5xzhu47iT9K8ItgKwo85yCHBugA9sLDlBGlI4tJjdpj+Xjx2ODwjUXnA==
X-Received: by 2002:a05:6512:1686:b0:491:3199:d407 with SMTP id bu6-20020a056512168600b004913199d407mr9079937lfb.476.1664199073672;
        Mon, 26 Sep 2022 06:31:13 -0700 (PDT)
Received: from mobilestation (ip1.ibrae.ac.ru. [91.238.191.1])
        by smtp.gmail.com with ESMTPSA id t1-20020ac24c01000000b0049b58c51773sm2528964lfq.193.2022.09.26.06.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 06:31:13 -0700 (PDT)
Date:   Mon, 26 Sep 2022 16:31:09 +0300
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
Message-ID: <20220926133109.q5a3qxnvtuovpe5o@mobilestation>
References: <20220822184701.25246-1-Sergey.Semin@baikalelectronics.ru>
 <20220822184701.25246-21-Sergey.Semin@baikalelectronics.ru>
 <YwzbARMkb/69+l2d@lpieralisi>
 <63a54a1b-66ba-9739-8217-13f75e602cd5@arm.com>
 <98179709-1ece-61ab-d43a-fc38a4fd3f67@arm.com>
 <20220912002522.arx4vypiv363qcni@mobilestation>
 <e8a4d4b0-f8ee-2aa7-de23-9afe21cc9915@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e8a4d4b0-f8ee-2aa7-de23-9afe21cc9915@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 26, 2022 at 02:09:59PM +0100, Robin Murphy wrote:
> On 2022-09-12 01:25, Serge Semin wrote:
> > On Wed, Aug 31, 2022 at 09:54:14AM +0100, Robin Murphy wrote:
> > > On 2022-08-31 09:36, Robin Murphy wrote:
> > > > On 2022-08-29 16:28, Lorenzo Pieralisi wrote:
> > > > [...]
> > > > > > +static int bt1_pcie_add_port(struct bt1_pcie *btpci)
> > > > > > +{
> > > > > > +��� struct device *dev = &btpci->pdev->dev;
> > > > > > +��� int ret;
> > > > > > +
> > > > > > +��� /*
> > > > > > +���� * DW PCIe Root Port controller is equipped with eDMA capable of
> > > > > > +���� * working with the 64-bit memory addresses.
> > > > > > +���� */
> > > > > > +��� ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> > > > > > +��� if (ret)
> > > > > > +������� return ret;
> > > > > 
> > > > > Is this the right place to set the DMA mask for the host controller
> > > > > embedded DMA controller (actually, the dev pointer is the _host_
> > > > > controller device) ?
> > > > > 
> > > > > How this is going to play when combined with:
> > > > > 
> > > > > https://lore.kernel.org/linux-pci/1e63a581-14ae-b4b5-a5bf-ca8f09c33af6@arm.com
> > > > > 
> > > > > It is getting a bit confusing. I believe the code in the link
> > > > > above sets the mask so that through the DMA API we are capable
> > > > > of getting an MSI doorbell virtual address whose physical address
> > > > > can be addressed by the endpoint; this through the DMA API.
> > > > > 
> > > > > This patch is setting the DMA mask for a different reason, namely
> > > > > setting the host controller embedded DMA controller addressing
> > > > > capabilities.
> > > > > 
> > > > > AFAICS - both approaches set the mask for the same device - now
> > > > > the question is about which one is legitimate and how to handle
> > > > > the other.
> > > > 
> > > > Assuming the dw-edma-pcie driver is the relevant one, that already sets
> > > > its own masks on its own device, so I also don't see why this is here.
> > > 
> > 
> > > Ah, I just found the patch at [1], which further implies that this is indeed
> > > completely bogus.
> > 
> > Really? Elaborate please. What you said in the comment to that patch
> > has nothing to do with the change you comment here.
> 

> It has everything to do with it; if the other driver did the right thing,
> this change wouldn't even be here.

What "right" thing do you imply? What the other driver should have done?

> Everything you've said has implied that
> the DMA engine driver cares about the AXI side of the bridge, which is
> represented by the platform device.

Both DW PCIe host controller and embedded eDMA drivers care about the
AXI-master-side of the device. The only driver which can be aware of
the interface config parameters is the platform driver. This patch
introduces a platform driver which sets the relevant DMA-mask.

> Thus it should set the platform device's
> DMA mask, and use the platform device for DMA API calls, and thus there
> should be no conflict with the host controller driver's use of the PCI
> device's DMA mask to reserve a DMA address in PCI memory space on the other
> side of the bridge, nor any translation across the bridge itself.

How do you expect the eDMA driver would detect the platform device
capability like DMAable memory range?

Note here we are talking about the DMAable memory ranges. Meanwhile
the eDMA-patch [1] you were commenting was necessary due to the
PCI-specific "dma-ranges" property setting. That's why I told you that
this and that parts are irrelevant.

[1] https://lore.kernel.org/dmaengine/20220822185332.26149-23-Sergey.Semin@baikalelectronics.ru/

-Sergey

> 
> Thanks,
> Robin.
