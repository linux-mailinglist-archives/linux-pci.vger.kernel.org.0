Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C52995A798E
	for <lists+linux-pci@lfdr.de>; Wed, 31 Aug 2022 10:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbiHaIz6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 Aug 2022 04:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbiHaIzi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 Aug 2022 04:55:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 86A921F2C5;
        Wed, 31 Aug 2022 01:54:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 013B1ED1;
        Wed, 31 Aug 2022 01:54:30 -0700 (PDT)
Received: from [10.57.15.237] (unknown [10.57.15.237])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A32D3F71A;
        Wed, 31 Aug 2022 01:54:20 -0700 (PDT)
Message-ID: <98179709-1ece-61ab-d43a-fc38a4fd3f67@arm.com>
Date:   Wed, 31 Aug 2022 09:54:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v5 20/20] PCI: dwc: Add Baikal-T1 PCIe controller support
Content-Language: en-GB
From:   Robin Murphy <robin.murphy@arm.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, willmcvicker@google.com
References: <20220822184701.25246-1-Sergey.Semin@baikalelectronics.ru>
 <20220822184701.25246-21-Sergey.Semin@baikalelectronics.ru>
 <YwzbARMkb/69+l2d@lpieralisi> <63a54a1b-66ba-9739-8217-13f75e602cd5@arm.com>
In-Reply-To: <63a54a1b-66ba-9739-8217-13f75e602cd5@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022-08-31 09:36, Robin Murphy wrote:
> On 2022-08-29 16:28, Lorenzo Pieralisi wrote:
> [...]
>>> +static int bt1_pcie_add_port(struct bt1_pcie *btpci)
>>> +{
>>> +    struct device *dev = &btpci->pdev->dev;
>>> +    int ret;
>>> +
>>> +    /*
>>> +     * DW PCIe Root Port controller is equipped with eDMA capable of
>>> +     * working with the 64-bit memory addresses.
>>> +     */
>>> +    ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
>>> +    if (ret)
>>> +        return ret;
>>
>> Is this the right place to set the DMA mask for the host controller
>> embedded DMA controller (actually, the dev pointer is the _host_
>> controller device) ?
>>
>> How this is going to play when combined with:
>>
>> https://lore.kernel.org/linux-pci/1e63a581-14ae-b4b5-a5bf-ca8f09c33af6@arm.com
>>
>> It is getting a bit confusing. I believe the code in the link
>> above sets the mask so that through the DMA API we are capable
>> of getting an MSI doorbell virtual address whose physical address
>> can be addressed by the endpoint; this through the DMA API.
>>
>> This patch is setting the DMA mask for a different reason, namely
>> setting the host controller embedded DMA controller addressing
>> capabilities.
>>
>> AFAICS - both approaches set the mask for the same device - now
>> the question is about which one is legitimate and how to handle
>> the other.
> 
> Assuming the dw-edma-pcie driver is the relevant one, that already sets 
> its own masks on its own device, so I also don't see why this is here.

Ah, I just found the patch at [1], which further implies that this is 
indeed completely bogus.

Robin.

[1] 
https://lore.kernel.org/dmaengine/20220822185332.26149-23-Sergey.Semin@baikalelectronics.ru/
