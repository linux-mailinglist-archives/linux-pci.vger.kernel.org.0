Return-Path: <linux-pci+bounces-28252-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 458DBAC01D3
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 03:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDC367A3CEE
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 01:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE09182B7;
	Thu, 22 May 2025 01:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="CZ3Y7vxU"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C125E847B;
	Thu, 22 May 2025 01:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747878555; cv=none; b=NuqC2p0VNJL8k1XGf7EzKnCfG+ym7ONFv8s2pzROJe9y6n3Ye5UrAnDrSrae9t6T7US/ockZBx3RXVvwMfw/xOxsdPpemt1HHCRUWnNYCTqRJ4f6OT+fRBF/eULn06kyPoYBXrgV+4OkfxVXxiXf7u3+99a6MiwClJbOPEalWoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747878555; c=relaxed/simple;
	bh=1WyhxZdaIYraS11q1vCIN4BxIyXnKhLV40XI2S9Vpkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q7ARMmZnzsz1rGd8QvMlIRMk0Haf64bBVc9eVCQpMWg/QQ7z+Zw2iL2UnotTarJCiZOz5eC3M4V6bzgv/hs3jDSiVxUqIMB+nGMrbj7y2zIKRH5O9OOgyzThdaXJB5zwZBqKFeDpT2CGTWGWeJ6A/P741ArrUbdrkywFXK8pMcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=CZ3Y7vxU; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=Np6wwdfNGDMOxCy0p7chbIR7ihNVO5eSTYMXHZ+6rgs=;
	b=CZ3Y7vxUx9TEmavUmIBsSqEANobPjxDXvzQNjSNPSmGbAr4Mp6/iyPd57Ekpzm
	kx9oQtG/g3hA6PrBxDwBNuYXSgXBkdvQQV7hK6Uo5UPeLHXw/8FWIz5Mz2QtYCUv
	ZurNRTGNfP0nilGO9LtChbKLqzIPPF+sKd7kUlQ63zZnI=
Received: from [192.168.18.52] (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3Vx9egi5oPMZwDA--.50136S2;
	Thu, 22 May 2025 09:48:16 +0800 (CST)
Message-ID: <3ac0565c-f920-4596-8ba0-91be892217c9@163.com>
Date: Thu, 22 May 2025 09:48:13 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pci: altera: remove unused 'node' variable
To: Arnd Bergmann <arnd@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Joyce Ooi <joyce.ooi@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, "Jiri Slaby (SUSE)"
 <jirislaby@kernel.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250521163329.2137973-1-arnd@kernel.org>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20250521163329.2137973-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3Vx9egi5oPMZwDA--.50136S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WryDJr4ftFW3uF17tw1rXrb_yoW8ZF1UpF
	WrJ3WavFW5JF45urs2kFyUXFyag3WqyrW8t3yFgFnrGFnrGF92kryUCF15K3W2kF4rAF4U
	Ar1jg3W8uF15JF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UrCztUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWw1Vo2gugSIp1wAAs7



On 2025/5/22 00:29, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This variable is only used when CONFIG_OF is enabled:
> 
> drivers/pci/controller/pcie-altera.c: In function 'altera_pcie_init_irq_domain':
> drivers/pci/controller/pcie-altera.c:855:29: error: unused variable 'node' [-Werror=unused-variable]
>    855 |         struct device_node *node = dev->of_node;
> 
> Use dev_fwnode() in place of of_node_to_fwnode() to avoid this.
> 
> Fixes: bbc94e6f72f2 ("PCI: Switch to irq_domain_create_linear()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ----
> I checked the other PCI host bridge drivers as well, this is the
> only one with that problem.
> ---
>   drivers/pci/controller/pcie-altera.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
> index 0fc77176a52e..3dbb7adc421c 100644
> --- a/drivers/pci/controller/pcie-altera.c
> +++ b/drivers/pci/controller/pcie-altera.c
> @@ -852,10 +852,9 @@ static void aglx_isr(struct irq_desc *desc)
>   static int altera_pcie_init_irq_domain(struct altera_pcie *pcie)
>   {
>   	struct device *dev = &pcie->pdev->dev;
> -	struct device_node *node = dev->of_node;
>   
>   	/* Setup INTx */
> -	pcie->irq_domain = irq_domain_create_linear(of_fwnode_handle(node), PCI_NUM_INTX,
> +	pcie->irq_domain = irq_domain_create_linear(dev_fwnode(dev), PCI_NUM_INTX,
>   					&intx_domain_ops, pcie);

Hello,

Please align the code by the way.

pcie->irq_domain = irq_domain_create_linear(dev_fwnode(dev), PCI_NUM_INTX,
					    &intx_domain_ops, pcie);


Besides, I didn't see this commit in the linux master branch and the PCI 
next branch.  It should be in some branch of Thomas Gleixner, right?

Fixes: bbc94e6f72f2 ("PCI: Switch to irq_domain_create_linear()")

Best regards,
Hans

>   	if (!pcie->irq_domain) {
>   		dev_err(dev, "Failed to get a INTx IRQ domain\n");


