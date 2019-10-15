Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3D0BD7511
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2019 13:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbfJOLeI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Oct 2019 07:34:08 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:7657 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfJOLeI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Oct 2019 07:34:08 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5da5aeb20001>; Tue, 15 Oct 2019 04:34:10 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 15 Oct 2019 04:34:07 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 15 Oct 2019 04:34:07 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 15 Oct
 2019 11:34:07 +0000
Received: from [10.25.73.96] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 15 Oct
 2019 11:34:04 +0000
Subject: Re: [PATCH] PCI: Add CRS timeout for pci_device_is_present()
To:     Sinan Kaya <okaya@kernel.org>, Thierry Reding <treding@nvidia.com>
CC:     <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <jonathanh@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20191005182129.32538-1-vidyas@nvidia.com>
 <20191014082023.GA232162@ulmo>
 <ce411d27-5b92-8dae-fccd-73c63aa30f1c@kernel.org>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <ddb0b314-7f8b-0714-773d-41c3b95288a9@nvidia.com>
Date:   Tue, 15 Oct 2019 17:04:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ce411d27-5b92-8dae-fccd-73c63aa30f1c@kernel.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1571139250; bh=iwsDtx3+GNyN2w0DfxgOYG10Z+MrLtZqM7mMZN2kvL0=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=GWIPN1kZgWp3/n2/3W4+DRxz66ix3AkB5ZOmsinexGx2kEDT/jftWEwNCg3GqzgQX
         8k9x7njr6eWRgY1KPQ8Uu45u0A0axO1NUKQg6yN6yVQnPYTY0jATxcDZnQmyR+6gXW
         w1Ri61lzlj6dwnMoUgRmtvOX1ZjmGlE52FvCbbjQcKo/16l5Xqi72F2P6cTTPLZh0A
         40YatgilAPQqhtxJVMcHXOb3ppS5z7KUyon62Y71d8anq2YO4jsaZJimTtBCV7JGey
         YvZOkhYschznnrDZG5NUKS77ktrDlVXZh70ZNsFnNhc5FTOGDdvCfSyXWQYd6vRlvV
         hJvPdQae0dOuQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/15/2019 1:51 AM, Sinan Kaya wrote:
> On 10/14/2019 1:20 AM, Thierry Reding wrote:
>> I think this makes sense, so:
>>
>> Reviewed-by: Thierry Reding <treding@nvidia.com>
>>
>> However, it looks like Sinan has researched this extensively in the past
>> and gave a presentation on this at Plumbers in 2017:
>>
>> 	https://blog.linuxplumbersconf.org/2017/ocw/system/presentations/4732/original/crs.pdf
>>
>> Adding Sinan to see if he has any concerns about this, since resume time
>> is explicitly mentioned in the above slides.
> 
> 
> Thanks for including me. Let me catch up here.
> 
> pci_dev_wait() is supposed to handle this case via pci_pm_reset().
> 
> /**
>   * pci_pm_reset - Put device into PCI_D3 and back into PCI_D0.
>   * @dev: Device to reset.
>   * @probe: If set, only check if the device can be reset this way.
>   */
> 
> Do you know if your execution path hits this function? We might have
> missed a use case.
> 
Nope. It doesn't.
Following is the stack dump showing how pci_update_current_state() is called in resume() path.
And pci_device_is_present() is called from inside pci_update_current_state() API.
My understanding is that pci_device_is_present() is the API we hit first in the resume() path
for any PCIe device.

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

Also, I don't see pci_pm_reset() getting called in resume() path at all.

Thanks,
Vidya Sagar
