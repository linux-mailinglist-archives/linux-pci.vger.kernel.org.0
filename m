Return-Path: <linux-pci+bounces-8672-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EA890568E
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 17:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0D2328377D
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 15:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CA517FAA2;
	Wed, 12 Jun 2024 15:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U9xbURPo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FAD15444E;
	Wed, 12 Jun 2024 15:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718205136; cv=none; b=kNRQY+avigFzvelUyFj/V3GJAyYGhEU+F+Q9/aznje9SeIL8eIOxhBBcvCn4R+9MoQtmkB1D4j9Lh1l6MzdRBP18JPusDoNqZfebfHEJHpzpjLQ6D/0Ze+upUEtP/cZ0J+/xaS5uJQcT8PS7mIeQjXF4s8pI+sMd1ps2hkvXkPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718205136; c=relaxed/simple;
	bh=WjhyEVrS4YOsT148Yx89pL+UkzPas9bEKkZhjJS5Oho=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=kIzghlzF12PdQ41E0muJiE9yYbpNXwAQc051GDxHa8/1qq5ZBfvJopaLANWLbArl687rr+V5Iue6LiO0b7QHHW35NHEiJ1D5p9ieCldPMBqEHP43gNi0to43u5ei7BomTEe0nSBSm9IQ1M+HN2tLE4wZ22l1MwZ8CImVtNmmLCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U9xbURPo; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718205135; x=1749741135;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=WjhyEVrS4YOsT148Yx89pL+UkzPas9bEKkZhjJS5Oho=;
  b=U9xbURPov/qbSTaDL2rVhzPlBZA1eEKoNe7JYU7QJAoHllyDOH8Ni/D1
   D0AV/v8d4itHREp6ExyoIrt37Yg291TG6mPWCmrysitaLOXjSLkZsWwJf
   e6YX9nTzv+1qSYTnwAfeliLx+jAkxIVzxrzLKDRMhCcanP3IUSHLUb+8u
   OZX1Dk41J8pweO3SjM08znDaGmGpjLF3MI6w3HqxCwfMCENdQYa6hC1RJ
   5vQssUnn8OQGiEXYeMZp9IgV/HekZkbhGc1D0OzGn0rdcIM06bA1/L+gu
   gB1dvkx2TdnjDAt0lbfKyFx1g5UTxk2R+OXSXOkYEFZhFtSfLAE/Ar/+X
   g==;
X-CSE-ConnectionGUID: Ltfxjm6yRc+LAV03ZV4Scw==
X-CSE-MsgGUID: /TS8zCxARyeE/2h67+oLvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="26394319"
X-IronPort-AV: E=Sophos;i="6.08,233,1712646000"; 
   d="scan'208";a="26394319"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 08:12:14 -0700
X-CSE-ConnectionGUID: kwDaRzc1TQiY9jarYnCxdg==
X-CSE-MsgGUID: 5Rrxm+96Skqw7TKKe3UrOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,233,1712646000"; 
   d="scan'208";a="40295494"
Received: from sj-4150-psse-sw-opae-dev2.sj.intel.com ([10.233.115.162])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 08:12:14 -0700
Date: Wed, 12 Jun 2024 08:12:05 -0700 (PDT)
From: matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@sj-4150-psse-sw-opae-dev2
To: Bjorn Helgaas <helgaas@kernel.org>
cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, bhelgaas@google.com, 
    krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
    joyce.ooi@intel.com, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] PCI: altera: support dt binding update
In-Reply-To: <20240611170410.GA989554@bhelgaas>
Message-ID: <alpine.DEB.2.22.394.2406120744350.662691@sj-4150-psse-sw-opae-dev2>
References: <20240611170410.GA989554@bhelgaas>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed



On Tue, 11 Jun 2024, Bjorn Helgaas wrote:

> On Tue, Jun 11, 2024 at 11:35:25AM -0500, matthew.gerlach@linux.intel.com wrote:
>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>
>> Add support for the device tree binding update. As part of
>> converting the binding document from text to yaml, with schema
>> validation, a device tree subnode was added to properly map
>> legacy interrupts. Maintain backward compatibility with previous binding.
>
> If something was *added* to the binding, I think it would be helpful
> to split that into two patches: (1) convert to YAML with zero
> functional changes, (2) add the new stuff.  Adding something at the
> same time as changing the format makes it hard to review.

Thanks for feedback. It was during the conversion to YAML that a problem 
with the original binding was discovered. As Rob Herring pointed out in
https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240513205913.313592-1-matthew.gerlach@linux.intel.com/

"Making the PCI host the interrupt parent didn't even work in the kernel
  until somewhat recently (maybe a few years now). That's why a bunch of PCI
  hosts have an interrupt-controller child node."

This was an attempt to fix the problem. I can resubmit a conversion to YAML 
with zero functional changes.

Matthew Gerlach


>
> Then we could have a more specific subject and commit log for *this*
> patch.
>
>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>> ---
>>  drivers/pci/controller/pcie-altera.c | 13 +++++++++++--
>>  1 file changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
>> index a9536dc4bf96..88511fa2f078 100644
>> --- a/drivers/pci/controller/pcie-altera.c
>> +++ b/drivers/pci/controller/pcie-altera.c
>> @@ -667,11 +667,20 @@ static void altera_pcie_isr(struct irq_desc *desc)
>>  static int altera_pcie_init_irq_domain(struct altera_pcie *pcie)
>>  {
>>  	struct device *dev = &pcie->pdev->dev;
>> -	struct device_node *node = dev->of_node;
>> +	struct device_node *node, *child;
>>
>>  	/* Setup INTx */
>> +	child = of_get_next_child(dev->of_node, NULL);
>> +	if (child)
>> +		node = child;
>> +	else
>> +		node = dev->of_node;
>> +
>>  	pcie->irq_domain = irq_domain_add_linear(node, PCI_NUM_INTX,
>> -					&intx_domain_ops, pcie);
>> +						 &intx_domain_ops, pcie);
>> +	if (child)
>> +		of_node_put(child);
>> +
>>  	if (!pcie->irq_domain) {
>>  		dev_err(dev, "Failed to get a INTx IRQ domain\n");
>>  		return -ENOMEM;
>> --
>> 2.34.1
>>
>

