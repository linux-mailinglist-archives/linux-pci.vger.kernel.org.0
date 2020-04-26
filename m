Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 744B01B8F23
	for <lists+linux-pci@lfdr.de>; Sun, 26 Apr 2020 12:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgDZKvU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 26 Apr 2020 06:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726125AbgDZKvU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 26 Apr 2020 06:51:20 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C316BC061A0C
        for <linux-pci@vger.kernel.org>; Sun, 26 Apr 2020 03:51:19 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x17so16244012wrt.5
        for <linux-pci@vger.kernel.org>; Sun, 26 Apr 2020 03:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=R0pU3luVXl4howr3W2t9DubPkMZpdZBK7T5ALJY+iSM=;
        b=ikMJC5n787RSS2bZe4VhFQgDB/6oWpsDovApGl8kcSHcxDSVFU+GBA1AqMSRk0C/89
         5lL3kRns+YgC9BkNYQ6Yp3bmrdx9P2W5S/DaCPFjsu+iCgskNeoH7OYv3SKPGfOvwrXZ
         dL1ZAyFT2Z2mllUDKUc+L5delHrEKe0GSL6hfqM2N6zNxKkQjwt4aCgulLlIxhC5PGcX
         MP8Utrw+JTOcCTQGb55jxkrduUz4k5eVcURqlQHSRcbUq6gifJJK85+u1v8Yc6EIGaro
         bWpHURcMn96j1qFczYHLG7INM08YTW/IRFjs179MYfI2BtYwcxN5ldHHz2itTbsQ5Mfs
         6WtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=R0pU3luVXl4howr3W2t9DubPkMZpdZBK7T5ALJY+iSM=;
        b=gDrXd//uL9TcKiF6Qher0dU/4aUCONuCCDXSE+5gwKksNxf/AZFB+k9H88s9RNVv19
         +OpDNzuVlx/eOWIqmRm1aAHvePWeyT+77imXF8J9rhxzqUnlVn9GIMpZ8MOww1aoU9cz
         oVsEjafiZuzBUodMptjF9WaO6XdPD6jj1y4WhVh4etHB5mwRYeR/VxXZm6W0DDCzoa5W
         vJ/G45mV6BmxNUOSQMyohmIvio+RbW5mJtRmVRhB6/LYls+Yl2znVL4knQMQqJqBf/Hb
         H1lVFECqH/xEZIy6ULoTDsOxHXIFRWqVE/HcrFHnFqq1PHcEsaLMvp6JCgCg/A4OJuTA
         tFAw==
X-Gm-Message-State: AGi0PuZtR8Ac1UE9BU/nXO2abS6tVPI9GoDa8BPRThOiGZdfqWnnQgK0
        FeY2L8RXHbSagxDGvUL1CDZDqEYvH7s1Fw==
X-Google-Smtp-Source: APiQypJgCuGXqxOHqhUSFbRoMsLnsk2tuEZEz5kJgtkaRnc5EjifruhptfI9+2Cex0YdbdTTagTDbQ==
X-Received: by 2002:adf:9d8d:: with SMTP id p13mr21178286wre.17.1587898278030;
        Sun, 26 Apr 2020 03:51:18 -0700 (PDT)
Received: from net.saheed (563BD1A4.dsl.pool.telekom.hu. [86.59.209.164])
        by smtp.gmail.com with ESMTPSA id 185sm12804761wmc.32.2020.04.26.03.51.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Apr 2020 03:51:17 -0700 (PDT)
Subject: Re: [PATCH v4] pci: Make return value of pcie_capability_read*()
 consistent
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bjorn@helgaas.com, yangyicong@hisilicon.com,
        skhan@linuxfoundation.org, linux-pci@vger.kernel.org
References: <20200424223044.GA211293@google.com>
From:   Saheed Bolarinwa <refactormyself@gmail.com>
Message-ID: <c9811866-8fea-9398-9337-45818136fe84@gmail.com>
Date:   Sun, 26 Apr 2020 11:51:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200424223044.GA211293@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Bjorn,

On 4/25/20 12:30 AM, Bjorn Helgaas wrote:
> Hi Saheed,
>
> On Fri, Apr 24, 2020 at 04:27:11PM +0200, Bolarinwa Olayemi Saheed wrote:
>> pcie_capability_read*() could return 0, -EINVAL, or any of the
>> PCIBIOS_* error codes (which are positive).
>> This is behaviour is now changed to return only PCIBIOS_* error
>> codes on error.
>> This is consistent with pci_read_config_*(). Callers can now have
>> a consistent way for checking which error has occurred.
>>
>> An audit of the callers of this function was made and no case was found
>> where there is need for a change within the caller function or their
>> dependencies down the heirarchy.
>> Out of all caller functions discovered only 8 functions either persist the
>> return value of pcie_capability_read*() or directly pass on the return
>> value.
>>
>> 1.) "./drivers/infiniband/hw/hfi1/pcie.c" :
>> => pcie_speeds() line-306
>>
>> 	if (ret) {
>> 		dd_dev_err(dd, "Unable to read from PCI config\n");
>> 		return ret;
>> 	}
>>
>> remarks: The variable "ret" is the captured return value.
>>           This function passes on the return value. The return value was
>> 	 store only by hfi1_init_dd() line-15076 in
>>           ./drivers/infiniband/hw/hfi1/chip.c and it behave the same on all
>> 	 errors. So this patch will not require a change in this function.
> Thanks for the analysis, but I don't think it's quite complete.
> Here's the call chain I see:
>
>    local_pci_probe
>      pci_drv->probe(..)
>        init_one                        # hfi1_pci_driver.probe method
>          hfi1_init_dd
>            pcie_speeds
>              pcie_capability_read_dword

Thank you for pointing out the call chain. After checking it, I noticed 
that the

error is handled within the chain in two places without being passed on.

1. init_one() in ./drivers/infiniband/hw/hfil1/init.c

      ret = hfi1_init_dd(dd);
             if (ret)
                     goto clean_bail; /* error already printed */

    ...
    clean_bail:
             hfi1_pcie_cleanup(pdev);  /*EXITS*/

2. hfi1_init_dd() in ./drivers/infiniband/hw/hfil1/chip.c

         ret = pcie_speeds(dd);
         if (ret)
                 goto bail_cleanup;

         ...

         bail_cleanup:
                  hfi1_pcie_ddcleanup(dd);  /*EXITS*/

> If pcie_capability_read_dword() returns any non-zero value, that value
> propagates all the way up and is eventually returned by init_one().
> init_one() id called by local_pci_probe(), which interprets:
>
>    < 0 as failure
>      0 as success, and
>    > 0 as "success but warn"
>
> So previously an error from pcie_capability_read_dword() could cause
> either failure or "success but warn" for the probe method, and after
> this patch those errors will always cause "success but warn".
>
> The current behavior is definitely a bug: if
> pci_bus_read_config_word() returns PCIBIOS_BAD_REGISTER_NUMBER, that
> causes pcie_capability_read_dword() to also return
> PCIBIOS_BAD_REGISTER_NUMBER, which will lead to the probe succeeding
> with a warning, when it should fail.
>
> I think the fix is to make pcie_speeds() call pcibios_err_to_errno():
>
>    ret = pcie_capability_read_dword(...);
>    if (ret) {
>      dd_dev_err(...);
>      return pcibios_err_to_errno(ret);
>    }

I agree that this fix is needed, so that PCIBIOS_* error code are not 
passed on but replaced

with one consistent with non-PCI error codes.

> That could be its own separate preparatory patch before this
> adjustment to pcie_capability_read_dword().
>
> I didn't look at the other cases below, so I don't know whether they
> are similar hidden problems.

I will check again, please I will like to clarify if it will be to fine 
to just implement the conversion

(as suggested for pcie_speeds) in all found references, which passes on 
the error code.

>
>> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
>> index 79c4a2ef269a..f0baab635b66 100644
>> --- a/drivers/pci/access.c
>> +++ b/drivers/pci/access.c
>> @@ -402,6 +402,10 @@ static bool pcie_capability_reg_implemented(struct pci_dev *dev, int pos)
>>    * Note that these accessor functions are only for the "PCI Express
>>    * Capability" (see PCIe spec r3.0, sec 7.8).  They do not apply to the
>>    * other "PCI Express Extended Capabilities" (AER, VC, ACS, MFVC, etc.)
>> + *
>> + * On error, this function returns a PCIBIOS_* error code,
>> + * you may want to use pcibios_err_to_errno()(include/linux/pci.h)
>> + * to convert to a non-PCI code.
>>    */
>>   int pcie_capability_read_word(struct pci_dev *dev, int pos, u16 *val)
>>   {
>> @@ -409,7 +413,7 @@ int pcie_capability_read_word(struct pci_dev *dev, int pos, u16 *val)
>>   
>>   	*val = 0;
>>   	if (pos & 1)
>> -		return -EINVAL;
>> +		return PCIBIOS_BAD_REGISTER_NUMBER;
>>   
>>   	if (pcie_capability_reg_implemented(dev, pos)) {
>>   		ret = pci_read_config_word(dev, pci_pcie_cap(dev) + pos, val);
>> @@ -444,7 +448,7 @@ int pcie_capability_read_dword(struct pci_dev *dev, int pos, u32 *val)
>>   
>>   	*val = 0;
>>   	if (pos & 3)
>> -		return -EINVAL;
>> +		return PCIBIOS_BAD_REGISTER_NUMBER;
>>   
>>   	if (pcie_capability_reg_implemented(dev, pos)) {
>>   		ret = pci_read_config_dword(dev, pci_pcie_cap(dev) + pos, val);
> We need to make similar changes to pcie_capability_write_word() and
> pcie_capability_write_dword(), of course.  I think it makes sense to
> do them all in the same patch, since it's logically the same change
> and all these functions should be consistent with each other.

I will include them in.

Thank you.

- Saheed

