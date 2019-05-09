Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E76E18EB4
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2019 19:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfEIRKn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 May 2019 13:10:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:50214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbfEIRKn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 May 2019 13:10:43 -0400
Received: from localhost (50-81-63-4.client.mchsi.com [50.81.63.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C2ED2173C;
        Thu,  9 May 2019 17:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557421842;
        bh=ePDT910qeCCB9+pl2V+45tNJ6H0z2LowBahjSs0X0hY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0UwfT/Y8RegfplmoTwREBxXtcS/YHnWJijH6uSUGsfNprFHOdFI7ARADjEw8M8Nw1
         DKfE5pz0SIUR7Ka1JGxnDZyIuCGZMGmp0Gdz+e4Dmj4xS/roJGBtj9kaXceXqh8TqL
         UkS5uDDeWhnOhZBz9Nl9kP/bY0I0Afv7dcT4HYUA=
Date:   Thu, 9 May 2019 12:10:40 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Frederick Lawler <fred@fredlawl.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Dongdong Liu <liudongdong3@huawei.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/10] PCI: Log with pci_dev, not pcie_device
Message-ID: <20190509171040.GA235064@google.com>
References: <20190509141456.223614-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509141456.223614-1-helgaas@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 09, 2019 at 09:14:46AM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> This is a collection of updates to Fred's v2 patches from:
> 
>   https://lore.kernel.org/lkml/20190503035946.23608-1-fred@fredlawl.com
> 
> and some follow-on discussion.
> 
> Bjorn Helgaas (3):
>   PCI: pciehp: Remove pciehp_debug uses
>   PCI: pciehp: Remove pointless PCIE_MODULE_NAME definition
>   PCI: pciehp: Remove pointless MY_NAME definition
> 
> Frederick Lawler (7):
>   PCI/AER: Replace dev_printk(KERN_DEBUG) with dev_info()
>   PCI/PME: Replace dev_printk(KERN_DEBUG) with dev_info()
>   PCI/DPC: Log messages with pci_dev, not pcie_device
>   PCI/AER: Log messages with pci_dev, not pcie_device
>   PCI: pciehp: Replace pciehp_debug module param with dyndbg
>   PCI: pciehp: Log messages with pci_dev, not pcie_device
>   PCI: pciehp: Remove unused dbg/err/info/warn() wrappers
> 
>  drivers/pci/hotplug/pciehp.h      | 31 +++++++-------------------
>  drivers/pci/hotplug/pciehp_core.c | 18 +++++++--------
>  drivers/pci/hotplug/pciehp_ctrl.c |  2 ++
>  drivers/pci/hotplug/pciehp_hpc.c  | 17 +++++++-------
>  drivers/pci/hotplug/pciehp_pci.c  |  2 ++
>  drivers/pci/pcie/aer.c            | 32 ++++++++++++++------------
>  drivers/pci/pcie/aer_inject.c     | 22 +++++++++---------
>  drivers/pci/pcie/dpc.c            | 37 +++++++++++++++----------------
>  drivers/pci/pcie/pme.c            | 10 +++++----
>  9 files changed, 82 insertions(+), 89 deletions(-)

I applied these to pci/printk-portdrv with Keith's reviewed-by, hoping to
still squeeze these into v5.2.
