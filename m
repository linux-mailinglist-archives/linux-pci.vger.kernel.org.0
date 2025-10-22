Return-Path: <linux-pci+bounces-38971-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E95EBBFB1EA
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 11:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 91C20508291
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 09:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE4527F00A;
	Wed, 22 Oct 2025 09:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="fhYFQRbH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m3280.qiye.163.com (mail-m3280.qiye.163.com [220.197.32.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2C81DD9AC
	for <linux-pci@vger.kernel.org>; Wed, 22 Oct 2025 09:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761124647; cv=none; b=jijI9A+fkpAihq+7l9f8uUnJLggP5KxbIsFsQ0NEtDgsVQWvlrYnoZTFYVJDRKjOWuXuiu+m/E0vT+Z9K2cNWkXI52mV2W3wy0hn2MwuaGKU00QT3VAXST7hz5Xecl/lruAkJGQOGPhTU7EK1/+eOn2K0ZyHOV2NfG2OFciIl0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761124647; c=relaxed/simple;
	bh=d6eo0999Latgt0nvXcHHC0e+StukJP7bCN/K0r21puU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=U+EJydszh7cP3adiFslZ7BN/DKJREKF90rKkgCxPk6c8C+qmDT+xqbnaSfhBwdyCCGGqKCAsMqg3zzWp9bJ8Ff6YkXjbwmoxRtq/LSnC5tn7AzQs/CpEUfhA4YOsU/HtuCx6M5Ko5uhsUBqP4vQPx5qDMRi5FpZJSxU9EqGHjmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=fhYFQRbH; arc=none smtp.client-ip=220.197.32.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.129] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 26c9fe1ae;
	Wed, 22 Oct 2025 17:17:13 +0800 (GMT+08:00)
Message-ID: <a09f6f91-0ef5-4d4a-a5c5-47f1be8c8d16@rock-chips.com>
Date: Wed, 22 Oct 2025 17:17:12 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Heiko Stuebner <heiko@sntech.de>,
 Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Thierry Reding <thierry.reding@gmail.com>,
 linux-rockchip@lists.infradead.org, Niklas Cassel <cassel@kernel.org>,
 linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/4] PCI: of: Add of_pci_clkreq_present()
To: Frank Li <Frank.li@nxp.com>
References: <1761032907-154829-1-git-send-email-shawn.lin@rock-chips.com>
 <1761032907-154829-2-git-send-email-shawn.lin@rock-chips.com>
 <aPex5YfxT+3dso2U@lizhi-Precision-Tower-5810>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <aPex5YfxT+3dso2U@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a0b354d2009cckunm1b9f0e6e7d6219
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGk0ZH1ZISUlPGEIfQ0oZTBhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpKQk
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=fhYFQRbHUxySyviOAobfM3APiSFTB/4MJE66kklQ93Lh9Od0H4nnTQDAs2ilRiL6gWazu7iALkA8E47kx1GhaLuOBpJre8QQjiJFhzpQSSrgvq7xuKQWGIE7JKTz03QY7evfQIr0AwUJAl86e3OLJuKW7QL0NAKknupJn1AT64s=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=loJRtAn9EJrDRUxd+4M8weJLoX8I792PVIqyUmM0rtI=;
	h=date:mime-version:subject:message-id:from;

在 2025/10/22 星期三 0:16, Frank Li 写道:
> On Tue, Oct 21, 2025 at 03:48:24PM +0800, Shawn Lin wrote:
>> of_pci_clkreq_present() is used by host drivers to decide whether the clkreq#
>> is properly connected and could enable L1.1/L1.2 support.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> ---
>>   drivers/pci/of.c  | 18 ++++++++++++++++++
>>   drivers/pci/pci.h |  6 ++++++
>>   2 files changed, 24 insertions(+)
>>
>> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
>> index 3579265f1198..52c6d365083b 100644
>> --- a/drivers/pci/of.c
>> +++ b/drivers/pci/of.c
>> @@ -1010,3 +1010,21 @@ int of_pci_get_equalization_presets(struct device *dev,
>>   	return 0;
>>   }
>>   EXPORT_SYMBOL_GPL(of_pci_get_equalization_presets);
>> +
>> +/**
>> + * of_pci_clkreq_present() - Check if the "supports-clkreq" is present
>> + * @np: Device tree node
>> + *
>> + * If the property is present, it means CLKREQ# is properly connected
>> + * and the hardware is ready to support L1.1/L1.2
>> + *
>> + * Return: true if the property is available, false otherwise.
>> + */
>> +bool of_pci_clkreq_present(struct device_node *np)
>> +{
>> +	if (!np)
>> +		return false;
>> +
>> +	return of_property_present(np, "supports-clkreq");
>> +}
>> +EXPORT_SYMBOL_GPL(of_pci_clkreq_present);
> 
> This helper function is quite small. I suggest direct put inline function
> into pci.h to keep simple.

Sounds reasonable, will wait for other comments and fix your comment
together in V2.

> 
> static inline bool of_pci_clkreq_present(struct device_node *np)
> {
> 	return np && of_property_present(np, "supports-clkreq");
> }
> 
> Frank
> 
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index 4492b809094b..2421e39e6e48 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -1061,6 +1061,7 @@ bool of_pci_supply_present(struct device_node *np);
>>   int of_pci_get_equalization_presets(struct device *dev,
>>   				    struct pci_eq_presets *presets,
>>   				    int num_lanes);
>> +bool of_pci_clkreq_present(struct device_node *np);
>>   #else
>>   static inline int
>>   of_get_pci_domain_nr(struct device_node *node)
>> @@ -1106,6 +1107,11 @@ static inline bool of_pci_supply_present(struct device_node *np)
>>   	return false;
>>   }
>>
>> +static inline bool of_pci_clkreq_present(struct device_node *np)
>> +{
>> +	return false;
>> +}
>> +
>>   static inline int of_pci_get_equalization_presets(struct device *dev,
>>   						  struct pci_eq_presets *presets,
>>   						  int num_lanes)
>> --
>> 2.43.0
>>
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
> 


