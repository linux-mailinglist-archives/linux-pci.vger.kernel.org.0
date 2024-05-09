Return-Path: <linux-pci+bounces-7312-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2F08C18AB
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2024 23:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC4DBB2093E
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2024 21:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06496128833;
	Thu,  9 May 2024 21:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DKjs52i4"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A42128826
	for <linux-pci@vger.kernel.org>; Thu,  9 May 2024 21:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715291456; cv=none; b=RAGS9fq4icBidbIqOT/3Z38sgcZliSheEUw44RT/5OxVCrvzQmdVKQPE/rTAhSa6xr/RbV30aJaF5ioS9zQVOGkYE/D0hVCMRI8bjLzog3OpJ96QUqyoe4iXSJIFvoHrcaQdvE2s/55e4PsyRYUKJwCM1iLzfefREfECFGxc6wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715291456; c=relaxed/simple;
	bh=bb0dF2CqfEI2bRgZH2VWNgit4IJI5S1YcgCig5aMvZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tbVsjCKKNdeBa3z2X8sqiLLUmrt9pESGiAHZEp/jUDGGIttikVyBG0UeSNRwySme2KPx3WFigIyBxIEqjvIk/fL9GKFmFDX0uk2/DZvQLo+TlD7XDe0JErkZw8RfCdWXgB9A/oMpxUzVxwgkfwlcMyYMmriKjJbBi4VLnUkm2+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DKjs52i4; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <868a4758-2873-4ede-83e5-65f42cb12b81@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715291453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x7hxte+yN2kBW0kbRz2/Qi+5X2Kn+BAGAuWpBF10X3k=;
	b=DKjs52i4jmyGtfwbwo/aDOO4scg7otP0xU9TesqQGHy3gR0RiG3HaMz+xQsYejHm8aO2/B
	jFwXbjrXnl34x8jZp8VRWC+NcXZVXpB4MYP7+cT1ef15sDfmcRZyz5XFX6PTxNDb/3sYz1
	pJrwqVEcTl3s5FjsazqJS9FAcaRN7Ow=
Date: Thu, 9 May 2024 22:50:46 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH V1 8/9] bnxt_en: Add TPH support in BNXT driver
To: Wei Huang <wei.huang2@amd.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org
Cc: bhelgaas@google.com, corbet@lwn.net, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 alex.williamson@redhat.com, gospo@broadcom.com, michael.chan@broadcom.com,
 ajit.khaparde@broadcom.com, manoj.panicker2@amd.com, Eric.VanTassell@amd.com
References: <20240509162741.1937586-1-wei.huang2@amd.com>
 <20240509162741.1937586-9-wei.huang2@amd.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20240509162741.1937586-9-wei.huang2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 09/05/2024 17:27, Wei Huang wrote:
> From: Manoj Panicker <manoj.panicker2@amd.com>
> 
> As a usage example, this patch implements TPH support in Broadcom BNXT
> device driver by invoking pcie_tph_set_st() function when interrupt
> affinity is changed.
> 
> Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> Reviewed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Manoj Panicker <manoj.panicker2@amd.com>
> ---
>   drivers/net/ethernet/broadcom/bnxt/bnxt.c | 51 +++++++++++++++++++++++
>   drivers/net/ethernet/broadcom/bnxt/bnxt.h |  4 ++
>   2 files changed, 55 insertions(+)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 2c2ee79c4d77..be9c17566fb4 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -55,6 +55,7 @@
>   #include <net/page_pool/helpers.h>
>   #include <linux/align.h>
>   #include <net/netdev_queues.h>
> +#include <linux/pci-tph.h>
>   
>   #include "bnxt_hsi.h"
>   #include "bnxt.h"
> @@ -10491,6 +10492,7 @@ static void bnxt_free_irq(struct bnxt *bp)
>   				free_cpumask_var(irq->cpu_mask);
>   				irq->have_cpumask = 0;
>   			}
> +			irq_set_affinity_notifier(irq->vector, NULL);
>   			free_irq(irq->vector, bp->bnapi[i]);
>   		}
>   
> @@ -10498,6 +10500,45 @@ static void bnxt_free_irq(struct bnxt *bp)
>   	}
>   }
>   
> +static void bnxt_rtnl_lock_sp(struct bnxt *bp);
> +static void bnxt_rtnl_unlock_sp(struct bnxt *bp);
> +static void bnxt_irq_affinity_notify(struct irq_affinity_notify *notify,
> +				     const cpumask_t *mask)
> +{
> +	struct bnxt_irq *irq;
> +
> +	irq = container_of(notify, struct bnxt_irq, affinity_notify);
> +	cpumask_copy(irq->cpu_mask, mask);
> +
> +	if (!pcie_tph_set_st(irq->bp->pdev, irq->msix_nr,
> +			     cpumask_first(irq->cpu_mask),
> +			     TPH_MEM_TYPE_VM, PCI_TPH_REQ_TPH_ONLY))
> +		pr_err("error in configuring steering tag\n");
> +
> +	if (netif_running(irq->bp->dev)) {
> +		rtnl_lock();
> +		bnxt_close_nic(irq->bp, false, false);
> +		bnxt_open_nic(irq->bp, false, false);
> +		rtnl_unlock();
> +	}

Is it really needed? It will cause link flap and pause in the traffic
service for the device. Why the device needs full restart in this case?

> +}
> +
> +static void bnxt_irq_affinity_release(struct kref __always_unused *ref)
> +{
> +}
> +
> +static inline void __bnxt_register_notify_irqchanges(struct bnxt_irq *irq)

No inlines in .c files, please. Let compiler decide what to inline.

> +{
> +	struct irq_affinity_notify *notify;
> +
> +	notify = &irq->affinity_notify;
> +	notify->irq = irq->vector;
> +	notify->notify = bnxt_irq_affinity_notify;
> +	notify->release = bnxt_irq_affinity_release;
> +
> +	irq_set_affinity_notifier(irq->vector, notify);
> +}
> +
>   static int bnxt_request_irq(struct bnxt *bp)
>   {
>   	int i, j, rc = 0;
> @@ -10543,6 +10584,7 @@ static int bnxt_request_irq(struct bnxt *bp)
>   			int numa_node = dev_to_node(&bp->pdev->dev);
>   
>   			irq->have_cpumask = 1;
> +			irq->msix_nr = map_idx;
>   			cpumask_set_cpu(cpumask_local_spread(i, numa_node),
>   					irq->cpu_mask);
>   			rc = irq_set_affinity_hint(irq->vector, irq->cpu_mask);
> @@ -10552,6 +10594,15 @@ static int bnxt_request_irq(struct bnxt *bp)
>   					    irq->vector);
>   				break;
>   			}
> +
> +			if (!pcie_tph_set_st(bp->pdev, i,
> +					     cpumask_first(irq->cpu_mask),
> +					     TPH_MEM_TYPE_VM, PCI_TPH_REQ_TPH_ONLY)) {
> +				netdev_err(bp->dev, "error in setting steering tag\n");
> +			} else {
> +				irq->bp = bp;
> +				__bnxt_register_notify_irqchanges(irq);
> +			}
>   		}
>   	}
>   	return rc;
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> index dd849e715c9b..0d3442590bb4 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> @@ -1195,6 +1195,10 @@ struct bnxt_irq {
>   	u8		have_cpumask:1;
>   	char		name[IFNAMSIZ + 2];
>   	cpumask_var_t	cpu_mask;
> +
> +	int		msix_nr;
> +	struct bnxt	*bp;
> +	struct irq_affinity_notify affinity_notify;
>   };
>   
>   #define HWRM_RING_ALLOC_TX	0x1


