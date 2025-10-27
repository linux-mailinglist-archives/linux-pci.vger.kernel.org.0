Return-Path: <linux-pci+bounces-39471-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2BAC11AC7
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 23:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 452EB4E3183
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 22:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6672232C320;
	Mon, 27 Oct 2025 22:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="ZjepjOpg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-io1-f66.google.com (mail-io1-f66.google.com [209.85.166.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B7D327790
	for <linux-pci@vger.kernel.org>; Mon, 27 Oct 2025 22:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761603880; cv=none; b=Jg8I6O8MAIcvYkqa5eMUFmui/ZD9b+zbpnEQSAO1Ll5T047LKqW7vaQQXH/qQO9W0DQIJ04FMWfLSMmcHlLydf5a6b4WWhOI04w2OIdMpC0XSrtMssX1YxpbUL867O+SL1aoZUaJsB551ceSRNhOA6+edyroPIMEcFaqKGTP5+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761603880; c=relaxed/simple;
	bh=iuxmZjW37Mn2BUZtgE3HSKiakJo/wcKrte0uvUxagiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iQqOKQ1VJG7abzWVHMD8X8Mp5dq6vKWqlxYsjqqRmGL6jYxWnG03pID6zCdrNHRHAw16HdcSTE9QJEvD8O+ZCUhWrf00+O9cIbzh3ZXFkyYkmSSlblX3gzYMk/qhtfsO7RvyCP4LA1P64mkGe3qY6dpMbVlIaA+U5OdVAefPy0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=ZjepjOpg; arc=none smtp.client-ip=209.85.166.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f66.google.com with SMTP id ca18e2360f4ac-945a5731dd3so79399239f.0
        for <linux-pci@vger.kernel.org>; Mon, 27 Oct 2025 15:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761603877; x=1762208677; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wM5uwMP02IQy2fgQls6S0qQat4rqlu7HXn5+aaktR2Y=;
        b=ZjepjOpgc9CuwWiJxr7I3EX6++2/oY7Jg/sa43KdJMu1Sh4kRPF9yIHSfAgMdpQani
         75YRyLK4Jr+LcGPLuK/u/1rzjtwsQNQc+zxvgAse318//0201d7sy085YhN6u77H7fFC
         raRGzhXSKSFpQDK8frlFc8rq5hw3/8uNgtbRfA2WfnbPyyw103qzwPAOCt58UX9bZr9Z
         XqyJPLUiOspVJ3WsuRenUUzI/aO8GdFfs6Wufboahmma4gPKXVD8dBMrowB47aUkDbLN
         oqdJCd+99HDvQ4F8FzNDYYm5idFIKHjB32mgd/fluaGAl4Z6p3FFX8P01cdBRrGgtpq/
         ywDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761603877; x=1762208677;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wM5uwMP02IQy2fgQls6S0qQat4rqlu7HXn5+aaktR2Y=;
        b=dlwQLxR8Kjvf3XNo1XQTnW/E0odPl48SViAmfjuALOrzftVdjEYZ9gvqBtv+s4x+zj
         kY6WiUCbd3jPzFiEQfrT6nTw4mLRZ7f9XOKkrQRIHzSg521g+6dfgcUzQpIWpbjJIpxs
         V8NBSyReRU4qLXinkUNn5ZxhytVUBVXELcL6x7so09pjDztDyTDyy3onjhWNUDM8o+va
         36WiaSMcnRCQ6TwQkDi2KvZiMtRsQqcNhArWSL+CD0IpJJoSA1a2tQobr5ksQ5WpMKKk
         /IrEqw9yhqBvUhzR2A/xQMyMzbIWfjK8eJkxRClSxxY0Q3z9I0QDSoGONW5vWnSCG7Wl
         Ycsg==
X-Forwarded-Encrypted: i=1; AJvYcCU34ZWLF9PWIMghokB7gLeTC5x4DduIN2ebyjSkG4xbeJjx0CrPY/p8ALd2Y8oClCCVbg/hh+Lu/50=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcQTMFDuQhzuEV4z8kpu5sel1z0Re2jxNr3HvtfhG+siushGJ4
	1i3mUR49HBe+OJLy6Tngnj+uJhhTXWbXJxFU4LMqhVaFEEx1uebFEUc+8u+JM1Ylx1E=
X-Gm-Gg: ASbGncvoq+mLR4O+D0jmLH/eAhg9tNWlofQS7eXvjCztlypFCIdMcFXVqFdDM68VbSr
	FVkok1VjX/CBzIKCOoRRYaySeb1HSZCbsEx7+QhVLbnwQmbipV85+xqv70V4/AeTigiZZObBhvk
	ELrgEXenc8HUWQlxD90N1+JKhzmO+2lEfshq6sX5Y3tHROFeA23W80wU/+zFkmzhHeRcEuICCv4
	EG5yII/qzWcoS8lilV6Edm8Txm6IQqeQZUZpBOatiW8ajaGy9/nOjuSfHPpUxxjuDenjgoGpoQE
	Px5ciSII6qwtN5v4gUqBeqO3ZnbN5PBHvG2OSgVJCvU/y44rtCRx9HCw/ZZKGXe539KJ1KokXPQ
	W2PhcyATVcEh7uTALlDXQi68NtZQrBTZLta133Bdd2wOs4cQ1fTj/yDFXJM2toL/Kg1twv/E+Za
	B9ushqV1ail4ykd7Yfm73IShCKqAnhak/pQioEjiyNpy5G9yDGhuc=
X-Google-Smtp-Source: AGHT+IEJrN3+Xz84SulzDfIciOJjJZgogpTlOlzimDxgN5DQZNhrRyWMLSpNLPzrSBpfR6FKNexDlA==
X-Received: by 2002:a05:6e02:348f:b0:430:9bc3:e1d3 with SMTP id e9e14a558f8ab-4320f7be914mr26591695ab.12.1761603876603;
        Mon, 27 Oct 2025 15:24:36 -0700 (PDT)
Received: from [172.22.22.234] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-431f67dcb0csm35005605ab.5.2025.10.27.15.24.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 15:24:36 -0700 (PDT)
Message-ID: <ae92d3f4-5131-46be-b9b1-e8ec437c9ae9@riscstar.com>
Date: Mon, 27 Oct 2025 17:24:33 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] dt-bindings: pci: spacemit: introduce PCIe host
 controller
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
 vkoul@kernel.org, kishon@kernel.org, dlan@gentoo.org, guodong@riscstar.com,
 pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 p.zabel@pengutronix.de, christian.bruel@foss.st.com, shradha.t@samsung.com,
 krishna.chundru@oss.qualcomm.com, qiang.yu@oss.qualcomm.com,
 namcao@linutronix.de, thippeswamy.havalige@amd.com, inochiama@gmail.com,
 devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-phy@lists.infradead.org, spacemit@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251013153526.2276556-1-elder@riscstar.com>
 <20251013153526.2276556-4-elder@riscstar.com>
 <u53qfrubgrcamiz35ox6lcdpp5bbzfwcsic466z5r6yyx6xz3n@c64nw2pegtfe>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <u53qfrubgrcamiz35ox6lcdpp5bbzfwcsic466z5r6yyx6xz3n@c64nw2pegtfe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/26/25 11:38 AM, Manivannan Sadhasivam wrote:
> On Mon, Oct 13, 2025 at 10:35:20AM -0500, Alex Elder wrote:
>> Add the Device Tree binding for the PCIe root complex found on the
>> SpacemiT K1 SoC.  This device is derived from the Synopsys Designware
>> PCIe IP.  It supports up to three PCIe ports operating at PCIe gen 2
>> link speeds (5 GT/sec).  One of the ports uses a combo PHY, which is
>> typically used to support a USB 3 port.
>>
>> Signed-off-by: Alex Elder <elder@riscstar.com>
>> ---
>> v2: - Renamed the binding, using "host controller"
>>      - Added '>' to the description, and reworded it a bit
>>      - Added reference to /schemas/pci/snps,dw-pcie.yaml
>>      - Fixed and renamed the compatible string
>>      - Renamed the PMU property, and fixed its description
>>      - Consistently omit the period at the end of descriptions
>>      - Renamed the "global" clock to be "phy"
>>      - Use interrupts rather than interrupts-extended, and name the
>>        one interrupt "msi" to make clear its purpose
>>      - Added a vpcie3v3-supply property
>>      - Dropped the max-link-speed property
>>      - Changed additionalProperties to unevaluatedProperties
>>      - Dropped the label and status property from the example
>>
>>   .../bindings/pci/spacemit,k1-pcie-host.yaml   | 156 ++++++++++++++++++
>>   1 file changed, 156 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml b/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml
>> new file mode 100644
>> index 0000000000000..87745d49c53a1
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml
>> @@ -0,0 +1,156 @@
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
>> +      - description: Global reset; must be deasserted for PHY to function
>> +
>> +  reset-names:
>> +    items:
>> +      - const: dbi
>> +      - const: mstr
>> +      - const: slv
>> +      - const: phy
>> +
>> +  interrupts:
>> +    items:
>> +      - description: Interrupt used for MSIs
>> +
>> +  interrupt-names:
>> +    const: msi
>> +
>> +  phys:
>> +    maxItems: 1
>> +
>> +  vpcie3v3-supply:
>> +    description:
>> +      A phandle for 3.3v regulator to use for PCIe
> 
> Could you please move these Root Port specific properties (phy, vpcie3v3-supply)
> to the Root Port node?
> 
> Reference: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/pci/st,stm32-pcie-host.yaml

OK, I'll try to follow what that ST binding does (and the
matching driver).

> For handling the 'vpcie3v3-supply', you can rely on PCI_PWRCTRL_SLOT driver.
I looked at the code under pci/pwrctrl.  But is there some other
documentation I should be looking at for this?

It looks like it involves creating a new node compatible with
"pciclass,0604".  And that the purpose of that driver was to
ensure certain resources are enabled before the "real" PCI
device gets probed.

I see two arm64 DTS files using it:  x1e80100.dtsi and r8a779g0.dtsi.
Both define this node inside the main PCIe controller node.

Will this model (with the parent pwrctrl node and child PCI
controller node) be used for all PCI controllers from here on?

Or are you saying this properly represents the relationship of
the supply with the PCIe port in this SpacemiT case?

>> +
>> +  device_type:
>> +    const: pci
>> +
> 
> This is part of the PCI bus schema itself.

That means I don't have to specify it here.  I'll remove it.
I will also remove it from the list of required properties.

>> +  num-viewport:
>> +    const: 8
>> +
> 
> This property has been deprecated in favor of driver auto-detecting the iATU
> regions.

Yes, that got removed in v3 of the series.

Thanks.

					-Alex

> 
> - Mani
> 


