Return-Path: <linux-pci+bounces-33550-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF07BB1D7CE
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 14:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF12B3A2D8F
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 12:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322F223F422;
	Thu,  7 Aug 2025 12:24:36 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCEC23B604;
	Thu,  7 Aug 2025 12:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754569476; cv=none; b=HkR8+1FFY5mCjeK7ReZBP8qv9Rr7aDVPxT267t7RihbnL/4OmK5demLWjsAY1x7zFx453/xByK6pxt2oSOtSfzYOzGTk6F0p60BAVcK9K1XBAHf3ypOiHiPbg51sZSavmFDDh9kh9q78HSl6qT1uqcYw2kaULmZmc1EXx2ln69s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754569476; c=relaxed/simple;
	bh=TNU1nS7W+ucvhTlR0cpmz01C5AizP0aa0FTJLe/kdn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=X6jTfCrUAfol/qzmqqhymCH1TGl729gWJCZu1sa752u7SnC08RU6aiLf9AUN3pNuj1dDlaWOCo38yUzT3gnqen6wsuanGrcndsf9xLo3fsqva3d+9eDwk2zDR+cLVccboxY9vRIqUIn0MlONsqcYHnjiw1+N/9AJSuQfOJgtpkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4byRFm0y2Vz2YPnC;
	Thu,  7 Aug 2025 20:25:32 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 2A5BC1402CA;
	Thu,  7 Aug 2025 20:24:29 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 7 Aug 2025 20:24:28 +0800
Message-ID: <8ffa0fe5-9657-31f0-6e72-246763e3b107@huawei.com>
Date: Thu, 7 Aug 2025 20:24:27 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] PCI: vmd: Fix wrong kfree() in vmd_msi_free()
Content-Language: en-US
To: Nam Cao <namcao@linutronix.de>, Nirmal Patel
	<nirmal.patel@linux.intel.com>, Jonathan Derrick
	<jonathan.derrick@linux.dev>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kwilczynski@kernel.org>, Manivannan
 Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Kenneth Crudup <kenny@panix.com>, Ammar Faizi <ammarfaizi2@gnuweeb.org>
References: <20250807063857.2175355-1-namcao@linutronix.de>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20250807063857.2175355-1-namcao@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 2025/8/7 14:38, Nam Cao wrote:
> vmd_msi_alloc() allocates struct vmd_irq and stashes it into
> irq_domain->irq-data->chip_data. vmd_msi_free() extracts the pointer by
> calling irq_get_chip_data() and frees it.
> 
> irq_get_chip_data() returns the chip_data of the top interrupt domain. This
> worked in the past, because VMD's interrupt domain was the top domain.
> 
> But since commit d7d8ab87e3e7 ("PCI: vmd: Switch to
> msi_create_parent_irq_domain()") changed the interrupt domain hierarchy,
> VMD's interrupt domain is not the top domain anymore. irq_get_chip_data()
> now returns the chip_data of the MSI devices' interrupt domain. It is
> therefore broken for vmd_msi_free() to kfree() this irq_data.
> 
> Fix this issue, correctly extract the chip_data of VMD's interrupt domain.
> 
> Fixes: d7d8ab87e3e7 ("PCI: vmd: Switch to msi_create_parent_irq_domain()")
> Reported-by: Kenneth Crudup <kenny@panix.com>
> Closes: https://lore.kernel.org/linux-pci/dfa40e48-8840-4e61-9fda-25cdb3ad81c1@panix.com/
> Reported-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
> Closes: https://lore.kernel.org/linux-pci/ed53280ed15d1140700b96cca2734bf327ee92539e5eb68e80f5bbbf0f01@linux.gnuweeb.org/
> Tested-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
> Tested-by: Kenneth Crudup <kenny@panix.com>
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
>  drivers/pci/controller/vmd.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 9bbb0ff4cc15..b679c7f28f51 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -280,10 +280,12 @@ static int vmd_msi_alloc(struct irq_domain *domain, unsigned int virq,
>  static void vmd_msi_free(struct irq_domain *domain, unsigned int virq,
>  			 unsigned int nr_irqs)
>  {
> +	struct irq_data *irq_data;
>  	struct vmd_irq *vmdirq;
>  
>  	for (int i = 0; i < nr_irqs; ++i) {
> -		vmdirq = irq_get_chip_data(virq + i);
> +		irq_data = irq_domain_get_irq_data(domain, virq + i);
> +		vmdirq = irq_data->chip_data;

Reviewed-by: Jinjie Ruan <ruanjinjie@huawei.com>

>  
>  		synchronize_srcu(&vmdirq->irq->srcu);
>  

