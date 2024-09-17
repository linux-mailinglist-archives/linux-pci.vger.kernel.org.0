Return-Path: <linux-pci+bounces-13254-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 963CE97AC3C
	for <lists+linux-pci@lfdr.de>; Tue, 17 Sep 2024 09:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58264288FD3
	for <lists+linux-pci@lfdr.de>; Tue, 17 Sep 2024 07:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1780613E022;
	Tue, 17 Sep 2024 07:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gi92DjyY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D949A10F4;
	Tue, 17 Sep 2024 07:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726558543; cv=none; b=SpJsohLufi2fJDndneP4Gs2x43H/GlvXK+2zgeHA6by5Pr/AHhKWna+Jn4FihHS7R6dxNTYFc+gwnV3aMV5kYiupkiy2hm5Wt6QCNZdk8hdJUDQaxMx1MDQmh00xkRkbEUWEXH8VXUpgrQMG7ab97fazN1a5jmq6CDyj8RQAc7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726558543; c=relaxed/simple;
	bh=b769VKDrIsyHYUFOuBuTXdEnM2V0sH0E/dspVqolmlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=omwgMN87edbHGunnh/6TJACC9GTSUdkJOyF4ypCwl/MuXMMIVCEX+UC6kSDcq+FaKbIk9oyGfkBME9PlQWQhrgdmXUWe7w938CHFvAi7gJVRlH79vr6TFzGWBN5Pg229taCZF1psaHQZEyGeMbm1tuT5fOHq0MWZUgi2LYEukJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gi92DjyY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAED7C4CECE;
	Tue, 17 Sep 2024 07:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726558542;
	bh=b769VKDrIsyHYUFOuBuTXdEnM2V0sH0E/dspVqolmlQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gi92DjyYRGcKjng7ij/KzLsSrFPg9hxnsJP99zw56qAsWOEIA7b7xRguEzzR3qSR1
	 L3PTIBJISJwJ18Q/HTyY5y/KgI7iEH2SusokCjlw95hgJZmcaKxX2qnSMtKJ10lEJK
	 BqKdun/n5TRnVDRaz+PTxLnLYSNxVMTdgESyZFm0G7m9eqfBsWp/7rM80MKBNKOYwT
	 E1I0MLDyXBAOGNNmp3lv8KguyTv5lSGcyyQe8k4Mu5RPBKjQB4L35DARUteTDjQ7yu
	 Pk9ZNk5lw1ZsKcouWV94XPPypM3c8Tr6h582TZQ0Y0lbty3A2+favXieso1m96onKd
	 iwxezRgIE5IXw==
Date: Tue, 17 Sep 2024 08:35:35 +0100
From: Simon Horman <horms@kernel.org>
To: Wei Huang <wei.huang2@amd.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, netdev@vger.kernel.org,
	Jonathan.Cameron@huawei.com, helgaas@kernel.org, corbet@lwn.net,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, alex.williamson@redhat.com, gospo@broadcom.com,
	michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
	somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com,
	manoj.panicker2@amd.com, Eric.VanTassell@amd.com,
	vadim.fedorenko@linux.dev, bagasdotme@gmail.com,
	bhelgaas@google.com, lukas@wunner.de, paul.e.luse@intel.com,
	jing2.liu@intel.com
Subject: Re: [PATCH V5 4/5] bnxt_en: Add TPH support in BNXT driver
Message-ID: <20240917073535.GI167971@kernel.org>
References: <20240916205103.3882081-1-wei.huang2@amd.com>
 <20240916205103.3882081-5-wei.huang2@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916205103.3882081-5-wei.huang2@amd.com>

On Mon, Sep 16, 2024 at 03:51:02PM -0500, Wei Huang wrote:
> From: Manoj Panicker <manoj.panicker2@amd.com>
> 
> Implement TPH support in Broadcom BNXT device driver. The driver uses TPH
> functions to retrieve and configure the device's Steering Tags when its
> interrupt affinity is being changed. With appropriate firmware, we see
> sustancial memory bandwidth savings and other benefits using real network
> benchmarks.
> 
> Co-developed-by: Somnath Kotur <somnath.kotur@broadcom.com>
> Signed-off-by: Somnath Kotur <somnath.kotur@broadcom.com>
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Manoj Panicker <manoj.panicker2@amd.com>
> Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 85 +++++++++++++++++++++++
>  drivers/net/ethernet/broadcom/bnxt/bnxt.h |  7 ++
>  net/core/netdev_rx_queue.c                |  1 +
>  3 files changed, 93 insertions(+)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c

...

> @@ -10865,6 +10867,63 @@ int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init)
>  	return 0;
>  }
>  
> +static void __bnxt_irq_affinity_notify(struct irq_affinity_notify *notify,
> +				       const cpumask_t *mask)
> +{
> +	struct bnxt_rx_ring_info *rxr;

Hi Wei Huang,

A minor nit from my side:

rxr is set but otherwise unused in this function.

Flagged by x86_64 W=1 builds with gcc-14 and clang-18.

> +	struct bnxt_irq *irq;
> +	u16 tag;
> +	int err;
> +
> +	irq = container_of(notify, struct bnxt_irq, affinity_notify);
> +	cpumask_copy(irq->cpu_mask, mask);
> +
> +	if (pcie_tph_get_cpu_st(irq->bp->pdev, TPH_MEM_TYPE_VM,
> +				cpumask_first(irq->cpu_mask), &tag))
> +		return;
> +
> +	if (pcie_tph_set_st_entry(irq->bp->pdev, irq->msix_nr, tag))
> +		return;
> +
> +	if (netif_running(irq->bp->dev)) {
> +		rxr = &irq->bp->rx_ring[irq->ring_nr];
> +		rtnl_lock();
> +		err = netdev_rx_queue_restart(irq->bp->dev, irq->ring_nr);
> +		if (err)
> +			netdev_err(irq->bp->dev,
> +				   "rx queue restart failed: err=%d\n", err);
> +		rtnl_unlock();
> +	}
> +}

...

