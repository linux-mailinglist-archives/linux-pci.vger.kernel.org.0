Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A24224E28D
	for <lists+linux-pci@lfdr.de>; Fri, 21 Aug 2020 23:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgHUVTa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Aug 2020 17:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbgHUVTa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Aug 2020 17:19:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54CBC061573;
        Fri, 21 Aug 2020 14:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=37T7GQJUOK9B+odqXgAli8PfC+aoalYh8vt1CB0b6Ic=; b=hK/2065/gMlYkrpQ4mvh8jTJt7
        fp8VSlgvjOVqfBL60nNipkyLTEvzVih8LDbHb6mHdNE0PyocwG+7Mbu9xY/uQFGYF90k2TdBp3Scm
        yIZhfbbBxMPpcFGXqx4P1YdLu7jCclE9MlqSvwEwsomXZriikdmNGw1T+IX/WprgtjKSwMyf/ED5w
        TSOyBBoNROARGBPioj4dOy5rpJnwvur2oLsxwDK8c2bQVMSNf3SU8gmcMnEQu2duDLmpMbNpftWWq
        99xjPGO7B1p/vLnoN8DPsafT2UJ/Pjih/F5uY3pK88gVj4unORjJzlacr44p/7VpcwGEGq2Ion3ht
        XmrcfjaA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k9ERa-0003sJ-5y; Fri, 21 Aug 2020 21:19:26 +0000
Subject: Re: [PATCH] x86/pci: don't set acpi stuff if !CONFIG_ACPI
To:     Adam Borowski <kilobyte@angband.pl>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-pci@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <len.brown@intel.com>
References: <20200820125320.9967-1-kilobyte@angband.pl>
 <87y2m7rc4a.fsf@nanos.tec.linutronix.de> <20200821203232.GA2187@angband.pl>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <85e70752-8034-ab95-f6b4-018c7086edad@infradead.org>
Date:   Fri, 21 Aug 2020 14:19:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200821203232.GA2187@angband.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 8/21/20 1:32 PM, Adam Borowski wrote:
> On Fri, Aug 21, 2020 at 10:13:25PM +0200, Thomas Gleixner wrote:
>> On Thu, Aug 20 2020 at 14:53, Adam Borowski wrote:
>>> Found by randconfig builds.
>>>
>>>  arch/x86/pci/intel_mid_pci.c | 2 ++
>>>  arch/x86/pci/xen.c           | 2 ++
> 
>>> --- a/arch/x86/pci/intel_mid_pci.c
>>> +++ b/arch/x86/pci/intel_mid_pci.c
>>> @@ -299,8 +299,10 @@ int __init intel_mid_pci_init(void)
>>> +#ifdef CONFIG_ACPI
>>>  	/* Continue with standard init */
>>>  	acpi_noirq_set();
>>> +#endif
> 
>> If CONFIG_ACPI=n then acpi_noirq_set() is an empty stub inline. So I'm
>> not sure what you are trying to solve here.
>>
>> Ah, I see with CONFIG_ACPI=n linux/acpi.h does not include asm/acpi.h so
>> the stubs are unreachable. So that needs to be fixed and not papered
>> over with #ifdeffery
> 
> If I understand Randy Dunlap correctly, he already sent a pair of patches
> that do what you want.

I did, but I sent them to the Xen and PCI maintainers,
not the x86 maintainers, but I will happily resend this patch.
The Xen patch has already been applied whereas the patch
to intel_mid_pci.c is in limbo. :(

Thomas, do you want me to send it to you/X86 people?
(with 2 Reviewed-by: additions)

thanks.
-- 
~Randy

