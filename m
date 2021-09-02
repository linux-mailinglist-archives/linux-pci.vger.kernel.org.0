Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4083FEE55
	for <lists+linux-pci@lfdr.de>; Thu,  2 Sep 2021 15:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344481AbhIBNIT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Sep 2021 09:08:19 -0400
Received: from foss.arm.com ([217.140.110.172]:49222 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234054AbhIBNIS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 Sep 2021 09:08:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6FBE51FB;
        Thu,  2 Sep 2021 06:07:19 -0700 (PDT)
Received: from [10.57.15.112] (unknown [10.57.15.112])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 41B0D3F5A1;
        Thu,  2 Sep 2021 06:07:17 -0700 (PDT)
Subject: Re: [PATCH v4] iommu/of: Fix pci_request_acs() before enumerating PCI
 devices
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Wang Xingang <wangxingang5@huawei.com>,
        Rob Herring <robh@kernel.org>, Will Deacon <will@kernel.org>,
        joro@8bytes.org, helgaas@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        iommu@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, xieyingtai@huawei.com,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
References: <1621566204-37456-1-git-send-email-wangxingang5@huawei.com>
 <CGME20210901085937eucas1p2d02da65cac797706ca3a10b8a2eb8ba2@eucas1p2.samsung.com>
 <01314d70-41e6-70f9-e496-84091948701a@samsung.com>
 <f3087045-1f0e-aa1a-d3f7-9e88bccca925@arm.com>
 <CADYN=9JWU3CMLzMEcD5MSQGnaLyDRSKc5SofBFHUax6YuTRaJA@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <25b0b214-b9b4-4066-3912-a5bcb054dc0d@arm.com>
Date:   Thu, 2 Sep 2021 14:07:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CADYN=9JWU3CMLzMEcD5MSQGnaLyDRSKc5SofBFHUax6YuTRaJA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021-09-02 13:51, Anders Roxell wrote:
> On Wed, 1 Sept 2021 at 11:58, Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 2021-09-01 09:59, Marek Szyprowski wrote:
>>> On 21.05.2021 05:03, Wang Xingang wrote:
>>>> From: Xingang Wang <wangxingang5@huawei.com>
>>>>
>>>> When booting with devicetree, the pci_request_acs() is called after the
>>>> enumeration and initialization of PCI devices, thus the ACS is not
>>>> enabled. And ACS should be enabled when IOMMU is detected for the
>>>> PCI host bridge, so add check for IOMMU before probe of PCI host and call
>>>> pci_request_acs() to make sure ACS will be enabled when enumerating PCI
>>>> devices.
>>>>
>>>> Fixes: 6bf6c24720d33 ("iommu/of: Request ACS from the PCI core when
>>>> configuring IOMMU linkage")
>>>> Signed-off-by: Xingang Wang <wangxingang5@huawei.com>
>>>
>>> This patch landed in linux-next as commit 57a4ab1584e6 ("iommu/of: Fix
>>> pci_request_acs() before enumerating PCI devices"). Sadly it breaks PCI
>>> operation on ARM Juno R1 board (arch/arm64/boot/dts/arm/juno-r1.dts). It
> 
> We've seen this on ARM Juno R2 boards too in the Linaro testfarm.
> 
> The problem is that the device can't get the "SATA link up" while booting.
> 
> see https://lkft.validation.linaro.org/scheduler/job/3416767#L577

Hmm, what's odd there is that you don't seem to be even detecting any of 
the endpoints there. Notably, the switch (which both the slots and the 
on-board endpoints are behind) *does* support ACS even though the Root 
Complex doesn't, so I wonder if it's getting enabled there and causing 
it to forward TLPs with ACS bits set which the RC doesn't like?

I'm far from a PCI expert, but I might try running this patch on my 
board to see if anything else stands out.

Robin.

> When reverting this patch we are able to see the "SATA link up".
> 
> Cheers,
> Anders
> 
