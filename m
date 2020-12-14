Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC4B52DA289
	for <lists+linux-pci@lfdr.de>; Mon, 14 Dec 2020 22:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503643AbgLNVYJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Dec 2020 16:24:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:43358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2503632AbgLNVYG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Dec 2020 16:24:06 -0500
Date:   Tue, 15 Dec 2020 06:23:19 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607981006;
        bh=ua1mvQkfPJ0msnNX7f1dlE0XqK2yBWOb3Gp0/Wh4O/I=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=CTOsgUOyxnBRo5XE4GtIQB+PkXwQVm4tBcMSqcPJ1lw8kmRhwvDIhlG75ks4fM+Uk
         FbBIxp2ZPzWYciXWNahTxGdxCOBo2431wW8U6oyg1dxdHMCWt1j2tLPclElpOU6hEr
         1ppg6IotSnSVhH9kueSdDB3YOuP9SDnOj9grL3u/Gobs1Lj+zqc4mCZRa8FS/0kqoC
         qi1ULjgZ92aQZ6Walojp8mkLOorKq1o9m08i8rptnVSUkgHi1/jznz++DHBT5kKnmz
         yzoJ5R77uQ3iTd+XhF2Bex5pU1QTFsInT+9xAJLKWOieu8u469aPqyHlFvndnIfjRz
         rVNOV+BaAhjww==
From:   Keith Busch <kbusch@kernel.org>
To:     Hinko Kocevar <hinko.kocevar@ess.eu>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: Recovering from AER: Uncorrected (Fatal) error
Message-ID: <20201214212319.GB22809@redsun51.ssa.fujisawa.hgst.com>
References: <20201209213227.GA2544987@bjorn-Precision-5520>
 <6234c1c4-a8cc-1bd6-8366-f359b9b5ef54@ess.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6234c1c4-a8cc-1bd6-8366-f359b9b5ef54@ess.eu>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 09, 2020 at 11:55:07PM +0100, Hinko Kocevar wrote:
> Adding a bunch of printk()'s to portdrv_pci.c led to (partial) success!
> 
> So, the pcie_portdrv_error_detected() returns PCI_ERS_RESULT_CAN_RECOVER and
> therefore the pcie_portdrv_slot_reset() is not called.
> 
> But the pcie_portdrv_err_resume() is called! Adding these two lines to
> pcie_portdrv_err_resume(), before the call to device_for_each_child():
> 
>         pci_restore_state(dev);
>         pci_save_state(dev);

You need to do that with the current kernel or are you still using a
3.10? A more recent kernel shouldn't have needed such a fix after the
following commit was introduced:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=874b3251113a1e2cbe79c24994dc03fe4fe4b99b
