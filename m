Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D136918A0C5
	for <lists+linux-pci@lfdr.de>; Wed, 18 Mar 2020 17:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgCRQnX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Mar 2020 12:43:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:51924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726775AbgCRQnX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Mar 2020 12:43:23 -0400
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96F4C20752;
        Wed, 18 Mar 2020 16:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584549802;
        bh=xkRZWv2qz/inCyPXDYapigGDKiogZ8MvrCnbzJ0+SYA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YagajiTAAdWytDxLvsbXxdjw4DDyb8Kak0ZqpN0vfUTz86e4B8p+1u8ZMqb9l5FKN
         xqPG36qEAp4YrGAl0l9J5kPU4ShPUhUVWwHWbxP0wBecMy5WtqIeIk0w8iyNVqyRD2
         QUzeTlUGWaJqs6K4PANIqmjjsIOwvO5KqAl2N5vU=
Date:   Thu, 19 Mar 2020 01:43:15 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        David Hoyer <David.Hoyer@netapp.com>,
        linux-pci@vger.kernel.org,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: Re: [PATCH] PCI: pciehp: Fix indefinite wait on sysfs requests
Message-ID: <20200318164315.GA22361@redsun51.ssa.fujisawa.hgst.com>
References: <DM5PR06MB313235E97731D97AB813F65D92FB0@DM5PR06MB3132.namprd06.prod.outlook.com>
 <cca1effa488065cb055120aa01b65719094bdcb5.1584530321.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cca1effa488065cb055120aa01b65719094bdcb5.1584530321.git.lukas@wunner.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 18, 2020 at 12:33:12PM +0100, Lukas Wunner wrote:
> Fixes: 54ecb8f7028c ("PCI: pciehp: Avoid returning prematurely from sysfs requests")
> Reported-by: David Hoyer <David.Hoyer@netapp.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v4.19+
> Cc: Keith Busch <kbusch@kernel.org>

Looks good to me.

Reviewed-by: Keith Busch <kbusch@kernel.org>

>  drivers/pci/hotplug/pciehp_hpc.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index e4627c68b30f..5f1a27bfcb19 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -663,17 +663,15 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
>  	if (atomic_fetch_and(~RERUN_ISR, &ctrl->pending_events) & RERUN_ISR) {
>  		ret = pciehp_isr(irq, dev_id);
>  		enable_irq(irq);
> -		if (ret != IRQ_WAKE_THREAD) {
> -			pci_config_pm_runtime_put(pdev);
> -			return ret;
> -		}
> +		if (ret != IRQ_WAKE_THREAD)
> +			goto out;
>  	}
>  
>  	synchronize_hardirq(irq);
>  	events = atomic_xchg(&ctrl->pending_events, 0);
>  	if (!events) {
> -		pci_config_pm_runtime_put(pdev);
> -		return IRQ_NONE;
> +		ret = IRQ_NONE;
> +		goto out;
>  	}
>  
>  	/* Check Attention Button Pressed */
> @@ -702,10 +700,12 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
>  		pciehp_handle_presence_or_link_change(ctrl, events);
>  	up_read(&ctrl->reset_lock);
>  
> +	ret = IRQ_HANDLED;
> +out:
>  	pci_config_pm_runtime_put(pdev);
>  	ctrl->ist_running = false;
>  	wake_up(&ctrl->requester);
> -	return IRQ_HANDLED;
> +	return ret;
>  }
>  
>  static int pciehp_poll(void *data)
> -- 
> 2.25.0
> 
