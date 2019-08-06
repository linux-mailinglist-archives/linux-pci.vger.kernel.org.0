Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB4682998
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2019 04:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731400AbfHFCZT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Aug 2019 22:25:19 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:61342 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729921AbfHFCZT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Aug 2019 22:25:19 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04391;MF=shannon.zhao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0TYmcN8B_1565058293;
Received: from 30.43.122.7(mailfrom:shannon.zhao@linux.alibaba.com fp:SMTPD_---0TYmcN8B_1565058293)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 06 Aug 2019 10:24:54 +0800
Subject: Re: [PATCH] PCI: Add ACS quirk for Cavium ThunderX 2 root port
 devices
To:     Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Shannon Zhao <shenglong.zsl@alibaba-inc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Guiping Duan <gduan@marvell.com>,
        George Cherian <gcherian@marvell.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>
References: <1563541835-141011-1-git-send-email-shenglong.zsl@alibaba-inc.com>
 <20190724185535.GD203187@google.com>
 <20190725163453.GA28724@dc5-eodlnx05.marvell.com>
From:   Shannon Zhao <shannon.zhao@linux.alibaba.com>
Message-ID: <7405c4fd-a1f6-9e0b-2d9c-10d8c101bbef@linux.alibaba.com>
Date:   Tue, 6 Aug 2019 10:24:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725163453.GA28724@dc5-eodlnx05.marvell.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019/7/26 0:35, Jayachandran Chandrasekharan Nair wrote:
> On Wed, Jul 24, 2019 at 01:55:35PM -0500, Bjorn Helgaas wrote:
>> See
>> https://lkml.kernel.org/r/20171026223701.GA25649@bhelgaas-glaptop.roam.corp.google.com
>> for incidental hints (subject, commit log, commit reference).  Your
>> patch basically extends that commit, so the subject should be very
>> similar.
>>
>> On Fri, Jul 19, 2019 at 09:10:35PM +0800, Shannon Zhao wrote:
>>> From: Shannon Zhao <shannon.zhao@linux.alibaba.com>
>>>
>>> Like commit f2ddaf8(PCI: Apply Cavium ThunderX ACS quirk to more Root
>>> Ports), it should apply ACS quirk to ThunderX 2 root port devices.
>>
>> s/root port/Root Port/ to be consistent
>>
>>> Signed-off-by: Shannon Zhao <shannon.zhao@linux.alibaba.com>
>>
>> I suppose this should have the same stable tag as f2ddaf8dfd4a ("PCI:
>> Apply Cavium ThunderX ACS quirk to more Root Ports") itself?
>>> ---
>>>   drivers/pci/quirks.c | 4 +++-
>>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>>> index 28c64f8..ea7848b 100644
>>> --- a/drivers/pci/quirks.c
>>> +++ b/drivers/pci/quirks.c
>>> @@ -4224,10 +4224,12 @@ static bool pci_quirk_cavium_acs_match(struct pci_dev *dev)
>>>   	 * family by 0xf800 mask (which represents 8 SoCs), while the lower
>>>   	 * bits of device ID are used to indicate which subdevice is used
>>>   	 * within the SoC.
>>> +	 * Effectively selects the ThunderX 2 root ports whose device ID
>>> +	 * is 0xaf84.
>>>   	 */
>>>   	return (pci_is_pcie(dev) &&
>>>   		(pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT) &&
>>> -		((dev->device & 0xf800) == 0xa000));
>>> +		((dev->device & 0xf800) == 0xa000 || dev->device == 0xaf84));
>>
>> I'm somewhat doubtful about this because previously we at least
>> selected a whole class of ThunderX 1 devices:
>>
>>    ((dev->device & 0xf800) == 0xa000)
>>
>> while you're adding only a *single* ThunderX device.
>>
>> I don't want a constant trickle of adding new devices.  Can somebody
>> from Cavium or Marvell provide a corresponding mask for ThunderX 2, or
>> confirm that 0xaf84 is really the single device we expect to need
>> here?
>   
> We are working on a patch to fix this quirk to handle more Marvell
> (Cavium) PCI IDs. Ideally we should be handling ThunderX1, ThunderX2
> and the Octeon-TX families here.
> 
> Adding the folks working on this reduce the churn here, hopefully
> we can get all of it sorted in one patch.
>   
That would be better. Please CC me when you send the patch out.

Thanks,
Shannon
