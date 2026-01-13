Return-Path: <linux-pci+bounces-44664-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A9AD1B0D6
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 20:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 34752302E857
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 19:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2179352FBE;
	Tue, 13 Jan 2026 19:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pZWKN/Ny"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9CA20F08C;
	Tue, 13 Jan 2026 19:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768332649; cv=none; b=KY1UcSF0gSDIvzW80B3rP4P2Vgdb2yEK2ZAiH3T+KUlv76zFjNya5CIqrx+yvjz+y/Y53q+A1SQZfdQPAlD1AZAQ4O5f2Lhc4v2KOjqJUz6cfEEmZ7hEDMnX+i6odyoOKN5GI2uePYbVQfNnDO/Ep106+ivCGYHrdcmYP9U+N24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768332649; c=relaxed/simple;
	bh=utkO7qAUKLK1RGX5DjRctYVXaccfBqPH23O3mAXzJXM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MzR0txhu7kfRu69Gs17Nzi15pk5HMsS+G+73iVmf5A340r+WGCsOMOFbslSO0Ax7MeUxHNexwR+gJAocKadyvTTtmiRvUv4HybpNDrnkVnImrYCy9v3+75pEOPDtDM4cL+mDDqC+G4Nc9idsSJzOlfUjBbqXC3jkfii4LYFhnbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pZWKN/Ny; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9330C19422;
	Tue, 13 Jan 2026 19:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768332649;
	bh=utkO7qAUKLK1RGX5DjRctYVXaccfBqPH23O3mAXzJXM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=pZWKN/Ny5D3bdiWT78yZVnjkTuVPLGjheLzekAKnfOf7tQRHkZJHxKVQNxzmzM1La
	 BHYcdQgrQPaUCEksIZgKPbKhw5VCAuayX4L9oai0ZuzJ0W2opl8tLrS99cUNUlbBT5
	 w6SirAuUsER1+8+JLuBzrKPWU3TeqGP+TEjuer+HvcojK/Ryik5PyJ9pknsJV982GA
	 L+VHWVgfgG/a012qHzG4rIwT8A91LNB8mnZ7AWp98A2n3OQnRSHQpuOJmR53nMRQLY
	 +K0DXIbrnaBwEOAIKx6Un6ChgD4mP62y8Jj1PJOLXCxWRbFpWTOXlRobLlXeL54ZVe
	 cj3OBi3JQNikg==
From: Thomas Gleixner <tglx@kernel.org>
To: Bert Karwatzki <spasswolf@web.de>, linux-kernel@vger.kernel.org
Cc: linux-next@vger.kernel.org, spasswolf@web.de, Mario Limonciello
 <mario.limonciello@amd.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, Steven
 Rostedt <rostedt@goodmis.org>, Christian =?utf-8?Q?K=C3=B6nig?=
 <christian.koenig@amd.com>,
 regressions@lists.linux.dev, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, "Rafael J . Wysocki"
 <rafael.j.wysocki@intel.com>, acpica-devel@lists.linux.dev, Robert Moore
 <robert.moore@intel.com>, Saket Dumbre <saket.dumbre@intel.com>, Bjorn
 Helgaas <bhelgaas@google.com>, Clemens Ladisch <clemens@ladisch.de>,
 Jinchao Wang <wangjinchao600@gmail.com>, Yury Norov
 <yury.norov@gmail.com>, Anna Schumaker <anna.schumaker@oracle.com>,
 Baoquan He <bhe@redhat.com>, "Darrick J. Wong" <djwong@kernel.org>, Dave
 Young <dyoung@redhat.com>, Doug Anderson <dianders@chromium.org>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, Helge Deller
 <deller@gmx.de>, Ingo Molnar <mingo@kernel.org>, Jason Gunthorpe
 <jgg@ziepe.ca>, Joanthan
 Cameron <Jonathan.Cameron@huawei.com>, Joel Granados
 <joel.granados@kernel.org>, John Ogness <john.ogness@linutronix.de>, Kees
 Cook <kees@kernel.org>, Li Huafei <lihuafei1@huawei.com>, "Luck, Tony"
 <tony.luck@intel.com>, Luo Gengkun <luogengkun@huaweicloud.com>, Max
 Kellermann <max.kellermann@ionos.com>, Nam Cao <namcao@linutronix.de>,
 oushixiong <oushixiong@kylinos.cn>, Petr Mladek <pmladek@suse.com>,
 Qianqiang Liu <qianqiang.liu@163.com>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Sohil Mehta <sohil.mehta@intel.com>, Tejun Heo
 <tj@kernel.org>, Thomas Zimemrmann <tzimmermann@suse.de>, Thorsten Blum
 <thorsten.blum@linux.dev>, Ville Syrjala <ville.syrjala@linux.intel.com>,
 Vivek Goyal <vgoyal@redhat.com>, Yunhui Cui <cuiyunhui@bytedance.com>,
 Andrew Morton <akpm@linux-foundation.org>, W_Armin@gmx.de
Subject: Re: NMI stack overflow during resume of PCIe bridge with
 CONFIG_HARDLOCKUP_DETECTOR=y
In-Reply-To: <bc20529d7520e7db7de2022bf9c96a1bc3a2f0df.camel@web.de>
References: <20260113094129.3357-1-spasswolf@web.de> <87h5spk01t.ffs@tglx>
 <bc20529d7520e7db7de2022bf9c96a1bc3a2f0df.camel@web.de>
Date: Tue, 13 Jan 2026 20:30:46 +0100
Message-ID: <87v7h5ia3d.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jan 13 2026 at 18:50, Bert Karwatzki wrote:
> Am Dienstag, dem 13.01.2026 um 16:24 +0100 schrieb Thomas Gleixner:
>
>>  What's more likely is that after a while _ALL_ CPUs are hung up in
>> the NMI handler after they tripped over the HPET read.
>
> I'm not sure about that, my latest testrun (with v6.18) crashed with
> only one message from exc_nmi().

What means crashed? Did it actually crash and output something or does
the machine just go dead? I assume the latter as you have no output.

>> along with the full output of /proc/iomem
>
> The physical address is 0xf0100000
>
> $ cat /proc/iomem
> f0000000-fcffffff : PCI Bus 0000:00
>   f0000000-f7ffffff : PCI ECAM 0000 [bus 00-7f]
>     f0000000-f7ffffff : pnp 00:00

That's the memory mapped PCI config space and this tries to access:

   MMIO_START			0xf0000000
   BUSNUM	0x01 << 20      0x00100000
   SLOT/FN	0x00 << 12      0x00000000
   OFFSET	0x00 <<  0      0x00000000
                               -----------
                                0xf0100000

Offset 0 is vendor/device ID IIRC.

Anyway if that access does not complete because of a hardware issue,
then any subsequent access to the MMIO mapped HPET goes stale as well.

As the HPET is the active clocksource on your machine, this obviously
does not only affect the NMI watchdog readout, it affects the regular
timekeeper accesses too and all other MMIO accesses all over the place.

So gradually your machine just stalls on outstanding MMIO transactions
w/o further notice... The NMI is just a red herring.

You need to figure out why that MMIO access to that device's
configuration space stalls as anything else is just subsequent
damage.

There is not much what can be done about that unless the PCI bus raises
a failure interrupt and some magic reset sequence aborts the outstanding
stalled transactions.

Whether that's feasible or not, I don't know. The failure mechanism
might run into the same stall scenario when accessing the PCI muck for
reset...

Sorry for not being helpful.

Thanks,

        tglx



