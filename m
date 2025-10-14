Return-Path: <linux-pci+bounces-37998-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A25CBD6E85
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 03:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9993D19A007C
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 01:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E911917F0;
	Tue, 14 Oct 2025 01:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="ZiSYeI1U"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5019E18C008
	for <linux-pci@vger.kernel.org>; Tue, 14 Oct 2025 01:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760403908; cv=none; b=NxFrBgWY9fH12lpTv7jkypwfQE7176PIV2bsV4O4CrkhHT3sDZVZSqjyTYaQLCyH5I7FNv6bOtp0M/NL9ocss4ZrfCDbY8WdNAsXYGdQdq+oYDbtNl06O2Jvcu7cR0L8ryVC9ap1q1ZKVkxQEKVM4iO31tL5yrd+fKmH0syQi2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760403908; c=relaxed/simple;
	bh=2QNjE48ZnNB8FAPZmXriz4Ia2TDBOmxaI6DMsLPWERc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lV5o44w8+CyR0hnSCrEJxYRxUN6mV0eRmZ5QXbHtODSu976jdFHy/x/VCfJCIGagIUIAShTvLgIwUcw/7RSQ4tCl6370GTUMjcZHNfgaibdoMUUNLnYrojfjNUELCTeDwlC2MqMPX78XsJ7DhPdxltFLUw0Nzeo1EOoE9adX73g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=ZiSYeI1U; arc=none smtp.client-ip=166.84.1.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from [10.50.4.39] (45-31-46-51.lightspeed.sndgca.sbcglobal.net [45.31.46.51])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4clwxD2tWrzPtp;
	Mon, 13 Oct 2025 21:05:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1760403904; bh=2QNjE48ZnNB8FAPZmXriz4Ia2TDBOmxaI6DMsLPWERc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ZiSYeI1UiG7JQrxoHV3TSr0F+y1pF1nCsC0m0V3hx2g/ih58MKb/iRXniFVjcRZw1
	 IzzZK8JgBvzSO4+cBW8TklTE0bdNjZBazLK271cxGGVZsBj+aEsQqqpwHeA89O2P92
	 p5408TaNw9BISmHRJ1hqjh5oZwIJksoGcM/K9dE0=
Message-ID: <fb1f8015-b76d-4c12-9a92-7026cae41aae@panix.com>
Date: Mon, 13 Oct 2025 18:05:03 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: commit 54f45a30c0 ("PCI/MSI: Add startup/shutdown for per device
 domains") causing boot hangs on my laptop
To: Inochi Amaoto <inochiama@gmail.com>
Cc: tglx@linutronix.de, bhelgaas@google.com, unicorn_wang@outlook.com,
 linux-pci@vger.kernel.org, Kenneth C <kenny@panix.com>
References: <af5f1790-c3b3-4f43-97d5-759d43e09c7b@panix.com>
 <2hyxqqdootjw5yepbimacuuapfsf26c5mmu5w2jsdmamxvsjdq@gnibocldkuz5>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <2hyxqqdootjw5yepbimacuuapfsf26c5mmu5w2jsdmamxvsjdq@gnibocldkuz5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Tested-By: Kenneth R. Crudup <kenny@panix.com>


> Hi, can you test the following?
> 
> ```
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 1bd5bf4a6097..b4b62b9ccc45 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -192,6 +192,12 @@ static void vmd_pci_msi_enable(struct irq_data *data)
>   	data->chip->irq_unmask(data);
>   }
>   
> +static unsigned int vmd_pci_msi_startup(struct irq_data *data)
> +{
> +	vmd_pci_msi_enable(data);
> +	return 0;
> +}
> +
>   static void vmd_irq_disable(struct irq_data *data)
>   {
>   	struct vmd_irq *vmdirq = data->chip_data;
> @@ -210,6 +216,11 @@ static void vmd_pci_msi_disable(struct irq_data *data)
>   	vmd_irq_disable(data->parent_data);
>   }
>   
> +static void vmd_pci_msi_shutdown(struct irq_data *data)
> +{
> +	vmd_pci_msi_disable(data);
> +}
> +
>   static struct irq_chip vmd_msi_controller = {
>   	.name			= "VMD-MSI",
>   	.irq_compose_msi_msg	= vmd_compose_msi_msg,
> @@ -309,6 +320,8 @@ static bool vmd_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
>   	if (!msi_lib_init_dev_msi_info(dev, domain, real_parent, info))
>   		return false;
>   
> +	info->chip->irq_startup		= vmd_pci_msi_startup;
> +	info->chip->irq_shutdown	= vmd_pci_msi_shutdown;
>   	info->chip->irq_enable		= vmd_pci_msi_enable;
>   	info->chip->irq_disable		= vmd_pci_msi_disable;
>   	return true;
> ```
> 

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA


