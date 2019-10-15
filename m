Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32DDED763B
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2019 14:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbfJOMPB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Oct 2019 08:15:01 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:9562 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbfJOMPB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Oct 2019 08:15:01 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5da5b8490000>; Tue, 15 Oct 2019 05:15:05 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 15 Oct 2019 05:14:54 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 15 Oct 2019 05:14:54 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 15 Oct
 2019 12:14:53 +0000
Received: from [10.25.73.96] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 15 Oct
 2019 12:14:50 +0000
Subject: Re: [PATCH] PCI: Add CRS timeout for pci_device_is_present()
To:     Sinan Kaya <okaya@kernel.org>, Thierry Reding <treding@nvidia.com>
CC:     <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <jonathanh@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <20191005182129.32538-1-vidyas@nvidia.com>
 <20191014082023.GA232162@ulmo>
 <ce411d27-5b92-8dae-fccd-73c63aa30f1c@kernel.org>
 <20191015093053.GA5778@ulmo>
 <4953b718-8818-575e-2ec1-8197e6b32593@kernel.org>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <85267afb-c08e-5625-d3ee-bd32af9ecb12@nvidia.com>
Date:   Tue, 15 Oct 2019 17:44:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <4953b718-8818-575e-2ec1-8197e6b32593@kernel.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1571141705; bh=uK5nIirjWo7QOhWfaYL0ARhpVoeb0jjD0jO12CScz8M=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=f2gpZPRqjOH5H53aSr/AW+dWzystnBn5v/Mb7mQ0wupMkRQRcYmhE8dDsWnzdAlRv
         vAHBhYiXVwAqafQVJUFtcqKpPm+MOmIi+nvU+FPjWxwRCneW3WalKRrsATrHkeWRQ3
         vndCoQ9XHg1TatX0mALcslT3lVtaOSoRBbmYIBNDVYpcJgt8ZFJwkAk967jTrRcwxu
         5hgIlbebu3KOWlvuMFYrky2GMhtzslLAPqhzhhaMBrTP4InbfyjsIA55h8S+Qm4Zz4
         NLhDcMeG+WzarGNOuyKpdCbgG+ZymwE/AYDXpzBgHuiDMvIoNYNNxo1KvksfcvSSld
         Oz93zSw6GJ09g==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/15/2019 4:40 PM, Sinan Kaya wrote:
> +Rafael
> 
> On 10/15/2019 2:30 AM, Thierry Reding wrote:
>> Vidya, can you clarify for which device you're seeing the issues? Sounds
>> like adding a call to pci_pm_reset() (via pci_reset_function()) at some
>> point.
>>
>> Sinan, it looks as if pci_pm_reset() (or any of its callers) is not used
>> very widely. Is that just because most drivers haven't had a need for it
>> yet? Or am I missing some core functionality that calls this for every
>> device anyway?
> 
> pci_pm_reset() is there as an alternative reset path. We are not
> supposed to call this function. Sorry for giving you wrong direction
> here. pci_reset_function() should call it only if there is no other
> suitable reset function is found.
> 
> I think the PCI core should be putting the device back D0 state as one
> of the first actions before enumerating. Wake up could be a combination
> of ACPI and/or PCI wake up depending on where your device sits in the
> topology.
Yup. It is indeed doing it as part of pci_power_up() in pci.c file.
But, what is confusing to me is the order of the calls.
pci_power_up() has following calls in the same order.
	pci_raw_set_power_state(dev, PCI_D0);
	pci_update_current_state(dev, PCI_D0);
But, pci_raw_set_power_state() is accessing config space without calling
pci_device_is_present() whereas pci_update_current_state() which is called
later in the flow is calling pci_device_is_present()...!

> 
> On the other hand, wake up code doesn't perform the CRS wait. CRS
> wait is deferred until the first vendor id read in pci_scan_device().
> I see that it already waits for 60 seconds.
> 
> Going back to the patch...
> 
> I think we need to find the path that actually needs this sleep and
> put pci_dev_wait() there.
Following is the path in resume() flow.
[   36.380726] Call trace:
[   36.383270]  dump_backtrace+0x0/0x158
[   36.386802]  show_stack+0x14/0x20
[   36.389749]  dump_stack+0xb0/0xf8
[   36.393451]  pci_update_current_state+0x58/0xe0
[   36.398178]  pci_power_up+0x60/0x70
[   36.401672]  pci_pm_resume_noirq+0x6c/0x130
[   36.405669]  dpm_run_callback.isra.16+0x20/0x70
[   36.410248]  device_resume_noirq+0x120/0x238
[   36.414364]  async_resume_noirq+0x24/0x58
[   36.418364]  async_run_entry_fn+0x40/0x148
[   36.422418]  process_one_work+0x1e8/0x360
[   36.426525]  worker_thread+0x40/0x488
[   36.430201]  kthread+0x118/0x120
[   36.433843]  ret_from_fork+0x10/0x1c

> 
> +++ b/drivers/pci/pci.c
> @@ -5905,7 +5905,8 @@ bool pci_device_is_present(struct pci_dev *pdev)
> 
>   	if (pci_dev_is_disconnected(pdev))
>   		return false;
> -	return pci_bus_read_dev_vendor_id(pdev->bus, pdev->devfn, &v, 0);
> +	return pci_bus_read_dev_vendor_id(pdev->bus, pdev->devfn, &v,
> +					  PCI_CRS_TIMEOUT);
>   }
> 
> pci_device_is_present() is a too low-level function and it may not
> be allowed to sleep. It uses 0 as timeout value.
> 
> 

