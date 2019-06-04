Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77FCE345BA
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2019 13:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfFDLnL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jun 2019 07:43:11 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:2792 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727249AbfFDLnK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jun 2019 07:43:10 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cf6594c0000>; Tue, 04 Jun 2019 04:43:08 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 04 Jun 2019 04:43:08 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 04 Jun 2019 04:43:08 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 4 Jun
 2019 11:43:08 +0000
Received: from [10.24.216.245] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 4 Jun 2019
 11:43:06 +0000
Subject: Re: [PATCH 2/2] PCI: Create device link for NVIDIA GPU
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Lukas Wunner <lukas@wunner.de>,
        <linux-pci@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <20190531050109.16211-1-abhsahu@nvidia.com>
 <20190531050109.16211-3-abhsahu@nvidia.com>
 <20190531203908.GA58810@google.com>
 <d0824334-99f2-d42e-3a5e-3bdc4c1c37c8@nvidia.com>
 <20190603172246.GC189360@google.com>
From:   Abhishek Sahu <abhsahu@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <4b4876eb-b3a0-6796-9d7a-af518a396689@nvidia.com>
Date:   Tue, 4 Jun 2019 17:13:03 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190603172246.GC189360@google.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1559648588; bh=6bS/IO5bk7Trmz3av9AdQK8DCTTtSrwKry5+scglc1k=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=qN3fENpIcYGhVNEXzRi76oHABsVUm8dOBkVtveqTV6gwvUJfPc0JD7CcHoDoasDgc
         RR4OF3BILpkhwZJSEq3huwKmMKuho1iPca7DBgbyzh6na+5oSKde5oK/nYGIR8lDVT
         AAv5OdsBIywfrvzRcPX3+EOx2r1b9BAWRouxnD5RRVZbi9bApCgcqFqoiSplpT5j8a
         4JtM0FB6RoM+E9COTHrkREqkcxZqZcDuBm/yhqjRUGcRCGk21JVwD8Kfxx159JePOB
         IGXnCnIYiZVCYlP0NWWGZVum/KxcpsXzRFCn/rFPw/z7hDs3nBoHjR8vK6Cx812ATR
         XLOaGaRKc4Y6w==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6/3/2019 10:52 PM, Bjorn Helgaas wrote:
> [+cc Rafael, just FYI]
> 
> On Mon, Jun 03, 2019 at 01:30:51PM +0530, Abhishek Sahu wrote:
>> On 6/1/2019 2:09 AM, Bjorn Helgaas wrote:
>>> On Fri, May 31, 2019 at 10:31:09AM +0530, Abhishek Sahu wrote:
>>>> NVIDIA Turing GPUs include hardware support for USB Type-C and
>>>> VirtualLink. It helps in delivering the power, display, and data
>>>> required to power VR headsets through a single USB Type-C connector.
>>>> The Turing GPU is a multi-function PCI device has the following
>>>> four functions:
>>>>
>>>> 	- VGA display controller (Function 0)
>>>> 	- Audio controller (Function 1)
>>>> 	- USB xHCI Host controller (Function 2)
>>>> 	- USB Type-C USCI controller (Function 3)
>>>>
>>>> The function 0 is tightly coupled with other functions in the
>>>> hardware. When function 0 goes in runtime suspended state,
>>>> then it will do power gating for most of the hardware blocks.
>>>> Some of these hardware blocks are used by other functions which
>>>> leads to functional failure. So if any of these functions (1/2/3)
>>>> are active, then function 0 should also be in active state.
>>>
>>>> 'commit 07f4f97d7b4b ("vga_switcheroo: Use device link for
>>>> HDA controller")' creates the device link from function 1 to
>>>> function 0. A similar kind of device link needs to be created
>>>> between function 0 and functions 2 and 3 for NVIDIA Turing GPU.
>>>
>>> I can't point to language that addresses this, but this sounds like a
>>> case of the GPU not conforming to the PCI spec.  The general
>>> assumption is that the OS should be able to discover everything it
>>> needs to do power management directly from the architected PCI config
>>> space.
>>
>>  The GPU is following PCIe spec but following is the implementation
>>  from HW side
> 
> Unless you can find spec language that talks about D-state
> dependencies between functions, I claim this is not following the
> PCIe spec.  For example, PCIe r5.0, sec 1.4, says "the PCI/PCIe
> hardware/software model includes architectural constructs necessary to
> discover, configure, and use a Function, without needing Function-
> specific knowledge." Sec 5.1 says "D states are associated with a
> particular Function" and "PM provides ... a mechanism to identify
> power management capabilities of a given Function [and] the ability to
> transition a Function into a certain power management state."
> 

 Thanks Bjorn. Here in case of GPU's these functions are not
 completely independent so it is not following PCIe spec in
 that aspect.

> If there *is* something about dependencies between functions in the
> spec, we should improve the generic PCI core to pay attention to that,
> and then we wouldn't need this quirk.
> 
> If the spec doesn't provide a way to discover them, these dependencies
> are exceptions from the spec, and we have to handle them as hardware
> defects, using quirks like this.  That's fine, but let's not pretend
> that this is a conforming device and that adding quirks is the
> expected process.  Just call a spade a spade and say we're working
> around a defect in this particular device.
> 

 Yes. I am agree with that we need to be very careful in
 adding quirks like this. I will communicate the same to
 HW team so they can explore other options to handle this
 in HW design side for future chips.

> I think the best path forward would be to add this quirk for the
> existing device, and then pursue a spec change to add something like
> a new PCIe capability to describe the dependencies.  Then we could
> enhance the PCI core once and power management for future devices
> would "Just Work" without having to add quirks.
> 

 Yes. It will be long term process. If other HW has similar
 requirement then it would be good to have this.

 Regards,
 Abhishek

