Return-Path: <linux-pci+bounces-16733-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA2C9C83F4
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 08:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C06BAB256FD
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 07:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B401EE037;
	Thu, 14 Nov 2024 07:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wyVFMNs9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17A415C14B;
	Thu, 14 Nov 2024 07:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731569238; cv=none; b=PItnuEayfzkukT/N8vKQmMRU/bJUYkHewLZAGXgqwTgK7wZ6rDC+Iyqozaezec1290w3NvtiuvrN7wi1wZD7fiUkvOTxroRwYkYmfrMZQ5VS/W8vTreFWJOu7AmTEd7PvgSWIYODgPy1ZSVpEOj+J+R1uClQIeQp2TK6lkx81nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731569238; c=relaxed/simple;
	bh=lLrYh6zWY0rI+VJ0Im+QzYqc0TqVGxFrhyHRj+UlvN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UXw9WMI8JezPSYGdFKONLWsD6JhHDS1okVCAWMJy1b/yFh5QlZtvuFMSxs7ZRlWlr5JU1lPz6YXiIFbPTpZpb/Er7qtPmUwCM8um1h4G/UTRoQ/PvO8fINXqyV0IC/tCSz1LtxhV7VHmo+Z/RGlUGXeobuj/9remZegVRnfVJJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wyVFMNs9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE635C4CECF;
	Thu, 14 Nov 2024 07:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731569237;
	bh=lLrYh6zWY0rI+VJ0Im+QzYqc0TqVGxFrhyHRj+UlvN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wyVFMNs9hAoSmgHreTZiTyJeiX3SRcl+IiXGE8f+E4NKFvbcnuIVJe5YoXSdgvXRg
	 Ft2AGXx/JXDmAbeQor/7FjQkky3VaI1PJSyQJHNS3rfNXB/LFI2PDTqBySh5j4anGT
	 da/f8LkW6xtELS81syPSUruAdV67RwStZwocOo1g=
Date: Thu, 14 Nov 2024 08:27:13 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Joshua Peraza <jperaza@google.com>
Cc: rajatja@google.com, baolu.lu@linux.intel.com, bhelgaas@google.com,
	dtor@google.com, dwmw2@infradead.org, helgaas@kernel.org,
	iommu@lists.linux-foundation.org, jean-philippe@linaro.org,
	joro@8bytes.org, jsbarnes@google.com, lenb@kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, mika.westerberg@linux.intel.com,
	oohall@gmail.com, pavel@denx.de, rafael.j.wysocki@intel.com,
	rafael@kernel.org, rajatxjain@gmail.com, will@kernel.org
Subject: Re: [PATCH 0/2] PCI/ACPI: Support Microsoft's "DmaProperty"
Message-ID: <2024111411-mating-granddad-11f6@gregkh>
References: <20220426172105.3663170-2-rajatja@google.com>
 <20241113202214.1421739-1-jperaza@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113202214.1421739-1-jperaza@google.com>

On Wed, Nov 13, 2024 at 08:22:12PM +0000, Joshua Peraza wrote:
> This patchset rebases two previously posted patches supporting
> recognition of Microsoft's DmaProperty.
> 
> Rajat Jain (2):
>   PCI/ACPI: Support Microsoft's "DmaProperty"
>   PCI: Rename pci_dev->untrusted to pci_dev->untrusted_dma

I thought we went through a lot of different choices when picking this
name, and explicitly did NOT use the "_dma" term here for a reason.  Can
you go and read those old patch submissions to verify why we did so, and
what has changed since then and then document here what has changed to
allow this name change now?

thanks,

greg k-h

