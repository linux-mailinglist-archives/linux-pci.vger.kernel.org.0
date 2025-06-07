Return-Path: <linux-pci+bounces-29138-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 559C6AD0E55
	for <lists+linux-pci@lfdr.de>; Sat,  7 Jun 2025 18:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 183D91690FA
	for <lists+linux-pci@lfdr.de>; Sat,  7 Jun 2025 16:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B501E834E;
	Sat,  7 Jun 2025 16:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="PAreezaA"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDBF3594C;
	Sat,  7 Jun 2025 15:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749312001; cv=none; b=CoH/igl2REXeNXqu7MuqZAKE7sWpVndom2pqoYiD1T/aTqlLGhznJqsW12Xl1mOC5o+pcv85qCSVJrp1JahhrmX3Z+ftg9IQDE7ZSFxjQPUywe7fxgn6IA9jY/opWXwVCsctvuHl8iX2YPKmPs3SyvGGaWQNvhnxUHEowwjiEVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749312001; c=relaxed/simple;
	bh=dB8BFMQaVi6LuvJFzp48EvNFV+o/fdmEM0ODMkSZNL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W1KdxaVSl+XQD6QnJpad/Q2MCo8hw2sUpLBo47Ap+Kj/EoZrkl2twn4QWbaBVxi2FevB+WNdiVJ8yQX6YAu2BeRs4q6aewuMhKBOHFx3dZnTfsOaGp9dHyi7FT7vmoLJrDuGZ53AFFK8+qXgWXxksUVyqmk36Ff1Ypt185Ac0Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=PAreezaA; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=WqPXzQfOBkSg6Wxyj4Ie76iGWRDRnm01njaAWfiUy1s=;
	b=PAreezaAcUZNwAn/lFfbdBkcDVhCD6jqD1LO+N7g/y7lvtN/OCnoG/3B6jJCOW
	ErhnhFrUCHGJG9h9AI2NFjr6kWwYinn6toHcULvCiUwUm898ucdmAA8T0OFYv5e9
	0beL1IbezcPdwWrbHiN15X+nGrAA14cDK/rAIazOFJv3w=
Received: from [192.168.71.94] (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wAHzn3cYURotOR+Gw--.10086S2;
	Sat, 07 Jun 2025 23:59:24 +0800 (CST)
Message-ID: <f2e49d66-ac97-4502-abe7-c02f560637e6@163.com>
Date: Sat, 7 Jun 2025 23:59:24 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI/AER: Use pci_clear_and_set_config_dword() to
 simplify mask updates
To: mahesh@linux.ibm.com, bhelgaas@google.com
Cc: oohall@gmail.com, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Manivannan Sadhasivam <mani@kernel.org>
References: <20250607155159.805679-1-18255117159@163.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20250607155159.805679-1-18255117159@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wAHzn3cYURotOR+Gw--.10086S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGry3ury3CF1kWw1Dtw1fJFb_yoW5Zw43pr
	ZxAFyrArWUJF1Y9rWUWaykAr1rZas7tay0gr93Gwn5XF4xZFZrJr9avw17J345KFZ7Xw4f
	Jws5Ka1ruF4UtaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UmZXrUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDx1lo2hEWUbMvgAAsV

Add Mani's new email address.

On 2025/6/7 23:51, Hans Zhang wrote:
> Replace manual read-modify-write sequences in multiple functions with
> pci_clear_and_set_config_dword() to ensure atomic operations and reduce
> code duplication.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
> Changes for v2:
> - The patch commit message were modified.
> - New optimizations for the functions disable_ecrc_checking, aer_enable_irq, and aer_disable_irq have been added.
> ---
>   drivers/pci/pcie/aer.c | 30 +++++++++++-------------------
>   1 file changed, 11 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 70ac66188367..86cbd204a73f 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -176,14 +176,13 @@ static int enable_ecrc_checking(struct pci_dev *dev)
>   static int disable_ecrc_checking(struct pci_dev *dev)
>   {
>   	int aer = dev->aer_cap;
> -	u32 reg32;
>   
>   	if (!aer)
>   		return -ENODEV;
>   
> -	pci_read_config_dword(dev, aer + PCI_ERR_CAP, &reg32);
> -	reg32 &= ~(PCI_ERR_CAP_ECRC_GENE | PCI_ERR_CAP_ECRC_CHKE);
> -	pci_write_config_dword(dev, aer + PCI_ERR_CAP, reg32);
> +	pci_clear_and_set_config_dword(dev, aer + PCI_ERR_CAP,
> +				       PCI_ERR_CAP_ECRC_GENE |
> +				       PCI_ERR_CAP_ECRC_CHKE, 0);
>   
>   	return 0;
>   }
> @@ -1101,15 +1100,12 @@ static bool find_source_device(struct pci_dev *parent,
>   static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>   {
>   	int aer = dev->aer_cap;
> -	u32 mask;
>   
> -	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, &mask);
> -	mask &= ~PCI_ERR_UNC_INTN;
> -	pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, mask);
> +	pci_clear_and_set_config_dword(dev, aer + PCI_ERR_UNCOR_MASK,
> +				       PCI_ERR_UNC_INTN, 0);
>   
> -	pci_read_config_dword(dev, aer + PCI_ERR_COR_MASK, &mask);
> -	mask &= ~PCI_ERR_COR_INTERNAL;
> -	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
> +	pci_clear_and_set_config_dword(dev, aer + PCI_ERR_COR_MASK,
> +				       PCI_ERR_COR_INTERNAL, 0);
>   }
>   
>   static bool is_cxl_mem_dev(struct pci_dev *dev)
> @@ -1555,23 +1551,19 @@ static irqreturn_t aer_irq(int irq, void *context)
>   static void aer_enable_irq(struct pci_dev *pdev)
>   {
>   	int aer = pdev->aer_cap;
> -	u32 reg32;
>   
>   	/* Enable Root Port's interrupt in response to error messages */
> -	pci_read_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
> -	reg32 |= ROOT_PORT_INTR_ON_MESG_MASK;
> -	pci_write_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, reg32);
> +	pci_clear_and_set_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND,
> +				       0, ROOT_PORT_INTR_ON_MESG_MASK);
>   }
>   
>   static void aer_disable_irq(struct pci_dev *pdev)
>   {
>   	int aer = pdev->aer_cap;
> -	u32 reg32;
>   
>   	/* Disable Root Port's interrupt in response to error messages */
> -	pci_read_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
> -	reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
> -	pci_write_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, reg32);
> +	pci_clear_and_set_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND,
> +				       ROOT_PORT_INTR_ON_MESG_MASK, 0);
>   }
>   
>   /**
> 
> base-commit: ec7714e4947909190ffb3041a03311a975350fe0


