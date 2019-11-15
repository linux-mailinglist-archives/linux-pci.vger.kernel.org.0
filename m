Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE6EFDA63
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2019 11:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfKOKEb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Nov 2019 05:04:31 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:18038 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbfKOKEa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Nov 2019 05:04:30 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dce782d0000>; Fri, 15 Nov 2019 02:04:29 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 15 Nov 2019 02:04:29 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 15 Nov 2019 02:04:29 -0800
Received: from [10.25.73.25] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 15 Nov
 2019 10:04:26 +0000
Subject: Re: [PATCH] PCI: Add CRS timeout for pci_device_is_present()
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Thierry Reding <treding@nvidia.com>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sinan Kaya <okaya@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <jonathanh@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>,
        "Andrew Murray" <andrew.murray@arm.com>,
        Lukas Wunner <lukas@wunner.de>
References: <20191114183612.GA215974@google.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <b6625491-dc02-4fdd-a748-fe0d3b573b01@nvidia.com>
Date:   Fri, 15 Nov 2019 15:34:23 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191114183612.GA215974@google.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1573812269; bh=E2pdpCUCUad4WzaXuj5mfDZKCvDCVPZUuGyvG0ac8l8=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=rHGDPjD6yIpqq+ofI9lpO7KCAnHKwIVDdy/wd4XuSm7gD+k2ynxTcrDrhYH0eI8Nt
         wxr2n5+qAKJIkqcA9KdZCU+XQnp1X1JmoygqV2lTnjyzAb7HZAHaQWY9z5CVYTjmRL
         ajhfqT9SW10CaGZAcQBeYIu1VaRZ+NYrcf3scpvjonABrK70QLUAFwsNNaxduoOclL
         TO059wYBmODnx8GUg7wgBOyC6S4M9zfPiPKDSfHwnSdtgFIumqol58HLPhNv1AbmQ+
         a8lcwzyniNiY4FCzg6VHTT30iKGCBFUV5HpDeJx+VZ/evRxLun2Q7FzCJcdgvU2/KJ
         hSiz/AW1vpWPg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/15/2019 12:06 AM, Bjorn Helgaas wrote:
> On Wed, Nov 13, 2019 at 12:20:43PM +0100, Thierry Reding wrote:
>> On Tue, Nov 12, 2019 at 12:58:44PM -0600, Bjorn Helgaas wrote:
> 
>>> My question is whether this wait should be connected somehow with
>>> platform_pci_set_power_state().  It sounds like the tegra host
>>> controller driver already does the platform-specific delays, and I'm
>>> not sure it's reasonable for platform_pci_set_power_state() to do the
>>> CRS polling.  Maybe something like this?  I'd really like to get
>>> Rafael's thinking here.
>>>
>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>> index e7982af9a5d8..052fa316c917 100644
>>> --- a/drivers/pci/pci.c
>>> +++ b/drivers/pci/pci.c
>>> @@ -964,9 +964,14 @@ void pci_refresh_power_state(struct pci_dev *dev)
>>>    */
>>>   void pci_power_up(struct pci_dev *dev)
>>>   {
>>> +	pci_power_state_t prev_state = dev->current_state;
>>> +
>>>   	if (platform_pci_power_manageable(dev))
>>>   		platform_pci_set_power_state(dev, PCI_D0);
>>>   
>>> +	if (prev_state == PCI_D3cold)
>>> +		pci_dev_wait(dev, "D3cold->D0", PCIE_RESET_READY_POLL_MS);
>>
>> Is there any reason in particular why you chose to call pci_dev_wait()?
>> It seems to me like that's a little broader than pci_bus_wait_crs(). The
>> latter is static in drivers/pci/probe.c so we'd need to change that in
>> order to use it from drivers/pci/pci.c, but it sounds like the more
>> explicit thing to do.
> 
> Broader in what sense?  They work essentially identically except that
> pci_bus_wait_crs() doesn't need a pci_dev * (because it's used during
> enumeration when we don't have a pci_dev yet) and it does dword reads
> instead of word reads.
> 
> It is a shame that the logic is duplicated, but we don't have to worry
> about that here.
> 
> I think I would stick with pci_dev_wait() in this case since we do
> have a pci_dev * and it's a little simpler, unless I'm missing the
> advantage of pci_bus_wait_crs().
Is there any specific reason why should there be a check for the state?
In Tegra series, I observe that, by the time execution comes to this point,
prev_state is PCI_D3Hot and in Tegra194 particularly, it is PCI_D0 because the
host controller driver explicitly keeps the downstream devices in PCI_D0 state
as a work around for one of the Tegra194 specific issues. So, I feel the check
for current_state may not be need here(?)

- Vidya Sagar
> 
> Bjorn
> 

