Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C36585E9B0
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2019 18:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfGCQub (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Jul 2019 12:50:31 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:12419 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfGCQub (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Jul 2019 12:50:31 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d1cdcd20000>; Wed, 03 Jul 2019 09:50:26 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 03 Jul 2019 09:50:29 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 03 Jul 2019 09:50:29 -0700
Received: from [10.25.75.27] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 3 Jul
 2019 16:50:26 +0000
Subject: Re: [PATCH V2] PCI: tegra: Enable Relaxed Ordering only for Tegra20 &
 Tegra30
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     <bhelgaas@google.com>, <treding@nvidia.com>, <swarren@nvidia.com>,
        <jonathanh@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20190701110942.24305-1-vidyas@nvidia.com>
 <20190703161922.GA22679@e121166-lin.cambridge.arm.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <be78c2c4-90bf-3c63-ace5-546e490c732c@nvidia.com>
Date:   Wed, 3 Jul 2019 22:20:23 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190703161922.GA22679@e121166-lin.cambridge.arm.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1562172626; bh=f+nQB8ajwcJAZIvrwWsys8xQoRtK/MZJ3oMr0+PsabU=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=cudLN6A/ud1m8rHP3+Q11z1E3hr2ltWYdjDtyKumRFHkbRgqNA/6o1jNiIpdfzIGY
         +CjxZsTPSeWYTn2VTfkWhIgFU/Yu4ZYrMUZnD4+Th2Vlw6o8MqGd7LCrj5aXz3fySi
         GjDD8EMWsHBlY+v98pG90xbSC29OV+GdBjCUog6/jNU5YFoY3awvRQPwda1PfgcD8p
         /xVW0/i/xrZyqLf1dmZc+Rq3Jrv0yGpDEZhKPKQoa0XB+n45r1y8AtmeOQpX9rEAYT
         THqoRCsE7Ez5grwicwcyCSKtGds7o4tjhJMnd2TE5B4KJmKr4niQ5mAo7V4y2zHtLV
         yTKTsa/pHvbvQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/3/2019 10:09 PM, Lorenzo Pieralisi wrote:
> On Mon, Jul 01, 2019 at 04:39:42PM +0530, Vidya Sagar wrote:
>> Currently Relaxed Ordering bit in the configuration space is enabled for
>> all devices, but, as per the Technical Reference Manual of Tegra20 which is
> 
> What devices ?
All PCIe devices, because, current quirk uses PCI_ANY_ID for both Vendor-ID
and Device-ID and that makes it applicable for all PCIe devices.

> 
>> available at https://developer.nvidia.com/embedded/downloads#?search=tegra%202
>> in Sec 34.1, it is mentioned that Relexed Ordering bit needs to be enabled in
>> its root ports to avoid deadlock in hardware. The same is applicable for
>> Tegra30 as well though it is not explicitly mentioned in Tegra30 TRM document,
>> but the same should not be extended to root ports of other Tegra SoCs or
>> other hosts.
> 
> Should not or must not ? What does this sentence mean ?
I think it is 'must not' here. Since the hardware deadlock issue is not present
in any other root ports other than Tegra20 and Tegra30, this quirk must not be
extended to any other root ports.

> 
> Can we try to be more precise please ?
> 
> As I said before the commit log must be clear to anyone reading it
> even if he has no background information.
Would the following work?

Currently Relaxed Ordering bit in the configuration space is enabled for
all PCIe devices as the quirk uses PCI_ANY_ID for both Vendor-ID and
Device-ID, but, as per the Technical Reference Manual of Tegra20 which is
available at https://developer.nvidia.com/embedded/downloads#?search=tegra%202
in Sec 34.1, it is mentioned that Relexed Ordering bit needs to be enabled in
its root ports to avoid deadlock in hardware. The same is applicable for
Tegra30 as well though it is not explicitly mentioned in Tegra30 TRM document,
but the same must not be extended to root ports of other Tegra SoCs or
other hosts as the same issue doesn't exist there.

> 
> Lorenzo
> 
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
>> V2:
>> * Modified commit message to include reference to Tegra20 TRM document.
>>
>>   drivers/pci/controller/pci-tegra.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
>> index 9cc03a2549c0..241760aa15bd 100644
>> --- a/drivers/pci/controller/pci-tegra.c
>> +++ b/drivers/pci/controller/pci-tegra.c
>> @@ -787,12 +787,15 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0bf1, tegra_pcie_fixup_class);
>>   DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0e1c, tegra_pcie_fixup_class);
>>   DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0e1d, tegra_pcie_fixup_class);
>>   
>> -/* Tegra PCIE requires relaxed ordering */
>> +/* Tegra20 and Tegra30 PCIE requires relaxed ordering */
>>   static void tegra_pcie_relax_enable(struct pci_dev *dev)
>>   {
>>   	pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_DEVCTL_RELAX_EN);
>>   }
>> -DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID, PCI_ANY_ID, tegra_pcie_relax_enable);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, 0x0bf0, tegra_pcie_relax_enable);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, 0x0bf1, tegra_pcie_relax_enable);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, 0x0e1c, tegra_pcie_relax_enable);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, 0x0e1d, tegra_pcie_relax_enable);
>>   
>>   static int tegra_pcie_request_resources(struct tegra_pcie *pcie)
>>   {
>> -- 
>> 2.17.1
>>

