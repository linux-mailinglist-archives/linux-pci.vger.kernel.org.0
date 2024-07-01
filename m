Return-Path: <linux-pci+bounces-9547-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD93D91EAC6
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 00:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72D2B1F21A44
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 22:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCDF85923;
	Mon,  1 Jul 2024 22:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VhYTboMk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5247538394;
	Mon,  1 Jul 2024 22:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719872384; cv=none; b=pgm57OX1uLH1AeQjxjIgeg3ZzKN9ZEpXfc+lsiP+VOdDPiq8bxO3R5jRuuo0xJGRW1bxMrqIzCGLbsmU/1Kq7j1hUvqOGnk/8vxZ5Hef9oto6jM57gqyONHvL2EZVT6cFe0yPpByy0oxywiwO7x63AJFFSwDY2o5N79JTWm2M4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719872384; c=relaxed/simple;
	bh=oTe6pp84cdG5j4yQ9X9fQZvdeb7qLRuCIJkf/86nbP4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BqG7TZa58dfvtBwVF/FbivEI2ddfyp81uENMQijSaHKH2MCCfUo+4oc2UM7jqPVExhjuWuDVX97nngY/q5wJ6zAtRB+Mfa7LeWCt8st3iv2qAyRki8qwopDDknr56lGZiUKpK43HGbFxxrG3abFDica867f47XpzgLCye/9V6mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VhYTboMk; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719872383; x=1751408383;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=oTe6pp84cdG5j4yQ9X9fQZvdeb7qLRuCIJkf/86nbP4=;
  b=VhYTboMkU8gn3ckBb13GOLeTRFdv43WZlqw84WHNf4mB3p7jBWbhrt3t
   s5QCNkWh2aVMTGQEP5RZKKora4L6SA4QxIFYg7Z1h8ANYM/8EnZig/g2h
   m7X6mtgxwn4PIayynv6RD9bNxVKjADzAlEsa5Z+HlaAstBxbUqwjHYL3W
   F/Q8miCXVE9Flwbw76CvwueTOvBb+347xDrMTtHDjXy1qv7mJxG9zfWZt
   H11R46HuBSeS4Em+Ej4TpdJ59LkjK6cMIi9OVkU9JsZOCEsF1AEbVYWu7
   AVbkUQrLOUcIkzXWFJW3C9ny2eb2UlBa65nSIG3Zd5skmLFFpEpb+2Rpj
   g==;
X-CSE-ConnectionGUID: 4pFGYcLIS1eysnFF25Y2MA==
X-CSE-MsgGUID: Ia+KmjtZSaau9mlLmBIRXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="17165146"
X-IronPort-AV: E=Sophos;i="6.09,177,1716274800"; 
   d="scan'208";a="17165146"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 15:19:42 -0700
X-CSE-ConnectionGUID: vkPELPRFS9qoJF7OpJ4mJg==
X-CSE-MsgGUID: Dg0YZb/QS/yenlP5pesyKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,177,1716274800"; 
   d="scan'208";a="83216803"
Received: from sj-4150-psse-sw-opae-dev2.sj.intel.com ([10.233.115.162])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 15:19:41 -0700
Date: Mon, 1 Jul 2024 15:19:31 -0700 (PDT)
From: matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@sj-4150-psse-sw-opae-dev2
To: Conor Dooley <conor@kernel.org>
cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, bhelgaas@google.com, 
    krzk+dt@kernel.org, conor+dt@kernel.org, joyce.ooi@intel.com, 
    linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7] dt-bindings: PCI: altera: Convert to YAML
In-Reply-To: <20240627-finer-expel-2c7ab9f05733@spud>
Message-ID: <alpine.DEB.2.22.394.2407011517270.757537@sj-4150-psse-sw-opae-dev2>
References: <20240614163520.494047-1-matthew.gerlach@linux.intel.com> <20240627-finer-expel-2c7ab9f05733@spud>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed



On Thu, 27 Jun 2024, Conor Dooley wrote:

> Been stalling replying here, was wondering if Rob would look given he
> reviewed the previous versions.
>
> On Fri, Jun 14, 2024 at 11:35:20AM -0500, matthew.gerlach@linux.intel.com wrote:
>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>
>> Convert the device tree bindings for the Altera Root Port PCIe controller
>> from text to YAML. Update the entries in the interrupt-map field to have
>> the correct number of address cells for the interrupt parent.
>>
>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>> diff --git a/Documentation/devicetree/bindings/pci/altera-pcie.txt b/Documentation/devicetree/bindings/pci/altera-pcie.txt
>> deleted file mode 100644
>> index 816b244a221e..000000000000
>> --- a/Documentation/devicetree/bindings/pci/altera-pcie.txt
>> +++ /dev/null
>> @@ -1,50 +0,0 @@
>> -* Altera PCIe controller
>> -
>> -Required properties:
>> -- compatible :	should contain "altr,pcie-root-port-1.0" or "altr,pcie-root-port-2.0"
>> -- reg:		a list of physical base address and length for TXS and CRA.
>> -		For "altr,pcie-root-port-2.0", additional HIP base address and length.
>> -- reg-names:	must include the following entries:
>> -		"Txs": TX slave port region
>> -		"Cra": Control register access region
>
>> -		"Hip": Hard IP region (if "altr,pcie-root-port-2.0")
>
> I think this should be constrained in the new yaml binding by setting
> maxItems: for reg/reg-names to 2 for 1.0 and, if I am not
> misunderstanding what "must include" means, minItems: to 3 for 2.0.

Your understanding is correct. Your suggestion makes the binding more 
precise, and I will implement it in v8.

Thanks for the feedback,

Matthew Gerlach

>
> Thanks,
> Conor.
>
>> diff --git a/Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml b/Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml
>> new file mode 100644
>> index 000000000000..0aaf5dbcc9cc
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml
>> @@ -0,0 +1,93 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +# Copyright (C) 2015, 2019, 2024, Intel Corporation
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/altr,pcie-root-port.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Altera PCIe Root Port
>> +
>> +maintainers:
>> +  - Matthew Gerlach <matthew.gerlach@linux.intel.com>
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - altr,pcie-root-port-1.0
>> +      - altr,pcie-root-port-2.0
>> +
>> +  reg:
>> +    items:
>> +      - description: TX slave port region
>> +      - description: Control register access region
>> +      - description: Hard IP region
>> +    minItems: 2
>> +
>> +  reg-names:
>> +    items:
>> +      - const: Txs
>> +      - const: Cra
>> +      - const: Hip
>> +    minItems: 2
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  interrupt-controller: true
>> +
>> +  interrupt-map-mask:
>> +    items:
>> +      - const: 0
>> +      - const: 0
>> +      - const: 0
>> +      - const: 7
>> +
>> +  interrupt-map:
>> +    maxItems: 4
>> +
>> +  "#interrupt-cells":
>> +    const: 1
>> +
>> +  msi-parent: true
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - reg-names
>> +  - interrupts
>> +  - "#interrupt-cells"
>> +  - interrupt-controller
>> +  - interrupt-map
>> +  - interrupt-map-mask
>> +
>> +allOf:
>> +  - $ref: /schemas/pci/pci-host-bridge.yaml#
>

