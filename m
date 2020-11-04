Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 720AE2A60E6
	for <lists+linux-pci@lfdr.de>; Wed,  4 Nov 2020 10:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbgKDJug (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Nov 2020 04:50:36 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:12108 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbgKDJug (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Nov 2020 04:50:36 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa2796a0004>; Wed, 04 Nov 2020 01:50:34 -0800
Received: from [10.26.45.122] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 4 Nov
 2020 09:50:28 +0000
Subject: Re: [PATCH 0/3] Add support to handle prefetchable memory
To:     Thierry Reding <treding@nvidia.com>,
        Jingoo Han <jingoohan1@gmail.com>
CC:     Vidya Sagar <vidyas@nvidia.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "amurray@thegoodpenguin.co.uk" <amurray@thegoodpenguin.co.uk>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kthota@nvidia.com" <kthota@nvidia.com>,
        "mmaddireddy@nvidia.com" <mmaddireddy@nvidia.com>,
        "sagar.tv@gmail.com" <sagar.tv@gmail.com>
References: <20201023195655.11242-1-vidyas@nvidia.com>
 <SLXP216MB04777D651A59246A60D036A8AA1B0@SLXP216MB0477.KORP216.PROD.OUTLOOK.COM>
 <20201026123012.GA356750@ulmo>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <f8f97e82-977f-6505-b4f9-c3948498ac5b@nvidia.com>
Date:   Wed, 4 Nov 2020 09:50:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201026123012.GA356750@ulmo>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604483434; bh=x0tsrQWHp+jRS8jI31fiEmMu3MtZ85XlMJrfLIuois4=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=sPRAHZSMFhbGefZd6xoA+fYxy/sXh0jELLoZLWHeQsnkGdV/i0os/CoVU7m5hm/Pz
         z5ytkNQWoi4pxPsQqNsLf2l/+C1Qltkkq6LI5l6M76UkB5UPdWt2M78DF+7JtXWN4n
         rF0JsuqgymBpgTr5Cnm0AoESerDHPkHdqfpV1xKod2kkLj2cYDSNxMikMONEkkiblP
         6/KJq+3XGnsxMU6Br6n162ZAmGlAg6JvV58hFmsttuYN0WI+Snh7z00b7F1Mqn0Xb7
         v8jNEl37rXqFmFSneeUEkOy6iFLY0cZD13k0dkqrsTiHAHHDB6CSKHfAh3vXGvzPnk
         Jg62H+qdzy3nw==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 26/10/2020 12:32, Thierry Reding wrote:
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
>>>   PCI: of: Warn if non-prefetchable memory aperture size is > 32-bit
>>>   PCI: dwc: Add support to program ATU for >4GB memory aperture sizes
>>>   PCI: dwc: Add support to handle prefetchable memory mapping
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

FWIW ...

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
