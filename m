Return-Path: <linux-pci+bounces-38712-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6411DBEF6FC
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 08:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C69B04EA7F6
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 06:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C823D21FF45;
	Mon, 20 Oct 2025 06:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="q9SgQ2C+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE00E28469F
	for <linux-pci@vger.kernel.org>; Mon, 20 Oct 2025 06:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760940954; cv=none; b=Yu1WkZaQUMKCUS/UnnJixRWehzyDvCyxQO7eTPDxKyqm+lUP+RXpfVZJANpK4PznO8nb0+4HXinZb4qR+MnsSBQT2u/lb7x7/sJUTycYgebQq7C2iAqNmcnw1GZ26w7g08RY7FDmI6S8MFbSTMMU/xDngYdgggyRTSlwNJESoBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760940954; c=relaxed/simple;
	bh=1uuOx1fBZN3sJlDbvDWwVQeBkgp3xfwRpCGd9hWJ58c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fA+t0DmcxQ9HUDx0lCmDVnwDA2yuVrR1dalhwt2mnJ5RUaRHrjv8rpNnYO+sv5WWv+oXDAULG2YgQnz1YTTgZYQiQIIqsnIuXEjXEWb2+QN9x8tYBX/KDfThSbKeyZHvtpw37aSsokIlfLuL/iuTswV72NdueqPNM6gzUHtj+A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=q9SgQ2C+; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b5c18993b73so658971166b.0
        for <linux-pci@vger.kernel.org>; Sun, 19 Oct 2025 23:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1760940950; x=1761545750; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GXhPF9zZ3GiKd73z5uR5oEzzSBPCnGUTtgpn+bJqQS0=;
        b=q9SgQ2C+6fqqKFm/4FdbYdDBqYaYxagIeJxe+6GjoN70+8uRr3yyXuXF6rYp7BNlCY
         Dv+3RzQX8VrqiA88pvxxbzmQ/xzGFRLpCwSjq9yxtjHfc6R8ZJaKHcHI9U+rJ/mdY6+G
         KzkrVWu/WPLObvws4EKhnpJ4USgRJ7+caeYF1xFv76+WaXFEBTlghcYeIOOaTI5qLahF
         mGZOpFeRlxGp8RHL1ZPytI00os6O5Xymn2zKNzlokLsSEImWtsnGjitianlUDveb34c5
         SEwAWigimtbMDwm/+BlMvU0kEFn8xryfdmGNcL1CkjkkNsJuX7xQvN4BtAFSEaZvR/2G
         XiNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760940950; x=1761545750;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GXhPF9zZ3GiKd73z5uR5oEzzSBPCnGUTtgpn+bJqQS0=;
        b=EGFduMAUDZGwonJ6BljWK1O7WvRxM2PLFnm9XOcBR2ep061I18uzcEYhTjzuhyJvpf
         0tvPtEIevDrlR5nxlQpbi3jknyD9wZWUASJTEiIskHkAHrmF6oaTKK+4gNRDuqSPF7VX
         h36F9Meu37Kgor9E6IiQUK8YyZjnw9j7hPF05S3/CXFiFIfuD7FhZLGFdzQtlZe0eZP7
         TVsCJTxirXvDWy4eBKzrXILJcs+mkabzCdMuTeme35WLbXdXhEgaCrYrutAR8w56z/Ww
         g2TeElDd2Y7AB0OxvyOR6ajlILPFZDQAcgrahmgS3JCTkdYNkmj26l0/Tb0hPrP6ktQD
         5JNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUml6FCykhvdwOvrzSOnAvrnE2t0pya0eeFqPyaIJByvI5Cr/TCOv6p64/4bOkT/bQRFTN1b8RJ3zw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv2TATnVuP5BCQ4894a8oj5Xwz24HJlqDg4TMjMTx193YHz5Uh
	+yTkKMi6oEUDK8j0d7LDUlgcI8gWEoMO84Rz2TXgyPj2HGSx0/2S7CSFftgKe8ks+7M=
X-Gm-Gg: ASbGncvLwmrRcroD2qCt6mVdXypkxfQG21AFJZbUi2cwrOT3vVt+4nDMAYav1aBbMcv
	2XOUbn1sJ7cvlHnte6qKoCWYyosTMtyTIxvQtpRfYdGwF8xiVIuI+HMwqWIFGSukhQigf6o8CQa
	kPwYC2htTuFfv5S+mvK+1m8WmmsHaHahjDKunzmaVZ2TlwNO6KmIKSAOARj0oHVMxdojEYBdcEp
	b7qM881HVcG40UgcuUv22aLfWvWRfL6bKWyj8UhdjbXxkp/PRDlX9oj/ArW49PKl0MB09fwlS5D
	dRUmkOF8Qezzo9YO/jMCUfvJ6IU0pxu7S6nLlbV6WsDAUfO7pTA3hmgjvMIYBeYlFmnvCMyLDPj
	tiqDxd7HH0D60JlgJXNg1J0b/j5ExSUlJiSLeuD7VlcYIWEdoFsT6iAo6bjFtfydiyRxiJtq05s
	LWW+/uZ04VKCICtlgT06M=
X-Google-Smtp-Source: AGHT+IFoYOgTWk/yesaqqeJZn0RjF/eXuGndb7IVuQS2tXGOubRmeP9oLf+Eer+uMLjFcajRsvdKZg==
X-Received: by 2002:a17:907:1b21:b0:b3f:c562:fae9 with SMTP id a640c23a62f3a-b6475703a96mr1386032266b.53.1760940949849;
        Sun, 19 Oct 2025 23:15:49 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.151])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e839416csm695099566b.28.2025.10.19.23.15.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Oct 2025 23:15:49 -0700 (PDT)
Message-ID: <a40a4a52-3dc0-4e17-8c55-548068976b8f@tuxon.dev>
Date: Mon, 20 Oct 2025 09:15:47 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/6] arm64: dts: renesas: r9a08g045: Add PCIe node
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
 bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
 geert+renesas@glider.be, magnus.damm@gmail.com, p.zabel@pengutronix.de,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
References: <20251007133657.390523-1-claudiu.beznea.uj@bp.renesas.com>
 <20251007133657.390523-4-claudiu.beznea.uj@bp.renesas.com>
 <k75ewk6mnv4w333oqefpgpa46fbg57grz7q6tlpc5evzehnzh5@elgnofa5ud5p>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <k75ewk6mnv4w333oqefpgpa46fbg57grz7q6tlpc5evzehnzh5@elgnofa5ud5p>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Mani,

On 10/19/25 09:57, Manivannan Sadhasivam wrote:
> On Tue, Oct 07, 2025 at 04:36:54PM +0300, Claudiu wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> The RZ/G3S SoC has a variant (R9A08G045S33) which supports PCIe. Add the
>> PCIe node.
>>
>> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> ---
>>
>> Changes in v5:
>> - updated the last part of ranges and dma-ranges
>> - collected tags
>>
>> Changes in v4:
>> - moved the node to r9a08g045.dtsi
>> - dropped the "s33" from the compatible string
>> - added port node
>> - re-ordered properties to have them grouped together
>>
>> Changes in v3:
>> - collected tags
>> - changed the ranges flags
>>
>> Changes in v2:
>> - updated the dma-ranges to reflect the SoC capability; added a
>>   comment about it.
>> - updated clock-names, interrupt names
>> - dropped legacy-interrupt-controller node
>> - added interrupt-controller property
>> - moved renesas,sysc at the end of the node to comply with
>>   DT coding style
>>
>>  arch/arm64/boot/dts/renesas/r9a08g045.dtsi | 66 ++++++++++++++++++++++
>>  1 file changed, 66 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
>> index 16e6ac614417..00b43377877e 100644
>> --- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
>> +++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
>> @@ -717,6 +717,72 @@ eth1: ethernet@11c40000 {
>>  			status = "disabled";
>>  		};
>>  
>> +		pcie: pcie@11e40000 {
>> +			compatible = "renesas,r9a08g045-pcie";
>> +			reg = <0 0x11e40000 0 0x10000>;
>> +			ranges = <0x02000000 0 0x30000000 0 0x30000000 0 0x08000000>;
>> +			/* Map all possible DRAM ranges (4 GB). */
>> +			dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 1 0x00000000>;
>> +			bus-range = <0x0 0xff>;
>> +			interrupts = <GIC_SPI 395 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 396 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 397 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 398 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 399 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 401 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 402 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 403 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 410 IRQ_TYPE_LEVEL_HIGH>;
>> +			interrupt-names = "serr", "serr_cor", "serr_nonfatal",
>> +					  "serr_fatal", "axi_err", "inta",
>> +					  "intb", "intc", "intd", "msi",
>> +					  "link_bandwidth", "pm_pme", "dma",
>> +					  "pcie_evt", "msg", "all";
>> +			#interrupt-cells = <1>;
>> +			interrupt-controller;
>> +			interrupt-map-mask = <0 0 0 7>;
>> +			interrupt-map = <0 0 0 1 &pcie 0 0 0 0>, /* INTA */
>> +					<0 0 0 2 &pcie 0 0 0 1>, /* INTB */
>> +					<0 0 0 3 &pcie 0 0 0 2>, /* INTC */
>> +					<0 0 0 4 &pcie 0 0 0 3>; /* INTD */
> 
> Why can't you describe the SPI interrupt for INTx in 'interrupt-map' itself?

Because the INTx need to be controlled at PCIe controller level, too.
Driver implements struct irq_chip::{irq_ack, irq_mask, irq_unmask} for
these interrupts. Describing them like:

interrupt-map = <0 0 0 1 &gic GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH>,
                <0 0 0 2 &gic GIC_SPI 401 IRQ_TYPE_LEVEL_HIGH>,
                <0 0 0 3 &gic GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH>,
                <0 0 0 4 &gic GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH>;

wouldn't allow for this, AFAICT.

> 
>> +			clocks = <&cpg CPG_MOD R9A08G045_PCI_ACLK>,
>> +				 <&cpg CPG_MOD R9A08G045_PCI_CLKL1PM>;
>> +			clock-names = "aclk", "pm";
>> +			resets = <&cpg R9A08G045_PCI_ARESETN>,
>> +				 <&cpg R9A08G045_PCI_RST_B>,
>> +				 <&cpg R9A08G045_PCI_RST_GP_B>,
>> +				 <&cpg R9A08G045_PCI_RST_PS_B>,
>> +				 <&cpg R9A08G045_PCI_RST_RSM_B>,
>> +				 <&cpg R9A08G045_PCI_RST_CFG_B>,
>> +				 <&cpg R9A08G045_PCI_RST_LOAD_B>;
>> +			reset-names = "aresetn", "rst_b", "rst_gp_b", "rst_ps_b",
>> +				      "rst_rsm_b", "rst_cfg_b", "rst_load_b";
>> +			power-domains = <&cpg>;
>> +			device_type = "pci";
>> +			#address-cells = <3>;
>> +			#size-cells = <2>;
>> +			max-link-speed = <2>;
> 
> 'max-link-speed' is used to limit the link speed. Why do you need to limit the
> link speed all the time for this controller?

I though it is to describe the max link speed supported by controller. This
controller max link speed is 5GT/s. Should I drop this property?

Thank you,
Claudiu


