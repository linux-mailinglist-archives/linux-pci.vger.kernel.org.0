Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF612714C
	for <lists+linux-pci@lfdr.de>; Wed, 22 May 2019 23:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729968AbfEVVAk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 May 2019 17:00:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:41854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729686AbfEVVAk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 22 May 2019 17:00:40 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FF2121019;
        Wed, 22 May 2019 21:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558558839;
        bh=DAAiD6IH0KlDghAVNPmVbeERdOtKivo01YxuNAw7Lv4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NMu4b6BJ6eGOg5zZMYjFoMJPEjwWgJzXYlUFNL/cVGdMfzr6eLQQV4fTw0oerv/D+
         RP2brANDVsvcMxhzfOECmHSJFZ8Ghm4KstXuGdGVc+DEa3jtgRa2btaLFFe575w+TH
         4i9jAAXLgNkFwSgCIMEOX1dAXlJtDolPRrkjQVhw=
Date:   Wed, 22 May 2019 16:00:38 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Isaac J. Manjarres" <isaacm@codeaurora.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        frowand.list@gmail.com, joro@8bytes.org, robin.murphy@arm.com,
        will.deacon@arm.com, kernel-team@android.com,
        pratikp@codeaurora.org, lmark@codeaurora.org
Subject: Re: [RFC/PATCH 2/4] PCI: Export PCI ACS and DMA searching functions
 to modules
Message-ID: <20190522210038.GE79339@google.com>
References: <1558118857-16912-1-git-send-email-isaacm@codeaurora.org>
 <1558118857-16912-3-git-send-email-isaacm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558118857-16912-3-git-send-email-isaacm@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 17, 2019 at 11:47:35AM -0700, Isaac J. Manjarres wrote:
> IOMMU drivers that can be compiled as modules may
> want to use pci_for_each_dma_alias() and pci_request_acs(),
> so export those functions.
> 
> Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/pci.c    | 1 +
>  drivers/pci/search.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 766f577..3f354c1 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3124,6 +3124,7 @@ void pci_request_acs(void)
>  {
>  	pci_acs_enable = 1;
>  }
> +EXPORT_SYMBOL_GPL(pci_request_acs);
>  
>  static const char *disable_acs_redir_param;
>  
> diff --git a/drivers/pci/search.c b/drivers/pci/search.c
> index 2b5f720..cf9ede9 100644
> --- a/drivers/pci/search.c
> +++ b/drivers/pci/search.c
> @@ -111,6 +111,7 @@ int pci_for_each_dma_alias(struct pci_dev *pdev,
>  
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(pci_for_each_dma_alias);
>  
>  static struct pci_bus *pci_do_find_bus(struct pci_bus *bus, unsigned char busnr)
>  {
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
