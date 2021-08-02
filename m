Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDC343DDC45
	for <lists+linux-pci@lfdr.de>; Mon,  2 Aug 2021 17:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234603AbhHBPXG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Aug 2021 11:23:06 -0400
Received: from mga01.intel.com ([192.55.52.88]:36272 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235018AbhHBPXG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Aug 2021 11:23:06 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10064"; a="235404975"
X-IronPort-AV: E=Sophos;i="5.84,289,1620716400"; 
   d="scan'208";a="235404975"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 08:22:55 -0700
X-IronPort-AV: E=Sophos;i="5.84,289,1620716400"; 
   d="scan'208";a="419348712"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 08:22:49 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 02 Aug 2021 18:22:47 +0300
Date:   Mon, 2 Aug 2021 18:22:47 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Sanjay R Mehta <Sanju.Mehta@amd.com>
Cc:     andreas.noever@gmail.com, michael.jamet@intel.com,
        bhelgaas@google.com, YehezkelShB@gmail.com,
        Basavaraj.Natikar@amd.com, linux-usb@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/4] thunderbolt: Handle INTR when Disable ISR auto clear
 bit set
Message-ID: <YQgNx/YiPVFEZrDb@lahna>
References: <1627909100-83338-1-git-send-email-Sanju.Mehta@amd.com>
 <1627909100-83338-3-git-send-email-Sanju.Mehta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1627909100-83338-3-git-send-email-Sanju.Mehta@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Mon, Aug 02, 2021 at 07:58:18AM -0500, Sanjay R Mehta wrote:
> From: Sanjay R Mehta <sanju.mehta@amd.com>
> 
> when the "Disable ISR Auto-Clear" bit is set, the Tx/Rx ring
> interrupt status is not cleared. Hence handling it by setting
> the "Interrupt status clear" register to clear the
> corresponding Tx/Rx ring interrupt.

I think REG_DMA_MISC_INT_AUTO_CLEAR which is bit 2 in that register is
actually Intel specific and not the same as in the USB4 spec bit 17. I
guess the AMD controller works fine as is if this bit (2) is not set? If
that's the case we can simply limit this behavior for Intel controllers.

> 
> Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
> ---
>  drivers/thunderbolt/nhi.c   | 26 +++++++++++++++++++++++++-
>  include/linux/thunderbolt.h |  1 +
>  2 files changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
> index d7d9c4b..63bbabf 100644
> --- a/drivers/thunderbolt/nhi.c
> +++ b/drivers/thunderbolt/nhi.c
> @@ -74,7 +74,11 @@ static void ring_interrupt_active(struct tb_ring *ring, bool active)
>  		if (!(misc & REG_DMA_MISC_INT_AUTO_CLEAR)) {
>  			misc |= REG_DMA_MISC_INT_AUTO_CLEAR;
>  			iowrite32(misc, ring->nhi->iobase + REG_DMA_MISC);
> -		}
> +			misc = ioread32(ring->nhi->iobase + REG_DMA_MISC);
> +			if (misc & REG_DMA_MISC_INT_AUTO_CLEAR)
> +				ring->nhi->is_intr_autoclr = true;
> +		} else
> +			ring->nhi->is_intr_autoclr = true;
>  
>  		ivr_base = ring->nhi->iobase + REG_INT_VEC_ALLOC_BASE;
>  		step = index / REG_INT_VEC_ALLOC_REGS * REG_INT_VEC_ALLOC_BITS;
> @@ -377,11 +381,31 @@ void tb_ring_poll_complete(struct tb_ring *ring)
>  }
>  EXPORT_SYMBOL_GPL(tb_ring_poll_complete);
>  
> +static void check_and_clear_intr_status(struct tb_ring *ring, int int_pos)
> +{
> +	u32 value;
> +
> +	if (!ring->nhi->is_intr_autoclr) {
> +		value = ioread32(ring->nhi->iobase
> +					 + REG_RING_NOTIFY_BASE
> +					 + 4 * (int_pos / 32));
> +		iowrite32(value, ring->nhi->iobase
> +			  + (REG_RING_NOTIFY_BASE + 8)
> +			  + 4 * (int_pos / 32));
> +	}
> +}
> +
>  static irqreturn_t ring_msix(int irq, void *data)
>  {
>  	struct tb_ring *ring = data;
>  
>  	spin_lock(&ring->nhi->lock);
> +
> +	if (ring->is_tx)
> +		check_and_clear_intr_status(ring, 0);
> +	else
> +		check_and_clear_intr_status(ring, ring->nhi->hop_count);
> +
>  	spin_lock(&ring->lock);
>  	__ring_interrupt(ring);
>  	spin_unlock(&ring->lock);
> diff --git a/include/linux/thunderbolt.h b/include/linux/thunderbolt.h
> index e7c96c3..bbe7c7e 100644
> --- a/include/linux/thunderbolt.h
> +++ b/include/linux/thunderbolt.h
> @@ -478,6 +478,7 @@ struct tb_nhi {
>  	struct tb_ring **rx_rings;
>  	struct ida msix_ida;
>  	bool going_away;
> +	bool is_intr_autoclr;
>  	struct work_struct interrupt_work;
>  	u32 hop_count;
>  };
> -- 
> 2.7.4
