Return-Path: <linux-pci+bounces-32502-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48059B09C45
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 09:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC400188EF0D
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 07:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879A52135CE;
	Fri, 18 Jul 2025 07:21:43 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC871E521B;
	Fri, 18 Jul 2025 07:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752823303; cv=none; b=sxrEobLJs7c2CmBZMgtdy+N00syqknJUQ6exzO9e80XLA77VMM0Q+0nhEdaq9XWGsZ+Onl26a13tav5uEdF1whwjfr7Bh+dYfDItgc9G1LOnkbd5oJr48CorlpqKmjDJ7EHkbsixIVKmp4JJFBz0Oe0M9Ywu+D5SuHG/Q2hlVbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752823303; c=relaxed/simple;
	bh=os2mYW4ZPebelMq9D5WoXK1DBewyC+h8nr44Az7zjRY=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=umsgyVZpCyRgEwUw23J30FLC78H9frolcqXDgFoQm7yhFhNnoRJvncXFQQ9GsO7h+NC59BaLVpKDHTRFojcG3vOf6pbo0XVCdEpDs9vQLqYEwzrNTThlqibzcJwKCIvat1OQmrTsVgTZ3o5BTQn7pBBjFTqf6f5D9qslgtXVDDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bk1P21S2gzvZ7F;
	Fri, 18 Jul 2025 15:18:46 +0800 (CST)
Received: from kwepemk500010.china.huawei.com (unknown [7.202.194.95])
	by mail.maildlp.com (Postfix) with ESMTPS id 8DA37147B5E;
	Fri, 18 Jul 2025 15:21:36 +0800 (CST)
Received: from [10.67.120.153] (10.67.120.153) by
 kwepemk500010.china.huawei.com (7.202.194.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 18 Jul 2025 15:21:36 +0800
Subject: Re: [PATCH] PCI: Add device-specific reset for Kunpeng virtual
 functions
To: Bjorn Helgaas <helgaas@kernel.org>
References: <20250714191903.GA2414617@bhelgaas>
CC: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <liulongfang@huawei.com>, Hui Wang
	<hui.wang@canonical.com>
From: Weili Qian <qianweili@huawei.com>
Message-ID: <5ed27a49-a437-66b1-8835-c3335edde07c@huawei.com>
Date: Fri, 18 Jul 2025 15:21:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250714191903.GA2414617@bhelgaas>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk500010.china.huawei.com (7.202.194.95)



On 2025/7/15 3:19, Bjorn Helgaas wrote:
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
> 
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

A generic solution for this would be even better.

I tested the patch in [1], but it did not resolve the issue. According to the PCIe specification(e.g.,
Section 7.5.1 PCI-Compatible Configuration Registers), the Vendor ID and Device ID for VFs are 0xffff.
However, if VFs cannot respond using the RRS mechanism, the pci_dev_wait() function reads the PCI_VENDOR_ID
register and gets the value 0xffffffff. This value is considered an error on PCIe, causing pci_dev_wait()
to continuously poll the register until a timeout occurs.

Thanks,
Weili
> 
> [1] https://lore.kernel.org/linux-pci/20250611101442.387378-1-hui.wang@canonical.com/
> 
>> Fixes: d591f6804e7e ("PCI: Wait for device readiness with Configuration RRS")
>> Signed-off-by: Weili Qian <qianweili@huawei.com>
>> ---
>>  drivers/pci/quirks.c | 36 ++++++++++++++++++++++++++++++++++++
>>  1 file changed, 36 insertions(+)
>>
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index d7f4ee634263..1df1756257d2 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -4205,6 +4205,36 @@ static int reset_hinic_vf_dev(struct pci_dev *pdev, bool probe)
>>  	return 0;
>>  }
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
>>  static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
>>  	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82599_SFP_VF,
>>  		 reset_intel_82599_sfp_virtfn },
>> @@ -4220,6 +4250,12 @@ static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
>>  		reset_chelsio_generic_dev },
>>  	{ PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HINIC_VF,
>>  		reset_hinic_vf_dev },
>> +	{ PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HUAWEI_ZIP_VF,
>> +		reset_kunpeng_acc_vf_dev },
>> +	{ PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HUAWEI_SEC_VF,
>> +		reset_kunpeng_acc_vf_dev },
>> +	{ PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HUAWEI_HPRE_VF,
>> +		reset_kunpeng_acc_vf_dev },
>>  	{ 0 }
>>  };
>>  
>> -- 
>> 2.33.0
>>
> .
> 

