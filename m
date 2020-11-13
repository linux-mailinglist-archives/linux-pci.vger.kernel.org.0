Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFB012B1C96
	for <lists+linux-pci@lfdr.de>; Fri, 13 Nov 2020 14:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbgKMNwb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Nov 2020 08:52:31 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52062 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbgKMNw3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Nov 2020 08:52:29 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605275547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xsSnKN0Y2j/jQ2IRBao4uClTn5UrQq6Zg7g/UkqX+lo=;
        b=ayNoDTQA8qN45li0yGYUyxDleZJkOg5NfkWvLrESAsBTP7HmGH+rsHryn2bNTDxixwa5H7
        UmIPAIT1Hacp/6y9T8dmqEt6Bvhspdyb06B6qG0TOEECmj+hlLfGqkOdQvfb0iSc5gak4J
        oBcUXRxTY2W9ABYeWH0ECE7h42DLdDApf+ow7Sr2U7HVZy3kXUWcoZKEOgJQc61hJyygFC
        C86gRbCf9R81w17QQmbm1X0bphCgaakqz4VhVEEMeRTKnFFXH2m4zJHkVapUcojXJDSDzf
        5/MGaf2atprYOuKwQopa03uoDwZi7/7blEcq2I7a1OeY9rFD7gqjfVXM8NQvFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605275547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xsSnKN0Y2j/jQ2IRBao4uClTn5UrQq6Zg7g/UkqX+lo=;
        b=X8h7nBkZIVQfOzZvoYR42UafxIu8Yci8xE9VWP/nM/wn3IGE5v2RPyiosOcb53/JPb8fNi
        m1VFqaGW00FwpFDw==
To:     Marc Zyngier <maz@kernel.org>
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
In-Reply-To: <2196b03a44a15fdc37223040197c4ac5@kernel.org>
References: <20200826111628.794979401@linutronix.de> <20201112125531.GA873287@nvidia.com> <87mtzmmzk6.fsf@nanos.tec.linutronix.de> <87k0uqmwn4.fsf@nanos.tec.linutronix.de> <87d00imlop.fsf@nanos.tec.linutronix.de> <87a6vmmf8h.fsf@nanos.tec.linutronix.de> <2196b03a44a15fdc37223040197c4ac5@kernel.org>
Date:   Fri, 13 Nov 2020 14:52:27 +0100
Message-ID: <87wnypl5yc.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 13 2020 at 09:19, Marc Zyngier wrote:
> On 2020-11-12 21:34, Thomas Gleixner wrote:
>> That would allow to add a irq_find_matching_fwspec() based lookup to
>> pci_msi_get_device_domain().
>
> Just so that I understand the issue: is the core of the problem that
> there is no 1:1 mapping between a PCI bus and a DMAR unit, and no
> firmware topology information to indicate which one to pick?

Yes, we don't have a 1:1 mapping and there is some info, but that's all
a horrible mess.

>> Though I'm not yet convinced that the outcome would be less horrible
>> than the hack in the DMAR driver when I'm taking all the other horrors
>> of x86 (including XEN) into account :)
>
> I tried to follow the notifier into the DMAR driver, ended up in the
> IRQ remapping code, and lost the will to live.

Please just don't look at that and stay alive :)

> I have a question though:
>
> In the bus notifier callback, you end-up in dmar_pci_bus_add_dev(),
> which calls intel_irq_remap_add_device(), which tries to set the MSI
> domain. Why isn't that enough? Are we still missing any information at
> that stage?

That works, but this code is not reached for VF devices ... See the
patch which cures that.

If we want to get rid of that mess we'd need to rewrite the DMAR IOMMU
device registration completely. I'll leave it as is for now. My will to
live is more important :)

Thanks

        tglx

