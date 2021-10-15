Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24DD942EF4A
	for <lists+linux-pci@lfdr.de>; Fri, 15 Oct 2021 13:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238267AbhJOLI7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Oct 2021 07:08:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:37842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238259AbhJOLI7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 15 Oct 2021 07:08:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA28A6108E;
        Fri, 15 Oct 2021 11:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634296013;
        bh=5urlJjG5MT9l7GOh70p04V26dTETlNdlw6d/u8+w/ko=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=FVGuAdBjTlMWVyDLJKPYT4Pxk30LhF2eJ+PesWGxyoE8+JZlg46DBUn3uMnQxfxlq
         dZtJKD69i1OatanhUQJlZeccpYDqJJQhErfCdX/YoqBUTuaoX9nXGVqFnNKzJfO6+x
         rNNMcexzNQBML8n9QYK7lqcbnx8D4RFVsTTyOKl3bvCduqUwyP7g7cChw4lKlZla/x
         5QfQCtCz+Pw2pZxa0FmNvxIwEdZyw90fZcvJL1XSWPr57CV0NoDgwblGQqFuoMDidW
         XwZiC0KXhA/3uCcgmF1I2BR4aNvA/tc/PTRayqDioUt9kVUJJgyMMs9oBWgZt4hMAG
         R4oTa71yf1TIg==
Date:   Fri, 15 Oct 2021 06:06:50 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     menglong8.dong@gmail.com
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
Subject: Re: [PATCH v2] pci: call cond_resched() after pci bus config writing
Message-ID: <20211015110650.GA2088919@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015024025.2916363-1-imagedong@tencent.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 15, 2021 at 10:40:25AM +0800, menglong8.dong@gmail.com wrote:
> From: Menglong Dong <imagedong@tencent.com>
> 
> While the system is running in KVM, pci config writing for virtio devices
> may cost long time (about 1-2ms), as it causes VM-exit. During
> __pci_bus_assign_resources(), pci_setup_bridge(), which can write pci
> config up to 10 times, can be called many times without any
> cond_resched(). So __pci_bus_assign_resources() can cause 25+ms
> scheduling latency with !CONFIG_PREEMPT.
> 
> To solve this problem, call cond_resched() after pci config writing.

See https://lore.kernel.org/r/20211013190014.GA1909934@bhelgaas
for comments about subject line, s/pci/PCI/, line length, etc.

> Signed-off-by: Menglong Dong <imagedong@tencent.com>
> ---
> v2:
> - use cond_resched() instead of _cond_resched()
> ---
>  drivers/pci/access.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> index 46935695cfb9..4c52a50f2c46 100644
> --- a/drivers/pci/access.c
> +++ b/drivers/pci/access.c
> @@ -57,6 +57,7 @@ int noinline pci_bus_write_config_##size \
>  	pci_lock_config(flags);						\
>  	res = bus->ops->write(bus, devfn, pos, len, value);		\
>  	pci_unlock_config(flags);					\
> +	cond_resched();						\
>  	return res;							\
>  }
>  
> -- 
> 2.27.0
> 
