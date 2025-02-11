Return-Path: <linux-pci+bounces-21173-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 172AFA3145A
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 19:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BDCC188605E
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 18:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBD9253B43;
	Tue, 11 Feb 2025 18:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikF/Nxh4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B7126157D;
	Tue, 11 Feb 2025 18:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739299677; cv=none; b=R4KIVYcOVGfuJY4J3smcQx1wF7CWvqIjt4wb9du2r+DYSmAPvu1BskW/3kMHmTkg/S4khSGA3x5xOaOi+CtZW6WFz1Umg02hANrCSR8wHQRVeuCAuDTVscnRDHjH/j095nHrLkBDAZ7zsKt/WUjNXGq0pKqHvlC27XqV8lkUink=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739299677; c=relaxed/simple;
	bh=3AGOatkqmVlymqNidMSHY0PR84IsNMySRHZshYcEDlo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ezRRN6Mlf/Eiip3bQZ4grqoDXa8NZuJ8m+XjYC+DVk0xHdBdBqnvVqhRG+fv0MR9Z83vUg5eEVjsk2xH1LyBXOzCVeen6y9s3qMVRyf/4wnKxgcaoJF8SD+12VfXbLeJa7s5yQs0H0p/NHkl51QF7Y+2zM7OOPr2rpN8X59Cn9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikF/Nxh4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCFA9C4CEDD;
	Tue, 11 Feb 2025 18:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739299676;
	bh=3AGOatkqmVlymqNidMSHY0PR84IsNMySRHZshYcEDlo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ikF/Nxh4gKXmMlRM+dKPG55okS+9fNOIRKMN4JXo42ink1DSAxKVAaLQU6dxeMbiY
	 eOiS8vEFFQ48OHN9fulW/gUJnztvY82UrYh3OWPSDzyLpjwjQqACcgzuPP2owAzOTU
	 J+EWmUXFyKF8yvd0YXzXcpN1rKdjRHvyXS3nDgWXgcCLByyRAQqcF1IA8UL/WH+bIz
	 auCBQayGVWTpQFi+CMjGodrUBLW0zNhSCa5EWbjZcloehn0sGujM44fHpKvB6RwAvl
	 IQuwGZaM0Jz1UK3UI7ZQa8i5uJt/2gXBGl7dfaaSRA8x0Oi6FFI8tInojOxDDpn2jj
	 7By98rr9j+JCQ==
Date: Tue, 11 Feb 2025 12:47:54 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, linux-pm@vger.kernel.org,
	regressions@leemhuis.info,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [bugzilla-daemon@kernel.org: [Bug 219765] New: Regression: VFIO
 NVIDIA GPU Passthrough Fails in Linux 6.13.0 (GPU Reset & Audio Controller
 Disappears)]
Message-ID: <20250211184754.GA51286@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210170715.GA8877@bhelgaas>

[+cc Ilpo, Jonathan]

On Mon, Feb 10, 2025 at 11:07:15AM -0600, Bjorn Helgaas wrote:
> #regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=219765
> 
> I don't see an obvious culprit between v6.12 and v6.13, suggested
> bisection if possible.
> 
> Workaround: boot with pcie_port_pm=off

Update: pcie_port_pm=off turned out *not* to be a workaround, possibly
a red herring due to configuration differences.

> Given the workaround, maybe it's worth trying a revert of this:
> 
>   dc421bb3c0db ("PCI: Enable runtime PM of the host bridge")

Reporter bisected to 665745f27487 ("PCI/bwctrl: Re-add BW notification
portdrv as PCIe BW controller").

Bisect log in bugzilla.  GPU passthrough works correctly after
reverting these commits:

  665745f27487 ("PCI/bwctrl: Re-add BW notification portdrv as PCIe BW controller")
  de9a6c8d5dbf ("PCI/bwctrl: Add pcie_set_target_speed() to set PCIe Link Speed")
  
> ----- Forwarded message from bugzilla-daemon@kernel.org -----
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=219765
> 
> Created attachment 307599
>   --> https://bugzilla.kernel.org/attachment.cgi?id=307599&action=edit
> dmesg logs for the kernel in which gpu passthrough works
> 
> After upgrading from Linux 6.12.10 to Linux 6.13.0, VFIO GPU passthrough fails
> for an NVIDIA GPU (AD107). The GPU is not passed through to the VM, and its
> audio device (01:00.1) disappears from Virt-Manager. This issue does not occur
> in Linux 6.12.10.
> 
> I have attached the logs.

