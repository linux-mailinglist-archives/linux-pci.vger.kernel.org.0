Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 703843D19F6
	for <lists+linux-pci@lfdr.de>; Thu, 22 Jul 2021 00:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbhGUWK7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Jul 2021 18:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbhGUWK6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Jul 2021 18:10:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E945C061575;
        Wed, 21 Jul 2021 15:51:34 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626907888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yXIuGKgrtndxLbEbLM1La0ZRahqh+qguRksSddZBObU=;
        b=FQhaaaHQvCqQHYzWEm7po6vb1f3efVKgampOXn8woHV3VktYXx8pJozVPE1YwnMNtvDJd8
        7Mt/mMj9pjqF3eWQZXZJbEQDy+Ifng4b54A7Ahb1wOOVcCQQuXrDEIJ9mpRxDZKXNDW7y3
        ic4eLTcu6Q0dLYX38ahJuJrSIV51C99m3xZmp6BXwTpMh3/v95uQZgOFFPq1j+zQTGe+x9
        tMyjJs1D1LtjI/HvkBrTCmXYBoDleJGM41Yxoz5OIOgJwAWblz0G9KoV/Bj/c02oDZz26b
        jZA8ynIUyOsVWf5t/8pwEnxIo0YVbW8f21zwk6x/qhUXgfcOWDHe8R3CAGnz2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626907888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yXIuGKgrtndxLbEbLM1La0ZRahqh+qguRksSddZBObU=;
        b=i1kPckcGM/EskWoovmQA7XEkQKJRf2UHVEXpt4PEmU94W6iYB4E4hT4XOcobA9xy3tzJ5O
        4KFi9hWzqHdCzhCg==
To:     "Raj\, Ashok" <ashok.raj@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [patch 1/8] PCI/MSI: Enable and mask MSIX early
In-Reply-To: <20210721213813.GB676232@otc-nc-03>
References: <20210721191126.274946280@linutronix.de> <20210721192650.106154171@linutronix.de> <20210721213813.GB676232@otc-nc-03>
Date:   Thu, 22 Jul 2021 00:51:23 +0200
Message-ID: <8735s7p9g4.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 21 2021 at 14:38, Ashok Raj wrote:

> On Wed, Jul 21, 2021 at 09:11:27PM +0200, Thomas Gleixner wrote:
>> The ordering of MSI-X enable in hardware is disfunctional:
>> 
>>  1) MSI-X is disabled in the control register
>>  2) Various setup functions
>>  3) pci_msi_setup_msi_irqs() is invoked which ends up accessing
>>     the MSI-X table entries
>>  4) MSI-X is enabled and masked in the control register with the
>>     comment that enabling is required for some hardware to access
>>     the MSI-X table
>> 
>> #4 obviously contradicts #3. The history of this is an issue with the NIU
>> hardware. When #4 was introduced the table access actually happened in
>> msix_program_entries() which was invoked after enabling and masking MSI-X.
>> 
>> This was changed in commit d71d6432e105 ("PCI/MSI: Kill redundant call of
>> irq_set_msi_desc() for MSI-X interrupts") which removed the table write
>> from msix_program_entries().
>> 
>> Interestingly enough nobody noticed and either NIU still works or it did
>> not get any testing with a kernel 3.19 or later.
>> 
>> Nevertheless this is inconsistent and there is no reason why MSI-X can't be
>> enabled and masked in the control register early on, i.e. move #4 above to
>
> Does the above comment also apply to legacy MSI when it support per-vector
> masking capability? Probably not interesting since without IR, we only give
> 1 vector to MSI. 

No MSI is completely different as the MSI configuration is purely in PCI
config space while the MSI-X table is separately mapped.

Thanks,

        tglx
