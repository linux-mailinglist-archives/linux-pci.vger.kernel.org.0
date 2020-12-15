Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 158962DB416
	for <lists+linux-pci@lfdr.de>; Tue, 15 Dec 2020 19:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731628AbgLOS5P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Dec 2020 13:57:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:51400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731748AbgLOS5F (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Dec 2020 13:57:05 -0500
Date:   Wed, 16 Dec 2020 03:56:18 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608058584;
        bh=ovatte7E0kTUsKU1pa6DNPPBGou3nH70MOUaEiQGVqY=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=jaCW45OwHKQtr6jgANQ5/UD43u9cmH/ismjletlxELE/hJh7DULKoCmOMCd9VYIKa
         v9tj3JZoCpgoy4BjJfXmMKMih7Ur1g3Po09pma2Pfex+yl6KX3yQViY6CAcEB/Gglq
         n45qv8VpMB7lYyXHbA1bIgBoL0yVB0vndPEnJCieVtI9VTfB1Sr/WDmGVSOyRlUTNM
         5nURuOYaTy1PZTAvev9/WK7B0XuQgxe93drZl8VD0FrUC2UmTLItDqhkKpXUydhtvW
         AHNyeTI9j0d8SUROQ0J3T6ZfEt1fQUFOlL68uryHCe8/Agl4/6krOX5JATpWhvWE6Q
         O7EM7LcChyZpA==
From:   Keith Busch <kbusch@kernel.org>
To:     Hinko Kocevar <hinko.kocevar@ess.eu>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: Recovering from AER: Uncorrected (Fatal) error
Message-ID: <20201215185618.GC22809@redsun51.ssa.fujisawa.hgst.com>
References: <20201209213227.GA2544987@bjorn-Precision-5520>
 <6234c1c4-a8cc-1bd6-8366-f359b9b5ef54@ess.eu>
 <20201214212319.GB22809@redsun51.ssa.fujisawa.hgst.com>
 <0def63a9-9a9e-440c-6bd8-7fd8dfef5b63@ess.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0def63a9-9a9e-440c-6bd8-7fd8dfef5b63@ess.eu>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 15, 2020 at 01:56:21PM +0100, Hinko Kocevar wrote:
> I noticed the change you are pointing out when trying to propose a patch.
> 
> It made me curious on why the pcie_portdrv_slot_reset() is not invoked.
> 
> After sprinkling a couple of printk()'s around the pcie_do_recovery() and
> pcie_portdrv_err_handler's I can observe that the pcie_portdrv_slot_reset()
> is never called from pcie_do_recovery() due to status returned by
> reset_subordinates() (actually aer_root_reset() from pcie/aer.c) being
> PCI_ERS_RESULT_RECOVERED.
> 
> I reckon, in order to invoke the pcie_portdrv_slot_reset(), the
> aer_root_reset() should have returned PCI_ERS_RESULT_NEED_RESET.
> 
> As soon as I plug the calls to pci_restore_state() and pci_save_state() into
> the pcie_portdrv_err_resume() the bus and devices are operational again.

It appears some sequences in the aer handling are out of sync with at
least a few driver's expectations. The .slot_reset callback is for when
'PCI slot has been reset' according the the code comments, so we should
be calling this after the reset to notify driver's of downstream devices
that event occured. I'll mess with it a bit and see if we can get
everyone aligned.
