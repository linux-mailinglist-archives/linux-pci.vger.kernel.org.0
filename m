Return-Path: <linux-pci+bounces-4978-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F66886607
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 06:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E088FB21875
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 05:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C198C09;
	Fri, 22 Mar 2024 05:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TIEp4OC4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6764D8BE8;
	Fri, 22 Mar 2024 05:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711085195; cv=none; b=YN3FZABNsdMEy2DVYn2Py28wwgkxkeef/CHpYvkPW2ETksDF4/VKMMorXBXmpUkOmvhLPuqCrPIb8syPujNzV50HKpea9uLLozRyxGqDEes6HCUkCzlas6aFPvofg6apruoLfUqOkkD59GQ04xxxm0LnZoNT/fB/lr5uz5OVOf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711085195; c=relaxed/simple;
	bh=XgCtEPtvhPQa/3nth0Qxvy5Epa05Z8v2RBpaIRqoZG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IDlOdoLb6GnN8EYrIOqbiurWxv7hwN6rQGJ5gUK+wAECzluOZdOKuEK8oTu+tIdma9NkgwUwox9oysqNW7sVxdFkp8CPQk9oksvAzmusXdI5sOm1+AXv0vXt6JjWLjkUJbFFhKos8XWugJW3P4tJn8Kkq26zbENUXFpQ+QSf3Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TIEp4OC4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34359C433C7;
	Fri, 22 Mar 2024 05:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711085194;
	bh=XgCtEPtvhPQa/3nth0Qxvy5Epa05Z8v2RBpaIRqoZG8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TIEp4OC4M5z6mpOgUpGNDFoS4Mbvk9BN481N0dArh6BKJmd7vlxuXBx5Q6Q8IyJGs
	 lDPEtOFoffPaqHZxFeEwVpJrt36jbDNwTe/23chI9C0zXZEW7wp6fRhEOrXEqiniAS
	 N8NxYQTfsiQJ20/sX7z4RJX0TfY+iE2T4fCglfRYVG2iwi7nfR5YBzxG7w/2cU6ymK
	 /oXrFjczaZSAhR1+i4X7gABGsBUnRiGJRO4YAZpeLGid5Z2zeE8O1jIYmY30FiEANX
	 5oVNASbOrFuRZKyEKpmLoYfuWUi7GntlZNYMYCzRD2mgrYW9a3qqe8DoJMtViUbIq9
	 YSk+Xhs5xtSng==
Date: Fri, 22 Mar 2024 10:56:23 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	niklas.cassel@wdc.com, bhelgaas@google.com,
	gustavo.pimentel@synopsys.com, imx@lists.linux.dev,
	jdmason@kudzu.us, jingoohan1@gmail.com, kw@linux.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	lpieralisi@kernel.org, robh@kernel.org
Subject: Re: [PATCH v2 1/1] PCI: dwc: Fix index 0 incorrectly being
 interpreted as a free ATU slot
Message-ID: <20240322052623.GA4092@thinkpad>
References: <20240321171345.GA2385@thinkpad>
 <20240321180732.GA1329092@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240321180732.GA1329092@bhelgaas>

On Thu, Mar 21, 2024 at 01:07:32PM -0500, Bjorn Helgaas wrote:
> On Thu, Mar 21, 2024 at 10:43:45PM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Mar 04, 2024 at 05:46:16PM -0500, Frank Li wrote:
> > > dw_pcie_ep_inbound_atu()
> > > {
> > > 	...
> > > 	if (!ep->bar_to_atu[bar])
> > > 		free_win = find_first_zero_bit(ep->ib_window_map, pci->num_ib_windows);
> > > 	else
> > > 		free_win = ep->bar_to_atu[bar];
> > > 	...
> > > }
> > > 
> > > The atu index 0 is valid case for atu number. The find_first_zero_bit()
> > > will return 6 when second time call into this function if atu is 0. Suppose
> > > it should use branch 'free_win = ep->bar_to_atu[bar]'.
> > > 
> > > Change 'bar_to_atu' to free_win + 1. Initialize bar_to_atu as 0 to indicate
> > > it have not allocate atu to the bar.
> > 
> > I'd rewrite the commit message as below:
> > 
> > "The mapping between PCI BAR and iATU inbound window are maintained in the
> > dw_pcie_ep::bar_to_atu[] array. While allocating a new inbound iATU map for a
> > BAR, dw_pcie_ep_inbound_atu() API will first check for the availability of the
> > existing mapping in the array and if it is not found (i.e., value in the array
> > indexed by the BAR is found to be 0), then it will allocate a new map value
> > using find_first_zero_bit().
> > 
> > The issue here is, the existing logic failed to consider the fact that the map
> > value '0' is a valid value for BAR0. Because, find_first_zero_bit() will return
> > '0' as the map value for BAR0 (note that it returns the first zero bit
> > position).
> > 
> > Due to this, when PERST# assert + deassert happens on the PERST# supported
> > platforms, the inbound window allocation restarts from BAR0 and the existing
> > logic to find the BAR mapping will return '6' for BAR0 instead of '0' due to the
> > fact that it considers '0' as an invalid map value.
> > 
> > So fix this issue by always incrementing the map value before assigning to
> > bar_to_atu[] array and then decrementing it while fetching. This will make sure
> > that the map value '0' always represents the invalid mapping."
> 
> This translates C code to English in great detail, but still doesn't
> tell me what's broken from a user's point of view, how urgent the fix
> is, or how it should be handled.
> 
> DMA doesn't work because ATU setup is wrong?  Driver MMIO access to
> the device doesn't work?  OS crashes?  How?  Incorrectly routed access
> causes UR response?  Happens on every boot?  Only after a reboot or
> controller reset?  What platforms are affected?  "PERST# supported
> platforms" is not actionable without a lot of research or pre-existing
> knowledge.  Should this be backported to -stable?
> 

Severity is less for the bug fixed by this patch. We have 8 inbound iATU windows
on almost all of the platforms and after PERST# assert + deassert, BAR0 uses map
'6' instead of '0'.

This has no user visibility since the mapping will go fine and we have only 6
BARs. So I'd not mark this as as critical fix that needs special attention.

Frank: Please ammend the commit message with the bug impact.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

