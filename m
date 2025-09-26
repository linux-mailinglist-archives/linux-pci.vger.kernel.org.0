Return-Path: <linux-pci+bounces-37134-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE126BA526B
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 23:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDE7D7A8193
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 21:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A752765CE;
	Fri, 26 Sep 2025 21:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2Ej6LyG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE7B8834;
	Fri, 26 Sep 2025 21:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758920545; cv=none; b=P+aMB1myJefzdphR89FoQomWZsQh1A2K6hXOEgWp3zYYFL4kn6gf5VYArSr7uvQ2ALMVOc+M7ZDSZskNJLDS+LtYfKZNl6X0t7ay+XnfbwlGTK/4qX4vRXSFvR99fO3X2HpGSm+hiwxVUIs9i0DnXZy7v+duTr3Vh+P+ml1fVCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758920545; c=relaxed/simple;
	bh=4jCZlpXaZ80Sq3/lQPGD6Bo/8VJJi2q8bRsY8VTDsls=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=lL/2X3ycIHyEQRUw+DqoxIkzaQ3c7kT0Kq9tdkCA6zrMw2Ly2774nSWZYQNm3WH1FAfJmT/ibQPulGUWXAxt72OfCqAoxJ6WAiAWAAcn+N2UrmdReYhgtpmkipvmkLKJuCvRTc14CQeusPrzRPEftmmarf5fpvti0A1+/x/8T+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2Ej6LyG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77AC7C4CEF4;
	Fri, 26 Sep 2025 21:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758920544;
	bh=4jCZlpXaZ80Sq3/lQPGD6Bo/8VJJi2q8bRsY8VTDsls=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=o2Ej6LyGPefsgyybe3cYqNvmf845P5dNCyDqIv2ZvGAsQiNIBt9QGgLTtPHMVXfAa
	 y5ep01vM2gfHQGKq6csy/9WNWACw4c1kEAFX35K74WH34wruK/CcoJ6NsQ1LOG4PDe
	 +MXDvE4eqbi7u1Vu0gt0xC+lHhlOQgNm0w5zCy8FagkajL2exCnY52L8JIUnGJ6iLw
	 /qUkIsdH0OAEPBjBKxEtJ1o/fVQWsxiRsGap3UMpe01acxJVfeq6Jxju4RC+hBrPkz
	 fN2WFP6orUdT+OIzDpXggimqOGiNMSecj6w1omMmta+1r0tV8dX+/RoP2uTSzMUtZ5
	 SXlRpaTyg8HNg==
Date: Fri, 26 Sep 2025 16:02:23 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Lukas Wunner <lukas@wunner.de>, Keith Busch <kbusch@kernel.org>,
	Gerd Bayer <gbayer@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Benjamin Block <bblock@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
	Julian Ruess <julianr@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] PCI/IOV: Add missing PCI rescan-remove locking when
 enabling/disabling SR-IOV
Message-ID: <20250926210223.GA2267349@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826-pci_fix_sriov_disable-v1-0-2d0bc938f2a3@linux.ibm.com>

On Tue, Aug 26, 2025 at 10:52:07AM +0200, Niklas Schnelle wrote:
> Hi Bjorn, Hi Lukas,
> 
> This series fixes missing PCI rescan-remove locking in sriov_disable()
> and sriov_enable() the former of which was observed to cause a double
> remove / list corruption on s390. The first patch is the fix itself and
> gives more details while the second patch is an optional proposal to add
> a lockdep assertion to pci_stop_and_remove_bus_device() to catch missing
> rescan-remove locking more easily in the future. If applied without the
> first patch disabling SR-IOV via "echo 0 > /sys/bus/pci/devices/<dev>
> /sriov_numvfs" triggers the lockdep assertion. I haven't found an easy
> way to trigger the assertion in the sriov_enable() case but I checked
> callers.
> 
> Also since the sriov_add_vfs() path is not excercised on s390 due to
> pdev->no_vf_scan I did some basic testing on an x86 test system with an
> SR-IOV capable ConnectX-6 DX NIC.
> 
> Thanks,
> Niklas
> 
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
> Niklas Schnelle (2):
>       PCI/IOV: Add missing PCI rescan-remove locking when enabling/disabling SR-IOV
>       PCI: Add lockdep assertion in pci_stop_and_remove_bus_device()
> 
>  drivers/pci/iov.c    | 5 +++++
>  drivers/pci/pci.h    | 2 ++
>  drivers/pci/probe.c  | 2 +-
>  drivers/pci/remove.c | 1 +
>  4 files changed, 9 insertions(+), 1 deletion(-)

Applied to pci/virtualization, hoping to squeeze into v6.18.

