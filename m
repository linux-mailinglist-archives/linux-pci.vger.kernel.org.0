Return-Path: <linux-pci+bounces-6328-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF318A6E84
	for <lists+linux-pci@lfdr.de>; Tue, 16 Apr 2024 16:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 711BEB2571F
	for <lists+linux-pci@lfdr.de>; Tue, 16 Apr 2024 14:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37AB012D741;
	Tue, 16 Apr 2024 14:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FTyNhICr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8102712C52E;
	Tue, 16 Apr 2024 14:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713277985; cv=none; b=YWBm6morQ7Iqy/AYcPmXK3OXKCpw8zC3j/yjpyVncx9HaKtys7V+DpdvkqRmAFP8kNvWjoMrqM44zfzrKsCdKBepfXRFHII+YGzkgDnqzmJCzQNaJEzAQ6ZxSkEc4ZquQNA5QbSqHXmBwmlNAcjMHX5gS5YKzin055kpU7odBn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713277985; c=relaxed/simple;
	bh=SbzdP1AH6OgPsATD5J3vkA9ntkgZ4zZS5HmxfvGTu5I=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=O+W+OePXHkBMpQefvoi6809GzuESTFHAv7Ahy/1Wxia0Esb6q4nu7+ukKNxXes9DZM7FreXcCLm2kntvz56aIH7rf/QefA71wwXTKo+H6DNzYaFVyahkX1Vj/4hTqh7ILY3hjwYcJn4QfVxPZdIiGgPbaTqsdAKKEnGKqeuIEAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FTyNhICr; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713277984; x=1744813984;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=SbzdP1AH6OgPsATD5J3vkA9ntkgZ4zZS5HmxfvGTu5I=;
  b=FTyNhICrQy6qtfnNaVw/ePRrJNpZpj6bd6ab3ZI9BvCmy2b9od17Bn7l
   duTFGYjsYSoDmhBeW6J++6MTMvxjQGCGGoX1V6Us53XMc1tarp+2t5yQ7
   cG4Hw2ikHV8UC4qbakPaprWA15XYpMUXkgKxG3FChTMcifHL9+mQRDNB0
   t9zdR7CAB6gG2ef5AmNXP17g70b5q32hBobgFKEr23A5/mtkdyHIe3M19
   S1wbuXOL1YFtR7ZptnYNAfcbFQoT8MBlkW+SJMpxPgN9GueBSEeF6U63y
   UTvQFDp0Q0Mdr4mWBOwUgblqERrWAIrNBwACPvpSTjVtgOO0KCZPYmchN
   Q==;
X-CSE-ConnectionGUID: RMEKeY7vTr26/Ki+akK3Jw==
X-CSE-MsgGUID: njNXOqjWTLCdBA5Le9+kSA==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="8884823"
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="8884823"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 07:33:03 -0700
X-CSE-ConnectionGUID: 6tgnHvJKSWS5fRMPbFupLA==
X-CSE-MsgGUID: e/XnE5zKQYaC8e/6ZqIVtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="22748577"
Received: from sj-4150-psse-sw-opae-dev2.sj.intel.com ([10.233.115.162])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 07:33:02 -0700
Date: Tue, 16 Apr 2024 07:32:52 -0700 (PDT)
From: matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@sj-4150-psse-sw-opae-dev2
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, 
    krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
    linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: PCI: altera: Convert to YAML
In-Reply-To: <c21f6d49-bd70-465e-a446-fb70838bab48@linaro.org>
Message-ID: <alpine.DEB.2.22.394.2404160720360.424541@sj-4150-psse-sw-opae-dev2>
References: <20240413172641.436341-1-matthew.gerlach@linux.intel.com> <c21f6d49-bd70-465e-a446-fb70838bab48@linaro.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed



On Sun, 14 Apr 2024, Krzysztof Kozlowski wrote:

> On 13/04/2024 19:26, matthew.gerlach@linux.intel.com wrote:
>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>
>> Convert the device tree bindings for the Altera Root Port PCIe controller
>> from text to YAML.
>>
>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>
> ...
>
>> +allOf:
>> +  - $ref: /schemas/pci/pci-host-bridge.yaml#
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          enum:
>> +            - altr,pcie-root-port-1.0
>> +    then:
>> +      properties:
>> +        reg:
>> +          items:
>> +            - description: TX slave port region
>> +            - description: Control register access region
>> +
>> +        reg-names:
>> +          items:
>> +            - const: Txs
>> +            - const: Cra
>> +
>> +    else:
>> +      properties:
>> +        reg:
>> +          items:
>> +            - description: Hard IP region
>
> Why Hip is the first? Old binding suggested it to be the last entry. It
> would also make binding easier, as you describe reg and reg-names in
> top-level and just limit them with min/maxItems.
>
> Does anything depend on different order (Hip as first)?

I don't think the order really matters. So Hip could go last, and it makes 
sense to only mention the reg/reg-names once in the top and then add 
limits with min/maxItems in the allOf section.

Thanks for the feedback,
Matthew Gerlach

>
>> +            - description: TX slave port region
>> +            - description: Control register access region
>> +
>> +        reg-names:
>> +          items:
>> +            - const: Hip
>> +            - const: Txs
>> +            - const: Cra
>> +
>
>
> Best regards,
> Krzysztof
>
>

