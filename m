Return-Path: <linux-pci+bounces-20276-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DADCA19FAA
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 09:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C48DA16DDC4
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 08:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE7220B7FB;
	Thu, 23 Jan 2025 08:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="BmBymhmS"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4EE136E21;
	Thu, 23 Jan 2025 08:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737620173; cv=none; b=DC+3YtbUuOJUJfHfdpV6Zuc1fdbJV+kr+h1yfhcG4BHZfW7KZ/ZyvcHW7/s6VfMbQFv4dIGrBBNU9+Je2AeL4sPHad0NiYQoAQ3zj87HBUgswpqtCMz9ZP+EzWxdq7E6SMlPah5VE3C6JXBlziZfL3pEZtxuz5qWRIRLYQDG/FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737620173; c=relaxed/simple;
	bh=04FgOiHblSUfFI91U8mRUSKvplRESzQSP7NiKX2rWdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZNBb7S/qUQiM32ggtVK+/Z/IdtnV6ZROkm7qvJBowp0HzQ9RStRari5JdA+Ihj/1cKm9fiRiFim2yAybKsrCz5te+MZgLHg8RH/2Bgylk59aAi2IbLC+MJcGDq9QwHk8cgjQxLeh84vOjl5ox+PauGuSqj7gQH0O1mC96rEL/TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=BmBymhmS; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=K1td3T1Bnc43/lhC/qBz9yU1NVLBnzJNdIjT9DaCHrU=;
	b=BmBymhmSQd62Ab8I3RCqkEAHC7Qp0IpMXPHwV2ye8u0RYUPyWOziHR+vUXRgXf
	1Dkt9ekRcKASjPQO0JZT4IuIMRmCuntYMtIaLCiNeea/VVRgA3RM6/fdvP3oPCQr
	NmRp+9KBM/dr8+tRFH47Gmb84Duv8yxi4a+WAAVsL2i40=
Received: from [192.168.174.52] (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wAHL2KQ+pFnG+OaHw--.16035S2;
	Thu, 23 Jan 2025 16:15:13 +0800 (CST)
Message-ID: <fcfd4827-4d9e-4bcd-b1d0-8f9e349a6be7@163.com>
Date: Thu, 23 Jan 2025 16:15:12 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND] PCI: cadence: Add configuration space capability search
 API
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org,
 robh@kernel.org, bhelgaas@google.com, bwawrzyn@cisco.com,
 thomas.richard@bootlin.com, wojciech.jasko-EXT@continental-corporation.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250123070935.1810110-1-18255117159@163.com>
 <vj5skjgz4li2vit3xpr3ysldrcvzoglfycemki3yrzg4ocrrkc@isk7ytysgih7>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <vj5skjgz4li2vit3xpr3ysldrcvzoglfycemki3yrzg4ocrrkc@isk7ytysgih7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wAHL2KQ+pFnG+OaHw--.16035S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cr45Cr4fGr45Xw4rZw4Utwb_yoW8Xr1fpF
	s0gw1UK34DJr13JFZrta1Y9FWfGrZYka42q3s8C34rAry3u3ZrGF4SkrWUJF97Cr4fG3WY
	qrWYqF97Z3Z0yFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UHrWwUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWx7do2eR7zrabAAAsu



On 2025/1/23 15:40, Siddharth Vadapalli wrote:
> On Thu, Jan 23, 2025 at 03:09:35PM +0800, Hans Zhang wrote:
>> Add configuration space capability search API using struct cdns_pcie*
>> pointer.
>>
>> Similar patches below have been merged.
>> commit 5b0841fa653f ("PCI: dwc: Add extended configuration space capability
>> search API")
>> commit 7a6854f6874f ("PCI: dwc: Move config space capability search API")
> 
> Similar patches being merged doesn't sound like a proper reason for
> having a feature. Please provide details regarding why this is required.
> Assuming that the intent for introducing this feature is to use it
> later, it will be a good idea to post the patch for that as well in the
> same series.
> 

Hi Siddharth,

For our SOC platform, the offset of some capability needs to be found 
during the initialization process, which I think should be put into the 
cadence public code

eg:

For API: cdns_pcie_find_capability
Need to find PCI Express, then set link speed, retrain link, MaxPayload, 
MaxReadReq, Enable Relaxed Ordering.

For API: cdns_pcie_find_ext_capability
Need to find the Secondary PCIe Capability and set the GEN3 preset 
value. Find the Physical Layer 16.0 GT/s and set the GEN4 preset value.

Development board based on our SOC, Radxa Orinon O6.
https://radxa.com/products/orion/o6/

Our controller driver currently has no plans for upstream and needs to 
wait for notification from the boss.


Best regards
Hans


