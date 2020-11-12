Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA5F62B0C6D
	for <lists+linux-pci@lfdr.de>; Thu, 12 Nov 2020 19:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgKLSTV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Nov 2020 13:19:21 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46270 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgKLSTV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Nov 2020 13:19:21 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605205159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Dro7ls5DhHhACesu0+9Z/Uvm1F67s9OF+bClE31wk1c=;
        b=Exz7Pb5hh+BSvw9KTiap38dZI1SADklDFNgfK9eyV4LF67qhViVYAlnOTSRcDTCiGit9Kw
        7uznHZSeWW5sXDnpyYHkqARlwosgUIDFQ+uM7P7ui+4Fq+lI+oNgM6L/zDi8SSJ48ViYz3
        byp3T5PzvZr77yhFQUk12mLeSMui3YqovoarS0yMIW2ztVtogS+Ejzp4md9pZigYnXz2wq
        OxzTmMCbk9VSYvLlcuuj/80TCAYHhYZwSBQG8LZBADXzKdUmVRLrCp1FGEhspIGLbHuDWM
        Zulho+zOIobQVuKIHbfkWkFNBf6GJ/qhOpx3Bm5t+6uhpvv5vz0KxzLLzL+qgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605205159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Dro7ls5DhHhACesu0+9Z/Uvm1F67s9OF+bClE31wk1c=;
        b=XSmsE9GbeKI7ABdF2CI44KnNdjXKUKOUCmCvsf3BiahLvZUCZcBuLhdsG1UmYz+wFaiyRx
        xuBFH3+dUIjbjZAg==
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Martin Kaiser <martin@kaiser.cx>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        rfi@lists.rocketboards.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Toan Le <toan@os.amperecomputing.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH] PCI: altera-msi: Remove irq handler and data in one go
In-Reply-To: <20201112142657.GA1011805@bjorn-Precision-5520>
References: <20201112142657.GA1011805@bjorn-Precision-5520>
Date:   Thu, 12 Nov 2020 19:19:18 +0100
Message-ID: <87h7pumo9l.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 12 2020 at 08:26, Bjorn Helgaas wrote:
> On Thu, Nov 12, 2020 at 02:50:42PM +0100, Thomas Gleixner wrote:
>> So I had a closer look and the reason why it only matters for the
>> chained handler case is that
>> 
>>    __irq_set_handler(..., is_chained = true, ...)
>> 
>> starts up the interrupt immediately. So the order for this _must_ be:
>> 
>>     set_handler_data() -> set_handler()
>> 
>> For regular interrupts it's really the mapping and allocation code which
>> does this long before the interrupt is started up. So the ordering does
>> not matter because the handler can't be reached before the full
>> setup is finished and the interrupt is actually started up.
>
> If the order truly doesn't matter here, maybe it's worth changing it
> to "set data, set handler" to avoid the need for a closer look to
> verify correctness and to make it harder to copy and paste to a place
> where it *does* matter?

Makes sense.
