Return-Path: <linux-pci+bounces-44107-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9996ACF88A3
	for <lists+linux-pci@lfdr.de>; Tue, 06 Jan 2026 14:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 121BF30028BB
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jan 2026 13:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B4932ED30;
	Tue,  6 Jan 2026 13:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="IAWNHltE"
X-Original-To: linux-pci@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1374337BBC
	for <linux-pci@vger.kernel.org>; Tue,  6 Jan 2026 13:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767706243; cv=none; b=Nchayc1j1mcbUveaDTe32xHcAzNczgdr+fDS7MbWrzc6yULC8K/WNd0OoCxRFcQB8RRcUwJ5TzVDzdJUPsBxiRtKQu0JGkTPu7rOtPAlXvTef+DnwiN/DaTQjA1JLY1Qv6w4j63AOFQ4KJ/Rhpt9Oy54dHncuxZW/n/RfRkFSaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767706243; c=relaxed/simple;
	bh=60+Sf5W7iO9SPKChWPLThRY3+OhvLAIM8zK8j5C5YYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ReYkX43oaSqA45XSnWZA3MVGBkHcGMCD/Ej8x6chDydb8JBd2QgBiwsKUX91MstQ3BsGO4ucuE6N9rEtENNO3/2umDEAwr/dNNsiu4harltKfzxaMxwC+VFhVEmxilVaB57FPwF/tc9QE5hD1sAndQuJnVl01ozLxQvjnfjgPQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=IAWNHltE; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:Reply-To:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=UUTskj3wiA5tfwgEryCVrLMh3FcdCtrzE/WCbGi9WFY=;
	t=1767706241; x=1768138241; b=IAWNHltEldCyTWos8uU4k6kZyQCtQ3O/PcvFJ39bqPC4SN8
	R7FPWy8egukRhU/0sFHxCMFt0Bvn5Ew00wwWi9rQVkfigBHWC2IgWkFk9RGbaI44bPyrpdSbH65zH
	R9mJYXnBP9Iv9QQ7YT3zvbTLqaogavcy5p6pPYH/VkwxjlbDwlK3+wKcyv0bDGXm/DeWDW2k3Y8TK
	wJL0tAW4E68ZdUdJ8xQJPoSnylbPc2heSuCo3p85GLbP2j8tNWtSfHkAKYnIlrtHInK1mzxxHoGGV
	kiA1u2dq1p7ZOnL/oD1lDuCL0VLIWVfaebsciNRHgwz4sWQAdfTW8UfVhGOrsYZw==;
Received: from [2a02:8108:8984:1d00:a0cf:1912:4be:477f]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
	id 1vd78o-004lF5-08;
	Tue, 06 Jan 2026 14:30:30 +0100
Message-ID: <80340269-c702-442d-a461-300a2041a497@leemhuis.info>
Date: Tue, 6 Jan 2026 14:30:29 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [PATCH] PCI: Disable RRS polling for Intel SSDPE2KX020T8 nvme
To: Bjorn Helgaas <helgaas@kernel.org>, Hui Wang <hui.wang@canonical.com>,
 Nirmal Patel <nirmal.patel@linux.intel.com>,
 Jonathan Derrick <jonathan.derrick@linux.dev>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
 raphael.norwitz@nutanix.com, alay.shah@nutanix.com,
 suresh.gumpula@nutanix.com, ilpo.jarvinen@linux.intel.com,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
References: <20251008165345.GA627277@bhelgaas>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <20251008165345.GA627277@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1767706241;b05f1c33;
X-HE-SMSGID: 1vd78o-004lF5-08

[top-posting to facilitate processing]

The issue discussed in this thread is still on my list of tracked
regression, which got me wondering what's the status here. Did it fall
through the cracks? Or was the regression maybe fixed already and I just
missed it?

Ciao, Thorsten

On 10/8/25 18:53, Bjorn Helgaas wrote:
> Nirmal, Jonathan, can you confirm that when RRS SV is enabled for VMD
> Root Ports, we should actually see the 0x0001 value when a device
> downstream of VMD responds with RRS?  From the log below, it appears
> that we actually get 0xffffffff when reading Device ID after a reset.
> 
> On Thu, Aug 21, 2025 at 11:39:36AM -0500, Bjorn Helgaas wrote:
>> On Thu, Jul 03, 2025 at 08:05:05AM +0800, Hui Wang wrote:
>>> On 7/2/25 17:43, Hui Wang wrote:
>>>> On 7/2/25 07:23, Bjorn Helgaas wrote:
>> ...
> 
>>>>> Thank you!  It seems like we get 0xffffffff (probably PCIe error) for
>>>>> a long time after we think the device should be able to respond with
>>>>> RRS.
>>>>>
>>>>> I always thought the spec required that after the delays, a device
>>>>> should respond with RRS if it's not ready, but now I guess I'm not
>>>>> 100% sure.  Maybe it's allowed to just do nothing, which would lead to
>>>>> the Root Port timing out and logging an Unsupported Request error.
>>>>>
>>>>> Can I trouble you to try the patch below?  I think we might have to
>>>>> start explicitly checking for that error.  That probably would require
>>>>> some setup to enable the error, check for it, and clear it.  I hacked
>>>>> in some of that here, but ultimately some of it should go elsewhere.
>> ...
> 
> The patch is here:
> https://lore.kernel.org/r/20250701232341.GA1859056@bhelgaas
> and the log with that patch is here:
> 
>>> This is the testing result and log.
>>> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2111521/comments/65
> 
>> We're waiting for 01:00.0, and we're seeing the poll message for about
>> 375 ms:
> 
> [   10.177356] pci 10000:00:02.0: PCI bridge to [bus 01]
> [   10.182278] pci 10000:01:00.0: [8086:0a54] type 00 class 0x010802 PCIe Endpoint
> [   10.195247] pci 10000:00:02.0: pci_reset_secondary_bus: PCI_BRIDGE_CTL_BUS_RESET deasserted
> [   10.195464] pci 10000:00:02.0: waiting 100 ms for downstream link, after activation
> [   10.195467] pci 10000:00:02.0: pcie_wait_for_link_delay: active 1 delay 100 link_active_reporting 1
> [   10.229269] pci 10000:00:02.0: pcie_wait_for_link_status: LNKSTA 0xb043
> [   10.334784] pci 10000:00:02.0: pcie_wait_for_link_delay: waited 100ms
> 
>>   [   10.334786] pci 10000:01:00.0: pci_dev_wait: VF- bus reset timeout 59900
>>   [   10.334792] pci 10000:00:02.0: pci_dev_wait: read 0xffffffff DEVSTA 0x0000
>>   ...
>>   [   10.708367] pci 10000:00:02.0: pci_dev_wait: read 0xffffffff DEVSTA 0x0000
>>
>> The 00:02.0 Root Port has RRS SV enabled, but the config reads of the
>> 01:00.0 Vendor ID did not return the RRS value (0x0001).  Instead,
>> they returned 0xffffffff, which typically means an error on PCIe.


