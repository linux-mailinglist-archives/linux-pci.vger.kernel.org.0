Return-Path: <linux-pci+bounces-42517-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EE3C9C965
	for <lists+linux-pci@lfdr.de>; Tue, 02 Dec 2025 19:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DC3B3A40FB
	for <lists+linux-pci@lfdr.de>; Tue,  2 Dec 2025 18:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346092D0C9D;
	Tue,  2 Dec 2025 18:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o74f6/Qq"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2482C032E
	for <linux-pci@vger.kernel.org>; Tue,  2 Dec 2025 18:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764699431; cv=none; b=jy8WAmqirGt/Ymvy4CX5cmion+xciZAxOyO71D2oP2JBQFUKI+InmxzLPhTswOFTTsICV4YdGvrcc6AyaAinRHRzaqu0WK1VU+hA477Yye8ktHtGN58yacyzcWuOemkS+YKCHX8fTuZ8mZdy4x68Zf0c4D1CgZij+PX/broH8U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764699431; c=relaxed/simple;
	bh=XJt/6hoSALardBqKcNsszG4D/J/RPpzDYdAsQrSJK0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iyHqYD8Rror6o100iUyPky1TF2jsqaNxg1gIsnZ2mpGo01epVviznH7SF5aVeh2CgoETbviEfvkgFibdjGl8gKnKuOi6nV4JGXGqatlncHgKs49WyhssMRp/d2StHzbjjnSZpKtTe52YVfkjxonCb9dtv53ZL5CKqnr8UloeZMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o74f6/Qq; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2d18db0c-185e-432c-8694-5dfb58c18cd1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764699424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a1mWc7gztRkP7VXxA4s1WBm62Y88a27Q09etAWEj2Wg=;
	b=o74f6/Qqfkf76WLkpi8ue36PUHZXm67UHCwg61qN71DBSrnvS7NeUJnyy5kBCTWhPRwVT8
	eNyuhTzdwk1nWKS9b5/w0Mw0J2yfL8xJ973qehHDx7504IM9JD80uHKUl1iCdNGBpiu8RL
	1WenBfZkldizW1Ku/boxSjQOXqGCxAM=
Date: Tue, 2 Dec 2025 10:16:55 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] PCI: Do not attempt to set ExtTag for VFs
To: Haakon Bugge <haakon.bugge@oracle.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Sinan Kaya <okaya@codeaurora.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20251112095442.1913258-1-haakon.bugge@oracle.com>
 <99561464-1C66-4075-9963-C67F8C492E46@oracle.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "yanjun.zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <99561464-1C66-4075-9963-C67F8C492E46@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 12/1/25 11:56 PM, Haakon Bugge wrote:
> 
> 
>> On 12 Nov 2025, at 10:54, Håkon Bugge <Haakon.Bugge@oracle.com> wrote:
>>
>> The bit for enabling extended tags is Reserved and Preserved (RsvdP)
>> for VFs, according to PCIe r7.0 section 7.5.3.4 table 7.21.  Hence,
>> bail out early from pci_configure_extended_tags() if the device is a
>> VF.


enabling extended tags in PCIe r7.0 section 7.5.3.4 table 7.21 is as below:
"
Extended Tag Field Enable - This bit, in combination with the 10-Bit Tag 
Requester Enable bit and the 14-Bit Tag Requester Enable bit, determines 
how many Tag field bits a Requester is permitted to use for non-UIO 
Requests. This bit is not applicable to a Requester when generating UIO 
Requests. The following applies when the 10-Bit Tag Requester Enable bit 
and the 14-Bit Tag Requester Enable bit are both Clear. If the Extended 
Tag Field Enable bit is Set, the Function is permitted to use an 8-bit 
Tag field as a Requester. If the bit is Clear, the Function is 
restricted to using a 5-bit Tag field. See § Section 2.2.6.2 for 
required behavior when one or both of these larger-Tag Requester Enable 
bits are Set. If software changes the value of the Extended Tag Field 
Enable bit while the Function has outstanding Non-Posted Requests, the 
result is undefined. Functions that do not implement this capability 
hardwire this bit to 0b. Default value of this bit is implementation 
specific.
"

Thus,
Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

>>
>> Otherwise, we may see incorrect log messages such as:
>>
>>    kernel: pci 0000:af:00.2: enabling Extended Tags
>>
>> (af:00.2 is a VF)
>>
>> Fixes: 60db3a4d8cc9 ("PCI: Enable PCIe Extended Tags if supported")
>> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
> 
> A gentle ping on this one.
> 
> 
> Thxs, Håkon
> 
>>
>> ---
>>
>> v1 -> v2: Added ref to PCIe spec
>> ---
>> drivers/pci/probe.c | 3 ++-
>> 1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index 0ce98e18b5a87..014017e15bcc8 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -2244,7 +2244,8 @@ int pci_configure_extended_tags(struct pci_dev *dev, void *ign)
>> u16 ctl;
>> int ret;
>>
>> - if (!pci_is_pcie(dev))
>> + /* PCI_EXP_DEVCTL_EXT_TAG is RsvdP in VFs */
>> + if (!pci_is_pcie(dev) || dev->is_virtfn)
>> return 0;
>>
>> ret = pcie_capability_read_dword(dev, PCI_EXP_DEVCAP, &cap);
>> -- 
>> 2.43.5
>>
> 


