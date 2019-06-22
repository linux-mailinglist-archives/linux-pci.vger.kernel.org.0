Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C45944F212
	for <lists+linux-pci@lfdr.de>; Sat, 22 Jun 2019 02:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbfFVABT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jun 2019 20:01:19 -0400
Received: from mga11.intel.com ([192.55.52.93]:10826 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726070AbfFVABT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Jun 2019 20:01:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jun 2019 17:01:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,402,1557212400"; 
   d="scan'208";a="163039686"
Received: from megha-z97x-ud7-th.sc.intel.com ([143.183.85.162])
  by orsmga003.jf.intel.com with ESMTP; 21 Jun 2019 17:01:18 -0700
Message-ID: <1561163018.12836.1.camel@intel.com>
Subject: Re: [RFC V1 0/6] Introduce dynamic allocation/freeing of MSI-X
 vectors
From:   Megha Dey <megha.dey@intel.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org
Cc:     ashok.raj@intel.com, jacob.jun.pan@linux.intel.com
Date:   Fri, 21 Jun 2019 17:23:38 -0700
In-Reply-To: <1560981824-3966-1-git-send-email-megha.dey@linux.intel.com>
References: <1560981824-3966-1-git-send-email-megha.dey@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 2019-06-19 at 15:03 -0700, Megha Dey wrote:
> Currently, MSI-X vector enabling and allocation for a PCIe device is
> static i.e. a device driver gets only one chance to enable a specific
> number of MSI-X vectors, usually during device probe. Also, in many
> cases, drivers usually reserve more than required number of vectors
> anticipating their use, which unnecessarily blocks resources that
> could have been made available to other devices. Lastly, there is no
> way for drivers to reserve more vectors, if the MSI-x has already
> been
> enabled for that device.
>  
> Hence, a dynamic MSI-X kernel infrastructure can benefit drivers by
> deferring MSI-X allocation to post probe phase, where actual demand
> information is available.
>  
> This patchset enables the dynamic allocation/de-allocation of MSI-X
> vectors by introducing 2 new APIs:
> pci_alloc_irq_vectors_dyn() and pci_free_irq_vectors_grp():
> 
> We have had requests from some of the NIC/RDMA users who have lots of
> interrupt resources and would like to allocate them on demand,
> instead of using an all or none approach.
> 
> The APIs are fairly well tested (multiple allocations/deallocations),
> but we have no early adopters yet. Hence, sending this series as an
> RFC for review and comments.
> 
> The patches are based out of Linux 5.2-rc5.

I have resent the patches to include LKML.
https://lkml.org/lkml/2019/6/21/923

> 
> Megha Dey (6):
>   PCI/MSI: New structures/macros for dynamic MSI-X allocation
>   PCI/MSI: Dynamic allocation of MSI-X vectors by group
>   x86: Introduce the dynamic teardown function
>   PCI/MSI: Introduce new structure to manage MSI-x entries
>   PCI/MSI: Free MSI-X resources by group
>   Documentation: PCI/MSI: Document dynamic MSI-X infrastructure
> 
>  Documentation/PCI/MSI-HOWTO.txt |  38 +++++
>  arch/x86/include/asm/x86_init.h |   1 +
>  arch/x86/kernel/x86_init.c      |   6 +
>  drivers/pci/msi.c               | 363
> +++++++++++++++++++++++++++++++++++++---
>  drivers/pci/probe.c             |   9 +
>  include/linux/device.h          |   3 +
>  include/linux/msi.h             |  13 ++
>  include/linux/pci.h             |  61 +++++++
>  kernel/irq/msi.c                |  34 +++-
>  9 files changed, 497 insertions(+), 31 deletions(-)
> 
