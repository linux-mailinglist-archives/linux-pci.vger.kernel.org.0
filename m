Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6D9B55D3C
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2019 03:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbfFZBMn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jun 2019 21:12:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:38054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726223AbfFZBMn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Jun 2019 21:12:43 -0400
Received: from localhost (unknown [172.104.248.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD7AD20659;
        Wed, 26 Jun 2019 01:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561511562;
        bh=rBZhPauoSDDehq7ofjORYPEEU1ACkLNNLGUBmHlNylk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P92pQSJjf0QXzLbVFgUxB0WFJM5VkPGPJIlR2oLdKCSMFu+Q5BynoQ3019OkAIX8D
         s2qlEDU1Ch6lRkUX113g9vzaEW2nlxYXBUatxbYs7ew418d2xsyvs/DQTOU3LLzi6n
         pCmckF6NrI32unPabnUm7817QITTlXaMCHMarfD4=
Date:   Wed, 26 Jun 2019 09:07:46 +0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Myron Stowe <myron.stowe@redhat.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: mmap/munmap in sysfs
Message-ID: <20190626010746.GA22454@kroah.com>
References: <20190625223608.GB103694@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625223608.GB103694@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 25, 2019 at 05:36:08PM -0500, Bjorn Helgaas wrote:
> Hi Greg, et al,
> 
> Userspace can mmap PCI device memory via the resourceN files in sysfs,
> which use pci_mmap_resource().  I think this path is unaware of power
> management, so the device may be runtime-suspended, e.g., it may be in
> D1, D2, or D3, where it will not respond to memory accesses.
> 
> Userspace accesses while the device is suspended will cause PCI
> errors, so I think we need something like the patch below.  But this
> isn't sufficient by itself because we would need a corresponding
> pm_runtime_put() when the mapping goes away.  Where should that go?
> Or is there a better way to do this?
> 
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 6d27475e39b2..aab7a47679a7 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1173,6 +1173,7 @@ static int pci_mmap_resource(struct kobject *kobj, struct bin_attribute *attr,
>  
>  	mmap_type = res->flags & IORESOURCE_MEM ? pci_mmap_mem : pci_mmap_io;
>  
> +	pm_runtime_get_sync(pdev);
>  	return pci_mmap_resource_range(pdev, bar, vma, mmap_type, write_combine);
>  }
>  

Ugh, we never thought about this when adding the mmap sysfs interface
all those years ago :(

I think you are right, this will not properly solve the issue, but I
don't know off the top of my head where to solve this.  Maybe Rafael has
a better idea as he knows the pm paths much better than I do?

thanks,

greg k-h
