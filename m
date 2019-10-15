Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38544D75BB
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2019 14:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729773AbfJOMDk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Oct 2019 08:03:40 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:9373 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbfJOMDk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Oct 2019 08:03:40 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5da5b59d0000>; Tue, 15 Oct 2019 05:03:41 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 15 Oct 2019 05:03:38 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 15 Oct 2019 05:03:38 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 15 Oct
 2019 12:03:38 +0000
Received: from [10.25.73.96] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 15 Oct
 2019 12:03:35 +0000
Subject: Re: [PATCH] PCI: Add CRS timeout for pci_device_is_present()
To:     Thierry Reding <treding@nvidia.com>, Sinan Kaya <okaya@kernel.org>
CC:     <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <jonathanh@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20191005182129.32538-1-vidyas@nvidia.com>
 <20191014082023.GA232162@ulmo>
 <ce411d27-5b92-8dae-fccd-73c63aa30f1c@kernel.org>
 <20191015093053.GA5778@ulmo>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <5b08ab4a-2f87-386b-596c-677435074f62@nvidia.com>
Date:   Tue, 15 Oct 2019 17:33:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191015093053.GA5778@ulmo>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1571141021; bh=zrxGILwH8edZQFrszX8zgAxohqM234pR/AYFTIizvdI=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=A/h9IgjUYq51mmtyxG9+WwPovhKoK5lfhQzvb/ICe1b+bPPH71VXQ+bH0n6jOHvo4
         vLxl0ADBkjWQ25CVX/5a2m9CtbaW5HtG09qkIpJWYwrh/ifB8PHSwDZQfJevcHFR/Q
         Gt5TP6pjMVXnyNid7/SHSOniMOdwB0ITBHX42/nWa7F9dh5wCaOLZi/zPl9b5/wi7M
         Ug47fjMFZ2tRJwM9lQs2uFkEAfAl6xgGKQ9XfHlFxIDIx+wAY5URYpRCoq4bE5QHAX
         8zZagn6Vpa2BXh4xdTEVEEZZWAjeAMW7ohUPMVH9TCSE5gzsDoUJp4eOHZAD0Sm5mL
         9ZtDDLdpmQswg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/15/2019 3:00 PM, Thierry Reding wrote:
> On Mon, Oct 14, 2019 at 01:21:31PM -0700, Sinan Kaya wrote:
>> On 10/14/2019 1:20 AM, Thierry Reding wrote:
>>> I think this makes sense, so:
>>>
>>> Reviewed-by: Thierry Reding <treding@nvidia.com>
>>>
>>> However, it looks like Sinan has researched this extensively in the past
>>> and gave a presentation on this at Plumbers in 2017:
>>>
>>> 	https://blog.linuxplumbersconf.org/2017/ocw/system/presentations/4732/original/crs.pdf
>>>
>>> Adding Sinan to see if he has any concerns about this, since resume time
>>> is explicitly mentioned in the above slides.
>>
>>
>> Thanks for including me. Let me catch up here.
>>
>> pci_dev_wait() is supposed to handle this case via pci_pm_reset().
>>
>> /**
>>   * pci_pm_reset - Put device into PCI_D3 and back into PCI_D0.
>>   * @dev: Device to reset.
>>   * @probe: If set, only check if the device can be reset this way.
>>   */
>>
>> Do you know if your execution path hits this function? We might have
>> missed a use case.
>>
> 
> I see only a couple of callers of pci_device_is_present() in the tree,
> this being from next-20191015:
> 
> 	$ git grep -n pci_device_is_present
> 	drivers/net/ethernet/broadcom/tg3.c:9070:       if (!pci_device_is_present(tp->pdev))drivers/net/ethernet/broadcom/tg3.c:11785:      if (pci_device_is_present(tp->pdev)) {
> 	drivers/net/ethernet/intel/igb/igb_main.c:8838: if (!pci_device_is_present(pdev))
> 	drivers/nvme/host/pci.c:2866:   if (!pci_device_is_present(pdev)) {
> 	drivers/pci/hotplug/acpiphp_glue.c:650:         alive = pci_device_is_present(dev);
> 	drivers/pci/pci.c:935:      !pci_device_is_present(dev)) {
> 	drivers/pci/pci.c:5902:bool pci_device_is_present(struct pci_dev *pdev)
> 	drivers/pci/pci.c:5910:EXPORT_SYMBOL_GPL(pci_device_is_present);
> 	drivers/thunderbolt/nhi.c:939:  if (!pci_device_is_present(pdev)) {
> 	include/linux/pci.h:1206:bool pci_device_is_present(struct pci_dev *pdev);
> 
I think the important one is the following which is called from inside
pci_update_current_state() function.

drivers/pci/pci.c:935:      !pci_device_is_present(dev)) {

I've put a dump_stack() to see how this is called and following is the trace
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


> The NVME driver has the call in the ->remove() callback, so I don't
> think it's relevant here. Both TG3 and IGB ethernet drivers seem to call
> this during resume and so does Thunderbolt.
> 
> Vidya, can you clarify for which device you're seeing the issues? Sounds
> like adding a call to pci_pm_reset() (via pci_reset_function()) at some
> point.
With 0 sec wait, I see issue with Intel 750 NVMe card. As I mentioned above,
it is called from the PCI-PM subsystem which is where the timeout is required.

> 
> Sinan, it looks as if pci_pm_reset() (or any of its callers) is not used
> very widely. Is that just because most drivers haven't had a need for it
> yet? Or am I missing some core functionality that calls this for every
> device anyway?
> 
> Thierry
> 

