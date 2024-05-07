Return-Path: <linux-pci+bounces-7196-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 318838BEDDB
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 22:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E01CB28442D
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 20:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A86E16EBED;
	Tue,  7 May 2024 20:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UtGykWW+"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB1216E86F
	for <linux-pci@vger.kernel.org>; Tue,  7 May 2024 20:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715112448; cv=none; b=aTh88jAqnsGmW4utjViUAvrXPqe3StELlNGrKSGlolaPByg9ddYc0+5Ta7pP+ZHK7kH4JQT2EW3jm2UAio8fZKp/0OiY/p0i2efCbUD2QnzuW6QOnAdTHtQxWi3yXvIAPqsF4t4tSDVTZDf2btZBhMcbAfmVSBm3OJkTMRXsxjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715112448; c=relaxed/simple;
	bh=Mc50FQ9sa791H2dMnsRK0GR1vGBbxHb1li3CAQ2ZdSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SbM19VVTH4PPb88/kEs3F8wwMdwJ2gJ1nX56vLJYp/I263aCX+znNpyDMJs10ALHgwwqvQgFa5xAQYpmbwfH8Pp13ATjMOmWf73YB6JIzJE8/EYEh3j/RpV8rOXXj4pafpK+6c0Gulpa6oOfkZX6/KY02MKrO2g+E5droeunsJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UtGykWW+; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a4347e43-06f7-4ede-b50f-554d1194a1f6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715112443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nt2uO6TpJx24xGPFvSzYImK2G9i5k2qnHj1h7z6S7Lg=;
	b=UtGykWW+noX7yFU08r1avJm7A81zlM2rR29tIloa0n2uR86TOf+TRIjG4Bp23h5dAh6GpO
	XZcLGHJc+2ahGxUgVCJJB+n+S0FA1+fHztZ8J5241liHKgdMkb3sy6vx5zUrLFcN7ba34M
	jVLuK0BJ7p2aluYRpfDvBx8wxZAG0kE=
Date: Tue, 7 May 2024 16:07:18 -0400
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/7] dt-bindings: pci: xilinx-nwl: Add phys
To: Rob Herring <robh@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 linux-pci@vger.kernel.org, Michal Simek <michal.simek@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 devicetree@vger.kernel.org
References: <20240506161510.2841755-1-sean.anderson@linux.dev>
 <20240506161510.2841755-2-sean.anderson@linux.dev>
 <20240507200640.GA955773-robh@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20240507200640.GA955773-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/7/24 16:06, Rob Herring wrote:
> On Mon, May 06, 2024 at 12:15:04PM -0400, Sean Anderson wrote:
>> Add phys properties so Linux can power-on/configure the GTR
>> transcievers.
>> 
>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>> ---
>> 
>> Changes in v2:
>> - Remove phy-names
>> - Add an example
>> 
>>  Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml | 6 ++++++
>>  1 file changed, 6 insertions(+)
>> 
>> diff --git a/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml b/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml
>> index 426f90a47f35..693b29039a9b 100644
>> --- a/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml
>> +++ b/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml
>> @@ -61,6 +61,10 @@ properties:
>>    interrupt-map:
>>      maxItems: 4
>>  
>> +  phys:
>> +    minItems: 1
>> +    maxItems: 4
> 
> I assume this is 1 phy per lane, but don't make me assume and define it.
> 
> Rob

It's one per lane. I'll add that to the description.

--Sean

