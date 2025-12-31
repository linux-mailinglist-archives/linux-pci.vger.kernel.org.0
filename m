Return-Path: <linux-pci+bounces-43887-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3323BCEC4FD
	for <lists+linux-pci@lfdr.de>; Wed, 31 Dec 2025 18:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8355D3007FE5
	for <lists+linux-pci@lfdr.de>; Wed, 31 Dec 2025 17:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B43028134F;
	Wed, 31 Dec 2025 17:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rGOAxQOu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E084C97;
	Wed, 31 Dec 2025 17:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767200676; cv=none; b=e0UXtoPotoEQaayCQJR3JeEjJn2I6GFd5+R1zGiztC6P1tAHKgHxYak6df5BXMHpAb9LXjdUXNTFm4JUUB/Hj4hCBJLqGlSwIJpCC97IJYc1VWVo5mZ2dxGL4KuChhdToKctDBckAX0Du+PhuN68hFqnDo6s6UbxfVtJaqaAFus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767200676; c=relaxed/simple;
	bh=UdD2WETjBAVFKgUJSLY9cX/ev7Q8Wxs4tu/21OACLE8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rs7QvNUKf5w2bqOnhLDVnxiu+1iu/Rbd5H52Ll6LdbK7BlltY7TbPaOarNK6QQdDzakFlcEogdBNUWIH0n+aIBe2z48yDwVHmjiszcvMaiNRjcyM9+VVWw8YHKv0iYdoUHsOcDHgN4uuTguQSl0fMN+9gLJd8h+j8J3abz1h7ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rGOAxQOu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1189C113D0;
	Wed, 31 Dec 2025 17:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767200675;
	bh=UdD2WETjBAVFKgUJSLY9cX/ev7Q8Wxs4tu/21OACLE8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=rGOAxQOuS8AoUrUjBqJ8bo21g3vTs1pusLMspCYb2vh07jBqeC/vf+ig5czYQ8kYN
	 mp2hY6bh4YurSi40oV5jiYUTTN10mEQI7mfBsZRxuF1JjXzEPlgJN2VDDs7SUqfZls
	 bp/upJ+LHUFAsw1VTxzH0P4OTJ4QHKwhMjaJ62wO2N/rrqf4COXGVwgqjLi1e3fiC7
	 01iQtFmangkk2rCijfh+uht3wlmTfvmfjytuQctONdhbO6ZdmU3NvjHSa30NMe72R0
	 d4M8b56wySZc6y6c84Xl4WGY+C1w3z+16bpUwEL103xwU/tQ6APZWmtnhCDhgm5u/e
	 AfAmeB/vVI88A==
Date: Wed, 31 Dec 2025 11:04:34 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: duziming <duziming2@huawei.com>, bhelgaas@google.com,
	jbarnes@virtuousgeek.org, chrisw@redhat.com,
	alex.williamson@redhat.com, linux-pci@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, liuyongqiang13@huawei.com,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: Re: [PATCH v2 2/3] PCI: Prevent overflow in proc_bus_pci_write()
Message-ID: <20251231170434.GA160560@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b5cc94da-23e7-0185-0b5a-b35125234af4@linux.intel.com>

On Wed, Dec 31, 2025 at 11:31:47AM +0200, Ilpo Järvinen wrote:
> On Tue, 30 Dec 2025, duziming wrote:
> > 在 2025/12/30 2:07, Bjorn Helgaas 写道:
> > > [+cc Krzysztof; I thought we looked at this long ago?]
> > > 
> > > On Wed, Dec 24, 2025 at 05:27:18PM +0800, Ziming Du wrote:
> > > > From: Yongqiang Liu <liuyongqiang13@huawei.com>
> > > > 
> > > > When the value of ppos over the INT_MAX, the pos is over set to a negtive
> > > > value which will be passed to get_user() or pci_user_write_config_dword().
> > > > Unexpected behavior such as a softlock will happen as follows:
> > > s/negtive/negative/
> > > s/softlock/soft lockup/ to match message below
> > Thanks for pointing out the ambiguous parts.
> > > s/ppos/pos/ (or fix this to refer to "*ppos", which I think is what
> > > you're referring to)
> > > 
> > > I guess the point is that proc_bus_pci_write() takes a "loff_t *ppos",
> > > loff_t is a signed type, and negative read/write offsets are invalid.
> > 
> > Actually, the *loff_t *ppos *passed in is not a negative value. The root cause
> > of the issue
> > 
> > lies in the cast *int* *pos = *ppos*. When the value of **ppos* over the
> > INT_MAX, the pos is over set
> > 
> > to a negative value. This negative *pos* then propagates through subsequent
> > logic, leading to the observed errors.
> > 
> > > If this is easily reproducible with "dd" or similar, could maybe
> > > include a sample command line?
> > 
> > We reproduced the issue using the following POC:
> > 
> >     #include <stdio.h>
> > 
> >     #include <string.h>
> >     #include <unistd.h>
> >     #include <fcntl.h>
> >     #include <sys/uio.h>
> > 
> >     int main() {
> >     int fd = open("/proc/bus/pci/00/02.0", O_RDWR);
> >     if (fd < 0) {
> >         perror("open failed");
> >         return 1;
> >     }
> >     char data[] = "926b7719201054f37a1d9d391e862c";
> >     off_t offset = 0x80800001;
> >     struct iovec iov = {
> >         .iov_base = data,
> >         .iov_len = 0xf
> >     };
> >     pwritev(fd, &iov, 1, offset);
> >     return 0;
> > }
> > 
> > > >   watchdog: BUG: soft lockup - CPU#0 stuck for 130s! [syz.3.109:3444]
> > > >   RIP: 0010:_raw_spin_unlock_irq+0x17/0x30
> > > >   Call Trace:
> > > >    <TASK>
> > > >    pci_user_write_config_dword+0x126/0x1f0
> > > >    proc_bus_pci_write+0x273/0x470
> > > >    proc_reg_write+0x1b6/0x280
> > > >    do_iter_write+0x48e/0x790
> > > >    vfs_writev+0x125/0x4a0
> > > >    __x64_sys_pwritev+0x1e2/0x2a0
> > > >    do_syscall_64+0x59/0x110
> > > >    entry_SYSCALL_64_after_hwframe+0x78/0xe2
> > > > 
> > > > Fix this by add check for the pos.
> > > > 
> > > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > > Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>
> > > > Signed-off-by: Ziming Du <duziming2@huawei.com>
> > > > ---
> > > >   drivers/pci/proc.c | 2 +-
> > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
> > > > index 9348a0fb8084..200d42feafd8 100644
> > > > --- a/drivers/pci/proc.c
> > > > +++ b/drivers/pci/proc.c
> > > > @@ -121,7 +121,7 @@ static ssize_t proc_bus_pci_write(struct file *file,
> > > > const char __user *buf,
> > > >   	if (ret)
> > > >   		return ret;
> > > >   -	if (pos >= size)
> > > > +	if (pos >= size || pos < 0)
> > > >   		return 0;
> > > I see a few similar cases that look like this; maybe we should do the
> > > same?
> > > 
> > >    if (pos < 0)
> > >      return -EINVAL;
> > > 
> > > Looks like proc_bus_pci_read() has the same issue?
> > 
> > proc_bus_pci_read() may also trigger similar issue as mentioned by Ilpo
> > Järvinen in
> > 
> > https://lore.kernel.org/linux-pci/e5a91378-4a41-32fb-00c6-2810084581bd@linux.intel.com/
> > 
> > However, it does not result in an overflow to a negative number.
> 
> Why does the cast has to happen first here?
> 
> This would ensure _correctness_ without any false alignment issues for 
> large numbers:
> 
> 	int pos;
> 	int size = dev->cfg_size;
> 
> 	...
> 	if (*ppos > INT_MAX)

Isn't *ppos a signed quantity?  If so, wouldn't we want to check for
"*ppos < 0"?

