Return-Path: <linux-pci+bounces-29650-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E3EAD83D2
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 09:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4EE43A0B53
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 07:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53B62749E6;
	Fri, 13 Jun 2025 07:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GS31FY1/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5372749D3;
	Fri, 13 Jun 2025 07:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749798699; cv=none; b=Qx+/nGK/fQ+ftocPuGL4kMuARRnJxn8sPB0m4CgWgL5D3Hc7zrt7IOXKpM+3k6ktu8fPeaae5PVlbISvoIHf/VQEdMdgxqCs/r7BYYVZrNRXVqxU7jL7scysHjgTTABWQ00Hk6odpvGg3H0ah7hI+N1B5i/ZBUs9lNqB95LWmlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749798699; c=relaxed/simple;
	bh=1FujxIW/faguNrJw8+wcNmLjc6X4I+pRlk7jkdBUCFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VxQjG5NB00Eu88RLAZMELqFQM4B3Wh0QBO0DKhI7U6yeGyAoLFo33L5eUGh+ROrl3rJMdyO8G1dBsSx5CKiPjIjjfDpfV8HnNX6f4VhMbaOWoV1IldzCORcnXh9833Hy2SZtrmqdL7RCODq/bfCtKvHrIs6rHSyW1Hm5pIHSqw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GS31FY1/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF081C4CEED;
	Fri, 13 Jun 2025 07:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749798698;
	bh=1FujxIW/faguNrJw8+wcNmLjc6X4I+pRlk7jkdBUCFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GS31FY1/oUNhPVYrgd50uEVLmUg4fGLA/Pm/rGd2aNcWfUizLZBnqZKJZo25i+B36
	 l2sHDdUk/53j2vGbfI8UW2B4YTWfap0fLel7TCcbFk7w3IfT0A8Q76fp+3eq1sCmqo
	 LxPQMcTsdnvaE1EHE6oLXTHrqI/YN7pChTkd4nWjw1FAuq7ZwYyZ2w6Q2wume7HTs9
	 JWE9e4V/tLdfBKgaFBrpkqXTiRbbgrvVz9kZmJK6XaiaxZ39MBYRLC9Q5UZCk5eHgr
	 L4UcuhfMG/QAV+OS74+3Evfh3CFoVbej9P3b5eoTL0OaRtRDmPXnO0//2sLWMYk1jX
	 xYMW3KiqjVKmw==
Date: Fri, 13 Jun 2025 12:41:29 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>, 
	Xuefeng Li <lixuefeng@loongson.cn>, Huacai Chen <chenhuacai@gmail.com>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, Hongchen Zhang <zhanghongchen@loongson.cn>, 
	stable@vger.kernel.org
Subject: Re: [PATCH V3 1/2] PCI: Use local_pci_probe() when best selected cpu
 is offline
Message-ID: <r6qqyt7dqa32hlpvn63ajxc6rcwkwtjkpcro3zdiwtoiuglz5s@ed5v3ytdcgs4>
References: <20250511083413.3326421-1-chenhuacai@loongson.cn>
 <20250511083413.3326421-2-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250511083413.3326421-2-chenhuacai@loongson.cn>

On Sun, May 11, 2025 at 04:34:12PM +0800, Huacai Chen wrote:
> From: Hongchen Zhang <zhanghongchen@loongson.cn>
> 
> When the best selected CPU is offline, work_on_cpu() will stuck forever.
> This can be happen if a node is online while all its CPUs are offline
> (we can use "maxcpus=1" without "nr_cpus=1" to reproduce it), Therefore,
> in this case, we should call local_pci_probe() instead of work_on_cpu().
> 

Just curious, did you encounter this problem in a real world usecase or just
found the issue while playing with maxcpus/nr_cpus parameters?

> Cc: <stable@vger.kernel.org>

I believe the fixes tag for this patch is 873392ca514f8.

- Mani

> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
> ---
>  drivers/pci/pci-driver.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index c8bd71a739f7..602838416e6a 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -386,7 +386,7 @@ static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
>  		free_cpumask_var(wq_domain_mask);
>  	}
>  
> -	if (cpu < nr_cpu_ids)
> +	if ((cpu < nr_cpu_ids) && cpu_online(cpu))
>  		error = work_on_cpu(cpu, local_pci_probe, &ddi);
>  	else
>  		error = local_pci_probe(&ddi);
> -- 
> 2.47.1
> 

-- 
மணிவண்ணன் சதாசிவம்

