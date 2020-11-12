Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D27A82B03D8
	for <lists+linux-pci@lfdr.de>; Thu, 12 Nov 2020 12:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgKLL2z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Nov 2020 06:28:55 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44028 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727147AbgKLL2z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Nov 2020 06:28:55 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605180533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x6LYK8bfLBdal9fvnfibNFlmU+KkoFrcpTdIIDLlxIg=;
        b=W2d7n0NWjwRpCv0IPMgXpWbuRBt4vAX1bqT2VjMF62KEt83feXs5TV6pGdJINKIfhRvVNl
        xnMPEybcPKWkGfe91WhHT2o1/EtQd9St22p8uE3hdzh57kOhZBSH4LrNHIqpLF075rqYvV
        zALUczDJPnSitvsH/SENWJHle9vAi1ZQiQhwCksulJJ7WeCAktsXEq3phRYcLEJ41Ym1jP
        pKQI7R65Za6b9K2okpnlLUKSRvhvk8Gr6YjZXnup0Ly+FheG4ljqvrDVqn51TYdewzg0nD
        o1d7GqAfjEF6hXGbYBC39hztUWMYkVCVcTWn1B8rEeWqMXluutlQc8mCeV/QQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605180533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x6LYK8bfLBdal9fvnfibNFlmU+KkoFrcpTdIIDLlxIg=;
        b=IWbrVAPy3SBaexRMh14J0swsStNTHBgzFp1VFYbhgCuM8va8a/sFdzxv8+niZblWE8sqfx
        LsCW1wynUV3ISzCA==
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     Ley Foon Tan <ley.foon.tan@intel.com>,
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
In-Reply-To: <20201111221639.GA973514@bjorn-Precision-5520>
References: <20201111221639.GA973514@bjorn-Precision-5520>
Date:   Thu, 12 Nov 2020 12:28:53 +0100
Message-ID: <87sg9en79m.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 11 2020 at 16:16, Bjorn Helgaas wrote:
> On Wed, Nov 11, 2020 at 10:43:55PM +0100, Martin Kaiser wrote:
>> This function uses the error status from irq_set_handler_data().
>> irq_set_chained_handler_and_data() returns no such error status. Is it
>> ok to drop the error handling?
>
> I'm not an IRQ expert, but I'd say it's OK to drop it.  Of the 40 or
> so callers, the only other caller that looks at the error status is
> ingenic_intc_of_init().

Don't know why irq_set_chained_handler_and_data() does not return an
error, but the call site must really do something stupid if it fails to
hand in the proper interrupt number.

> Thomas, it looks like irq_domain_set_info() and msi_domain_ops_init()
> set the handler itself before setting the handler data:
>
>   irq_domain_set_info
>     irq_set_chip_and_handler_name(virq, chip, handler, ...)
>     irq_set_handler_data(virq, handler_data)
>
>   msi_domain_ops_init
>     __irq_set_handler(virq, info->handler, ...)
>     if (info->handler_data)
>       irq_set_handler_data(virq, info->handler_data)
>
> That looks at least superficially similar to the race you fixed with
> 2cf5a03cb29d ("PCI/keystone: Fix race in installing chained IRQ
> handler").
>
> Should irq_domain_set_info() and msi_domain_ops_init() swap the order,
> too?

In theory yes. Practically it should not matter because that happens
during the allocation way before the interrupt can actually fire.  I'll
have a deeper look nevertheless.

Thanks,

        tglx
