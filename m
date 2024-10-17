Return-Path: <linux-pci+bounces-14701-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 854D59A1747
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 02:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 386A01F211B2
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 00:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C077710F2;
	Thu, 17 Oct 2024 00:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUxOjcxG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D56BF4ED
	for <linux-pci@vger.kernel.org>; Thu, 17 Oct 2024 00:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729126020; cv=none; b=QXZSNv8Sasn5xLM2EpBUJT7as1b793wjBFvj7SAGfc6Pg3+DdEl15O8oLXAqIvGNTyZ9uSy3XHKpt7GkS+l77SU0T3Mx1xHYeWUgW2xHJ0RfDX0MSdayGl5kNrsvdWQcRFnvf+HYh5U9bgEUFw24iLonLypjSQ7eFVdOc9sSi/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729126020; c=relaxed/simple;
	bh=d7boWV0l7wdXwACEeUBMqm6JO4Hchi2drWKWrhFcbJc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=WjPB0eHYNIiQ1ON4eIX9c5Cejvhjg2iVPAk3g6J5visdEZFCpdYnua4MwNmpJClgC5v01/Q1y9FknBUbYTi3OzZpTJ665O4pT+yrKxz8SX6Zzgn9QSx1awPLBEdNXmG/ZZB3UvY+O+eWK4R5DrI/1u89qWoiCTyDu0dYAbG4VNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUxOjcxG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD585C4CEC5;
	Thu, 17 Oct 2024 00:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729126020;
	bh=d7boWV0l7wdXwACEeUBMqm6JO4Hchi2drWKWrhFcbJc=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=YUxOjcxGQfcaOMOvBynRqCS3pf5xNC4QDG6At3HXx3+7l9O0x66ypNEyGQo1hkXPR
	 sx7+u19ozcXLZ1bqxgipOQ+9Qutt++1BQ1em/aPxKA9pQ+QN/1sILxTiieUlD+Xv8j
	 TEkhhsA9O/hqjVs3r+hqLwrqkW2YDhdnJ1urAK3dvON7M3Mh63PF0Wq+v+Q7+niyB4
	 knFOYreirxz01r8bG+i5bp2ZUFS/LUhch96pGMxupPvDGAwJaHMdZulAUkACJBXHZ2
	 MDni+LGEUFZFEiK/v5/rNt2KJCHWr+nFGziRGSsveoIxAV32+apDKnGypZSn9WdwXe
	 ZdGCiiB/xzuAQ==
Message-ID: <327b4c34-89af-49f2-ab78-f13ee85bdbce@kernel.org>
Date: Thu, 17 Oct 2024 09:46:57 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v2] PCI: endpoint: Improve pci_epc_ops::align_addr()
 interface
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Jingoo Han <jingoohan1@gmail.com>,
 linux-pci@vger.kernel.org, Rick Wertenbroek <rick.wertenbroek@gmail.com>,
 Niklas Cassel <cassel@kernel.org>
References: <20241015090712.112674-1-dlemoal@kernel.org>
 <20241016165930.djlddcgx7uhrpowd@thinkpad>
 <3d586e07-ac13-42cb-988b-eb24a48491f6@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <3d586e07-ac13-42cb-988b-eb24a48491f6@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/17/24 09:37, Damien Le Moal wrote:
> On 10/17/24 01:59, Manivannan Sadhasivam wrote:
>> On Tue, Oct 15, 2024 at 06:07:12PM +0900, Damien Le Moal wrote:
>>> The PCI endpoint controller operation interface for the align_addr()
>>> operation uses the phys_addr_t type for the PCI address argument and
>>> return a value using this type. This is not ideal as PCI addresses are
>>> bus addresses, not regular memory physical addresses. Replace the use of
>>> phys_addr_t for this operation with the generic u64 type. To be
>>> consistent with this change the Designware driver implementation of this
>>> operation (function dw_pcie_ep_align_addr()) as well as the type of PCI
>>> address fields of struct pci_epc_map are also changed.
>>>
>>> Fixes: e98c99e2ccad ("PCI: endpoint: Introduce pci_epc_mem_map()/unmap()")
>>> Fixes: cb6b7158fdf5 ("PCI: dwc: endpoint: Implement the pci_epc_ops::align_addr() operation")
>>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>>
>> I thought of applying it, but then decided to squash it with the offending
>> patches.
> 
> Fine with me. Thanks !

Just checked the pci/endpoint branch but I do not see this patch squashed there.
Did you push the change ?

-- 
Damien Le Moal
Western Digital Research

