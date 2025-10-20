Return-Path: <linux-pci+bounces-38763-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49697BF1E76
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 16:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19E373B4BF3
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 14:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93794148832;
	Mon, 20 Oct 2025 14:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="BNcjBVgI"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA03435972;
	Mon, 20 Oct 2025 14:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760971545; cv=none; b=B8JrrNERvNIh27ryze1TSMVwJDWVJeLCyJnDYQD5Wiin06YgV5Npj/J3UQ9Kt983xlDFjObuwv9xM6DahJDeWKTTmfbNVMmIJeWwudq+85kK827+Q96NO4vF4SXVddRhDrHeXVMGWcuvwPfnAsa7wj9HiDshEjAceE15XJ6hnNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760971545; c=relaxed/simple;
	bh=thykIJJg2EpAUfe4ozCQkG52TcMWFQEs45g6JDhqjDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JwSymq5mHnHlCV3X+kckTYmtKUz3dZ4BcEwXTrmOAaJ3A3hWkqYKq932UDKNThPThjrHSBhA9DaOqgTziPqsyjH9g4ZSaRa85BxwWI3hLdMvEC08pnc75o3fAq+ckMXrYB/+HUutTQt1rzK1kJa5y9iS4yUxFA76TwDDWzHN5ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=BNcjBVgI; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760971537; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=hCe3ut/WXfuVO1xIbv9Xf6/wnz4HbVZxWnU0T5Zbwk4=;
	b=BNcjBVgI13hXxZ9jhQobrABlVAKGkM4ap1ctFSAuIRvYL3zHxCzLDYLSAVysTRYCA+FgJfbAYzyGIXZRl1v2j4JjdZY1bm+gU7BcnO9p2kv//nV/s6D96y7L44bBd1WB//ujBC6AU9Lz89j+hwKLwRFno5w7WIfCwGsTFxvnfcA=
Received: from 30.246.161.241(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WqdeIFD_1760971535 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 20 Oct 2025 22:45:36 +0800
Message-ID: <645adbb6-096f-4af3-9609-ddc5a6f5239a@linux.alibaba.com>
Date: Mon, 20 Oct 2025 22:45:31 +0800
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
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com, kbusch@kernel.org,
 sathyanarayanan.kuppuswamy@linux.intel.com, mahesh@linux.ibm.com,
 oohall@gmail.com, Jonathan.Cameron@huawei.com, terry.bowman@amd.com,
 tianruidong@linux.alibaba.com
References: <20251015024159.56414-1-xueshuai@linux.alibaba.com>
 <20251015024159.56414-5-xueshuai@linux.alibaba.com>
 <aPYMO2Eu5UyeEvNu@wunner.de>
 <0fe95dbe-a7ba-4882-bfff-0197828ee6ba@linux.alibaba.com>
 <aPZAAPEGBNk_ec36@wunner.de>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <aPZAAPEGBNk_ec36@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/20 21:58, Lukas Wunner 写道:
> On Mon, Oct 20, 2025 at 09:09:41PM +0800, Shuai Xue wrote:
>> ??? 2025/10/20 18:17, Lukas Wunner ??????:
>>> On Wed, Oct 15, 2025 at 10:41:58AM +0800, Shuai Xue wrote:
>>>> Replace the manual checks for native AER control with the
>>>> pcie_aer_is_native() helper, which provides a more robust way
>>>> to determine if we have native control of AER.
>>>
>>> Why is it more robust?
>>
>> IMHO, the pcie_aer_is_native() helper is more robust because it includes
>> additional safety checks that the manual approach lacks:
> [...]
>> Specifically, it performs a sanity check for dev->aer_cap before
>> evaluating native AER control.
> 
> I'm under the impression that aer_cap must be set, otherwise the
> error wouldn't have been reported and we wouldn't be in this code path?
> 
> If we can end up in this code path without aer_cap set, your patch
> would regress devices which are not AER-capable because it would
> now skip clearing of errors in the Device Status register via
> pcie_clear_device_status().

Hi Lukas,

You raise an excellent point about the potential regression.

The origin code is:

	if (host->native_aer || pcie_ports_native) {
		pcie_clear_device_status(bridge);
		pci_aer_clear_nonfatal_status(bridge);
	}

This code clears both the PCIe Device Status register and AER status
registers when in native AER mode.

pcie_clear_device_status() is renamed from
pci_aer_clear_device_status(). Does it intends to clear only AER error
status?

- BIT 0: Correctable Error Detected
- BIT 1: Non-Fatal Error Detected
- BIT 2: Fatal Error Detected
- BIT 3: Unsupported Request Detected

 From PCIe spec, BIT 0-2 are logged for functions supporting Advanced
Error Handling.

I am not sure if we should clear BIT 3, and also BIT 6 (Emergency Power
Reduction Detected) and in case a AER error.

> 
> Thanks,
> 
> Lukas

Thanks.
Shuai

