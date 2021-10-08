Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD96F4273B2
	for <lists+linux-pci@lfdr.de>; Sat,  9 Oct 2021 00:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbhJHW1s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Oct 2021 18:27:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:34040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231830AbhJHW1r (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Oct 2021 18:27:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A7B8060F6B;
        Fri,  8 Oct 2021 22:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633731952;
        bh=9acV1R8jlnvHbQ0xOKG84jeP85uyj+piXHo63LmDFeU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=UcEbanUDRRlTgVgqusRAff5Aid25qBwNaAMy8om1Ytk4ef9iH4QLgJYQ1oslv5VL3
         jClswfAZ5Lv4kzY3xtMM+wxtig92ccvKgejCQOjp9GB2noGXMDKgZ2pbfNXaxyV+EM
         4PDVhJjBKzFTsW9paXPFkaiGpYdGE3FGh1qEieW0HNxZ4dpYUYcxbbB4QeulqIzNew
         IueeeuIb2J8LF7XY37NJ0wlo4SA5i/QGF3UnrnnaUYAKVCzADzqlQTMlC/w71uHBW5
         fJSG+D/hixP8YyW/Ii+UWiDZVd6zAzPhO0LKENF2NMX5UNXBOr0sC50ThSFhQqmYkj
         B0R19onrHTMHA==
Date:   Fri, 8 Oct 2021 17:25:50 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     hch@infradead.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com, stefanha@redhat.com, oren@nvidia.com,
        kw@linux.com
Subject: Re: [PATCH v3 2/2] PCI/sysfs: use NUMA_NO_NODE macro
Message-ID: <20211008222550.GA1385680@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211004133453.18881-2-mgurtovoy@nvidia.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 04, 2021 at 04:34:53PM +0300, Max Gurtovoy wrote:
> Use the proper macro instead of hard-coded (-1) value.
> 
> Suggested-by: Krzysztof Wilczyński <kw@linux.com>
> Reviewed-by: Krzysztof Wilczyński <kw@linux.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>

These two patches are independent, so I applied this patch only to
pci/sysfs for v5.16, thanks!

I assume Greg will take the drivers/base patch.

> ---
>  drivers/pci/pci-sysfs.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 7fb5cd17cc98..f807b92afa6c 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -81,8 +81,10 @@ static ssize_t pci_dev_show_local_cpu(struct device *dev, bool list,
>  	const struct cpumask *mask;
>  
>  #ifdef CONFIG_NUMA
> -	mask = (dev_to_node(dev) == -1) ? cpu_online_mask :
> -					  cpumask_of_node(dev_to_node(dev));
> +	if (dev_to_node(dev) == NUMA_NO_NODE)
> +		mask = cpu_online_mask;
> +	else
> +		mask = cpumask_of_node(dev_to_node(dev));
>  #else
>  	mask = cpumask_of_pcibus(to_pci_dev(dev)->bus);
>  #endif
> -- 
> 2.18.1
> 
