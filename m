Return-Path: <linux-pci+bounces-10663-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 878B193A485
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 18:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47C4C283AC7
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 16:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C06715748E;
	Tue, 23 Jul 2024 16:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j77iUv5I"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027F013B287;
	Tue, 23 Jul 2024 16:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721753301; cv=none; b=ggR9hWGNEXRNx07fB2XdtUbNG9TYp3pRGejujPhP6HB+2mP7hBKdumRn5XrUgKZje6glzUHBTy/KhI9VcYfHLDYr+j9r2u+dQU7ZOZL3A5DtbhskxkXx4dD48Wm/Tb7hXtnubqr/qxh6z07IwyVtPd4JfrGCRGuYowjwnAJ8cJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721753301; c=relaxed/simple;
	bh=72kqMw43xIKt1+EjiOzFO8x8diXBtCq9Ge6RJyrtpfE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=GYaUU6LQgdVmcOA5pDk/YNXZSKGSxGqkjaNZQcZH9MqWxoNSbGkCGhRJqcHvlxKLXyqpoVZPQFI+dxgM92mZYeS8xfEGUGMQo7S1VZspSgeZQFqDuEK0kKxYHjj/iJyvuPp9Zaf30PkK4MiXC+aklcSkH1j1rcscE0NSwSw9480=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j77iUv5I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40EB3C4AF0A;
	Tue, 23 Jul 2024 16:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721753300;
	bh=72kqMw43xIKt1+EjiOzFO8x8diXBtCq9Ge6RJyrtpfE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=j77iUv5I/A8gz1Vh8m5n44iIzE1I5OlMI40Gse0oetgBQ/NT/cT77RVVwu1chXQVX
	 VPvbFUrDyck1eSeOsP8ygchWj/c+y2x2KznBeihlUNduZ0bXJneh/sG2DhwWwZnMSN
	 tFtgdR7pODDyNmCBvPTj5owwmLpb/27SHlsfVXX6LJOI6ZeRgXpDOC7jhTT1Ek6523
	 KPhLN2K151AnC9To+sfkvYtTAEWUCkR6GRHTHt6RxLfoLSRlkhzFAFtbBc7n6CHilL
	 VKsHjynniyBLdBxncMBfU5AsdaGA/5fWc6Os0NLWAFmNCof3YOAsrjEDwiouZA4GKN
	 Loic5wFhh6WSQ==
Date: Tue, 23 Jul 2024 11:48:18 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Wei Huang <wei.huang2@amd.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, netdev@vger.kernel.org,
	Jonathan.Cameron@huawei.com, corbet@lwn.net, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	alex.williamson@redhat.com, gospo@broadcom.com,
	michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
	somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com,
	manoj.panicker2@amd.com, Eric.VanTassell@amd.com,
	vadim.fedorenko@linux.dev, horms@kernel.org, bagasdotme@gmail.com,
	bhelgaas@google.com
Subject: Re: [PATCH V3 09/10] bnxt_en: Add TPH support in BNXT driver
Message-ID: <20240723164818.GA760263@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717205511.2541693-10-wei.huang2@amd.com>

On Wed, Jul 17, 2024 at 03:55:10PM -0500, Wei Huang wrote:
> From: Manoj Panicker <manoj.panicker2@amd.com>
> 
> Implement TPH support in Broadcom BNXT device driver by invoking
> pcie_tph_set_st() function when interrupt affinity is changed.

*and* invoking pcie_tph_set_st() when setting up the IRQ in the first
place, I guess?

I guess this gives a significant performance benefit?  The series
includes "pci=nostmode" so the benefit can be quantified, so now I'm
curious about what you measured :)

> +static void bnxt_rtnl_lock_sp(struct bnxt *bp);
> +static void bnxt_rtnl_unlock_sp(struct bnxt *bp);

These duplicate declarations can't be right, can they?  OK for
work-in-progress, but it doesn't look like the final solution.

> +static void __bnxt_irq_affinity_notify(struct irq_affinity_notify *notify,
> +				       const cpumask_t *mask)
> +{
> +	struct bnxt_irq *irq;
> +
> +	irq = container_of(notify, struct bnxt_irq, affinity_notify);
> +	cpumask_copy(irq->cpu_mask, mask);
> +
> +	if (!pcie_tph_set_st(irq->bp->pdev, irq->msix_nr,
> +			     cpumask_first(irq->cpu_mask),
> +			     TPH_MEM_TYPE_VM, PCI_TPH_REQ_TPH_ONLY))
> +		netdev_dbg(irq->bp->dev, "error in setting steering tag\n");
> +
> +	if (netif_running(irq->bp->dev)) {
> +		rtnl_lock();
> +		bnxt_close_nic(irq->bp, false, false);
> +		bnxt_open_nic(irq->bp, false, false);
> +		rtnl_unlock();
> +	}
> +}

