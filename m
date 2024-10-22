Return-Path: <linux-pci+bounces-15066-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 309C99AB962
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 00:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3CC6281A5F
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 22:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D13C1CCB50;
	Tue, 22 Oct 2024 22:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXNdNrBq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC177198846
	for <linux-pci@vger.kernel.org>; Tue, 22 Oct 2024 22:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729635163; cv=none; b=K7ZQjFFf6JVpfh30IwMpRcmiKviROxZNuy78MZSIKVmJJxdfDHRN5PKtal5fqiOQd1jrkGSEpLpz6+DFGaNwOKp53gK+MgeAjhSCPL6ALy2NPkoK7E2WUFn1zxGXg4SqcfaLZdP/1J6tbTm/fSGhkAKFImfczlZ+pGr/4S/dsNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729635163; c=relaxed/simple;
	bh=EdSM3xFr5nicXTWcakIZpBOD5bgSiZQYU4tE1DXlxro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uaTt6v38JohAyTGNiZHnBTVFCMnZ5X5xeIMUqJ14k2qqHBICBKefppXHG2mq8tBaJtgioZFAIEeysqguUfy2rX+wWZ6HQOB0A4x0uH0t/B9Ln1NS5/qzF70eURo4WBVX2nn2LQfdMW7woprs6Y7lHXsqH/FGx2Nr404eIIICkU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXNdNrBq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C20EC4CEC7;
	Tue, 22 Oct 2024 22:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729635163;
	bh=EdSM3xFr5nicXTWcakIZpBOD5bgSiZQYU4tE1DXlxro=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JXNdNrBqnUiIzaTSuZk9pDKr7lO4+uozAkwJkdtWJ9PfKMgZFFtAj1XHDRVgRrUdS
	 oc9xQWrndjglhoJ+rerlN15Nhv44H7fGTMGSGfSb2r2O43uVZbuKnmZkeYdf6QHow4
	 DpZNN71GRBiq5dGNkKXgERf9hUZohz0yByz/iaDxyohOY40gKAGe6oCqavfxX0wqQX
	 +sLNz9l2r/vw2QFVOr7K5NKnPQbK3muRyhACCYE9WmbfJqc/suVU6x4PZjJM7Yiwaj
	 jaG9ivngYEfgZi6TKBQhCH87+ZFrUo+KrC+xTL8mWYxM5y+AbEgIXLbiTwktj88wak
	 pT1gP5EZZJUgg==
Message-ID: <edacb9ce-8cba-4017-9c1a-c010d5d930fc@kernel.org>
Date: Wed, 23 Oct 2024 07:12:40 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/6] Improve PCI memory mapping API
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Niklas Cassel <cassel@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kw@linux.com>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Jingoo Han <jingoohan1@gmail.com>,
 linux-pci@vger.kernel.org, Rick Wertenbroek <rick.wertenbroek@gmail.com>
References: <20241021221956.GA851955@bhelgaas>
 <848f676b-afce-472e-872d-53a32af094c1@kernel.org>
 <ZxdkopcSp9/P4f6k@x1-carbon.wireless.wdc>
 <20241022135631.a6ux4jzb47v7jvqr@thinkpad>
 <ZxezuNnmJesC3IG9@x1-carbon.wireless.wdc>
 <20241022153033.uizmuvqzamfninlr@thinkpad>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241022153033.uizmuvqzamfninlr@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/23/24 00:30, Manivannan Sadhasivam wrote:
> On Tue, Oct 22, 2024 at 04:16:24PM +0200, Niklas Cassel wrote:
>> On Tue, Oct 22, 2024 at 07:26:31PM +0530, Manivannan Sadhasivam wrote:
>>> On Tue, Oct 22, 2024 at 10:38:58AM +0200, Niklas Cassel wrote:
>>>> On Tue, Oct 22, 2024 at 10:51:53AM +0900, Damien Le Moal wrote:
>>>>> On 10/22/24 07:19, Bjorn Helgaas wrote:
>>>>>> On Sat, Oct 12, 2024 at 08:32:40PM +0900, Damien Le Moal wrote:
>>>
>>>> However, if you think about a generic DMA controller, e.g. an ARM primecell
>>>> pl330, I don't see how it that DMA controller will be able to perform
>>>> transfers correctly if there is not an iATU mapping for the region that it
>>>> is reading/writing to.
>>>>
>>>
>>> I don't think the generic DMA controller can be used to read/write to remote
>>> memory. It needs to be integrated with the PCIe IP so that it can issue PCIe
>>> transactions.
>>
>> I'm not an expert, so I might of course be misunderstanding how things work.
>>
> 
> Neither am I :) I'm just sharing my understanding based on reading the DWC spec
> and open to get corrected if I'm wrong.
> 
>> When the CPU performs an AXI read/write to a MMIO address within the PCIe
>> controller (specifically the PCIe controller's outbound memory window),
>> the PCIe controller translates that incoming read/write to a read/write on the
>> PCIe bus.
>>
> 
> I don't think the *PCIe controller* translates the read/writes, but the iATU. If
> we use iATU, then the remote address needs to be mapped to the endpoint DDR and
> if CPU performs AXI read/write to that address, then iATU will translate the DDR
> address to remote address and then issue PCIe transactions (together with the
> PCIe controller).
> 
> And if DMA is used, then DMA controller can issue PCIe transactions to the
> remote memory itself (again, together with the PCIe controller). So no mapping
> is required here.

Caveat: DMA here cannot be the case "using the generic memory copy offload DMA
channel". It must be DMA driven by hardware rx/tx DMA channels. For memory copy
offload DMA channel, an EPF must map the address range to "DMA" to (which is
really memcpy_toio/fromio() but the DMA API will hide that...).

Would love to have so EPF wrapper API around all that mess to simplify EPF
drivers. They all end up having to do the exact same things.

> 
> - Mani
> 


-- 
Damien Le Moal
Western Digital Research

