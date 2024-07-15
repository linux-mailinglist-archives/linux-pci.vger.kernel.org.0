Return-Path: <linux-pci+bounces-10314-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 677C1931B9C
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 22:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D309BB216AC
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 20:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EADD13E88B;
	Mon, 15 Jul 2024 20:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K7xKLgQj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9E513E40F
	for <linux-pci@vger.kernel.org>; Mon, 15 Jul 2024 20:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721074253; cv=none; b=lWeggE0dLRMQQBQmMdrr86eNrFxLkn1tmpqbEkJdNHzZuqF2WgF7+oIT9yU5rbgJjMCyVsl181jrl/T/I0eXPSDAvbTEEn01b/GMIh6xX8fjfVpeKumDUgQHCzKquiNgSTPXV79ZMOjfztbkGasPkuQh7LEjGIj0Xj44vj72rfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721074253; c=relaxed/simple;
	bh=apIzQbvUQRMe95SHtzkjIV3GFY79ySQ9uE4Zolrk3vY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TDp0StYaZkRxbNbSMcFR22WS2aW+8YyCwpf/J02809iSI1vMuGoSsj9+iXSLb1HkpQtXSx2NWV/o5R94423CjGRZrVaB7zDbmsEaRVjOkqp/9cA+adVqh8TBLYUdXRPE7nEeFOfXvyoeExDIBsy6bNOrfn+VEiWfOF0qqv5l3nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K7xKLgQj; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a77e6dd7f72so569101566b.3
        for <linux-pci@vger.kernel.org>; Mon, 15 Jul 2024 13:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721074249; x=1721679049; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XWIo3s3ppYQ4sfyuhvPeRxZE+2HFTQTLn/FHTLwsUU0=;
        b=K7xKLgQjfYeLRVl99f/0pfn2eAiL+fbs/HzkYUkUD9mXPmNVa2QmUM9fP645+S+LQI
         t9qe1BN1DTJR+z2OmECcTu4PqUETa/0oQVQAtHilYJazNPRkcRV6EHYrhzqq/sLoUr9I
         Fq8JwGEyhIkCWruZfg6u0q12loS9Y4B/hGshz2r+udQGduKx+3lZAVdqI5t0f7vx7WRu
         UoOvWUni4yZsO0h5tHTy0k0HZ3S3+PDvZ6fhc71/KOc9wPj+AIWpBBhILiamSfiAloUH
         0Cf1c+97HDvgr4C0i72YKJxSDWqI8XyDwBJd6WMgIc9ud0JkvYLcaFoTSiayCFvDWdl0
         575Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721074249; x=1721679049;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XWIo3s3ppYQ4sfyuhvPeRxZE+2HFTQTLn/FHTLwsUU0=;
        b=jQFOc2ZIgSpuQpFcLXp6Xy8SrDiVu5Ljrdl6vE5Wn45hoKHCbbIRhhbaELo42TvVki
         EJ7tfPpyUORwU1OabLujVcxMHW1jH0p6OD8LvQ6I6EP6Amplp1Lc/7JLe8ZkHZROK2MI
         8XRpDiR1I50gnivkQf7Ic+zNfb+Enzi5TtljENF7Qbp9LecDju6HmtVYhs7iWD8ElaeZ
         CbLC4B1UCmkwY6aFhTyGKVk2Jyv4W6tKAPD38c2omjvBP35F1c3QDC04wiyFz6zUrm0q
         w0L07xcVhLzXpFpoiU/JLlhHxy41omHdXCYLpqf9Ps2CuFnVtWyMpCJ3ICjfWy7t29WC
         fbdA==
X-Gm-Message-State: AOJu0YxadH2/6p7M7OIEqj0rYzWFUQhSWaqKlnMONmUJ3Cs7EN1GNgXr
	T3PrWSE1lwkQ9PX7fvWeXJKst8SONJdqf8RxOCX+YbzhGZk1U63MSuZhqPw6tOw=
X-Google-Smtp-Source: AGHT+IGncW6Av8+CLeIS5zUNKTkEElaBGCbltYGwtYKP8h1FXJsG68xeRxIUHQtlauMLhB8uiohZMA==
X-Received: by 2002:a17:906:3412:b0:a75:1069:5b94 with SMTP id a640c23a62f3a-a79ea437512mr2853166b.21.1721074249441;
        Mon, 15 Jul 2024 13:10:49 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc7f1d29sm235668066b.105.2024.07.15.13.10.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 13:10:49 -0700 (PDT)
Message-ID: <b56c54ae-f12e-4c2c-bb55-6a64695a1c94@linaro.org>
Date: Mon, 15 Jul 2024 22:10:47 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/14] PCI: qcom: Simulate PCIe hotplug using 'global'
 interrupt
To: manivannan.sadhasivam@linaro.org,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20240715-pci-qcom-hotplug-v1-0-5f3765cc873a@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240715-pci-qcom-hotplug-v1-0-5f3765cc873a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15.07.2024 7:33 PM, Manivannan Sadhasivam via B4 Relay wrote:
> Hi,
> 
> This series adds support to simulate PCIe hotplug using the Qcom specific
> 'global' IRQ. Historically, Qcom PCIe RC controllers lack standard hotplug
> support. So when an endpoint is attached to the SoC, users have to rescan the
> bus manually to enumerate the device. But this can be avoided by simulating the
> PCIe hotplug using Qcom specific way.
> 
> Qcom PCIe RC controllers are capable of generating the 'global' SPI interrupt
> to the host CPUs. The device driver can use this event to identify events such
> as PCIe link specific events, safety events etc...
> 
> One such event is the PCIe Link up event generated when an endpoint is detected
> on the bus and the Link is 'up'. This event can be used to simulate the PCIe
> hotplug in the Qcom SoCs.
> 
> So add support for capturing the PCIe Link up event using the 'global' interrupt
> in the driver. Once the Link up event is received, the bus underneath the host
> bridge is scanned to enumerate PCIe endpoint devices, thus simulating hotplug.
> 
> This series also has some cleanups to the Qcom PCIe EP controller driver for
> interrupt handling.

Welp I've reviewed this series, and only now came to the realization that
the PCIe RC and PCIe EP descriptions are borderline identical.. perhaps for
new platforms we could get a new binding that could have a structure like

pcie@abcd1234 {
	// commmon properties

	pcie-ep {
		// ep specifics
	};

	pcie-rc {
		// rc specifics
	}
};

or better yet, have a single node no matter what, but consume only the
required resources from the driver and have something akin to phy-mode,
just like we solved the DP/eDP dual-mode controller story

Although here it may not be so simple given there's properties like
iommu-map that map to bus specifics..

Konrad

