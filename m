Return-Path: <linux-pci+bounces-13823-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DD0990447
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 15:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 773B91C21E3B
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 13:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF9715990C;
	Fri,  4 Oct 2024 13:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+eblRru"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B0914B07A
	for <linux-pci@vger.kernel.org>; Fri,  4 Oct 2024 13:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728048358; cv=none; b=Q0IWVtsekzgHEgNzpsDEKnFLqOyUYEcuR3EaIM8wz9AbfD+nZbwTLUCAWWHTauZbSd6qIEQvwSKSQ2054wSQ5OoP53ALZ8nyG/X8tCS5iie9h+T4PlDD1PHabpdbRNFgVQrueA5jpALZN+Rg2dOn8Y7I7C1e2ZDaPww+FHmqtUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728048358; c=relaxed/simple;
	bh=pr04qx00+spbOlSt9VKfuiNUP/HzAglZERFi+2Xm4vo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a2AA7lnY1V8gnXqerZbnz9KFa9y2Xv3iSnKRhELcSTeexFguUUOeqiK6VDMgDJvh2uhY7LgBg4CKny2hyESs+JrdcL5hY9CPJzuxoDDf4Y9B0eosX0hPLfLQw8K51SwQwkA/gO0ZbjyJXft85ecCWcP+RHY8x4cUqYlyj3TlIR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+eblRru; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76414C4CEC6;
	Fri,  4 Oct 2024 13:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728048358;
	bh=pr04qx00+spbOlSt9VKfuiNUP/HzAglZERFi+2Xm4vo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=C+eblRrubSMva+RXh1mFsNmu+bzCSUdQkmcL4Z3CJBEvoNA+5toBcqARUw4FpN2YT
	 yCYh2mwPuhdHg2mAeU994uH0ru+44KBEaKYCXGp7EkRPit1eH3FbOQ29Du0Pt9OYev
	 sndvkbeio2YyZCvrJoTEZ+7K62oe/f6+5N+1uGokAkuhJhahITW2UahcDT2rQT0+WY
	 iHXVJBQDp76BcIhPZrj0DRTKIMnZAQ9+zxJmMVsX7RJG+TzKwpzPQG3LWa8A+cwofp
	 RukQ5mRqEGbOGdknZ8o4e0Z3rqiiFWc+vQLwpql0HGqfv0qrkJU9nbkiPOSJ8EoTxk
	 Dom40XKYIcBhg==
Message-ID: <00e56c66-fed0-417e-b009-5bf11b05b1cc@kernel.org>
Date: Fri, 4 Oct 2024 22:25:54 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] Improve PCI memory mapping API
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Jingoo Han <jingoohan1@gmail.com>,
 linux-pci@vger.kernel.org, Rick Wertenbroek <rick.wertenbroek@gmail.com>
References: <20241004050742.140664-1-dlemoal@kernel.org>
 <Zv_p3CjYblYnY9Dj@ryzen.lan>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <Zv_p3CjYblYnY9Dj@ryzen.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/4/24 22:13, Niklas Cassel wrote:
> On Fri, Oct 04, 2024 at 02:07:35PM +0900, Damien Le Moal wrote:
>> This series introduces the new functions pci_epc_map_align(),
>> pci_epc_mem_map() and pci_epc_mem_unmap() to improve handling of the
>> PCI address mapping alignment constraints of endpoint controllers in a
>> controller independent manner.
>>
>> The issue fixed is that the fixed alignment defined by the "align" field
>> of struct pci_epc_features assumes is defined for inbound ATU entries
>> (e.g. BARs) and is a fixed value, whereas some controllers need a PCI
>> address alignment that depends on the PCI address itself. For instance,
>> the rk3399 SoC controller in endpoint mode uses the lower bits of the
>> local endpoint memory address as the lower bits for the PCI addresses
>> for data transfers. That is, when mapping local memory, one must take
>> into account the number of bits of the RC PCI address that change from
>> the start address of the mapping.
>>
>> To fix this, the new endpoint controller method .map_align is introduced
>> and called from pci_epc_map_align(). This method is optional and for
>> controllers that do not define it, it is assumed that the controller has
>> no PCI address constraint.
>>
>> The functions pci_epc_mem_map() is a helper function which obtains
>> mapping information, allocates endpoint controller memory according to
>> the mapping size obtained and maps the memory. pci_epc_mem_unmap()
>> unmaps and frees the endpoint memory.
>>
>> This series is organized as follows:
>>  - Patch 1 tidy up the epc core code
>>  - Patch 2 improves pci_epc_mem_alloc_addr()
>>  - Patch 3 and 4 introduce the new map_align endpoint controller method
>>    and the epc functions pci_epc_mem_map() and pci_epc_mem_unmap().
>>  - Patch 5 documents these new functions.
>>  - Patch 6 modifies the test endpoint function driver to use 
>>    pci_epc_mem_map() and pci_epc_mem_unmap() to illustrate the use of
>>    these functions.
>>  - Finally, patch 7 implements the rk3588 endpoint controller driver
>>    .map_align operation to satisfy that controller 64K PCI address
>>    alignment constraint.
>>
>> Changes from v2:
>>  - Dropped all patches for the rockchip-ep. These patches will be sent
>>    later as a separate series.
>>  - Added patch 2 and 5
>>  - Added review tags to patch 1
>>
>> Changes from v1:
>>  - Changed pci_epc_check_func() to pci_epc_function_is_valid() in patch
>>    1.
>>  - Removed patch "PCI: endpoint: Improve pci_epc_mem_alloc_addr()"
>>    (former patch 2 of v1)
>>  - Various typos cleanups all over. Also fixed some blank space
>>    indentation.
>>  - Added review tags
> 
> 
> I think the cover letter is missing some text on how this series has been
> tested.
> 
> In V2 I suggested adding a new option to pcitest.c, so that it doesn't
> ensure that buffers are aligned. pci_test will currently use a 4k alignment
> by default, and for some PCI device IDs and vendor IDs, it will ensure that
> the buffers are aligned to something else. (E.g. for the PCI device ID used
> by rk3588, buffers will be aligned to 64K.)
> 
> By adding an --no-alignment option to pci_test, we can ensure that this new
> API is actually working.
> 
> Did you perhaps ifdef out all the alignment from pci_endpoint_test.c when
> testing?

Yes I did. And I also extensively tested using the nvme epf function driver
(coming soon !) which has very random PCI addresses for data buffers (e.g.
BIOSes and GRUB are happy using on-stack totally unaligned buffers...).

> I think that having a --no-alignment option included as part of the series
> would give us higher confidence that the API is working as intended.

Sure, we can add that as a followup patch. I really would like that series to
not be hold up by this though as more stuff depend on it (the nvme epf function
driver is one).

> 
> (pci_test would still align buffers by default, and the long term plan is
> to remove these eventually, but it would be nice to already have an option
> to disable it.)
> 
> 
> Kind regards,
> Niklas


-- 
Damien Le Moal
Western Digital Research

