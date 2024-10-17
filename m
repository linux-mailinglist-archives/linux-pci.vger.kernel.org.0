Return-Path: <linux-pci+bounces-14700-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D46859A1737
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 02:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 464F7B266E8
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 00:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BA73C30;
	Thu, 17 Oct 2024 00:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZatcvCgT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FAC23A6
	for <linux-pci@vger.kernel.org>; Thu, 17 Oct 2024 00:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729125440; cv=none; b=iK0N9pmqblxgv7KjLCA2EfKhAXmsnIqYAqbZyJcHN+9pX+oIYQoygelxHOxBRcVN97chh2JS0j+aUaP4SqaV3XFPU8etJXAS0zBcxxE6pz65drOdF/oPDNlqM2vQu75w2MzcxahwzYthvXtmYrXjAxZ3NkwVB9gMHRuf/4F+gFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729125440; c=relaxed/simple;
	bh=ogUzhpG6qjQ4NVc+L7MrplTVoROXVnLtG6bx4Q6SN58=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=qfUbHEHh0u1zsFVd2k4oIhhdMiMKuKg5z9C4buzhTFaSeqWr8kLD/8hyr1OfWsCg/5293dEGeaXofKZVPgn33TbF9NjwpKQ3xrimKIX/MzMBfennY+GoDQKKDGblYm/OSJP15hYH59vz70zp+q54jVObHamHnf0yYQyD4dTlxs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZatcvCgT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E602C4CEC7;
	Thu, 17 Oct 2024 00:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729125440;
	bh=ogUzhpG6qjQ4NVc+L7MrplTVoROXVnLtG6bx4Q6SN58=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=ZatcvCgThhpH3yPysy3Q/mB21Iamulsd2LYFpstoAjYSk6UD4OuuZ8am2zWDyRXXz
	 J+lgOCTa/K2CcKzFNbhbCoAAYU6gI2HBYjJFclDKqOD0gtxMDr+/jS8ch6rTYlG3cx
	 JB/aUAz07yqupLq/Nk3fjoR9/XOUQfYX6OcQGwLevFs/jybrpYpNw6WtEzrwM5tCb8
	 7ckcXmXnDRZtdF4peA7bWuM+gwXBwdncIvznWsrF9chjXm49rdK9EWrkADLkW3r6gJ
	 RHj9+b0RRUPptPhbP8LpQQCzd7hKSwCGob9bb6nOKtoKdTEUGRKGl1aOOYnfYjQw4a
	 0wog6uVGv9u+g==
Message-ID: <3d586e07-ac13-42cb-988b-eb24a48491f6@kernel.org>
Date: Thu, 17 Oct 2024 09:37:16 +0900
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
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241016165930.djlddcgx7uhrpowd@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/17/24 01:59, Manivannan Sadhasivam wrote:
> On Tue, Oct 15, 2024 at 06:07:12PM +0900, Damien Le Moal wrote:
>> The PCI endpoint controller operation interface for the align_addr()
>> operation uses the phys_addr_t type for the PCI address argument and
>> return a value using this type. This is not ideal as PCI addresses are
>> bus addresses, not regular memory physical addresses. Replace the use of
>> phys_addr_t for this operation with the generic u64 type. To be
>> consistent with this change the Designware driver implementation of this
>> operation (function dw_pcie_ep_align_addr()) as well as the type of PCI
>> address fields of struct pci_epc_map are also changed.
>>
>> Fixes: e98c99e2ccad ("PCI: endpoint: Introduce pci_epc_mem_map()/unmap()")
>> Fixes: cb6b7158fdf5 ("PCI: dwc: endpoint: Implement the pci_epc_ops::align_addr() operation")
>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> 
> I thought of applying it, but then decided to squash it with the offending
> patches.

Fine with me. Thanks !


-- 
Damien Le Moal
Western Digital Research

