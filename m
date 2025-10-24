Return-Path: <linux-pci+bounces-39231-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E856C04388
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 05:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D261E3514E1
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 03:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEDD25DAF0;
	Fri, 24 Oct 2025 03:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="p/f4y8xv"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E192F1A3160;
	Fri, 24 Oct 2025 03:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761275380; cv=none; b=OFGSAfJG0v/wDh6os38Md6o4Px5eNuyi5tXMLk4d71ATDBcYScL9iakqeh56kOv46fBCsbHV3SwHXV6+mxi8G2pklYyWsxF8flUVbgI7EooVoBwAHNrHLok7TL5oHZG3IcEBLIlBZqMyEoCuCBIRK5lMVSRwFh9vgoqkAfNbdRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761275380; c=relaxed/simple;
	bh=1qbpGAwOvZh5MHLgLvw2hkTTuBqG905rvavB2/9adlA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KPqBdJktYElVaPJ+8XMhzipNzWYvQe0vzkmW0mdcKPyoCsaQXppufXdtkOUh5ImSr8lzUsfMrX9JJWgJZhP75Ah9AeKsmoMBbE3YomAye5pCwUP1gCPsfdZyxg1iCcJxmi/LXmMSDouSYT5zjT8vkxcmm2GoPXVRMaNo6n7q06U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=p/f4y8xv; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761275367; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=pdaoYJ6/jp41uVjOn5ADQtwMyGMN5yCeVaz4/XBge20=;
	b=p/f4y8xvbZ5mYnBovZVlyAeQ+9rapGQxcKTQq5Duq4z6UC/NUNvyNHXb6jEmXFcfRupMax1zyGvjAie5kaOeSu4fgYoKlPRoceTnrGhVyUErrgCrjwGTw1wG7c5755jBe1E7jMD45Bqz8fttfXR0jJBeo5Lf7TYFp7CAXzCUhsA=
Received: from 30.246.161.241(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Wqskgl9_1761275365 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 24 Oct 2025 11:09:26 +0800
Message-ID: <1eaf1f94-e26b-4313-b6b7-51ad966fe28e@linux.alibaba.com>
Date: Fri, 24 Oct 2025 11:09:25 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] PCI/ERR: Use pcie_aer_is_native() to check for
 native AER control
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, kbusch@kernel.org,
 sathyanarayanan.kuppuswamy@linux.intel.com, mahesh@linux.ibm.com,
 oohall@gmail.com, Jonathan.Cameron@huawei.com, terry.bowman@amd.com,
 tianruidong@linux.alibaba.com
References: <20251015024159.56414-1-xueshuai@linux.alibaba.com>
 <20251015024159.56414-5-xueshuai@linux.alibaba.com>
 <aPYMO2Eu5UyeEvNu@wunner.de>
 <0fe95dbe-a7ba-4882-bfff-0197828ee6ba@linux.alibaba.com>
 <aPZAAPEGBNk_ec36@wunner.de>
 <645adbb6-096f-4af3-9609-ddc5a6f5239a@linux.alibaba.com>
 <aPoDbKebJD30NjKG@wunner.de>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <aPoDbKebJD30NjKG@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/23 18:29, Lukas Wunner 写道:
> On Mon, Oct 20, 2025 at 10:45:31PM +0800, Shuai Xue wrote:
>> 	if (host->native_aer || pcie_ports_native) {
>> 		pcie_clear_device_status(bridge);
>> 		pci_aer_clear_nonfatal_status(bridge);
>> 	}
>>
>> This code clears both the PCIe Device Status register and AER status
>> registers when in native AER mode.
>>
>> pcie_clear_device_status() is renamed from
>> pci_aer_clear_device_status(). Does it intends to clear only AER error
>> status?
>>
>> - BIT 0: Correctable Error Detected
>> - BIT 1: Non-Fatal Error Detected
>> - BIT 2: Fatal Error Detected
>> - BIT 3: Unsupported Request Detected
>>
>>  From PCIe spec, BIT 0-2 are logged for functions supporting Advanced
>> Error Handling.
>>
>> I am not sure if we should clear BIT 3, and also BIT 6 (Emergency Power
>> Reduction Detected) and in case a AER error.
> 
> AFAIUI, bits 0 to 3 are what the PCIe r7.0 sec 6.2.1 calls
> "baseline capability" error reporting.  They're supported
> even if AER is not supported.
> 
> Bit 6 has nothing to do with this AFAICS.

Hi, Lukas,

Per PCIe r7.0 section 7.5.3.5:

   **For Functions supporting Advanced Error Handling**, errors are logged
   in this register regardless of the settings of the Uncorrectable Error
   Mask register. Default value of this bit is 0b.

 From this, it's clear that bits 0 to 2 are not logged unless AER is supported.

So, if dev->aer_cap is not true, there’s no need to clear bits 0 to 2.
This validates the dev->aer_cap sanity check in pcie_aer_is_native():

   int pcie_aer_is_native(struct pci_dev *dev)
   {
       struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);

       if (!dev->aer_cap)
           return 0;

       return pcie_ports_native || host->native_aer;
   }
   EXPORT_SYMBOL_NS_GPL(pcie_aer_is_native, "CXL");

Based on this, the introduction of pcie_aer_is_native() in the patch
seems reasonable and consistent with the PCIe specification.

Further, should we rename pcie_clear_device_status() back to
pci_aer_clear_device_status():

-void pcie_clear_device_status(struct pci_dev *dev)
+void pci_aer_clear_device_status(struct pci_dev *dev)
  {
         u16 sta;

         pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &sta);
-       pcie_capability_write_word(dev, PCI_EXP_DEVSTA, sta);
+       /* Bits 0-2 are logged if AER is supported */
+       pcie_capability_write_word(dev, PCI_EXP_DEVSTA, sta & 0x7);
  }

I am still uncertain whether bit 3 ("Unsupported Request Detected")
should be cleared in this function. It’s not directly tied to AER
capability.


I’d love to hear your thoughts, as well as @Bjorn’s, on both the renaming
suggestion and whether bit 3 should be cleared alongside bits 0 to 2.

Thanks.
Shuai

