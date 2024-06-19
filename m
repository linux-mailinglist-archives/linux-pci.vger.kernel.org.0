Return-Path: <linux-pci+bounces-8999-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC1390F74E
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 22:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1395B20AA2
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 20:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A166FA8;
	Wed, 19 Jun 2024 20:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dLXes0kR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592FF4A19;
	Wed, 19 Jun 2024 20:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718827242; cv=none; b=HQPavlfnE8mjfoyAHiKissi2pWFA3zNy8eaephGfMQ5qKIX/KFc/sxi5iK4N8Xd28UoFqHBMEZDSpKdFJciRF0DccMvmwbLWJCrS0/yIVjPLSqKXbNRgAUC3r33QFXvhkYwJSz8JtS/n3ewsS8iCOvF0tOk+wJil07Tjg77jE/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718827242; c=relaxed/simple;
	bh=aCGa6edCKrfdPW2raArQARW88dX9AV7C5HmYaPUFTL0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=tCtEDcFXy8+/3ea+R7Kdl5l28NtK7Psp8Gw2H+IvW4ad8Hoj9oIMqInHzJ1uzMjo79uH2H7NsP6NyV5nfWnhj5RZvr3mXNtryDCCTX3kuu4LxIWRJuApeZ3LVJme1hUdyoduqfX/CJ7tohLh5ITL3IXT08pKQ4oU0cz7QiS8I18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dLXes0kR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1101C2BBFC;
	Wed, 19 Jun 2024 20:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718827242;
	bh=aCGa6edCKrfdPW2raArQARW88dX9AV7C5HmYaPUFTL0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=dLXes0kR7tEXrQ2F7lhQsjRODW9bEwuzSGNzgCgJMLoTTmnHFBKrCDyvppM3MlY/P
	 F5DaOpedXTveG/38pnL1wTsnoOlZ44onBrVlbOqJnrk2y1oiWF2FERJDleAOzbfWL+
	 zy/KOCK+gtP5pwwTnZ3w2LPiGWTImrVu/LuPzlgMVaLgMstyHLPImHrV7J/xHZJLFp
	 BSfr8xN8KzJhWRb/0ZjpYF34oJgAdrlJzHXgSMwjaKcY7Atlf2AR2ttwEgSqP4SF63
	 a61V7idSxlIzFobiFIYwq767Frdq+qMpjyatSBuy0Wto1UFh/ILdTQYSL4d0xGl86i
	 6Xuk/DEmIJiqA==
Date: Wed, 19 Jun 2024 15:00:39 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jiwei Sun <sunjw10@outlook.com>
Cc: nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, sunjw10@lenovo.com,
	ahuang12@lenovo.com, Thomas Gleixner <tglx@linutronix.de>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] PCI: vmd: Use raw spinlock for cfg_lock
Message-ID: <20240619200039.GA1319210@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEZPR01MB45274AF863D3BD2F028141D9A8CF2@SEZPR01MB4527.apcprd01.prod.exchangelabs.com>

[+cc Thomas in case he has msi_lock comment, Keith in case he has
cfg_lock comment]

On Wed, Jun 19, 2024 at 07:27:59PM +0800, Jiwei Sun wrote:
> From: Jiwei Sun <sunjw10@lenovo.com>
> 
> If the kernel is built with the following configurations and booting
>   CONFIG_VMD=y
>   CONFIG_DEBUG_LOCKDEP=y
>   CONFIG_DEBUG_SPINLOCK=y
>   CONFIG_PROVE_LOCKING=y
>   CONFIG_PROVE_RAW_LOCK_NESTING=y
> 
> The following log appears,
> 
> =============================
> [ BUG: Invalid wait context ]
> 6.10.0-rc4 #80 Not tainted
> -----------------------------
> kworker/18:2/633 is trying to lock:
> ffff888c474e5648 (&vmd->cfg_lock){....}-{3:3}, at: vmd_pci_write+0x185/0x2a0
> other info that might help us debug this:
> context-{5:5}
> 4 locks held by kworker/18:2/633:
>  #0: ffff888100108958 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0xf78/0x1920
>  #1: ffffc9000ae1fd90 ((work_completion)(&wfc.work)){+.+.}-{0:0}, at: process_one_work+0x7fe/0x1920
>  #2: ffff888c483508a8 (&md->mutex){+.+.}-{4:4}, at: __pci_enable_msi_range+0x208/0x800
>  #3: ffff888c48329bd8 (&dev->msi_lock){....}-{2:2}, at: pci_msi_update_mask+0x91/0x170
> stack backtrace:
> CPU: 18 PID: 633 Comm: kworker/18:2 Not tainted 6.10.0-rc4 #80 7c0f2526417bfbb7579e3c3442683c5961773c75
> Hardware name: Lenovo ThinkSystem SR630/-[7X01RCZ000]-, BIOS IVEL60O-2.71 09/28/2020
> Workqueue: events work_for_cpu_fn
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x7c/0xc0
>  __lock_acquire+0x9e5/0x1ed0
>  lock_acquire+0x194/0x490
>  _raw_spin_lock_irqsave+0x42/0x90
>  vmd_pci_write+0x185/0x2a0
>  pci_msi_update_mask+0x10c/0x170
>  __pci_enable_msi_range+0x291/0x800
>  pci_alloc_irq_vectors_affinity+0x13e/0x1d0
>  pcie_portdrv_probe+0x570/0xe60
>  local_pci_probe+0xdc/0x190
>  work_for_cpu_fn+0x4e/0xa0
>  process_one_work+0x86d/0x1920
>  process_scheduled_works+0xd7/0x140
>  worker_thread+0x3e9/0xb90
>  kthread+0x2e9/0x3d0
>  ret_from_fork+0x2d/0x60
>  ret_from_fork_asm+0x1a/0x30
>  </TASK>
> 
> The root cause is that the dev->msi_lock is a raw spinlock, but
> vmd->cfg_lock is a spinlock.

Can you expand this a little bit?  This isn't enough unless one
already knows the difference between raw_spinlock_t and spinlock_t,
which I didn't.

Documentation/locking/locktypes.rst says they are the same except when
CONFIG_PREEMPT_RT is set (might be worth mentioning with the config
list above?), but that with CONFIG_PREEMPT_RT, spinlock_t is based on
rt_mutex.

And I guess there's a rule that you can't acquire rt_mutex while
holding a raw_spinlock.

The dev->msi_lock was added by 77e89afc25f3 ("PCI/MSI: Protect
msi_desc::masked for multi-MSI") and only used in
pci_msi_update_mask():

  raw_spin_lock_irqsave(lock, flags);
  desc->pci.msi_mask &= ~clear;
  desc->pci.msi_mask |= set;
  pci_write_config_dword(msi_desc_to_pci_dev(desc), desc->pci.mask_pos,
			 desc->pci.msi_mask);
  raw_spin_unlock_irqrestore(lock, flags);

The vmd->cfg_lock was added by 185a383ada2e ("x86/PCI: Add driver for
Intel Volume Management Device (VMD)") and is only used around VMD
config accesses, e.g.,

  * CPU may deadlock if config space is not serialized on some versions of this
  * hardware, so all config space access is done under a spinlock.

  static int vmd_pci_read(...)
  {
    spin_lock_irqsave(&vmd->cfg_lock, flags);
    switch (len) {
    case 1:
	    *value = readb(addr);
	    break;
    case 2:
	    *value = readw(addr);
	    break;
    case 4:
	    *value = readl(addr);
	    break;
    default:
	    ret = -EINVAL;
	    break;
    }
    spin_unlock_irqrestore(&vmd->cfg_lock, flags);
  }

IIUC those reads turn into single PCIe MMIO reads, so I wouldn't
expect any concurrency issues there that need locking.

But apparently there's something weird that can deadlock the CPU.

> Signed-off-by: Jiwei Sun<sunjw10@lenovo.com>
> Suggested-by: Adrian Huang <ahuang12@lenovo.com>
> ---
>  drivers/pci/controller/vmd.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 87b7856f375a..45d0ebf96adc 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -125,7 +125,7 @@ struct vmd_irq_list {
>  struct vmd_dev {
>  	struct pci_dev		*dev;
>  
> -	spinlock_t		cfg_lock;
> +	raw_spinlock_t		cfg_lock;
>  	void __iomem		*cfgbar;
>  
>  	int msix_count;
> @@ -402,7 +402,7 @@ static int vmd_pci_read(struct pci_bus *bus, unsigned int devfn, int reg,
>  	if (!addr)
>  		return -EFAULT;
>  
> -	spin_lock_irqsave(&vmd->cfg_lock, flags);
> +	raw_spin_lock_irqsave(&vmd->cfg_lock, flags);
>  	switch (len) {
>  	case 1:
>  		*value = readb(addr);
> @@ -417,7 +417,7 @@ static int vmd_pci_read(struct pci_bus *bus, unsigned int devfn, int reg,
>  		ret = -EINVAL;
>  		break;
>  	}
> -	spin_unlock_irqrestore(&vmd->cfg_lock, flags);
> +	raw_spin_unlock_irqrestore(&vmd->cfg_lock, flags);
>  	return ret;
>  }
>  
> @@ -437,7 +437,7 @@ static int vmd_pci_write(struct pci_bus *bus, unsigned int devfn, int reg,
>  	if (!addr)
>  		return -EFAULT;
>  
> -	spin_lock_irqsave(&vmd->cfg_lock, flags);
> +	raw_spin_lock_irqsave(&vmd->cfg_lock, flags);
>  	switch (len) {
>  	case 1:
>  		writeb(value, addr);
> @@ -455,7 +455,7 @@ static int vmd_pci_write(struct pci_bus *bus, unsigned int devfn, int reg,
>  		ret = -EINVAL;
>  		break;
>  	}
> -	spin_unlock_irqrestore(&vmd->cfg_lock, flags);
> +	raw_spin_unlock_irqrestore(&vmd->cfg_lock, flags);
>  	return ret;
>  }
>  
> @@ -1015,7 +1015,7 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  	if (features & VMD_FEAT_OFFSET_FIRST_VECTOR)
>  		vmd->first_vec = 1;
>  
> -	spin_lock_init(&vmd->cfg_lock);
> +	raw_spin_lock_init(&vmd->cfg_lock);
>  	pci_set_drvdata(dev, vmd);
>  	err = vmd_enable_domain(vmd, features);
>  	if (err)
> -- 
> 2.27.0
> 

