Return-Path: <linux-pci+bounces-14622-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D03E9A03D4
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 10:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BFF2B21B56
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 08:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5DE1C4A2B;
	Wed, 16 Oct 2024 08:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nK4UbDBj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2B0187850;
	Wed, 16 Oct 2024 08:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729066369; cv=none; b=TuyFaG9042cC0r8AS04YmLC9ptpx9TXjzRSEckVYUwaNScgeLbP+qhXm5iOm8dXOxWdgH64FjI9b+VT4LHNV+CFlFhRY2TcCBj56wHvHsuHyBsHbVZIOSuu5werWDcRIEK8uLd35t8xmd6trpv6/V/qlUFVw3p8u5zLH2hI+noo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729066369; c=relaxed/simple;
	bh=Qdmh6k51UaEvIFsLmFyTr+186GXAMGMaOGtbFGw4cak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u5VzLvN8pP13/IntLCh2+CCY2U64F1MVc+NX+hzmg2/fFEpKZjkdXvvO9iFS+tJaegEGtaC5KyQAGH6yKZWWPUdBO8OG5t01GnA0qJhQ385E6FuzQHfPTKV8DRVtuNTkFrvZKrC5NVlrBCbsYq/iEQoh8jcOx9iJLD8weAvoLmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nK4UbDBj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 572E6C4CECE;
	Wed, 16 Oct 2024 08:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729066368;
	bh=Qdmh6k51UaEvIFsLmFyTr+186GXAMGMaOGtbFGw4cak=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nK4UbDBjh5Af56lFkoJ5QuA4MZoZVvPmz2sgzhEszcCTSTa1HfMHInGo5GGYq/XeJ
	 +fJRgCoEkF2oTiuFuNanqUsJdYSbt9VkcdG8n3C9o5i5hFgggCqsfCJnDCio0fFQJy
	 etUn8E5dFbFcn5wtL6uCVZmDLCVCBtd8pPRGpi3l6cvJnuf1VP6cDTJDwwS+9n69Hk
	 ekhA5uo8twJlRy8RJ8XQRuRoGCLRlN/pBRpFed0gcff+WOWi+wO14iTwYE50jj8fgt
	 vla958bnXcNsYTtHsXSIIv9y41lS1RXAwpfLZchGezwKGTGUngTXzOW4MIf+TRthRu
	 b37N718upUP1A==
Message-ID: <65ea27ce-0a0d-4324-945b-1d9fcaafd9e8@kernel.org>
Date: Wed, 16 Oct 2024 17:12:45 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Constify pci_register_io_range stub fwnode_handle
To: Arnd Bergmann <arnd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 "Rob Herring (Arm)" <robh@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Dan Williams <dan.j.williams@intel.com>,
 Dave Jiang <dave.jiang@intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Philipp Stanner <pstanner@redhat.com>, Johan Hovold
 <johan+linaro@kernel.org>, Reinette Chatre <reinette.chatre@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241016062410.2581152-1-arnd@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241016062410.2581152-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/16/24 3:24 PM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The patch to change the argument types for pci_register_io_range()
> only caught one of the two implementations, but missed the empty
> version:
> 
> drivers/of/address.c: In function 'of_pci_range_to_resource':
> drivers/of/address.c:244:45: error: passing argument 1 of 'pci_register_io_range' discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
>   244 |                 err = pci_register_io_range(&np->fwnode, range->cpu_addr,
>       |                                             ^~~~~~~~~~~
> In file included from drivers/of/address.c:12:
> include/linux/pci.h:1559:49: note: expected 'struct fwnode_handle *' but argument is of type 'const struct fwnode_handle *'
>  1559 | int pci_register_io_range(struct fwnode_handle *fwnode, phys_addr_t addr,
>       |                           ~~~~~~~~~~~~~~~~~~~~~~^~~~~~
> 
> Change this the same way.
> 
> Fixes: 6ad99a07e6d2 ("PCI: Constify pci_register_io_range() fwnode_handle")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Looks fine.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

