Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5536D29A35
	for <lists+linux-pci@lfdr.de>; Fri, 24 May 2019 16:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404134AbfEXOqP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 May 2019 10:46:15 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:1840 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403997AbfEXOqP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 May 2019 10:46:15 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ce803af0000>; Fri, 24 May 2019 07:46:07 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 24 May 2019 07:46:12 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 24 May 2019 07:46:12 -0700
Received: from [10.25.75.99] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 24 May
 2019 14:46:07 +0000
Subject: Re: [PATCH V7 04/15] PCI: dwc: Move config space capability search
 API
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <lorenzo.pieralisi@arm.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <kishon@ti.com>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, <jingoohan1@gmail.com>,
        <gustavo.pimentel@synopsys.com>, <mperttunen@nvidia.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20190517123846.3708-1-vidyas@nvidia.com>
 <20190517123846.3708-5-vidyas@nvidia.com> <20190521211757.GF57618@google.com>
 <fd164d1f-cf99-fe81-c368-46e3a3742a59@nvidia.com>
 <20190522140235.GB79339@google.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <fcd437d6-1bf8-9247-9453-d7769f430cb7@nvidia.com>
Date:   Fri, 24 May 2019 20:16:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190522140235.GB79339@google.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1558709167; bh=7gQdgrdEH6mUJp+DZg0whOMryAQmbUGCSVJvsmfrn80=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=AP800U3TqwiZEhIKSf/MMHAE4tT2L+6Lh7TylCmBvdpziSNQtgwc19+kqyKzl+u+W
         IPy/3sFkQudDemRovVMMRvH5Nn8lgEXzzEiw+KpMSbuscFaCwIdxflr3itSzYWZFAd
         SrbjnQ+sLMjgp9VzleeJP/acStCIHmDfAw9veb0vP6gguPwnWOk875gtaaKLhbqRBz
         FZu/2cYtLpZJ1pG5Fvd9XdPGMcnSX9YN/eAW+uSRYMy+3j4qHBu7zFmgUqcpZy0oNF
         yZ6PoK4DEgRIJD7HATD1aLF8usXnZug1p0JLy/wpGiax65BrMk2aBwAb2qMZrwyEe5
         UB0KhBxh3UaJA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5/22/2019 7:32 PM, Bjorn Helgaas wrote:
> On Wed, May 22, 2019 at 02:26:08PM +0530, Vidya Sagar wrote:
>> On 5/22/2019 2:47 AM, Bjorn Helgaas wrote:
>>> On Fri, May 17, 2019 at 06:08:35PM +0530, Vidya Sagar wrote:
>>>> Move PCIe config space capability search API to common DesignWare file
>>>> as this can be used by both host and ep mode codes.
> 
>>>>    .../pci/controller/dwc/pcie-designware-ep.c   | 37 +----------------
>>>>    drivers/pci/controller/dwc/pcie-designware.c  | 40 +++++++++++++++++++
>>>>    drivers/pci/controller/dwc/pcie-designware.h  |  2 +
>>>>    3 files changed, 44 insertions(+), 35 deletions(-)
> 
>>>> --- a/drivers/pci/controller/dwc/pcie-designware.c
>>>> +++ b/drivers/pci/controller/dwc/pcie-designware.c
>>>> @@ -14,6 +14,46 @@
>>>>    #include "pcie-designware.h"
>>>> +/*
>>>> + * These APIs are different from standard pci_find_*capability() APIs in the
>>>> + * sense that former can only be used post device enumeration as they require
>>>> + * 'struct pci_dev *' pointer whereas these APIs require 'struct dw_pcie *'
>>>> + * pointer and can be used before link up also.
>>>
>>> I think this comment is slightly misleading because it suggests the
>>> reason we need these DW interfaces is because we're doing something
>>> before a pci_dev pointer is available.
>>>
>>> But these DW interfaces are used on devices that will *never* have a
>>> pci_dev pointer because they are not PCI devices.  They're used on
>>> host controller devices, which have a PCIe link on the downstream
>>> side, but the host controller driver operates them using their
>>> upstream, non-PCI interfaces.  Logically, I think they would be
>>> considered parts of Root Complexes, not Root Ports.
>>>
>>> There's actually no reason why that upstream interface should look
>>> anything like PCI; it doesn't need to organize registers into
>>> capability lists at all.  It might be convenient for the hardware to
>>> do that and share things with a Root Port device, which *is* a PCI
>>> device, but it's not required.
>>>
>>> It also really has nothing to do with whether the link is up.  This
>>> code operates on hardware that is upstream from the link, so we can
>>> reach it regardless of the link.
>>
>> I added this comment after receiving a review comment to justify why
>> standard pci_find_*capability() APIs can't be used here. Hence added
>> this.  I understand your comment that DW interface need not have to
>> be a PCI device, but what is present in the hardware is effectively
>> a root port implementation and post enumeration, we get a 'struct
>> pci_dev' created for it, hence I thought it is fine to bring 'struct
>> pci_dev' into picture.
> 
> This code operates on the host controller.  It configures the bridge
> that leads *to* PCI devices.  Since that bridge is not a PCI device,
> the PCI specs don't say anything about how to program it.
> 
> The fact that the host controller programming interface happens to
> resemble the PCI programming interface is purely coincidental.
> 
>> Also, I agree that mention of 'link up' is unwarranted and could be
>> reworded in a better way.
>>
>> Do you suggest to remove this comment altogether or reword it s/and
>> can be used before link up also/and can be used before 'struct
>> pci_dev' is available/ ?
> 
> Maybe something like this?
> 
>      These interfaces resemble the pci_find_*capability() interfaces,
>      but these are for configuring host controllers, which are bridges
>      *to* PCI devices but are not PCI devices themselves.
Ok. Done.

> 

