Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBB618658E
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2019 17:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733119AbfHHPUH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Aug 2019 11:20:07 -0400
Received: from mga01.intel.com ([192.55.52.88]:46713 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbfHHPUH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Aug 2019 11:20:07 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 08:20:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,361,1559545200"; 
   d="scan'208";a="203611641"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga002.fm.intel.com with ESMTP; 08 Aug 2019 08:20:06 -0700
Date:   Thu, 8 Aug 2019 09:17:40 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Shivasharan Srikanteshwara 
        <shivasharan.srikanteshwara@broadcom.com>
Subject: Re: [PATCH] genirq/affinity: create affinity mask for single vector
Message-ID: <20190808151740.GA27077@localhost.localdomain>
References: <20190805011906.5020-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805011906.5020-1-ming.lei@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 05, 2019 at 09:19:06AM +0800, Ming Lei wrote:
> Since commit c66d4bd110a1f8 ("genirq/affinity: Add new callback for
> (re)calculating interrupt sets"), irq_create_affinity_masks() returns
> NULL in case of single vector. This change has caused regression on some
> drivers, such as lpfc.
> 
> The problem is that single vector may be triggered in some generic cases:
> 1) kdump kernel 2) irq vectors resource is close to exhaustion.
> 
> If we don't create affinity mask for single vector, almost every caller
> has to handle the special case.
> 
> So still create affinity mask for single vector, since irq_create_affinity_masks()
> is capable of handling that.

Hi Ming,

Looks good to me.

Reviewed-by: Keith Busch <keith.busch@intel.com>
 
> ---
>  kernel/irq/affinity.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
> index 4352b08ae48d..6fef48033f96 100644
> --- a/kernel/irq/affinity.c
> +++ b/kernel/irq/affinity.c
> @@ -251,11 +251,9 @@ irq_create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
>  	 * Determine the number of vectors which need interrupt affinities
>  	 * assigned. If the pre/post request exhausts the available vectors
>  	 * then nothing to do here except for invoking the calc_sets()
> -	 * callback so the device driver can adjust to the situation. If there
> -	 * is only a single vector, then managing the queue is pointless as
> -	 * well.
> +	 * callback so the device driver can adjust to the situation.
>  	 */
> -	if (nvecs > 1 && nvecs > affd->pre_vectors + affd->post_vectors)
> +	if (nvecs > affd->pre_vectors + affd->post_vectors)
>  		affvecs = nvecs - affd->pre_vectors - affd->post_vectors;
>  	else
>  		affvecs = 0;
> -- 
