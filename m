Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 536F61DD831
	for <lists+linux-pci@lfdr.de>; Thu, 21 May 2020 22:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbgEUUXR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 May 2020 16:23:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:51102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726814AbgEUUXR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 May 2020 16:23:17 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70C9C20756;
        Thu, 21 May 2020 20:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590092596;
        bh=RGUv6BMi0Iw+ZBs3cpA5/0PsBXXhP0/4Xn8nKAJggok=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=owGCxzrBWUOYzDIfmA8tgCrExIskgItvu0YfuoUysCrcPkyawjJtu/rbElMimi49q
         DFdZQrSJ947w9OLRzyul/rZqDDJh82ysTdBJ+h7DkpOSQVGzLM0jNaZC3bSaVJmv1p
         /DffvSl0beV1pl6z/w/4nNmqS6WduvN27NcnJj+k=
Date:   Thu, 21 May 2020 15:23:15 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof Wilczynski <kw@linux.com>
Cc:     Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/switchtec: Correct bool variable type assignment
Message-ID: <20200521202315.GA1174773@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521200439.1076672-1-kw@linux.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 21, 2020 at 08:04:39PM +0000, Krzysztof Wilczynski wrote:
> Use true instead of 1 in the assignment as the variable use_dma_mrpc is
> of a bool type.  Also, resolve the following Coccinelle warning:
> 
>   drivers/pci/switch/switchtec.c:28:12-24: WARNING: Assignment of 0/1 to
>   bool variable
> 
> Signed-off-by: Krzysztof Wilczynski <kw@linux.com>

Applied to pci/switchtec for v5.8, thanks!

> ---
>  drivers/pci/switch/switchtec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
> index e69cac84b605..850cfeb74608 100644
> --- a/drivers/pci/switch/switchtec.c
> +++ b/drivers/pci/switch/switchtec.c
> @@ -25,7 +25,7 @@ static int max_devices = 16;
>  module_param(max_devices, int, 0644);
>  MODULE_PARM_DESC(max_devices, "max number of switchtec device instances");
>  
> -static bool use_dma_mrpc = 1;
> +static bool use_dma_mrpc = true;
>  module_param(use_dma_mrpc, bool, 0644);
>  MODULE_PARM_DESC(use_dma_mrpc,
>  		 "Enable the use of the DMA MRPC feature");
> -- 
> 2.26.2
> 
