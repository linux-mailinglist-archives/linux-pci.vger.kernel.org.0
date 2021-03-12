Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6211B3399FA
	for <lists+linux-pci@lfdr.de>; Sat, 13 Mar 2021 00:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235753AbhCLX1C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Mar 2021 18:27:02 -0500
Received: from mga03.intel.com ([134.134.136.65]:32203 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235714AbhCLX0o (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Mar 2021 18:26:44 -0500
IronPort-SDR: u8LFZLYjOoiNZW7+742CoaGhK+/pXfDdbz5iE/iEpXk/5nP9SLoI3x+7omdWvIq59sPzClniHD
 HT/9F4HWMZkQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="188945965"
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="188945965"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 15:26:42 -0800
IronPort-SDR: I3nluUzT4Hd/AdP7XefOJa7boRCfknc6myQ7bM27dJsqE6IHBnEUS9HN1MLghAbkRRoQuN0uIU
 YhCWpYNqhRXA==
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="411171890"
Received: from fgeisler-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.251.5.8])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 15:26:41 -0800
Subject: Re: [PATCH v1 1/1] PCI: pciehp: Skip DLLSC handling if DPC is
 triggered
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com,
        dan.j.williams@intel.com, keith.busch@intel.com,
        knsathya@kernel.org, Lukas Wunner <lukas@wunner.de>
References: <20210312231416.GA2304029@bjorn-Precision-5520>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <7c64f84b-906a-7adf-901e-05492779a3a3@linux.intel.com>
Date:   Fri, 12 Mar 2021 15:26:39 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210312231416.GA2304029@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 3/12/21 3:14 PM, Bjorn Helgaas wrote:
> On Fri, Mar 12, 2021 at 02:11:03PM -0800, Kuppuswamy, Sathyanarayanan wrote:
>> On 3/12/21 1:33 PM, Bjorn Helgaas wrote:
>>> On Mon, Mar 08, 2021 at 10:34:10PM -0800, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
>>>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
>>>> +bool is_dpc_reset_active(struct pci_dev *dev)
>>>> +{
>>>> +	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
>>>> +	u16 status;
>>>> +
>>>> +	if (!dev->dpc_cap)
>>>> +		return false;
>>>> +
>>>> +	/*
>>>> +	 * If DPC is owned by firmware and EDR is not supported, there is
>>>> +	 * no race between hotplug and DPC recovery handler. So return
>>>> +	 * false.
>>>> +	 */
>>>> +	if (!host->native_dpc && !IS_ENABLED(CONFIG_PCIE_EDR))
>>>> +		return false;
>>>> +
>>>> +	if (atomic_read_acquire(&dev->dpc_reset_active))
>>>> +		return true;
>>>> +
>>>> +	pci_read_config_word(dev, dev->dpc_cap + PCI_EXP_DPC_STATUS, &status);
>>>> +
>>>> +	return !!(status & PCI_EXP_DPC_STATUS_TRIGGER);
>>>
>>> I know it's somewhat common in drivers/pci/, but I'm not really a
>>> big fan of "!!".
>> I can change it to use ternary operator.
>> (status & PCI_EXP_DPC_STATUS_TRIGGER) ? true : false;
> 
> Ternary isn't terrible, but what's wrong with:
> 
>    if (status & PCI_EXP_DPC_STATUS_TRIGGER)
>      return true;
>    return false;
I am fine with above format.
> 
> which matches the style of the rest of the function.
> 
> Looking at this again, we return "true" if either dpc_reset_active or
> PCI_EXP_DPC_STATUS_TRIGGER.  I haven't worked this all out, but that
> pattern feels racy.  I guess the thought is that if
> PCI_EXP_DPC_STATUS_TRIGGER is set, dpc_reset_link() will be invoked
> soon and we don't want to interfere?
Yes, the reason for checking dpc_reset_active before
PCI_EXP_DPC_STATUS_TRIGGER is because, we want suppress DLLSC events
till link comes back or it times out.

137         atomic_inc_return_acquire(&pdev->dpc_reset_active);
138
139         pci_write_config_word(pdev, cap + PCI_EXP_DPC_STATUS,
140                               PCI_EXP_DPC_STATUS_TRIGGER);
141
142         if (!pcie_wait_for_link(pdev, true)) {
143                 pci_info(pdev, "Data Link Layer Link Active not set in 1000 msec\n");
144                 status = PCI_ERS_RESULT_DISCONNECT;
145         }
146
147         atomic_dec_return_release(&pdev->dpc_reset_active);

> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
