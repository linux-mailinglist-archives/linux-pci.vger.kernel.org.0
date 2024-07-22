Return-Path: <linux-pci+bounces-10585-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E574938A3C
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2024 09:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 402D01C210BE
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2024 07:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094BA14882E;
	Mon, 22 Jul 2024 07:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kXWj5Gsx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D7313E02A;
	Mon, 22 Jul 2024 07:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721633997; cv=none; b=oL5W133vZCyUIDj9kbFjfFc8orH0vj02xD5lJlWljW4AEYVIhH/o2BHlGp5yQ9k7NWalvjnlhrwk4K+U3lE9pIp/1X90J2CELw/qi1Kai5q2DxrWWtQY8FwKHj+rM0c6ma8cURJEljVOJ2aexlhSdKx8mc4I0f7egA+YdP3YUWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721633997; c=relaxed/simple;
	bh=oEC/Lwj06wbQoxnr7za85dRZRUfGfj8vnerb6oSYZsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H4DeUgBwdPZFbGIP/+KcxtwCRIUOeYnOHbQSmQMt8gAbRFKljDSrX3svYoLH17obZnqEp+36bm9r3a2zIGMp/0QajH9gZw6VLDdzFaQSl2eYLh9hApczZWLQrvznjphTtVvc8YWoX3bfnWPPLNnA3tZwfIpnaD7d9dEx1CC2j1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kXWj5Gsx; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721633996; x=1753169996;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oEC/Lwj06wbQoxnr7za85dRZRUfGfj8vnerb6oSYZsY=;
  b=kXWj5GsxCfr4Lz3N9VQfIStN1d2zPYQ+3W1cy+viGUx7/6f/Yf3DH1tm
   7dJD8pGEoqUq/8BtlZk2G26tZPb9xmfA1kFWz9/3mZKoqDDkoVrqAh7Ub
   FdQMSRO6NvoAzqLR89/c3epocnnyXGv41Ftr1e8yaSozqkCdrRrX4bUvt
   NBzeomwQXE6W2FiOJbtHzxCY80Jv9VIZk45N5BdLXbKDjueihOK9Mmt+k
   SzRpmjPGODZYuD4DlRfpGWi4YHefDLNb80/9QFhk8I5ggEQQeOJQxE1d/
   GA78IfTz5KMJmUVQq+VsWHEeXVvsy0D8UHdjdcifA8cQW/jqUVK741OWL
   A==;
X-CSE-ConnectionGUID: m6LP8fHvROCM2PYTjLFtSQ==
X-CSE-MsgGUID: ITFtoqCBQiiSUfVw45dtFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11140"; a="19060490"
X-IronPort-AV: E=Sophos;i="6.09,227,1716274800"; 
   d="scan'208";a="19060490"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 00:39:55 -0700
X-CSE-ConnectionGUID: QNdvz+AqRJqOcXLuZw/r2Q==
X-CSE-MsgGUID: cevTNEMIRiG/a1AZaeCigQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,227,1716274800"; 
   d="scan'208";a="55971761"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.249.175.144]) ([10.249.175.144])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 00:39:51 -0700
Message-ID: <a50b3865-8a04-4a9a-8d27-b317619a75c0@linux.intel.com>
Date: Mon, 22 Jul 2024 15:39:39 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI: pci_call_probe: call local_pci_probe() when
 selected cpu is offline
To: Hongchen Zhang <zhanghongchen@loongson.cn>,
 Markus Elfring <Markus.Elfring@web.de>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Alex Belits <abelits@marvell.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Nitesh Narayan Lal <nitesh@redhat.com>,
 Frederic Weisbecker <frederic@kernel.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 stable@vger.kernel.org, Huacai Chen <chenhuacai@loongson.cn>
References: <20240613074258.4124603-1-zhanghongchen@loongson.cn>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <20240613074258.4124603-1-zhanghongchen@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/13/2024 3:42 PM, Hongchen Zhang wrote:
> Call work_on_cpu(cpu, fn, arg) in pci_call_probe() while the argument
> @cpu is a offline cpu would cause system stuck forever.
>
> This can be happen if a node is online while all its CPUs are
> offline (We can use "maxcpus=1" without "nr_cpus=1" to reproduce it).
>
> So, in the above case, let pci_call_probe() call local_pci_probe()
> instead of work_on_cpu() when the best selected cpu is offline.
>
> Fixes: 69a18b18699b ("PCI: Restrict probe functions to housekeeping CPUs")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
> ---
> v2 -> v3: Modify commit message according to Markus's suggestion
> v1 -> v2: Add a method to reproduce the problem
> ---
>   drivers/pci/pci-driver.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index af2996d0d17f..32a99828e6a3 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -386,7 +386,7 @@ static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
>   		free_cpumask_var(wq_domain_mask);
>   	}
>   
> -	if (cpu < nr_cpu_ids)

Why not choose the right cpu to callwork_on_cpu() ? the one that is online. Thanks, Ethan

> +	if ((cpu < nr_cpu_ids) && cpu_online(cpu))
>   		error = work_on_cpu(cpu, local_pci_probe, &ddi);
>   	else
>   		error = local_pci_probe(&ddi);

