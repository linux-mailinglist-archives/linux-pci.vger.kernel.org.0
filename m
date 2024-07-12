Return-Path: <linux-pci+bounces-10198-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3DF92F78F
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2024 11:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DD2C28230B
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2024 09:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BD4143C51;
	Fri, 12 Jul 2024 09:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mYOPmfjI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783BD143747;
	Fri, 12 Jul 2024 09:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720775282; cv=none; b=DB4alvTA6PhZm0T6lla2BumJmBySQYybaOT1MNnUGJOHFNGjOuW8/M+Fdbl7Ap+EU/zD1lav77X7nMsZFwq5s0YZSLlB/WA4zc1DKcxOwpEhEHZpTpJx40fd8FAiK4TPW3v/VqIMrxDc6JlLU7djS+4Y+YR7UNIn9ZgPYNzw1cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720775282; c=relaxed/simple;
	bh=itxLX/wA5zZyTsCHr4QrHkRPDcxLqgiW6wSTdG2clwo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p0VUEqqiaXaYxe+gF3qJc/KmtvXP/gMfrh8NuhP/C5W3MmgWKIu7b9+0sD2VPDPypeEAX7o5GmNITeforbHD7SHetxupwkbYW5Iy7NYFIpbNI1iM8b+U3PyUsSrLtdHaFYKNF6N/hO2W2ppJvIRBF2ESZmqk3ydkt3h33citdzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mYOPmfjI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0E02C4AF09;
	Fri, 12 Jul 2024 09:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720775281;
	bh=itxLX/wA5zZyTsCHr4QrHkRPDcxLqgiW6wSTdG2clwo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mYOPmfjIe8FX/hcAHjXi1jmOsT6YH6m+aPXLBbR4qfE0PD/VXbEbSebSRLeMVlcwb
	 g1ScL/gXIGxaF7sCz4Yvv6b+CLZ1x9b03ZTXN9HmMW09skVQ2sC2IKLvZMuDBtk2P9
	 /y32NpWs0CRkEiUtvj5XXbAT1pYPvAdMw8Yn1quocIz0NWZGypFlP++4R2xACaOqwz
	 pP9upz9NH/KoDLcuPIXz5fJqAMEN0Rg+Fc0WBxLdgFuBSMqskHjKo5VDdKHkXx2Mmz
	 DxmgnPBYBnDYBlKY+Y/xw8hZK5X4Bm1/NTWB+x4GpCLqGEbzUME1HzUWu3X5ve7s15
	 gJlW1T8h06aRw==
Date: Fri, 12 Jul 2024 11:07:56 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Alexandra Diupina <adiupina@astralinux.ru>
Cc: Xiaowei Song <songxiaowei@hisilicon.com>, Binghui Wang
 <wangbinghui@hisilicon.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>, Rob Herring
 <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
Subject: Re: [PATCH] PCI: kirin: Fix buffer overflow
Message-ID: <20240712110756.3abe1806@foz.lan>
In-Reply-To: <20240712084309.13248-1-adiupina@astralinux.ru>
References: <20240712084309.13248-1-adiupina@astralinux.ru>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Fri, 12 Jul 2024 11:43:09 +0300
Alexandra Diupina <adiupina@astralinux.ru> escreveu:

> In kirin_pcie_parse_port() pcie->num_slots is compared to
> pcie->gpio_id_reset size (MAX_PCI_SLOTS). Need to fix
> condition to pcie->num_slots >= MAX_PCI_SLOTS to
> avoid out of bounds array access.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: b22dbbb24571 ("PCI: kirin: Support PERST# GPIOs for HiKey970 external PEX 8606 bridge")
> Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
> ---
>  drivers/pci/controller/dwc/pcie-kirin.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
> index d5523f302102..5ef3384c137d 100644
> --- a/drivers/pci/controller/dwc/pcie-kirin.c
> +++ b/drivers/pci/controller/dwc/pcie-kirin.c
> @@ -413,7 +413,7 @@ static int kirin_pcie_parse_port(struct kirin_pcie *pcie,
>  				continue;
>  
>  			pcie->num_slots++;
> -			if (pcie->num_slots > MAX_PCI_SLOTS) {
> +			if (pcie->num_slots >= MAX_PCI_SLOTS) {
>  				dev_err(dev, "Too many PCI slots!\n");
>  				ret = -EINVAL;
>  				goto put_node;

Hmm... the logic will keep num_slots incremented when the error condition
is trigged. IMO, the code should be, instead:

                        if (pcie->num_slots + 1 >= MAX_PCI_SLOTS) {
                                dev_err(dev, "Too many PCI slots!\n");
                                ret = -EINVAL;
                                goto put_node;
                        }
                        pcie->num_slots++;

Thanks,
Mauro

