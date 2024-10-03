Return-Path: <linux-pci+bounces-13741-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CA798E784
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2024 02:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 209381F25F26
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2024 00:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C8138C;
	Thu,  3 Oct 2024 00:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mg9AO4Vh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA4C38B
	for <linux-pci@vger.kernel.org>; Thu,  3 Oct 2024 00:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727913892; cv=none; b=rLj+0a+4nIdOJnn4bf1I+4Ff8AkpcBvfqk7ITIu9kvJfAxiCBP7t7dvSbi5kFW8jH5M5+bS4XLwUSkcWatebTSvLvJVqm1Fkawg4ALmALJ3YsTLTyUMgCffPQmZ+oEzIZvjjjuY0RnuaBkj9v0Togeb5xPxg4EoKrA9d13IJ2iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727913892; c=relaxed/simple;
	bh=fzwriY9KdzQ/vI9K54QePO9zEqU3L5eVVuMdk+fAUbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tCRjckCt4oDzVrM2MP6W4f5kSPOMs2x2xl0B+FOz36p2WQGxKyVX/T5dDrJORG/LI2cDUo9n3YR+s/RifMbha05CiWvGRHkjPLUcMMPky/gyQ9o2a204dG5qnzB+Bx8ZzbE9NsHqQixrTv/fLI/eDZ21qXFt50HaVxIExjYdBUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mg9AO4Vh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6460FC4CEC2;
	Thu,  3 Oct 2024 00:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727913891;
	bh=fzwriY9KdzQ/vI9K54QePO9zEqU3L5eVVuMdk+fAUbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mg9AO4VhWPI448ZXDU6XoQhkaPYgepunw7zdtiuN4jG4q4OnyWPyFRW3P+Ho86KHG
	 UQpQyFUxfcski1yqy1iBm3vja5uqNyY8FpNkYZY47fwvA9ASJEwFFjLre2lFref2R2
	 1ZagpTMuAjfJCFw89HGAdZG2ccs0HUfKUen8JY3hfHsC0ZCtJpxxoxAutpCF/NUKHO
	 r0vi/dAysareB1+zfdwzFpWzJEtcIH6pjbGey9CltWb6aCehEBwxS8TuuDoFVBK6JF
	 +X1wAXLqzBa5Lw+DN1bSxhHpnY/5XxAMm/WAk749z2Q6eVvLZ6Vw8PnSQwrrmyqY+F
	 rdtvpnF9LjaqQ==
Date: Wed, 2 Oct 2024 18:04:48 -0600
From: Keith Busch <kbusch@kernel.org>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: Keith Busch <kbusch@meta.com>, linux-pci@vger.kernel.org,
	bhelgaas@google.com, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCHv2 1/5] pci: make pci_stop_dev concurrent safe
Message-ID: <Zv3foGpzXKx8adcy@kbusch-mbp>
References: <20240827192826.710031-1-kbusch@meta.com>
 <20240827192826.710031-2-kbusch@meta.com>
 <20241002233937.jvudgfhxjqbspq6n@offworld>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002233937.jvudgfhxjqbspq6n@offworld>

On Wed, Oct 02, 2024 at 04:39:37PM -0700, Davidlohr Bueso wrote:
> > +	set_bit(PCI_DEV_ADDED, &dev->priv_flags);
> > +}
> 
> So set_bit does not imply any barriers. 

Huh. Hannes told me the same thing just last weak, and I was thinking
"nah, it's an atomic operation." But I'm mistaken thinking that provides
a memory barrier.

> Does this matter in the future when breaking up
> pci_rescan_remove_lock? For example, what prevents things like:

We're still far from being able to remove the big pci rescan/remove
lock, but yes, that's the idea. This should be safe as-is since it is
still using that lock, I can add smp barriers to make the memroy
dependencies explicit.
 
> pci_bus_add_device()			pci_stop_dev()
>     pci_dev_assign_added()
> 	dev->priv_flags [S]
> 					    pci_dev_test_and_clear_added() // true
> 						dev->priv_flags [L]
>     device_attach(&dev->dev)
> 					    device_release_driver(&dev->dev)
> 
> ... I guess that implied barrier from that device_lock() in device_attach().
> I am not familiar with this code, but overall I think any locking rework should
> explain more about the ordering implications in the changes if the end result

Oh, goot point. This sequence shouldn't be possible with either the
existing or proposed bus locking, and I can certainly add more detailed
explanations.

