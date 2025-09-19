Return-Path: <linux-pci+bounces-36539-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FF4B8B2CF
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 22:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91748A03279
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 20:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDF82BE62B;
	Fri, 19 Sep 2025 20:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="jATh2H/C"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F1428314D
	for <linux-pci@vger.kernel.org>; Fri, 19 Sep 2025 20:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758312852; cv=none; b=Pf0E2Dof5EpOj0vCuS2bNU0z7wEaEm15M9Y8JeXxDP4y70QhVsc+olpzpsXsHrJdl+MBKTyDQjopcKOhEuquG/zqYtU54DVT5Eg8XescH5mqtS+KPgULqXZqbYqZeUQpD3TTOhMQbjYTm2VEUTav1UHqHx8xb3I4DE2jSq2kCRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758312852; c=relaxed/simple;
	bh=VRK+pmEe7PbC45zTMGIrHgpzmAUjzNw9/dwoa9Zpgsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i312VDRsuwGTMi2vs6AUpmmgf7hrKDo/speI0gsSO9Wcmy3scyjw0fI8uAfIxL8iTADr+eA3DpPNGVmiULj9WHxRFTcIfiiGZ6k/9Yzm15DYgy7YRaqilm8j70eM+31P7VBtaPgeOKVim9ncH2/1uDKf3VpzlDu8inz70jgG490=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=jATh2H/C; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-88428b19ea9so119872439f.0
        for <linux-pci@vger.kernel.org>; Fri, 19 Sep 2025 13:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1758312848; x=1758917648; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=laoMcSCfK07azaBjCslDo0m3+R/kL+S83GK1yKfDxF8=;
        b=jATh2H/CRu5A3jcxiBkzcaOrJ4L/RLHdXp4FdZxhSTfIM9Ek0j9tTCIXSj1fg2hfZ0
         B+sgsn8GEyRoYlHkVvbU9WniFM1o0CYGhEjds8CLrvhAWesk7nffhU+WCxXeBGyt6mZr
         e9mtVXTsLcZuLLzJ6346cAzsmueflgmRv8u2SK1IwD0ddKroRFD5rgtYAFyxXFCPcPjZ
         LtSEzDeM/KGZrmD509l8TB6iZ6XQjbio9GU+FebDjwWAVXSnosZhXNyjVUey2QWcFE3o
         QLfHCtC8Q4IRta9EprRaS5T5CQHhS9sIST8QqaytEKYVmCS1BCMVKvB01g4uF5T5jYvW
         gkJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758312848; x=1758917648;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=laoMcSCfK07azaBjCslDo0m3+R/kL+S83GK1yKfDxF8=;
        b=xARRaXuikihHr1agq31wdgzkQaW9xN482SjRKtwugEoBVLDX84DZenKay7dcBJte7p
         hXFmotq752R/KXxTFzTGxkjYlSyzgCZJTzZgr/kuh78QXYZLYhG2Icj6M2EwkzzsKRye
         LnfQFMFtohjRgA+wShwf7voNpHdt6Gqel4YHJYYtvChyl3j8y7QtNf36Hi+Oefi1RJaN
         7QT5ozxQVQslg3zEtHKsmFU6gHtgRIkIYYiFA5tWhQEC8AQZNSaORU1IzmS7ZrLyN4wO
         ePlp24cWX6IeV3/IKWbrYM9W4R62jAe8ihNmPW064UZhCa2i3MBJ9cpIb4eYoWrOzD6T
         6apQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgg29u1KrTnAhdFdVbEWIcN9B35UTph/0HbHSUL0EW082iH9UUXTdUX1YRyKoJOGU9bt5Ug10bYBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YznNrIpSphCkpP5hx2VLSykLesZwJLWf+LJ2RRj5ld6sRo9JwlE
	/7ujUGx60yOpBsmiaKQhI+SUSVlDi6L0mj9toKtf5WqN+F+FLtJNH23hVTJkgy6WzTg=
X-Gm-Gg: ASbGncuVRqcAzXph+yvdvOWSeX/FcpQruradbnXXy2eRzzl35Q/UJOgX145wqdGuHBs
	FFgXh663J674rnw2DjGwDdVInPT9euMUXnx8NQLO9foN+NXjHwr+PuQiPfEemDWUSh5E6CvPM/C
	bygUJjntpzu//lkw02nMhJylLxENubiFEFW+P129MhuJrbkgZxP5tGw5tfw2DKIt5rqaBPeoEUy
	ksEEEEld6eIlJUWeDLt8NCuuAboGbEGveVCY3x2HUcMCu+2YtF+q6Xh1f3YiBjTWCBfqNmyQ0XJ
	nnnRkZiVQWihew9a4NjE3u/F1gHJKDuZkMODZooOtnALGm7KrWXIik3SmF5AJ8+T6eJyrTI9MG5
	gpaSfDGJSNysfOlKZno4gwvGbc/KBZY1umPGojwY+IpTpNSxlLA/E2C74riVgDw==
X-Google-Smtp-Source: AGHT+IF/1Bf6FjG2s85ZEcZvlS57Mzf5kDdUZySVUGALWKCNyJGWzPVLZfqNWOxGh/9d2jvI0LV4rw==
X-Received: by 2002:a05:6e02:2163:b0:424:2c9:26b5 with SMTP id e9e14a558f8ab-42441af5e02mr127967325ab.9.1758312847889;
        Fri, 19 Sep 2025 13:14:07 -0700 (PDT)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-53d5399014dsm2475887173.59.2025.09.19.13.14.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Sep 2025 13:14:07 -0700 (PDT)
Message-ID: <804ea57f-699f-41cc-a27c-844f107e627f@riscstar.com>
Date: Fri, 19 Sep 2025 15:14:05 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] dt-bindings: phy: spacemit: introduce PCIe root
 complex
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
 vkoul@kernel.org, kishon@kernel.org, dlan@gentoo.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 alex@ghiti.fr, p.zabel@pengutronix.de, tglx@linutronix.de,
 johan+linaro@kernel.org, thippeswamy.havalige@amd.com, namcao@linutronix.de,
 mayank.rana@oss.qualcomm.com, shradha.t@samsung.com, inochiama@gmail.com,
 quic_schintav@quicinc.com, fan.ni@samsung.com, devicetree@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
 spacemit@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250813184701.2444372-1-elder@riscstar.com>
 <20250813184701.2444372-4-elder@riscstar.com>
 <tmdq6iut5z2bzemduovvyarya6ho2lwlxvvqqhazw6dnnyjpq3@72xrd2pij42h>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <tmdq6iut5z2bzemduovvyarya6ho2lwlxvvqqhazw6dnnyjpq3@72xrd2pij42h>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/15/25 3:14 AM, Manivannan Sadhasivam wrote:
> On Wed, Aug 13, 2025 at 01:46:57PM GMT, Alex Elder wrote:
> 
> Subject should have 'pci' prefix, not 'phy'.

OK I'll update that in the next version.

>> Add the Device Tree binding for the PCIe root complex found on the
>> SpacemiT K1 SoC.  This device is derived from the Synopsys Designware
>> PCIe IP.  It supports up to three PCIe ports operating at PCIe gen 2
>> link speeds (5 GT/sec).  One of the ports uses a combo PHY, which is
>> typically used to support a USB 3 port.
>>
>> Signed-off-by: Alex Elder <elder@riscstar.com>
>> ---
>>   .../bindings/pci/spacemit,k1-pcie-rc.yaml     | 141 ++++++++++++++++++
>>   1 file changed, 141 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/pci/spacemit,k1-pcie-rc.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-rc.yaml b/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-rc.yaml
>> new file mode 100644
>> index 0000000000000..6bcca2f91a6fd
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-rc.yaml
>> @@ -0,0 +1,141 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/pci/spacemit,k1-pcie-rc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: SpacemiT K1 PCI Express Root Complex
>> +
>> +maintainers:
>> +  - Alex Elder <elder@riscstar.com>
>> +
>> +description:
>> +  The SpacemiT K1 SoC PCIe root complex controller is based on the
>> +  Synopsys DesignWare PCIe IP.
>> +
>> +properties:
>> +  compatible:
>> +    const: spacemit,k1-pcie-rc.yaml
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
>> +      - description: DWC PCIe application AXI-bus Master interface clock
>> +      - description: DWC PCIe application AXI-bus Slave interface clock.
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
>> +      - description: DWC PCIe application AXI-bus Master interface reset
>> +      - description: DWC PCIe application AXI-bus Slave interface reset.
>> +      - description: Global reset; must be deasserted for PHY to function
>> +
>> +  reset-names:
>> +    items:
>> +      - const: dbi
>> +      - const: mstr
>> +      - const: slv
>> +      - const: global
>> +
>> +  interrupts-extended:
>> +    maxItems: 1
> 
> What is the purpose of this property? Is it for MSI or INTx?

It is for MSIs, which are translated into this interrupt.
I'll add a short description indicating this.

Is there a better way to represent this?

>> +
>> +  spacemit,syscon-pmu:
>> +    description:
>> +      PHandle that refers to the APMU system controller, whose
>> +      regmap is used in managing resets and link state.
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +
>> +  device_type:
>> +    const: pci
>> +
>> +  max-link-speed:
>> +    const: 2
> 
> Why do you need to limit it to 5 GT/s always?

It's what the hardware overview says is the speed
of the ports.
     PCIE PortA Gen2x1
     PCIE PortB Gen2x2
     PCIE PortC Gen2x2

But I think what you're asking might be "why do you
need to specify in DT that the link speed is limited".
And in that case, I realize now that it is not needed.
I will specify dw_pcie->max_link_speed to 2 before
calling dw_pcie_host_init().

If that's not what you meant, please let me know.

>> +  num-viewport:
>> +    const: 8
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - clock-names
>> +  - resets
>> +  - reset-names
>> +  - spacemit,syscon-pmu
>> +  - "#address-cells"
>> +  - "#size-cells"
>> +  - device_type
>> +  - max-link-speed
> 
> Same comment as above.
> 
>> +  - bus-range
>> +  - num-viewport
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/spacemit,k1-syscon.h>
>> +    pcie0: pcie@ca000000 {
>> +        compatible = "spacemit,k1-pcie-rc";
>> +        reg = <0x0 0xca000000 0x0 0x00001000>,
>> +              <0x0 0xca300000 0x0 0x0001ff24>,
>> +              <0x0 0x8f000000 0x0 0x00002000>,
>> +              <0x0 0xc0b20000 0x0 0x00001000>;
>> +        reg-names = "dbi",
>> +                    "atu",
>> +                    "config",
>> +                    "link";
>> +
>> +        ranges = <0x01000000 0x8f002000 0x0 0x8f002000 0x0 0x100000>,
> 
> I/O port CPU address starts from 0.

First, I'm not sure what this comment means.

But second, this ranges value (which I'm sure I just copied from
the working DTS file) somehow got munged.

I know there were other errors in this YAML file that I have
to fix, and I'll fix this too.

Thank you Mani.

					-Alex

> 
> - Mani
> 


