Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB5F471F4
	for <lists+linux-pci@lfdr.de>; Sat, 15 Jun 2019 21:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbfFOT4Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 15 Jun 2019 15:56:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:33750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725270AbfFOT4Z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 15 Jun 2019 15:56:25 -0400
Received: from localhost (rrcs-162-155-246-179.central.biz.rr.com [162.155.246.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54E8E21852;
        Sat, 15 Jun 2019 19:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560628584;
        bh=5pzNQptnsFClJ3I2c85gaKDrOpQPFODNMKPCD018SjI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rv+CFhiHxXUmMtz5fRK1miEMBd1vnOt37iQb8fFkW919KHaPZmOuQlqevUQVzHQSV
         zbt1J1OBhPzVGZrjOPUKztc5tTGYiwBbpoCE3871p4zzGYSQ3d0viFnjDkh6TXXqHC
         1v4lAZr83v/Os0MBbHbF5rXIrYMxJm/ZDfdw88FE=
Date:   Sat, 15 Jun 2019 14:56:19 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v6 0/4] PCI: Patch series to support Thunderbolt without
 any BIOS support
Message-ID: <20190615195604.GW13533@google.com>
References: <PS2P216MB0642AD5BCA377FDC5DCD8A7B80000@PS2P216MB0642.KORP216.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PS2P216MB0642AD5BCA377FDC5DCD8A7B80000@PS2P216MB0642.KORP216.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Ben, Logan]

Ben, Logan, since you're looking at the resource code, maybe you'd be
interested in this as well?

On Wed, May 22, 2019 at 02:30:30PM +0000, Nicholas Johnson wrote:
> Rebase patches to apply cleanly to 5.2-rc1 source. Remove patch for 
> comment style cleanup as this has already been applied.

Thanks for rebasing these.

They do apply cleanly, but they seem to be base64-encoded MIME
attachments, and I don't know how to make mutt extract them easily.  I
had to save each patch attachment individually, apply it, insert the
commit log manually, etc.

Is there any chance you could send the next series as plain-text
patches?  That would be a lot easier for me.

> Anybody interested in testing, you can do so with:
> 
> a) Intel system with Thunderbolt 3 and native enumeration. The Gigabyte 
> Z390 Designare is one of the most perfect for this that I have never had 
> the opportunity to use - it does not even have the option for BIOS 
> assisted enumeration present in the BIOS.
> 
> b) Any system with PCIe and the Gigabyte GC-TITAN RIDGE add-in card, 
> jump the header as described and use kernel parameters like:
> 
> pci=assign-busses,hpbussize=0x33,realloc,hpmemsize=128M,hpmemprefsize=1G,nocrs 
> pcie_ports=native
> 
> [optional] pci.dyndbg
> 
>     ___
>  __/   \__
> |o o o o o| When looking into the receptacle on back of PCIe card.
> |_________| Jump pins 3 and 5.
> 
>  1 2 3 4 5
> 
> The Intel system is nice in that it should just work. The add-in card 
> setup is nice in that you can go nuts and assign copious amounts of 
> MMIO_PREF - can anybody show a Xeon Phi coprocessor with 16G BAR working 
> in an eGPU enclosure with these patches?
> 
> However, if you specify the above kernel parameters on the Intel system, 
> you should be able to override it to allocate more space.
> 
> Nicholas Johnson (4):
>   PCI: Consider alignment of hot-added bridges when distributing
>     available resources
>   PCI: Modify extend_bridge_window() to set resource size directly
>   PCI: Fix bug resulting in double hpmemsize being assigned to MMIO
>     window
>   PCI: Add pci=hpmemprefsize parameter to set MMIO_PREF size
>     independently
> 
>  .../admin-guide/kernel-parameters.txt         |   7 +-
>  drivers/pci/pci.c                             |  18 +-
>  drivers/pci/setup-bus.c                       | 265 ++++++++++--------
>  include/linux/pci.h                           |   3 +-
>  4 files changed, 167 insertions(+), 126 deletions(-)
> 
> -- 
> 2.20.1
> 
