Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38E7742C93B
	for <lists+linux-pci@lfdr.de>; Wed, 13 Oct 2021 21:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbhJMTCU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Oct 2021 15:02:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:45186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231246AbhJMTCU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Oct 2021 15:02:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4EE06610E8;
        Wed, 13 Oct 2021 19:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634151616;
        bh=vu0O+pfV+sCyaPdC66uaJw0vVQuREbc9+nyIuESVaQw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=t08h/jItfp6nbs6PYAEQyke8nuQTkSs0EEEmdggCQQ0dRzR0PuFh8jgsf4zelvM5V
         7sWRUEBc3w9k1sLQ5KmMfuhVaNPWoYPyBZUyqtAo0D7iVSBklrXA9o3yxmhFjWwaB2
         9XNWwZdaK1k5JSwcDnWOmrqnDycU2C6AzPqO7a3iKsv6tk6bRZUoqjGEWaBxf2Fv56
         CNv5IPAFtoRhAy3jEJ1i6p5Mhn0OxQLmqAqPz2p0e3sLBFq/LC0L2Zhlsdx38CNd0r
         pPPpTXiBCiHHI5UeA38KXbHgNqN3qKS9nBmhB9o9eTXKeHVVu2w+5KVF/mnKu1gxD1
         nmlruchHZZCBA==
Date:   Wed, 13 Oct 2021 14:00:14 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     menglong8.dong@gmail.com
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
Subject: Re: [PATCH] pci: call _cond_resched() after pci_bus_write_config
Message-ID: <20211013190014.GA1909934@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013125542.759696-1-imagedong@tencent.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Match previous subject lines (use "git log --oneline
drivers/pci/access.c" to see them).

On Wed, Oct 13, 2021 at 08:55:42PM +0800, menglong8.dong@gmail.com wrote:
> From: Menglong Dong <imagedong@tencent.com>
> 
> While the system is running in KVM, pci config writing for virtio devices
> may cost long time(about 1-2ms), as it causes VM-exit. During
> __pci_bus_assign_resources(), pci_setup_bridge, which can do pci config
> writing up to 10 times, can be called many times without any
> _cond_resched(). So __pci_bus_assign_resources can cause 25+ms scheduling
> latency with !CONFIG_PREEMPT.
> 
> To solve this problem, call _cond_resched() after pci config writing.

s/pci/PCI/ above.
Add space before "(".
Add "()" after function names consistently (some have it, some don't).

What exactly is the problem?  I expect __pci_bus_assign_resources() to
be used mostly during boot-time enumeration.  How much of a problem is
the latency at that point?  Why is this particularly a problem in the
KVM environment?  Or is it also a problem on bare metal?

Are there other config write paths that should have a similar change?

_cond_resched() only appears here:

  $ git grep "\<_cond_resched\>"
  include/linux/sched.h:static __always_inline int _cond_resched(void)
  include/linux/sched.h:static inline int _cond_resched(void)
  include/linux/sched.h:static inline int _cond_resched(void) { return 0; }
  include/linux/sched.h:  _cond_resched();

so I don't believe PCI is so special that this needs to be the only
other use.  Maybe a different resched interface is more appropriate?

> Signed-off-by: Menglong Dong <imagedong@tencent.com>
> ---
>  drivers/pci/access.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> index 46935695cfb9..babed43702df 100644
> --- a/drivers/pci/access.c
> +++ b/drivers/pci/access.c
> @@ -57,6 +57,7 @@ int noinline pci_bus_write_config_##size \
>  	pci_lock_config(flags);						\
>  	res = bus->ops->write(bus, devfn, pos, len, value);		\
>  	pci_unlock_config(flags);					\
> +	_cond_resched();						\
>  	return res;							\
>  }
>  
> -- 
> 2.27.0
> 
