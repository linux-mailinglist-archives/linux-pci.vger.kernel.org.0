Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F423145BC6
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2020 19:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbgAVSwi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Jan 2020 13:52:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:54804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbgAVSwi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 22 Jan 2020 13:52:38 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 184A821835;
        Wed, 22 Jan 2020 18:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579719157;
        bh=5N2lby6WvqFZeWW6SAuM+U0/JmDPEWrEqossVjyGV7w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GCTP14tWdJpqduyaoSOjxqcDcDRk88aa+t7uhARNpQVY0cYRdiiVje5oW20xDqhq/
         xmMgDozhkztwNJcnyPKixFGN9FCL5e7+1UTQtKroaekg6qd6/IqJBMEaJ2sLVwuhBJ
         +swTUIPVhAae75S0AO/yDPKC6k+AIz8QuEbHRWr4=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1iuL7D-000nzY-Dp; Wed, 22 Jan 2020 18:52:35 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 22 Jan 2020 18:52:35 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Evan Green <evgreen@chromium.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>,
        Rajat Jain <rajatxjain@gmail.com>
Subject: Re: [PATCH] PCI/MSI: Avoid torn updates to MSI pairs
In-Reply-To: <20200122172816.GA139285@google.com>
References: <20200122172816.GA139285@google.com>
Message-ID: <9c27a991dfc5237397001ac8e5e613a4@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.8
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: helgaas@kernel.org, evgreen@chromium.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, hch@lst.de, rajatxjain@gmail.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020-01-22 17:28, Bjorn Helgaas wrote:
> [+cc Thomas, Marc, Christoph, Rajat]
> 
> On Thu, Jan 16, 2020 at 01:31:28PM -0800, Evan Green wrote:
>> __pci_write_msi_msg() updates three registers in the device: address
>> high, address low, and data. On x86 systems, address low contains
>> CPU targeting info, and data contains the vector. The order of writes
>> is address, then data.
>> 
>> This is problematic if an interrupt comes in after address has
>> been written, but before data is updated, and the SMP affinity of
>> the interrupt is changing. In this case, the interrupt targets the
>> wrong vector on the new CPU.
>> 
>> This case is pretty easy to stumble into using xhci and CPU 
>> hotplugging.
>> Create a script that targets interrupts at a set of cores and then
>> offlines those cores. Put some stress on USB, and then watch xhci lose
>> an interrupt and die.
>> 
>> Avoid this by disabling MSIs during the update.
>> 
>> Signed-off-by: Evan Green <evgreen@chromium.org>
>> ---
>> 
>> 
>> Bjorn,
>> I was unsure whether disabling MSIs temporarily is actually an okay
>> thing to do. I considered using the mask bit, but got the impression
>> that not all devices support the mask bit. Let me know if this going 
>> to
>> cause problems or there's a better way. I can include the repro
>> script I used to cause mayhem if needed.
> 
> I suspect this *is* a problem because I think disabling MSI doesn't
> disable interrupts; it just means the device will interrupt using INTx
> instead of MSI.  And the driver is probably not prepared to handle
> INTx.
> 
> PCIe r5.0, sec 7.7.1.2, seems relevant: "If MSI and MSI-X are both
> disabled, the Function requests servicing using INTx interrupts (if
> supported)."
> 
> Maybe the IRQ guys have ideas about how to solve this?

Not from the top of my head. MSI-X should always support masking,
so we could at least handle that case properly and not loose interrupts.
Good ol' MSI is more tricky. Disabling MSI, as Bjorn pointed out, is
just going to make the problem worse.

There is also the problem that a number of drivers pick MSI instead of
MSI-X.

         M.
-- 
Jazz is not dead. It just smells funny...
