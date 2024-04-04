Return-Path: <linux-pci+bounces-5646-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFAEF897DD3
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 04:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0084B1C216F8
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 02:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128891C6B8;
	Thu,  4 Apr 2024 02:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzGdfQ5L"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC891CA9F;
	Thu,  4 Apr 2024 02:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712198668; cv=none; b=Sh2aQTQGd8HABMlthHP6oBe7qSa7zxY/2M2RvHlZB0Q+87BnVFPsRc8xOJF4dpLegsYMRwZqGgL1h8Pd7wuGVw8hXKkN9NSk4RHWmZa5d6UbH+GycCU16GES1Y7awDwh6B15oYZzQFHKVw8mSaN3eiyKy9KrB+a9C6RjZNqY2p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712198668; c=relaxed/simple;
	bh=tQ9ZqLh/ARmjH/CVuaNVKJd4tLa7dMh1i7FeCkgw9WQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SE+gTmEo8FX0gKRv7nJkSRJSHX1JC2FL2GrwmI9CEz/tyPDxE5JFyFjhPCXKd9Pbn7NxacE6aaXPnn20LP2IrL2VrgB3Zv0yi/BpLVfo2Hsl4kzheYlCZlRUC8Dw3lYoxtEn+i/55uPqzb5E9JRuayqFxugrcTtM06AsTjIFL48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzGdfQ5L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3E8DC433C7;
	Thu,  4 Apr 2024 02:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712198667;
	bh=tQ9ZqLh/ARmjH/CVuaNVKJd4tLa7dMh1i7FeCkgw9WQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KzGdfQ5Lux0oFduqAYUlB5pb2TRf/rZosmSC+e36HOOFmbAR/JEZQBAb45PvaURol
	 3JeE67YzjOxiB9gQntUvPhaQh57Totea4USOATFK2GsR3TmjUi1dIIZFHMLbXuzNTI
	 obpv/TF7o83OEMTnCZh/CNBSznSKUnm8ayh4CXBdlucLYDfWI2Zd3/2owpXLVS02Xf
	 VNKcEwzLP8Q850N5Py/QeGimPfCrVOjkntURgFYGM8W/vEr+porMzn0CmaIHBO06VA
	 88JUapavmqdPWUvpAKNqacj4pkOu1Iy0sB2H9Yo7HPZvxuycfcBldRew+6vX+Bhf+L
	 v9vH7co5OUZNQ==
Message-ID: <3a2aff21-4b1d-4f99-bd49-bf75f41cb924@kernel.org>
Date: Thu, 4 Apr 2024 11:43:47 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/18] PCI: endpoint: Introduce pci_epc_map_align()
To: Kishon Vijay Abraham I <kvijayab@amd.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Shawn Lin <shawn.lin@rock-chips.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kw@linux.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Rick Wertenbroek <rick.wertenbroek@gmail.com>,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>, Niklas Cassel <cassel@kernel.org>
References: <20240330041928.1555578-1-dlemoal@kernel.org>
 <20240330041928.1555578-3-dlemoal@kernel.org>
 <dccb87db-d826-43fa-a499-cf36ea9b10d5@amd.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <dccb87db-d826-43fa-a499-cf36ea9b10d5@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/3/24 21:33, Kishon Vijay Abraham I wrote:
> Hi Damien,
> 
> On 3/30/2024 9:49 AM, Damien Le Moal wrote:
>> Some endpoint controllers have requirements on the alignment of the
>> controller physical memory address that must be used to map a RC PCI
>> address region. For instance, the rockchip endpoint controller uses
>> at most the lower 20 bits of a physical memory address region as the
>> lower bits of an RC PCI address. For mapping a PCI address region of
>> size bytes starting from pci_addr, the exact number of address bits
>> used is the number of address bits changing in the address range
>> [pci_addr..pci_addr + size - 1].
>>
>> For this example, this creates the following constraints:
>> 1) The offset into the controller physical memory allocated for a
>>     mapping depends on the mapping size *and* the starting PCI address
>>     for the mapping.
>> 2) A mapping size cannot exceed the controller windows size (1MB) minus
>>     the offset needed into the allocated physical memory, which can end
>>     up being a smaller size than the desired mapping size.
>>
>> Handling these constraints independently of the controller being used in
>> a PCI EP function driver is not possible with the current EPC API as
>> it only provides the ->align field in struct pci_epc_features.
>> Furthermore, this alignment is static and does not depend on a mapping
>> pci address and size.
>>
>> Solve this by introducing the function pci_epc_map_align() and the
>> endpoint controller operation ->map_align to allow endpoint function
>> drivers to obtain the size and the offset into a controller address
>> region that must be used to map an RC PCI address region. The size
>> of the physical address region provided by pci_epc_map_align() can then
>> be used as the size argument for the function pci_epc_mem_alloc_addr().
>> The offset into the allocated controller memory can be used to
>> correctly handle data transfers. Of note is that pci_epc_map_align() may
>> indicate upon return a mapping size that is smaller (but not 0) than the
>> requested PCI address region size. For such case, an endpoint function
>> driver must handle data transfers in fragments.
>>
>> The controller operation ->map_align is optional: controllers that do
>> not have any address alignment constraints for mapping a RC PCI address
>> region do not need to implement this operation. For such controllers,
>> pci_epc_map_align() always returns the mapping size as equal
>> to the requested size and an offset equal to 0.
>>
>> The structure pci_epc_map is introduced to represent a mapping start PCI
>> address, size and the size and offset into the controller memory needed
>> for mapping the PCI address region.
>>
>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>> ---
>>   drivers/pci/endpoint/pci-epc-core.c | 66 +++++++++++++++++++++++++++++
>>   include/linux/pci-epc.h             | 33 +++++++++++++++
>>   2 files changed, 99 insertions(+)
>>
>> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
>> index 754afd115bbd..37758ca91d7f 100644
>> --- a/drivers/pci/endpoint/pci-epc-core.c
>> +++ b/drivers/pci/endpoint/pci-epc-core.c
>> @@ -433,6 +433,72 @@ void pci_epc_unmap_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>>   }
>>   EXPORT_SYMBOL_GPL(pci_epc_unmap_addr);
>>   
>> +/**
>> + * pci_epc_map_align() - Get the offset into and the size of a controller memory
>> + *			 address region needed to map a RC PCI address region
>> + * @epc: the EPC device on which address is allocated
>> + * @func_no: the physical endpoint function number in the EPC device
>> + * @vfunc_no: the virtual endpoint function number in the physical function
>> + * @pci_addr: PCI address to which the physical address should be mapped
>> + * @size: the size of the mapping starting from @pci_addr
>> + * @map: populate here the actual size and offset into the controller memory
>> + *       that must be allocated for the mapping
>> + *
>> + * Invoke the controller map_align operation to obtain the size and the offset
>> + * into a controller address region that must be allocated to map @size
>> + * bytes of the RC PCI address space starting from @pci_addr.
>> + *
>> + * The size of the mapping that can be handled by the controller is indicated
>> + * using the pci_size field of @map. This size may be smaller than the requested
>> + * @size. In such case, the function driver must handle the mapping using
>> + * several fragments. The offset into the controller memory for the effective
>> + * mapping of the @pci_addr..@pci_addr+@map->pci_size address range is indicated
>> + * using the map_ofst field of @map.
>> + */
>> +int pci_epc_map_align(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>> +		      u64 pci_addr, size_t size, struct pci_epc_map *map)
>> +{
>> +	const struct pci_epc_features *features;
>> +	size_t mask;
>> +	int ret;
>> +
>> +	if (!pci_epc_function_is_valid(epc, func_no, vfunc_no))
>> +		return -EINVAL;
>> +
>> +	if (!size || !map)
>> +		return -EINVAL;
>> +
>> +	memset(map, 0, sizeof(*map));
>> +	map->pci_addr = pci_addr;
>> +	map->pci_size = size;
>> +
>> +	if (epc->ops->map_align) {
>> +		mutex_lock(&epc->lock);
>> +		ret = epc->ops->map_align(epc, func_no, vfunc_no, map);
>> +		mutex_unlock(&epc->lock);
>> +		return ret;
>> +	}
>> +
>> +	/*
>> +	 * Assume a fixed alignment constraint as specified by the controller
>> +	 * features.
>> +	 */
>> +	features = pci_epc_get_features(epc, func_no, vfunc_no);
>> +	if (!features || !features->align) {
>> +		map->map_pci_addr = pci_addr;
>> +		map->map_size = size;
>> +		map->map_ofst = 0;
>> +	}
> 
> The 'align' of pci_epc_features was initially added only to address the 
> inbound ATU constraints. This is also added as comment in [1]. The PCI 
> address restrictions (only fixed alignment constraint) were handled by 
> the host side driver and depends on the connected endpoint device 
> (atleast it was like that for pci_endpoint_test.c [2]).
> So pci-epf-test.c used the 'align' in pci_epc_features only as part of 
> pci_epf_alloc_space().
> 
> Though I have abused 'align' of pci_epc_features in pci-epf-ntb.c using 
> it out of pci_epf_alloc_space(), I think we should keep the 'align' of 
> pci_epc_features only within pci_epf_alloc_space() and controllers with 
> any PCI address restrictions to implement ->map_align(). This could as 
> well be done in a phased manner to let controllers implement 
> ->map_align() and then remove using  pci_epc_features in 
> pci_epc_map_align(). Let me know what you think?

Yep, good idea. I will remove the use of "align" as a default alignment
constraint. For controllers that have a fixed alignment constraint (not
necessarilly epc->features->align), it is trivial to provide a generic helper
function that implements the ->map_align method.


-- 
Damien Le Moal
Western Digital Research


