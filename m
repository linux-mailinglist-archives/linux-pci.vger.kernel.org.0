Return-Path: <linux-pci+bounces-32103-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1BCB04DB2
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 04:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5282E1AA1C69
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 02:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FF82C326A;
	Tue, 15 Jul 2025 02:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="NeX61Zft"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C1E18C008;
	Tue, 15 Jul 2025 02:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752545408; cv=none; b=jbzUOpGItPIYvs1vg67ugUVDaSX7MJNbVvi+CukIy+8GrOm4qPeUcJ3nsyw5zuimLERAGsBnYArPsBYgjvIqDo2FHFyDyCvhEjxxO6vYe4SCPoALvwfewoXq/4BQZSYmDQI6ydg/hJHAjZbsvTyV4xvcLjFHCEXSMXBWnfjD0kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752545408; c=relaxed/simple;
	bh=0D4blojolGMbx7+DLt1/BaCMUA0lJFoGL9iVnnKAnjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XjXTqpY4xLzUxWxIBsLfKvRufgf7WJUrelU+p9rT8Y2oxvwsfoFu4pbM8hcXOUI07pIV7/OiJeD24T/oRCm/ouMN2r/CM3Q8/bk+Q1d5pKCQ1fgH+iJ06aHsFJTyL1nZhyuuq68xKu7GO48xLPdHDjNXf5eSaOgwQ7eTHBcP7Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=NeX61Zft; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from [10.172.195.16] (1.general.hwang4.uk.vpn [10.172.195.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 19A9F3FABF;
	Tue, 15 Jul 2025 02:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1752545013;
	bh=UVnRhOuCXATS1qihIygfD+xlzP2qJkfG8Vyk2aqzNcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=NeX61Zft9eQsTi+GCko4eFOu84Cszdp81VAqscSiGHaS/LQxT+VdwTWma+gsgftEg
	 Ek7Iu6acM2ySidCp+LzJHVGuOz3OeRmKvIXx8t7HWL/CwpOcmvYPoK+/DsjVgVe5+h
	 tgAs8V3KFK0hcj7svMLA31j0ko9Zjci9JvJphtwc0B4iHba570R4Y3U+RjyOyLxK2p
	 cED1ziEHoue9qJkWv5osY7qa4w9DZIoXCh3iejFiPbQDga4+D7ysfxhqgLBERkHQFY
	 aYe+b1h5kttjnoWQpJYemt+zK0DTTdvjm7HH5BB55NsmwaoN/v8SGjhrx9afKnPZ8B
	 /jNFA/0nkPbxw==
Message-ID: <e9618cb6-8393-42e0-9f58-ca8824077188@canonical.com>
Date: Tue, 15 Jul 2025 10:03:21 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Add device-specific reset for Kunpeng virtual
 functions
To: Bjorn Helgaas <helgaas@kernel.org>, Weili Qian <qianweili@huawei.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, liulongfang@huawei.com
References: <20250714191903.GA2414617@bhelgaas>
Content-Language: en-US
From: Hui Wang <hui.wang@canonical.com>
In-Reply-To: <20250714191903.GA2414617@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 7/15/25 03:19, Bjorn Helgaas wrote:
> [+cc Hui]
>
> On Sat, Jul 12, 2025 at 07:30:28PM +0800, Weili Qian wrote:
>> Prior to commit d591f6804e7e ("PCI: Wait for device readiness with
>> Configuration RRS"), pci_dev_wait() polls PCI_COMMAND register until
>> its value is not ~0(i.e., PCI_ERROR_RESPONSE). After d591f6804e7e,
>> if the Configuration Request Retry Status Software Visibility (RRS SV)
>> is enabled, pci_dev_wait() polls PCI_VENDOR_ID register until its value
>> is not the reserved Vendor ID value 0x0001.
>>
>> On Kunpeng accelerator devices, RRS SV is enabled. However,
>> when the virtual function's FLR (Function Level Reset) is not
>> ready, the pci_dev_wait() reads the PCI_VENDOR_ID register and gets
>> the value 0xffff instead of 0x0001. It then incorrectly assumes this
>> is a valid Vendor ID and concludes the device is ready, returning
>> successfully. In reality, the function may not be fully ready, leading
>> to the device becoming unavailable.
>>
>> A 100ms wait period is already implemented before calling pci_dev_wait().
>> In most cases, FLR completes within 100ms. However, to eliminate the
>> risk of function being unavailable due to an incomplete FLR, a
>> device-specific reset is added. After pcie_flr(), the function continues
>> to poll PCI_COMMAND register until its value is no longer ~0.
> As far as I can tell, there's nothing specific to Kungpeng devices
> here.  We've seen a similar issue with Intel NVMe devices [1], and I
> don't want a whole mess of quirks and device-specific reset methods.
>
> We need some sort of generic solution for this.  My understanding was
> that if devices are not ready 100ms after a reset, they are required
> to respond with RRS.  Maybe these devices are defective.  Or maybe my
> understanding is incorrect.  Either way, I think we should at least
> check for a PCIe error before assuming that 0xffff is a valid
> response.
>
> [1] https://lore.kernel.org/linux-pci/20250611101442.387378-1-hui.wang@canonical.com/
And this quirk doesn't work in my case, in my case it is booting reset 
rather than FLR, so the "bool probe" is true and the pci_dev_wait() fails.
>
>> Fixes: d591f6804e7e ("PCI: Wait for device readiness with Configuration RRS")
>> Signed-off-by: Weili Qian <qianweili@huawei.com>
>> ---
>>   drivers/pci/quirks.c | 36 ++++++++++++++++++++++++++++++++++++
>>   1 file changed, 36 insertions(+)
>>
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index d7f4ee634263..1df1756257d2 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -4205,6 +4205,36 @@ static int reset_hinic_vf_dev(struct pci_dev *pdev, bool probe)
>>   	return 0;
>>   }
>>   
>> +#define KUNPENG_OPERATION_WAIT_CNT	3000
>> +#define KUNPENG_RESET_WAIT_TIME		20
>> +
>> +/* Device-specific reset method for Kunpeng accelerator virtual functions */
>> +static int reset_kunpeng_acc_vf_dev(struct pci_dev *pdev, bool probe)
>> +{
>> +	u32 wait_cnt = 0;
>> +	u32 cmd;
>> +
>> +	if (probe)
>> +		return 0;
>> +
>> +	pcie_flr(pdev);
>> +
>> +	do {
>> +		pci_read_config_dword(pdev, PCI_COMMAND, &cmd);
>> +		if (!PCI_POSSIBLE_ERROR(cmd))
>> +			break;
>> +
>> +		if (++wait_cnt > KUNPENG_OPERATION_WAIT_CNT) {
>> +			pci_warn(pdev, "wait for FLR ready timeout; giving up\n");
>> +			return -ENOTTY;
>> +		}
>> +
>> +		msleep(KUNPENG_RESET_WAIT_TIME);
>> +	} while (true);
>> +
>> +	return 0;
>> +}
>> +
>>   static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
>>   	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82599_SFP_VF,
>>   		 reset_intel_82599_sfp_virtfn },
>> @@ -4220,6 +4250,12 @@ static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
>>   		reset_chelsio_generic_dev },
>>   	{ PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HINIC_VF,
>>   		reset_hinic_vf_dev },
>> +	{ PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HUAWEI_ZIP_VF,
>> +		reset_kunpeng_acc_vf_dev },
>> +	{ PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HUAWEI_SEC_VF,
>> +		reset_kunpeng_acc_vf_dev },
>> +	{ PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HUAWEI_HPRE_VF,
>> +		reset_kunpeng_acc_vf_dev },
>>   	{ 0 }
>>   };
>>   
>> -- 
>> 2.33.0
>>

