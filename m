Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B347C29AC
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2019 00:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfI3Whs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Sep 2019 18:37:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:36026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726789AbfI3Whs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Sep 2019 18:37:48 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1FEF20842;
        Mon, 30 Sep 2019 22:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569883068;
        bh=CG6AGYG4Q9eBtF3k96zDiWziV6iiBID/OWdD0xkiS2M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=2GUqY1nIaT36j9D3lPhNKCDg3+CmiPQCFe7URUKg6ONZRc3Y7j2CzbyxDjqPHZ116
         UNNfjLN/I3OkxJ6BbG2wlJiYOU/UUsdatEzfwWDwyWSUrWMoteN9U3SPgDeQIVMgFn
         OFRhN6rzXxVQkODpfUlETjc0tsbSA6DsrKXz411I=
Date:   Mon, 30 Sep 2019 17:37:46 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Doug Meyer <dmeyer@gigaio.com>,
        Kelvin Cao <Kelvin.Cao@microchip.com>
Subject: Re: [PATCH] PCI/switchtec: read all 64bits of part_event_bitmap
Message-ID: <20190930223746.GA216949@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190910195833.3891-1-logang@deltatee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 10, 2019 at 01:58:33PM -0600, Logan Gunthorpe wrote:
> The part_event_bitmap register is 64 bits wide and should be read with
> ioread64 instead of the 32-bit ioread32.
> 
> Reported-by: Doug Meyer <dmeyer@gigaio.com>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Kelvin Cao <Kelvin.Cao@microchip.com>

Applied to pci/switchtec for v5.5, thanks!

I added:

  Fixes: 52eabba5bcdb ("switchtec: Add IOCTLs to the Switchtec driver")
  Cc: stable@vger.kernel.org      # v4.12+

Object if you don't want those.

> ---
>  drivers/pci/switch/switchtec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
> index 8c94cd3fd1f2..465d6afd826e 100644
> --- a/drivers/pci/switch/switchtec.c
> +++ b/drivers/pci/switch/switchtec.c
> @@ -675,7 +675,7 @@ static int ioctl_event_summary(struct switchtec_dev *stdev,
>  		return -ENOMEM;
>  
>  	s->global = ioread32(&stdev->mmio_sw_event->global_summary);
> -	s->part_bitmap = ioread32(&stdev->mmio_sw_event->part_event_bitmap);
> +	s->part_bitmap = ioread64(&stdev->mmio_sw_event->part_event_bitmap);
>  	s->local_part = ioread32(&stdev->mmio_part_cfg->part_event_summary);
>  
>  	for (i = 0; i < stdev->partition_count; i++) {
> -- 
> 2.20.1
> 
