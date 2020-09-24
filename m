Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22AA62776A6
	for <lists+linux-pci@lfdr.de>; Thu, 24 Sep 2020 18:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbgIXQYp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Sep 2020 12:24:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:45966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726516AbgIXQYo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Sep 2020 12:24:44 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2B3D238E3;
        Thu, 24 Sep 2020 16:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600964684;
        bh=vFQ/jlTzhlIN2us7zr7mpKdkocgl+KGTCuVffTtovC4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ft0gchCDOdWmf8uY3Pux9ul9+2UGwTUzZZGFmzUC9lo8iFgbuh3riaz2BMx7w0u/9
         apKSnNzdRqe5ahiR5zoC3vMjgh6LLTm7hgDbCguiRO5MQo2V6gfUZgqCXhBOESatiB
         Ij5nIFD8pO/QqrkqgJmDVCcto6nPk6UXBUdB4QLU=
Date:   Thu, 24 Sep 2020 11:24:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ian Kumlien <ian.kumlien@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Subject: Re: [PATCH] Use maximum latency when determining L1/L0s ASPM v2
Message-ID: <20200924162442.GA2321475@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA85sZvm5SyiG_AE3=4Xowz4AYuMW38uvw8QJ5D8WL3=1Tkv7w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 23, 2020 at 11:36:00PM +0200, Ian Kumlien wrote:

> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=66ff14e59e8a
> 
> "7d715a6c1ae5 ("PCI: add PCI Express ASPM support") added the ability for
> Linux to enable ASPM, but for some undocumented reason, it didn't enable
> ASPM on links where the downstream component is a PCIe-to-PCI/PCI-X Bridge.
> 
> Remove this exclusion so we can enable ASPM on these links."
> ...

> And all of this worked before the commit above.

OK, really sorry, I got myself totally confused here, and I need to
start over from scratch.  Correct me when I go off the rails.

You're running 5.8.11+, and you get ~40 Mbit/s on the Intel I211 NIC.
Reverting 66ff14e59e8a ("PCI/ASPM: Allow ASPM on links to
PCIe-to-PCI/PCI-X Bridges") gets your bandwidth up to the 900+ Mbit/s
you expect.

66ff14e59e8a only makes a difference if you have a PCIe-to-PCI/PCI-X
Bridge (PCI_EXP_TYPE_PCI_BRIDGE) in your system.  But from your lspci
and pci=earlydump output, I don't see any of those.  The only bridges
I see are:

[    0.810346] pci 0000:00:01.2: [1022:1483] type 01 Root Port to [bus 01-07]
[    0.810587] pci 0000:00:03.1: [1022:1483] type 01 Root Port to [bus 08]
[    0.810587] pci 0000:00:03.2: [1022:1483] type 01 Root Port to [bus 09]
[    0.810837] pci 0000:00:07.1: [1022:1484] type 01 Root Port to [bus 0a]
[    0.811587] pci 0000:00:08.1: [1022:1484] type 01 Root Port to [bus 0b]
[    0.812586] pci 0000:01:00.0: [1022:57ad] type 01 Upstream Port to [bus 02-07]
[    0.812629] pci 0000:02:03.0: [1022:57a3] type 01 Downstream Port to [bus 03]
[    0.813584] pci 0000:02:04.0: [1022:57a3] type 01 Downstream Port to [bus 04]
[    0.814584] pci 0000:02:08.0: [1022:57a4] type 01 Downstream Port to [bus 05]
[    0.815584] pci 0000:02:09.0: [1022:57a4] type 01 Downstream Port to [bus 06]
[    0.815584] pci 0000:02:0a.0: [1022:57a4] type 01 Downstream Port to [bus 07]

So I'm lost right off the bat.  You have no PCI_EXP_TYPE_PCI_BRIDGE
device, so how can 66ff14e59e8a make a difference for you?

Can you add a printk there, e.g.,

        list_for_each_entry(child, &linkbus->devices, bus_list) {
                if (pci_pcie_type(child) == PCI_EXP_TYPE_PCI_BRIDGE) {
  +                     pci_info(child, "PCIe-to-PCI bridge, disabling ASPM\n");
                        link->aspm_disable = ASPM_STATE_ALL;
                        break;
                }
        }

