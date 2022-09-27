Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3868C5EC4B8
	for <lists+linux-pci@lfdr.de>; Tue, 27 Sep 2022 15:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbiI0NlX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Sep 2022 09:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231923AbiI0NlV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Sep 2022 09:41:21 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15F25E66C
        for <linux-pci@vger.kernel.org>; Tue, 27 Sep 2022 06:41:18 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id q35-20020a17090a752600b002038d8a68fbso15646921pjk.0
        for <linux-pci@vger.kernel.org>; Tue, 27 Sep 2022 06:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=4pzwYFff+/gp6imXGz+Xr/QW1tSB5Pck/AS91fsmU3k=;
        b=LePq5aNygaRO4JwWo4786w9RJBPiOvEJaaocpUnMfXBoPwzGPk2aH8F8r0Y192UysC
         /GVZyqPuEod63zVf/SLGKIbUrkaA1NHkdRx5Ihl8zSriN6TdOCVIqyAOEWdTeu9SEJRm
         zVlJiU5ca/DSoQoraxCyph66is6b6yPPfVDrIOQX1R2GboUsqZXSN9giX+ystSq6zU+e
         OpFstFBRjZX66JhUETQen00Nqpf2MnEK2uhahuwX5CrCMMekAjTst7VBZrvM2mOVNWPu
         +cy5+6fA0vS8uG5yYR50nl8aenZjMrkYrvaFwhjmN9+DYFoG0v9UAN/K7Iu39dqeOnPp
         SjZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=4pzwYFff+/gp6imXGz+Xr/QW1tSB5Pck/AS91fsmU3k=;
        b=7PhMpK66kauZgzh+BK06y3h1akViRA1sjgO2c02RyoRgWOlWcgM3tgHYAXeb9pKAqf
         fRwermMFbCbpn/tzbknRKdiqCpXAVOYreXzjDAGxqtFKRsTszMGzBXOwydT+vH+w5AmA
         HEBr+CQF/o2bumrIfmrcM/SvBVJa5zK5s1XTngs6XXDchloaO9jxaWKHILKA6enKtMKY
         hFFskXxuuNg1JYjo+SVV2KW6BbrwGp5vDM+XB8rN7mzVswOv7HIzFsS9R1q+xCitdkOD
         eSkJabul4jZfQXDbAAbNsbxz3EV2+ZrRzhaK7EGLbo8jIvGIC/Wlc4N2+ENr4HA2pM87
         8DCA==
X-Gm-Message-State: ACrzQf1f5v76pOMcKv6yAWkaj/lKKVFIOg6xtZXEzT7UsuGKFPqiyCL7
        6HzCE66q/0UKv9yxGSetF7lV0A==
X-Google-Smtp-Source: AMsMyM77LunLFCmKosQx6Onu7WC4eGvOAvGGQe2jOricoTl6inaR33JtDw1CPTh3n9Pc1Mv0wYQf5g==
X-Received: by 2002:a17:90a:3f89:b0:205:a54e:2db8 with SMTP id m9-20020a17090a3f8900b00205a54e2db8mr4622868pjc.36.1664286078324;
        Tue, 27 Sep 2022 06:41:18 -0700 (PDT)
Received: from [10.2.223.68] ([61.120.150.77])
        by smtp.gmail.com with ESMTPSA id n16-20020a634d50000000b0042c0ffa0e62sm1516141pgl.47.2022.09.27.06.41.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 06:41:17 -0700 (PDT)
Message-ID: <97ac6c82-81a0-2f63-7d8f-e56d702bc874@bytedance.com>
Date:   Tue, 27 Sep 2022 21:41:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.0
Subject: Re: [External] Re: [PATCH 2/3] PCI/ERR: Clear fatal status in
 pcie_do_recovery()
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     allenbh@gmail.com, dave.jiang@intel.com,
        linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        linux-pci@vger.kernel.org, jejb@linux.ibm.com, jdmason@kudzu.us,
        james.smart@broadcom.com, fancer.lancer@gmail.com,
        linux-kernel@vger.kernel.org, ntb@lists.linux.dev,
        oohall@gmail.com, bhelgaas@google.com, dick.kennedy@broadcom.com,
        linuxppc-dev@lists.ozlabs.org
References: <20220926180906.GA1609498@bhelgaas>
From:   Zhuo Chen <chenzhuo.1@bytedance.com>
In-Reply-To: <20220926180906.GA1609498@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 9/27/22 2:09 AM, Bjorn Helgaas wrote:
> On Mon, Sep 26, 2022 at 10:01:55PM +0800, Zhuo Chen wrote:
>> On 9/23/22 5:08 AM, Bjorn Helgaas wrote:
>>> On Fri, Sep 02, 2022 at 02:16:33AM +0800, Zhuo Chen wrote:
>>>> When state is pci_channel_io_frozen in pcie_do_recovery(),
>>>> the severity is fatal and fatal status should be cleared.
>>>> So we add pci_aer_clear_fatal_status().
>>>
>>> Seems sensible to me.  Did you find this by code inspection or by
>>> debugging a problem?  If the latter, it would be nice to mention the
>>> symptoms of the problem in the commit log.
>>
>> I found this by code inspection so I may not enumerate what kind of problems
>> this code will cause.
>>>
>>>> Since pcie_aer_is_native() in pci_aer_clear_fatal_status()
>>>> and pci_aer_clear_nonfatal_status() contains the function of
>>>> 'if (host->native_aer || pcie_ports_native)', so we move them
>>>> out of it.
>>>
>>> Wrap commit log to fill 75 columns.
>>>
>>>> Signed-off-by: Zhuo Chen <chenzhuo.1@bytedance.com>
>>>> ---
>>>>    drivers/pci/pcie/err.c | 8 ++++++--
>>>>    1 file changed, 6 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
>>>> index 0c5a143025af..e0a8ade4c3fe 100644
>>>> --- a/drivers/pci/pcie/err.c
>>>> +++ b/drivers/pci/pcie/err.c
>>>> @@ -243,10 +243,14 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>>>>    	 * it is responsible for clearing this status.  In that case, the
>>>>    	 * signaling device may not even be visible to the OS.
>>>>    	 */
>>>> -	if (host->native_aer || pcie_ports_native) {
>>>> +	if (host->native_aer || pcie_ports_native)
>>>>    		pcie_clear_device_status(dev);
>>>
>>> pcie_clear_device_status() doesn't check for pcie_aer_is_native()
>>> internally, but after 068c29a248b6 ("PCI/ERR: Clear PCIe Device Status
>>> errors only if OS owns AER") and aa344bc8b727 ("PCI/ERR: Clear AER
>>> status only when we control AER"), both callers check before calling
>>> it.
>>>
>>> I think we should move the check inside pcie_clear_device_status().
>>> That could be a separate preliminary patch.
>>>
>>> There are a couple other places (aer_root_reset() and
>>> get_port_device_capability()) that do the same check and could be
>>> changed to use pcie_aer_is_native() instead.  That could be another
>>> preliminary patch.
>>>
>> Good suggestion. But I have only one doubt. In aer_root_reset(), if we use
>> "if (pcie_aer_is_native(dev) && aer)", when dev->aer_cap
>> is NULL and root->aer_cap is not NULL, pcie_aer_is_native() will return
>> false. It's different from just using "(host->native_aer ||
>> pcie_ports_native)".
>> Or if we can use "if (pcie_aer_is_native(root))", at this time a NULL
>> pointer check should be added in pcie_aer_is_native() because root may be
>> NULL.
> 
> Good point.  In aer_root_reset(), we're updating Root Port registers,
> so I think they should look like:
> 
>    if (pcie_aer_is_native(root) && aer) {
>      ...
>    }
> 
> Does that seem safe and equivalent to you?
> 
> Bjorn

I think ‘if (aer && pcie_aer_is_native(root))’ might be safer,
because when root is NULL, 'aer' will be NUll as well, and the
predicate will return false without entering pcie_aer_is_native(root).


-- 
Thanks,
Zhuo Chen
