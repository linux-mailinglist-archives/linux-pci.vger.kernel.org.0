Return-Path: <linux-pci+bounces-42554-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDD8C9E744
	for <lists+linux-pci@lfdr.de>; Wed, 03 Dec 2025 10:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 76C284E029C
	for <lists+linux-pci@lfdr.de>; Wed,  3 Dec 2025 09:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1182DCC13;
	Wed,  3 Dec 2025 09:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VwlykdpO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04E62DC79E
	for <linux-pci@vger.kernel.org>; Wed,  3 Dec 2025 09:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764753866; cv=none; b=vF7glrBcPl8bXZ0LSRcLWO6BoBFV1pcXgFvqfdKtSDCPOeH+Gofc4ADljSV3o+FANInF42s9FoCHrXwJyXCnkWmUoWE6uNJOH0MIqZ1RcaskkrUDEbu5hxjkgdcLkZ4EaAO5UcttzSbJ3lLQf8zDUv9dlv7hC4+fh0K4xO6gNnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764753866; c=relaxed/simple;
	bh=gISgXZarD9qm8hi8sOqrhr7ifIhZiCjDJpFmY8PcJvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D4olTmeGIvICsquEkjBQe/cWCVVc+ccbqSmD0ScgzpmE4GwhNUdywrtvwcJ8XUpgJCiC/DfvIZtNf4Gkwx8tftVME23tnzRC9W9t9yRJST6eBS9CYdtc0vLP3m3O2lFSmLO0MmdM+atFkjccOD5oXiPd5KsOtG1bChMZZ+okOEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VwlykdpO; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42e2b78d45bso1830611f8f.0
        for <linux-pci@vger.kernel.org>; Wed, 03 Dec 2025 01:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764753863; x=1765358663; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hIq3IHSi3NCGoALJGtGBwT4WOSI8sD7pseTnOYUGDBU=;
        b=VwlykdpOBU7mAvpNHu3pxT18+iSR+YKm/j+NQf7Rzz/NwMEdaPFuoyFw4oqPbr2Lhj
         9EPd6+xhuQ4sVCTf1VruV1jurUJSN93t10QWp7qFT/qbAfOm901sLF1q5I08f5d9JU4j
         hVpm3m+TmknE7k/+Ie83xAXMVyda4c6nI397ystW5bG5/nBbKfSPVltSsUouK5QbtbQ5
         qlHQtyMWBaI90bkyrXrjP23k8P3AzCy54Hp0J/jATjxvxmoawEiX7PbA+Bxb9v0Ou/6x
         NtMvawqrApAxx1GtKpkzhyTv6csWcJ3KDfBiJLV1A2FEKPvrsLyquZMYak/OE5zKu6oq
         CY9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764753863; x=1765358663;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hIq3IHSi3NCGoALJGtGBwT4WOSI8sD7pseTnOYUGDBU=;
        b=NEMCTpD5rUD36KcylORlgfrSbSKIitHSXW6DCD+sFje/iZuDuiv46v/Nos1TCJjYKt
         yY5qWmNdo4zLT9zgdvAiaHpGqZWU6GSuXuXAi7Bi3cEoCIVTs4TNZWAYFl/DVYsnFA7c
         qh9txMHHttxSOeS9hZV2LgPW0UKu/WDelxu7IC3wXdS0HDLk91wQjkMgl/+px/50un7x
         MZXeabwSYu/eQLR+waN7e9ReDS37VDhsGenZNDaKgbo1jPBB/QGkmWEoZYuDdtINaDE/
         dCyHGTPiKqoLxYYp0o3ha7jqZq6jYn7CzJZCiEh086H11YPcWY+p8BUHl7qoQF3gk5P3
         P2dw==
X-Forwarded-Encrypted: i=1; AJvYcCUs61VU5JVkcVpN2NRPrMoy0ZBeYbWDYNxZ4HAyz/FeQvzevD8mHVuPMS2ThP7Mr8zOHt3sRgGgjh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxfqVkTHcYnRfO6wwAMXYNYTnGDNRYPkTBbyJK9GXsw0Mnu1Ff
	OZN+p+Gx8EV8lD5hRhEFRO8nEHuvAqSolywg2TvsBNC/NC7rRbYGAS5uM8BmQJ8wZNc=
X-Gm-Gg: ASbGnctYrWZifzVJ7VLS8lw+iHU/gM5z9UaA4r4lEPNifVv+N363QBicAem28NfmO0d
	+DErJefY3wFVVrzCHfxR7TxBPrApTyRrwHWoxd60St+B3+wSSTD5QERLqbhYA8PS+antTAllAks
	EcnqgG3jhYphIao7yCiLJtmPaVbOpS1f7ZDqflnBn3ZSpM2XpKR0Mfizq/pnCacwEPresUrz2TJ
	MBc4OkUfgx4o18t+sw8L/i2nThmdra5aF1yk5ppFWLwTfu7a8dSwn6+gAvkPIeQ17AbiJAuGwPu
	uvE2YJUn1POmJAxwFWtdvvUuxA/Ptj4Cg6U/FlRT0i3zXtMY25k8IGbqLqMs4t4qZO+65+kOxQe
	vFIDHVfMBLPprOPD3T5p9qZ3Vait9jdhQkfye4cOa+5YiS8ptO/cyljWmkpT+UfDIxaN0Do1RAe
	0d5VCXtOo8kSd33ltzRcgzv7J3GNSpn7XBUgf02MtT6T+fPLKXGJVncU9ajQ==
X-Google-Smtp-Source: AGHT+IF2iU8jB8+25UI8v8StXBFRMZ8jem8wdZqu4MTeDmBwzCDt27e9WG51u5pLanJkVFwLbAoY/A==
X-Received: by 2002:a05:6000:24c6:b0:42b:39ee:288e with SMTP id ffacd0b85a97d-42f7317d149mr1470532f8f.13.1764753863013;
        Wed, 03 Dec 2025 01:24:23 -0800 (PST)
Received: from [10.255.254.100] (bba-83-110-84-117.alshamil.net.ae. [83.110.84.117])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1ca78f77sm38217963f8f.32.2025.12.03.01.24.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Dec 2025 01:24:22 -0800 (PST)
Message-ID: <b6df2f2e-c1d6-4eb2-82e5-d7e149d12575@linaro.org>
Date: Wed, 3 Dec 2025 11:24:19 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v6 2/2] dmaengine: dw-edma: Add non-LL mode
To: "Verma, Devendra" <Devendra.Verma@amd.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "mani@kernel.org" <mani@kernel.org>, "vkoul@kernel.org" <vkoul@kernel.org>
Cc: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Simek, Michal" <michal.simek@amd.com>
References: <20251121113455.4029-1-devendra.verma@amd.com>
 <20251121113455.4029-3-devendra.verma@amd.com>
 <SA1PR12MB8120B42CB67E6A4F25318B4895DBA@SA1PR12MB8120.namprd12.prod.outlook.com>
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <SA1PR12MB8120B42CB67E6A4F25318B4895DBA@SA1PR12MB8120.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/1/25 11:58, Verma, Devendra wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Hi All
> 
> Could you all please review the following patch?

No need to remind people, your patch will be reviewed.

> 
> Regards,
> Dev
> 
>> -----Original Message-----
>> From: Devendra K Verma <devendra.verma@amd.com>
>> Sent: Friday, November 21, 2025 5:05 PM
>> To: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org
>> Cc: dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
>> kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>; Verma,
>> Devendra <Devendra.Verma@amd.com>
>> Subject: [PATCH RESEND v6 2/2] dmaengine: dw-edma: Add non-LL mode
>>
>> AMD MDB IP supports Linked List (LL) mode as well as non-LL mode.

Is this non-LL mode some official name ? (e.g. in the datasheet or
official product name )
Because having a 'bool non-LL' as false making it in a LL mode adds a
double negation that is difficult to follow.
 >> The current code does not have the mechanisms to enable the DMA
>> transactions using the non-LL mode. The following two cases are added with
>> this patch:
>> - When a valid physical base address is not configured via the
>>   Xilinx VSEC capability then the IP can still be used in non-LL
>>   mode. The default mode for all the DMA transactions and for all
>>   the DMA channels then is non-LL mode.
>> - When a valid physical base address is configured but the client
>>   wants to use the non-LL mode for DMA transactions then also the
>>   flexibility is provided via the peripheral_config struct member of
>>   dma_slave_config. In this case the channels can be individually
>>   configured in non-LL mode. This use case is desirable for single
>>   DMA transfer of a chunk, this saves the effort of preparing the
>>   Link List. This particular scenario is applicable to AMD as well
>>   as Synopsys IP.
>>
>> Signed-off-by: Devendra K Verma <devendra.verma@amd.com>

[...]

