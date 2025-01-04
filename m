Return-Path: <linux-pci+bounces-19298-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39604A01369
	for <lists+linux-pci@lfdr.de>; Sat,  4 Jan 2025 09:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3B5B3A44C9
	for <lists+linux-pci@lfdr.de>; Sat,  4 Jan 2025 08:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD41A433B3;
	Sat,  4 Jan 2025 08:53:13 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CFA13FD83;
	Sat,  4 Jan 2025 08:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735980793; cv=none; b=RD4dtPQ6gxDuO1Y1hJ9wkeuAiUNSsXu30hCNKz4pvBSY5HN5UwI14mb8UkcH+XGdcj8B4LWpjJfSypmRHX4XOTa8tL8QMdcU8nTYKO1liqQo0XJPuR83N5TNTYb9q1ikXNQbJzDZrSIVVf61/67ymjM5JDfkAFkejV/KZznoOmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735980793; c=relaxed/simple;
	bh=Rnx7AvPJ/Nt5jm1Mb12jy+VXzcwtUez2+aAy1eZFTG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HiwFEzb6ydG4GIFmcJE2nCTy8xHjQaN5qmnTYTdHwbqdIaa0X7xNWGA3PpcM7Sawu9Ksn3dVoRUXa7cCcqOyLIVb+QpcTBM4WKZ6LCyBX+Ts6R022204okFn1kJQByHPJrCpjAy+su1Y0xjBLT+w/XmY6KxEoStxXkqVlFf0POk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.2.102] (213.87.90.50) by msexch01.omp.ru (10.188.4.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Sat, 4 Jan
 2025 11:37:50 +0300
Message-ID: <5f8d43fe-25e3-450d-b5c2-2d69b9bc9923@omp.ru>
Date: Sat, 4 Jan 2025 11:37:47 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: rcar-ep: Fix the issue of the name parameter when
 calling devm_request_mem_region
To: <kingdix10@qq.com>, <marek.vasut+renesas@gmail.com>,
	<yoshihiro.shimoda.uh@renesas.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <tencent_59625EFD404130F5900D6FB48840AD428F05@qq.com>
Content-Language: en-US
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
In-Reply-To: <tencent_59625EFD404130F5900D6FB48840AD428F05@qq.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 01/04/2025 08:15:05
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 190178 [Jan 03 2025]
X-KSE-AntiSpam-Info: Version: 6.1.1.7
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 49 0.3.49
 28b3b64a43732373258a371bd1554adb2caa23cb
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 213.87.90.50 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 213.87.90.50 in (user) dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 213.87.90.50
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 19
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 01/04/2025 08:18:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 1/4/2025 6:00:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 1/4/25 6:39 AM, kingdix10@qq.com wrote:

> From: King Dix <kingdix10@qq.com>
> 
> When using devm_request_mem_region to request a resource, if the passed
> variable is a stack string variable, it will lead to an oops issue when
> eecuting the command cat /proc/iomem.
> 
> Fix this by replacing outbound_name with the name of the previously
> requested resource.
> 
> Signed-off-by: King Dix <kingdix10@qq.com>
> ---
>  drivers/pci/controller/pcie-rcar-ep.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-rcar-ep.c b/drivers/pci/controller/pcie-rcar-ep.c
> index 047e2cef5afc..464f8f29390c 100644
> --- a/drivers/pci/controller/pcie-rcar-ep.c
> +++ b/drivers/pci/controller/pcie-rcar-ep.c
> @@ -107,7 +107,7 @@ static int rcar_pcie_parse_outbound_ranges(struct rcar_pcie_endpoint *ep,
>  		}
>  		if (!devm_request_mem_region(&pdev->dev, res->start,
>  					     resource_size(res),
> -					     outbound_name)) {
> +						 res->name)) {

   Why this strange indentation?

[...]

MBR, Sergey


