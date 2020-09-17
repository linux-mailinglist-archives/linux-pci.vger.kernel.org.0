Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0FC26E18F
	for <lists+linux-pci@lfdr.de>; Thu, 17 Sep 2020 19:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbgIQRBN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Sep 2020 13:01:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:43692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728849AbgIQRBH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Sep 2020 13:01:07 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6F8F206A2;
        Thu, 17 Sep 2020 17:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600362067;
        bh=xTesHD8rdcJzcKgn8TNOGI+Q5BfNGqKv4PuZ7vzy6Wk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=vllloxOlsMFSa6EIckEWJnrf9q/KUPFw/55ooylh4Jz0PORZMpbLB+W0fTjuPtazN
         ltl6mqSTAIj1EOUz0XFN+F0dHmBkeidFTh19S/V+xNTsYLo1ntqRWoKJ30pjljp/gJ
         7fsNv7eRT6L/LqgO6kieX93lOyrX1LKcIAUJ1Zt8=
Date:   Thu, 17 Sep 2020 12:01:05 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dongdong Liu <liudongdong3@huawei.com>
Cc:     linux-pci@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH] PCI/LINK: Print IRQ number used by port
Message-ID: <20200917170105.GA1709114@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599737055-73624-1-git-send-email-liudongdong3@huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 10, 2020 at 07:24:15PM +0800, Dongdong Liu wrote:
> Print IRQ number used by PCIe Link Bandwidth Notification services port
> as AER, PME and DPC does. It provides convenience to track PCIe BW notif
> interrupts counts of certain port from /proc/interrupts.
> 
> The dmesg log is as below.
> pcieport 0000:00:00.0: bw_notification: enabled with IRQ 1166
> 
> Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>

Applied to pci/misc for v5.10, thanks!

> ---
>  drivers/pci/pcie/bw_notification.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/pcie/bw_notification.c b/drivers/pci/pcie/bw_notification.c
> index 77e6857..565d23c 100644
> --- a/drivers/pci/pcie/bw_notification.c
> +++ b/drivers/pci/pcie/bw_notification.c
> @@ -14,6 +14,8 @@
>   * and warns when links become degraded in operation.
>   */
>  
> +#define dev_fmt(fmt) "bw_notification: " fmt
> +
>  #include "../pci.h"
>  #include "portdrv.h"
>  
> @@ -97,6 +99,7 @@ static int pcie_bandwidth_notification_probe(struct pcie_device *srv)
>  		return ret;
>  
>  	pcie_enable_link_bandwidth_notification(srv->port);
> +	pci_info(srv->port, "enabled with IRQ %d\n", srv->irq);
>  
>  	return 0;
>  }
> -- 
> 1.9.1
> 
