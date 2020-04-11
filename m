Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24D9E1A4D63
	for <lists+linux-pci@lfdr.de>; Sat, 11 Apr 2020 04:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgDKCJb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Apr 2020 22:09:31 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:41142 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726666AbgDKCJb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 Apr 2020 22:09:31 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4C315CF969FBCBA833C1;
        Sat, 11 Apr 2020 10:09:27 +0800 (CST)
Received: from [10.65.58.147] (10.65.58.147) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Sat, 11 Apr 2020
 10:09:25 +0800
Subject: Re: [PATCH] Replace -EINVAL with PCIBIOS_BAD_REGISTER_NUMBER
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Bolarinwa Olayemi Saheed <refactormyself@gmail.com>,
        <bjorn@helgaas.com>
References: <20200410202252.GA11837@google.com>
CC:     <skhan@linuxfoundation.org>, <linux-pci@vger.kernel.org>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <ec072da8-3dcb-2606-40ee-39e745311292@hisilicon.com>
Date:   Sat, 11 Apr 2020 10:10:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20200410202252.GA11837@google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.58.147]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn and Saheed,

Callers use return value(most callers even don't check) of
pcie_capability_{read,write}_*() I found lists below. some
may directly print them to dmesg, others return the error
codes to its caller. I think we should do the conversion in
both condition.

- pcie_speeds() in drivers/infiniband/hw/hfi1/pcie.c, line 306
- amd_ntb_get_link_status() in drivers/ntb/hw/amd/ntb_hw_amd.c, line 216, line 233

the probably change may look like:

    ret = pcie_capability_{read, write}_*();
    if (ret)
        return pcibios_err_to_errno(ret);

However, pci_{read, write}_config*() also have such problem, as they are also
used widely outside pci driver and these drivers don't do the conversion. for example
in arch/x86/platform/intel/iosf_mbi.c, iosf_mbi_pci_read_mdr() at line 39:

    result = pci_read_config_dword();
    if (result < 0)
        goto fail_read;

Seems it'll nevet get a failure result. Perhaps another patch is needed to solve these issues.

AS PCIBIOS_* error code canbe *equivalent* to generic error code, why can't we
directly use the generic ones? Considering of compatibility, maybe possible
change will be like:

    - #define PCIBIOS_FUNC_NOT_SUPPORTED 0X81
    + #define PCIBIOS_FUNC_NOT_SUPPORTED -ENOENT
    ......

and pcibios_err_to_errno() is not neccessary any more.

I don't know why we didn't use generic error code and define positive private errors.
Please tell me if there is any background.

Regards,
Yicong


On 2020/4/11 4:22, Bjorn Helgaas wrote:
> On Fri, Apr 10, 2020 at 09:28:07AM +0800, Yicong Yang wrote:
>> Hi Bolarinwa,
>>
>> I notice some drivers use these functions and if there is an error,
>> pass the error code directly to the userspace. As it's our private
>> error code, is it appropriate to pass or should we call
>> pcibios_err_to_errno()(include/linux/pci.h, line 672) to do the
>> conversion?
> The whole point of this is to make the return values of the
> pcie_capability_{read,write,etc}*() functions work the same as
> the pci_{read,write}_config*() functions.
>
> The latter return PCIBIOS_* error codes, so the former should as well.
>
> When we do this, we do need to audit every caller of the
> pcie_capability_{read,write}*() functions to make sure we don't break
> them.  If some callers pass the error code directly to userspace, they
> may need some change.
>
> Yicong, can you point to the ones you noticed so Saheed can check them
> out?
>
> Bjorn
>
>> On 2020/4/10 0:16, Bolarinwa Olayemi Saheed wrote:
>>> Signed-off-by: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
>>> Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
>>> ---
>>>  drivers/pci/access.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
>>> index 79c4a2ef269a..451f2b8b2b3c 100644
>>> --- a/drivers/pci/access.c
>>> +++ b/drivers/pci/access.c
>>> @@ -409,7 +409,7 @@ int pcie_capability_read_word(struct pci_dev *dev, int pos, u16 *val)
>>>  
>>>  	*val = 0;
>>>  	if (pos & 1)
>>> -		return -EINVAL;
>>> +		return PCIBIOS_BAD_REGISTER_NUMBER;
>>>  
>>>  	if (pcie_capability_reg_implemented(dev, pos)) {
>>>  		ret = pci_read_config_word(dev, pci_pcie_cap(dev) + pos, val);
>>> @@ -444,7 +444,7 @@ int pcie_capability_read_dword(struct pci_dev *dev, int pos, u32 *val)
>>>  
>>>  	*val = 0;
>>>  	if (pos & 3)
>>> -		return -EINVAL;
>>> +		return PCIBIOS_BAD_REGISTER_NUMBER;
>>>  
>>>  	if (pcie_capability_reg_implemented(dev, pos)) {
>>>  		ret = pci_read_config_dword(dev, pci_pcie_cap(dev) + pos, val);
> .
>

