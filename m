Return-Path: <linux-pci+bounces-35393-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC1EB4263D
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 18:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E41271667A2
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 16:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1914A2BD013;
	Wed,  3 Sep 2025 16:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="YwFopzdn"
X-Original-To: linux-pci@vger.kernel.org
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A072BCF6A
	for <linux-pci@vger.kernel.org>; Wed,  3 Sep 2025 16:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756915723; cv=none; b=mxIIPwDgHqXrJLhVU8FR+X83epvl/fWEKxxb31BiARYJslnxOU0FMUo1yLfQJDf7uMttmDQsyEi9CAM4n+L00oONKzx+O/wUqxniHBanFW3/0xj04YkiFeMiF1MDh1wV61wuwDe5qXGblS0+fLCivP9uD3I5HrQMpBQZOFK8Tfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756915723; c=relaxed/simple;
	bh=awkF7dKZwj1rInUhM5TYfJVYvC91r3wssrGZNRHiQVw=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=HhYIGDnAs3r3Vh2Df5DaAs1LjfdgApl5UXsYQ+yzqLDW4QSOb9w9RYbL/jJOPx4U4bhXNex0Sn6YJrLxxFr5KBHRe/vKZzdh8Kfwn+YKNGtO2Zp7Oh61EDOw4bolIVLV955R5AVsiJWHKA2H5Tjy5aPLPl5KApdwEVCOZm9MqUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=YwFopzdn; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=BFLvhs+eiyuLL1I8N487xESWVCYSUAQZNAew51LgL1I=; b=YwFopzdnHSFjP2DJWebQRFJ4Wn
	Fdga8wHKbZnHet2ajGbNjobF4G6PBTIp9Ul2yumRPtz1p512xlJM3bwpWGgDsn583I4lWh1eZiJWV
	86LFSNEO7Z6L5VBI+TDbVre+s0Nfgsyxmac/I8uebBPA8iQn2td7vA1DN2L4Yv9aZtNSB8j7Onc4y
	wSx4XXJD+ezyKkawJyoDydalorYxhLI4cTDLL96aLqxpdGX3nJNc6puxjmPzdijEDh/rzcVMCC2+K
	NbeMid5PVDERLtkt8lDkStsmIQLHPo38+V0tD1v0+fpiGDHpXVIyRU6RQn7TtCaKBPEs36b0G6oa8
	A44v7fTQ==;
Received: from d172-219-145-75.abhsia.telus.net ([172.219.145.75] helo=[192.168.11.155])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <logang@deltatee.com>)
	id 1utq26-00CVaF-2u;
	Wed, 03 Sep 2025 10:08:27 -0600
Message-ID: <fe4dc929-2c7c-4164-917c-c9e3107e7387@deltatee.com>
Date: Wed, 3 Sep 2025 10:08:26 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Leon Romanovsky <leonro@nvidia.com>, linux-pci@vger.kernel.org
References: <d40f3f1decf54c9236bc38b48a6aae612a5c182f.1756900291.git.leon@kernel.org>
Content-Language: en-US
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <d40f3f1decf54c9236bc38b48a6aae612a5c182f.1756900291.git.leon@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.219.145.75
X-SA-Exim-Rcpt-To: leon@kernel.org, bhelgaas@google.com, leonro@nvidia.com, linux-pci@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH] PCI/P2PDMA: Reduce scope of pci_has_p2pmem function
X-SA-Exim-Version: 4.2.1 (built Wed, 06 Jul 2022 17:57:39 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2025-09-03 05:52, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> pci_has_p2pmem() function is not used outside of p2pdma.c and there is
> no need in EXPORT_SYMBOL_GPL for this function at all.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Makes sense to me, thanks.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>



