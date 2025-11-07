Return-Path: <linux-pci+bounces-40545-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC07C3DFEA
	for <lists+linux-pci@lfdr.de>; Fri, 07 Nov 2025 01:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D54F3A7920
	for <lists+linux-pci@lfdr.de>; Fri,  7 Nov 2025 00:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B6C27F724;
	Fri,  7 Nov 2025 00:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="NggE5AVl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m3279.qiye.163.com (mail-m3279.qiye.163.com [220.197.32.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C4326E154
	for <linux-pci@vger.kernel.org>; Fri,  7 Nov 2025 00:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762475994; cv=none; b=uLz+6CK3BrFtalwRZuvKaI9m0gZ3MhWpaWDyHbmKWdegG3MVVaxRB4POpSa2lRRtjIfVL5FOXihbbH7ACGUVUevGItgwNIieg70HNaz4MEBX4QTGrPWUyut9XVSLaz/9HE3lM6SpNiIjv4pNokahGXglRI89KyBCvFn7ygx/pFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762475994; c=relaxed/simple;
	bh=78UR5NbxjK40KyOkhV5uol3aNV7pGnP8sbC3sWiaSBg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GE6iI/8wl1JB28nQjJ1VvZ7bKLqTT6sCYASkrVpPh9h3NwZPAXQg9zQL0hyVMkgkl8OJHkdFlDavjzGY3fVOYSF3yutn3t2DXXWmGLKfJHHd5py275ylsyNJXdo0LHekEymQwDCmz0cAJky42IDcxJUxFpfnRp9HWA0Q+Xtl1bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=NggE5AVl; arc=none smtp.client-ip=220.197.32.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.129] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 28b29a2a8;
	Fri, 7 Nov 2025 08:34:33 +0800 (GMT+08:00)
Message-ID: <9b83595d-ba79-404d-a7ff-ed07f524966f@rock-chips.com>
Date: Fri, 7 Nov 2025 08:34:29 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Manivannan Sadhasivam <mani@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-rockchip@lists.infradead.org,
 linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Add ASPM quirk for Hi1105 PCIe Wi-Fi
To: Bjorn Helgaas <helgaas@kernel.org>
References: <20251106195057.GA1965757@bhelgaas>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20251106195057.GA1965757@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a5bbc864409cckunmd4e8aafdf2fcd2
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGRgYHlYaH0hISkxCQkpPSkJWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=NggE5AVl8XhBnnmJyNK7Cwogs6U59gtofVbLUBzBUjMDJiBKFUTlDZjZNRTVGuZjbdb4Pvif5Eoz11ZMLU4Xw970pk90qce152zEM0A+YFe+hY+6DMxBFQPRlFjV4FkpRbsMqQwnd7sBTUbPFfcUIzaJqcVz59RNkfM76f9hsQc=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=Q79vdCYmG7hbeV1qHtnnEhd5iOqPqUirn2KQg3JO6u8=;
	h=date:mime-version:subject:message-id:from;

在 2025/11/07 星期五 3:50, Bjorn Helgaas 写道:
> On Thu, Nov 06, 2025 at 11:51:59AM +0800, Shawn Lin wrote:
>> This Wi-Fi advertises the L0s and L1 capabilities but actually
>> it doesn't support them. This's comfirmed by Hisilicon team in
>> actual productization.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> ---
>>
>>   drivers/pci/quirks.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index 214ed06..67250d4 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -2526,6 +2526,12 @@ static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
>>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm_l0s_l1);
>>   
>>   /*
>> + * The Hi1105 PCIe Wi-Fi doesn't support L0s and L1 but advertise the capability.
>> + * Disable both L0s and L1 for now.
>> + */
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0x1105, quirk_disable_aspm_l0s_l1);
> 
> PCI_VENDOR_ID_HUAWEI is 0x19e5.  Is there an upstream driver that
> matches [19e5:1105]?  I didn't find anything.

Yes, like plenty of other wireless drivers, Hi1105 driver is also out of
tree.

> 
> I think quirk_disable_aspm_l0s_l1() might be a problem because the new
> strategy is to enable ASPM early (in pcie_aspm_init_link_state(),
> called from pci_scan_slot(), which happens before FINAL fixups are run
> during pci_bus_add_device().
> 

Oh, I missed this.

> So I think we will enable L0s and L1 briefly before
> quirk_disable_aspm_l0s_l1() runs, and it's possible we'd see a problem
> then.
> 
> But if you apply this series:
>    https://lore.kernel.org/r/20251106183643.1963801-1-helgaas@kernel.org
> 
> and then the patch below on top, I think we should avoid enabling L0s
> and L1 at all:
> 

The patch below looks good to me. I will fix it.
Thanks.

> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 44e780718953..24c278857159 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -2536,6 +2536,7 @@ static void quirk_disable_aspm_l0s_l1_cap(struct pci_dev *dev)
>   	pci_info(dev, "ASPM: L0s L1 removed from Link Capabilities to work around device defect\n");
>   }
>   DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_FREESCALE, 0x0451, quirk_disable_aspm_l0s_l1_cap);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HUAWEI, 0x1105, quirk_disable_aspm_l0s_l1_cap);
>   
>   /*
>    * Some Pericom PCIe-to-PCI bridges in reverse mode need the PCIe Retrain
> 


