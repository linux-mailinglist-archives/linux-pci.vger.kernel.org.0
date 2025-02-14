Return-Path: <linux-pci+bounces-21432-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED77A358FF
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 09:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 145411890A7D
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 08:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93F71F8908;
	Fri, 14 Feb 2025 08:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="X7bOPsEA"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81972158D96;
	Fri, 14 Feb 2025 08:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739522219; cv=none; b=HMnAJUv9oo/NLp3Y2J1CrDLIYuB75329JJY5t1bMFLDftqxZRaYKw8WZ4d9cu/tdsYw0tyaLqiJ97Krc1KE/BZ+bho1jnFegpGDw8oRXh1c7N7e0mOnGIDtLQLKT2K/gJT7H5FCy9A1IRjWg1XXGaC6RADsN/VeiFilrBKIvs9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739522219; c=relaxed/simple;
	bh=DP1bZDqHbhMk9Mgs44/molM374HfwtjOUl6yfRN6Jz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MRWocfdB2YLow0joe55IjQSOxOOlFbCNiMr6MCk9TusXgZKr3M5xgix6hXQXmU+64v3aHQPCKdTBzi5/+nMqOGuNMhgjaMtGIO9JNP0mK2yJ7bM18OdI+0oFKL+uhlfZ5xVHgktAcqvh7q56Qqof6JJVOWB1RP9Qg+8Hv2cx4JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=X7bOPsEA; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=Z3f5umrZkA9R6vcNxKZuVbQK7YsIjE6lF/DNaSrj2mk=;
	b=X7bOPsEAwf5jsoBwgte7K+SQI5BlSHdvIVePpSpDfG2BezM/FuNqwMVXBXCQAY
	j87STwLct9KW526H33bxjVG6my31mg+IpPMo2Y2ntoyrxa7Uk155ESRBokmGTZIW
	SRRe8Wp6NjfwSVwspSO5kHfv4SrjfIN7hs4G+VmTNyBlk=
Received: from [192.168.243.52] (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wC31vkVAK9nXwGDLg--.14183S2;
	Fri, 14 Feb 2025 16:34:31 +0800 (CST)
Message-ID: <33191017-b12c-44a2-92dc-44a7d0e79bd0@163.com>
Date: Fri, 14 Feb 2025 16:34:29 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2] PCI: dwc: Add the debugfs property to provide the LTSSM
 status of the PCIe link
To: Niklas Cassel <cassel@kernel.org>
Cc: jingoohan1@gmail.com, shradha.t@samsung.com,
 manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org, kw@linux.com,
 robh@kernel.org, bhelgaas@google.com, Frank.Li@nxp.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, rockswang7@gmail.com
References: <20250206151343.26779-1-18255117159@163.com>
 <Z64C7dzY3J7hCbZy@ryzen>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <Z64C7dzY3J7hCbZy@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wC31vkVAK9nXwGDLg--.14183S2
X-Coremail-Antispam: 1Uf129KBjvJXoWrurW5WF1UJFy7WFyUGFW7Jwb_yoW8JF1xpa
	ykJayFyr4qyry8trySvanrZr1SqFn5ur47C34jyFyIv3sFvry8CFn7J3yak3s3Cr4Yy3W5
	Aa15J34xGwn8JaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UQ18PUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWxrzo2eu9yyeQQABsd



On 2025/2/13 22:34, Niklas Cassel wrote:
>> +int dwc_pcie_debugfs_init(struct dw_pcie *pci)
>> +{
>> +	char dirname[DWC_DEBUGFS_BUF_MAX];
>> +	struct device *dev = pci->dev;
>> +	struct dentry *dir;
>> +	int ret;
>> +
>> +	/* Create main directory for each platform driver */
>> +	snprintf(dirname, DWC_DEBUGFS_BUF_MAX, "dwc_pcie_%s", dev_name(dev));
>> +	dir = debugfs_create_dir(dirname, NULL);
>> +	if (IS_ERR(dir))
>> +		return PTR_ERR(dir);
>> +
>> +	pci->debugfs = dir;
>> +	ret = dwc_pcie_rasdes_debugfs_init(pci, dir);
>> +	if (ret)
>> +		dev_dbg(dev, "rasdes debugfs init failed\n");
>> +
>> +	dwc_pcie_ltssm_debugfs_init(pci, dir);
>> +
>> +	return 0;
>> +}
>> +
> 
> Stray newline here.
> This causes:
> 
> /home/nks/src/linux/.git/worktrees/linux-scratch/rebase-apply/patch:136: new blank line at EOF.
> +
> warning: 1 line adds whitespace errors.
> 
> when doing git am.
> 
> 
> Also, this patch does not apply anymore, because of a conflict introduce by:
> 112aba9a7934 ("PCI: dwc: Remove LTSSM state test in dw_pcie_suspend_noirq()")
> 
> Which added:
> +       DW_PCIE_LTSSM_DETECT_WAIT = 0x6,
> to drivers/pci/controller/dwc/pcie-designware.h
> 

Thank you very much, Niklas.

I will git pull the latest code and fix it.


Best regards
Hans


