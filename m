Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E15C61DE5A8
	for <lists+linux-pci@lfdr.de>; Fri, 22 May 2020 13:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbgEVLhw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 May 2020 07:37:52 -0400
Received: from foss.arm.com ([217.140.110.172]:33792 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728601AbgEVLhw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 May 2020 07:37:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 008FA55D;
        Fri, 22 May 2020 04:37:52 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C15B53F305;
        Fri, 22 May 2020 04:37:50 -0700 (PDT)
Date:   Fri, 22 May 2020 12:37:48 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>
Subject: Re: [PATCH] PCI: endpoint: Fix epc windows allocation in
 pci_epc_multi_mem_init()
Message-ID: <20200522113748.GC11785@e121166-lin.cambridge.arm.com>
References: <1589901081-29948-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589901081-29948-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 19, 2020 at 04:11:20PM +0100, Lad Prabhakar wrote:
> Fix allocation of epc windows with the correct size, this also fix smatch
> warning:
> 
> drivers/pci/endpoint/pci-epc-mem.c:65 pci_epc_multi_mem_init()
> warn: double check that we're allocating correct size: 4 vs 112
> 
> Fixes: ecbae87 ("PCI: endpoint: Add support to handle multiple base for mapping outbound memory")
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reported-by: kbuild test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/pci/endpoint/pci-epc-mem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Squashed in the original commit in pci/rcar, pushed out.

Thanks,
Lorenzo

> diff --git a/drivers/pci/endpoint/pci-epc-mem.c b/drivers/pci/endpoint/pci-epc-mem.c
> index 2325f74..80c46f3 100644
> --- a/drivers/pci/endpoint/pci-epc-mem.c
> +++ b/drivers/pci/endpoint/pci-epc-mem.c
> @@ -62,7 +62,7 @@ int pci_epc_multi_mem_init(struct pci_epc *epc,
>  	if (!windows || !num_windows)
>  		return -EINVAL;
>  
> -	epc->windows = kcalloc(num_windows, sizeof(*mem), GFP_KERNEL);
> +	epc->windows = kcalloc(num_windows, sizeof(*epc->windows), GFP_KERNEL);
>  	if (!epc->windows)
>  		return -ENOMEM;
>  
> -- 
> 2.7.4
> 
