Return-Path: <linux-pci+bounces-14252-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF7A9999E6
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 04:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC1371F23FF8
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 02:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798322F44;
	Fri, 11 Oct 2024 02:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KMPQtqKX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5428B3E49E
	for <linux-pci@vger.kernel.org>; Fri, 11 Oct 2024 02:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728612073; cv=none; b=MrlF3KGJpgPMvWd0SAecPEPgvRKEs4eAn2ulqQSthq9DAz/kYG8m+uGvHE2MsIDxB45Vh0yHNtm7GLaOqE/anhRolWW0SyBBeOc3F9yCMG3Xy8lYCqokXnlrudxfabwUrp9QP4i0Ba2TZx45xcPrK6nVUwPwYHAHg+CLlBZ56nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728612073; c=relaxed/simple;
	bh=70QMixQFcpnh5kbZPF2thc406E/uGj9Csyv2B0Pysxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JPfs/U4fiNT1kuUOrSeAjvNXUrUKTSCmnHFNYpdAGHxcHebKH9Xhoh7FbKDZltQj61UytWP8eRkiTXendAWBarQapr3V0QszEap/MuUgYmP4uALtt6aNYyr4MOMxXu/nZnVLXkxB3inz+1LDVigguHDu+JfCQFA0RAzFYmiMcIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KMPQtqKX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D7A6C4CEC5;
	Fri, 11 Oct 2024 02:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728612072;
	bh=70QMixQFcpnh5kbZPF2thc406E/uGj9Csyv2B0Pysxk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KMPQtqKXxL+03Qoel3q6rNAZW6SVU9+2yrX8N4CgORO7Ayfzg2G/7Oi0/aaf8FVMw
	 cvYoCoRm+9umBaChdKnzvlQmVDsL9nYlsLSYy4fQt8FknQS/Z1DGunCgU2uAO2J0FA
	 QRBX13CCXjai4tR/z3Z0JzfMxHdYr2E7/Ya7uxj5r5d7aeupIBuSM4mEJuPGIp0ZOS
	 v4hdUwuOXEPrSjeQIEe2pymSDLkqGWDvJbc6BZo1dtEPAs8z0IK2LzDIOwnPRcTKEk
	 2pUVAcHYNZ4uPjGS4ag1evdR/sj1CIxSG/HLCh2zHMmaCr8HbjQWtGtdJBpXRoaRSb
	 1YMTAYAJfZThg==
Message-ID: <ee174108-66d5-4a4e-8051-d4a5889ecd10@kernel.org>
Date: Fri, 11 Oct 2024 11:01:09 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] PCI: endpoint: Introduce pci_epc_mem_map()/unmap()
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Jingoo Han <jingoohan1@gmail.com>,
 linux-pci@vger.kernel.org, Rick Wertenbroek <rick.wertenbroek@gmail.com>,
 Niklas Cassel <cassel@kernel.org>
References: <20241007040319.157412-1-dlemoal@kernel.org>
 <20241007040319.157412-5-dlemoal@kernel.org>
 <20241010164355.okuasill4hzsipun@thinkpad>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241010164355.okuasill4hzsipun@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/11/24 01:43, Manivannan Sadhasivam wrote:
> On Mon, Oct 07, 2024 at 01:03:16PM +0900, Damien Le Moal wrote:
>> Introduce the function pci_epc_mem_map() to facilitate controller memory
>> address allocation and mapping to a RC PCI address region in endpoint
>> function drivers.
>>
>> This function first uses pci_epc_map_align() to determine the controller
>> memory address size (and offset into) depending on the controller
>> address alignment constraints. The result of this function is used to
>> allocate a controller physical memory region using
>> pci_epc_mem_alloc_addr() and map that memory to the RC PCI address
>> space with pci_epc_map_addr().
>>
>> Since pci_epc_map_align() may indicate that the effective mapping
>> of a PCI address region is smaller than the user requested size,
>> pci_epc_mem_map() may only partially map the RC PCI address region
>> specified. It is the responsibility of the caller (an endpoint function
>> driver) to handle such smaller mapping.
>>
>> The counterpart of pci_epc_mem_map() to unmap and free the controller
>> memory address region is pci_epc_mem_unmap().
>>
>> Both functions operate using a struct pci_epc_map data structure
>> Endpoint function drivers can use struct pci_epc_map to access the
>> mapped RC PCI address region using the ->virt_addr and ->pci_size
>> fields.
>>
>> Co-developed-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
>> Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> 
> Looks good to me. Just one comment below.
> 
>> Reviewed-by: Niklas Cassel <cassel@kernel.org>
>> ---
>>  drivers/pci/endpoint/pci-epc-core.c | 78 +++++++++++++++++++++++++++++
>>  include/linux/pci-epc.h             |  4 ++
>>  2 files changed, 82 insertions(+)
>>
>> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
>> index 1adccf07c33e..d03c753d0a53 100644
>> --- a/drivers/pci/endpoint/pci-epc-core.c
>> +++ b/drivers/pci/endpoint/pci-epc-core.c
>> @@ -532,6 +532,84 @@ int pci_epc_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>>  }
>>  EXPORT_SYMBOL_GPL(pci_epc_map_addr);
>>  
>> +/**
>> + * pci_epc_mem_map() - allocate and map a PCI address to a CPU address
>> + * @epc: the EPC device on which the CPU address is to be allocated and mapped
>> + * @func_no: the physical endpoint function number in the EPC device
>> + * @vfunc_no: the virtual endpoint function number in the physical function
>> + * @pci_addr: PCI address to which the CPU address should be mapped
>> + * @pci_size: the number of bytes to map starting from @pci_addr
>> + * @map: where to return the mapping information
>> + *
>> + * Allocate a controller memory address region and map it to a RC PCI address
>> + * region, taking into account the controller physical address mapping
>> + * constraints using pci_epc_map_align().
>> + * The effective size of the PCI address range mapped from @pci_addr is
>> + * indicated by @map->pci_size. This size may be less than the requested
>> + * @pci_size. The local virtual CPU address for the mapping is indicated by
>> + * @map->virt_addr (@map->phys_addr indicates the physical address).
>> + * The size and CPU address of the controller memory allocated and mapped are
>> + * respectively indicated by @map->map_size and @map->virt_base (and
>> + * @map->phys_base).
>> + *
>> + * Returns 0 on success and a negative error code in case of error.
>> + */
>> +int pci_epc_mem_map(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>> +		    u64 pci_addr, size_t pci_size, struct pci_epc_map *map)
>> +{
>> +	int ret;
>> +
>> +	ret = pci_epc_map_align(epc, func_no, vfunc_no, pci_addr, pci_size, map);
> 
> I don't like the fact that one structure is passed to two functions and both
> modify some members. If you get rid of the pci_epc_map_align() API and just use
> the callback, then the arguments could be passed on their own without the 'map'
> struct.

That would be far too many arguments. The pci_epc functions already have many
(minimum of 3 for epc, func and vfunc). So I prefer trying to minimize that.

I removed clearing map->map_size in the unmap function. I had added that to make
that function a nop if it is called twice with for the same map. But given that
pci_epc_unmap_addr() and pci_epc_mem_free_addr() will do nothing for memory that
is not mapped/allocated, it is not super useful. Doing such double call would be
a bug in the endpoint function anyway.

-- 
Damien Le Moal
Western Digital Research

