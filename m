Return-Path: <linux-pci+bounces-17976-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E95F19EA470
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 02:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B137316431E
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 01:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7206970808;
	Tue, 10 Dec 2024 01:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="PuD0xhXq"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F02E487B0;
	Tue, 10 Dec 2024 01:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733794743; cv=none; b=OD1Tnk1VZKIRf8fOxEpAIddU0FLKS3CfIFE9BFmy6skh9ed6b5HQVHQ5WxQQVKMDtizSqujyBIAJei0WCzJHmP1McbDcgC5VXFP9nn4CGXBFxtm3Vbi8qW2IQoPIoePQ7+T/8Hhey/hNHSpelnaj7EVqJfnsuLdWK694vwcZkS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733794743; c=relaxed/simple;
	bh=J97hBA7X2LqwNgYn+Bb902hRFy0wUF2meOyIkPm/1ko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dDR1CpnjP9Jrv/23wGx8Xz4LVwuDAvBmmZXi/hovbcMnGGp8uSNSLgbiP7rBJb+UDn3cNjl2UMeaY+W4WsStheo4hA+lSdL0w4kfDud01S/g/8UBvi4CgAaijtT7CQmRVyhGlK3B//MnuFQrZngYErhcS44TBmlWmONgiRhxnaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=PuD0xhXq; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733794737; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=BR2mdtTaoSEy+8fSRGvh/KqzQFMgidQP+WKmP5iDzus=;
	b=PuD0xhXq9ivKKc4pUr2ndWrNxxDcX6n3QzHN9laPB9PCFpwl3I5kCwYGpLpddaS8x88rq7CrFvPZLCU/n+SC+E4d8sbsg172b1zASaSQHC1akQeU2VmsmPp/yiISsM8RRl09BOYr77Ryg/gVb8axndmKtK5p73b/ehWKFLmB8kg=
Received: from 30.166.1.177(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WLCyrkm_1733794735 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 10 Dec 2024 09:38:56 +0800
Message-ID: <5139818d-8e1b-44ff-bfb4-18a1aca8afed@linux.alibaba.com>
Date: Tue, 10 Dec 2024 09:38:54 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 4/5] drivers/perf: add DesignWare PCIe PMU driver
To: Bjorn Helgaas <helgaas@kernel.org>, Will Deacon <will@kernel.org>
Cc: ilkka@os.amperecomputing.com, kaishen@linux.alibaba.com,
 yangyicong@huawei.com, Jonathan.Cameron@huawei.com,
 baolin.wang@linux.alibaba.com, robin.murphy@arm.com,
 chengyou@linux.alibaba.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 rdunlap@infradead.org, mark.rutland@arm.com, zhuo.song@linux.alibaba.com,
 renyu.zj@linux.alibaba.com
References: <20241209224741.GA3206765@bhelgaas>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20241209224741.GA3206765@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/12/10 06:47, Bjorn Helgaas 写道:
> On Mon, Dec 09, 2024 at 03:40:16PM +0000, Will Deacon wrote:
>> On Fri, Dec 06, 2024 at 10:54:57AM -0600, Bjorn Helgaas wrote:
>>> On Fri, Dec 08, 2023 at 10:56:51AM +0800, Shuai Xue wrote:
>>>> This commit adds the PCIe Performance Monitoring Unit (PMU) driver support
>>>> for T-Head Yitian SoC chip. Yitian is based on the Synopsys PCI Express
>>>> Core controller IP which provides statistics feature. The PMU is a PCIe
>>>> configuration space register block provided by each PCIe Root Port in a
>>>> Vendor-Specific Extended Capability named RAS D.E.S (Debug, Error
>>>> injection, and Statistics).
>>>
>>>> +#define DWC_PCIE_VSEC_RAS_DES_ID		0x02
>>>
>>>> +static const struct dwc_pcie_vendor_id dwc_pcie_vendor_ids[] = {
>>>> +	{.vendor_id = PCI_VENDOR_ID_ALIBABA },
>>>> +	{} /* terminator */
>>>> +};
>>>
>>>> +static bool dwc_pcie_match_des_cap(struct pci_dev *pdev)
>>>> +{
>>>> +	const struct dwc_pcie_vendor_id *vid;
>>>> +	u16 vsec;
>>>> +	u32 val;
>>>> +
>>>> +	if (!pci_is_pcie(pdev) || !(pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT))
>>>> +		return false;
>>>> +
>>>> +	for (vid = dwc_pcie_vendor_ids; vid->vendor_id; vid++) {
>>>> +		vsec = pci_find_vsec_capability(pdev, vid->vendor_id,
>>>> +						DWC_PCIE_VSEC_RAS_DES_ID);
>>>
>>> This looks wrong to me, and it promotes a misunderstanding of how VSEC
>>> Capabilities work.  The VSEC ID is defined by the vendor, so we have
>>> to check both the Vendor ID and the VSEC ID before we know what this
>>> VSEC Capability is.
>>
>> Thanks for pointing this out! The code's been merged for a while now,
>> so we'll need to fix what we have rather than revert it, I think.
> 
> Yep, for sure.
> 
>> Any chance you could send a patch with those, please? I'm also not able
>> to test this stuff, but I'm sure Ilkka would help us out.
> 
> Posted at https://lore.kernel.org/linux-pci/20241209222938.3219364-1-helgaas@kernel.org
> 
> Bjorn

Hi, Bjorn and Will,

Thanks for pointing this out and fix it so quickly, I will also test this patch
on our platform later.

Best Regards,
Shuai



