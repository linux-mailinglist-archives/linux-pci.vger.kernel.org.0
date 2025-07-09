Return-Path: <linux-pci+bounces-31822-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 058FBAFF56D
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jul 2025 01:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDA221C48544
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 23:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA562641F8;
	Wed,  9 Jul 2025 23:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLH+iYGl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523F521D001;
	Wed,  9 Jul 2025 23:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752104302; cv=none; b=BpJjt4LIER3yam0kXm4cuapCq4r7wUiEpDRdDSpRImCqMoly4WeAissQOZkaeQM8yrVXOcvLqVICCSKsKkzDwGIRSdn/l/2aZ+k/OFDQ5dGEk3b8Eq9H9NJZ6rPebz0MZC609G47YGd96ncYN1tm7gScAI+29lcjS3BOOX0cSX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752104302; c=relaxed/simple;
	bh=+saq+jsUrUpBT+5osqmmx0pEvV9D8xuRp7bJmqNCkdU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=NlgTzA/AfW3xNVBy9qT2gLjxzM/Yhunnjo8tlewy90JrzUqMymP8Jt2RzMxqqVthLayg5DmXzybThmkk89zpJgDXbxev1OSBpRR2Ajij2v0X9tUD+1yLfhoqVZD/GFaRDWErcPff4oPDYlaSa1ttNi5T8MBn5BwmNU5GxqUv3c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XLH+iYGl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BA26C4CEEF;
	Wed,  9 Jul 2025 23:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752104301;
	bh=+saq+jsUrUpBT+5osqmmx0pEvV9D8xuRp7bJmqNCkdU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=XLH+iYGlSou+fshL81YHTKEnxmlfMB6lVH85uc/p0EZX1I1zxgzeaVyZGQA91E6xT
	 kx1i1Xy7R/9kAwl9S7BhzVsQflbYiJ119OPziCYFCSsZJgjQWECEqwD109ONcrA5vW
	 SpxdjzjpbsbqMt4gvRcaRz8tMhVjkYZBsUJpXmO35uJQAsAqtOTj3uOL+u6VF4Bxrv
	 CY6BCcEBZ58Ow3bRCR8E/SJVmJ5END48v6ecEfesE9G0qPcl6TygvhcYfnPHb2wL1D
	 4yK56gFhx1qLwb9ZTrOTDSM9lf9cjd7VX1XYONI4Q8B3vj4nOPoe4rx/ajVBh+azkK
	 XfeGs4jqOTyJw==
Date: Wed, 9 Jul 2025 18:38:20 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
	Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Parav Pandit <parav@nvidia.com>, virtualization@lists.linux.dev,
	stefanha@redhat.com, alok.a.tiwari@oracle.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH RFC v5 1/5] pci: report surprise removal event
Message-ID: <20250709233820.GA2212185@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fba3d235e38c1c6fcef2a30ed083ad9e25b20fa3.1752094439.git.mst@redhat.com>

Housekeeping: Note subject line convention. Indent with spaces in
commit log.  Remove spurious plus signs.

On Wed, Jul 09, 2025 at 04:55:26PM -0400, Michael S. Tsirkin wrote:
> At the moment, in case of a surprise removal, the regular remove
> callback is invoked, exclusively.  This works well, because mostly, the
> cleanup would be the same.
> 
> However, there's a race: imagine device removal was initiated by a user
> action, such as driver unbind, and it in turn initiated some cleanup and
> is now waiting for an interrupt from the device. If the device is now
> surprise-removed, that never arrives and the remove callback hangs
> forever.
> 
> For example, this was reported for virtio-blk:
> 
> 	1. the graceful removal is ongoing in the remove() callback, where disk
> 	   deletion del_gendisk() is ongoing, which waits for the requests +to
> 	   complete,
> 
> 	2. Now few requests are yet to complete, and surprise removal started.
> 
> 	At this point, virtio block driver will not get notified by the driver
> 	core layer, because it is likely serializing remove() happening by
> 	+user/driver unload and PCI hotplug driver-initiated device removal.  So
> 	vblk driver doesn't know that device is removed, block layer is waiting
> 	for requests completions to arrive which it never gets.  So
> 	del_gendisk() gets stuck.
> 
> Drivers can artificially add timeouts to handle that, but it can be
> flaky.
> 
> Instead, let's add a way for the driver to be notified about the
> disconnect. It can then do any necessary cleanup, knowing that the
> device is inactive.

This relies on somebody (typically pciehp, I guess) calling
pci_dev_set_disconnected() when a surprise remove happens.

Do you think it would be practical for the driver's .remove() method
to recognize that the device may stop responding at any point, even if
no hotplug driver is present to call pci_dev_set_disconnected()?

Waiting forever for an interrupt seems kind of vulnerable in general.
Maybe "artificially adding timeouts" is alluding to *not* waiting
forever for interrupts?  That doesn't seem artificial to me because
it's just a fact of life that devices can disappear at arbitrary
times.

It seems a little fragile to me to depend on some other part of the
system to notice the surprise removal and tell you about it or
schedule your work function.  I think it would be more robust for the
driver to check directly, i.e., assume writes to the device may be
lost, check for PCI_POSSIBLE_ERROR() after reads from the device, and
never wait for an interrupt without a timeout.

> Since cleanups can take a long time, this takes an approach
> of a work struct that the driver initiates and enables
> on probe, and tears down on remove.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/pci/pci.h   |  6 ++++++
>  include/linux/pci.h | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 51 insertions(+)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 12215ee72afb..3ca4ebfd46be 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -553,6 +553,12 @@ static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
>  	pci_dev_set_io_state(dev, pci_channel_io_perm_failure);
>  	pci_doe_disconnected(dev);
>  
> +	if (READ_ONCE(dev->disconnect_work_enable)) {
> +		/* Make sure work is up to date. */
> +		smp_rmb();
> +		schedule_work(&dev->disconnect_work);
> +	}
> +
>  	return 0;
>  }
>  
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 05e68f35f392..723b17145b62 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -548,6 +548,10 @@ struct pci_dev {
>  	/* These methods index pci_reset_fn_methods[] */
>  	u8 reset_methods[PCI_NUM_RESET_METHODS]; /* In priority order */
>  
> +	/* Report disconnect events. 0x0 - disable, 0x1 - enable */
> +	u8 disconnect_work_enable;
> +	struct work_struct disconnect_work;
> +
>  #ifdef CONFIG_PCIE_TPH
>  	u16		tph_cap;	/* TPH capability offset */
>  	u8		tph_mode;	/* TPH mode */
> @@ -1993,6 +1997,47 @@ pci_release_mem_regions(struct pci_dev *pdev)
>  			    pci_select_bars(pdev, IORESOURCE_MEM));
>  }
>  
> +/*
> + * Run this first thing after getting a disconnect work, to prevent it from
> + * running multiple times.
> + * Returns: true if disconnect was enabled, proceed. false if disabled, abort.
> + */
> +static inline bool pci_test_and_clear_disconnect_enable(struct pci_dev *pdev)
> +{
> +	u8 enable = 0x1;
> +	u8 disable = 0x0;
> +	return try_cmpxchg(&pdev->disconnect_work_enable, &enable, disable);
> +}
> +
> +/*
> + * Caller must initialize @pdev->disconnect_work before invoking this.
> + * The work function must run and check pci_test_and_clear_disconnect_enable.
> + * Note that device can go away right after this call.
> + */
> +static inline void pci_set_disconnect_work(struct pci_dev *pdev)
> +{
> +	/* Make sure WQ has been initialized already */
> +	smp_wmb();
> +
> +	WRITE_ONCE(pdev->disconnect_work_enable, 0x1);
> +
> +	/* check the device did not go away meanwhile. */
> +	mb();
> +
> +	if (!pci_device_is_present(pdev))
> +		schedule_work(&pdev->disconnect_work);
> +}
> +
> +static inline void pci_clear_disconnect_work(struct pci_dev *pdev)
> +{
> +	WRITE_ONCE(pdev->disconnect_work_enable, 0x0);
> +
> +	/* Make sure to stop using work from now on. */
> +	smp_wmb();
> +
> +	cancel_work_sync(&pdev->disconnect_work);
> +}
> +
>  #else /* CONFIG_PCI is not enabled */
>  
>  static inline void pci_set_flags(int flags) { }
> -- 
> MST
> 

