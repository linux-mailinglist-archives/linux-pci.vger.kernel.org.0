Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A226A72322
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2019 01:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfGWXhP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Jul 2019 19:37:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:51038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726862AbfGWXhP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Jul 2019 19:37:15 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B14482184B;
        Tue, 23 Jul 2019 23:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563925034;
        bh=fdHWyEHGRz64s2G2uXhlm5YnUP8y5eicNiu3Xgx/sA0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KpntqEg1youWiJ29MD0o8e7OH2NSri60yME0HD/WjPWqkacQgtSJcxNCma9peWMSf
         mgG51npzA7QY4knTY3bvRFDGvKNzWihkbGQ5bCxcatGNDCJSVk6xE66VPFl4oa1XnX
         N95rMtgTGuZHMb5SYTuAg26i+yzbHGmzYQ1hhjsI=
Date:   Tue, 23 Jul 2019 18:37:13 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kelsey Skunberg <skunberg.kelsey@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [Linux-kernel-mentees] [PATCH] PCI: Stop exporting pci_bus_sem
Message-ID: <20190723233713.GE47047@google.com>
References: <20190718032951.40188-1-skunberg.kelsey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718032951.40188-1-skunberg.kelsey@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 17, 2019 at 09:29:52PM -0600, Kelsey Skunberg wrote:
> pci_bus_sem is not used by a loadable kernel module and does not need to
> be exported. Remove line exporting pci_bus_sem.
> 
> Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>

Applied to pci/hide for v5.4, thanks!

> ---
>  drivers/pci/search.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/search.c b/drivers/pci/search.c
> index 7f4e65872b8d..bade14002fd8 100644
> --- a/drivers/pci/search.c
> +++ b/drivers/pci/search.c
> @@ -15,7 +15,6 @@
>  #include "pci.h"
>  
>  DECLARE_RWSEM(pci_bus_sem);
> -EXPORT_SYMBOL_GPL(pci_bus_sem);
>  
>  /*
>   * pci_for_each_dma_alias - Iterate over DMA aliases for a device
> -- 
> 2.20.1
> 
> _______________________________________________
> Linux-kernel-mentees mailing list
> Linux-kernel-mentees@lists.linuxfoundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/linux-kernel-mentees
