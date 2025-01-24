Return-Path: <linux-pci+bounces-20336-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA947A1B68D
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2025 14:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25B6F16BBFD
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2025 13:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1D0524F;
	Fri, 24 Jan 2025 13:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="LvTTE0IL"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBF235945;
	Fri, 24 Jan 2025 13:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737723713; cv=none; b=EO4UNmxKkzKYzYKIoMyKHc2UnCHQQONJXslvCNSahDS2EoX6CkQM+wHd0f+iGkGTFEEdXzPvFD0/kmubsJiojhbhPXNJS01wleLLmBwwnkh/UvvgvqJfIeA+qFf3RBFzxrS/NDDl/9NfL5z4ONXQXeqkwrdLZBv8ks6gaHKNMZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737723713; c=relaxed/simple;
	bh=GpAPZF03nG38ZHDy9iMjo29tVDDLE1ABFiD7wZCZgrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CQDb1hYpqgaLTsL68rwwuMFDhGN4qqKAeio7vNfpueh5HNZbDPMvik9tVu5HdJINS7xEoatMzZ9IYfq1zfWQgrUnHOkBigtZEPnwTzYk1bvUER0nLEreURwIQmSyPJgWKtxXEqHXWHROXnXwCzwfQ0GQpS+8Y9xFA/ps4JBY0EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=LvTTE0IL; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=TN1EfBgDx1eDHQBugFEedOW2gvOChBEEF6T8sRNHNSI=;
	b=LvTTE0ILAsPE2Qwt6JUiI6eZYdblwTUWLond+f5LUb//6LAw800vTBBfOivPcv
	rUYjCYDw5EQm4M0SxNtU3GNt3Y/QIkupw57dEmQ4DnBSF7AZTg1PekfdsrnwaIEt
	F7+eK9ZAxvDRgoc5Z0ENXTehJpwY8svlztntcXTAFvHpM=
Received: from [192.168.174.52] (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgDn3hLYjpNnPjW1FQ--.57031S2;
	Fri, 24 Jan 2025 21:00:09 +0800 (CST)
Message-ID: <79dc276d-7154-4b83-9dc5-dfdd65d89ad5@163.com>
Date: Fri, 24 Jan 2025 21:00:09 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND] PCI: cadence: Add configuration space capability search
 API
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, lpieralisi@kernel.org,
 kw@linux.com, manivannan.sadhasivam@linaro.org, robh@kernel.org,
 bhelgaas@google.com, bwawrzyn@cisco.com, thomas.richard@bootlin.com,
 wojciech.jasko-EXT@continental-corporation.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250123170831.GA1226684@bhelgaas>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20250123170831.GA1226684@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PSgvCgDn3hLYjpNnPjW1FQ--.57031S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFy5Wry7Gr1UAr43GFyDKFg_yoW8CrWxpF
	WDW3W5Kw4DJr4SyFZ7tw40gayagr95Za47X3s8G34rAr9I9rnxKF4SkrWUCF92kr4fW3WY
	vrWYqas7Za1YvFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UOzV8UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiDxzeo2eTVielogABst



On 2025/1/24 01:08, Bjorn Helgaas wrote:
> On Thu, Jan 23, 2025 at 04:15:12PM +0800, Hans Zhang wrote:
>> On 2025/1/23 15:40, Siddharth Vadapalli wrote:
>>> On Thu, Jan 23, 2025 at 03:09:35PM +0800, Hans Zhang wrote:
>>>> Add configuration space capability search API using struct cdns_pcie*
>>>> pointer.
>>>>
>>>> Similar patches below have been merged.
>>>> commit 5b0841fa653f ("PCI: dwc: Add extended configuration space capability
>>>> search API")
>>>> commit 7a6854f6874f ("PCI: dwc: Move config space capability search API")
>>>
>>> Similar patches being merged doesn't sound like a proper reason for
>>> having a feature. Please provide details regarding why this is required.
>>> Assuming that the intent for introducing this feature is to use it
>>> later, it will be a good idea to post the patch for that as well in the
>>> same series.
>>
>> For our SOC platform, the offset of some capability needs to be found during
>> the initialization process, which I think should be put into the cadence
>> public code
>>
>> eg:
>>
>> For API: cdns_pcie_find_capability
>> Need to find PCI Express, then set link speed, retrain link, MaxPayload,
>> MaxReadReq, Enable Relaxed Ordering.
>>
>> For API: cdns_pcie_find_ext_capability
>> Need to find the Secondary PCIe Capability and set the GEN3 preset value.
>> Find the Physical Layer 16.0 GT/s and set the GEN4 preset value.
>>
>> Development board based on our SOC, Radxa Orinon O6.
>> https://radxa.com/products/orion/o6/
>>
>> Our controller driver currently has no plans for upstream and needs to wait
>> for notification from the boss.
> 
> If/when you upstream code that needs this interface, include this
> patch as part of the series.  As Siddharth pointed out, we avoid
> merging code that has no upstream users.
> 
> Bjorn

I got it. Thank you Siddharth and Bjorn.

Best regards
Hans


