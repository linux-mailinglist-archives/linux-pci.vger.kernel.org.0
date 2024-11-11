Return-Path: <linux-pci+bounces-16456-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CD49C444E
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 18:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 867CC28A33F
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 17:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EB21AA78D;
	Mon, 11 Nov 2024 17:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iraPhC48"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BD31AA1C4
	for <linux-pci@vger.kernel.org>; Mon, 11 Nov 2024 17:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731347954; cv=none; b=ne3Sool6IwT1zG/DxLJQt8WMwMsJSk28dKUDjm/G0pqJugUxKJaxxhujHVrD5032h4N/ZB2MiznPhgBZADXKO+rejlCYjlWNVyzbwisIJ0BFqCBGhmFt3OQtpniAF+quszzTFWcoxKvj12l61bR4yLORKxz5YgRbMZ2AQUrUJYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731347954; c=relaxed/simple;
	bh=0NpiMVM81gqRJwJWhNlQr4rw8UjpuFF2SQ5zCr1nWHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fB4m59eDJvYVHn95GWZhfqPmve5vauHb+QMRPnK+duAS4o6/WVaFO9WwLaUXBvRp7oAMqr7uwLuD+OsoYyEQIhwKovrwHiP0dkFI5xl0lCUM4k+M3OQkyOuHGPDidFnDlDl54rzVdO0NIp1UTFZnrPpnKaHqaXZNFQqmtWm54tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iraPhC48; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B688C4CECF;
	Mon, 11 Nov 2024 17:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731347953;
	bh=0NpiMVM81gqRJwJWhNlQr4rw8UjpuFF2SQ5zCr1nWHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iraPhC48yeg9poA230RDcAtcqhNGIDGYWUBFRmkAM8beSubqzKQhVLmujZ8YNoizN
	 kYYiJx+7tvfC9NecMX2GgDdYZ0yVzbE2CIdTfOxmcfjOnqld8GDVMoFBYx5HQbD039
	 +OxUr1iI8A5ebRKB3a4KtNP5IiAPvUWOSOGrusS5ZIS3hOlG+/O22WhDSbgcjPYRvH
	 G1q0rSH39P0HcBX+RME5N6BxNd3bL2YkBIBoed6dOL8T/U2Qi6YvI9pmbpKwbO4e8d
	 2BAgL79krDGB87+4cyUEi8KlVe/ZVX2QZapse2kDtqf+l2UxbebyVTe8QzjaOhWa8M
	 I7lvJP7JkpgiA==
Date: Mon, 11 Nov 2024 10:59:11 -0700
From: Keith Busch <kbusch@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Keith Busch <kbusch@meta.com>, linux-pci@vger.kernel.org,
	bhelgaas@google.com
Subject: Re: [PATCHv2 1/2] PCI: pciehp: fix concurrent sub-tree removal
 deadlock
Message-ID: <ZzJF77YoNO-fdmow@kbusch-mbp.dhcp.thefacebook.com>
References: <20240612181625.3604512-1-kbusch@meta.com>
 <20240612181625.3604512-2-kbusch@meta.com>
 <Zn0Y-UhMqCo2PCtM@wunner.de>
 <ZzG0W7LGrggNa6Qi@wunner.de>
 <ZzG5koPOn16KQ8uM@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzG5koPOn16KQ8uM@wunner.de>

On Mon, Nov 11, 2024 at 09:00:18AM +0100, Lukas Wunner wrote:
> On Mon, Nov 11, 2024 at 08:38:03AM +0100, Lukas Wunner wrote:
> > Thinking about this some more:
> > 
> > The problem is pci_lock_rescan_remove() is a single global lock.
> > 
> > What if we introduce a lock at each bridge or for each pci_bus.
> > Before a portion of the hierarchy is removed, all locks in that
> > sub-hierarchy are acquired bottom-up.
> > 
> > I think that should avoid the deadlock.  Thoughts?
> 
> I note that you attempted something similar back in July:
> 
> https://lore.kernel.org/all/20240722151936.1452299-9-kbusch@meta.com/
> 
> However I'd suggest to solve this differently:
> 
> Keep the pci_lock_rescan_remove() everywhere, don't add pci_lock_bus()
> adjacent to it.
> 
> Instead, amend pci_lock_rescan_remove() to walk the sub-hierarchy
> bottom-up and acquire all the bus locks.  Obviously you'll have to amend
> pci_lock_rescan_remove() to accept a pci_dev which is the bridge atop
> the sub-hierarchy.  (Or alternatively, the top-most pci_bus in the
> sub-hierarchy.)

I don't think we can walk the bus bottom-up without hitting the same
deadlock I'm trying to fix.

