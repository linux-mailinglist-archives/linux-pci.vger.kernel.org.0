Return-Path: <linux-pci+bounces-21632-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF26BA3880D
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 16:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20A3C1882EC1
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 15:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F834149E16;
	Mon, 17 Feb 2025 15:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h12iOGhr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FEF148FE6;
	Mon, 17 Feb 2025 15:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739807271; cv=none; b=JPo2Ty/Jwb0xBbKuuMClKurQHGv6RzOzu7JGyoNfZ9jczr14aaoTTYdjB57iUNTbxjMs5jDv/cMpMf8YHrTPhr6lcO/B7iMb4dQDLCHkwiNLh0y0NJp5ddD2OGSWz9ZW3ullF72wzShlXNIuWepNUfe1Dpcccue05GfmL4fdGZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739807271; c=relaxed/simple;
	bh=Jg4b5scquHVll3QK/t2HTEm164tAsSFt/MOKwjNMrfM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FbjBiQhWoJgz0k9ZxLLQT4Q2we6S/2DTHiUY8kX0/EvAJ8W6XFQvTQc+ZvzMZvIPdrOXZgVVYk+6NxJSvs7jj+ZEUbY/J6IcqwJTt6FcGmgSa/d44H56apuxLigZgLnsxrZPAzy2RSC289mk8UV737MAED5Uj9XV3Z8LDRy9Z1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h12iOGhr; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739807270; x=1771343270;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Jg4b5scquHVll3QK/t2HTEm164tAsSFt/MOKwjNMrfM=;
  b=h12iOGhrUpsvuZQPz8SHbvVHFjs77osicdvAizyu42i7jAItZX7Z5Lek
   /FHKE0euZXt7MZCqpjMeRMV6SeTWlDGwynQr2MGcOmFTdbuHnMbALq4A5
   EUy5zWjQCXoq3/FHLhbPCQLrBSbyuO1XDI+zLXAMH8bzCQ2GVpR/rJwlZ
   xbabeQrA4ilVDwplmgeyBw94Fosg3uSf2N+ef+9xyzMWcIDi5YirRXo1t
   AvaK4JOS+SnrfjEC76EoqMKyEwHN1F+Lz3i2jdy/kX/VJZ4gYbWP+K3hN
   oSHNPEYlZbDk3RfYr6ZOSyPDMdRo6gOEgSz9R1YLuLKIREnnPD4URGxQf
   Q==;
X-CSE-ConnectionGUID: gU/6yvJ0QUWrIZBOQqMHkQ==
X-CSE-MsgGUID: kWf3sVZZRzitnWRygDt/Lg==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="44252024"
X-IronPort-AV: E=Sophos;i="6.13,293,1732608000"; 
   d="scan'208";a="44252024"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 07:47:50 -0800
X-CSE-ConnectionGUID: 10ktuiBpTsmJVEBpiiiwFg==
X-CSE-MsgGUID: 5/Xb2eNSQO2T21iUbJpXsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,293,1732608000"; 
   d="scan'208";a="114086272"
Received: from sj-2308-osc3.sj.altera.com ([10.244.138.69])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 07:47:49 -0800
Date: Mon, 17 Feb 2025 07:47:48 -0800 (PST)
From: matthew.gerlach@linux.intel.com
To: Krzysztof Kozlowski <krzk@kernel.org>
cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org, 
    robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org, 
    conor+dt@kernel.org, dinguyen@kernel.org, joyce.ooi@intel.com, 
    linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
    linux-kernel@vger.kernel.org, matthew.gerlach@altera.com, 
    peter.colberg@altera.com
Subject: Re: [PATCH v7 2/7] dt-bindings: intel: document Agilex PCIe Root
 Port
In-Reply-To: <20250216-ubiquitous-agile-spoonbill-cf12ab@krzk-bin>
Message-ID: <dcd28035-6ba8-5d67-daa3-26812c4fc99d@linux.intel.com>
References: <20250215155359.321513-1-matthew.gerlach@linux.intel.com> <20250215155359.321513-3-matthew.gerlach@linux.intel.com> <20250216-ubiquitous-agile-spoonbill-cf12ab@krzk-bin>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed



On Sun, 16 Feb 2025, Krzysztof Kozlowski wrote:

> On Sat, Feb 15, 2025 at 09:53:54AM -0600, Matthew Gerlach wrote:
>> The Agilex7f devkit can support PCIe End Points with the appropriate
>> daughter card.
>>
>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>> ---
>> v7:
>>  - New patch to series.
>> ---
>>  Documentation/devicetree/bindings/arm/intel,socfpga.yaml | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/intel,socfpga.yaml b/Documentation/devicetree/bindings/arm/intel,socfpga.yaml
>> index 2ee0c740eb56..0da5810c9510 100644
>> --- a/Documentation/devicetree/bindings/arm/intel,socfpga.yaml
>> +++ b/Documentation/devicetree/bindings/arm/intel,socfpga.yaml
>> @@ -20,6 +20,7 @@ properties:
>>                - intel,n5x-socdk
>>                - intel,socfpga-agilex-n6000
>>                - intel,socfpga-agilex-socdk
>> +              - intel,socfpga-agilex7f-socdk-pcie-root-port
>
> Compatible should represent the board, so what is here exactly the
> board? 7f? Agilex7f? socdk? Or is it standard agilex-socdk but with some
> things attached?

The board is the Agilex 7 FPGA F-Series Transceiver-Soc Development Kit:
https://www.intel.com/content/www/us/en/products/details/fpga/development-kits/agilex/si-agf014.html

There is not a single, standard agilex-socdk board. There are currently 
three variants. In addition to the F-Series socdk, there are I-Series and 
M-Series devkits:
https://www.intel.com/content/www/us/en/products/details/fpga/development-kits/agilex/si-agi027.html
https://www.intel.com/content/www/us/en/products/details/fpga/development-kits/agilex/agm039.html

>
> But then, are they attached or you just creat the same board with
> different configuration?
The PCIe Root Port does involve a different FPGA configuration, but 
depending on the board, daughter cards and possibly cables are also 
involved.

>
> Best regards,
> Krzysztof
>
>
Thanks for the feedback,
Matthew Gerlach

