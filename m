Return-Path: <linux-pci+bounces-16857-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 324F69CDC25
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 11:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9D362823BB
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 10:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99AB1B21A2;
	Fri, 15 Nov 2024 10:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kkkMeZeT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A091B2195;
	Fri, 15 Nov 2024 10:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731665276; cv=none; b=qZ5DIf4XGvufqDSF/XA2m17N1ZE+c+ayFF97LV5BrnVLjAO4IqlQgwguzp5d1BRqi6C7uQf6VKPvlxOStPdHgVFWFUQgeRgdbkkz2veC8iTLOvhWgZ1TANShdIeG0f89dlGh+/iQTzAwxzTIC4gMEzSj84vk1TnehqhARQBR/i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731665276; c=relaxed/simple;
	bh=lJKsGQI4xz6t71E2kqE8xiRIHAV3ZEdmgwiJINGlAs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q23GkiB+j7S2Z43L3x/aJaCTINqfyNl08EjIQB0NIA2BPUHLRDWvDfRLTK/RJs5hVYc/ALAE4Fxyy55eGIB3aqiXmxfu2QXsTo34KflNw/L4yhYIBXmLdVLLt4RaQ2vkJF+92jsF+8mpFDRLGDU1qKysfd3EWGVRsyqV3m/CU6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kkkMeZeT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C2AC4CECF;
	Fri, 15 Nov 2024 10:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731665276;
	bh=lJKsGQI4xz6t71E2kqE8xiRIHAV3ZEdmgwiJINGlAs4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kkkMeZeTYtDOa+VZqtvyzrO+OAnKC3+HJyYFpAyXD/KFjBTulyHAAtwX3hCoxgalE
	 WAEfGCSV5wNcJS47uOlu+ozlzuuJtfp21STz3StWQh0130Y/WkjKYHOYbB2nza2+rf
	 8yNfM0RzIwljjnMsN2DwyZ1XdZ890n0Oof1zxK+NiFymh+fhiMdf68FDNX+GVHxQtM
	 5u4gkRReKVXdFP71nCaJZsb0EUmrDkvfisPbws2fXuUyvJIwckCVfW79PxXXXWKh2t
	 hxBUpJaWTpQfuEfXDEeV5JiaAa3hTq4GGXRiJsusHQ20szylEkjM99eOJe0/h7u7C8
	 KvSWE3Tu7dY8A==
Date: Fri, 15 Nov 2024 11:07:50 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, dlemoal@kernel.org, maz@kernel.org,
	tglx@linutronix.de, jdmason@kudzu.us
Subject: Re: [PATCH v7 3/6] PCI: endpoint: Add pci_epf_align_addr() helper
 for address alignment
Message-ID: <ZzcdduDnQH6L1We6@ryzen>
References: <20241114-ep-msi-v7-0-d4ac7aafbd2c@nxp.com>
 <20241114-ep-msi-v7-3-d4ac7aafbd2c@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114-ep-msi-v7-3-d4ac7aafbd2c@nxp.com>

On Thu, Nov 14, 2024 at 05:52:39PM -0500, Frank Li wrote:
> Introduce the helper function pci_epf_align_addr() to adjust addresses
> according to PCI BAR alignment requirements, converting addresses into base
> and offset values.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> change from v6 to v7
> - new patch
> ---
>  drivers/pci/endpoint/pci-epf-core.c | 39 +++++++++++++++++++++++++++++++++++++
>  include/linux/pci-epf.h             | 13 +++++++++++++
>  2 files changed, 52 insertions(+)
> 
> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> index 8fa2797d4169a..a3f172cc786e9 100644
> --- a/drivers/pci/endpoint/pci-epf-core.c
> +++ b/drivers/pci/endpoint/pci-epf-core.c
> @@ -464,6 +464,45 @@ struct pci_epf *pci_epf_create(const char *name)
>  }
>  EXPORT_SYMBOL_GPL(pci_epf_create);
>  
> +/**
> + * pci_epf_align_addr() - Get base address and offset that match bar's
> + *			  alignment requirement
> + * @epf: the EPF device
> + * @addr: the address of the memory
> + * @bar: the BAR number corresponding to map addr
> + * @base: return base address, which match BAR's alignment requirement, nothing
> + *	  return if NULL
> + * @off: return offset, nothing return if NULL
> + *
> + * Helper function to convert input 'addr' to base and offset, which match
> + * BAR's alignment requirement.

Should we perhaps also mention that this function is not needed in the
"normal case" ? (i.e. pci_epf_alloc_space() + pci_epc_set_bar())


Kind regards,
Niklas

