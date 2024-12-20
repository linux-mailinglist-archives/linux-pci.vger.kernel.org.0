Return-Path: <linux-pci+bounces-18873-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 361819F8F0F
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 10:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44ED51896E75
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 09:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9CF19F42F;
	Fri, 20 Dec 2024 09:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXNQJ80b"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C526A2582
	for <linux-pci@vger.kernel.org>; Fri, 20 Dec 2024 09:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734687301; cv=none; b=oE+wOj44IVz9djAr1X3x7FXB3xL+dev7unWia6C6Pvyc++A2pgRnLnyeCcywokHELW/x5s6r5ko3OX1SW/Xd5iU6U+OiDg/r3cZrY3egD8HIowVT1ZWu7TDI5Kw9eOajqcBC7yZExVclzHmrucVJlhfpwMXIl+/A7ei4aCgCVBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734687301; c=relaxed/simple;
	bh=6aHlxxEE5s0daOuuf5+/ndwzU60spUvmAxdJU2cLcuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UELg+b4QcOdGQTY8YUj+LNs9/PKRZFDq8MSw81SiwnGTquBSw7gfuqi8mn61iXTzGlGS9o+zVGrun8ZfUEDf3DyHvxWm2XC1v0njYA8gillgFAycER3v3c4gAAiJvM75eu/tKJcp51wy9+KKxg+S0wC3Q0KITOCNFqd+RxZNH0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXNQJ80b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1BC1C4CECD;
	Fri, 20 Dec 2024 09:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734687301;
	bh=6aHlxxEE5s0daOuuf5+/ndwzU60spUvmAxdJU2cLcuI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AXNQJ80b24OZ+voeUJWCUWbNLBLyGYhcTOvSAiSvh9nC5N++hvW/9X6UTiHVeCszU
	 iTlUwlAapQoZzW/8xtDWmZ71cHwmjLGsmA6qf3cfQdWdlJ4HM2l8qZ2GR8E2lpcarA
	 I60lJVQv//mUQEPXdnPMVMwcHV3tjSIHrLVh5peihUkRwS6dnkJcJtSqO4f5JrdKOV
	 eAXFLBFAx+2KSCOwXjtm+ELYXioP21/DCDKdWlJeIhnxyeXUCmrNiC6Em0Vro7p5AD
	 5+67rS8L01LMuiph3jlT5GOOEB0Crg0qnLNpXl4/2fm0yrAFuAaNh5++rCokedVmmL
	 Jl08CxjPAJ2NA==
Message-ID: <80f3782b-c444-48ec-9276-cbfc9dae6a61@kernel.org>
Date: Fri, 20 Dec 2024 18:34:58 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 17/18] nvmet: New NVMe PCI endpoint function target
 driver
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-pci@vger.kernel.org, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kw@linux.com>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Rick Wertenbroek <rick.wertenbroek@gmail.com>,
 Niklas Cassel <cassel@kernel.org>
References: <20241220035441.600193-1-dlemoal@kernel.org>
 <20241220035441.600193-18-dlemoal@kernel.org>
 <20241220081229.pij52jwfdyeygux7@thinkpad>
 <eb787b7e-f141-4120-a6b0-e1b3f6bebd2d@kernel.org>
 <20241220092639.jho2tbdcxarlzpmr@thinkpad>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241220092639.jho2tbdcxarlzpmr@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/20/24 18:26, Manivannan Sadhasivam wrote:
> On Fri, Dec 20, 2024 at 05:59:05PM +0900, Damien Le Moal wrote:
> 
> [...]
> 
>>>> +static void nvmet_pci_epf_clear_bar(struct nvmet_pci_epf *nvme_epf)
>>>> +{
>>>> +	struct pci_epf *epf = nvme_epf->epf;
>>>> +
>>>> +	pci_epc_clear_bar(epf->epc, epf->func_no, epf->vfunc_no,
>>>> +			  &epf->bar[BAR_0]);
>>>> +	pci_epf_free_space(epf, nvme_epf->reg_bar, BAR_0, PRIMARY_INTERFACE);
>>>> +	nvme_epf->reg_bar = NULL;
>>>
>>> Memory for BAR 0 is allocated in nvmet_pci_epf_bind(), but it is freed in both
>>> nvmet_pci_epf_epc_deinit() and nvmet_pci_epf_bind(). This will cause NULL ptr
>>> dereference if epc_deinit() gets called after nvmet_pci_epf_bind() and then
>>> epc_init() is called (we call epc_deinit() once PERST# is deasserted to cleanup
>>> the EPF for platforms requiring refclk from host).
>>>
>>> So please move pci_epf_free_space() and 'nvme_epf->reg_bar = NULL' to a
>>> separate helper nvmet_pci_epf_free_bar() and call that only from
>>> nvmet_pci_epf_unbind() (outside of 'epc->init_complete' check).
>>
>> I do not get PERST# on the RK3588... So I never noticed this.
>> Does this work for you ?
>>
>> diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
>> index 8db084f1b20b..4d2a66668e73 100644
>> --- a/drivers/nvme/target/pci-epf.c
>> +++ b/drivers/nvme/target/pci-epf.c
>> @@ -2170,14 +2170,23 @@ static int nvmet_pci_epf_configure_bar(struct
>> nvmet_pci_epf *nvme_epf)
>>         return 0;
>>  }
>>
>> +static void nvmet_pci_epf_free_bar(struct nvmet_pci_epf *nvme_epf)
>> +{
>> +       struct pci_epf *epf = nvme_epf->epf;
>> +
>> +       if (!nvme_epf->reg_bar)
>> +               return;
>> +
>> +       pci_epf_free_space(epf, nvme_epf->reg_bar, BAR_0, PRIMARY_INTERFACE);
>> +       nvme_epf->reg_bar = NULL;
>> +}
>> +
>>  static void nvmet_pci_epf_clear_bar(struct nvmet_pci_epf *nvme_epf)
>>  {
>>         struct pci_epf *epf = nvme_epf->epf;
>>
>>         pci_epc_clear_bar(epf->epc, epf->func_no, epf->vfunc_no,
>>                           &epf->bar[BAR_0]);
>> -       pci_epf_free_space(epf, nvme_epf->reg_bar, BAR_0, PRIMARY_INTERFACE);
>> -       nvme_epf->reg_bar = NULL;
>>  }
>>
>>  static int nvmet_pci_epf_init_irq(struct nvmet_pci_epf *nvme_epf)
>> @@ -2319,8 +2328,6 @@ static void nvmet_pci_epf_epc_deinit(struct pci_epf *epf)
>>
>>         nvmet_pci_epf_deinit_dma(nvme_epf);
>>         nvmet_pci_epf_clear_bar(nvme_epf);
>> -
>> -       mutex_destroy(&nvme_epf->mmio_lock);
>>  }
>>
>>  static int nvmet_pci_epf_link_up(struct pci_epf *epf)
>> @@ -2390,8 +2397,9 @@ static void nvmet_pci_epf_unbind(struct pci_epf *epf)
>>         if (epc->init_complete) {
>>                 nvmet_pci_epf_deinit_dma(nvme_epf);
>>                 nvmet_pci_epf_clear_bar(nvme_epf);
>> -               mutex_destroy(&nvme_epf->mmio_lock);
>>         }
>> +
>> +       nvmet_pci_epf_free_bar(nvme_epf);
>>  }
>>
>>  static struct pci_epf_header nvme_epf_pci_header = {
>>
>>> With the above change, I'm able to get this EPF driver working on my Qcom RC/EP
>>> setup.
>>
>> With the above, does it work for you ?
>>
> 
> Yes, it does!
> 
> One more suggestion. Since you correctly removed mutex_destroy() from deinit()
> and unbind(), you should also switch to devm_mutex_init() in probe().

Ah! Yes. Will do.

-- 
Damien Le Moal
Western Digital Research

