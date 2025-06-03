Return-Path: <linux-pci+bounces-28876-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A85ACCAE2
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 18:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 675183A6413
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 16:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8DE23BF83;
	Tue,  3 Jun 2025 16:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XKF4/4E6"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D4E72605;
	Tue,  3 Jun 2025 16:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748966485; cv=none; b=V25ChEo7DqA4m2a7dBYxyztxUaOa8z9V2pfdvyTsJMsZjS6K7T3ILg8vDYJ/KtXZGQVv4yvCvICr2w6kCL9UDyUYJFYa8hTEP2qWOImU8auURQVX6GqQTX3U88grV41tOMSfsIszK9RkzaKAbbjSpqPwXOupFLf9ljFqY6RSdOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748966485; c=relaxed/simple;
	bh=eQluU8LKzEIXN3yHXodEbU5NLp2cwpxQ74ZswsqZdcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PBwF3lhXepBMBHpMdod2kLiJplY0UfXSn22cKVUOAL/I+36dIefXxZTzDyoFQgw0N1dxDzo8S4kekFD6+kNb2TshHCUsINf+QZhoxm6NojUMjWQKSbAR32mijzJNCQaMvDxJmB4uvKHY7i/cEH098/gqdr3CeAzWi7mXyknEfew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XKF4/4E6; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=xyH2BBTR0Ia68sGPAmB4YaJN+cm3jJj8OVxhBoCA98E=;
	b=XKF4/4E6asmse1GknOBT+61PhGryH/RrDsOBo7gE0PXve3xm5QYAq+CaIk3Qeb
	Iw/cigurNX2kVN1PlbGXW0yzJip2+rpdRPygKgBxxGQCe2UVKsjw3jk3l1uFoa+Z
	MqoW7+JEtVg9kkizEV92yprNQkap0TKjK5sW2QFR8yL80=
Received: from [192.168.71.94] (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wCXyo4qHD9ofxMiFw--.9916S2;
	Wed, 04 Jun 2025 00:00:42 +0800 (CST)
Message-ID: <60425d94-a8df-4183-918a-52fca291dfd8@163.com>
Date: Wed, 4 Jun 2025 00:00:42 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 6/6] PCI: cadence: Use cdns_pcie_find_*capability to
 avoid hardcode.
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: lpieralisi@kernel.org, bhelgaas@google.com,
 manivannan.sadhasivam@linaro.org, kw@linux.com, cassel@kernel.org,
 robh@kernel.org, jingoohan1@gmail.com, linux-pci@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20250514161258.93844-1-18255117159@163.com>
 <20250514161258.93844-7-18255117159@163.com>
 <828b30f5-93f9-bcae-296b-0a9aadde9e4f@linux.intel.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <828b30f5-93f9-bcae-296b-0a9aadde9e4f@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCXyo4qHD9ofxMiFw--.9916S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3GrWrtFWDAryfAFW8XF1fWFg_yoW3AF4xpF
	Z8uF4SkF4kXrW7uFsFv3W5ZrnxtFnayry7Aw4Ik3WruF129F1UGFyI9FyYkFnIkrs7uF1x
	XrWUtFsI9FnxtrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UsTmDUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWx9ho2g-Ev7tFwAAsH



On 2025/6/3 17:49, Ilpo Järvinen wrote:
> On Thu, 15 May 2025, Hans Zhang wrote:
> 
>> The PCIe capability/extended capability offsets are not guaranteed to be
>> the same across all SoCs integrating the Cadence PCIe IP. Hence, use the
>> cdns_pcie_find_{ext}_capability() APIs for finding them.
> 
> A minor point perhaps, but IMO, controller drivers should use the core's
> capability search regardless of the offset being same or not. :-)

Dear Ilpo,

I agree. In the future code iterations, we are committed to finding 
better methods.

> 
>> This avoids hardcoding the offsets in the driver.
>>
>> Signed-off-by: Hans Zhang <18255117159@163.com>
>> ---
>> Changes since v8 ~ v11:
>> - None
>>
>> Changes since v7:
>> - Resolve compilation errors.
>>
>> Changes since v6:
>> https://lore.kernel.org/linux-pci/20250323164852.430546-4-18255117159@163.com/
>>
>> - The patch commit message were modified.
>>
>> Changes since v5:
>> https://lore.kernel.org/linux-pci/20250321163803.391056-4-18255117159@163.com
>>
>> - Kconfig add "select PCI_HOST_HELPERS"
>> ---
>>   .../pci/controller/cadence/pcie-cadence-ep.c  | 40 +++++++++++--------
>>   drivers/pci/controller/cadence/pcie-cadence.h |  5 ---
>>   2 files changed, 23 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
>> index 599ec4b1223e..5c4b2151d181 100644
>> --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
>> +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
>> @@ -19,12 +19,13 @@
>>   
>>   static u8 cdns_pcie_get_fn_from_vfn(struct cdns_pcie *pcie, u8 fn, u8 vfn)
>>   {
>> -	u32 cap = CDNS_PCIE_EP_FUNC_SRIOV_CAP_OFFSET;
>>   	u32 first_vf_offset, stride;
>> +	u16 cap;
>>   
>>   	if (vfn == 0)
>>   		return fn;
>>   
>> +	cap = cdns_pcie_find_ext_capability(pcie, PCI_EXT_CAP_ID_SRIOV);
>>   	first_vf_offset = cdns_pcie_ep_fn_readw(pcie, fn, cap + PCI_SRIOV_VF_OFFSET);
>>   	stride = cdns_pcie_ep_fn_readw(pcie, fn, cap +  PCI_SRIOV_VF_STRIDE);
>>   	fn = fn + first_vf_offset + ((vfn - 1) * stride);
>> @@ -36,10 +37,11 @@ static int cdns_pcie_ep_write_header(struct pci_epc *epc, u8 fn, u8 vfn,
>>   				     struct pci_epf_header *hdr)
>>   {
>>   	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
>> -	u32 cap = CDNS_PCIE_EP_FUNC_SRIOV_CAP_OFFSET;
>>   	struct cdns_pcie *pcie = &ep->pcie;
>>   	u32 reg;
>> +	u16 cap;
>>   
>> +	cap = cdns_pcie_find_ext_capability(pcie, PCI_EXT_CAP_ID_SRIOV);
>>   	if (vfn > 1) {
>>   		dev_err(&epc->dev, "Only Virtual Function #1 has deviceID\n");
>>   		return -EINVAL;
>> @@ -224,9 +226,10 @@ static int cdns_pcie_ep_set_msi(struct pci_epc *epc, u8 fn, u8 vfn, u8 mmc)
>>   {
>>   	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
>>   	struct cdns_pcie *pcie = &ep->pcie;
>> -	u32 cap = CDNS_PCIE_EP_FUNC_MSI_CAP_OFFSET;
>>   	u16 flags;
>> +	u8 cap;
>>   
>> +	cap = cdns_pcie_find_capability(pcie, PCI_CAP_ID_MSI);
>>   	fn = cdns_pcie_get_fn_from_vfn(pcie, fn, vfn);
>>   
>>   	/*
>> @@ -246,9 +249,10 @@ static int cdns_pcie_ep_get_msi(struct pci_epc *epc, u8 fn, u8 vfn)
>>   {
>>   	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
>>   	struct cdns_pcie *pcie = &ep->pcie;
>> -	u32 cap = CDNS_PCIE_EP_FUNC_MSI_CAP_OFFSET;
>>   	u16 flags, mme;
>> +	u8 cap;
>>   
>> +	cap = cdns_pcie_find_capability(pcie, PCI_CAP_ID_MSI);
>>   	fn = cdns_pcie_get_fn_from_vfn(pcie, fn, vfn);
>>   
>>   	/* Validate that the MSI feature is actually enabled. */
>> @@ -269,9 +273,10 @@ static int cdns_pcie_ep_get_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
>>   {
>>   	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
>>   	struct cdns_pcie *pcie = &ep->pcie;
>> -	u32 cap = CDNS_PCIE_EP_FUNC_MSIX_CAP_OFFSET;
>>   	u32 val, reg;
>> +	u8 cap;
>>   
>> +	cap = cdns_pcie_find_capability(pcie, PCI_CAP_ID_MSIX);
>>   	func_no = cdns_pcie_get_fn_from_vfn(pcie, func_no, vfunc_no);
>>   
>>   	reg = cap + PCI_MSIX_FLAGS;
>> @@ -290,9 +295,10 @@ static int cdns_pcie_ep_set_msix(struct pci_epc *epc, u8 fn, u8 vfn,
>>   {
>>   	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
>>   	struct cdns_pcie *pcie = &ep->pcie;
>> -	u32 cap = CDNS_PCIE_EP_FUNC_MSIX_CAP_OFFSET;
>>   	u32 val, reg;
>> +	u8 cap;
>>   
>> +	cap = cdns_pcie_find_capability(pcie, PCI_CAP_ID_MSIX);
>>   	fn = cdns_pcie_get_fn_from_vfn(pcie, fn, vfn);
>>   
>>   	reg = cap + PCI_MSIX_FLAGS;
>> @@ -378,11 +384,11 @@ static int cdns_pcie_ep_send_msi_irq(struct cdns_pcie_ep *ep, u8 fn, u8 vfn,
>>   				     u8 interrupt_num)
>>   {
>>   	struct cdns_pcie *pcie = &ep->pcie;
>> -	u32 cap = CDNS_PCIE_EP_FUNC_MSI_CAP_OFFSET;
>>   	u16 flags, mme, data, data_mask;
>> -	u8 msi_count;
>>   	u64 pci_addr, pci_addr_mask = 0xff;
>> +	u8 msi_count, cap;
>>   
>> +	cap = cdns_pcie_find_capability(pcie, PCI_CAP_ID_MSI);
>>   	fn = cdns_pcie_get_fn_from_vfn(pcie, fn, vfn);
>>   
>>   	/* Check whether the MSI feature has been enabled by the PCI host. */
>> @@ -430,14 +436,14 @@ static int cdns_pcie_ep_map_msi_irq(struct pci_epc *epc, u8 fn, u8 vfn,
>>   				    u32 *msi_addr_offset)
>>   {
>>   	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
>> -	u32 cap = CDNS_PCIE_EP_FUNC_MSI_CAP_OFFSET;
>>   	struct cdns_pcie *pcie = &ep->pcie;
>>   	u64 pci_addr, pci_addr_mask = 0xff;
>>   	u16 flags, mme, data, data_mask;
>> -	u8 msi_count;
>> +	u8 msi_count, cap;
>>   	int ret;
>>   	int i;
>>   
>> +	cap = cdns_pcie_find_capability(pcie, PCI_CAP_ID_MSI);
>>   	fn = cdns_pcie_get_fn_from_vfn(pcie, fn, vfn);
>>   
>>   	/* Check whether the MSI feature has been enabled by the PCI host. */
>> @@ -480,16 +486,16 @@ static int cdns_pcie_ep_map_msi_irq(struct pci_epc *epc, u8 fn, u8 vfn,
>>   static int cdns_pcie_ep_send_msix_irq(struct cdns_pcie_ep *ep, u8 fn, u8 vfn,
>>   				      u16 interrupt_num)
>>   {
>> -	u32 cap = CDNS_PCIE_EP_FUNC_MSIX_CAP_OFFSET;
>>   	u32 tbl_offset, msg_data, reg;
>>   	struct cdns_pcie *pcie = &ep->pcie;
>>   	struct pci_epf_msix_tbl *msix_tbl;
>>   	struct cdns_pcie_epf *epf;
>>   	u64 pci_addr_mask = 0xff;
>>   	u64 msg_addr;
>> +	u8 bir, cap;
>>   	u16 flags;
>> -	u8 bir;
>>   
>> +	cap = cdns_pcie_find_capability(pcie, PCI_CAP_ID_MSIX);
>>   	epf = &ep->epf[fn];
>>   	if (vfn > 0)
>>   		epf = &epf->epf[vfn - 1];
>> @@ -563,7 +569,9 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
>>   	int max_epfs = sizeof(epc->function_num_map) * 8;
>>   	int ret, epf, last_fn;
>>   	u32 reg, value;
>> +	u8 cap;
>>   
>> +	cap = cdns_pcie_find_capability(pcie, PCI_CAP_ID_EXP);
>>   	/*
>>   	 * BIT(0) is hardwired to 1, hence function 0 is always enabled
>>   	 * and can't be disabled anyway.
>> @@ -587,12 +595,10 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
>>   				continue;
>>   
>>   			value = cdns_pcie_ep_fn_readl(pcie, epf,
>> -					CDNS_PCIE_EP_FUNC_DEV_CAP_OFFSET +
>> -					PCI_EXP_DEVCAP);
>> +						      cap + PCI_EXP_DEVCAP);
>>   			value &= ~PCI_EXP_DEVCAP_FLR;
>> -			cdns_pcie_ep_fn_writel(pcie, epf,
>> -					CDNS_PCIE_EP_FUNC_DEV_CAP_OFFSET +
>> -					PCI_EXP_DEVCAP, value);
>> +			cdns_pcie_ep_fn_writel(pcie, epf, cap + PCI_EXP_DEVCAP,
>> +					       value);
>>   		}
>>   	}
>>   
>> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
>> index 0a4a8bfd3174..e7c108f6e0b2 100644
>> --- a/drivers/pci/controller/cadence/pcie-cadence.h
>> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
>> @@ -125,11 +125,6 @@
>>    */
>>   #define CDNS_PCIE_EP_FUNC_BASE(fn)	(((fn) << 12) & GENMASK(19, 12))
>>   
>> -#define CDNS_PCIE_EP_FUNC_MSI_CAP_OFFSET	0x90
>> -#define CDNS_PCIE_EP_FUNC_MSIX_CAP_OFFSET	0xb0
>> -#define CDNS_PCIE_EP_FUNC_DEV_CAP_OFFSET	0xc0
>> -#define CDNS_PCIE_EP_FUNC_SRIOV_CAP_OFFSET	0x200
>> -
>>   /*
>>    * Endpoint PF Registers
>>    */
>>
> 
> Nice to see these go away.
> 
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Thank you for your review.

Best regards,
Hans

> 


