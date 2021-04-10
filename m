Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAC7035AE43
	for <lists+linux-pci@lfdr.de>; Sat, 10 Apr 2021 16:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234738AbhDJOZk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 10 Apr 2021 10:25:40 -0400
Received: from bmailout2.hostsharing.net ([83.223.78.240]:39495 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234733AbhDJOZj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 10 Apr 2021 10:25:39 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 17CE52800B3D3;
        Sat, 10 Apr 2021 16:25:24 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 0DEC13663B; Sat, 10 Apr 2021 16:25:24 +0200 (CEST)
Date:   Sat, 10 Apr 2021 16:25:24 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: Re: PCI service interrupt handlers & access to PCI config space
Message-ID: <20210410142524.GA31187@wunner.de>
References: <20210410122845.nhenihbygmcjlegn@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210410122845.nhenihbygmcjlegn@pali>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Apr 10, 2021 at 02:28:45PM +0200, Pali Rohár wrote:
> I see that more PCI service drivers in their interrupt handlers are
> accessing PCI config space.
> 
> E.g. in PCIe Hot Plug interrupt handler pciehp_isr handler is called
> pcie_capability_read_word() function.
> 
> It is correct? Because these capability functions are protected by
> pci_lock_config() / pci_unlock_config() calls.

Looks fine to me.  That's a raw_spin_lock, which is allowed to be taken
in interrupt context.

> And what would happen when during execution of reading or writing to
> PCIe config space (e.g. via pcie_capability_read_word()) is triggered
> PCIe HP interrupt? Would not enter interrupt handler function in
> deadlock (waiting for unlocking config space)?

The interrupt handler would spin until the lock is released.
raw_spin_locks are not supposed to be held for a prolonged
period of time.

The interrupt is masked when it triggers and until it's been handled,
so the interrupt handler never runs multiple times concurrently.
See e.g. handle_level_irq() in kernel/irq/chip.c.

Thanks,

Lukas
