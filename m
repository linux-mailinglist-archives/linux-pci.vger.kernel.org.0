Return-Path: <linux-pci+bounces-7818-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2C98CE7CF
	for <lists+linux-pci@lfdr.de>; Fri, 24 May 2024 17:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B6AF1F21213
	for <lists+linux-pci@lfdr.de>; Fri, 24 May 2024 15:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C464712C49D;
	Fri, 24 May 2024 15:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a0sGCF2r"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12531EC7
	for <linux-pci@vger.kernel.org>; Fri, 24 May 2024 15:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716564298; cv=none; b=oMR4QZUWBlpYvEJYIghr4dmao7CMPIoku+pzKA64mL0X4jNHfRPMTQZoz3mhiRs5ZsU9fQV7SMqQSFaTbh/ssyj+DuKzZMZzm4/Uo1c5V0BhKiBbtKPqysiH+YQZtJjZ9xkToi2koV7JIt6kOkrFWSZTfBA0GLHcA+bJMUySOdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716564298; c=relaxed/simple;
	bh=BeMaca235xewFPAx0PvO35sjrAhkdYkAuY4wkzJRxUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YD3Yp8NkJkSytrDEqpkMguNBhdrS62czh0CxdbDYEbDq4UwXKgSPMNMx/iVVvutJXOB2fx8HqaPLfJIFr8b6Om7yoL2LJuuEbz838J8tO/GSCSuOwaLlf/AKftnbW6osEGDLguCog7+TB7xIRA1nAAbLUJIQb5+rT0lgUh+RNJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a0sGCF2r; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: dan.carpenter@linaro.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716564295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YppIzif2hxqccFPGz5Hh9YVI07X4BAYIHIW3FdSSYI8=;
	b=a0sGCF2rK1ld2MDtZzDa0eIKGoJkLuPxHmZEW2SSnIbBPw8eK6JFMoJiX8h6mafiQ/Oflq
	oKgLX3IlrBobG6P83hn6nuigck86TTtz5nKK1KbcEt4KbQp5BJTZvREzFCHZY6rIQgfBF2
	v5zc63X24LZypUwGBDrJdQnrhcQqC8E=
X-Envelope-To: lpieralisi@kernel.org
X-Envelope-To: kw@linux.com
X-Envelope-To: robh@kernel.org
X-Envelope-To: linux-pci@vger.kernel.org
X-Envelope-To: michal.simek@amd.com
X-Envelope-To: thippeswamy.havalige@amd.com
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: bhelgaas@google.com
X-Envelope-To: linux-kernel@vger.kernel.org
Message-ID: <d58dafb1-fce5-478a-bf05-1a80256f2df6@linux.dev>
Date: Fri, 24 May 2024 11:24:50 -0400
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 6/7] PCI: xilinx-nwl: Add phy support
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
 Michal Simek <michal.simek@amd.com>,
 Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
 linux-arm-kernel@lists.infradead.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-kernel@vger.kernel.org
References: <20240520145402.2526481-1-sean.anderson@linux.dev>
 <20240520145402.2526481-7-sean.anderson@linux.dev>
 <41d89132-f6bb-4feb-af1d-412206a85afa@moroto.mountain>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <41d89132-f6bb-4feb-af1d-412206a85afa@moroto.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/24/24 10:59, Dan Carpenter wrote:
> On Mon, May 20, 2024 at 10:54:01AM -0400, Sean Anderson wrote:
>> +static int nwl_pcie_phy_enable(struct nwl_pcie *pcie)
>> +{
>> +	int i, ret;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(pcie->phy); i++) {
>> +		ret = phy_init(pcie->phy[i]);
>> +		if (ret)
>> +			goto err;
>> +
>> +		ret = phy_power_on(pcie->phy[i]);
>> +		if (ret) {
>> +			WARN_ON(phy_exit(pcie->phy[i]));
>> +			goto err;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +
>> +err:
>> +	while (--i) {
> 
> This doesn't work.  If we fail on the first iteration, then it will
> lead to an array underflow.  It should be while (--i >= 0) or
> while (i--).  I prefer the first, but the second format works for people
> who use unsigned iterators.

Thanks, will fix.

--Sean

>> +		WARN_ON(phy_power_off(pcie->phy[i]));
>> +		WARN_ON(phy_exit(pcie->phy[i]));
>> +	}
>> +
>> +	return ret;
>> +}
> 
> regards,
> dan carpenter
> 


