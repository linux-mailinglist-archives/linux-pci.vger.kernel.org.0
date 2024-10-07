Return-Path: <linux-pci+bounces-13931-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EFC9923B6
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 06:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2DE8B22165
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 04:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D90B2AD05;
	Mon,  7 Oct 2024 04:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G61u6UWC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D0C4204D
	for <linux-pci@vger.kernel.org>; Mon,  7 Oct 2024 04:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728276428; cv=none; b=gmn1YmUNcBVb6CZGQOGGFS5ikogEaSXmphUYsFvCXuSfVqIOzIbJmB42u3fX64hCtm1Nwbc3JB7Mv7rkR500+PVwAlnHmyl2eEpSnGhn3/OjdFrhcpQRQOa0A9X75Ms26Vf8IgdBRj0P67CcM71mRxCZeVVhB+UWBKgC5z85gZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728276428; c=relaxed/simple;
	bh=PGFu2zwINSyvb9bIpNV/4FXVY+cgPlkgi8npCXSx9ug=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=AA+6hSzh3VTdfK0RlyD9WRRwyYa24icC3GTmrRdQ1Hd0xBltlKs2al/e4Y+5fzuTNCpYTCO5YKi5x8O0jO/K2mhLmsYFb4L6WNz7PHXKzS8u9BY4SVtwTwimJjTX0+g5qcb/8bjTnq6Noe4+QLHE50xK6gaqT3wJehXvJkanbbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G61u6UWC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A03BAC4CEC6;
	Mon,  7 Oct 2024 04:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728276428;
	bh=PGFu2zwINSyvb9bIpNV/4FXVY+cgPlkgi8npCXSx9ug=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=G61u6UWCcvVSNp3jj8Dex9szoXfB3hklM41SzU4chyLwxOmzGa+KNeWWUTxWxM3MJ
	 S1B5tWoVU4skBR5GwU4D+mrnJahXwJbIatgBf+CT5C2MQvz1hTHDo3drk1p2XA+y93
	 dABWHQzJ5TxbtxdYjeCKzO+YmLvEsnX8gs7mN1lg9cwRlYbRD8KSmb0Aner97fbKNj
	 3Wqtgk9RXujZl5Tj/VlPOiUtRt1/FJjDWkqSmvi+cQxxvbdm4LtV0aj4JUIPI4Y5HU
	 xFXwF0DxwiFxBrnjLiMBK97HhEsUHuNbYhHfX6auO2Qrgz6DMJDttvytcbiBnfWszn
	 teCyjmlkc/PPg==
Message-ID: <c617bbdb-bd0a-46eb-b62c-9e3fa188a079@kernel.org>
Date: Mon, 7 Oct 2024 13:47:05 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] Improve PCI memory mapping API
From: Damien Le Moal <dlemoal@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Jingoo Han <jingoohan1@gmail.com>,
 linux-pci@vger.kernel.org
Cc: Rick Wertenbroek <rick.wertenbroek@gmail.com>,
 Niklas Cassel <cassel@kernel.org>
References: <20241007040319.157412-1-dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241007040319.157412-1-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/7/24 13:03, Damien Le Moal wrote:
> This series introduces the new functions pci_epc_map_align(),
> pci_epc_mem_map() and pci_epc_mem_unmap() to improve handling of the
> PCI address mapping alignment constraints of endpoint controllers in a
> controller independent manner.
> 
> The issue fixed is that the fixed alignment defined by the "align" field
> of struct pci_epc_features is defined for inbound ATU entries (e.g.
> BARs) and is a fixed value, whereas some controllers need a PCI address
> alignment that depends on the PCI address itself. For instance, the
> rk3399 SoC controller in endpoint mode uses the lower bits of the local
> endpoint memory address as the lower bits for the PCI addresses for data
> transfers. That is, when mapping local memory, one must take into
> account the number of bits of the RC PCI address that change from the
> start address of the mapping.
> 
> To fix this, the new endpoint controller method .map_align is introduced
> and called from pci_epc_map_align(). This method is optional and for
> controllers that do not define it, it is assumed that the controller has
> no PCI address constraint.
> 
> The functions pci_epc_mem_map() is a helper function which obtains
> mapping information, allocates endpoint controller memory according to
> the mapping size obtained and maps the memory. pci_epc_mem_unmap()
> unmaps and frees the endpoint memory.
> 
> This series is organized as follows:
>  - Patch 1 introduces a small helper to clean up the epc core code
>  - Patch 2 improves pci_epc_mem_alloc_addr()
>  - Patch 3 and 4 introduce the new map_align endpoint controller method
>    and the epc functions pci_epc_mem_map() and pci_epc_mem_unmap().
>  - Patch 5 documents these new functions.
>  - Patch 6 modifies the test endpoint function driver to use 
>    pci_epc_mem_map() and pci_epc_mem_unmap() to illustrate the use of
>    these functions.
>  - Finally, patch 7 implements the rk3588 endpoint controller driver
>    .map_align operation to satisfy that controller PCI address
>    alignment constraint.

I forgot to add that the series was extensively tested using the rk3588 endpoint
controller with the test endpoint function driver (as-is and modified to remove
the forced host buffer alignment) as well as using the NVMe endpoint function
driver (v1 patches just posted).

> 
> Changes from v3:
>  - Addressed Niklas comments (improved patch 2 commit message, added
>    comments in the pci_epc_map_align() function in patch 3, typos and
>    improvements in patch 5, patch 7 commit message).
>  - Added review tags
> 
> Changes from v2:
>  - Dropped all patches for the rockchip-ep. These patches will be sent
>    later as a separate series.
>  - Added patch 2 and 5
>  - Added review tags to patch 1
> 
> Changes from v1:
>  - Changed pci_epc_check_func() to pci_epc_function_is_valid() in patch
>    1.
>  - Removed patch "PCI: endpoint: Improve pci_epc_mem_alloc_addr()"
>    (former patch 2 of v1)
>  - Various typos cleanups all over. Also fixed some blank space
>    indentation.
>  - Added review tags
> 
> Damien Le Moal (7):
>   PCI: endpoint: Introduce pci_epc_function_is_valid()
>   PCI: endpoint: Improve pci_epc_mem_alloc_addr()
>   PCI: endpoint: Introduce pci_epc_map_align()
>   PCI: endpoint: Introduce pci_epc_mem_map()/unmap()
>   PCI: endpoint: Update documentation
>   PCI: endpoint: test: Use pci_epc_mem_map/unmap()
>   PCI: dwc: endpoint: Define the .map_align() controller operation
> 
>  Documentation/PCI/endpoint/pci-endpoint.rst   |  35 ++
>  .../pci/controller/dwc/pcie-designware-ep.c   |  15 +
>  drivers/pci/endpoint/functions/pci-epf-test.c | 372 +++++++++---------
>  drivers/pci/endpoint/pci-epc-core.c           | 223 ++++++++---
>  drivers/pci/endpoint/pci-epc-mem.c            |   9 +-
>  include/linux/pci-epc.h                       |  41 ++
>  6 files changed, 465 insertions(+), 230 deletions(-)
> 


-- 
Damien Le Moal
Western Digital Research

