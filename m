Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04190690DA7
	for <lists+linux-pci@lfdr.de>; Thu,  9 Feb 2023 16:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbjBIPzA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Feb 2023 10:55:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbjBIPyy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Feb 2023 10:54:54 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0FBF31BAC0;
        Thu,  9 Feb 2023 07:54:52 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E5C6FEC;
        Thu,  9 Feb 2023 07:55:34 -0800 (PST)
Received: from [192.168.1.110] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 75D3D3F8C6;
        Thu,  9 Feb 2023 07:54:49 -0800 (PST)
Message-ID: <c0846f7f-2290-15b5-c51c-98da515d571f@arm.com>
Date:   Thu, 9 Feb 2023 15:54:35 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v6 0/2] PCI: dwc: Add support for 64-bit MSI target
 addresses
Content-Language: en-GB
To:     Evgenii Shatokhin <e.shatokhin@yadro.com>,
        Serge Semin <fancer.lancer@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        kernel-team@android.com, Vidya Sagar <vidyas@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux@yadro.com,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Will McVicker <willmcvicker@google.com>
References: <20220825235404.4132818-1-willmcvicker@google.com>
 <decae9e4-3446-2384-4fc5-4982b747ac03@yadro.com>
 <c014b074-6d7f-773b-533a-c0500e239ab8@arm.com>
 <46ba97c9-85ff-eb47-0d05-79dc3960d7b4@yadro.com>
 <20230203221216.c2s6ahm52ug5jtqv@mobilestation>
 <66b01fd7-7466-5d76-c384-0758ceadee8e@yadro.com>
 <20230209004837.n62af6wxgjj4kxt6@mobilestation>
 <7f59568a-eebe-95c8-4aea-c01dd726efa7@yadro.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <7f59568a-eebe-95c8-4aea-c01dd726efa7@yadro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2023-02-09 08:03, Evgenii Shatokhin wrote:
[...]
>> Currently the kernel PCIe subsystem doesn't provide a way to reserve a
>> range within the PCIe bus memory with no physical RAM behind and left
>> unused during the BARs resource initialization. Implementing such
>> functionality (perhaps in the framework of the P2P module or based on
>> it) would give the generic solution.
>>
>>>
>>> For now, we are probably better off with SoC-specific patches, when 
>>> we know
>>> which PCIe devices can possibly be used and what their restrictions are.
>>
>> Since you know that there is no any RAM below 4GB and you have
>> matching CPU and PCIe address spaces, then you can just take any
>> address below 4GB and use it to initialize the MSI-target address
>> (dw_pcie_rp.msi_data). But make sure that the peripheral PCIe-devices
>> don't use it for something application-specific (like accessing CPU
>> MMIO devices mapped to that base address). That seems like the most
>> universal solution for your case.
> 
> Interesting idea!
> Thank you, Sergey.

Yes, if the platform-specific driver knows enough to be able to pick a 
suitable "safe" MSI address, then I think allowing it to pre-set 
pp.msi_data, and only falling back to the dma-mapping workaround 
otherwise, sounds reasonable.

Thanks,
Robin.
