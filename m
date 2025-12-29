Return-Path: <linux-pci+bounces-43820-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FA6CE7CBE
	for <lists+linux-pci@lfdr.de>; Mon, 29 Dec 2025 19:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86DC83015866
	for <lists+linux-pci@lfdr.de>; Mon, 29 Dec 2025 18:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8132D63FC;
	Mon, 29 Dec 2025 18:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WLnnfPpU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765AE1AE877;
	Mon, 29 Dec 2025 18:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767031664; cv=none; b=a0V3ZRCCjQAge8CN1WD/jptlfE7zG3o7mhKQzOlUP2g7zWAVdcSQCfRpld5LLicthBPS3iSlGaRcd6RYfTJBiWFgExdwCkfnDRs0tdqt44jTgotfytKDfnDPgXOloxaEiTolmguyqJzbCsYy9X/M9UL4wOPk0PUb+uzit+RK33o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767031664; c=relaxed/simple;
	bh=QZ6esHtHl5YiUbsmvl1SS/cjY+N3/aUL9YOuLzxEyok=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Eu2LU/xVxL8Ktiqb0eu5dlMhKDYgsKUDfOaN+9iQAsl2wJkISIMmzggElYyYx8QzjE77k3WSnXlZNSRlUW2OlcRTdkTHLcILsvXwgT6cGSMwLpUiuoSTkbxYXgVGIiQIowaKIFlU5/od6awXbgAgz3TUfN8o1zRiAxEW532R4GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WLnnfPpU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED844C4CEF7;
	Mon, 29 Dec 2025 18:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767031664;
	bh=QZ6esHtHl5YiUbsmvl1SS/cjY+N3/aUL9YOuLzxEyok=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=WLnnfPpU6kxL5ZGFmVhybaYk4IjUWxjEPo4fEXyoGwO1Uq4RW2C4C8loe7V1ew4sm
	 pD36VqCk+ibcfkNajjtNVuybohfW0BGwgm3ywjUCsCsQQ0B3LfVLmJ8uWqnEJEfLMd
	 oeZCAOn7IDJTVazUNRyjZD1ZTEhdXyNo9qXlWozEwl4zhLkTsKTQ2G6uJgET6dkoR7
	 gC4KQN08WYFZhn/CijiFLrSqQuEp6KKvOaZIWR6mAKQyOYO+InBFd/AnfMCleC/YJ9
	 RgB9j1+45PrdW6OcTjIxbMxsajLApkMAfz+8tXPkAI+yMxJMnXUd33rOV4++W0qoEN
	 4EL4de5PF5IYg==
Date: Mon, 29 Dec 2025 12:07:42 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ziming Du <duziming2@huawei.com>
Cc: bhelgaas@google.com, jbarnes@virtuousgeek.org, chrisw@redhat.com,
	alex.williamson@redhat.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, liuyongqiang13@huawei.com,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: Re: [PATCH v2 2/3] PCI: Prevent overflow in proc_bus_pci_write()
Message-ID: <20251229180742.GA69587@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251224092721.2034529-3-duziming2@huawei.com>

[+cc Krzysztof; I thought we looked at this long ago?]

On Wed, Dec 24, 2025 at 05:27:18PM +0800, Ziming Du wrote:
> From: Yongqiang Liu <liuyongqiang13@huawei.com>
> 
> When the value of ppos over the INT_MAX, the pos is over set to a negtive
> value which will be passed to get_user() or pci_user_write_config_dword().
> Unexpected behavior such as a softlock will happen as follows:

s/negtive/negative/
s/softlock/soft lockup/ to match message below

s/ppos/pos/ (or fix this to refer to "*ppos", which I think is what
you're referring to)

I guess the point is that proc_bus_pci_write() takes a "loff_t *ppos",
loff_t is a signed type, and negative read/write offsets are invalid.

If this is easily reproducible with "dd" or similar, could maybe
include a sample command line?

>  watchdog: BUG: soft lockup - CPU#0 stuck for 130s! [syz.3.109:3444]
>  RIP: 0010:_raw_spin_unlock_irq+0x17/0x30
>  Call Trace:
>   <TASK>
>   pci_user_write_config_dword+0x126/0x1f0
>   proc_bus_pci_write+0x273/0x470
>   proc_reg_write+0x1b6/0x280
>   do_iter_write+0x48e/0x790
>   vfs_writev+0x125/0x4a0
>   __x64_sys_pwritev+0x1e2/0x2a0
>   do_syscall_64+0x59/0x110
>   entry_SYSCALL_64_after_hwframe+0x78/0xe2
> 
> Fix this by add check for the pos.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>
> Signed-off-by: Ziming Du <duziming2@huawei.com>
> ---
>  drivers/pci/proc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
> index 9348a0fb8084..200d42feafd8 100644
> --- a/drivers/pci/proc.c
> +++ b/drivers/pci/proc.c
> @@ -121,7 +121,7 @@ static ssize_t proc_bus_pci_write(struct file *file, const char __user *buf,
>  	if (ret)
>  		return ret;
>  
> -	if (pos >= size)
> +	if (pos >= size || pos < 0)
>  		return 0;

I see a few similar cases that look like this; maybe we should do the
same?

  if (pos < 0)
    return -EINVAL;

Looks like proc_bus_pci_read() has the same issue?

What about pci_read_config(), pci_write_config(),
pci_llseek_resource(), pci_read_legacy_io(), pci_write_legacy_io(),
pci_read_resource_io(), pci_write_resource_io(), pci_read_rom()?
These are all sysfs things; does the sysfs infrastructure take care of
negative offsets before we get to these?

>  	if (nbytes >= size)
>  		nbytes = size;
> -- 
> 2.43.0
> 

