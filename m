Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A63237E726
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2019 02:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732196AbfHBAYr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Aug 2019 20:24:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:45812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729359AbfHBAYr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Aug 2019 20:24:47 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A82D6206A3;
        Fri,  2 Aug 2019 00:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564705486;
        bh=KzNocgptr3atsBh5WELd0hq9znXO426VvX/fm+IJhug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0gfrH+8bYUaQB8OB0qSm3FlVb3htQnV+rWVUqsP+TFG8vjmBkEKezzIKpxRHIk5fn
         nb90R7GKv+gsx0jiSw3DQ4DbzwuTwNLJS8C/oDaFoQzpqTBa0UKoyyX2grc/OyME6r
         cQ2fW+8mkqBsyrZiTkQsv8c04PGCTQ0r+ARBjK/s=
Date:   Thu, 1 Aug 2019 19:24:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Megha Dey <megha.dey@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, marc.zyngier@arm.com, ashok.raj@intel.com,
        jacob.jun.pan@linux.intel.com, megha.dey@intel.com
Subject: Re: [RFC V1 RESEND 0/6] Introduce dynamic allocation/freeing of
 MSI-X vectors
Message-ID: <20190802002442.GI151852@google.com>
References: <1561162778-12669-1-git-send-email-megha.dey@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1561162778-12669-1-git-send-email-megha.dey@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Megha,

On Fri, Jun 21, 2019 at 05:19:32PM -0700, Megha Dey wrote:
> Currently, MSI-X vector enabling and allocation for a PCIe device is
> static i.e. a device driver gets only one chance to enable a specific
> number of MSI-X vectors, usually during device probe. Also, in many
> cases, drivers usually reserve more than required number of vectors
> anticipating their use, which unnecessarily blocks resources that
> could have been made available to other devices. Lastly, there is no
> way for drivers to reserve more vectors, if the MSI-x has already been
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
> 
> Megha Dey (6):
>   PCI/MSI: New structures/macros for dynamic MSI-X allocation
>   PCI/MSI: Dynamic allocation of MSI-X vectors by group
>   x86: Introduce the dynamic teardown function
>   PCI/MSI: Introduce new structure to manage MSI-x entries

s/MSI-x/MSI-X/
If "entries" here means the same as "vectors" above, please use the
same word.

>   PCI/MSI: Free MSI-X resources by group

Is "resources" the same as "vectors"?

>   Documentation: PCI/MSI: Document dynamic MSI-X infrastructure

When you post a v2 after addressing Thomas' comments, please make
these subject lines imperative sentences beginning with a descriptive
verb.  You can run "git log --oneline drivers/pci" to see the style.
If you're adding a specific interface or structure, mention it by name
in the subject if it's practical.  The "x86" line needs a little more
context; I assume it should include "IRQ", "MSI-X", or something.

>  Documentation/PCI/MSI-HOWTO.txt |  38 +++++
>  arch/x86/include/asm/x86_init.h |   1 +
>  arch/x86/kernel/x86_init.c      |   6 +
>  drivers/pci/msi.c               | 363 +++++++++++++++++++++++++++++++++++++---
>  drivers/pci/probe.c             |   9 +
>  include/linux/device.h          |   3 +
>  include/linux/msi.h             |  13 ++
>  include/linux/pci.h             |  61 +++++++
>  kernel/irq/msi.c                |  34 +++-
>  9 files changed, 497 insertions(+), 31 deletions(-)
> 
> -- 
> 2.7.4
> 
