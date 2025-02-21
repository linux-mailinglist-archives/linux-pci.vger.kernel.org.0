Return-Path: <linux-pci+bounces-21967-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46917A3ECCC
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 07:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22C0C16C31F
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 06:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98ED61FBEBE;
	Fri, 21 Feb 2025 06:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EgU87aoO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4011D89E4;
	Fri, 21 Feb 2025 06:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740118971; cv=none; b=V5oxsHwkr4vNa62sUgYVvGNeQEeWPYbZa+mg98J+RCW1NrHHLk7QOzpMfZtrzyYruIJ2eiJtdlLGz73Nly7GBiW2pe9aTp7RFXPawgQ7MMwrkznPuw2y2QWfRuG856ZMomnWExasnTv5I7fpjyX1vd+Hd0xwNP3DOWpi9zoXGcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740118971; c=relaxed/simple;
	bh=OcphQuiU8TOis33FpWcJWtMOdsI54Ux3WhFuco7MjO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lxkfPyQyylz5yR7nYpyReKyomlD6eCxK2PX227axOcvufGTHwIgO5ctaRyEwZNFM0KPfspJ93EGxNdC2MnNS3xfd9JBAaGiiRmsGMy8HcsBzG/flyb7gZTZfqMTE3PhZMVSJcty8TRgAwk0tALizFFGAmdvuQFfawGX0iMq6gOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EgU87aoO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65A76C4CEE2;
	Fri, 21 Feb 2025 06:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740118970;
	bh=OcphQuiU8TOis33FpWcJWtMOdsI54Ux3WhFuco7MjO4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EgU87aoO4RUlseqtC9ZN5Ytgy8r6M5J5SHUcvjGCR30AGeR3mwArlMb+BtdII3/Cc
	 rLRwuexNRl66YWcEepD+bjN6gwdNzfjLV8Hh08aQF+N05rjDq0ylrVqYyfge6pJUPy
	 3/14nKwVo/m7mhkFlF4oQA/ULqCILyvUdfpeJ+XI=
Date: Fri, 21 Feb 2025 07:21:44 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Joshua Peraza <jperaza@google.com>
Cc: baolu.lu@linux.intel.com, bhelgaas@google.com, dtor@google.com,
	dwmw2@infradead.org, helgaas@kernel.org,
	iommu@lists.linux-foundation.org, jean-philippe@linaro.org,
	joro@8bytes.org, jsbarnes@google.com, lenb@kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, mika.westerberg@linux.intel.com,
	oohall@gmail.com, pavel@denx.de, rafael.j.wysocki@intel.com,
	rafael@kernel.org, rajatja@google.com, rajatxjain@gmail.com,
	will@kernel.org
Subject: Re: [v9 PATCH 1/2] PCI/ACPI: Support Microsoft's "DmaProperty"
Message-ID: <2025022136-demanding-affluent-c72a@gregkh>
References: <20250221000943.973221-1-jperaza@google.com>
 <20250221000943.973221-2-jperaza@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221000943.973221-2-jperaza@google.com>

On Fri, Feb 21, 2025 at 12:09:40AM +0000, Joshua Peraza wrote:
> From: Rajat Jain <rajatja@google.com>
> 
> The "DmaProperty" is supported and currently documented and used by
> Microsoft [link 1 below], to flag internal PCIe root ports that need
> DMA protection [link 2 below]. We have discussed with them and reached
> a common understanding that they shall change their MSDN documentation
> to say that the same property can be used to protect any PCI device,
> and not just internal PCIe root ports (since there is no point
> introducing yet another property for arbitrary PCI devices). This helps
> with security from internal devices that offer an attack surface for
> DMA attacks (e.g. internal network devices).
> 
> Support DmaProperty to mark DMA from a PCI device as untrusted.
> 
> Link: [1] https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-internal-pcie-ports-accessible-to-users-and-requiring-dma-protection
> Link: [2] https://docs.microsoft.com/en-us/windows/security/information-protection/kernel-dma-protection-for-thunderbolt
> Signed-off-by: Rajat Jain <rajatja@google.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Joshua Peraza <jperaza@google.com>
> ---
>  drivers/acpi/property.c |  3 +++
>  drivers/pci/pci-acpi.c  | 22 ++++++++++++++++++++++
>  2 files changed, 25 insertions(+)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

