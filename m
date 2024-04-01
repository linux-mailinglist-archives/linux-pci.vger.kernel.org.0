Return-Path: <linux-pci+bounces-5470-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3567A893882
	for <lists+linux-pci@lfdr.de>; Mon,  1 Apr 2024 08:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C23991F21217
	for <lists+linux-pci@lfdr.de>; Mon,  1 Apr 2024 06:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036548C1E;
	Mon,  1 Apr 2024 06:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FGqRYffX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B6E29AF
	for <linux-pci@vger.kernel.org>; Mon,  1 Apr 2024 06:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711954788; cv=none; b=JQLFHrQlcoS6LfAUZfIvYljjYFHfodHFFhxMZg+3/Ih7Mcc2w3HVwZ1bNRu/jJSwIYlBGc/5aG4MODeHz8iIGwVXoeyS8vnlKb3mY3Xf+AJUkJ6QSqecR1I05Q7ossMtMLfBGyHIQK+kPQ0mM5LjLvs4VutuU9KFEQDxBl5M/go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711954788; c=relaxed/simple;
	bh=BO4iEbJ+EDNgglvq3pj+mwN8DBXIKP7Kmy2BunCGATA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LaVxlPxWBHbmAW5FQ57Ac3+aoSKK9nAmQufyI2cbGh9UvqFCScBVrSmrP21QGcWqrYOCli6y9IonXruOabjbLQtuhpmHeVdGCaEtcoeYVvKG5iSw/m9xMrE4HkT40lJxoP7z2bb7v4R/oVlDNKQZU2NCiCgrrzh6RNUp6cBo9wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FGqRYffX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FA0BC433C7;
	Mon,  1 Apr 2024 06:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711954788;
	bh=BO4iEbJ+EDNgglvq3pj+mwN8DBXIKP7Kmy2BunCGATA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FGqRYffX7Mv/eeLxf0LkcvIAqyQu4gv1B05jBvXz2sa0pL9iIS6uqBuo49RptEPb7
	 JITpYYt8nKks+EsoVlU64PpRthDQjqJLltI0qoRChRbw2MWVtiX2Y6yT8JOP9pCb7z
	 6VF9FPmE09mv3SNaoOC2pRjC3sMpEsjH5WOI3ZZ8FGi4w6w0HOVh23t0QiFjlSx9en
	 XOqyyefruVdEVWBEN/UIJtj8xQoJLh6WygZFqK+lso95kYUXjcRozGGUhPfPPd0J/N
	 +WPdzlYmPXnlWvEW4/veweKx7VYNr6vG2V2TyAUvxOUOJylVmUab7F+o7WFM93ow2V
	 A6ff7Ehehg1JA==
Message-ID: <89eb3414-38ba-4397-9ed7-aebebbdadd07@kernel.org>
Date: Mon, 1 Apr 2024 15:59:45 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: rockchip-host: Fix rockchip_pcie_host_init_port()
 PERST# handling
To: Dragan Simic <dsimic@manjaro.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>,
 linux-pci@vger.kernel.org, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org
References: <20240330035043.1546087-1-dlemoal@kernel.org>
 <d1ed4a0bf702d9927d4e9279f19bcf7b@manjaro.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <d1ed4a0bf702d9927d4e9279f19bcf7b@manjaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/1/24 04:34, Dragan Simic wrote:
> Hello Damien,
> 
> Please see my comments below.
> 
> On 2024-03-30 04:50, Damien Le Moal wrote:
>> The PCIe specifications (PCI Express Electromechanical Specification 
>> rev
>> 2.0, section 2.6.2) mandate that the PERST# signal must remain asserted
>> for at least 100 usec (Tperst-clk) after the PCIe reference clock
>> becomes stable (if a reference clock is supplied), for at least 100 
>> msec
>> after the power is stable (Tpvperl).
>>
>> In addition, the PCI Express Base SPecification Rev 2.0, section 6.6.1
>> state that the host should wait for at least 100 msec from the end of a
>> conventional reset (PERST# is de-asserted) before accessing the
>> configuration space of the attached device.
>>
>> Modify rockchip_pcie_host_init_port() by adding two 100ms sleep, one
>> before and after bringing back PESRT signal to high using the ep_gpio
>> GPIO. Comments are also added to clarify this behavior.
>>
>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>> ---
>>
>> Changes from v1:
>>  - Add more specification details to the commit message.
>>  - Add missing msleep(100) after PERST# is deasserted.
>>
>>  drivers/pci/controller/pcie-rockchip-host.c | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/pci/controller/pcie-rockchip-host.c
>> b/drivers/pci/controller/pcie-rockchip-host.c
>> index 300b9dc85ecc..ff2fa27bd883 100644
>> --- a/drivers/pci/controller/pcie-rockchip-host.c
>> +++ b/drivers/pci/controller/pcie-rockchip-host.c
>> @@ -294,6 +294,7 @@ static int rockchip_pcie_host_init_port(struct
>> rockchip_pcie *rockchip)
>>  	int err, i = MAX_LANE_NUM;
>>  	u32 status;
>>
>> +	/* Assert PERST */
>>  	gpiod_set_value_cansleep(rockchip->ep_gpio, 0);
>>
>>  	err = rockchip_pcie_init_port(rockchip);
>> @@ -322,8 +323,19 @@ static int rockchip_pcie_host_init_port(struct
>> rockchip_pcie *rockchip)
>>  	rockchip_pcie_write(rockchip, PCIE_CLIENT_LINK_TRAIN_ENABLE,
>>  			    PCIE_CLIENT_CONFIG);
>>
>> +	/*
>> +	 * PCIe CME specifications mandate that PERST be asserted for at
>> +	 * least 100ms after power is stable.
>> +	 */
>> +	msleep(100);
> 
> Perhaps it would be slightly better to use usleep_range()
> instead of msleep().

I can do that, but I fail to see the advantage. Why do you say that it may be
better ?

> 
>>  	gpiod_set_value_cansleep(rockchip->ep_gpio, 1);
>>
>> +	/*
>> +	 * PCIe base specifications rev 2.0 mandate that the host wait for
>> +	 * 100ms after completion of a conventional reset.
>> +	 */
>> +	msleep(100);
> 
> Obviously, the same comment as above applies here.
> 
>> +
>>  	/* 500ms timeout value should be enough for Gen1/2 training */
>>  	err = readl_poll_timeout(rockchip->apb_base + 
>> PCIE_CLIENT_BASIC_STATUS1,
>>  				 status, PCIE_LINK_UP(status), 20,

-- 
Damien Le Moal
Western Digital Research


