Return-Path: <linux-pci+bounces-2910-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C65FC8451AC
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 07:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBE88B212C1
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 06:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF5F157E6B;
	Thu,  1 Feb 2024 06:56:39 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2D414C58D;
	Thu,  1 Feb 2024 06:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706770599; cv=none; b=U5sh6Sru9WEiTkzwZ3tRm7AwobddrlueON7F3MYO+COc/5wRAf8xmJ2A6zF5RbioGmcidrsuLI+RPGg18MUMvdNqCg9r9eMkqWb30avp1kky9YCg7alWCRYw23WWOdlaq7scczESrbWMjvfKLgWUyn2E8iY5ogyfxOIm2LjdzNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706770599; c=relaxed/simple;
	bh=0hGp61YtpizS4C5ByCdu2R4tN2l76xoOODrZGSJ7FHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yyc3Up3+nuNX453q//vNmM0OcAYoB4JQJVt50qc0uPrGl1K3tIlZ/k4QAbaMzpzji+dDkVt76Ml4rHmX4Q+zyjcZ8MrwYzuyy6gx2BrCLiIpxXvOWvtPq9r8LZPXfammghVhmLpm9nTzQAdrlNFScqLFFlXHSM2bHnPcH+O1eJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id CF282100DA1A1;
	Thu,  1 Feb 2024 07:50:40 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 9ED9A1E367; Thu,  1 Feb 2024 07:50:40 +0100 (CET)
Date: Thu, 1 Feb 2024 07:50:40 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: Re: [PATCH kernel 1/4] pci/doe: Define protocol types and make those
 public
Message-ID: <20240201065040.GA31925@wunner.de>
References: <20240201060228.3070928-1-aik@amd.com>
 <20240201060228.3070928-2-aik@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201060228.3070928-2-aik@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Feb 01, 2024 at 05:02:25PM +1100, Alexey Kardashevskiy wrote:
> Already public pci_doe() takes a protocol type argument.
> PCIe 6.0 defines three, define them in a header for use with pci_doe().
[...]
> --- a/include/linux/pci-doe.h
> +++ b/include/linux/pci-doe.h
> @@ -13,6 +13,10 @@
>  #ifndef LINUX_PCI_DOE_H
>  #define LINUX_PCI_DOE_H
>  
> +#define PCI_DOE_PROTOCOL_DISCOVERY		0
> +#define PCI_DOE_PROTOCOL_CMA_SPDM		1
> +#define PCI_DOE_PROTOCOL_SECURED_CMA_SPDM	2

These are deliberately defined in the .c files which actually need them,
i.e. DISCOVERY is defined in drivers/pci/doe.c and CMA_SPDM is defined in
drivers/pci/cma.c:

https://lore.kernel.org/all/7721bfa3b4f8a99a111f7808ad8890c3c13df56d.1695921657.git.lukas@wunner.de/

I don't see why they would have to be public if they're each only needed
in a single .c file.

Thanks,

Lukas

