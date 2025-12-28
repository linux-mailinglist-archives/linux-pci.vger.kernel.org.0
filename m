Return-Path: <linux-pci+bounces-43772-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34610CE52C3
	for <lists+linux-pci@lfdr.de>; Sun, 28 Dec 2025 17:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 10F383004F1D
	for <lists+linux-pci@lfdr.de>; Sun, 28 Dec 2025 16:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E4319E97F;
	Sun, 28 Dec 2025 16:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rPBUqnoY"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A6278F26
	for <linux-pci@vger.kernel.org>; Sun, 28 Dec 2025 16:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766938867; cv=none; b=byWvDQFxVDYurl9zLGx79KU5LzfYQ33LPGd9tpKXU1yMvBrtkrecYObpXXSfrvgz+LrIyJI69h/Z6Lj1J9+zE/SkweHX8XgNzgALRRu7zRcz9vjbWkKO3w6Oi/7i87aAV1L6ihgyz0IK9SqOrbztg/KYMkfCVL3n4YjtChXi7HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766938867; c=relaxed/simple;
	bh=nDkhZCBPU6vnFUtxGGIdkLS6iGnGp6BXyrRZgQVwkcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cmNgM+fXARxVJwFmfZWWOKMRynLaS21fZPqZWaWRt+I8V4Kj+y9Ib/VmYE2QnCz0v4jYBO3ZtY8AEkkljHCt5mjX0Aa972nis+P//WrIgzbZ/LRjNdxjAFoB1DdkDg2Z/F7H3JwtDyVM0mlfy+EMAs3Xul4Mx8zKppIOfD+NEio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rPBUqnoY; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c67820d1-0199-4ee4-8f1b-7156040e5032@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766938862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tSAI4Q60fwh8YvEC8GqQbFP9yU0iNyxnCDJ2JwGti2k=;
	b=rPBUqnoYEpmDV8yVg8kIJAtQp2qrlILuzNRMs8EViF6lXRmd0+vRuSlvdY/axV75zEPH51
	9gjc77REEiNA5v3o2PfShzK7yqVcS2P8Y893TprsfODV1GOCVMIwoEs/jSx2Miu+IerF2M
	WuEEstopiwkTCPI8hNwkXIQXIt+g58w=
Date: Mon, 29 Dec 2025 00:20:51 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] Documentation: PCI: Fix typos in msi-howto.rst
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
References: <1766713528-173281-1-git-send-email-shawn.lin@rock-chips.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zenghui Yu <zenghui.yu@linux.dev>
In-Reply-To: <1766713528-173281-1-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2025/12/26 09:45, Shawn Lin wrote:
> Fix subjject-verb agreement for "has a requirements" as well as
> "neither...or" conjunction mistake. And convert "Message Signalled
> Interrupts" to "Message Signaled Interrupts" to match the PCIe spec.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
>  Documentation/PCI/msi-howto.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/PCI/msi-howto.rst b/Documentation/PCI/msi-howto.rst
> index 0692c9a..667ebe2 100644
> --- a/Documentation/PCI/msi-howto.rst
> +++ b/Documentation/PCI/msi-howto.rst
> @@ -98,7 +98,7 @@ function::
>  
>  which allocates up to max_vecs interrupt vectors for a PCI device.  It
>  returns the number of vectors allocated or a negative error.  If the device
> -has a requirements for a minimum number of vectors the driver can pass a
> +has a requirement for a minimum number of vectors the driver can pass a
>  min_vecs argument set to this limit, and the PCI core will return -ENOSPC
>  if it can't meet the minimum number of vectors.
>  
> @@ -127,7 +127,7 @@ not be able to allocate as many vectors for MSI as it could for MSI-X.  On
>  some platforms, MSI interrupts must all be targeted at the same set of CPUs
>  whereas MSI-X interrupts can all be targeted at different CPUs.
>  
> -If a device supports neither MSI-X or MSI it will fall back to a single
> +If a device supports neither MSI-X nor MSI it will fall back to a single
>  legacy IRQ vector.
>  
>  The typical usage of MSI or MSI-X interrupts is to allocate as many vectors
> @@ -203,7 +203,7 @@ How to tell whether MSI/MSI-X is enabled on a device
>  ----------------------------------------------------
>  
>  Using 'lspci -v' (as root) may show some devices with "MSI", "Message
> -Signalled Interrupts" or "MSI-X" capabilities.  Each of these capabilities
> +Signaled Interrupts" or "MSI-X" capabilities.  Each of these capabilities
>  has an 'Enable' flag which is followed with either "+" (enabled)
>  or "-" (disabled).

It was indeed reported as "Message Signalled Interrupts" and was later
changed to "MSI" in [1].  It has been 17 years since then.  Probably we
can just drop the outdated (and misspelled) words?

[1] https://github.com/pciutils/pciutils/commit/acbd2e055b65

Thanks,
Zenghui

