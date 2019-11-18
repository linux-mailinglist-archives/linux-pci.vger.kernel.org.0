Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF75100802
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2019 16:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbfKRPSU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Nov 2019 10:18:20 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:16558 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbfKRPSU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Nov 2019 10:18:20 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dd2b6390000>; Mon, 18 Nov 2019 07:18:17 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 18 Nov 2019 07:18:19 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 18 Nov 2019 07:18:19 -0800
Received: from [10.25.74.243] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 18 Nov
 2019 15:18:15 +0000
Subject: Re: [PATCH] PCI: Add CRS timeout for pci_device_is_present()
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Thierry Reding <treding@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sinan Kaya <okaya@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <jonathanh@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>,
        "Andrew Murray" <andrew.murray@arm.com>,
        Lukas Wunner <lukas@wunner.de>
References: <20191115223647.GA129381@google.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <31b03468-c2ee-4347-51ab-6a15a23cda01@nvidia.com>
Date:   Mon, 18 Nov 2019 20:48:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191115223647.GA129381@google.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1574090297; bh=2PJZ79E/jHsTKbs+cod8Gz9JS/ZVnHFDloRMTChYXVY=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=ROP9XUzKBGMVqfi1I39vq7akOktSSrdYDPzT+Ui7O9ooPCEpphBV5s37rRN96NU42
         +d+ldjKDEa+4v8nYg+M9sPriHx/DcasCvj5+S13tKJxYQLjaRj1jcTbdoSpIHyLSEF
         3E5NdRUGu3jWQywK77KlZBGCImRahm4MTwC1gvpvJDDs4fg4DhNLooPIQnKab4Yd3s
         cseOR551C/VZPR45JzZGagp+3Jw/nSF2qlGEC9JFLDA25p4ZrjRKx8HbBDxEecfxsJ
         lEHvD65ehyYsFLbxZTEzVCxz7zAXeWyRAuPsrDWlc0y6ZKQUomkcWGfd8//TOosx3Z
         NlNNngGJIwYDw==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/16/2019 4:06 AM, Bjorn Helgaas wrote:
> On Fri, Nov 15, 2019 at 03:34:23PM +0530, Vidya Sagar wrote:
>> On 11/15/2019 12:06 AM, Bjorn Helgaas wrote:
>>> On Wed, Nov 13, 2019 at 12:20:43PM +0100, Thierry Reding wrote:
>>>> On Tue, Nov 12, 2019 at 12:58:44PM -0600, Bjorn Helgaas wrote:
>>>>
>>>>> My question is whether this wait should be connected somehow with
>>>>> platform_pci_set_power_state().  It sounds like the tegra host
>>>>> controller driver already does the platform-specific delays, and I'm
>>>>> not sure it's reasonable for platform_pci_set_power_state() to do the
>>>>> CRS polling.  Maybe something like this?  I'd really like to get
>>>>> Rafael's thinking here.
>>>>>
>>>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>>>> index e7982af9a5d8..052fa316c917 100644
>>>>> --- a/drivers/pci/pci.c
>>>>> +++ b/drivers/pci/pci.c
>>>>> @@ -964,9 +964,14 @@ void pci_refresh_power_state(struct pci_dev *dev)
>>>>>     */
>>>>>    void pci_power_up(struct pci_dev *dev)
>>>>>    {
>>>>> +	pci_power_state_t prev_state = dev->current_state;
>>>>> +
>>>>>    	if (platform_pci_power_manageable(dev))
>>>>>    		platform_pci_set_power_state(dev, PCI_D0);
>>>>> +	if (prev_state == PCI_D3cold)
>>>>> +		pci_dev_wait(dev, "D3cold->D0", PCIE_RESET_READY_POLL_MS);
>>
>> Is there any specific reason why should there be a check for the
>> state?  In Tegra series, I observe that, by the time execution comes
>> to this point, prev_state is PCI_D3Hot and in Tegra194 particularly,
>> it is PCI_D0 because the host controller driver explicitly keeps the
>> downstream devices in PCI_D0 state as a work around for one of the
>> Tegra194 specific issues.
> 
> I think you're right, we probably should not try to check "prev_state"
> here because we can't rely on that being accurate.
> 
> On Tegra, I assume suspend puts the PCIe devices in D3hot, then when
> we suspend the RC itself, it looks like tegra_pcie_pm_suspend()
> actually turns off the power, so the PCIe devices probably go to
> D3cold but nothing updates their dev->current_state, so it's probably
> still PCI_D3hot.
> 
> On Tegra194, the same probably happens, except that when we suspend
> the RC itself, tegra_pcie_downstream_dev_to_D0() puts the PCIe devices
> back in D0 (updating their dev->current_state to PCI_D0), and then we
> turn off the power, so they probably also end up in D3cold but with
> dev_current_state still set to PCI_D0.
> 
>> So, I feel the check for current_state may not be need here(?)
> 
> I think you're right.  We can't tell what dev->current_state is when
> we enter pci_power_up().
Thanks,
I'll push a change with your suggested modifications.

- Vidya Sagar
> 
> Bjorn
> 

