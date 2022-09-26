Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104B95EAA10
	for <lists+linux-pci@lfdr.de>; Mon, 26 Sep 2022 17:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236019AbiIZPRH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Sep 2022 11:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235398AbiIZPQg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Sep 2022 11:16:36 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03A51CB37
        for <linux-pci@vger.kernel.org>; Mon, 26 Sep 2022 07:02:04 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id r62so2802646pgr.12
        for <linux-pci@vger.kernel.org>; Mon, 26 Sep 2022 07:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=1yGPnS7+tabIF9f3YGZrIJUzZlCgUowefj3Ak6tgbc8=;
        b=Cml+idqKmgZLlpiIB8rfPG/ng2lFM3Uc9sHJGoyFG7EKF7hZNke7PI/XfWak9pHRFi
         efod9Ah4zEqgORi+dMraA2Sbgo/pbkOsElfL2aD04OOna/C7XRrRxw0DfgIIfFkuQBtl
         cmmg93A0HBEzFfB1+OSXJZfXPeyzl0IgyhatrNNxgm2ohJf5RdnnNFXZNdgo7YaW0/yv
         LuuQM2kgG/3u1LhXdaEb1jXfGr5iRHnQ+eWfqiHMVUElxVxahOJVNf9IRTzA3BIZLfv3
         zqpVrMthiVdLVBUkfIC5c7/0nUDogIn6jR/lCahdK1UXLrg6UQyGo+qF4+waB/51xAs+
         2x6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=1yGPnS7+tabIF9f3YGZrIJUzZlCgUowefj3Ak6tgbc8=;
        b=vufBmB7vZ4IPz1oAxhNoYDd3q2KJ9xfzrwc8GuL+fGcLMdn3xOg/5b0uxjlYPvcxqV
         nuMYxdGN5VaKt883l7y4WdpKOlCzsn6teWkox85u+oMdKlgQYLYQj4+MvBe223hdt0+5
         kV9aMF2DWXKGdx2L37UWCXrD+cSINRtV1ZGDFhjeaAYFznSGY+eKEoTL5Fadkgc7F9lH
         NxbLuqG/92i2D64VdWjH5n3b7OP0+AGxhY2NcYDYXd1LEO4lYBRaTIdC3vESE58bFHot
         NXqpJo6ESG+Ort8F3w+C2zs19ADcX9yqptXO1SZDjNP1SXnh+JK3z2CeSI1QPkkHKGgV
         hSEA==
X-Gm-Message-State: ACrzQf1GMCtBz7IC4Da8Sot0Jv/NNMFO7jylluFOOufPizuvFzov9SPY
        wjfonoDXjHU6p0WcBiera+RoMg==
X-Google-Smtp-Source: AMsMyM56mNVNCK934eTJEzhPKz0Kgne9owdo04+/JMJy5BNbxI/i4itBQ3mjMLHU+WUWOj1bBuUPqA==
X-Received: by 2002:aa7:9f0c:0:b0:546:c556:ac86 with SMTP id g12-20020aa79f0c000000b00546c556ac86mr23732346pfr.55.1664200924322;
        Mon, 26 Sep 2022 07:02:04 -0700 (PDT)
Received: from [10.2.223.68] ([61.120.150.77])
        by smtp.gmail.com with ESMTPSA id b15-20020a63d30f000000b004393cb720afsm10769098pgg.38.2022.09.26.07.01.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 07:02:03 -0700 (PDT)
Message-ID: <1de80c28-33ec-b1bd-a557-91e4166d2da7@bytedance.com>
Date:   Mon, 26 Sep 2022 22:01:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.0
Subject: Re: [PATCH 2/3] PCI/ERR: Clear fatal status in pcie_do_recovery()
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     fancer.lancer@gmail.com, jdmason@kudzu.us, dave.jiang@intel.com,
        allenbh@gmail.com, bhelgaas@google.com, ruscur@russell.cc,
        oohall@gmail.com, james.smart@broadcom.com,
        dick.kennedy@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntb@lists.linux.dev, linuxppc-dev@lists.ozlabs.org
References: <20220922210853.GA1335665@bhelgaas>
From:   Zhuo Chen <chenzhuo.1@bytedance.com>
In-Reply-To: <20220922210853.GA1335665@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 9/23/22 5:08 AM, Bjorn Helgaas wrote:
> On Fri, Sep 02, 2022 at 02:16:33AM +0800, Zhuo Chen wrote:
>> When state is pci_channel_io_frozen in pcie_do_recovery(),
>> the severity is fatal and fatal status should be cleared.
>> So we add pci_aer_clear_fatal_status().
> 
> Seems sensible to me.  Did you find this by code inspection or by
> debugging a problem?  If the latter, it would be nice to mention the
> symptoms of the problem in the commit log.

I found this by code inspection so I may not enumerate what kind of 
problems this code will cause.
> 
>> Since pcie_aer_is_native() in pci_aer_clear_fatal_status()
>> and pci_aer_clear_nonfatal_status() contains the function of
>> 'if (host->native_aer || pcie_ports_native)', so we move them
>> out of it.
> 
> Wrap commit log to fill 75 columns.
> 
>> Signed-off-by: Zhuo Chen <chenzhuo.1@bytedance.com>
>> ---
>>   drivers/pci/pcie/err.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
>> index 0c5a143025af..e0a8ade4c3fe 100644
>> --- a/drivers/pci/pcie/err.c
>> +++ b/drivers/pci/pcie/err.c
>> @@ -243,10 +243,14 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>>   	 * it is responsible for clearing this status.  In that case, the
>>   	 * signaling device may not even be visible to the OS.
>>   	 */
>> -	if (host->native_aer || pcie_ports_native) {
>> +	if (host->native_aer || pcie_ports_native)
>>   		pcie_clear_device_status(dev);
> 
> pcie_clear_device_status() doesn't check for pcie_aer_is_native()
> internally, but after 068c29a248b6 ("PCI/ERR: Clear PCIe Device Status
> errors only if OS owns AER") and aa344bc8b727 ("PCI/ERR: Clear AER
> status only when we control AER"), both callers check before calling
> it.
> 
> I think we should move the check inside pcie_clear_device_status().
> That could be a separate preliminary patch.
> 
> There are a couple other places (aer_root_reset() and
> get_port_device_capability()) that do the same check and could be
> changed to use pcie_aer_is_native() instead.  That could be another
> preliminary patch.
> 
Good suggestion. But I have only one doubt. In aer_root_reset(), if we 
use "if (pcie_aer_is_native(dev) && aer)", when dev->aer_cap
is NULL and root->aer_cap is not NULL, pcie_aer_is_native() will return 
false. It's different from just using "(host->native_aer ||
pcie_ports_native)".
Or if we can use "if (pcie_aer_is_native(root))", at this time a NULL 
pointer check should be added in pcie_aer_is_native() because root may 
be NULL.

> 
>> +	if (state == pci_channel_io_frozen)
>> +		pci_aer_clear_fatal_status(dev);
>> +	else
>>   		pci_aer_clear_nonfatal_status(dev);
>> -	}
>> +
>>   	pci_info(bridge, "device recovery successful\n");
>>   	return status;
>>   
>> -- 
>> 2.30.1 (Apple Git-130)
>>

-- 
Thanks,
Zhuo Chen
