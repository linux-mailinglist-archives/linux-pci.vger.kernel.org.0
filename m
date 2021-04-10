Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B6535AEC7
	for <lists+linux-pci@lfdr.de>; Sat, 10 Apr 2021 17:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234680AbhDJPR0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 10 Apr 2021 11:17:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:37768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234392AbhDJPR0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 10 Apr 2021 11:17:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D34CB6113A;
        Sat, 10 Apr 2021 15:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618067832;
        bh=4WHOBwE1WNOvLxdgMJwpN6D5kOlBOL+bHFlPdgW9/mI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ezKoJfWEz+bhqrmzsXCDIY2E638wmad41z4+Ihzck0ZVBAzZ1DAM6acWZCqOxTfWb
         BlA1g6Nya+9fIktw1lacCV/4BX4TdvLqxpnj/0Lvz+KhpBBMsSmpLbD7LKbSGaduLU
         KrE0aDSoVEqEcitKmjfC1HfW+Vl4fZIO4puUfUvV/bT5MVp6vuxCsqDUixJg5tsT8C
         vJ4Lv6zBgKo9fzFfgwy35hHF2epvlkvJ7BTEuUA/HYZBFgi4RwpuXUsKMKZqdBqNpX
         SSNYlxM00sl6dBZh6oWHFKxBtvFDTNEvSJ5gRjMfAIRd1SlbMVYl1rCyzXGVo+DyEq
         /rTe3DNLtzHkw==
Received: by pali.im (Postfix)
        id 7F9D2BEF; Sat, 10 Apr 2021 17:17:09 +0200 (CEST)
Date:   Sat, 10 Apr 2021 17:17:09 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-pci@vger.kernel.org
Subject: Re: PCI service interrupt handlers & access to PCI config space
Message-ID: <20210410151709.yb42uloq3aiwcoog@pali>
References: <20210410122845.nhenihbygmcjlegn@pali>
 <20210410142524.GA31187@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210410142524.GA31187@wunner.de>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

On Saturday 10 April 2021 16:25:24 Lukas Wunner wrote:
> On Sat, Apr 10, 2021 at 02:28:45PM +0200, Pali Rohár wrote:
> > I see that more PCI service drivers in their interrupt handlers are
> > accessing PCI config space.
> > 
> > E.g. in PCIe Hot Plug interrupt handler pciehp_isr handler is called
> > pcie_capability_read_word() function.
> > 
> > It is correct? Because these capability functions are protected by
> > pci_lock_config() / pci_unlock_config() calls.
> 
> Looks fine to me.  That's a raw_spin_lock, which is allowed to be taken
> in interrupt context.
> 
> > And what would happen when during execution of reading or writing to
> > PCIe config space (e.g. via pcie_capability_read_word()) is triggered
> > PCIe HP interrupt? Would not enter interrupt handler function in
> > deadlock (waiting for unlocking config space)?
> 
> The interrupt handler would spin until the lock is released.
> raw_spin_locks are not supposed to be held for a prolonged
> period of time.

What is "prolonged period of time"? Because for example PCIe controller
on A3720 has upper limit about 1.5s when accessing config space. This is
what I measured in real example. It really took PCIe HW more than 1s to
return error code if it happens.

> The interrupt is masked when it triggers and until it's been handled,
> so the interrupt handler never runs multiple times concurrently.
> See e.g. handle_level_irq() in kernel/irq/chip.c.

I'm thinking if it is really safe here. On dual-core system, there may
be two tasks (on each CPU) which calls pcie_capability_read_word() (or
other access function). Exactly one pass pci lock. And after that two
different interrupts (for each CPU) may occur which handlers would like
to call pcie_capability_read_word(). raw_spin_lock_irqsave (which is
called from pci_lock_config()) disable interrupts on local CPU, right?
But what with second CPU? Could not be there issue?

And what would happen if pcie_capability_read_word() is locked for 1.5s
as described above? Does not look safe for me.
