Return-Path: <linux-pci+bounces-13816-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6A2990285
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 13:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59F461C21387
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 11:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98631EB2E;
	Fri,  4 Oct 2024 11:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mk3k5mJ7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58681D5AD8
	for <linux-pci@vger.kernel.org>; Fri,  4 Oct 2024 11:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728042681; cv=none; b=FFl6rYqA6ay5kW92bm743IcrtMmCaZgrF/b4cjXR6NLuacOSbB6y/4nb0qpaRG4d5Oc4WaxU+ufS8UrKBwVzlaEx3+A3eTsduNwn0a9n6MGA5AT2vUIruxggPEKjh4xrfV+WQoSgwQr6KeeMnYbhUzT0YMatmBYfht1jJjCeBXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728042681; c=relaxed/simple;
	bh=CP5MqPIvcu9bzzlFH67CwxK4h+3BAotuvDFextNv7YQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/0cUK13QtrAvT7fFtt/GlcIqhTl+mXeMJWhHiVYBialuuTjKjG2jp8dCezDDPzOmOBiARqpgK76RklCHN+zQGP4usZc5Iu7kp3hS1wAma668k3iWNGoy+0QgnChiVcbfcwPJpUen1Rx4QxcmQuruoi5V4SzlaojXBR16pmaeqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mk3k5mJ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C228AC4CEC6;
	Fri,  4 Oct 2024 11:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728042681;
	bh=CP5MqPIvcu9bzzlFH67CwxK4h+3BAotuvDFextNv7YQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mk3k5mJ7ScdYLKF5HrR5zwqkI6uYiMpP1+0GK3qfNAAdEBKlspaP0s2CwHYdXLmun
	 RftSYGgjVREpDpD/y19/x6ec1jQiGsHwL6CItt7sA1oyKmLv+gKH6rCuBaE994CR3k
	 fU7n1CSpkVJDXaTwNiBHDc2cIrDMLINr0MgfqnxuLZkcigglDDJA+xJKraUSwY6arp
	 J/NqOSUaihho01Iv4wnJV57NRCP7sP5F9y1wPW5LTZhxzrxAy+Em8SL4YmPVCHzubd
	 NN2szdgLwkZ/1w0vO2De2yfk3GMh5URgS6nYRnBbOPhas9H4jJkNmdbe85nqxeNNX6
	 97AOATeR7kktg==
Date: Fri, 4 Oct 2024 13:51:15 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>
Subject: Re: [PATCH v3 5/7] PCI: endpoint: Update documentation
Message-ID: <Zv_Ws1_eiM6ihTu_@ryzen.lan>
References: <20241004050742.140664-1-dlemoal@kernel.org>
 <20241004050742.140664-6-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004050742.140664-6-dlemoal@kernel.org>

On Fri, Oct 04, 2024 at 02:07:40PM +0900, Damien Le Moal wrote:
> Document the new functions pci_epc_map_align(), pci_epc_mem_map() and
> pci_epc_mem_unmap(). Also add the documentation for the functions
> pci_epc_map_addr() and pci_epc_unmap_addr() that were missing.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  Documentation/PCI/endpoint/pci-endpoint.rst | 33 +++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/Documentation/PCI/endpoint/pci-endpoint.rst b/Documentation/PCI/endpoint/pci-endpoint.rst
> index 21507e3cc238..80061110441d 100644
> --- a/Documentation/PCI/endpoint/pci-endpoint.rst
> +++ b/Documentation/PCI/endpoint/pci-endpoint.rst
> @@ -117,6 +117,39 @@ by the PCI endpoint function driver.
>     The PCI endpoint function driver should use pci_epc_mem_free_addr() to
>     free the memory space allocated using pci_epc_mem_alloc_addr().
>  
> +* pci_epc_map_align()
> +
> +   The PCI endpoint controller may impose constraints on the RC PCI addresses
> +   that can be mapped. The function pci_epc_map_align() allows endpoint drivers
> +   to discover and handle such constraint by providing the size of the memory

Nit: s/constraint/constraints/


> +   that must be allocated with pci_epc_mem_alloc_addr() for successfully mapping
> +   any RC PCI address. This function will also indicate the offset into the
> +   allocated memory to use for accessing the target RC PCI address.

Should probably also mention that it might map less memory than requested.


> +
> +* pci_epc_map_addr()
> +
> +  A PCI endpoint function driver should use pci_epc_map_addr() to map to a RC
> +  PCI address the CPU address of local memory obtained with
> +  pci_epc_mem_alloc_addr().
> +
> +* pci_epc_unmap_addr()
> +
> +  A PCI endpoint function driver should use pci_epc_unmap_addr() to unmap the
> +  CPU address of local memory mapped to a RC address with pci_epc_map_addr().
> +
> +* pci_epc_mem_map()
> +
> +  A PCI endpoint function driver can use pci_epc_mem_map() to allocate and map
> +  a RC PCI address range. This function combines calls to pci_epc_map_align(),
> +  pci_epc_mem_alloc_addr() and pci_epc_mem_alloc_addr() into a single function
> +  to simplify the PCI address mapping handling in endpoitn function drivers.

s/endpoitn/endpoint/


> +
> +* pci_epc_mem_unmap()
> +
> +  A PCI endpoint function driver can use pci_epc_mem_unmap() to unmap and free
> +  memory that was allocated and mapped using pci_epc_mem_map().
> +
> +
>  Other EPC APIs
>  ~~~~~~~~~~~~~~
>  
> -- 
> 2.46.2
> 

I think that it would make more sense if you squashed the doc updates for
each function into the respective commit that add the new function(s).

Sure, you would still need a commit that adds the documentation for the
functions that was missing, but that is expected.


Regardless:
Reviewed-by: Niklas Cassel <cassel@kernel.org>

