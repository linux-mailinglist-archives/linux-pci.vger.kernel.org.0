Return-Path: <linux-pci+bounces-40361-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE69C368C7
	for <lists+linux-pci@lfdr.de>; Wed, 05 Nov 2025 17:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 596424F657F
	for <lists+linux-pci@lfdr.de>; Wed,  5 Nov 2025 15:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E76A30F7E8;
	Wed,  5 Nov 2025 15:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="LcEauCLy"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C466B30F92D;
	Wed,  5 Nov 2025 15:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762358201; cv=none; b=ivgs4KL/XegvXjbpNXmqOeYFiqJZhthhHAPt1usTlrpJJxShQSwWbwYW8qHSMWf+QW+UY1mOhhSSQ93JOKEaFe03OpI1iXJWfhvIsJXXGSrh4McG4bk7WhWN84iVnHqz6yILL/f23ENOa5oJKU+dNoTq6HHYXWWtlU8IyVs/L/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762358201; c=relaxed/simple;
	bh=0S9XzOld/wJ83Z34NVYi9AzMSHoRV7uYj8ovgqz8T7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=T3D5a2lFVxWUNu+Eigg/JLX8/KzKqQeIXevZbjQted8nCkoiyi5MiCzxs2okVWLkelPFS8HH1pMCLePThxjxbOMh7Iyd8ikQ3i+/soq4WbwjCa4TXv2DlUusFOdIAcMPNzR9J79bKK3qnwWWAtg0gACiMGfeC3r9bJqy/Du5xmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=LcEauCLy; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=iYNG2+m0hR4ggoPbQGjiXanwJnvQb6SZARxGOrR8rZc=;
	b=LcEauCLySztn59Q0zQh2Iw2XHW9NRRmvnLoVJOzlMG0sHid1PLL1a5cL1ru25a
	Z4ZX8n+jWzq+o2wOcB2qz48wLYJbZzXGlTFphnGkjkJ0Sc08mPNLGR2fZH4nFcAu
	kJSPs6ThcuaXh7BK41GZ68pTpz0wfDanH4vzHuqSAt5as=
Received: from [IPV6:240e:b8f:927e:1000:c17c:cb22:ae30:df94] (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wCnnLqfcwtpaFZGBw--.16628S2;
	Wed, 05 Nov 2025 23:56:16 +0800 (CST)
Message-ID: <9ad5a25e-04b6-48b6-b1e0-b9f51e49f8e6@163.com>
Date: Wed, 5 Nov 2025 23:56:15 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] PCI: Add macro for secondary bus reset delay
To: bhelgaas@google.com, helgaas@kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251101160538.10055-1-18255117159@163.com>
 <20251101160538.10055-2-18255117159@163.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20251101160538.10055-2-18255117159@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wCnnLqfcwtpaFZGBw--.16628S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJF15Zw1DCr4DJw18CrW3Jrb_yoW8Ww4rpF
	Z0kFykAr1rJay8Xan5Aa1Uury5W3ZIkFW0kF48K3sa9F1S9FyDCa1YgFWYgrnFqrWxXr1f
	Aas8C34UJay5trDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U8kusUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOgj8o2kLcM4xqwAAsr

Hi Bjorn,

I wonder if this is still necessary? If not, please drop it as well. Thanks.

Best regards,
Hans

On 2025/11/2 00:05, Hans Zhang wrote:
> Add PCI_T_RST_SEC_BUS_DELAY_MS macro for the secondary bus reset
> delay value according to PCIe r7.0 spec, section 7.5.1.3.13.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
>   drivers/pci/pci.c | 7 ++-----
>   drivers/pci/pci.h | 3 +++
>   2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b14dd064006c..86449f2d627b 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4912,11 +4912,8 @@ void pci_reset_secondary_bus(struct pci_dev *dev)
>   	ctrl |= PCI_BRIDGE_CTL_BUS_RESET;
>   	pci_write_config_word(dev, PCI_BRIDGE_CONTROL, ctrl);
>   
> -	/*
> -	 * PCI spec v3.0 7.6.4.2 requires minimum Trst of 1ms.  Double
> -	 * this to 2ms to ensure that we meet the minimum requirement.
> -	 */
> -	msleep(2);
> +	/* Double this to 2ms to ensure that we meet the minimum requirement */
> +	msleep(2 * PCI_T_RST_SEC_BUS_DELAY_MS);
>   
>   	ctrl &= ~PCI_BRIDGE_CTL_BUS_RESET;
>   	pci_write_config_word(dev, PCI_BRIDGE_CONTROL, ctrl);
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 4492b809094b..31f975619774 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -63,6 +63,9 @@ struct pcie_tlp_log;
>   #define PCIE_LINK_WAIT_MAX_RETRIES	10
>   #define PCIE_LINK_WAIT_SLEEP_MS		90
>   
> +/* PCIe r7.0, sec 7.5.1.3.13, requires minimum Trst of 1ms */
> +#define PCI_T_RST_SEC_BUS_DELAY_MS	1
> +
>   /* Message Routing (r[2:0]); PCIe r6.0, sec 2.2.8 */
>   #define PCIE_MSG_TYPE_R_RC	0
>   #define PCIE_MSG_TYPE_R_ADDR	1


