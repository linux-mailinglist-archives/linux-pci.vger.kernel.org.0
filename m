Return-Path: <linux-pci+bounces-35577-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1EDB464ED
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 22:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76F5F1C8578B
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 20:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405672D8781;
	Fri,  5 Sep 2025 20:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYpgh0SC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076812868B5;
	Fri,  5 Sep 2025 20:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757105331; cv=none; b=qeGt1K65cZBR9wcn2En8oL1tpRmNZ/TlntQ82uMlYDcA2o+o3AsECrvMKb68SSaOfL0UiqRApaODPkGIBhVQ7zzPotPnO/qdWnmr9yvdhOFpt/6UOEx0AAh3rEu/PQfjDyKo+5jga9G78LGfYpagyaceWsedId4BJ6ygRJ+xQe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757105331; c=relaxed/simple;
	bh=UM//CX27PEjyc+M1WSMpVvolKTZDb7r8NPB0I7aQ4F0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Xd1qra9JN10KZT6LfWudXO/Z89JzLicko0E8isH2+bs+Sw+9343AhfatUIe2fstxqUh7EHEUNl13BriMs7T9UHdKGYqa02zNs01/JdVL6qLoaGvzXQ/nY8uV2orRhK8ORYp62DBZibNQ09Q05bhVr6ngXzZrPkpeZG/7x3bmP+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYpgh0SC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5473BC4CEF1;
	Fri,  5 Sep 2025 20:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757105330;
	bh=UM//CX27PEjyc+M1WSMpVvolKTZDb7r8NPB0I7aQ4F0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=oYpgh0SC9Go9u5mDCbyzQI281mbVwTpMLnfZ/IC1pLODSKF/G7jXzTnQfIi2KZTUG
	 bsClwvoMVAJ0cUzucv0llj6Y1igSeObJy6wYJaN/fKTx7Wmmtvu9cekHHqkZR4ZlGp
	 znVTjHKrzHyegtCyMNywhLuZzXZBKGxlCwJbojXxqyrUJpQ2rQ4JtUkDAQy0Em7MUZ
	 CdGnloJJbe8uW7uYeLqyy6dacht2ptbeHDdqRyRGb0hFeegLU7S9h4feP9wa9HNQGx
	 jMAGcpOikpXHVD18Uk5wyN+tlpcjKeQCGbcGbUyLtbraOJ2n9nugCTW05NtwFb5F46
	 Ehso0Ga8pV5sQ==
Date: Fri, 5 Sep 2025 15:48:48 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Wang ShaoBo <bobo.shaobowang@huawei.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com, leijitang@huawei.com,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	christian.brauner@ubuntu.com, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] PCI: Fix the int overflow in proc_bus_pci_write()
Message-ID: <20250905204848.GA1322742@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905104730.2833673-1-bobo.shaobowang@huawei.com>

[+cc linux-hardening]

On Fri, Sep 05, 2025 at 06:47:30PM +0800, Wang ShaoBo wrote:
> Following testcase can trigger a softlockup BUG.
> syscall(__NR_pwritev, /*fd=*/..., /*vec=*/..., /*vlen=*/...,
>         /*pos_l=*/0x80010000, /*pos_h=*/0x100);
> 
> watchdog: BUG: soft lockup - CPU#11 stuck for 22s! [test:537]
> Modules linked in:
> CPU: 11 PID: 537 Comm: test Not tainted 5.10.0+ #67
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
> RIP: 0010:pci_user_write_config_dword+0x67/0xc0
> Code: 00 00 44 89 e2 48 8b 87 e0 00 00 00 48 8b 40 20 e8 9e 54 7e 00 48 c7 c7 20 48 a2 83 41 89 c0 c6 07 00 0f 1f 40 00 fb 45 85 c0 <7e> 12 41 8d 80 7f ff ff ff 41 b8 de ff ff ff 83 f8 08 76 0c 5b 44
> RSP: 0018:ffffc900016c3d30 EFLAGS: 00000246
> RAX: 0000000000000000 RBX: ffff888042058000 RCX: 0000000000000005
> RDX: ffff888004058a00 RSI: 0000000000000046 RDI: ffffffff83a24820
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
> R10: ffff888005c25900 R11: 0000000000000000 R12: 0000000080c48680
> R13: 0000000020c38684 R14: 0000000080010000 R15: ffff888004702408
> FS:  000000003ae91880(0000) GS:ffff88801f380000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020c00000 CR3: 0000000006f2c000 CR4: 00000000000006e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  proc_bus_pci_write+0x22c/0x260
>  proc_reg_write+0x40/0x90
>  do_loop_readv_writev.part.0+0x97/0xc0
>  do_iter_write+0xf6/0x150
>  vfs_writev+0x97/0x130
>  ? files_cgroup_alloc_fd+0x5c/0x70
>  ? do_sys_openat2+0x1c9/0x320
>  __x64_sys_pwritev+0xb1/0x100
>  do_syscall_64+0x2b/0x40
>  entry_SYSCALL_64_after_hwframe+0x6c/0xd6
> 
> The pos_l parameter for pwritev syscall may be an integer negative value,
> which will make the variable pos in proc_bus_pci_write() negative and
> variable cnt a very large number.

Sounds like a problem; have you looked for similar problems in other
.proc_write() and .proc_read() functions?  validate_flash_write() is
one that also looks suspicious to me.

I think you're describing this code:

  static ssize_t proc_bus_pci_write(struct file *file, const char __user *buf,
				    size_t nbytes, loff_t *ppos)
  {
        int pos = *ppos;
        int size = dev->cfg_size;
        int cnt, ret;

        if (pos + nbytes > size)
                nbytes = size - pos;
        cnt = nbytes;
	...
	while (cnt >= 4) {
		...
                pos += 4;
                cnt -= 4;
	}

proc_bus_pci_read() is quite similar but "pos", "cnt", and "size" are
unsigned:

  static ssize_t proc_bus_pci_read(struct file *file, char __user *buf,
				   size_t nbytes, loff_t *ppos)
  {
        unsigned int pos = *ppos;
        unsigned int cnt, size;

It seems like they should use the same strategy to avoid this problem.

> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
> ---
>  drivers/pci/proc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
> index 9348a0fb8084..ef7a33affb3b 100644
> --- a/drivers/pci/proc.c
> +++ b/drivers/pci/proc.c
> @@ -121,7 +121,7 @@ static ssize_t proc_bus_pci_write(struct file *file, const char __user *buf,
>  	if (ret)
>  		return ret;
>  
> -	if (pos >= size)
> +	if (pos < 0 || pos >= size)
>  		return 0;
>  	if (nbytes >= size)
>  		nbytes = size;
> -- 
> 2.25.1
> 

