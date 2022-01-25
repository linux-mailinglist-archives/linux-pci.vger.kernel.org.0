Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 565D849BA43
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jan 2022 18:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237528AbiAYRXy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jan 2022 12:23:54 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:45374 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1588062AbiAYRV0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jan 2022 12:21:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 745676115D;
        Tue, 25 Jan 2022 17:21:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2942C340E0;
        Tue, 25 Jan 2022 17:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643131283;
        bh=gPCdN8hHlNnY+V2scDQMdjEgjDrE7whfrHiP+g10BFA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=juhfXXTiGnYRUe2bYtmQAkzPKYBykTnU3r6H8snpH0i9nGBIfUXKesIJs7rOSrMGz
         L6o5DdmAYdAZlaCcdLwNFfot2efLwMrZztC9y5cRihsvP9kuqVyLznEHoTWoNIdjER
         nuR5AUW9TW/GZ/DIBaOXebYPQCzma1tFrqUlmDZOUV/6z0CU7Hh4qObSqW9uVGC9wt
         7+dE7cGN0ojt/rcUVHk3RBJjkwhkC3nGrOzlJLhqNqWDj7KxHW9iXOrd54b24Swyrl
         i5rwdhJwkHgRh0E/IuNEY64HYb3QokAGmwyChr4BAHn+eT606BlLHqqI8eiuOc1rUC
         Nl99mnqgHTPNg==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nCPVR-002yy2-RP; Tue, 25 Jan 2022 17:21:21 +0000
MIME-Version: 1.0
Date:   Tue, 25 Jan 2022 17:21:21 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     qizhong cheng <qizhong.cheng@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy?= =?UTF-8?Q?=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, chuanjia.liu@mediatek.com
Subject: Re: [PATCH] PCI: mediatek: Change MSI interrupt processing sequence
In-Reply-To: <20220125165748.GA1458116@bhelgaas>
References: <20220125165748.GA1458116@bhelgaas>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <e8e42eba6e7cf49bc2260f20844a7849@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: helgaas@kernel.org, qizhong.cheng@mediatek.com, ryder.lee@mediatek.com, jianjun.wang@mediatek.com, lorenzo.pieralisi@arm.com, kw@linux.com, bhelgaas@google.com, linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, chuanjia.liu@mediatek.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022-01-25 16:57, Bjorn Helgaas wrote:
> All patches change *something*.  Can you update the subject line so it
> says something specific about the change?
> 
> Maybe something like "Clear MSI status before dispatching handler"?
> 
> On Sun, Jan 23, 2022 at 11:33:06AM +0800, qizhong cheng wrote:
>> As an edge-triggered interrupts, its interrupt status should be 
>> cleared
>> before dispatch to the handler of device.
> 
> I'm not an IRQ expert, but the reasoning that "we should clear the MSI
> interrupt status before dispatching the handler because MSI is an
> edge-triggered interrupt" doesn't seem completely convincing because
> your code will now look like this:
> 
>   /* Clear the INTx */
>   writel(1 << bit, port->base + PCIE_INT_STATUS);
>   generic_handle_domain_irq(port->irq_domain, bit - INTX_SHIFT);
>   ...
> 
>   /* Clear MSI interrupt status */
>   writel(MSI_STATUS, port->base + PCIE_INT_STATUS);
>   generic_handle_domain_irq(port->inner_domain, bit);
> 
> You clear interrupt status before dispatching the handler for *both*
> level-triggered INTx interrupts and edge-triggered MSI interrupts.
> 
> So it doesn't seem that simply being edge-triggered is the critical
> factor here.

This is the usual problem with these half-baked implementations.
The signalling to the primary interrupt controller is level, as
they take a multitude of input and (crucially) latch the MSI
edges. Effectively, this is an edge-to-level converter, with
all the problems that this creates.

By clearing the status *after* the handling, you lose edges that
have been received and coalesced after the read of the status
register. By clearing it *before*, you are acknowledging the
interrupts early, and allowing them to be coalesced independently
of the ones that have been received earlier.

This is however mostly an educated guess. Someone with access
to the TRM should verify this.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
