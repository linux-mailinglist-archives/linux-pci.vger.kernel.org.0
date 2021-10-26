Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76C1343BC7D
	for <lists+linux-pci@lfdr.de>; Tue, 26 Oct 2021 23:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239665AbhJZVih (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Oct 2021 17:38:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:59932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239682AbhJZViZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Oct 2021 17:38:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E71860E8B;
        Tue, 26 Oct 2021 21:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635284161;
        bh=huHOq3qPce2MozjKdd043JAI+SHWVUUw15CzyMPZhJM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=aAdJL3R6ihlnTL7eSG/MT6fP9CtWwOm9xv5cZXuQWA8aKLL7JqoQP1KXEeA3nmpnv
         w3gtEtbuZLdp5k0PCB8lgC8PafetVmtwVnWS51X6seHCAWhlhbIbCTtsit1sDO5mwq
         VfN3Ww8PPq24ztxXK4RWEosiyCXR69XJC5FzuZswK0TPmSIhK/pgOGqNfrVQe0hr/n
         18SRBCTtjKUQzDjrFvBH1N0rMWahfBK1yTsg/Yr4P3hZkgd1FZ+mltioZTNdDig69K
         Xpd2DJRwXPUJ/xN5uuqFMI8goDt4neOvYnidqDLj+X4/KXMzI/IM+l4+N3JrDZ31XY
         ZPppp79qdwlcA==
Date:   Tue, 26 Oct 2021 16:35:59 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Remove redundant initialization of variable rc
Message-ID: <20211026213559.GA169971@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210910161417.91001-1-colin.king@canonical.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 10, 2021 at 05:14:17PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable rc is being initialized with a value that is never read, it
> is being updated later on. The assignment is redundant and can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied with Krzysztof's reviewed-by to pci/misc for v5.16, thanks!

> ---
>  drivers/pci/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index ce2ab62b64cf..cd8cb94cc450 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5288,7 +5288,7 @@ const struct attribute_group pci_dev_reset_method_attr_group = {
>   */
>  int __pci_reset_function_locked(struct pci_dev *dev)
>  {
> -	int i, m, rc = -ENOTTY;
> +	int i, m, rc;
>  
>  	might_sleep();
>  
> -- 
> 2.32.0
> 
