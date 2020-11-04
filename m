Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C11E2A5EE7
	for <lists+linux-pci@lfdr.de>; Wed,  4 Nov 2020 08:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgKDHrP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Nov 2020 02:47:15 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:17978 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbgKDHrO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Nov 2020 02:47:14 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa25c810001>; Tue, 03 Nov 2020 23:47:13 -0800
Received: from [10.40.203.207] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 4 Nov
 2020 07:47:02 +0000
Subject: Re: [PATCH 0/3] Add support to handle prefetchable memory
To:     Thierry Reding <treding@nvidia.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
CC:     "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "amurray@thegoodpenguin.co.uk" <amurray@thegoodpenguin.co.uk>,
        "robh@kernel.org" <robh@kernel.org>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kthota@nvidia.com" <kthota@nvidia.com>,
        "mmaddireddy@nvidia.com" <mmaddireddy@nvidia.com>,
        "sagar.tv@gmail.com" <sagar.tv@gmail.com>
References: <20201023195655.11242-1-vidyas@nvidia.com>
 <SLXP216MB04777D651A59246A60D036A8AA1B0@SLXP216MB0477.KORP216.PROD.OUTLOOK.COM>
 <20201026123012.GA356750@ulmo>
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <53277a71-13e5-3e7e-7c51-aca367b99d31@nvidia.com>
Date:   Wed, 4 Nov 2020 13:16:57 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201026123012.GA356750@ulmo>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604476033; bh=QeSqa6GvM+bf3uNLQi9VSfzj1po5EbjFmVrkNpp/7gA=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=Ifr6JUnC5B0NMRMUvYd+/WhhZXKPkWuzhCfs3e+itFu4MJSEU5ixIMKMSxduPdom6
         iMu+6cSqqUssACAej8CuEl7tghcArGXURwtZSse9j4QNSAmOZRVtRyETY53B2FEpOQ
         1oNnf1vdPWfzD/wXf1A5v/oLDuWaXhrBFa4cIglsmUXLarT4rFHiVb4nY3fkG0GYun
         Odq3MJifchS403KcZ7QDrvv4qiwWn6dyitZ+ZG+e04Aqnh7PW2zT1hmFrMRSRJ0fq5
         +xv+TGOjqKmKIvJkY2LQfAHQ2OYZfA/PLiPsRV5I29acgF1PSRbeumhQ5gxDQbvFKu
         JWx8cuiOxBRWA==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Lorenzo / Bjorn,
Could you please review patches-1 & 2 in this series?
For the third patch, we already went with Rob's patch @ 
http://patchwork.ozlabs.org/project/linux-pci/patch/20201026154852.221483-1-robh@kernel.org/

Thanks,
Vidya Sagar

On 10/26/2020 6:02 PM, Thierry Reding wrote:
> On Sat, Oct 24, 2020 at 04:03:41AM +0000, Jingoo Han wrote:
>> On 10/23/20, 3:57 PM, Vidya Sagar wrote:
>>>
>>> This patch series adds support for configuring the DesignWare IP's ATU
>>> region for prefetchable memory translations.
>>> It first starts by flagging a warning if the size of non-prefetchable
>>> aperture goes beyond 32-bit as PCIe spec doesn't allow it.
>>> And then adds required support for programming the ATU to handle higher
>>> (i.e. >4GB) sizes and then finally adds support for differentiating
>>> between prefetchable and non-prefetchable regions and configuring one of
>>> the ATU regions for prefetchable memory translations purpose.
>>>
>>> Vidya Sagar (3):
>>>    PCI: of: Warn if non-prefetchable memory aperture size is > 32-bit
>>>    PCI: dwc: Add support to program ATU for >4GB memory aperture sizes
>>>    PCI: dwc: Add support to handle prefetchable memory mapping
>>
>> For 2nd & 3rd,
>> Acked-by: Jingoo <jingoohan1@gmail.com>
>> But, I still want someone to ack 1st patch, not me.
>>
>> To Vidya,
>> If possible, can you ask your coworker to give 'Tested-by'? It will be very helpful.
>> Thank you.
> 
> On next-20201026 (but also going back quite a while) I'm seeing this
> during boot on Jetson AGX Xavier (Tegra194):
> 
> [    3.493382] ahci 0001:01:00.0: version 3.0
> [    3.493889] ahci 0001:01:00.0: SSS flag set, parallel bus scan disabled
> [    4.497706] ahci 0001:01:00.0: controller reset failed (0xffffffff)
> [    4.498114] ahci: probe of 0001:01:00.0 failed with error -5
> 
> After applying this series, AHCI over PCI is back to normal:
> 
> [    3.543230] ahci 0001:01:00.0: AHCI 0001.0000 32 slots 1 ports 6 Gbps 0x1 impl SATA mode
> [    3.550841] ahci 0001:01:00.0: flags: 64bit ncq sntf led only pmp fbs pio slum part sxs
> [    3.559747] scsi host0: ahci
> [    3.561998] ata1: SATA max UDMA/133 abar m512@0x1230010000 port 0x1230010100 irq 63
> 
> So for the series:
> 
> Tested-by: Thierry Reding <treding@nvidia.com>
> 
