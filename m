Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1BD61AF81A
	for <lists+linux-pci@lfdr.de>; Sun, 19 Apr 2020 08:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725910AbgDSG4M (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 19 Apr 2020 02:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgDSG4L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 19 Apr 2020 02:56:11 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E4EC061A0C
        for <linux-pci@vger.kernel.org>; Sat, 18 Apr 2020 23:56:11 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id y24so7543871wma.4
        for <linux-pci@vger.kernel.org>; Sat, 18 Apr 2020 23:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=bvVxplEq12gRKVU/1QU9KaRq3+qBnxhiE6tTLAwVB9M=;
        b=WBG4WyLOEuUI2MbKwXFW38XL4fhkHm6uzkMXk6+gDdSpp4n0GoaWe+W2uzcutPOnvR
         snhMv6X0m5D9YYfKEhoetHYugFL6MS+r6S8YIp1V+5R1+sa06JlO+NCw4FFkYSnKlP7k
         F/ENKVJxkwboQ13oDBhVRxEnsXfLeTzIbPdjbL4ZwDHZqRDIB8ay6AWA9kBCi/O3G1ys
         WnATbSEuCHd+wOo3Ja374xGXYAlX/G4b5ILHdzjUjdSa9qx4vm6AVmFbwX8dhpkniVLD
         2T5HUFoNZqCwbGlvhAH7qYmAr8dl/5t3Bp7KuupXzqXLc2JlbzjjHQbFP6RuGUAr++wE
         yLnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=bvVxplEq12gRKVU/1QU9KaRq3+qBnxhiE6tTLAwVB9M=;
        b=Ugr5RwE38W5uBH5t1utwjYiZ8jDnIiyL7AaG9g0Euj+NS0Ocao7zvXPp8HMy+Q8SNP
         2zJAy58CrBfMztNXV3Yjp1WbfbHN66gdRZWSyQoSPStT+pKQmmdhXN0GW7zSdpbePff3
         b79UYxVfgneD709s413gnVWw2Y568FWaC7ZSE4VZzE+bxYxyqnRBb+/L0t75IzyRi4p7
         +MQmD9GIMgakJE9UIig/szni5U3rSXmSkiH+2/qdHJVd0OBkq8rOoJ+Dx4Z3dbcwpUwm
         Vprtr9YWaON9whJVjJoegmCYC61Ia14URvTZ4Pm4iLqKBnMQ4r8MF0NWg+7paDO261Hr
         4BDw==
X-Gm-Message-State: AGi0PubIqDvzdcYVm8R+58NXTcluWa2uRf1r34//BEgTD9IbHUfVKTOJ
        unlEwB71DmSVWF8wC7uB3wGm6rVTv/TYVg==
X-Google-Smtp-Source: APiQypLaz0MJhFpNHXTXSn3LYY6czBEyM7F5ajNWVEnejkLJbEOHPeG/7XmloVReicWHrSZoQ+uO/A==
X-Received: by 2002:a1c:b757:: with SMTP id h84mr11480261wmf.188.1587279369849;
        Sat, 18 Apr 2020 23:56:09 -0700 (PDT)
Received: from net.saheed (5402C526.dsl.pool.telekom.hu. [84.2.197.38])
        by smtp.gmail.com with ESMTPSA id q184sm2295470wma.25.2020.04.18.23.56.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Apr 2020 23:56:09 -0700 (PDT)
Subject: Re: [PATCH] Replace -EINVAL with PCIBIOS_BAD_REGISTER_NUMBER
To:     Yicong Yang <yangyicong@hisilicon.com>,
        Bjorn Helgaas <helgaas@kernel.org>, bjorn@helgaas.com
Cc:     skhan@linuxfoundation.org, linux-pci@vger.kernel.org
References: <20200410202252.GA11837@google.com>
 <ec072da8-3dcb-2606-40ee-39e745311292@hisilicon.com>
From:   Saheed Bolarinwa <refactormyself@gmail.com>
Message-ID: <f348edfc-cecc-f732-833d-f99ca64d565c@gmail.com>
Date:   Sun, 19 Apr 2020 07:56:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <ec072da8-3dcb-2606-40ee-39e745311292@hisilicon.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Bjorn and Yicong

On 4/11/20 4:10 AM, Yicong Yang wrote:
> Hi Bjorn and Saheed,
>
> Callers use return value(most callers even don't check) of
> pcie_capability_{read,write}_*() I found lists below. some

In this patch I have focused only on pcie_capability_read_{word & dword}()

Do you think the consistency issue is of concern also with 
pcie_capability_write_*()?

> may directly print them to dmesg, others return the error
> codes to its caller. I think we should do the conversion in
> both condition.
>
> - pcie_speeds() in drivers/infiniband/hw/hfi1/pcie.c, line 306
> - amd_ntb_get_link_status() in drivers/ntb/hw/amd/ntb_hw_amd.c, line 216, line 233

Thank you Yicong for helping me with this. I have also search for 
functions that

either persist the return value of pcie_capability_read_*() or return it 
directly.

I have sent a RFC Patch with a report of my audit of the functions I 
found. I will

appreciate your comment.

- Saheed


> the probably change may look like:
>
>      ret = pcie_capability_{read, write}_*();
>      if (ret)
>          return pcibios_err_to_errno(ret);
>
> However, pci_{read, write}_config*() also have such problem, as they are also
> used widely outside pci driver and these drivers don't do the conversion. for example
> in arch/x86/platform/intel/iosf_mbi.c, iosf_mbi_pci_read_mdr() at line 39:
>
>      result = pci_read_config_dword();
>      if (result < 0)
>          goto fail_read;
>
> Seems it'll nevet get a failure result. Perhaps another patch is needed to solve these issues.
>
> AS PCIBIOS_* error code canbe *equivalent* to generic error code, why can't we
> directly use the generic ones? Considering of compatibility, maybe possible
> change will be like:
>
>      - #define PCIBIOS_FUNC_NOT_SUPPORTED 0X81
>      + #define PCIBIOS_FUNC_NOT_SUPPORTED -ENOENT
>      ......
>
> and pcibios_err_to_errno() is not neccessary any more.
>
> I don't know why we didn't use generic error code and define positive private errors.
> Please tell me if there is any background.
>
> Regards,
> Yicong
>
>
> On 2020/4/11 4:22, Bjorn Helgaas wrote:
>> On Fri, Apr 10, 2020 at 09:28:07AM +0800, Yicong Yang wrote:
>>> Hi Bolarinwa,
>>>
>>> I notice some drivers use these functions and if there is an error,
>>> pass the error code directly to the userspace. As it's our private
>>> error code, is it appropriate to pass or should we call
>>> pcibios_err_to_errno()(include/linux/pci.h, line 672) to do the
>>> conversion?
>> The whole point of this is to make the return values of the
>> pcie_capability_{read,write,etc}*() functions work the same as
>> the pci_{read,write}_config*() functions.
>>
>> The latter return PCIBIOS_* error codes, so the former should as well.
>>
>> When we do this, we do need to audit every caller of the
>> pcie_capability_{read,write}*() functions to make sure we don't break
>> them.  If some callers pass the error code directly to userspace, they
>> may need some change.
>>
>> Yicong, can you point to the ones you noticed so Saheed can check them
>> out?
>>
>> Bjorn
>>
>>> On 2020/4/10 0:16, Bolarinwa Olayemi Saheed wrote:
>>>> Signed-off-by: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
>>>> Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
>>>> ---
>>>>   drivers/pci/access.c | 4 ++--
>>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
>>>> index 79c4a2ef269a..451f2b8b2b3c 100644
>>>> --- a/drivers/pci/access.c
>>>> +++ b/drivers/pci/access.c
>>>> @@ -409,7 +409,7 @@ int pcie_capability_read_word(struct pci_dev *dev, int pos, u16 *val)
>>>>   
>>>>   	*val = 0;
>>>>   	if (pos & 1)
>>>> -		return -EINVAL;
>>>> +		return PCIBIOS_BAD_REGISTER_NUMBER;
>>>>   
>>>>   	if (pcie_capability_reg_implemented(dev, pos)) {
>>>>   		ret = pci_read_config_word(dev, pci_pcie_cap(dev) + pos, val);
>>>> @@ -444,7 +444,7 @@ int pcie_capability_read_dword(struct pci_dev *dev, int pos, u32 *val)
>>>>   
>>>>   	*val = 0;
>>>>   	if (pos & 3)
>>>> -		return -EINVAL;
>>>> +		return PCIBIOS_BAD_REGISTER_NUMBER;
>>>>   
>>>>   	if (pcie_capability_reg_implemented(dev, pos)) {
>>>>   		ret = pci_read_config_dword(dev, pci_pcie_cap(dev) + pos, val);
>> .
>>
