Return-Path: <linux-pci+bounces-12627-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA7A968D6F
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2024 20:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55C55B22105
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2024 18:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B5519CC0C;
	Mon,  2 Sep 2024 18:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8jblI1S"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351C719CC04;
	Mon,  2 Sep 2024 18:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725301760; cv=none; b=e7wvLljF52L8NJGDbohC+vGZuQ2WmLahNYqAP1y4pLgUaNxh5xwC5N85hToR6+CA0kDDo09moEGJFMy1GnLIPF0PW+a8sNETei0Brw8ZXI1ukGTebXMz6JN2JHWTLGev+X7cCLsRkmSCS/eF4058mefO5iRv4Ks3MRbvzH4jcDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725301760; c=relaxed/simple;
	bh=4s8oxzcwxCWIXOWCXaa4pqsQAL0C90W5kJjfPYgPEGs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qP7f2GS0N5Zd+P3uw9GNOl0xcsqgTwyqz9vHmPZncEbzNaLjIJEZWFNAMySQK4V5HS4mUxnkxlFRsOD3ezDDF7H3aF8YEmUNjZtIdTrpaCONB7U5pwecnOugTzcimdM8HWdm7Wj+0FTlaA4y7nH914besmadIb1xPruqHDGSAg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8jblI1S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0406C4CEC2;
	Mon,  2 Sep 2024 18:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725301759;
	bh=4s8oxzcwxCWIXOWCXaa4pqsQAL0C90W5kJjfPYgPEGs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M8jblI1SNukufzShWrYMPjvLZsUcL5nSe2QhQ1v4Aof90hwjzjA3xl1+GoxP1nhqe
	 Kkz0U3w7UZO/HRtIfohQ+dGcdEIhGZr6lw4hPDJLIVNFELnGKOAvUZY1SyVHTwjK8R
	 pWfsObpLqwHQc1pdTzQNuRZNVtzp4C0gZTHyhsgY8iGy6hb4QPU4pjPcdWTZS0kfIb
	 uWvHeSYUVKkR2X8LUhlN7S/p3SK1aZhhznLjBxfALnee0sUf24lOrFuaGGyXEHtXmU
	 o/r6xUXXHJHLy9FtVLMz1JRxXe61vM6knLt8QBeSserL0AZXqj83oW5QTcV473ealw
	 x+6d57OLzOj7g==
Date: Mon, 2 Sep 2024 20:29:14 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Alexandra Diupina <adiupina@astralinux.ru>
Cc: Xiaowei Song <songxiaowei@hisilicon.com>, Binghui Wang
 <wangbinghui@hisilicon.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>, Rob Herring
 <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
Subject: Re: [PATCH v2] PCI: kirin: Fix buffer overflow
Message-ID: <20240902202914.2d399974@foz.lan>
In-Reply-To: <20240719122153.1987-1-adiupina@astralinux.ru>
References: <20240712110756.3abe1806@foz.lan>
	<20240719122153.1987-1-adiupina@astralinux.ru>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Fri, 19 Jul 2024 15:21:53 +0300
Alexandra Diupina <adiupina@astralinux.ru> escreveu:

> In kirin_pcie_parse_port() pcie->num_slots is compared to
> pcie->gpio_id_reset size (MAX_PCI_SLOTS). Need to fix
> condition to pcie->num_slots + 1 >= MAX_PCI_SLOTS and move
> pcie->num_slots increment lower to avoid out-of-bounds
> array access.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: b22dbbb24571 ("PCI: kirin: Support PERST# GPIOs for HiKey970 external PEX 8606 bridge")
> Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>

LGTM.

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

> ---
> v2: some changes
>  drivers/pci/controller/dwc/pcie-kirin.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
> index d5523f302102..deab1e653b9a 100644
> --- a/drivers/pci/controller/dwc/pcie-kirin.c
> +++ b/drivers/pci/controller/dwc/pcie-kirin.c
> @@ -412,12 +412,12 @@ static int kirin_pcie_parse_port(struct kirin_pcie *pcie,
>  			if (pcie->gpio_id_reset[i] < 0)
>  				continue;
>  
> -			pcie->num_slots++;
> -			if (pcie->num_slots > MAX_PCI_SLOTS) {
> +			if (pcie->num_slots + 1 >= MAX_PCI_SLOTS) {
>  				dev_err(dev, "Too many PCI slots!\n");
>  				ret = -EINVAL;
>  				goto put_node;
>  			}
> +			pcie->num_slots++;
>  
>  			ret = of_pci_get_devfn(child);
>  			if (ret < 0) {



Thanks,
Mauro

