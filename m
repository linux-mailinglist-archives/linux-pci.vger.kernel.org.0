Return-Path: <linux-pci+bounces-27895-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DF1ABA3BE
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 21:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AFAF1B60382
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 19:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5775226CE0;
	Fri, 16 May 2025 19:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M/O+MtAc"
X-Original-To: linux-pci@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D401CEAC2;
	Fri, 16 May 2025 19:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747423682; cv=none; b=Xbceu8Dho/R3qaO30NZTb5lb+ZW1YUGxT2atNRX6a+WhQ7KdyWhLxI/rc8yblvChYX/v+EjMCBV7cTbM64ivG0mQPquABQUI6RbGg3Gpi28UdQ6nesUnLaw9kV9j9jibdOo1UBAxdLGYs9eFlBqFzsyijT8H0iHX4ljfQRi49t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747423682; c=relaxed/simple;
	bh=8szMpAx4GbkKtdl9rIKAP5pwATyUKPg7MocRMWOyX2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b6cMBKM7WywAezfsV7heowe1pVA3/MFd7ThYL9bJAa8YtlCYrGtIA53qjr3mnQ92T9a3QwFyqGDpQLdntanuKo9gVLPp5RTXRCugoHdtSB3lLLKW9WQ49ugxNDFtiz2fBflQ/2/c5lEkditP808f9tO4N+uEWARvTnAEyvzsfgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=M/O+MtAc; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=JPS4NRNnkUopVfkxBsto11zOA6kziWl5Eya9/gk+PQ8=; b=M/O+MtAcr2hdJSi0CqruV2pI3U
	ESjAkCxesKcdcRnONIfqv4saA7YhsulDtqtJCGzc1AggQbn7kufDDubq0KLA6bJVmySAbjtb+o9ud
	BwE7JM35siEEOjJaGVzu/8YNcqBJXM93ZN4ypNCiU7mUUyoRuA/tSSLzHtpDDBCeugv604dvo6gJX
	tlC+jUPkUyMhEfTvjhvhM5izd4jFdX7Yd0GdxGMalqxSpL8+RYmQAouIX9b63ur/rpDsmxdlkGcr9
	ubLTZn8vrx4crehCA8vkMiL4LOjLakjxIsyIdcRqIdYLqAIBc+uPZP7qBOMgjCmwUsp//7DxSpP0k
	srxcmybw==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1uG0if-000000006g1-2DoZ;
	Fri, 16 May 2025 19:27:46 +0000
Message-ID: <393bdc27-a6a3-416c-93e9-d2a9ee9fb465@infradead.org>
Date: Fri, 16 May 2025 12:27:40 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] Documentation/driver-api: Update
 pcim_enable_device()
To: Philipp Stanner <phasta@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Bjorn Helgaas <bhelgaas@google.com>, Mark Brown <broonie@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Zijun Hu <quic_zijuhu@quicinc.com>, Yang Yingliang
 <yangyingliang@huawei.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20250516174141.42527-1-phasta@kernel.org>
 <20250516174141.42527-3-phasta@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250516174141.42527-3-phasta@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 5/16/25 10:41 AM, Philipp Stanner wrote:
> pcim_enable_device() is not related anymore to switching the mode of
> operation of any functions. It merely sets up a devres callback for
> automatically disabling the PCI device on driver detach.
> 
> Adjust the function's documentation.
> 
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> ---
>  Documentation/driver-api/driver-model/devres.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
> index d75728eb05f8..9443911c4742 100644
> --- a/Documentation/driver-api/driver-model/devres.rst
> +++ b/Documentation/driver-api/driver-model/devres.rst
> @@ -391,7 +391,7 @@ PCI
>    devm_pci_remap_cfgspace()	: ioremap PCI configuration space
>    devm_pci_remap_cfg_resource()	: ioremap PCI configuration space resource
>  
> -  pcim_enable_device()		: after success, some PCI ops become managed
> +  pcim_enable_device()		: after success, PCI dev gets deactivated automatically

I think that the patch description has a better comment that could be put here. ^^^^^

>    pcim_iomap()			: do iomap() on a single BAR
>    pcim_iomap_regions()		: do request_region() and iomap() on multiple BARs
>    pcim_iomap_table()		: array of mapped addresses indexed by BAR

-- 
~Randy


