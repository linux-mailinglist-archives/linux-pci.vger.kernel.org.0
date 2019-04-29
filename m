Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 162B5DA10
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2019 02:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfD2ARL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 28 Apr 2019 20:17:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:53288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726223AbfD2ARL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 28 Apr 2019 20:17:11 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E7F620656;
        Mon, 29 Apr 2019 00:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556497029;
        bh=oG6Yu4j/Dt+FoonJfviNsLx4jjegkGBiqnZn0AdmUTE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1zvrhoZQieoigcwC87QQNYfTCrNcvfzgWSdrwQfu2RuYfbLjxt/oyZEf6++27LBz6
         Me+gqjRshaO/NydGhU3lmYWw2N7PuE97zeOudmiKZReE23OQ607uvPJDtW1XW0scgB
         zUKqhXT5fTekSE5F71QHTMYV7/Gp/YIx3L+RLn20=
Date:   Sun, 28 Apr 2019 19:17:08 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     fred@fredlawl.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mika.westerberg@linux.intel.com, lukas@wunner.de,
        andriy.shevchenko@linux.intel.com, keith.busch@intel.com,
        mr.nuke.me@gmail.com, liudongdong3@huawei.com, thesven73@gmail.com
Subject: Re: [PATCH 4/4] PCI/portdrv: Add dev_fmt() to port drivers
Message-ID: <20190429001708.GM14616@google.com>
References: <20190427191304.32502-1-fred@fredlawl.com>
 <20190427191304.32502-5-fred@fredlawl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190427191304.32502-5-fred@fredlawl.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Apr 27, 2019 at 02:13:04PM -0500, fred@fredlawl.com wrote:
> From: Frederick Lawler <fred@fredlawl.com>
> 
> Add dev_fmt() to port drivers.
> 
> Signed-off-by: Frederick Lawler <fred@fredlawl.com>
> ---
>  drivers/pci/hotplug/pciehp_core.c  | 3 +++
>  drivers/pci/hotplug/pciehp_ctrl.c  | 2 ++
>  drivers/pci/hotplug/pciehp_hpc.c   | 3 +++
>  drivers/pci/hotplug/pciehp_pci.c   | 2 ++
>  drivers/pci/pcie/aer.c             | 3 +++
>  drivers/pci/pcie/aer_inject.c      | 2 ++
>  drivers/pci/pcie/bw_notification.c | 2 ++
>  drivers/pci/pcie/dpc.c             | 2 ++
>  drivers/pci/pcie/pme.c             | 2 ++
>  9 files changed, 21 insertions(+)
> 
> diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
> index 430a47556813..b07d713fd4bd 100644
> --- a/drivers/pci/hotplug/pciehp_core.c
> +++ b/drivers/pci/hotplug/pciehp_core.c
> @@ -17,6 +17,9 @@
>   *   Dely Sy <dely.l.sy@intel.com>"
>   */
>  
> +#define pr_fmt(fmt) "pciehp: " fmt
> +#define dev_fmt(fmt) pr_fmt(fmt)

This should be in the same patch that converts from using the pcie_device
to the pci_dev.  That way the "pciehp" that came from the pcie_device is
atomically replaced with the "pciehp" from pr_fmt()/dev_fmt().

If you do it in separate patches, there's an intermediate stage where
there's no prefix at all, and we want to avoid that.

BTW, in most cases you can simply do this, which is slightly simpler:

  #define dev_fmt pr_fmt

>  #include <linux/moduleparam.h>
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
> diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
> index 345c02b1e8d7..969a9c72f65d 100644
> --- a/drivers/pci/hotplug/pciehp_ctrl.c
> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> @@ -13,6 +13,8 @@
>   *
>   */
>  
> +#define dev_fmt(fmt) "pciehp: " fmt
> +
>  #include <linux/kernel.h>
>  #include <linux/types.h>
>  #include <linux/pm_runtime.h>
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 28a132a0d9db..f2a3da105f5b 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -12,6 +12,9 @@
>   * Send feedback to <greg@kroah.com>,<kristen.c.accardi@intel.com>
>   */
>  
> +#define pr_fmt(fmt) "pciehp: " fmt
> +#define dev_fmt(fmt) pr_fmt(fmt)
> +
>  #include <linux/kernel.h>
>  #include <linux/types.h>
>  #include <linux/jiffies.h>
> diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
> index 55967ce567f6..04ccd535aca7 100644
> --- a/drivers/pci/hotplug/pciehp_pci.c
> +++ b/drivers/pci/hotplug/pciehp_pci.c
> @@ -13,6 +13,8 @@
>   *
>   */
>  
> +#define dev_fmt(fmt) "pciehp: " fmt
> +
>  #include <linux/kernel.h>
>  #include <linux/types.h>
>  #include <linux/pci.h>
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 224d878a28b4..6fd67285423d 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -12,6 +12,9 @@
>   *    Andrew Patterson <andrew.patterson@hp.com>
>   */
>  
> +#define pr_fmt(fmt) "AER: " fmt
> +#define dev_fmt(fmt) pr_fmt(fmt)
> +
>  #include <linux/cper.h>
>  #include <linux/pci.h>
>  #include <linux/pci-acpi.h>
> diff --git a/drivers/pci/pcie/aer_inject.c b/drivers/pci/pcie/aer_inject.c
> index 610b617ae600..d4f6d49acd0c 100644
> --- a/drivers/pci/pcie/aer_inject.c
> +++ b/drivers/pci/pcie/aer_inject.c
> @@ -12,6 +12,8 @@
>   *     Huang Ying <ying.huang@intel.com>
>   */
>  
> +#define dev_fmt(fmt) "AER: " fmt
> +
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/irq.h>
> diff --git a/drivers/pci/pcie/bw_notification.c b/drivers/pci/pcie/bw_notification.c
> index d2eae3b7cc0f..a4bb90562cd5 100644
> --- a/drivers/pci/pcie/bw_notification.c
> +++ b/drivers/pci/pcie/bw_notification.c
> @@ -14,6 +14,8 @@
>   * and warns when links become degraded in operation.
>   */
>  
> +#define dev_fmt(fmt) "BWN: " fmt
> +
>  #include "../pci.h"
>  #include "portdrv.h"
>  
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index 72659286191b..b3c10cdc508a 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -6,6 +6,8 @@
>   * Copyright (C) 2016 Intel Corp.
>   */
>  
> +#define dev_fmt(fmt) "DPC: " fmt
> +
>  #include <linux/aer.h>
>  #include <linux/delay.h>
>  #include <linux/interrupt.h>
> diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
> index 54d593d10396..d6698423a6d6 100644
> --- a/drivers/pci/pcie/pme.c
> +++ b/drivers/pci/pcie/pme.c
> @@ -7,6 +7,8 @@
>   * Copyright (C) 2009 Rafael J. Wysocki <rjw@sisk.pl>, Novell Inc.
>   */
>  
> +#define dev_fmt(fmt) "PME: " fmt
> +
>  #include <linux/pci.h>
>  #include <linux/kernel.h>
>  #include <linux/errno.h>
> -- 
> 2.17.1
> 
