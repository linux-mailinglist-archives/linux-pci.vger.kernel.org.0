Return-Path: <linux-pci+bounces-45103-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF579D3956F
	for <lists+linux-pci@lfdr.de>; Sun, 18 Jan 2026 14:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 653CD300819E
	for <lists+linux-pci@lfdr.de>; Sun, 18 Jan 2026 13:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F492580E1;
	Sun, 18 Jan 2026 13:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ijJdo7Co"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E23158857;
	Sun, 18 Jan 2026 13:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768744121; cv=none; b=YluNvV56FC1jKfEMpcQes/ler0RR5mNmbUECusuLhbGEJHGH5ac9O4JNukMQXjMU3beEdgzf4BELYke7phCRZN3DcR7HgP8InP2mNprf8QvslzKfdi94s8hKn39rdvY01MK56XzbQJO2y4KH5gnE0rlAzA1uiB251LYbYDrypQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768744121; c=relaxed/simple;
	bh=QVAtJU32fI3hijyKBLjoH3GMdFQjjw5d7difJLTShhI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I9bv4rpTWYjqNgnoewPXxZYEV27/+1DkVm9Qpbs2l/25JttTppFgDVmfDqtxo+Z57JCM4TuxCLngImwgH0gnfGuWWujSIc5w6jO5kG6M2wQtRSrmRxCfqxkvd4UuTmovsl9hZwWN4C7UnnEFn3qt0i4ayIenp175rhiFNfUZgqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ijJdo7Co; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=z1piXpiFHso3GGftRgQQooHaij0dQTWZjfWoc2FOYuc=;
	b=ijJdo7CoNK2U4hWMpXSKGmw9hLxWZPVDnqIXWbj6nNtlFY4ZtkKje7FxNdgqdM
	pP8kj3Hn8NL4N8AsTvH8471pWDoAGcl5oHPuw+UtvFEmjAnM6ksS9o8qhllCP5f5
	EHSSdue3mZLhql9+tpu9gVfqekEQusDnKscLLX41Yf5uo=
Received: from [IPV6:240e:b8f:927e:1000:e94b:3b22:e2ce:7986] (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDX+GyK5GxpZrMiGQ--.49932S2;
	Sun, 18 Jan 2026 21:47:54 +0800 (CST)
Message-ID: <1d267e9e-5e32-483c-8b53-1454d4dc5e9a@163.com>
Date: Sun, 18 Jan 2026 21:47:54 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v4 0/2] PCI: Introduce pci_clear/set_config_dword()
To: mahesh@linux.ibm.com, bhelgaas@google.com
Cc: oohall@gmail.com, mani@kernel.org, lukas@wunner.de,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251101162219.12016-1-18255117159@163.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20251101162219.12016-1-18255117159@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wDX+GyK5GxpZrMiGQ--.49932S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF4UJr45XryxJr1ftr1DJrb_yoW8Wry5pr
	Z3Ary3JrW7GFya9FW7GFy2ya45Wa1kJFWrJr17Kwn5Zw13Zry8ZF9agry5AF9rJrWrXw42
	grs2gFy8uw1qkFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRyEE8UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6wrQdGls5IqSrAAA3Q

Hi,

Gentle ping.

Best regards,
Hans

On 2025/11/2 00:22, Hans Zhang wrote:
> This series introduces auxiliary functions for the PCI configuration space
> and simplifies the read and write operations of the AER driver, reducing a
> lot of repetitive code.
> 
> Patch 1 adds pci_clear_config_dword() and pci_set_config_dword() helpers
> to reduce repetitive read-modify-write sequences when modifying PCI config
> space. These helpers improve code readability and maintainability.
> 
> Patch 2 refactors the PCIe AER driver to use these new helpers,
> eliminating manual read-modify-write patterns and intermediate variable
> in several functions. This results in cleaner and more concise code.
> 
> ---
> Changes for v4:
> - Introduce pci_clear/set_config_dword()
> 
> Changes for v3:
> https://patchwork.kernel.org/project/linux-pci/patch/20250816161743.340684-1-18255117159@163.com/
> 
> - Rebase to v6.17-rc1.
> - The patch commit message were modified.
> - Add Acked-by: Manivannan Sadhasivam <mani@kernel.org>
> 
> Changes for v2:
> - The patch commit message were modified.
> - New optimizations for the functions disable_ecrc_checking, aer_enable_irq, and aer_disable_irq have been added.
> ---
> 
> Hans Zhang (2):
>    PCI: Introduce pci_clear/set_config_dword()
>    PCI/AER: Use pci_clear/set_config_dword to simplify code
> 
>   drivers/pci/pcie/aer.c | 29 ++++++++++-------------------
>   include/linux/pci.h    | 12 ++++++++++++
>   2 files changed, 22 insertions(+), 19 deletions(-)
> 
> 
> base-commit: 8742b2d8935f476449ef37e263bc4da3295c7b58


