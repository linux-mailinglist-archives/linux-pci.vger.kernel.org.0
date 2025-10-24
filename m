Return-Path: <linux-pci+bounces-39237-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4F8C04455
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 05:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8AB1034FF52
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 03:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFD222333B;
	Fri, 24 Oct 2025 03:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="i/Gq1f83"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6AB35B130;
	Fri, 24 Oct 2025 03:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761277103; cv=none; b=Rwj85Pf2uh/Cl0zgyS03Ezn6iaJjOxI0+1PE4jKEtNh3vNBrazwMEJcUULrycT2iy3w333w2zDm9K1lgrE/R3WkzISp403wcGJU7nDzYD+PjHhigjQXgzTovqwBLsbL2bDvJqfGyRdH2OPsSFBg5uOKVmHRC4Gorh+H42yhagpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761277103; c=relaxed/simple;
	bh=uZ+3n5yBuhKuIqv5PzI7Y9LlJcM5gY9hS3dSPPam2MQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Luaan/jCfVrFN4aeYFtyg94cm14fVIcB7MIin6xM2Bq9P6vIwB2+70s0i0NzbgI0uyM0uZQetjpLc49Nir16h7OLTIHPRNXSfYaA6RE+V7rNGWkjWm7PnJs3+kLe2LJKehr5k0L4n8IUunbe7gEGX1gylrcBVS2/HOfoom7vxbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=i/Gq1f83; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761277092; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=PbKaT848m86AFJ7rPP/TZd4RMwVP1HqCrdS58KEB1IU=;
	b=i/Gq1f83zFRiNOLs8p+NQeFsN4VvdMoc29IgzMYuEdn/7mS8HcUSTyTpg4yLuJoKifHRBI3u3GPZ7Q1zwS908LwbuNT4oKtsQYmgXSxOGck4zcl2hN9qLUQwYx97arybJjKEtUYvo8HNsTJkVWIKDpsZZthqknQvN+UxyFQTnqA=
Received: from 30.246.161.241(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Wqsw-7-_1761277090 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 24 Oct 2025 11:38:11 +0800
Message-ID: <91cf33b4-7f67-4f3a-b095-e8f04d8c18e9@linux.alibaba.com>
Date: Fri, 24 Oct 2025 11:38:10 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] PCI/ERR: Use pcie_aer_is_native() to check for
 native AER control
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kbusch@kernel.org, sathyanarayanan.kuppuswamy@linux.intel.com,
 mahesh@linux.ibm.com, oohall@gmail.com, Jonathan.Cameron@huawei.com,
 terry.bowman@amd.com, tianruidong@linux.alibaba.com
References: <20251015024159.56414-1-xueshuai@linux.alibaba.com>
 <20251015024159.56414-5-xueshuai@linux.alibaba.com>
 <aPYMO2Eu5UyeEvNu@wunner.de>
 <0fe95dbe-a7ba-4882-bfff-0197828ee6ba@linux.alibaba.com>
 <aPZAAPEGBNk_ec36@wunner.de>
 <645adbb6-096f-4af3-9609-ddc5a6f5239a@linux.alibaba.com>
 <aPoDbKebJD30NjKG@wunner.de>
 <1eaf1f94-e26b-4313-b6b7-51ad966fe28e@linux.alibaba.com>
 <aPrvEZ3X4_tiD2Fh@wunner.de>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <aPrvEZ3X4_tiD2Fh@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/24 11:14, Lukas Wunner 写道:
> On Fri, Oct 24, 2025 at 11:09:25AM +0800, Shuai Xue wrote:
>> 2025/10/23 18:29, Lukas Wunner:
>>> On Mon, Oct 20, 2025 at 10:45:31PM +0800, Shuai Xue wrote:
>>>>  From PCIe spec, BIT 0-2 are logged for functions supporting Advanced
>>>> Error Handling.
>>>>
>>>> I am not sure if we should clear BIT 3, and also BIT 6 (Emergency Powerjj
>>>> Reduction Detected) and in case a AER error.
>>>
>>> AFAIUI, bits 0 to 3 are what the PCIe r7.0 sec 6.2.1 calls
>>> "baseline capability" error reporting.  They're supported
>>> even if AER is not supported.
>>>
>>> Bit 6 has nothing to do with this AFAICS.
>>
>> Per PCIe r7.0 section 7.5.3.5:
>>
>>    **For Functions supporting Advanced Error Handling**, errors are logged
>>    in this register regardless of the settings of the Uncorrectable Error
>>    Mask register. Default value of this bit is 0b.
>>
>>  From this, it's clear that bits 0 to 2 are not logged unless AER is supported.
> 
> No.  It just means that if AER is supported, the Uncorrectable Error Mask
> register has no bearing on whether the bits in the Device Status register
> are set.  It does not mean that the bits are only set if AER is supported.
> 

Thank you for pointing that out. I now understand that my interpretation
was incorrect.

As such, I will drop this patch that introduced the dev->aer_cap check.

The remaining question is whether it would make more sense to rename
pcie_clear_device_status() to pci_clear_device_error_status() and refine
its behavior by adding a mask specifically for bits 0 to 3. Here’s an
example of the proposed change:

-void pcie_clear_device_status(struct pci_dev *dev)
+void pci_clear_device_error_status(struct pci_dev *dev)
  {
         u16 sta;

         pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &sta);
-       pcie_capability_write_word(dev, PCI_EXP_DEVSTA, sta);
+       /* clear error-related bits: 0-3   */
+       pcie_capability_write_word(dev, PCI_EXP_DEVSTA, sta & 0xF);
  }

Renaming the function to pci_clear_device_error_status() better
reflects its current focus on clearing error-related bits, and
introducing the mask ensures that only those relevant bits (0-3) are
cleared, rather than modifying the entire register. What do you think
about these changes?

Thanks.
Shuai

