Return-Path: <linux-pci+bounces-44042-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E47CF4F66
	for <lists+linux-pci@lfdr.de>; Mon, 05 Jan 2026 18:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1EFB73009D77
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jan 2026 17:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2572233ADA1;
	Mon,  5 Jan 2026 17:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="rFg/6qqU"
X-Original-To: linux-pci@vger.kernel.org
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF6933A9E9;
	Mon,  5 Jan 2026 17:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767633575; cv=none; b=iuTPaLs+VDlRbx0bjwc5f321QDXlY9+kmBEpPM/aHboXJCCXyepJh7MY6RhDgVWXsNu47e7Frhn3AbeCiXMu1HKAeSDwjWVjFedFOdigJS7gI8gusszIsORHCF2hjqdNDXPZXbcRKxCIlROVP7hfon51BcxWgYHQ99Mt2cMBLpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767633575; c=relaxed/simple;
	bh=fZ2sAPLOyHq1FxADhZSS8Bg41rmW1I7xXUnD6YLxvm8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=AbMEBRVVne/EuBjTenHWtNXYt7vAWbyHJII6eQ6+72kusqumXp4rQ0KSVkW46UENJrGpZ1pI/81kzh8J1Il8dDYAUKAJGAzGkyv2Iox47EMqyRFOUATP88UPs8EFISVHFoYJVLkM0cQDc6j1dngw/vLq5IExi0NPKXoFFlhWdaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=rFg/6qqU; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=Esd1bEU1wPkAmA0IaQdjSvBElZOUGI5f7UFY62l5SlI=; b=rFg/6qqUeMSMhrWH2S2l0a8IAi
	4SViL3ihtfMXlqgopKedoKZ7WXXl5V3KPEjOcdlBgH2W5SZWQg4vR30Era5zMbMNqFx9jxwhAZi8J
	8a3204x3GVtmzIpsRLAAl6LJCed61hBTmn6+RIdeHgWDcvuNZuctx+lUNyEpXnZ3zyzhjlqbtwnkD
	UcbW5DcXUXCnM9qPRC+0lWw6NFkUMcFjky94igmeayLfpAF0mlrAbT6YWG6yLlgu55AEAwAJGDxUP
	dvHfczzFAxeHvmvlG2R/ND0szQRWaApnle7t6xrpcU5/6LluMGmTuR1T/UpHbyRjpchZc3Py+8AWO
	mwTEX7UQ==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1vcnc0-00000000kXe-2XQc;
	Mon, 05 Jan 2026 09:39:21 -0700
Message-ID: <a8fc3e98-336a-4448-9ce6-db962bde1a1a@deltatee.com>
Date: Mon, 5 Jan 2026 09:39:17 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Alex Williamson <alex@shazbot.org>,
 Ankit Agrawal <ankita@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bjorn Helgaas <helgaas@kernel.org>
References: <20260104-fix-p2p-kdoc-v1-1-6d181233f8bc@nvidia.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260104-fix-p2p-kdoc-v1-1-6d181233f8bc@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: leon@kernel.org, bhelgaas@google.com, jgg@ziepe.ca, alex@shazbot.org, ankita@nvidia.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, helgaas@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH] PCI/P2PDMA: Add missing struct p2pdma_provider
 documentation
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-01-04 05:51, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Two fields in struct p2pdma_provider were not documented, which resulted
> in the following kernel-doc warning:
> 
>   Warning: include/linux/pci-p2pdma.h:26 struct member 'owner' not described in 'p2pdma_provider'
>   Warning: include/linux/pci-p2pdma.h:26 struct member 'bus_offset' not described in 'p2pdma_provider'
> 
> Repro:
> 
>   $ scripts/kernel-doc -none include/linux/pci-p2pdma.h
> 
> Fixes: f58ef9d1d135 ("PCI/P2PDMA: Separate the mmap() support from the core logic")
> Reported-by: Bjorn Helgaas <helgaas@kernel.org>
> Closes: https://lore.kernel.org/all/20260102234033.GA246107@bhelgaas
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

LGTM

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

