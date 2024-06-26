Return-Path: <linux-pci+bounces-9313-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB34918564
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 17:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEF52B21FC9
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 15:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1C4186E33;
	Wed, 26 Jun 2024 15:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKLlX19I"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4562418509F;
	Wed, 26 Jun 2024 15:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719414503; cv=none; b=pEOe8rYbeRcXBkjgH2Kn9kghmOms3Jy6UP60F7RD76/ol3FEYp9OE1LnImLhK/6dACDF3KRF+ccIZPQSbjSjx0MIBBDpyLnqpCwacFNIq/6oQNd5GhG3ZkWH3NtqVjY+tfHuXRMqEkxHcHs+nom6CrhaNOh5JnLwmGUX62Dhcs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719414503; c=relaxed/simple;
	bh=QPet1PZlyBbbtlEE9TjbBmawH/TuKsCLb0EzxOzVoZU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=s2HSclEnTxpli2ZZ495htIT2BzlrNwSAsTfsj0RzutADRyldHmV/qJc63w4KYe1GycHxQqtgKvQc4APJrTlFGT7+YchMd7HhN0dr8A4+wm1IhttaI8bBsmpjYqY1Qc7Ha28/H/UwRw4BnxQzN4zQjpS4IN22+Drd7mm8nCaxkY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKLlX19I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99F84C116B1;
	Wed, 26 Jun 2024 15:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719414502;
	bh=QPet1PZlyBbbtlEE9TjbBmawH/TuKsCLb0EzxOzVoZU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=oKLlX19IFDMsVZhAio5B06r4zvLtnslkjhVb3qRAA5y1puDvmhES4RBsf7b/eueBF
	 IwSM5Xk8qh5ZfEm3kK/0HQwC5KZP7EOLy5i87fFIuYxYnGHVK5uBNAnEaw+Gcwdasi
	 8hmLVpwLrdEByXHnQxRMZW6FBtQN8TT5ubHTDDMS5RKaZTVFDWxb7bv0+AW5LmVVfI
	 d8AiRlVyaoeOyv59u51Qao6wI+KNJZHyImUXxBzZmwZQ4ClneYAvb5Idjbmwq8F1Ij
	 L1u3Dy1E4QyaE7pxeL+1viwYbwU/iEBnWN70cve2PrAmc/QPS19bA/vVJIgYTvuess
	 UdN/hnyWSyj0A==
Date: Wed, 26 Jun 2024 10:08:20 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
	Jianmin Lv <lvjianmin@loongson.cn>,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Huacai Chen <chenhuacai@gmail.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org
Subject: Re: [PATCH] PCI: PM: Fix PCIe MRRS restoring for Loongson
Message-ID: <20240626150820.GA1466617@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240623033940.1806616-1-chenhuacai@loongson.cn>

On Sun, Jun 23, 2024 at 11:39:40AM +0800, Huacai Chen wrote:
> Don't limit MRRS during resume, so that saved value can be restored,
> otherwise the MRRS will become the minimum value after resume.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 8b3517f88ff2983f ("PCI: loongson: Prevent LS7A MRRS increases")
> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  drivers/pci/pci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 35fb1f17a589..bfc806d9e9bd 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -31,6 +31,7 @@
>  #include <asm/dma.h>
>  #include <linux/aer.h>
>  #include <linux/bitfield.h>
> +#include <linux/suspend.h>
>  #include "pci.h"
>  
>  DEFINE_MUTEX(pci_slot_mutex);
> @@ -5945,7 +5946,7 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
>  
>  	v = FIELD_PREP(PCI_EXP_DEVCTL_READRQ, ffs(rq) - 8);
>  
> -	if (bridge->no_inc_mrrs) {
> +	if (bridge->no_inc_mrrs && (pm_suspend_target_state == PM_SUSPEND_ON)) {

I don't think we can check pm_suspend_target_state here.  That seems
like a layering/encapsulation problem.  Are we failing to save this
state at suspend?  Seems like something we should address more
explicitly higher up in the suspend/resume path where we save/restore
config space.

>  		int max_mrrs = pcie_get_readrq(dev);
>  
>  		if (rq > max_mrrs) {
> -- 
> 2.43.0
> 

