Return-Path: <linux-pci+bounces-6210-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B2D8A3A3F
	for <lists+linux-pci@lfdr.de>; Sat, 13 Apr 2024 03:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5742D1C20F77
	for <lists+linux-pci@lfdr.de>; Sat, 13 Apr 2024 01:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197127492;
	Sat, 13 Apr 2024 01:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFAE1hq5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9ED210962
	for <linux-pci@vger.kernel.org>; Sat, 13 Apr 2024 01:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712973044; cv=none; b=RmH0NZWB1XXcvP3L8YZFqSoC9Z35B2A0MfKCFx1FMGxtKa28JEERk6bjSoUhQpNnYjZhHSBTEAsnSfRuYom/gpZNlIQRdJmRJTgRF4G9OMko5qojhciHO+iK2DrwCNVJdRO4y4SNS55eDI+WzfzJ/k5QksTG+UcBXho/Hw68GPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712973044; c=relaxed/simple;
	bh=JfDhAkZ7NqPI1BHC5+qlpIyO3RdLjwXqyssIHUY7iME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Elymu8lIoH1BDt6AurC022oR4RYNoJjwFo1Qh0UwswCGzMQkUj+ifY6kTrXi3ZyeYTZ17mbScaknE8qK9ERA6Q4SZXLG2M9t+gzreaJ8pWrNQThpAx9R+Q+rFpt1QTxlh3PlcTqmzef9MV5sw/wFwcTLp2liCKnWgjLqQkqIk/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFAE1hq5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22DBCC113CC;
	Sat, 13 Apr 2024 01:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712973043;
	bh=JfDhAkZ7NqPI1BHC5+qlpIyO3RdLjwXqyssIHUY7iME=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UFAE1hq5am1I2pRPOK2srF287pPcWBqQGoUHEe0/PsrFbAGnXex3mk60YYqfA2rIZ
	 iuyOrtD4uQ1lcvDe4clvy4JTTUXjnofYk6TmdoTJhno4K7V/QGG8d/O+MOZa1kNOKM
	 DEm35qrYgo6tFN1WF0d5h06kFSzNrYhTeJ3fj9d8mYqegEJknMU74ct0kIkq6o3I2A
	 u3cVvYPcu/It9gUJp1tFEAoIqu9ter9ac+Fz/fBC2y9Wt1xBJko7fq8skx2vSQ/J2v
	 nT/S2xU73pH5sDd2lDtTC4UqMgwpCm8CKFKBSCjdJ2PzdgqFxEogNWPV4TKezx98/0
	 Vuo3n1K4nEEhA==
Message-ID: <89bbe0a0-55d3-4f25-b50a-9b3737697807@kernel.org>
Date: Sat, 13 Apr 2024 10:50:40 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] PCI: rockchip-host: Wait 100ms after reset before
 starting configuration
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>,
 linux-pci@vger.kernel.org, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org
References: <20240412212916.GA18789@bhelgaas>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240412212916.GA18789@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/13/24 06:29, Bjorn Helgaas wrote:
> On Fri, Apr 12, 2024 at 11:37:21AM +0900, Damien Le Moal wrote:
>> The PCI Express Base Specification r6.0, section 6.6.1, states that the
>> host should wait for at least 100 msec from the end of a conventional
>> reset (PERST# is de-asserted) before sending a configuration request to
>> ensure that the device is able to respond with a "Request Retry Status"
>> completion.
>>
>> Add the PCIE_T_RRS_READY_MS macro to define this wait time and modify
>> rockchip_pcie_host_init_port() to add this 100ms sleep after bringing
>> back PESRT# signal to high using the ep_gpio GPIO.
> 
> s/PESRT#/PERST#/
> s/bringing back PERST# signal to high/deasserting PERST#/
> 
>> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>> ---
>>  drivers/pci/controller/pcie-rockchip-host.c | 2 ++
>>  drivers/pci/pci.h                           | 7 +++++++
>>  2 files changed, 9 insertions(+)
>>
>> diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
>> index fc868251e570..cbec71114825 100644
>> --- a/drivers/pci/controller/pcie-rockchip-host.c
>> +++ b/drivers/pci/controller/pcie-rockchip-host.c
>> @@ -325,6 +325,8 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
>>  	msleep(PCIE_T_PVPERL_MS);
>>  	gpiod_set_value_cansleep(rockchip->ep_gpio, 1);
>>  
>> +	msleep(PCIE_T_RRS_READY_MS);
>> +
>>  	/* 500ms timeout value should be enough for Gen1/2 training */
>>  	err = readl_poll_timeout(rockchip->apb_base + PCIE_CLIENT_BASIC_STATUS1,
>>  				 status, PCIE_LINK_UP(status), 20,
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index 17fed1846847..c93ffc5e6e1f 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -16,6 +16,13 @@
>>  /* Power stable to PERST# inactive from PCIe card Electromechanical Spec */
>>  #define PCIE_T_PVPERL_MS		100
>>  
>> +/*
>> + * End of conventional reset (PERST# de-asserted) to first configuration
>> + * request (device able to respond with a "Request Retry Status" completion),
>> + * from PCI Express Base Specification r6.0, section 6.6.1.
> 
> "PCIe r6.0, sec 6.6.1" to match typical style, e.g., the reference
> just below.
> 
> Whoever applies this can take care of this.

To make it easier to apply, I sent v4 with the corrections. Thanks.

> 
>> +#define PCIE_T_RRS_READY_MS	100
> 
> Thanks a lot for doing this; there are many similar places we can
> update to use this #define.
> 
>>  /*
>>   * PCIe r6.0, sec 5.3.3.2.1 <PME Synchronization>
>>   * Recommends 1ms to 10ms timeout to check L2 ready.
>> -- 
>> 2.44.0
>>

-- 
Damien Le Moal
Western Digital Research


