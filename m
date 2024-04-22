Return-Path: <linux-pci+bounces-6542-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7BE8AD688
	for <lists+linux-pci@lfdr.de>; Mon, 22 Apr 2024 23:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 602941C21138
	for <lists+linux-pci@lfdr.de>; Mon, 22 Apr 2024 21:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB4C1CABF;
	Mon, 22 Apr 2024 21:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mWuX9Kg/"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87805EAC7
	for <linux-pci@vger.kernel.org>; Mon, 22 Apr 2024 21:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713821414; cv=none; b=IZQGbz+D13LK6S3hQoJEpa2CEzXaPIBcXF7uj/XJ8ASmd17+bmmhbKlp0MqXdGvkGyWk8qfbhWxM8t6lCFJVP/81oHUe72X6v76NToJv6JKKqllSQ19NYPJ4U+VQi4X6m31xb5IbcWB1/MuycWPw3kS/ihPHobqHIs+3o/L2HO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713821414; c=relaxed/simple;
	bh=Ku1DGEy0db+OnEa5w7PseS2QxxW9d5ZfsbNmxLSkJk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HyjUXo6KZyIxMg+w7Y7xUI/tS5d6hbiZXfz3bMoJpJLi8iCR/DclZ/sgUa4nnJxQ15cZ8+XRHA2i9fdJUHpGz0y79T1rAwKwkMaR7FWSyKc/zXyMHFrR5GxZZPDqNBBAhINCz7lnxyPP+PbKDcB3Y4erjFxeW5zuuoj8RQiTgzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mWuX9Kg/; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <173a7bb2-5473-4c1b-b3dd-ef776e63ac7a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713821410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nH11/CXhaPQDxPvStD1h8S0lo64PkavloRKwmStdkfE=;
	b=mWuX9Kg/JSi1GlYagbN/iSGyHb/7PXLCjJlVe2ffi1+IfdKuKtnzjNx4prIYV7NtPx33eP
	8B5u1AI13YXJt+teLHVOvg75/U1S+3pRwtbXlsY/OMJnyiEvQkkBySvgFP0vw/MxqUcOGj
	Qy2HIzwX+531fGEzPAj3ctd1ecHdlnk=
Date: Mon, 22 Apr 2024 17:30:06 -0400
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/7] dt-bindings: pci: xilinx-nwl: Add phys
To: Rob Herring <robh@kernel.org>
Cc: Michal Simek <michal.simek@amd.com>,
 Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 devicetree@vger.kernel.org, Lorenzo Pieralisi <lpieralisi@kernel.org>
References: <20240422195904.3591683-1-sean.anderson@linux.dev>
 <20240422195904.3591683-2-sean.anderson@linux.dev>
 <171382130333.1986303.15938018699322126426.robh@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <171382130333.1986303.15938018699322126426.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/22/24 17:28, Rob Herring wrote:
> 
> On Mon, 22 Apr 2024 15:58:58 -0400, Sean Anderson wrote:
>> Add phys properties so Linux can power-on/configure the GTR
>> transcievers.
>> 
>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>> ---
>> 
>>  Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>> 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml: properties:phy-names: {'maxItems': 4, 'items': [{'pattern': '^pcie-phy[0-3]$'}]} should not be valid under {'required': ['maxItems']}
> 	hint: "maxItems" is not needed with an "items" list
> 	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240422195904.3591683-2-sean.anderson@linux.dev
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
> 

This warning is invalid, since I am using pattern with items.

--Sean

