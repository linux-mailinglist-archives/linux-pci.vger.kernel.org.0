Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63D283D2F4E
	for <lists+linux-pci@lfdr.de>; Thu, 22 Jul 2021 23:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbhGVVDS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Jul 2021 17:03:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:45944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231607AbhGVVDR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Jul 2021 17:03:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2995760C41;
        Thu, 22 Jul 2021 21:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626990232;
        bh=2kvR1xHEV7E/jIz++TVbdoqI/mjjjq/kQh4TSnyo864=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=BBzT1S1REZ4FbZ3eSY6GK7KAKUw5CgpyHRHnmZDbsFy9Bu8FAlhXeqVfFwxvSUUi2
         BOsaqw97Lr34o1zzsQSinyvy039PWWG/S65dXZS/zgAdVN6E0BJr4K9fwvUz5W5ZHW
         pPNNnS+4v9+8BJRyosHEpXmvmTqdr+B8g5DoFUvdiDq23QZw62Nc8j8uJNQ3k5jODp
         QDP59EzOJb5xm3DEpF/SiFFExtYSKMCiZU3/+HwB3MI/ar5L9wiXc/wEVq+zh6titg
         HraKC7XtrqcrDPo2QdlrhNyDjSFX2F6NywoSTipBT09c7s6nmCqtE9RIKu+U27zmBh
         gb3arNT9R1rFQ==
Date:   Thu, 22 Jul 2021 16:43:50 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org
Subject: Re: [patch 0/8] PCI/MSI, x86: Cure a couple of inconsistencies
Message-ID: <20210722214350.GA349746@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721191126.274946280@linutronix.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 21, 2021 at 09:11:26PM +0200, Thomas Gleixner wrote:
> A recent discussion about the PCI/MSI management for virtio unearthed a
> violation of the MSI-X specification vs. writing the MSI-X message: under
> certain circumstances the entry is written without being masked.
> 
> While looking at that and the related violation of the x86 non-remapped
> interrupt affinity mechanism a few other issues were discovered by
> inspection.
> 
> The following series addresses these.
> 
> Note this does not fix the virtio issue, but while staring at the above
> problems I came up with a plan to address this. I'm still trying to
> convince myself that I can get away without sprinkling locking all over the
> place, so don't hold your breath that this will materialize tomorrow.
> 
> The series is also available from git:
> 
>     git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git irq/msi
> 
> Thanks,
> 
> 	tglx
> ---
>  arch/x86/kernel/apic/io_apic.c |    6 +-
>  arch/x86/kernel/apic/msi.c     |   11 +++-
>  arch/x86/kernel/hpet.c         |    2 
>  drivers/pci/msi.c              |   98 +++++++++++++++++++++++++++--------------
>  include/linux/irq.h            |    2 
>  kernel/irq/chip.c              |    5 +-
>  6 files changed, 85 insertions(+), 39 deletions(-)

Acked-by: Bjorn Helgaas <bhelgaas@google.com> for the PCI pieces.

I'm happy to take the whole series via PCI, given an x86 ack.  Or you
can merge with my ack.

