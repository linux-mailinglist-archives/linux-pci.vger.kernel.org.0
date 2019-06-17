Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11533480D6
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2019 13:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbfFQLeu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jun 2019 07:34:50 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:4018 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbfFQLeu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jun 2019 07:34:50 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d077ad90000>; Mon, 17 Jun 2019 04:34:49 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 17 Jun 2019 04:34:49 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 17 Jun 2019 04:34:49 -0700
Received: from [10.24.247.153] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 17 Jun
 2019 11:34:47 +0000
Subject: Re: [PATCH v2 0/2] PCI: device link quirk for NVIDIA GPU
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lukas@wunner.de>
References: <20190606092225.17960-1-abhsahu@nvidia.com>
 <20190613205720.GK13533@google.com>
X-Nvconfidentiality: public
From:   Abhishek Sahu <abhsahu@nvidia.com>
Message-ID: <ec2226e8-ccce-488f-20eb-0dd22dc9bed1@nvidia.com>
Date:   Mon, 17 Jun 2019 17:04:43 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190613205720.GK13533@google.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560771289; bh=Hk/6KBGqJg6eibtneR2WtGviyInDD/OJ7+WqSEyVYRc=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=bieRDgFeWAkiTRJzUdd4ELyDZRMADAoqyCE90ifyaN/QNX4qV7WRSuW+zpDQdVBpH
         iDhxm8A09dE/2J1ceOTaoQpvXVrwF9b8KIX9OQSN7NdpniNwOBVmtM3MNxtMrrCK4O
         oQ3ECSTaM9mN5k39Smjq3UQseOaBRSuhdP0EBn+FHWC4/TyRClbaZNBOAmXE/MjFG0
         qsUZvBKSbAlxX9eJwm+JXyHErDFO4ATEKM+ikjX1AV0JawFOjvzYNERL/phM31pmoX
         7a5buzhrPg9Hy2tdb1b7XBqTzu+nGBo4bvEebzUUjQrrEYP//SEKgX2Ky6hxv6PDyV
         G/3ysW/Dp1ghg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 6/14/2019 2:27 AM, Bjorn Helgaas wrote:
> On Thu, Jun 06, 2019 at 02:52:23PM +0530, Abhishek Sahu wrote:
>> * v2:
>>
>> 1. Make the pci device link helper function generic which can be
>>    used for other multi-function PCI devices also.
>> 2. Minor changes in comments and commit logs.
>>
>> * v1:
>>
>> NVIDIA Turing GPU [1] has hardware support for USB Type-C and
>> VirtualLink [2]. The Turing GPU is a multi-function PCI device
>> which has the following four functions:
>>
>> 	- VGA display controller (Function 0)
>> 	- Audio controller (Function 1)
>> 	- USB xHCI Host controller (Function 2)
>> 	- USB Type-C USCI controller (Function 3)
>>
>> Currently NVIDIA and Nouveau GPU drivers only manage function 0.
>> Rest of the functions are managed by other drivers. These functions
>> internally in the hardware are tightly coupled. When function 0 goes
>> in runtime suspended state, then it will do power gating for most of
>> the hardware blocks. Some of these hardware blocks are used by
>> the other PCI functions, which leads to functional failure. In the
>> mainline kernel, the device link is present between
>> function 0 and function 1.  This patch series deals with creating
>> a similar kind of device link between function 0 and
>> functions 2 and 3.
>>
>> [1] https://www.nvidia.com/content/dam/en-zz/Solutions/design-visualization/technologies/turing-architecture/NVIDIA-Turing-Architecture-Whitepaper.pdf
>> [2] https://en.wikipedia.org/wiki/VirtualLink
>>
>> Abhishek Sahu (2):
>>   PCI: Code reorganization for creating device link
>>   PCI: Create device link for NVIDIA GPU
> 
> Applied to pci/misc for v5.3, thanks!

 Thanks Bjorn for your review and support!

 The runtime PM changes in USB Type-C USCI driver is also
 applied for v5.3

 https://marc.info/?l=linux-usb&m=155994544705901&w=2

 It will help in achieving run-time PM for Turing GPUs
 in v5.3.

 Regards,
 Abhishek
