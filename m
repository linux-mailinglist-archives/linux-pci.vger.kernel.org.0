Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60F1A24AD8D
	for <lists+linux-pci@lfdr.de>; Thu, 20 Aug 2020 06:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725468AbgHTEIH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Aug 2020 00:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbgHTEIG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Aug 2020 00:08:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FF1C061757;
        Wed, 19 Aug 2020 21:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=WmtpAyrOA4FNl/DzMNF6BC2DOQ6KxPXZ7lYWa9s+4RI=; b=VhClpoNayNggIskH4KYA/2gjpq
        8CRQIlSfkOcazgLZzjoaXLal48fioUKxGp4HTIn/7cR0HJTGaDDN3oG7UR+oL3/aQzqps4yG4gMpT
        v4Ku7BjMjtle8IQmv63/UFe7dTKg5M97APX2X3oZIH5qyXEGng2Imymm24OkHZMjDOGfpbDwZk4vF
        TNM/yV4ipesWvORZLWFfxYQ29gxADn17KBppzv/FxOAGDWDiU8E1y7VxbG5raUpGJ6qRSyN5CYH40
        ftBCnAtnhsgoa46/XOzHxTVTSvAVDiV8v/jbqJLhNIcGYRQhyNygSeuWPVPrpvDzGBQ6m89s9K0rd
        T/MR/Fyw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k8brp-0006ak-Gn; Thu, 20 Aug 2020 04:07:58 +0000
Subject: Re: [PATCH] x86/pci: fix intel_mid_pci.c build error when ACPI is not
 enabled
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arjan van de Ven <arjan@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Len Brown <lenb@kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <20952e3e-6b06-11e4-aff7-07dfbdc5ee18@infradead.org>
 <810f1b0e-0adf-c316-f23c-172338f9ef0a@linux.intel.com>
 <CAHp75VcJCjJJvbkSiGHC+3_shWRwoqeZHE2KNDLQBjneW=02dg@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <2b14b6be-a031-a28b-6585-8307d2fdae21@infradead.org>
Date:   Wed, 19 Aug 2020 21:07:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VcJCjJJvbkSiGHC+3_shWRwoqeZHE2KNDLQBjneW=02dg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 8/13/20 1:55 PM, Andy Shevchenko wrote:
> On Thu, Aug 13, 2020 at 11:31 PM Arjan van de Ven <arjan@linux.intel.com> wrote:
>> On 8/13/2020 12:58 PM, Randy Dunlap wrote:
>>> From: Randy Dunlap <rdunlap@infradead.org>
>>>
>>> Fix build error when CONFIG_ACPI is not set/enabled by adding
>>> the header file <asm/acpi.h> which contains a stub for the function
>>> in the build error.
>>>
>>> ../arch/x86/pci/intel_mid_pci.c: In function ‘intel_mid_pci_init’:
>>> ../arch/x86/pci/intel_mid_pci.c:303:2: error: implicit declaration of function ‘acpi_noirq_set’; did you mean ‘acpi_irq_get’? [-Werror=implicit-function-declaration]
>>>    acpi_noirq_set();
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Thanks!

also:
Reviewed-by: Jesse Barnes <jsbarnes@google.com>

> 
>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
>>> Cc: Len Brown <lenb@kernel.org>
>>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>>> Cc: Jesse Barnes <jsbarnes@google.com>
>>> Cc: Arjan van de Ven <arjan@linux.intel.com>
>>> Cc: linux-pci@vger.kernel.org
>>> ---
>>> Found in linux-next, but applies to/exists in mainline also.
>>>
>>> Alternative.1: X86_INTEL_MID depends on ACPI
>>> Alternative.2: drop X86_INTEL_MID support
>>
>> at this point I'd suggest Alternative 2; the products that needed that (past tense, that technology
>> is no longer need for any newer products) never shipped in any form where a 4.x or 5.x kernel could
>> work, and they are also all locked down...
> 
> This is not true. We have Intel Edison which runs nicely on vanilla
> (not everything, some is still requiring a couple of patches, but most
> of it works out-of-the-box).
> 
> And for the record, I have been working on removing quite a pile of
> code (~13kLOCs to the date IIRC) in MID area. Just need some time to
> fix Edison watchdog for that.


I didn't see a consensus on this patch, although Andy says it's still needed,
so it shouldn't be removed (yet). Maybe his big removal patch can remove it
later. For now can we just fix the build error?


-- 
~Randy

