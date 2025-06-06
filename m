Return-Path: <linux-pci+bounces-29082-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1565FACFEEE
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 11:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64CDF189A95A
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 09:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25DD286437;
	Fri,  6 Jun 2025 09:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="TxvA3+vc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D006A28642D
	for <linux-pci@vger.kernel.org>; Fri,  6 Jun 2025 09:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749201147; cv=none; b=WZRllAubu5rILdht8g8ydDg8N+20Ni2/a/xKIkRDi9bWz4vdQv4sU3LrIf7bBi6QiVlPN9zqXTieSK3SKtCV3OW71y4QuzdZjYY5jAEWe1WGA/O9+KBaJq2CHToBvApwS0HSR3b11KetR15LtByDDfWhegFfNTyRUcs2HgZy9Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749201147; c=relaxed/simple;
	bh=HmRNUwvFUl/hdKoO4B1dgc6/Hw5mGyFSqMWv/NJQVWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uH+gizAI5bNev/gHcJxu1gUHAM5ifFeebMcifX3Me0NHxZbAIVu9oFxcK1vEZppAtx0jkaYVvUhEQDMjnhdjS8wKE1CXxfYt2k+5f8XS5zebxD/Idz22t2fNO3AYsJxwCDjnRsHMpvHPFnSRyHuP2ELtX9WK1m4OLKkeZ0gtKrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=TxvA3+vc; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-addda47ebeaso367306166b.1
        for <linux-pci@vger.kernel.org>; Fri, 06 Jun 2025 02:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749201144; x=1749805944; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wc+ifX+7O38yry593NEDWvp79xQMU3g4ALAygrP5+5k=;
        b=TxvA3+vcesJZKqLdzgVo3evL9gOZzhwlcXroGLLBq+G8ahix5MAMLbKqLE35JLUHF2
         VAvfkrrzKMTNT1Er2AEEtR0GK5Jklbeh4SDj//wLvZ+MXHqpuLHP1y8+Ew37iDNJ/ELB
         zGhVek5Cu05m1W0oBuGylGglcngGZP80EfUkifMT7AU6RLF4+uduuyt1BPRz3coEAQtq
         SW9pJJVof/RhUpHQVgMQkGdxLiu/xtLDer20WNPoe3nsqhMdclVAfEwnrx7puRF3IKrA
         3xZthlRqDnC+BfNnrav3UnkwCkSEWUZ9QA8rf88C/gzcD6VYUSmeu6f9qbBQ1uH4nfQi
         3eoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749201144; x=1749805944;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wc+ifX+7O38yry593NEDWvp79xQMU3g4ALAygrP5+5k=;
        b=Ea4Ph7Oy19zddXNJ6IvjeCdMFkmRgKapIwe9GMAOVPaWjOQJNISnFHK9+CWcAG6kTb
         RSfF1LY9wgD74Qumk9yrgpf0PATxjuG5Gzc5tHwTShvBFONIdVRCeq3owVgWQHRqAx8m
         p9n3pHzIBv7uu+OBCibnBeFJjIxA5X4nt0AMlmqM3WLj2j9L4jAQocywwccV1zMhHwrn
         hmvsoJhP7aKuQPXw18snSR3H831DcjFZwaM9t/Stv7OQtQRyrPStWo/J/aWhTPETHHBb
         T8wyVIPK/eZkZkboBX13XuuqVbT+1FMf9u80RySbdALZtrcMAHpVD9DpcTVSEx7RRI+6
         OkEw==
X-Forwarded-Encrypted: i=1; AJvYcCUaR77TbGrFsdzTU3M1JUFI39Vv6nL75HvW6O81ClEW9ZRfKKncwlQ93P2CtD2SmwjzaedL2zubyzg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj3MIV8Gr8tv3DxF8nTxy2mKHoYKKwSxSSTuJvwEBs33MPuhz1
	6Cwpf3WffG+pmgZaqiNFQsnuNyf7uG/qfmatW6uOxDw6flgtX5m6R8BC3kUtoebGmpY=
X-Gm-Gg: ASbGncuw2RYGFsK3JtBcS5GAScUwRCV3pGsYYJtGy9eBbnCmPAYHRWJkMDjhkXDzTa7
	NQz3Xso8j7vXIb71Cd93mwKP2Xfg8ot+3+6q46KllaUHMd+Y5GuuB5fwPYl5GL0LKBQAWgeYHEA
	67wZ74ASRT+IJtklIDNh3cZUiNqz5xI1BeiXKHBOZypWxHk2S3H/zzl18ibPWYesdJAxQOQtnAe
	cEeVaPNEjQ1gaUBwAy1zt8/UZ2//UCc+CQRFL/F252UtRM18861956dIWdI5O6dG8dfxHeWWMeK
	Ro8f80agLkB2YFNz40ShdVuI67VNt/TSVyiEroEATDA5+GSrRa4EB4dX15Ve
X-Google-Smtp-Source: AGHT+IEjDHiLE7sMo+a12s7VFlD8SjfCEiBfxxMF3QVGmJjKfSvQI7x7ZEGc6pDRlowYGNhvaszk6A==
X-Received: by 2002:a17:907:bb49:b0:adb:428f:f748 with SMTP id a640c23a62f3a-ade1aa06c95mr206620466b.21.1749201143788;
        Fri, 06 Jun 2025 02:12:23 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1dc7d300sm85900566b.179.2025.06.06.02.12.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jun 2025 02:12:23 -0700 (PDT)
Message-ID: <53921bd9-6ac9-49fb-8c9d-2c439ec8cd5b@tuxon.dev>
Date: Fri, 6 Jun 2025 12:12:21 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] PCI: rzg3s-host: Add Initial PCIe Host Driver for
 Renesas RZ/G3S SoC
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
 manivannan.sadhasivam@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, geert+renesas@glider.be, magnus.damm@gmail.com,
 mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
 john.madieu.xa@bp.renesas.com,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20250605225730.GA625963@bhelgaas>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20250605225730.GA625963@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Bjorn,

On 06.06.2025 01:57, Bjorn Helgaas wrote:
> On Fri, May 30, 2025 at 02:19:13PM +0300, Claudiu wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> The Renesas RZ/G3S features a PCIe IP that complies with the PCI Express
>> Base Specification 4.0 and supports speeds of up to 5 GT/s. It functions
>> only as a root complex, with a single-lane (x1) configuration. The
>> controller includes Type 1 configuration registers, as well as IP
>> specific registers (called AXI registers) required for various adjustments.
> 
>> +/* Timeouts */
>> +#define RZG3S_REQ_ISSUE_TIMEOUT_US		2500
>> +#define RZG3S_LTSSM_STATE_TIMEOUT_US		1000
>> +#define RZG3S_LS_CHANGE_TIMEOUT_US		1000
>> +#define RZG3S_LINK_UP_TIMEOUT_US		500000
> 
> Are any of these timeouts related to values in the PCIe spec?  If so,
> use #defines from drivers/pci/pci.h, or add a new one if needed.
> 
> If they come from the RZ/G3S spec, can you include citations?

The values here were retrieved by experimenting. They are not present in
RZ/G3S specification. I'll look though the header you pointed and use any
defines if they match.

> 
>> +static int rzg3s_pcie_host_init(struct rzg3s_pcie_host *host, bool probe)
>> +{
>> +	u32 val;
>> +	int ret;
>> +
>> +	/* Initialize the PCIe related registers */
>> +	ret = rzg3s_pcie_config_init(host);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Initialize the interrupts */
>> +	rzg3s_pcie_irq_init(host);
>> +
>> +	ret = reset_control_bulk_deassert(host->data->num_cfg_resets,
>> +					  host->cfg_resets);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Wait for link up */
>> +	ret = readl_poll_timeout(host->axi + RZG3S_PCI_PCSTAT1, val,
>> +				 !(val & RZG3S_PCI_PCSTAT1_DL_DOWN_STS), 5000,
>> +				 RZG3S_LINK_UP_TIMEOUT_US);
> 
> Where do we wait for PCIE_T_RRS_READY_MS before pci_host_probe()
> starts issuing config requests to enumerate devices?

I missed adding it as RZ/G3S manual don't mention this delay.

> 
>> +	if (ret) {
>> +		reset_control_bulk_assert(host->data->num_cfg_resets,
>> +					  host->cfg_resets);
>> +		return ret;
>> +	}
>> +
>> +	val = readl(host->axi + RZG3S_PCI_PCSTAT2);
>> +	dev_info(host->dev, "PCIe link status [0x%x]\n", val);
>> +
>> +	val = FIELD_GET(RZG3S_PCI_PCSTAT2_STATE_RX_DETECT, val);
>> +	dev_info(host->dev, "PCIe x%d: link up\n", hweight32(val));
>> +
>> +	if (probe) {
>> +		ret = devm_add_action_or_reset(host->dev,
>> +					       rzg3s_pcie_cfg_resets_action,
>> +					       host);
>> +	}
>> +
>> +	return ret;
>> +}
> 
>> +		 * According to the RZ/G3S HW manual (Rev.1.10, section
>> +		 * 34.3.1.71 AXI Window Mask (Lower) Registers) HW expects first
>> +		 * 12 LSB bits to be 0xfff. Extract 1 from size for this.
> 
> s/Extract/Subtract/

OK.

Thank you for your review,
Claudiu

