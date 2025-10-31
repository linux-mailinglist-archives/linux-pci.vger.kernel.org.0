Return-Path: <linux-pci+bounces-39882-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F48C22E44
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 02:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E4393ABC39
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 01:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE90256C6D;
	Fri, 31 Oct 2025 01:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="uXty7MD2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-il1-f196.google.com (mail-il1-f196.google.com [209.85.166.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8957324BBEC
	for <linux-pci@vger.kernel.org>; Fri, 31 Oct 2025 01:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761874642; cv=none; b=pb1uLx7/OM7++53c+58qBtmVJ/POmFnvMta8Ln3Jo0TuA0blfDUELAOo3ZB/UUri49TaJaC4Mn6eqcW8QiMA1gZeW+EItJlFS7GEYCpTogmU65jNnvhJ3xN4KcpWcn6RmErlO1PDw7GI1Cd+um1laUF6/A8tyiI6/acOwVC5iuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761874642; c=relaxed/simple;
	bh=nQ29tceSmQ4urDG0IsVFtbhp5svpPgNTCQfprJofihs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Son6UUULesDy94Bd/lEIGEn58vNuX1FJj7Cpl0Ow+XSCYVdJ8uzjDx/8tI7cJ1KWFU60pqGe0x2t5GXCvdWBoL6/m6rmPPL4QiNv2Z9HXSrA2FSqds300xYeavPPitZx41CsAmHIUnvCK1vR0OzbCPh+q/Wzg8DacMw2eHAKnb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=uXty7MD2; arc=none smtp.client-ip=209.85.166.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f196.google.com with SMTP id e9e14a558f8ab-4330d2ea04eso2500355ab.3
        for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2025 18:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761874638; x=1762479438; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MZXfwu/E+BC+JAhEUtk1GdLUOAn+XEVcnmRSn9TxWj8=;
        b=uXty7MD2IMXtj/z2YgEmQfmOPcGb9VBgZY/cYAYCiYEDpIyToMZuA/kRHfE+ZGDyHs
         hdfQ3+3WdJ/gW8+b7OAW4wP5DWCqtCUQGauVyV+uvF6s+BkY0rmrkqo/pYXc0UMOnP4H
         FmUmzIeQJx7ezApiDcl7829rTv6xNoXJHBrYibXPoPn1gpzR8oUGHQWLPH/KjHOQtGwc
         NYE721SFaQmAa3WWk1B2jV8vpvUwk5DBu51p+vPi5M0hKDgOaE+gTAwKIqCAyO86ylaW
         Fwxhw0mOMG3vArfRVV8Q1AenBBgtGrcmCbYIpB+yOIN7tjtL+/YMuSQx+/S/94X1Fpdi
         tTDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761874638; x=1762479438;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MZXfwu/E+BC+JAhEUtk1GdLUOAn+XEVcnmRSn9TxWj8=;
        b=NebuDAE2ePjEBeOYNjjmpxoyGPAc62oFlJuTUL8DHzccE87uZX3glKYimvGaCrAul8
         2UUcVWXDDVlLCqE2Kr9dMkZTrsqMQ1WY2I/orlqzzL1WPbeRaJh8ifiuvUtuuYjJjycx
         8ehUCcZKkqhuPX8eq6T5ZmVG8ismkzC3CQyZOpJmWdDmZTbRXYB/DANuZJSzwZO5VcoO
         eHkqlIVUXg6ZJS1mbRxoe6tUtnCopC5DoBLZq5NWAKpRfvl/8epe16kfVQDwcJT+3E9j
         V4AnU/qasG7+sg+8PRUc9UJfJzIG0jXuEFf7Qh3xJ9/8mvPzcHgxtfKSihrJ7tz/BW9K
         slnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXV1EXO5Wz+zetzJEMrLdfJIQrNOjpKPUZNcX4amH9Jq1+4NuSgnCbVPy9HDMRpj9oYbJwCA+9DL0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsPTH5s8oCkksQZnXhXbaL1UPVj9xsT3+CFUpqEIvBymui9CLW
	WK5GCR0JzNT1vZq0rnHZpt0XzON6dstGViNO6xQB0rPELJioX3NzYvJbHXJED+xCtAc=
X-Gm-Gg: ASbGnctt3Pw9mvpzKNzBRtjdL4LLeTmIa/p7goJohrkMrx4rADoIHsnNZ4VyOZAaWYe
	mXhTTJ3v0aWG6r98tSj4gsCqOfv3he2UvE90t+7wvWqXRSjItixqPNZZtZg+k7f+QQgx6u/BoVA
	Pa2raLApri2HB9XAdP9qWbn4cMyLnTMUuKTJU+qylqdlBraS+vvaNzxYm3g+xVX6sZMBTxBHtyt
	o0XJv1QKRj9LsKg4nhx0XgMwUTv3C2smHBCwl1O3Zt+6poTBGgzsR101yAF2V1WrZtPoy6yDwSJ
	hUBW0AzLMH/Bg+9JryATWL3l12jSWJHpo/bVvZspMRUp6YD/vM9WK+BvudXwkOgLWyX4dc9kkQe
	L3XJBPHGti5Vob/IcDKA4ySSbgP2gdd7kf94kHRAVxeShZ1ZndWGi+PwksXwiQO+q0FDH8w0eKL
	w2n7NWKE/0gOmOgNpYUYm1jhF1PblztP7KiD2PIDZw
X-Google-Smtp-Source: AGHT+IF8jKPMcN4haMJfj2iiZ24svqDtow1spkbfII1MB862Q9VVregRX2uRZw72R6OIomLop1+AMQ==
X-Received: by 2002:a05:6e02:b27:b0:430:af13:accc with SMTP id e9e14a558f8ab-4330d1280afmr28635775ab.7.1761874638596;
        Thu, 30 Oct 2025 18:37:18 -0700 (PDT)
Received: from [172.22.22.234] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-43310245c34sm1321815ab.2.2025.10.30.18.37.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 18:37:18 -0700 (PDT)
Message-ID: <9e60f7ed-7afc-4151-a301-4a0832b9105f@riscstar.com>
Date: Thu, 30 Oct 2025 20:37:16 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/7] dt-bindings: pci: spacemit: introduce PCIe host
 controller
To: Rob Herring <robh@kernel.org>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, bhelgaas@google.com,
 lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 dlan@gentoo.org, guodong@riscstar.com, devicetree@vger.kernel.org,
 linux-pci@vger.kernel.org, spacemit@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251030220259.1063792-1-elder@riscstar.com>
 <20251030220259.1063792-4-elder@riscstar.com>
 <20251031005718.GA539812-robh@kernel.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20251031005718.GA539812-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/30/25 7:58 PM, Rob Herring wrote:
> On Thu, Oct 30, 2025 at 05:02:54PM -0500, Alex Elder wrote:
>> Add the Device Tree binding for the PCIe root complex found on the
>> SpacemiT K1 SoC.  This device is derived from the Synopsys Designware
>> PCIe IP.  It supports up to three PCIe ports operating at PCIe gen 2
>> link speeds (5 GT/sec).  One of the ports uses a combo PHY, which is
>> typically used to support a USB 3 port.
>>
>> Signed-off-by: Alex Elder <elder@riscstar.com>
>> ---
>>   .../bindings/pci/spacemit,k1-pcie-host.yaml   | 157 ++++++++++++++++++
>>   1 file changed, 157 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml b/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml
>> new file mode 100644
>> index 0000000000000..58239a155ecc0
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml
>> @@ -0,0 +1,157 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/pci/spacemit,k1-pcie-host.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: SpacemiT K1 PCI Express Host Controller
>> +
>> +maintainers:
>> +  - Alex Elder <elder@riscstar.com>
>> +
>> +description: >
>> +  The SpacemiT K1 SoC PCIe host controller is based on the Synopsys
>> +  DesignWare PCIe IP.  The controller uses the DesignWare built-in
>> +  MSI interrupt controller, and supports 256 MSIs.
> 
> Wrap lines at 80.

OK.

>> +
>> +allOf:
>> +  - $ref: /schemas/pci/snps,dw-pcie.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    const: spacemit,k1-pcie
>> +
>> +  reg:
>> +    items:
>> +      - description: DesignWare PCIe registers
>> +      - description: ATU address space
>> +      - description: PCIe configuration space
>> +      - description: Link control registers
>> +
>> +  reg-names:
>> +    items:
>> +      - const: dbi
>> +      - const: atu
>> +      - const: config
>> +      - const: link
>> +
>> +  clocks:
>> +    items:
>> +      - description: DWC PCIe Data Bus Interface (DBI) clock
>> +      - description: DWC PCIe application AXI-bus master interface clock
>> +      - description: DWC PCIe application AXI-bus slave interface clock
>> +
>> +  clock-names:
>> +    items:
>> +      - const: dbi
>> +      - const: mstr
>> +      - const: slv
>> +
>> +  resets:
>> +    items:
>> +      - description: DWC PCIe Data Bus Interface (DBI) reset
>> +      - description: DWC PCIe application AXI-bus master interface reset
>> +      - description: DWC PCIe application AXI-bus slave interface reset
>> +
>> +  reset-names:
>> +    items:
>> +      - const: dbi
>> +      - const: mstr
>> +      - const: slv
>> +
>> +  interrupts:
>> +    items:
>> +      - description: Interrupt used for MSIs
>> +
>> +  interrupt-names:
>> +    const: msi
>> +
>> +  spacemit,apmu:
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +    description:
>> +      A phandle that refers to the APMU system controller, whose
>> +      regmap is used in managing resets and link state, along with
>> +      and offset of its reset control register.
>> +    items:
>> +      - items:
>> +          - description: phandle to APMU system controller
>> +          - description: register offset
>> +
>> +patternProperties:
>> +  '^pcie?@':
> 
> It's always PCIe, so drop the '?'.

I'll fix that.

> With that,
> 
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

Thanks for the review.

					-Alex

