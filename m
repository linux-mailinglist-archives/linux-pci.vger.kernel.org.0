Return-Path: <linux-pci+bounces-27074-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD8EAA6364
	for <lists+linux-pci@lfdr.de>; Thu,  1 May 2025 21:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A733A3B7FFB
	for <lists+linux-pci@lfdr.de>; Thu,  1 May 2025 19:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87FE224883;
	Thu,  1 May 2025 19:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A24wruSW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945C12236FA
	for <linux-pci@vger.kernel.org>; Thu,  1 May 2025 19:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746126140; cv=none; b=UFORneUEJsxOqBQfJYcQjIYQZ02Af+vUIa4U4JJY+SS0oQQPgx1Kr/aIq27H2WNKd1CQuz6Xwawv9xC7t7ZU6t6rK9XpQldUO7LkMCF7On5a00GLGflazERSzbtrHOgXQwLq0JearahsxRo5ZlWyeHP7a1qGl/TpUJY/T5WkMQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746126140; c=relaxed/simple;
	bh=FB+rPAcZr2Epx4AgG0OSS73NMvlhyswIcpZ/5hpK9qg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ui4m2lpAVaSvQn/G2lSIQzCUixhtyIofgeNo2u/T64VdgfC4DWlMZv8aalsiZj62Og/MxmABTdHHco7qGFn22NbbEP7oQYXhOxKYPwtvX2AFqHhaTZXcmI6pbpad/h/ZRN+IA8/vJMUnGHUhLVADaDvuNb4I0E2dzc+qtRqdZqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A24wruSW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB1E9C4CEE3;
	Thu,  1 May 2025 19:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746126140;
	bh=FB+rPAcZr2Epx4AgG0OSS73NMvlhyswIcpZ/5hpK9qg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=A24wruSW20JJRfcZPx7LIAL7S7E4fbpBM1WX4bvmP52PuG7gx3AbADs76RFT88oe8
	 bHXHLx6tkEWGU0TjxmniT93w1lH1tpM5xZXsdxRkVfMDuflSsjJGk8VjDrRTE/T4s/
	 /4sYVCW27oXQDE5RctZOlFKLXWS2EHpe2RnQxp+Bc5EDBZW7A1IgW5ydF14Z+ZzvxO
	 zIJR28IBoguIa1VMJ9rV0/76rmyRgiVEvcI4nBvrcitTkpX3Ztbp3a0F2rKA6LXeV5
	 KznBxsWRkf0KADHPeej59xGLTwmH5TItYCrToc/iNyKwAmMvYBf5WxgN+Gf4HqD0kR
	 abV/3J3Wj7gFQ==
Message-ID: <5db4d54a-38bc-42b4-a9d0-558d2573d720@kernel.org>
Date: Fri, 2 May 2025 04:02:17 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] PCI: cadence-ep: Fix broken set_msix() callback
To: Niklas Cassel <cassel@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Alan Douglas <adouglas@cadence.com>
Cc: Wilfred Mallawa <wilfred.mallawa@wdc.com>, linux-pci@vger.kernel.org
References: <20250430123158.40535-3-cassel@kernel.org>
 <20250430123158.40535-4-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250430123158.40535-4-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/30/25 21:32, Niklas Cassel wrote:
> While the parameter 'interrupts' to the functions pci_epc_set_msi() and
> pci_epc_set_msix() represent the actual number of interrupts, and
> pci_epc_get_msi() and pci_epc_get_msix() return the actual number of
> interrupts.
> 
> These endpoint library functions just mentioned will however supply
> "interrupts - 1" to the EPC callback functions pci_epc_ops->set_msi() and
> pci_epc_ops->set_msix(), and likewise add 1 to return value from
> pci_epc_ops->get_msi() and pci_epc_ops->get_msix(), even though the
> parameter name for the callback function is also named 'interrupts'.
> 
> While the set_msix() callback function in pcie-cadence-ep writes the
> Table Size field correctly (N-1), the calculation of the PBA offset
> is wrong because it calculates space for (N-1) entries instead of N.
> 
> This results in e.g. the following error when using QEMU with PCI
> passthrough on a device which relies on the PCI endpoint subsystem:
> failed to add PCI capability 0x11[0x50]@0xb0: table & pba overlap, or they don't fit in BARs, or don't align
> 
> Fix the calculation of PBA offset in the MSI-X capability.
> 
> Fixes: 3ef5d16f50f8 ("PCI: cadence: Add MSI-X support to Endpoint driver")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

