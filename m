Return-Path: <linux-pci+bounces-7800-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE30C8CDB3F
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2024 22:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46D52B21C15
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2024 20:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B3084D30;
	Thu, 23 May 2024 20:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gaTRJS5V"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29DA82D91
	for <linux-pci@vger.kernel.org>; Thu, 23 May 2024 20:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716495533; cv=none; b=pg3PI51a4rTPRdcw9iQjuYiRuSU9yJNRMXr9t6NYLTklD/yjONWcOw/pSNghI4Bd1NxHFCkg1Vgn4663gveUYnfEzvoUIOqtg2J/ic9FDAOlcBARwT5tTQKk5FT0OVa894Rb8Sn7aWucllXnpou6R1XZQ9ax2DenBICw15UIHT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716495533; c=relaxed/simple;
	bh=/MnKLO3shXWEZFBIMAsNwFyC317yrwWObfqwNCUloow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uLK5n+HdEdc56vKgO08fAYaADW1mkkiLSrVxFxYPCynDTMYBboh7R5K5GkFGO8m2cjiw+6ieoaIRpazUHlnIvhOxYFU46Swtm/mz8ARceODfHtbrRGjoP8ZTjWNe8BF1rTAfQrXqoRTlOLbn4xTfZZwgd2DJdH9C9gO3ShAJM2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gaTRJS5V; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: markus.elfring@web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716495529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b6Wt/yr5KVLoM5TaMmIZdJgpIFHqeGyswfXtkHFJYik=;
	b=gaTRJS5V2i8CsvTKTxwRH7Eml035EyZJldaxir3Sy+sotgCbBJPtXmN/qy9ArbajrCZDTT
	JOBGcTzNEuizdoJjis4+R4rfFC2+2MVjzOGuQokAaLayUNBE4c+kNtnozpyW7q24rOveS4
	lOld6QJrNva6uNYLTJQSyuQdjTJv25g=
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: linux-pci@vger.kernel.org
X-Envelope-To: kw@linux.com
X-Envelope-To: lpieralisi@kernel.org
X-Envelope-To: robh@kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: bharat.kumar.gogada@xilinx.com
X-Envelope-To: bhelgaas@google.com
X-Envelope-To: lorenzo.pieralisi@arm.com
X-Envelope-To: michal.simek@amd.com
X-Envelope-To: michal.simek@xilinx.com
X-Envelope-To: thippeswamy.havalige@amd.com
Message-ID: <f42151e1-d62e-4346-9acc-0aa10ca52ba9@linux.dev>
Date: Thu, 23 May 2024 16:18:42 -0400
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 5/7] PCI: xilinx-nwl: Clean up clock on probe
 failure/removal
To: Markus Elfring <Markus.Elfring@web.de>,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Michal Simek <michal.simek@amd.com>, Michal Simek <michal.simek@xilinx.com>,
 Thippeswamy Havalige <thippeswamy.havalige@amd.com>
References: <20240520145402.2526481-6-sean.anderson@linux.dev>
 <4a43cda4-dfa4-4156-b616-75e740f6fd64@web.de>
 <bb9e239f-902b-4f52-a5e9-98c29b360418@linux.dev>
 <f541195e-7963-4970-9a1d-a3298226cdd5@web.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <f541195e-7963-4970-9a1d-a3298226cdd5@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 5/23/24 16:11, Markus Elfring wrote:
>>> …
>>>> +++ b/drivers/pci/controller/pcie-xilinx-nwl.c
>>> …
>>>> @@ -817,11 +818,23 @@ static int nwl_pcie_probe(struct platform_device *pdev)
>>>>  		err = nwl_pcie_enable_msi(pcie);
>>>>  		if (err < 0) {
>>>>  			dev_err(dev, "failed to enable MSI support: %d\n", err);
>>>> -			return err;
>>>> +			goto err_clk;
>>>>  		}
>>>>  	}
>>>>
>>>> -	return pci_host_probe(bridge);
>>>> +	err = pci_host_probe(bridge);
>>>> +
>>>> +err_clk:
>>>> +	if (err)
>>>> +		clk_disable_unprepare(pcie->clk);
>>>
>>> I suggest to use the label “disable_unprepare_clock” directly before this function call
>>> (in the if branch) so that a duplicate check would be avoided after some error cases.
>>
>> Well if you want to avoid a check, we can just do
>>
>> err = pci_host_probe(bridge);
>> if (!err)
>> 	return 0;
>>
>> err_clk:
>> 	...
> 
> This design variant can also be reasonable.
> 
> Do any preferences matter here for label name selections?

Personally, I prefer to use labels named after what they're cleaning up and not what they're doing.

--Sean

