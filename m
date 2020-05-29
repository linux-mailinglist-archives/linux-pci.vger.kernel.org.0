Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 159871E7B0F
	for <lists+linux-pci@lfdr.de>; Fri, 29 May 2020 12:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725833AbgE2K6k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 May 2020 06:58:40 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:19845 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgE2K6j (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 May 2020 06:58:39 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ed0ea830000>; Fri, 29 May 2020 03:57:07 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 29 May 2020 03:58:38 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 29 May 2020 03:58:38 -0700
Received: from [10.25.76.239] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 29 May
 2020 10:58:28 +0000
Subject: Re: [PATCH] PCI: tegra: fix runtime pm imbalance on error
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        Dinghao Liu <dinghao.liu@zju.edu.cn>, <kjlu@umn.edu>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200520163739.GA1100601@bjorn-Precision-5520>
 <e7c967a0-c285-450a-bbad-f6456c661d41@nvidia.com>
 <20200529102317.GA12270@e121166-lin.cambridge.arm.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <74c911ac-95ab-d2a0-8604-1ef19c2f997d@nvidia.com>
Date:   Fri, 29 May 2020 16:28:23 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200529102317.GA12270@e121166-lin.cambridge.arm.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1590749827; bh=06/Fdr3bA+ciLNMseJ/kn2hvnWdtUgAwTL8Ebufl9cc=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=HEnxrdPaTamFwHVwP3lcJImL81/SCDFEZkJuQc5KwaxVLRLmvWOEP351hf9uYUYGJ
         FxwSBmNrfIAzLYGFbDJT5OY9gPtBxbkJyjCnVBW+S4HT+Cw8+mKmlr/p8ReSOtrIm9
         g/BxOqEHeNyosTal4A9G3kN20WAE3xigboj76gQXb8rT6x2CqIJhHhdeedqYWeFh+z
         vrza/JEBnhtiQQeq7C/fMvcogEvwtpUNpTi1tHWWtNwjT8NRsvR3cRa2aTFDXKOku3
         Iqh+VT++jpyYnJP+D++u8eh+IZN/o//C4jY6vCAcQbfgjnZcLOG6o1ufzZdP0qQxCv
         lAmu3X47o+AMg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 29-May-20 3:53 PM, Lorenzo Pieralisi wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Wed, May 20, 2020 at 11:39:08PM +0530, Vidya Sagar wrote:
>> Thanks for pushing a patch to fix it. I've been under the wrong assumption
>> that a failing pm_runtime_get_sync() wouldn't increment the usage counter.
>> With Thierry's and Bjorn's comments addressed
>>
>> Acked-by: Vidya Sagar <vidyas@nvidia.com>
> 
> Thierry, Vidya,
> 
> are your ACKs applying also to:
> 
> https://patchwork.kernel.org/patch/11562109/
I just took a look at this change and it looks good to me.
So, I'm fine with extending my 'Acked-by' to this patch as well.

Thanks,
Vidya Sagar
> 
> Dinghao did not carry them over and I could not understand from this
> thread if your ACKs apply to both tegra and tegra194.
> 
> Thanks,
> Lorenzo
> 
>> On 20-May-20 10:07 PM, Bjorn Helgaas wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On Wed, May 20, 2020 at 11:59:08AM +0200, Thierry Reding wrote:
>>>> On Wed, May 20, 2020 at 04:52:23PM +0800, Dinghao Liu wrote:
>>>>> pm_runtime_get_sync() increments the runtime PM usage counter even
>>>>> it returns an error code. Thus a pairing decrement is needed on
>>>>
>>>> s/even it/even when it/
>>>>
>>>> Might also be a good idea to use a different subject prefix because I
>>>> was almost not going to look at the other patch, taking this to be a
>>>> replacement for it.
>>>
>>> Amen.  This would be a good change to start using "PCI: tegra194" or
>>> something for pcie-tegra194.c.  Or will there be tegra195, tegra 196,
>>> etc added to this driver?
>>>
>>> Also, please capitalize the first word and "PM" in the subjects:
>>>
>>>     PCI: tegra194: Fix runtime PM imbalance on error
>>>
>>> Bjorn
>>>
