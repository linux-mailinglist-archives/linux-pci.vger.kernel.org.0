Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7019439CFC
	for <lists+linux-pci@lfdr.de>; Mon, 25 Oct 2021 19:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234690AbhJYRKx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Oct 2021 13:10:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:60538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235207AbhJYRJJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Oct 2021 13:09:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7385960EE3;
        Mon, 25 Oct 2021 17:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635181606;
        bh=uhJMDAp/6lANSR2wbX+jf2O7qM4e7RYNtaW7xvDtw/4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=uaJRVHXZzko8RT7ie/I6pDSvZITLf0raKfzP1f6fJ0hED+h9PyLG4hIHpRq7eQG9M
         HTEaNZyJa21bX7pk/2BRj35jfZxMYlq4ahI3zGdUZnpBozvExg5FOiGaGkIjXukt5x
         ChojxwF8LN8pZ+q6htwYxpvB1H+7d9mZRcTd1OlN7A40s3WkS6sV5NGParlOSQnzfY
         7M6JJZCP0lugvcvKRNtsc1hV4XVd3BxJ75v59qD6km+4vBnMVxH8bDYKc1TSTub2TX
         LKKjQkZdyKEhB0LzTaEqQ5t795cADx0QzmrbcsPVaDNBFdEj4BWkQO8pSqhFrcV8vd
         Nr4RZzXfL1vLQ==
Date:   Mon, 25 Oct 2021 12:06:45 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     linux-pci@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: PCI/VPD: recursive loop issue with lspci
Message-ID: <20211025170645.GA10265@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f7e3770-ab47-42b5-719c-f7c661c07d28@socionext.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 26, 2021 at 12:51:07AM +0900, Kunihiko Hayashi wrote:
> Hi all,
> 
> I found that "lspci -vv" causes a recursive loop in the linux-next kernel.
> As a result, the kernel crashed on stack overflow.
> 
> This issue was reproduced using Akebi96 board with UniPhier LD20 and DWC3 PCIe
> controller, and R8169 ethernet card.
> 
> # lspci -s 01:00.0 -vv
> 01:00.0 Class 0200: Device 10ec:8168 (rev 06)
> [   19.152157] Insufficient stack space to handle exception!
> ...
> [   19.152449] Hardware name: Akebi96 (DT)
> [   19.152455] Call trace:
> [   19.152458]  dump_backtrace+0x0/0x1b0
> [   19.152484]  show_stack+0x20/0x30
> [   19.152503]  dump_stack_lvl+0x68/0x84
> [   19.152525]  dump_stack+0x18/0x34
> [   19.152542]  panic+0x154/0x34c
> [   19.152556]  nmi_panic+0x94/0x98
> [   19.152577]  panic_bad_stack+0xec/0x100
> [   19.152590]  handle_bad_stack+0x38/0x68
> [   19.152606]  __bad_stack+0x8c/0x90
> [   19.152620]  pci_vpd_read+0xc/0x1f8
> [   19.152639]  pci_vpd_size+0x58/0x1a0
> [   19.152651]  pci_vpd_read+0x1a0/0x1f8
> [   19.152669]  __pci_read_vpd+0x94/0xc0
> [   19.152681]  pci_vpd_size+0x58/0x1a0
> [   19.152692]  pci_vpd_read+0x1a0/0x1f8
> [   19.152710]  __pci_read_vpd+0x94/0xc0
> [   19.152722]  pci_vpd_size+0x58/0x1a0
> [   19.152734]  pci_vpd_read+0x1a0/0x1f8
> [   19.152752]  __pci_read_vpd+0x94/0xc0
> ...
> [   19.155039]  pci_vpd_size+0x58/0x1a0
> [   19.155051]  pci_vpd_read+0x1a0/0x1f8
> [   19.155069]  __pci_read_vpd+0x94/0xc0
> [   19.155081]  pci_vpd_size+0x58/0x1a0
> [   19.155093]  pci_vpd_read+0x1a0/0x1f8
> [   19.155111]  __pci_read_vpd+0x94/0xc0
> [   19.155124]  pci_vpd_size+0x58/0x1a0
> [   19.155136]  pci_vpd_read+0x1a0/0x1f8
> [   19.155153]  __pci_read_vpd+0x94/0xc0
> [   19.155166]  vpd_read+0x28/0x38
> [   19.155177]  sysfs_kf_bin_read+0x74/0x98
> 
> In the following commit, initialization of dev->vpd.len has been removed.
> 
>     commit 80484b7f8db101119928c73e7ce09ae6be54e45c
>         PCI/VPD: Use pci_read_vpd_any() in pci_vpd_size()
> 
> When calling pci_read_vpd_any(), if dev->vpd.len is zero, pci_vpd_size()
> will continue to be called recursively.
> 
>     pci_vpd_available()			// dev->vpd.len == 0
>      -> pci_vpd_size()
>         -> pci_read_vpd_any()
>            -> __pci_read_vpd()
>               -> pci_vpd_read()
>                  -> pci_vpd_available()	// dev->vpd.len == 0
>                     -> pci_vpd_size()
>                        ...
> 
> This issue didn't occur before applying this commit.
> Does anyone run into the same issue?

Likely this patch:

  https://lore.kernel.org/r/6211be8a-5d10-8f3a-6d33-af695dc35caf@gmail.com

which I obviously need to move to the top of my list.  If you can
confirm that this fixes it, that would be awesome!

Bjorn
