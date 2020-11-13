Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 798142B180D
	for <lists+linux-pci@lfdr.de>; Fri, 13 Nov 2020 10:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgKMJTP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Nov 2020 04:19:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:44292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbgKMJTO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Nov 2020 04:19:14 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21D4E217A0;
        Fri, 13 Nov 2020 09:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605259153;
        bh=4WfWbAlavSUu5PlR51nGUJzILHY5zJO40KyO7oEp2x0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=v+5H7kN+M6Sx/diM7jt8WdPp+z/ENWnjqo0Mt7jppePx8mOt6BV3zrXRG9C2ULikU
         h9y7cqmKqm+YjgJ4ZrirPtHXISgCrx9lvuZxQAnqFsHFzVDfJdBD7oFnw9u7vpLI/6
         EgYK3U+iopdz/Fm1SkJdgZyUFi6bNIhmOz1Og6J8=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kdVEc-00AHye-HD; Fri, 13 Nov 2020 09:19:10 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 13 Nov 2020 09:19:10 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Ziyad Atiyyeh <ziyadat@nvidia.com>,
        Itay Aveksis <itayav@nvidia.com>,
        Moshe Shemesh <moshe@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: iommu/vt-d: Cure VF irqdomain hickup
In-Reply-To: <87a6vmmf8h.fsf@nanos.tec.linutronix.de>
References: <20200826111628.794979401@linutronix.de>
 <20201112125531.GA873287@nvidia.com>
 <87mtzmmzk6.fsf@nanos.tec.linutronix.de>
 <87k0uqmwn4.fsf@nanos.tec.linutronix.de>
 <87d00imlop.fsf@nanos.tec.linutronix.de>
 <87a6vmmf8h.fsf@nanos.tec.linutronix.de>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <2196b03a44a15fdc37223040197c4ac5@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: tglx@linutronix.de, jgg@nvidia.com, ziyadat@nvidia.com, itayav@nvidia.com, moshe@nvidia.com, linux-kernel@vger.kernel.org, x86@kernel.org, joro@8bytes.org, iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org, bhelgaas@google.com, dwmw2@infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020-11-12 21:34, Thomas Gleixner wrote:
> On Thu, Nov 12 2020 at 20:15, Thomas Gleixner wrote:
>> The recent changes to store the MSI irqdomain pointer in struct device
>> missed that Intel DMAR does not register virtual function devices.  
>> Due to
>> that a VF device gets the plain PCI-MSI domain assigned and then 
>> issues
>> compat MSI messages which get caught by the interrupt remapping unit.
>> 
>> Cure that by inheriting the irq domain from the physical function
>> device.
>> 
>> That's a temporary workaround. The correct fix is to inherit the irq 
>> domain
>> from the bus, but that's a larger effort which needs quite some other
>> changes to the way how x86 manages PCI and MSI domains.
> 
> Bah, that's not really going to work with the way how irq remapping
> works on x86 because at least Intel/DMAR can have more than one DMAR
> unit on a bus.
> 
> So the alternative solution would be to assign the domain per device,
> but the current ordering creates a hen and egg problem. Looking the
> domain up in pci_set_msi_domain() does not work because at that point
> the device is not registered in the IOMMU. That happens from
> device_add().
> 
> Marc, is there any problem to reorder the calls in pci_device_add():
> 
>       device_add();
>       pci_set_msi_domain();

I *think* it works as long as we keep the "match_driver = false" hack.
Otherwise, we risk binding to a driver early, and game over.

> That would allow to add a irq_find_matching_fwspec() based lookup to
> pci_msi_get_device_domain().

Just so that I understand the issue: is the core of the problem that
there is no 1:1 mapping between a PCI bus and a DMAR unit, and no
firmware topology information to indicate which one to pick?

> Though I'm not yet convinced that the outcome would be less horrible
> than the hack in the DMAR driver when I'm taking all the other horrors
> of x86 (including XEN) into account :)

I tried to follow the notifier into the DMAR driver, ended up in the
IRQ remapping code, and lost the will to live. I have a question though:

In the bus notifier callback, you end-up in dmar_pci_bus_add_dev(),
which calls intel_irq_remap_add_device(), which tries to set the
MSI domain. Why isn't that enough? Are we still missing any information
at that stage?

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
