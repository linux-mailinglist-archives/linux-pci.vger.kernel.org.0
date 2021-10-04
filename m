Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 467BF4208CC
	for <lists+linux-pci@lfdr.de>; Mon,  4 Oct 2021 11:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbhJDJzn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Oct 2021 05:55:43 -0400
Received: from foss.arm.com ([217.140.110.172]:59702 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232161AbhJDJzn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Oct 2021 05:55:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A80C0D6E;
        Mon,  4 Oct 2021 02:53:54 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB9D83F766;
        Mon,  4 Oct 2021 02:53:53 -0700 (PDT)
Date:   Mon, 4 Oct 2021 10:53:51 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        pali@kernel.org
Subject: Re: [PATCH 00/13] PCI: aardvark controller fixes
Message-ID: <20211004095351.GB22827@lpieralisi>
References: <20211001195856.10081-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211001195856.10081-1-kabel@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 01, 2021 at 09:58:43PM +0200, Marek Behún wrote:
> Hi Lorenzo,
> 
> this series fixes some issues with the Aardvark PCIe controller driver.
> 
> Most of them are small changes. Patch 11 has a rather long commit message
> since it explains how the bugs were introduced from multiple misleading
> names and comments of some registers.
> 
> We have another 56 fixes for aardvark, but last time nobody wanted to
> review such a large series, so we are now trying in smaller batches.
> 
> It would be great if you could find time to review, since we would like
> this to land in 5.16. Preferably we would like to send another batch for
> 5.16, but we will see how fast this one goes
> 
> Marek & Pali

OK, so what's the overlap between this series and:

https://patchwork.kernel.org/user/todo/linux-pci/?series=506773

https://patchwork.kernel.org/user/todo/linux-pci/?series=507035

I need to keep track of reviews in the series above and make
sure they are reflected into *this* series if some of the
patches overlap or they are a rework.

Please let me know, thank you.

Lorenzo

> Marek Behún (2):
>   PCI: aardvark: Don't spam about PIO Response Status
>   PCI: aardvark: Deduplicate code in advk_pcie_rd_conf()
> 
> Pali Rohár (11):
>   PCI: Add PCI_EXP_DEVCTL_PAYLOAD_* macros
>   PCI: aardvark: Fix PCIe Max Payload Size setting
>   PCI: aardvark: Fix preserving PCI_EXP_RTCTL_CRSSVE flag on emulated
>     bridge
>   PCI: aardvark: Fix configuring Reference clock
>   PCI: aardvark: Do not clear status bits of masked interrupts
>   PCI: aardvark: Do not unmask unused interrupts
>   PCI: aardvark: Implement re-issuing config requests on CRS response
>   PCI: aardvark: Simplify initialization of rootcap on virtual bridge
>   PCI: aardvark: Fix link training
>   PCI: aardvark: Fix checking for link up via LTSSM state
>   PCI: aardvark: Fix reporting Data Link Layer Link Active
> 
>  drivers/pci/controller/pci-aardvark.c | 364 +++++++++++++++-----------
>  include/uapi/linux/pci_regs.h         |   6 +
>  2 files changed, 212 insertions(+), 158 deletions(-)
> 
> -- 
> 2.32.0
> 
