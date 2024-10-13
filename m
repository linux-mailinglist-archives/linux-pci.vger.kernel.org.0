Return-Path: <linux-pci+bounces-14412-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C293899BA35
	for <lists+linux-pci@lfdr.de>; Sun, 13 Oct 2024 17:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F2CB1F21B5A
	for <lists+linux-pci@lfdr.de>; Sun, 13 Oct 2024 15:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE3D1465AE;
	Sun, 13 Oct 2024 15:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQN55DUY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD9A145B1F;
	Sun, 13 Oct 2024 15:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728835117; cv=none; b=mcLVqnGUhv8AczMyvmB8IqSaHMQaCOKQSy70kheXEi6XG5pmDnPDCugrAxCjBqh4er7XJVq6W3pm7eyVOMZ3VaZZM5eMPh/JDUrAh61Us8ECfTfsipYrnjKHeNAFfKI9sSueY3jzP3/S0RjZsEpnRhKPn9ulT4em9iSposlbYpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728835117; c=relaxed/simple;
	bh=Sj76r7XqRUyXlV5pB6AePNQPILfWU/XU/2fmpIPRtII=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=kwi3kcbGyHA8onMEF2XpwdKF4hG4xTMn5KFjFF52ATvrQlpVnfVkiZeJGeL3BYQq7fkh5DGxC8UXBEoDz0F5ibjbAQGK/JtV94bZ6ypz9TPbi4vM1zsZN7QUbbp/IXxJKG6A0BTP+9kK8HhbSMy9skFkisRRYO73kHuRcIlZ7i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQN55DUY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA5A4C4CEC5;
	Sun, 13 Oct 2024 15:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728835117;
	bh=Sj76r7XqRUyXlV5pB6AePNQPILfWU/XU/2fmpIPRtII=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=YQN55DUYQ2ZGpgBoXn2YIb9BRXqsa58llbNpQMSKVq2rd/kiM4x/rBmHGU6mOj6YL
	 ny1pp3hfCuBRqgK6AgG/BK+axjPdofQgY40FTT5ovdT0aoSZIJhRFThJIqWdUS1IGL
	 lzB4mvZRfNw1F0AvOFOiYQR0mUWOt/yoI1jNzGfWi5ToaQbJJKG38LPJc1sM4fSl0u
	 Um0F2TzYa16f3Ek4co//OqBZISwaiN9mU7EAv+GGwtQoPDWlT1nI/mWGkyujlApEKi
	 i3pDUjg1nS3N8y8YGnkt9l0qrL8nC619kkVxAo4c3zq8+Zk3bVgTHwvmbnb55WaNiL
	 IxxpF8NQFvIxQ==
Date: Sun, 13 Oct 2024 10:58:34 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Gregory Price <gourry@gourry.net>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, lukas@wunner.de,
	dan.j.williams@intel.com, bhelgaas@google.com, dave@stgolabs.net,
	dave.jiang@intel.com, vishal.l.verma@intel.com,
	Jonathan.Cameron@huawei.com
Subject: Re: [PATCH] PCI/DOE: Poll DOE Busy bit for up to 1 second in
 pci_doe_send_req
Message-ID: <20241013155834.GA607803@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwkvMIqC2DjLZJrg@PC2K9PVX.TheFacebook.com>

On Fri, Oct 11, 2024 at 09:59:12AM -0400, Gregory Price wrote:
> On Thu, Oct 10, 2024 at 05:16:28PM -0500, Bjorn Helgaas wrote:
> > On Fri, Oct 04, 2024 at 12:28:28PM -0400, Gregory Price wrote:
> > > During initial device probe, the PCI DOE busy bit for some CXL
> > > devices may be left set for a longer period than expected by the
> > > current driver logic. Despite local comments stating DOE Busy is
> > > unlikely to be detected, it appears commonly specifically during
> > > boot when CXL devices are being probed.
> > > 
> > > This was observed on a single socket AMD platform with 2 CXL memory
> > > expanders attached to the single socket. It was not the case that
> > > concurrent accesses were being made, as validated by monitoring
> > > mailbox commands on the device side.
> > > 
> > > This behavior has been observed with multiple CXL memory expanders
> > > from different vendors - so it appears unrelated to the model.
> > > 
> > > In all observed tests, only a small period of the retry window is
> > > actually used - typically only a handful of loop iterations.
> > > 
> > > Polling on the PCI DOE Busy Bit for (at max) one PCI DOE timeout
> > > interval (1 second), resolves this issues cleanly.
> > > 
> > > Per PCIe r6.2 sec 6.30.3, the DOE Busy Bit being cleared does not
> > > raise an interrupt, so polling is the best option in this scenario.
> > > 
> > > Subsqeuent code in doe_statemachine_work and abort paths also wait
> > > for up to 1 PCI DOE timeout interval, so this order of (potential)
> > > additional delay is presumed acceptable.
> > 
> > I provisionally applied this to pci/doe for v6.13 with Lukas and
> > Jonathan's reviewed-by.  
> > 
> > Can we include a sample of any dmesg logging or other errors users
> > would see because of this problem?  I'll update the commit log with
> > any of this information to help users connect an issue with this fix.
> >
> 
> The only indication in dmesg you will see is a line like
> 
> [   24.542625] endpoint6: DOE failed -EBUSY
> 
> produced by cxl_cdat_get_length or cxl_cdat_read_table
> 
> 
> Do you want an updated patch with the nits fixed?

No need, I fixed the nits and added the dmesg line to the commit log.
Thank you!

Bjorn

