Return-Path: <linux-pci+bounces-43722-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF48CDE5AB
	for <lists+linux-pci@lfdr.de>; Fri, 26 Dec 2025 06:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BD8E3001866
	for <lists+linux-pci@lfdr.de>; Fri, 26 Dec 2025 05:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447C019309C;
	Fri, 26 Dec 2025 05:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4ZPHDbGO"
X-Original-To: linux-pci@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8C1495E5;
	Fri, 26 Dec 2025 05:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766727697; cv=none; b=a3lkit3VWuQvNxtjrTwePb/j2IrkFK+IJTkx9RRKkjuJIXLQR7MOHZj0OzCOD4cZzS67UsH7WTlfnW0pJV5d91iBlcQi8vOO47dUns6bUecGF6t3O9T/bTxkdp04us8nnuPk/5ShpJIwZSoVMQOM+medp45J8kaAISJGinqmyQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766727697; c=relaxed/simple;
	bh=2z+x3t/FD2WOIYtni91vbULh99ahI2qeapcvOQ12JYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PnVdKE5MsA8iSnXacANSU/+cpsJdtJT5ApP3thoLf5E4dxTCsYsP4nEf4SVzT51Ux9La5obghujsUvbClcg5o6gaTFYcyTUhUZvAkGA3JFCzWhaO6JxywTx+EDfwPrzAS6XPEoxZYjpbpPti8uTRCmWFjrLcqhVZozOZiWiu0qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4ZPHDbGO; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=XXCHceZgI8fRZ1Vjy9oS+AldIjcdBPXKSupUrnUs79k=; b=4ZPHDbGOKZh72O5AWOIzhyJU9r
	mFiOmJ1sS0/Lh0+ov4TdX3ZqXxha6E4Ofa3d3+1StMMaAHSmX2JLgkgvji9PJxN5ABHA8Cf7ZA87s
	9csD9/NDfrvgdTrYAwb7k5DgbGes/yFnbrkYPT9MzxSnXXqy0IMHYTIbFIdrhREg0In9uaH1LAdJD
	x+gPj3onSzvhMbmFCA9imfX2icfwRGiIl+zBF0kAcpywiqtNq/k1lg7A3g39DRIxCNVzrAxGl1MMk
	WWlsAMYZUH2SXJCt66DMjLUzT+kc1BIdlxt2vFfkCLgfUvmAORVKsDXvmZKfSCu5yw1NFlIzwkEj1
	w5bpaarQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZ0Zu-00000000vgk-3Ice;
	Fri, 26 Dec 2025 05:41:30 +0000
Message-ID: <6cb6e393-7ca3-497d-b266-6a5e29501348@infradead.org>
Date: Thu, 25 Dec 2025 21:41:28 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: PCI: Fix typos in msi-howto.rst
To: Shawn Lin <shawn.lin@rock-chips.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-doc@vger.kernel.org
References: <1766713528-173281-1-git-send-email-shawn.lin@rock-chips.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <1766713528-173281-1-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/25/25 5:45 PM, Shawn Lin wrote:
> Fix subjject-verb agreement for "has a requirements" as well as
> "neither...or" conjunction mistake. And convert "Message Signalled
> Interrupts" to "Message Signaled Interrupts" to match the PCIe spec.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

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
>  

-- 
~Randy

