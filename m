Return-Path: <linux-pci+bounces-14396-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C9399B4B3
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 14:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1A351C203E4
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 12:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD5515C0;
	Sat, 12 Oct 2024 12:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sBgOmlx0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00091527AC
	for <linux-pci@vger.kernel.org>; Sat, 12 Oct 2024 12:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728734605; cv=none; b=peXyPK25BS3oW7G7RJlO1xW269Jz3boY7TmXPXSyMeFcQERy4wLn6Iff2pX/qZlNBZRqTfacJ3c1vvIMetg4TraCFzXyr1smjCEtDKyG0bRUquZsTVxsmQp+PUBZjmIESX/LMsJRcw4hT5kx+OpAQjLx0Bu/KdMRWBsVF9G/faE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728734605; c=relaxed/simple;
	bh=YZkfQ879/Gx7aGUjG/Bs5rY0CqQ6p+diKWc96G9d3ac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nQSYS4jgsFDzSCaO3Q+LowHlchI7eLDvs8FeZs4e6kxRV7i6sJXtpri25t5nOlHfTZHV1pGHtnk6FUXPyTtA6KgwYh7Stc6xqdfAOOnDQNLHb4WUJiyZNsOeVePo/StVqJsa4jDVc7K0x7VxHfpecOosr2h2Q0CFXHwjtmB3Kv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sBgOmlx0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BCD8C4CEC6;
	Sat, 12 Oct 2024 12:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728734604;
	bh=YZkfQ879/Gx7aGUjG/Bs5rY0CqQ6p+diKWc96G9d3ac=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sBgOmlx0NGOR+gNu+5YiZc58JXqV2l4K2dzrQ9bh2/QbwwOKFIwGW5q6gRwN79JyJ
	 xBNk6TW/Fs6qUGZwx8Pzht616xlFTsk5ApOhPLqvsXeK4MtayH/xRHBiLP18eWWC/D
	 n0dwPrsir0b8OPZ96wjQ0ZqdmWX4HSlpB8IQrDJW68jJSgzVy+5nYJl+cHLoIO02Va
	 3iirDYoNKT4DOeVqD/aL5Ds3VZjGvTUwqPmXFvxmDS9Va04pYGKJjOYXaEhaib/3Wy
	 i/86vw18rRVW5EjPTQHRrEk6o2tQwH8hPp7GjGtPWH0Pc2qc4ksmPbjTj79z8yNMXF
	 ZK5dMSgCjaFag==
Message-ID: <94bbd606-86c5-470f-80c2-6db3bc0f1d9a@kernel.org>
Date: Sat, 12 Oct 2024 21:03:22 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/6] Improve PCI memory mapping API
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Jingoo Han <jingoohan1@gmail.com>,
 linux-pci@vger.kernel.org, Rick Wertenbroek <rick.wertenbroek@gmail.com>,
 Niklas Cassel <cassel@kernel.org>
References: <20241012113246.95634-1-dlemoal@kernel.org>
 <20241012115737.qxwnsxy6pts6iyza@thinkpad>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241012115737.qxwnsxy6pts6iyza@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/12/24 20:57, Manivannan Sadhasivam wrote:
> On Sat, Oct 12, 2024 at 08:32:40PM +0900, Damien Le Moal wrote:
>> This series introduces the new functions pci_epc_mem_map() and
>> pci_epc_mem_unmap() to improve handling of the PCI address mapping
>> alignment constraints of endpoint controllers in a controller
>> independent manner.
>>
>> The issue fixed is that the fixed alignment defined by the "align" field
>> of struct pci_epc_features is defined for inbound ATU entries (e.g.
>> BARs) and is a fixed value, whereas some controllers need a PCI address
>> alignment that depends on the PCI address itself. For instance, the
>> rk3399 SoC controller in endpoint mode uses the lower bits of the local
>> endpoint memory address as the lower bits for the PCI addresses for data
>> transfers. That is, when mapping local memory, one must take into
>> account the number of bits of the RC PCI address that change from the
>> start address of the mapping.
>>
>> To fix this, the new endpoint controller method .align_addr is
>> introduced and called from the new pci_epc_mem_map() function. This
>> method is optional and for controllers that do not define it, it is
>> assumed that the controller has no PCI address constraint.
>>
>> The functions pci_epc_mem_map() is a helper function which obtains
>> the mapping information, allocates endpoint controller memory according
>> to the mapping size obtained and maps the memory. pci_epc_mem_unmap()
>> unmaps and frees the endpoint memory.
>>
>> This series is organized as follows:
>>  - Patch 1 introduces a small helper to clean up the epc core code
>>  - Patch 2 improves pci_epc_mem_alloc_addr()
>>  - Patch 3 introduce the new align_addr() endpoint controller method
>>    and the epc functions pci_epc_mem_map() and pci_epc_mem_unmap().
>>  - Patch 4 documents these new functions.
>>  - Patch 5 modifies the test endpoint function driver to use 
>>    pci_epc_mem_map() and pci_epc_mem_unmap() to illustrate the use of
>>    these functions.
>>  - Finally, patch 6 implements the RK3588 endpoint controller driver
>>    .align_addr() operation to satisfy that controller PCI address
>>    alignment constraint.
>>
>> This patch series was tested using the pci endpoint test driver (as-is
>> and a modified version removing memory allocation alignment on the host
>> side) as well as with a prototype NVMe endpoint function driver (where
>> data transfers use addresses that are never aligned to any specific
>> boundary).
>>
> 
> Applied to pci/endpoint!

Awesome ! Thanks a lot !

-- 
Damien Le Moal
Western Digital Research

