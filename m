Return-Path: <linux-pci+bounces-17075-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF099D2799
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2024 15:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4919EB280C8
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2024 14:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF171CCB5F;
	Tue, 19 Nov 2024 14:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qvFPjAN2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860921CCB41
	for <linux-pci@vger.kernel.org>; Tue, 19 Nov 2024 14:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732025077; cv=none; b=iibGVfScQ+Vr6eCUJ39V41W6zxUo/f7lKS1uAjncvtJYv6TkllN7g5+A3TAGubpOyFgYzRF/UOGbo61lP4FrQbaTJmesKL0RcVsGr8ycb9jLCU/oW6SLVdd0XMg8ByGUA+l/OFJJkLJ+6Kr6wpFqwHY8FS2P0onVyeELZYVuwWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732025077; c=relaxed/simple;
	bh=EFj27XiSlI2F/cFhX41NCqaPibp9dHWCXZHyIoyG7DM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=IpGsEZNpuRVDKQdwQ3Sk1AR4QkMsl0uyh02NSomLv5FuDjZE05bS7yBBNAo2iwxbyIb1Cqb+8DldITnMMpHlpJy9e2IjoBwMBOYVxDTUPEaAk3i2YFvU2N/I9SP+Ilp2gG+yDxRAv4eHIRZVnz3OXiaB80i8jr9sKV8RiAkleoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qvFPjAN2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3951BC4CECF;
	Tue, 19 Nov 2024 14:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732025077;
	bh=EFj27XiSlI2F/cFhX41NCqaPibp9dHWCXZHyIoyG7DM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=qvFPjAN2/6xBHW4Ai5JsPJlgvLtwi40JjswpJa2TEqEFqqXqaBSUbE8nq8Gn9CnJw
	 5r7RW+kpKjQS9VarglUVacZo5oTfYNzeq5pCW4OUAXbMRQp9vIcL5aOSCsg6omNslo
	 Z/t8Yth7S+5oTJpjTFOrMRSxdBl1gYqr5Rrq2k+kyNpXYXd3bcuVRpuTp2Uv9Dgkf6
	 Mln77kgYeimg1g8fRBzXSBMidDmz81EYJILS1ubTi2eHHZf/lN4K2SAqm2DRpQELQ4
	 q2OzbrX3eG1Qgwebp8MPtmUC7+qFjgjyDsKl5b/TSWZ54uop90d5N4LttbSOemLLB4
	 nFt5G6QET5PXg==
Date: Tue, 19 Nov 2024 08:04:34 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	dullfire@yahoo.com, linux-pci@vger.kernel.org
Subject: Re: [Bug 219513] New: PCIe drivers do not bind
Message-ID: <20241119140434.GA2260828@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bug-219513-41252@https.bugzilla.kernel.org/>

On Tue, Nov 19, 2024 at 12:55:36PM +0000, bugzilla-daemon@kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=219513
> 
>           Hardware: Sparc64
>           Priority: P3
>           Reporter: dullfire@yahoo.com
>         Regression: No
> 
> Created attachment 307241
>   --> https://bugzilla.kernel.org/attachment.cgi?id=307241&action=edit
> debug info (some shell commands to check the PCIe devices and drivers)
> 
> In linux-next (next-20241118), since
> commit 03cfe0e05650 ("PCI/pwrctl: Ensure that the pwrctl drivers are probed
> before the PCI client drivers")
> PCIe drivers no longer bind (at least on the tested SPARCv9 system).
> 
> It appears a "supplier" devlink is created, however it is are dormant. see
> attached "bug-info.txt"

Thanks for the report.  It sounds like you bisected this to
03cfe0e05650?  Can you attach a complete dmesg log to the bugzilla?

This commit is queued for v6.13, and the merge window is now open, so
if it's a regression, we need to resolve it or drop it ASAP.

