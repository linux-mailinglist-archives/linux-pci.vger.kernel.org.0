Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3CC77C987C
	for <lists+linux-pci@lfdr.de>; Sun, 15 Oct 2023 11:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjJOJh0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 15 Oct 2023 05:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjJOJhZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 15 Oct 2023 05:37:25 -0400
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0723BAD;
        Sun, 15 Oct 2023 02:37:23 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 865442800A287;
        Sun, 15 Oct 2023 11:37:22 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 790F219279; Sun, 15 Oct 2023 11:37:22 +0200 (CEST)
Date:   Sun, 15 Oct 2023 11:37:22 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Marcel Hamer <marcel.hamer@windriver.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: pciehp lockdep possible circular locking dependency
Message-ID: <20231015093722.GA11283@wunner.de>
References: <ZSUdqxOZ9HUFR32S@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSUdqxOZ9HUFR32S@windriver.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 10, 2023 at 11:47:23AM +0200, Marcel Hamer wrote:
> On kernel v6.6.0-rc5 we have discovered a lockdep warning when using PCIe
> hotplug. The issue is reproducible using PCIe hotplug in a Qemu environment.
> 
> When reverting the following commit, the warning no longer exists:
> 
> commit f5eff5591b8f9c5effd25c92c758a127765f74c1
> Author: Lukas Wunner <lukas@wunner.de>
> Date:   Tue Apr 11 08:21:02 2023 +0200
> 
>     PCI: pciehp: Fix AB-BA deadlock between reset_lock and device_lock
> 
> We have also experienced the issue on the v5.10-stable branch.
> 
> For now I have difficulty determining if this is a serious potential deadlock
> candidate or if this is a false reporting. Any help here would be greatly
> appreciated.

Thanks a lot for the report.

It's a false positive because the two stacktraces are identical
but pciehp_ist() is single-threaded.  There is only ever a single
instance of pciehp_ist() running per hotplug port, so two instances
running on separate CPUs can't happen:

> [   19.885923] -> #1 (pci_rescan_remove_lock){+.+.}-{3:3}:
> [   19.886623]        __mutex_lock+0x81/0xcb0
> [   19.886889]        pciehp_configure_device+0x1f/0x100
> [   19.887211]        pciehp_handle_presence_or_link_change+0x16e/0x4d0
> [   19.887587]        pciehp_ist+0x157/0x190
> [   19.887822]        irq_thread_fn+0x1f/0x60
> [   19.888076]        irq_thread+0xe5/0x1b0
> [   19.888306]        kthread+0xe4/0x120
> [   19.888499]        ret_from_fork+0x2f/0x50
> [   19.888728]        ret_from_fork_asm+0x1b/0x30
> [   19.889018]
> [   19.889018] -> #0 (&ctrl->reset_lock){.+.+}-{3:3}:
> [   19.889382]        __lock_acquire+0x1509/0x25f0
> [   19.889661]        lock_acquire+0xc1/0x2b0
> [   19.889899]        down_read_nested+0x2f/0x160
> [   19.890177]        pciehp_configure_device+0xb1/0x100
> [   19.890492]        pciehp_handle_presence_or_link_change+0x16e/0x4d0
> [   19.890876]        pciehp_ist+0x157/0x190
> [   19.891085]        irq_thread_fn+0x1f/0x60
> [   19.891301]        irq_thread+0xe5/0x1b0
> [   19.891538]        kthread+0xe4/0x120
> [   19.891764]        ret_from_fork+0x2f/0x50
> [   19.891989]        ret_from_fork_asm+0x1b/0x30

lockdep doesn't appear to be smart enough to recognize that and
we do not have an annotation which would tell lockdep that a
particular function is always single-threaded.

From a brief look, amending lockdep to cope with such situations
seems non-trivial and I'm not sure if it happens frequently enough
to justify the additional complexity.

The only other option I see is to set lockdep_set_novalidate_class()
for the reset_lock.  However that will prevent us from detecting
*valid* issues with that lock.

Hm, that's a difficult decision...

Thanks,

Lukas
