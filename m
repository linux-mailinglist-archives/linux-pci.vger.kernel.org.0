Return-Path: <linux-pci+bounces-19383-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D04C9A03705
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 05:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF5EC7A0411
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 04:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9AD3F9FB;
	Tue,  7 Jan 2025 04:29:50 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3A1ECC
	for <linux-pci@vger.kernel.org>; Tue,  7 Jan 2025 04:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736224190; cv=none; b=AQ4dY0ToO4FgZN01GNo7IhjY9ddlyNdKQKLMvR6ii2yAqAFJqTAg+TtBMUs0kQH8ne7tpZW8ycEV2cJzDr0ajATi2DiWZyHnsTeiwqbMnuB6ESNEHK2hgP9zFMafSuD6ERg3tFI12r5We/3WUAKt5rluvWC7FsDkk13fxneIV0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736224190; c=relaxed/simple;
	bh=mfvuI+yhpQ5vxrq3yTzpW1d+Kh1E57HAvlXC/FRmlcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m3oFHZDj7muRLwRNEBSF5G1WW8JDzJMXvrwYDAaGDKhQS7Daacp/7O+qum+kWQUnZZBynHH0vccVQyepaEFfo407C+KSxe2vZR1ZP3iSyPZ6x0ShMxujNn1ReKXMNCFrmk/HosJFT3S4AdA7ZB6puhrET7vaKWEPp6F4oskvBzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 84E382800B485;
	Tue,  7 Jan 2025 05:29:37 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 69FF3558D39; Tue,  7 Jan 2025 05:29:37 +0100 (CET)
Date: Tue, 7 Jan 2025 05:29:37 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Krzysztof Wilczynski <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org, Niklas Schnelle <niks@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Evert Vorster <evorster@gmail.com>
Subject: Re: [PATCH for-linus] PCI/bwctrl: Fix NULL pointer deref on unbind
 and bind
Message-ID: <Z3ytsSBP3FzuFLRj@wunner.de>
References: <0ee5faf5395cad8d29fb66e1ec444c8d882a4201.1735852688.git.lukas@wunner.de>
 <e08d30b5-50e0-4381-d2e7-61c2da12966f@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e08d30b5-50e0-4381-d2e7-61c2da12966f@linux.intel.com>

On Sun, Jan 05, 2025 at 06:54:24PM +0200, Ilpo Järvinen wrote:
> Indeed, it certainly didn't occur to me while arranging the code the way 
> it is that there are other sources for the same irq. However, there is a 
> reason those lines where within the same critical section (I also realized 
> it's not documented anywhere):
> 
> As bwctrl has two operating modes, one with BW notifications and the other 
> without them, there are races when switching between those modes during 
> probe wrt. call to lbms counting accessor, and I reused those rw 
> semaphores to prevent those race (the race fixes were noted only in a 
> history bullet of the bwctrl series).

Could you add code comment(s) to document this?

I've respun the patch, but of course yesterday was a holiday in Finland.
So I'm hoping you get a chance to review the v2 patch today.


It seems pcie_bwctrl_setspeed_rwsem is only needed because
pcie_retrain_link() calls pcie_reset_lbms_count(), which
would recursively acquire pcie_bwctrl_lbms_rwsem.

There are only two callers of pcie_retrain_link(), so I'm
wondering if the invocation of pcie_reset_lbms_count()
can be moved to them, thus avoiding the recursive lock
acquisition and allowing to get rid of pcie_bwctrl_setspeed_rwsem.
An alternative would be to have a __pcie_retrain_link() helper
which doesn't call pcie_reset_lbms_count().

Right now there are no less than three locks used by bwctrl
(the two global rwsem plus the per-port mutex).  That doesn't
look elegant and makes it difficult to reason about the code,
so simplifying the locking would be desirable I think.


I'm also wondering if the IRQ handler really needs to run in
hardirq context.  Is there a reason it can't run in thread
context?  Note that CONFIG_PREEMPT_RT=y (as well as the
"threadirqs" command line option) cause the handler to be run
in thread context, so it must work properly in that situation
as well.


Another oddity that caught my eye is the counting of the
interrupts.  It seems the only place where lbms_count is read
is the pcie_failed_link_retrain() quirk, and it only cares
about the count being non-zero.  So this could be a bit in
pci_dev->priv_flags that's accessed with set_bit() / test_bit()
similar to pci_dev_assign_added() / pci_dev_is_added().

Are you planning on using the count for something else in the
future?  If not, using a flag would be simpler and more economical
memory-wise.  I'm also worried about the lbms_count overflowing.


Because there's hardware which signals an interrupt before actually
setting one of the two bits in the Link Status Register, I'm
wondering if it would make sense to poll the register a couple
of times in the irq handler.  Obviously this is only an option
if the handler is running in thread context.  What was the maximum
time you saw during testing that it took to set the LBMS bit belatedly?

If you don't poll for the LBMS bit, then you definitely should clear
it on unbind in case it contains a stale 1.  Or probably clear it in
any case.

Thanks,

Lukas

