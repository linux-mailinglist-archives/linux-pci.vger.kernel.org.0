Return-Path: <linux-pci+bounces-41476-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D32EEC670FE
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 03:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B45043567B8
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 02:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4941B645;
	Tue, 18 Nov 2025 02:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="neQxWp76"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869EA3203BB
	for <linux-pci@vger.kernel.org>; Tue, 18 Nov 2025 02:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763434101; cv=none; b=ECg3qD3s86RqM0+JNCQMloOaDV3XfWXGPhvtBLN9+UuGKMAl0ormInfKAnyypPA15NSlF3VNNg7sJdTaD2+epMtDFntHtMnSUvAz6oG8snSOG7rCfO46Y4h3/2nJvzy4B6rjSJfntcm8hgUyOX1aJPAbNWp1d533//HZoStw4/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763434101; c=relaxed/simple;
	bh=n+CZthML9eAKpg7fuI/hBOtHwwZxx1J6VXoalswkOGY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=AkZJm9mbRBtRxJPni+1hZMQWYlfOtyOs/ArpEYHWnqan06WzVbUDrnbqdhLtBEo2fjAG4UvgCG4lasbaTDdVdR4NY3sSmY97YHuKvnaYn9gey+ElDS8J6ECRktqewalvEuYtG6+ghj6zNLavnpO0rJcTTP8m8VvGUOi46pYA4po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=neQxWp76; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1763434095; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=jHzu4ojLiInJE/iENcKSYBecM3BsBpf/f/W9AOlxMX4=;
	b=neQxWp762irT1n5DLCH7AEH5oZVyr3Sb5OWxymcSgVXqmPhLjuD5qW7egMWKe7Ovj0i3j/HJjjv+StKkSMFW9D2W/C7NTyW4HuFr3awYm8yPHrTnyAW8D78F0856tBwtj2OyOit+1Q/IC8RMsvl+A2bKvWMu91BBkIIP4x0zrxE=
Received: from 30.178.83.114(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WshGBic_1763434094 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 18 Nov 2025 10:48:15 +0800
Message-ID: <02f81329-48ef-439c-9c0d-dc1e93f174f2@linux.alibaba.com>
Date: Tue, 18 Nov 2025 10:48:14 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH] PCI: Check rom image addr at every step
From: Guixin Liu <kanie@linux.alibaba.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
References: <20251114063411.88744-1-kanie@linux.alibaba.com>
In-Reply-To: <20251114063411.88744-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Gentle ping...

BR
Guixin Liu

在 2025/11/14 14:34, Guixin Liu 写道:
> We meet a crash when running stress-ng:
>    BUG: unable to handle page fault for address: ffa0000007f40000
>    RIP: 0010:pci_get_rom_size+0x52/0x220
>    Call Trace:
>    <TASK>
>    pci_map_rom+0x80/0x130
>    pci_read_rom+0x4b/0xe0
>    kernfs_file_read_iter+0x96/0x180
>    vfs_read+0x1b1/0x300
>    ksys_read+0x63/0xe0
>    do_syscall_64+0x34/0x80
>    entry_SYSCALL_64_after_hwframe+0x78/0xe2
> Bcause of broken rom space, before calling readl(pds), pds already
> points to the rom space end (rom + size - 1), invoking readl()
> would therefore cause an out-of-bounds access and trigger a crash.
>
> Fix this by adding every step address checking.
>
> Fixes: 47b975d234ea ("PCI: Avoid iterating through memory outside the resource window")
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
>   drivers/pci/rom.c | 25 +++++++++++++++++++++----
>   1 file changed, 21 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pci/rom.c b/drivers/pci/rom.c
> index e18d3a4383ba..f9377ad3f89f 100644
> --- a/drivers/pci/rom.c
> +++ b/drivers/pci/rom.c
> @@ -69,6 +69,10 @@ void pci_disable_rom(struct pci_dev *pdev)
>   }
>   EXPORT_SYMBOL_GPL(pci_disable_rom);
>   
> +#define PCI_ROM_DATA_STRUCT_OFFSET 24
> +#define PCI_ROM_LAST_IMAGE_OFFSET 21
> +#define PCI_ROM_LAST_IMAGE_LEN_OFFSET 16
> +
>   /**
>    * pci_get_rom_size - obtain the actual size of the ROM image
>    * @pdev: target PCI device
> @@ -86,28 +90,41 @@ static size_t pci_get_rom_size(struct pci_dev *pdev, void __iomem *rom,
>   	void __iomem *image;
>   	int last_image;
>   	unsigned int length;
> +	void __iomem *end = rom + size;
>   
>   	image = rom;
>   	do {
>   		void __iomem *pds;
> +
> +		if (image + 2 >= end)
> +			break;
> +
>   		/* Standard PCI ROMs start out with these bytes 55 AA */
>   		if (readw(image) != 0xAA55) {
>   			pci_info(pdev, "Invalid PCI ROM header signature: expecting 0xaa55, got %#06x\n",
>   				 readw(image));
>   			break;
>   		}
> +
> +		if (image + PCI_ROM_DATA_STRUCT_OFFSET + 2 >= end)
> +			break;
>   		/* get the PCI data structure and check its "PCIR" signature */
> -		pds = image + readw(image + 24);
> +		pds = image + readw(image + PCI_ROM_DATA_STRUCT_OFFSET);
> +		if (pds + 4 >= end)
> +			break;
>   		if (readl(pds) != 0x52494350) {
>   			pci_info(pdev, "Invalid PCI ROM data signature: expecting 0x52494350, got %#010x\n",
>   				 readl(pds));
>   			break;
>   		}
> -		last_image = readb(pds + 21) & 0x80;
> -		length = readw(pds + 16);
> +
> +		if (pds + PCI_ROM_LAST_IMAGE_OFFSET + 1 >= end)
> +			break;
> +		last_image = readb(pds + PCI_ROM_LAST_IMAGE_OFFSET) & 0x80;
> +		length = readw(pds + PCI_ROM_LAST_IMAGE_LEN_OFFSET);
>   		image += length * 512;
>   		/* Avoid iterating through memory outside the resource window */
> -		if (image >= rom + size)
> +		if (image + 2 >= end)
>   			break;
>   		if (!last_image) {
>   			if (readw(image) != 0xAA55) {


