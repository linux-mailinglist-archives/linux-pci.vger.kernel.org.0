Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 847533939DD
	for <lists+linux-pci@lfdr.de>; Fri, 28 May 2021 01:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235419AbhE1AAO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 May 2021 20:00:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:46232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235756AbhE1AAE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 May 2021 20:00:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B7FB460233;
        Thu, 27 May 2021 23:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622159911;
        bh=LReRf0mXlMHM2Ka7rklNEdQGl/501pPEF+NpmvBZqYU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=eNXa/m/uSA7ovrxDeAzCRvUR3coWOr84LPHuK7rlUtoyTxuQtSC7Ff2iqznjWpTPH
         GIgkwIDOgJZF2SfV8s9jG+wusmsIZwZ6NtDZ12Lk92NG8wDOjW9Af+BS0kBh7u1PvQ
         o4oL14ApRwxKzZfMrdrllJ5KxMuX+b/1249cSnBNCNxniRWazIlkpudWCu0U3o/7pl
         JdiHK/hver9Swk2sh5j7wjM8aY9SZN+dwKOahlq9QJNaeul8ZNBGZE6ChMX8ctr18/
         x9TBF5TB/E++bt4pg3BDKJZtFxYV1pS8kXjtalowXe+ZDvMf+8sSQvet8Ls7Eo8fxX
         ym2isvlMvFVlg==
Date:   Thu, 27 May 2021 18:58:29 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Print a debug message on PCI device release
Message-ID: <20210527235829.GA1447806@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311132312.2882425-1-schnelle@linux.ibm.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 11, 2021 at 02:23:12PM +0100, Niklas Schnelle wrote:
> Commit 62795041418d ("PCI: enhance physical slot debug information")
> added a debug print on releasing the PCI slot and another message on
> destroying it. There is however no debug print on releasing the PCI
> device structure itself and even with closely looking at the kernel log
> during hotplug testing, I overlooked several missing pci_dev_put() calls
> for way too long. So let's add a debug print in pci_release_dev() making
> it much easier to spot when the PCI device structure is not released
> when it is supposed to.
> 
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

Applied to pci/enumeration for v5.14, thanks!

> ---
>  drivers/pci/probe.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 953f15abc850..3e3669a00a2f 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2226,6 +2226,7 @@ static void pci_release_dev(struct device *dev)
>  	pci_bus_put(pci_dev->bus);
>  	kfree(pci_dev->driver_override);
>  	bitmap_free(pci_dev->dma_alias_mask);
> +	dev_dbg(dev, "device released\n");
>  	kfree(pci_dev);
>  }
>  
> -- 
> 2.25.1
> 
