Return-Path: <linux-pci+bounces-7814-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 351848CE736
	for <lists+linux-pci@lfdr.de>; Fri, 24 May 2024 16:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E12291F21950
	for <lists+linux-pci@lfdr.de>; Fri, 24 May 2024 14:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AEA912BF30;
	Fri, 24 May 2024 14:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="W+6sNU+8"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3546184D30
	for <linux-pci@vger.kernel.org>; Fri, 24 May 2024 14:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716561513; cv=none; b=UodwcefbFyhL3UlcEf3jMDQvUnhgEwpOAeIENsXIWcxYvWDUBMhvLXCHnFDfQFcGIq7cWQutZqdbgAJBS/Xf9gHVWG4KbwmKOip/LBvqRsxooTNP/l8yJMMGxTcwy3sAEHfrTp/kbDPsKsMncCR/73DHgnW5BXjh7T1WPfuLexM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716561513; c=relaxed/simple;
	bh=P0oGiXPwUYgxEc8MMGLYiqhD0U1U/yW8vDU6/y/HYA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lkjETtjA8Z5p4Y/Y/chRZVAJfHFtCJA15axry/L8eolPgFf9HxbtKPwsC1cZnUlzdIep1eBcIKkG2gG88Nz83k4TkVpePhJto+S62Gcglo0O0ahJhbF4tcHIg6OKpD6DENdNoFBbJfmof5bm/yqhmSxQrgwYohUY6pA54ynJ3CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=W+6sNU+8; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: markus.elfring@web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716561508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KNBYTib7bUrTL43Ki1euUCce0RgdF7TpezQWmMPaS+0=;
	b=W+6sNU+8P+CQXEFhRbBWKO7eHkid0PNn/SrR8Ctd1eIuq/OVVzJbS8HWe469L3WfSuZSvW
	jv4AxCVIjSyIS1kVjuGpkGKjBhOvGeJEQhIYV9e3TFpCIX+JY6NIHRPZ+ibvMr8f8ZuqD4
	f2QaMZbCPnVfA+1kzyv6TuGv0jbQqYg=
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: linux-pci@vger.kernel.org
X-Envelope-To: kernel-janitors@vger.kernel.org
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
Message-ID: <ad8da38a-5e3d-4f79-8744-66acf73703af@linux.dev>
Date: Fri, 24 May 2024 10:38:23 -0400
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 6/7] PCI: xilinx-nwl: Add phy support
To: Markus Elfring <Markus.Elfring@web.de>,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 kernel-janitors@vger.kernel.org, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kw@linux.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Rob Herring <robh@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Michal Simek <michal.simek@amd.com>, Michal Simek <michal.simek@xilinx.com>,
 Thippeswamy Havalige <thippeswamy.havalige@amd.com>
References: <20240520145402.2526481-7-sean.anderson@linux.dev>
 <89d6acd5-5008-4db3-927c-d267be7b9302@web.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <89d6acd5-5008-4db3-927c-d267be7b9302@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 5/24/24 04:16, Markus Elfring wrote:
>> Add support for enabling/disabling PCIe phys. We can't really do
>> anything about failures in the disable/remove path, so just warn.
> …
>> +++ b/drivers/pci/controller/pcie-xilinx-nwl.c
> …
>> @@ -818,12 +876,15 @@ static int nwl_pcie_probe(struct platform_device *pdev)
>>  		err = nwl_pcie_enable_msi(pcie);
>>  		if (err < 0) {
>>  			dev_err(dev, "failed to enable MSI support: %d\n", err);
>> -			goto err_clk;
>> +			goto err_phy;
>>  		}
>>  	}
>>
>>  	err = pci_host_probe(bridge);
>>
>> +err_phy:
>> +	if (err)
>> +		nwl_pcie_phy_disable(pcie);
>>  err_clk:
>>  	if (err)
>>  		clk_disable_unprepare(pcie->clk);
> 
> I got the impression that some source code adjustments should be performed
> in another separate update step for this function implementation.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.9#n81
> 
> You propose to extend the exception handling here.
> Does such information indicate a need for another tag “Fixes”?

Huh? I am only disabling what I enabled...

--Sean

