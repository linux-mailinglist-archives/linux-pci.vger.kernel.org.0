Return-Path: <linux-pci+bounces-27073-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC44AA6363
	for <lists+linux-pci@lfdr.de>; Thu,  1 May 2025 21:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE4B5188DE3C
	for <lists+linux-pci@lfdr.de>; Thu,  1 May 2025 19:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4ED22425E;
	Thu,  1 May 2025 19:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kROpWN8j"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD03E2236FA
	for <linux-pci@vger.kernel.org>; Thu,  1 May 2025 19:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746126097; cv=none; b=CKg+Y0dHXysHBlEK9bk4c2lTA18aahs6qaRpXIprdJJu8IsDvyOiZw/SWqYfAYFygdhts3EEtgiHWjwUcSJhLCYkB8PT1YIgyB+4Oe6epFg8OYELst3siTa9hQSjVvsXO6yZzBMOPRhZuIBj3mbbUgXI9tpxDvvenVtyIhmdY8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746126097; c=relaxed/simple;
	bh=2YO+Fi3ufnuH6AlfnBL1izbrq0NSrEqmNWBpaHsiOK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gemQHKXmXEVYglD64s2ujePL3q+vQxeUez5kbUiIC/HUggMCF3MedwloOZmLA4i/K704SxAY/3/STWA2FSDvepUqp2MI9pCnGjml29DNDiFfJJItl4sH5tJN3SxDFl6GWcQ+ERouNxRcqTGFhkJMiaINMZa0zmTvipfNyCk52Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kROpWN8j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC7CC4CEE3;
	Thu,  1 May 2025 19:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746126097;
	bh=2YO+Fi3ufnuH6AlfnBL1izbrq0NSrEqmNWBpaHsiOK0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kROpWN8ja8GD0f+WmyK6cwlHfTfOQG51FkHiGz5vUis47QpxtQZ+9gJUAbB3BJrlL
	 wZ1Up8GNrT65Kg5/pXHETnb12KRGtdFkGMLKYYQKXwoeIlAA94bm4QoiCDGedE7sOp
	 UdIP/rWMhq0sXu1wBk52aPZYVAYAGQYprQvTH9UBdh1+xfmdW3+Y7jbX+G89O4MoID
	 hNKNVJsQc+la3w0rORYKfGYYpVni3lzDc8IldPSephmr7zkehetpj1f3CPyw4gcU9N
	 t7+MhKARw0zk1GpevJ2rn2UBLrws/uXcMqHfje1WjxOG5uwOrqzgrakpU8vqkuf0Sd
	 2m+XlcjwfelAA==
Message-ID: <575a1aae-3282-4f63-aafb-cb9f2252b443@kernel.org>
Date: Fri, 2 May 2025 04:01:35 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PCI: dwc: ep: Fix broken set_msix() callback
To: Niklas Cassel <cassel@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Wilfred Mallawa <wilfred.mallawa@wdc.com>, linux-pci@vger.kernel.org
References: <20250430123158.40535-3-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250430123158.40535-3-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/30/25 21:31, Niklas Cassel wrote:
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

It would be nice to fix this discrepancy between the high level api and the
driver operatrion as it is awfully confusing... But that is separate from this fix.

> 
> While the set_msix() callback function in pcie-designware-ep writes the
> Table Size field correctly (N-1), the calculation of the PBA offset
> is wrong because it calculates space for (N-1) entries instead of N.
> 
> This results in e.g. the following error when using QEMU with PCI
> passthrough on a device which relies on the PCI endpoint subsystem:
> failed to add PCI capability 0x11[0x50]@0xb0: table & pba overlap, or they don't fit in BARs, or don't align
> 
> Fix the calculation of PBA offset in the MSI-X capability.
> 
> Fixes: 83153d9f36e2 ("PCI: endpoint: Fix ->set_msix() to take BIR and offset as arguments")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

