Return-Path: <linux-pci+bounces-19409-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C77DEA04045
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 14:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDC5D160DBB
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 13:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9160433AD;
	Tue,  7 Jan 2025 13:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="TeUQt3Zh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B7F1E7668;
	Tue,  7 Jan 2025 13:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736255017; cv=none; b=DiJSD5LglWR4px7swFMmC6GtEPAHDIhNXkQrDATkxUzRk88/165t1HzZ4xmRc8RHVTHZunhbRV2GPyyICtUzfjhznf9iUbG1NYzCyVIPH2a+Te122kuGZ5ecXrkpi8Ugs/vPHOjmA0zdV4jlpdlrsfMEG+aa3Q3T3/T/CV3yGx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736255017; c=relaxed/simple;
	bh=VWmwSoNFyI2F0wcASkpdI1PKwOeMbWSJAPVy5V718dE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OdirSeHc5K8cg6NXZAsECiDg3sgTlLVmMvqRxusPIBFVZWijNk6NcRn0WnUmF/fWb3R2n4wtbXYLDwwDwTqJ+UE7Wwzk1C/gOpKt8943GfK2dMMEcL7Ele2yTZYvklGaZJxRufE6mUaxVKEkGwv7Oxp5vanFlcWV09kcHhuBdeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=TeUQt3Zh; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4YSB7R5x0Gz1FRm4;
	Tue,  7 Jan 2025 14:03:31 +0100 (CET)
Received: from [192.168.0.25] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4YSB7R49KXz1FXRv;
	Tue,  7 Jan 2025 14:03:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1736255011;
	bh=dNBJTG5z7ycU4q/mW03dhfretKGvrB/QspHtueUCtGE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=TeUQt3Zhh90Ko2HQoE6T9HPjP+PKQgb7jHHUuq4BOOMJCfWzZ8nrkZIsdRecP/k7x
	 g6t9rmGSJqOfVgKQv4j2si0qiGhnrIBYustJuKcHgyLWbBRlLK64z0xo3dZOYh5km5
	 20F5Gj20r0KpE9p4mqQc0kIm2zFqAW+uLXt/3Mjs=
Message-ID: <b1d7fb1e-171f-4bfc-a558-ae49274dd362@gaisler.com>
Date: Tue, 7 Jan 2025 14:03:29 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] sparc/PCI: Update reference to
 devm_of_pci_get_host_bridge_resources()
To: Bjorn Helgaas <helgaas@kernel.org>, Rob Herring <robh@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>
References: <20250103213129.5182-1-helgaas@kernel.org>
 <20250103213129.5182-4-helgaas@kernel.org>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20250103213129.5182-4-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-01-03 22:31, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> 5bd51b35c7cb ("PCI: Rework of_pci_get_host_bridge_resources() to
> devm_of_pci_get_host_bridge_resources()") converted and renamed
> of_pci_get_host_bridge_resources().  Update the comment reference to match.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  arch/sparc/kernel/pci_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/sparc/kernel/pci_common.c b/arch/sparc/kernel/pci_common.c
> index 5eeec9ad6845..2576f4f31309 100644
> --- a/arch/sparc/kernel/pci_common.c
> +++ b/arch/sparc/kernel/pci_common.c
> @@ -361,7 +361,7 @@ void pci_determine_mem_io_space(struct pci_pbm_info *pbm)
>  	int i, saw_mem, saw_io;
>  	int num_pbm_ranges;
>  
> -	/* Corresponding generic code in of_pci_get_host_bridge_resources() */
> +	/* Corresponds to generic devm_of_pci_get_host_bridge_resources() */
>  
>  	saw_mem = saw_io = 0;
>  	pbm_ranges = of_get_property(pbm->op->dev.of_node, "ranges", &i);
Acked-by: Andreas Larsson <andreas@gaisler.com>

Thanks,
Andreas


