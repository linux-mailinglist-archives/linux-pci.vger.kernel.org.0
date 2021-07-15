Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A07413C9EDC
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jul 2021 14:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237508AbhGOMq0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Jul 2021 08:46:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:40642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236466AbhGOMq0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Jul 2021 08:46:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 96CDD61380;
        Thu, 15 Jul 2021 12:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626353013;
        bh=I26ip+L6jaBCoKglg+A/kXJXIznxwC2sF/kVCNXkY8Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YNLU19es5l5WGyAiZQObR11CU5+goSOTJG4MtsoVA2IAnqHEVubYnfsuddISuBmw6
         PYZwCDBfZEx/BThp+2FvdQOrowEn9xEqTMFsKc7NOhvdW9Wtq7ZaGDwtyPmtDIG5y7
         UbSMxbroigH5scLdn5yfEABSw6aA3zJmci2+w0lI=
Date:   Thu, 15 Jul 2021 14:40:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH V4 1/3] driver core: mark device as irq affinity managed
 if any irq is managed
Message-ID: <YPAs12ZfqQomASZC@kroah.com>
References: <20210715120844.636968-1-ming.lei@redhat.com>
 <20210715120844.636968-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715120844.636968-2-ming.lei@redhat.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 15, 2021 at 08:08:42PM +0800, Ming Lei wrote:
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -569,6 +569,7 @@ struct device {
>  #ifdef CONFIG_DMA_OPS_BYPASS
>  	bool			dma_ops_bypass : 1;
>  #endif
> +	bool			irq_affinity_managed : 1;
>  };

No documentation for this new field?

:(
