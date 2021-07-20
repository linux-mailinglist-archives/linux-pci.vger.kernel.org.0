Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3713D0451
	for <lists+linux-pci@lfdr.de>; Wed, 21 Jul 2021 00:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbhGTVa5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Jul 2021 17:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232729AbhGTVaq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Jul 2021 17:30:46 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F66FC0613E4
        for <linux-pci@vger.kernel.org>; Tue, 20 Jul 2021 15:11:10 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id y66so820526oie.7
        for <linux-pci@vger.kernel.org>; Tue, 20 Jul 2021 15:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QDjuN8hS5kPSCLMuKND95kRAyOUhcK7K+eQw+lVnAdg=;
        b=hVcjYp++6ofMzxEIAFJgs5cdcBkSrN6C38ndc4GHpA8WV04NLWDY2zXSds4zOodSNw
         kK4XxMbH3d+E8M9N2iNC2Wx0m9Ywx5nloD5ex0MydZiWvruGb5mJiCppUT4JgziosBN7
         ODBqIOcU9JnlKSaLVbTZUz/wF8JsKZ7FzD87chiopq7yzr0Lzretw97c+gTD+VLkFg04
         ZJVOjOjw3p+GZC59LSVni3son2zdqXmU6Hs2bkzHyRlcyDMhKbXSAz9AILR/9aeK+HXF
         nv3k7LdWBBlNOXY0sLa47TpZFtPFUP0Fz3R7+8yWZK9X2d40rFPU5OQFcsKqEueO3EwZ
         aYbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QDjuN8hS5kPSCLMuKND95kRAyOUhcK7K+eQw+lVnAdg=;
        b=j6bpMZpMyzU3k9VpJVwq5yPRo/ySp+83qf3RY/pvyHFsFyFKfBnhdibjksXXQ2PzZ6
         ILdE+RpRUqS2A8OzVy1ZYflXYfqRsm/H9eebqc82KVFJVhwHhXMAUBrynNIFtN1AjVI8
         UvZx2qTUHL63Z8LKMcegepD/h8YisKfj+mT4dAnytEP79sq0NZTcJv5w7m1aJXYTgP75
         rlWrxnfi8Agz37YdmFrTmNuyrw/oDLYRvPFrE/WyEZT9eAzgfBQh14E5c0DMlzPdA5ou
         CquhmR+2vmjl/YwPOAOGfiA5DbgDqcTXipF/1RRVsmYpczTMDRV/FmEZZwRjlfz1lvFW
         /Xcg==
X-Gm-Message-State: AOAM531vJg2KvdLqpcsVswSyVRDSIW/eO1w5jt79SZp15LrTHkfFkCio
        JwF9KRz8cdcTSwu0H6EIW4s=
X-Google-Smtp-Source: ABdhPJxBkVacKoYW87GdUD4ejmAjdpSIClFMMqdSsIoOsMK95xV/63A+YlkMmSUedD6xn69PdbDu6g==
X-Received: by 2002:aca:6704:: with SMTP id z4mr492559oix.13.1626819069698;
        Tue, 20 Jul 2021 15:11:09 -0700 (PDT)
Received: from ?IPv6:2603:8081:2802:9dfb:49b3:8e2:3d6d:26c8? (2603-8081-2802-9dfb-49b3-08e2-3d6d-26c8.res6.spectrum.com. [2603:8081:2802:9dfb:49b3:8e2:3d6d:26c8])
        by smtp.gmail.com with ESMTPSA id 3sm4126813oob.1.2021.07.20.15.11.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jul 2021 15:11:09 -0700 (PDT)
Subject: Re: [PATCH v2] PCI: pciehp: Ignore Link Down/Up caused by DPC
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ethan Zhao <haifeng.zhao@intel.com>,
        Sinan Kaya <okaya@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <kbusch@kernel.org>,
        Yicong Yang <yangyicong@hisilicon.com>,
        linux-pci@vger.kernel.org, Russell Currey <ruscur@russell.cc>,
        Oliver OHalloran <oohall@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
References: <0be565d97438fe2a6d57354b3aa4e8626952a00b.1619857124.git.lukas@wunner.de>
 <20210616221945.GA3010216@bjorn-Precision-5520>
 <20210620073804.GA13118@wunner.de>
 <08c046b0-c9f2-3489-eeef-7e7aca435bb9@gmail.com>
 <20210719151011.GA25258@wunner.de>
 <a70a936d-d031-7199-4ed7-30753b3e7cfa@gmail.com>
 <20210720065718.GA21556@wunner.de>
From:   stuart hayes <stuart.w.hayes@gmail.com>
Message-ID: <f092c1fd-17fb-9714-ec09-9e5513364a2b@gmail.com>
Date:   Tue, 20 Jul 2021 17:11:07 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210720065718.GA21556@wunner.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 7/20/2021 1:57 AM, Lukas Wunner wrote:
> On Mon, Jul 19, 2021 at 02:00:51PM -0500, stuart hayes wrote:
>> On 7/19/2021 10:10 AM, Lukas Wunner wrote:
>>> Could you test if the below patch fixes the issue?
>>
>> That does appear to fix the issue, thanks!  Without your patch, the PCIe
>> devices under 64:02.0 disappear (the triggered bit is still set in the DPC
>> capability).  With your patch, recovery is successful and all of the PCIe
>> devices are still there.
> 
> Thanks for testing.
> 
> The test patch clears DLLSC because the Hot Reset that is propagated
> down the hierarchy causes the link to flap.  I'm wondering though if
> that's sufficient or if PDC needs to be cleared as well.  According
> to PCIe Base Spec sec. 4.2.6, LTSSM transitions from "Hot Reset" state
> to "Detect", then "Polling".  If I understand the table "Link Status
> Mapped to the LTSSM" in the spec correctly, in-band presence is 0b
> in Detect state, hence I'd expect PDC to flap as well as a result of
> a Hot Reset being propagated down the hierarchy.
> 

I think the table "Link Status Mapped to the LTSSM" is saying that when 
in-band presence is 0, the LTSSM state must be "Detect" (not that being 
in "Detect" will force in-band presence to zero).

I would not expect PDC to flap since the presence detect (even in-band) 
should not go away during hot reset.

On the system I'm using, I modified the kernel to read and print the 
slot status register right before your test patch clears DLLSC, and it 
reads 0x140 (link status changed, presence is detected, but PDC is not set).

> Does the hotplug port at 0000:68:00.0 support In-Band Presence Disable?
> That would explain why only clearing DLLSC is sufficient.
> 

No... the slot capabilities 2 register is 0.

> The problem is, if PDC is cleared as well, we lose the ability to
> detect that a device was hot-removed while the reset was ongoing,
> which is unfortunate.
> 

Agreed, but I don't think PDC should get set on hot reset.

> If an error is handled by aer_root_reset() (instead of dpc_reset_link())
> and the reset is performed at a hotplug port, then pciehp_reset_slot()
> is invoked:
> 
> aer_root_reset()
>    pci_bus_error_reset()
>      pci_slot_reset()
>        pci_reset_hotplug_slot()
>          pciehp_reset_slot()
> 
> pciehp_reset_slot() temporarily masks both DLLSC *and* PDC events,
> then performs a Secondary Bus Reset at the hotplug port.
> 
> If there are further hotplug ports below that hotplug port
> where the SBR is performed, my expectation is that the Hot Reset
> is likewise propagated down the hierarchy (just as with DPC),
> so those cascaded hotplug ports should also see their link go down.
> 
> In other words, the issue you're seeing isn't really DPC-specific.
> However, the test patch should fix the issue for AER-handled errors
> as well.  Do you agree with this analysis or did I miss anything?
> 

That looks correct to me.

> Thanks,
> 
> Lukas
> 
