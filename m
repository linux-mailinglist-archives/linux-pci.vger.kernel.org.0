Return-Path: <linux-pci+bounces-10500-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 581DC934CF7
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 14:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8EAA1F22AF2
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 12:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E0113BC12;
	Thu, 18 Jul 2024 12:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zbplqjNg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6020012FB34
	for <linux-pci@vger.kernel.org>; Thu, 18 Jul 2024 12:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721304668; cv=none; b=kVwtnxWPITB2iKktpePSvJgRlC/Uh1kF4XJVhmdHVjO3GQNE4/v80gdJsAVStj1gImtuLhhbJVXRgYeUnhBe6mOEkXiozdeIoMG55eF5krIDtbF1E2zG0DNow7SSvfDcSNN/XycERhINDZ/PJXBnoiWom5h/qdCBHFbW/VcUJoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721304668; c=relaxed/simple;
	bh=5FlvvF6ElZoar91TZyjpmKtRh40LGlBGD1Ri5a2ma5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SH2HJS5Tv7843H66vERG27bvDMM0itKdv4flRZ7WKBlSM1uCtRoZQbMpFVk72LcW+dBOqlYPHVO2lb3ApmUV7qwULK2AkvdZnoYsOLJtH5jaVVnGpPs3gk+nao/xTJFdC4PZ820VgPldMRERh1zsO/tUSF2YH5N/Js1BDKEeIxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zbplqjNg; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a77cb7c106dso76601966b.1
        for <linux-pci@vger.kernel.org>; Thu, 18 Jul 2024 05:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721304664; x=1721909464; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HMhzX7yfMRYWWdn8bv1T9AEmz4KNpf5iD+xeOE74dI4=;
        b=zbplqjNgzzswYLqQve+cEiGc1I7tBZgic1M0R1D0Q4/xFtavr1XC0zfP+aF4Mz3A1I
         lcwhKZc7UEEc35RP0BJhmOxgw3vFERFvBm1uwqA8gBXYXMvLd5viCoX9k8PxjnpIMtC9
         p3WUiqWlsGff4z/55kSC5GLYo193Xm7i7L1RGLBeDarUzrWl2Osw9Y94+VhJzLBGFcRr
         SjCzprgxMF57r4P28KPZ1ve0OqMjmgTSRRbuyD+KdqOWYMZnaxL7NoARmw0VWq5yqnUm
         tReLC2m5VNyufr0bN99xfcrvQaUY7zl2LcaHXcs+zqP3Co4sng8Gxe+QjXc8kULdUscK
         FmOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721304664; x=1721909464;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HMhzX7yfMRYWWdn8bv1T9AEmz4KNpf5iD+xeOE74dI4=;
        b=G1H52sNAtwS+tajaEFvGIHZiYUfmqI1jz53EZWz64mdZBEMH61AhhlyQcIo4UUhk7O
         Ezdc0T9ZKtP1UyQXxuk2uzwYVihDrtUB6XMwtvCNv8hQdaQbF9NjE8zi5+XxYMGbr955
         7OkeN2Mm/K/SG+KjoC1+lZC70HMBwtel+UJ2fUwJidfAYWxnZMYH7lA5sizsCXll9Ihc
         BqnwMrp1YEQRuXKkMP7BG+0D+kwQLJjuXWo5CqC9YUIPPWbupsxst9ltOOmVqyGCfPQd
         ysWBR/RkxM3Rl7RMAC3eVXogvQv0vVCo6sTohI7gYIFJz2ZUerSwNYEcruNMn+WGsa6w
         IXOA==
X-Gm-Message-State: AOJu0YweWjBvt5jEky/4HPUcvGGc/y3ZrrPGci0r1fzYt5XsDHkN881n
	nz5TGRXbRLsNI8mz30rm24P/7kngnWH+0lpE5aWil33mwRQuC3oZo6cIj4qh0AjXa5q1cqSCrVM
	i
X-Google-Smtp-Source: AGHT+IEaFqvxuZZ7uAVDsD2FLeFUDd9vDe5QIGuH7rH9x2g06eiK94eBPWI/FWmwd3PIAyZkU8JvJg==
X-Received: by 2002:a17:906:80c3:b0:a72:80b8:ba64 with SMTP id a640c23a62f3a-a7a01145e24mr325166966b.25.1721304662661;
        Thu, 18 Jul 2024 05:11:02 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc5e85ebsm558826066b.96.2024.07.18.05.11.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 05:11:02 -0700 (PDT)
Message-ID: <8b6cd895-8904-4d8c-bf23-5d933f476d57@linaro.org>
Date: Thu, 18 Jul 2024 14:11:00 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/13] PCI: endpoint: Assign PCI domain number for
 endpoint controllers
To: manivannan.sadhasivam@linaro.org,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20240717-pci-qcom-hotplug-v2-0-71d304b817f8@linaro.org>
 <20240717-pci-qcom-hotplug-v2-5-71d304b817f8@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240717-pci-qcom-hotplug-v2-5-71d304b817f8@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17.07.2024 7:03 PM, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Right now, PCI endpoint subsystem doesn't assign PCI domain number for the
> PCI endpoint controllers. But this domain number could be useful to the EPC
> drivers to uniquely identify each controller based on the hardware instance
> when there are multiple ones present in an SoC (even multiple RC/EP).
> 
> So let's make use of the existing pci_bus_find_domain_nr() API to allocate
> domain numbers based on either Devicetree (linux,pci-domain) property or
> dynamic domain number allocation scheme.
> 
> It should be noted that the domain number allocated by this API will be
> based on both RC and EP controllers in a SoC. If the 'linux,pci-domain' DT
> property is present, then the domain number represents the actual hardware
> instance of the PCI endpoint controller. If not, then the domain number
> will be allocated based on the PCI EP/RC controller probe order.
> 
> If the architecture doesn't support CONFIG_PCI_DOMAINS_GENERIC (rare), then
> currently a warning is thrown to indicate that the architecture specific
> implementation is needed.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/endpoint/pci-epc-core.c | 10 ++++++++++
>  include/linux/pci-epc.h             |  2 ++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index 84309dfe0c68..7fa81b91e762 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -838,6 +838,9 @@ void pci_epc_destroy(struct pci_epc *epc)
>  {
>  	pci_ep_cfs_remove_epc_group(epc->group);
>  	device_unregister(&epc->dev);
> +
> +	if (IS_ENABLED(CONFIG_PCI_DOMAINS_GENERIC))
> +		pci_bus_release_domain_nr(NULL, &epc->dev);	

Shouldn't this be called before device_unregister? pci/remove.c
does that (via pci_remove_bus() in pci_remove_root_bus())

Konrad

