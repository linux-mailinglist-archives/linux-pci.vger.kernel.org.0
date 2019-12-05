Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6419C1140CA
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2019 13:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbfLEMZF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Dec 2019 07:25:05 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7639 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729048AbfLEMZF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Dec 2019 07:25:05 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5BB757E58D61C3C000C9;
        Thu,  5 Dec 2019 20:25:02 +0800 (CST)
Received: from [127.0.0.1] (10.184.52.56) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Thu, 5 Dec 2019
 20:24:53 +0800
Subject: Re: [PATCH] PCI: Add quirk to disable unused BAR for hisilicon NP
 devices 5896
To:     Andrew Murray <andrew.murray@arm.com>
CC:     <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <wangkefeng.wang@huawei.com>,
        <huawei.libin@huawei.com>, <guohanjun@huawei.com>
References: <1575546041-50907-1-git-send-email-wangxiongfeng2@huawei.com>
 <20191205121527.GL18399@e119886-lin.cambridge.arm.com>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <25257817-14fb-8e03-7280-35a2ccaa0009@huawei.com>
Date:   Thu, 5 Dec 2019 20:24:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20191205121527.GL18399@e119886-lin.cambridge.arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.184.52.56]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Andrew，
   Thanks for your advice. I will change them and send another version.

Thanks,
Xiongfeng

On 2019/12/5 20:15, Andrew Murray wrote:
> On Thu, Dec 05, 2019 at 07:40:41PM +0800, Xiongfeng Wang wrote:
>> Add pci quirk for hisilicon PCI Network Processor devices 5896.
> 
> Can you capatalise HiSilicon correctly (capital H and S), both here and
> in the subject line?
> 
> s/devices 5896/5896 devices/ ?
> 
>> The size of the unused BAR3 is set as 265T wrongly. This patch disalbes
> 
> s/disalbes/disables/
> 
>> this bar.
>>
>> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
>> ---
>>  drivers/pci/quirks.c    | 29 +++++++++++++++++++++++++++++
>>  include/linux/pci_ids.h |  1 +
>>  2 files changed, 30 insertions(+)
>>
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index 4937a08..7dfb272 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -5431,3 +5431,32 @@ static void quirk_reset_lenovo_thinkpad_p50_nvgpu(struct pci_dev *pdev)
>>  DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, 0x13b1,
>>  			      PCI_CLASS_DISPLAY_VGA, 8,
>>  			      quirk_reset_lenovo_thinkpad_p50_nvgpu);
>> +
>> +static void quirk_hisi_fixup_np_class(struct pci_dev *pdev)
>> +{
>> +	u32 class = pdev->class;
>> +
>> +	pdev->class = PCI_BASE_CLASS_NETWORK << 8;
>> +	pci_info(pdev, "PCI class overriden (%#08x -> %#08x)\n",
>> +		 class, pdev->class);
> 
> Why is this in here? This is completely unrelated to the commit message.
> 
>> +}
>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HISI_5896,
>> +			quirk_hisi_fixup_np_class);
>> +
>> +/*
>> + * Hisilicon NP devices 5896 BAR3 size is misreported as 256T. Actually, this
>> + * BAR is unused, so let's disable it.
> 
> Does this mean that the existing driver doesn't use this BAR? Is a better fix
> up the BAR to report the correct size?
> 
> 
>> + */
>> +#define HISI_5896_WRONG_BAR 3
> 
> I'd suggest this define is possibly not required.
> 
>> +static void quirk_hisi_fixup_np_bar(struct pci_dev *pdev)
>> +{
>> +	struct resource *r = &pdev->resource[HISI_5896_WRONG_BAR];
>> +
>> +	r->start = 0;
>> +	r->end = 0;
>> +	r->flags = 0;
>> +
>> +	pci_info(pdev, "disable BAR %d\n", HISI_5896_WRONG_BAR);
> 
> It might be more helpful to describe why, e.g. "Disabling invalid BAR 3"
> or similar.
> 
> 
>> +}
>> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HISI_5896,
>> +			 quirk_hisi_fixup_np_bar);
>> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
>> index 2302d133..56e2b91 100644
>> --- a/include/linux/pci_ids.h
>> +++ b/include/linux/pci_ids.h
>> @@ -2558,6 +2558,7 @@
>>  #define PCI_DEVICE_ID_KORENIX_JETCARDF3	0x17ff
>>  
>>  #define PCI_VENDOR_ID_HUAWEI		0x19e5
>> +#define PCI_DEVICE_ID_HISI_5896        0x5896 /* Hisilicon NP devices 5896 */
>>  
>>  #define PCI_VENDOR_ID_NETRONOME		0x19ee
>>  #define PCI_DEVICE_ID_NETRONOME_NFP4000	0x4000
> 
> Thanks,
> 
> Andrew Murray
> 
>> -- 
>> 1.7.12.4
>>
> 
> .
> 

