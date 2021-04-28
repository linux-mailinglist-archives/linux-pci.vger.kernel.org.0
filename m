Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE7536D008
	for <lists+linux-pci@lfdr.de>; Wed, 28 Apr 2021 02:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235454AbhD1Akb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Apr 2021 20:40:31 -0400
Received: from mga02.intel.com ([134.134.136.20]:29024 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230368AbhD1Aka (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Apr 2021 20:40:30 -0400
IronPort-SDR: YjweTBve18neMbpX6+ZGO5WBJ6s2UnllxkbWHJEs1M8zOndw7+n3MTa0LAFhD4f9dpgZYLOmbV
 XRkEyDZIxGjQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9967"; a="183763213"
X-IronPort-AV: E=Sophos;i="5.82,256,1613462400"; 
   d="scan'208";a="183763213"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2021 17:39:46 -0700
IronPort-SDR: 0RqJwd+vV3gBvayyZ0K16jmwkWyPVJmz6/rcFgRvMTEQKoI8xvcFrjxqloggiU7vrsgUy99wSJ
 0yR3HIQSCrcg==
X-IronPort-AV: E=Sophos;i="5.82,256,1613462400"; 
   d="scan'208";a="386326646"
Received: from mchintha-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.5.143])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2021 17:39:45 -0700
Subject: Re: [PATCH] PCI: pciehp: Ignore Link Down/Up caused by DPC
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ethan Zhao <haifeng.zhao@intel.com>, Sinan Kaya <okaya@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <kbusch@kernel.org>, linux-pci@vger.kernel.org,
        Russell Currey <ruscur@russell.cc>,
        Oliver O'Halloran <oohall@gmail.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
References: <b70e19324bbdded90b728a5687aa78dc17c20306.1616921228.git.lukas@wunner.de>
 <13bbd4f9-dff4-be79-d80a-342399961939@linux.intel.com>
Message-ID: <c7a09e8d-d2a9-02c9-8ac1-224147bd7827@linux.intel.com>
Date:   Tue, 27 Apr 2021 17:39:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <13bbd4f9-dff4-be79-d80a-342399961939@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 3/30/21 1:53 PM, Kuppuswamy, Sathyanarayanan wrote:
>> Downstream Port Containment (PCIe Base Spec, sec. 6.2.10) disables the
>> link upon an error and attempts to re-enable it when instructed by the
>> DPC driver.
>>
>> A slot which is both DPC- and hotplug-capable is currently brought down
>> by pciehp once DPC is triggered (due to the link change) and brought up
>> on successful recovery.  That's undesirable, the slot should remain up
>> so that the hotplugged device remains bound to its driver.  DPC notifies
>> the driver of the error and of successful recovery in pcie_do_recovery()
>> and the driver may then restore the device to working state.
>>
>> Moreover, Sinan points out that turning off slot power by pciehp may
>> foil recovery by DPC:  Power off/on is a cold reset concurrently to
>> DPC's warm reset.  Sathyanarayanan reports extended delays or failure
>> in link retraining by DPC if pciehp brings down the slot.
>>
>> Fix by detecting whether a Link Down event is caused by DPC and awaiting
>> recovery if so.  On successful recovery, ignore both the Link Down and
>> the subsequent Link Up event.
>>
>> Afterwards, check whether the link is down to detect surprise-removal or
>> another DPC event immediately after DPC recovery.  Ensure that the
>> corresponding DLLSC event is not ignored by synthesizing it and
>> invoking irq_wake_thread() to trigger a re-run of pciehp_ist().
>>
>> The IRQ threads of the hotplug and DPC drivers, pciehp_ist() and
>> dpc_handler(), race against each other.  If pciehp is faster than DPC,
>> it will wait until DPC recovery completes.
>>
>> Recovery consists of two steps:  The first step (waiting for link
>> disablement) is recognizable by pciehp through a set DPC Trigger Status
>> bit.  The second step (waiting for link retraining) is recognizable
>> through a newly introduced PCI_DPC_RECOVERING flag.
>>
>> If DPC is faster than pciehp, neither of the two flags will be set and
>> pciehp may glean the recovery status from the new PCI_DPC_RECOVERED flag.
>> The flag is zero if DPC didn't occur at all, hence DLLSC events are not
>> ignored by default.
>>
>> This commit draws inspiration from previous attempts to synchronize DPC
>> with pciehp:
>>
>> By Sinan Kaya, August 2018:
>> https://lore.kernel.org/linux-pci/20180818065126.77912-1-okaya@kernel.org/
>>
>> By Ethan Zhao, October 2020:
>> https://lore.kernel.org/linux-pci/20201007113158.48933-1-haifeng.zhao@intel.com/
>>
>> By Sathyanarayanan Kuppuswamy, March 2021:
>> https://lore.kernel.org/linux-pci/59cb30f5e5ac6d65427ceaadf1012b2ba8dbf66c.1615606143.git.sathyanarayanan.kuppuswamy@linux.intel.com/ 
>>
> Looks good to me. This patch fixes the reported issue in our environment.
> 
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Tested-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Any update on this patch? is this queued for merge? One of our customers is looking
for this fix. So wondering about the status.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
