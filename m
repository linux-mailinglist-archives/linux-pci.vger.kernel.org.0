Return-Path: <linux-pci+bounces-44840-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FFED21063
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 20:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AB623025A7F
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 19:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F23346798;
	Wed, 14 Jan 2026 19:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJS+Z3N3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04297329E6A
	for <linux-pci@vger.kernel.org>; Wed, 14 Jan 2026 19:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768418699; cv=none; b=qdDitejQmQKb0TxuYSQbiK94T/8kJrKCb1pERlupVIVRL1S85KWQ0mEgnE/jbdr86OIx7baZ+HgRX5gp5fKdM+kxB/4hlmNFfRQMXTmAoa11zdqONIZZXZPt/5BfnylAVvl2uCYPaHb3a9ZBrnQPCgmyZYrWXQAit8zgWeDdozc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768418699; c=relaxed/simple;
	bh=g57ez4p8R4tWbrf4gOaMhjaKyyWIKyCZqEbjLUl/7dQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mKZs2gFt2/k0Vfio9mb1PiFk9J+Z8zWEdlRzCwdw446Nhvi1dl8As4DVY4ScUQM9CC384UgJFjG/K87IX64HiSmXqN9Uxkn6nQpyoOeNxXew5tefyGy2LELd7DnY5gsIxPDa+kDf/a/qYzEx6CLjDQGHN4y3rDztvFSH5/HCit0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJS+Z3N3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C11EC4CEF7;
	Wed, 14 Jan 2026 19:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768418698;
	bh=g57ez4p8R4tWbrf4gOaMhjaKyyWIKyCZqEbjLUl/7dQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kJS+Z3N3BZDYuDhOFPhcpsOYAK1cSwVV+ZBP37u+ryiWL7lC/0to6d+xeFFsdXMsU
	 IF32V3oUg32/inoIMiu8wU5E7RpwrGGFky58nP1zZ33OyNSa6+TL4MZEogAkNCSN9u
	 QWiF72HSThTTR5ODcw9aHDrK+skgrFnpkmnGDjqYrzrNVoL8j8zPqK/6jSOapyV4uU
	 yaguZevUeSIUZsFjRT9/nQS4c1KZ9cF+oGArr6y+E+xWliM2NZXuWnuDQard/5YvrI
	 Mhdwrg9GTEnqGLx5gCyXeAjgFckn9w2XaCMhPcLlMUvZa6WUsYWZsKHfUHJEy2lWI+
	 jYw72SMOn5aLg==
Date: Wed, 14 Jan 2026 12:24:56 -0700
From: Keith Busch <kbusch@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-pci@vger.kernel.org,
	bhelgaas@google.com, Alex Williamson <alex@shazbot.org>,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] pci: make reset_subordinate hotplug safe
Message-ID: <aWftiPx6_7naz4uy@kbusch-mbp>
References: <20260114185821.704089-1-kbusch@meta.com>
 <20260114191828.GA830415@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114191828.GA830415@bhelgaas>

On Wed, Jan 14, 2026 at 01:18:28PM -0600, Bjorn Helgaas wrote:
> [+cc Alex, Lukas]
> 
> On Wed, Jan 14, 2026 at 10:58:21AM -0800, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > Use the slot reset method when resetting the bridge if the bus contains
> > hotplug slots. This fixes spurious hotplug events the secondary bus
> > reset triggers by utilizing slot's specific reset callback that ignores
> > link events.
> 
> What do these spurious events look like in dmesg?

Sure, after starting the reset_subordinate:

 # echo 1 > /sys/bus/pci/devices/0000:00:03.1/reset_subordinate

Kernel dmesg currently show something like this:

  pci 0000:01:03.4: save config 0x30: 0x00000000
  pci 0000:01:03.4: save config 0x34: 0x00000040
  pci 0000:01:03.4: save config 0x38: 0x00000000
  pci 0000:01:03.4: save config 0x3c: 0x000001ff
  pcieport 0000:00:03.1: pciehp: pending interrupts 0x0100 from Slot Status
  pcieport 0000:00:03.1: pciehp: Slot(33): Link Down
  pci 0000:01:03.4: PME# disabled
  pcieport 0000:00:03.1: waiting 100 ms for downstream link, after activation
  pcieport 0000:00:03.1: pciehp: pending interrupts 0x0008 from Slot Status
  pcieport 0000:00:03.1: pciehp: pending interrupts 0x0008 from Slot Status
  pcieport 0000:00:03.1: pciehp: pending interrupts 0x0100 from Slot Status
  pci 0000:01:00.0: disconnected; not waiting
  pci 0000:01:00.0: restore config 0x3c: 0xffffffff -> 0x000001ff

The desirable behavior we'd expect to see instead would inclue this
message:

  pcieport 0000:00:03.1: pciehp: Slot(33): Link Down/Up ignored

