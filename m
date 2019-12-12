Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09A1E11CD88
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2019 13:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbfLLMvx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Dec 2019 07:51:53 -0500
Received: from foss.arm.com ([217.140.110.172]:45770 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729226AbfLLMvx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Dec 2019 07:51:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC82930E;
        Thu, 12 Dec 2019 04:51:52 -0800 (PST)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 247893F718;
        Thu, 12 Dec 2019 04:51:51 -0800 (PST)
Date:   Thu, 12 Dec 2019 12:51:49 +0000
From:   Andrew Murray <andrew.murray@arm.com>
To:     Zenghui Yu <yuzenghui@huawei.com>
Cc:     bhelgaas@google.com, corbet@lwn.net, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        wanghaibin.wang@huawei.com
Subject: Re: [PATCH] Documentation: PCI: msi-howto.rst: Fix wrong function
 name
Message-ID: <20191212125149.GG24359@e119886-lin.cambridge.arm.com>
References: <20191212111338.1848-1-yuzenghui@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212111338.1848-1-yuzenghui@huawei.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 12, 2019 at 07:13:38PM +0800, Zenghui Yu wrote:
> pci_irq_alloc_vectors() -> pci_alloc_irq_vectors().
> 
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> ---
>  Documentation/PCI/msi-howto.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/PCI/msi-howto.rst b/Documentation/PCI/msi-howto.rst
> index 994cbb660ade..aa2046af69f7 100644
> --- a/Documentation/PCI/msi-howto.rst
> +++ b/Documentation/PCI/msi-howto.rst
> @@ -283,5 +283,5 @@ or disabled (0).  If 0 is found in any of the msi_bus files belonging
>  to bridges between the PCI root and the device, MSIs are disabled.
>  
>  It is also worth checking the device driver to see whether it supports MSIs.
> -For example, it may contain calls to pci_irq_alloc_vectors() with the
> +For example, it may contain calls to pci_alloc_irq_vectors() with the

Reviewed-by: Andrew Murray <andrew.murray@arm.com>

Thanks,

Andrew Murray

>  PCI_IRQ_MSI or PCI_IRQ_MSIX flags.
> -- 
> 2.19.1
> 
> 
