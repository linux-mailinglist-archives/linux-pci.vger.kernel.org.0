Return-Path: <linux-pci+bounces-29482-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2420AD5CC5
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 19:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6614A7AAA20
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 16:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2741F582E;
	Wed, 11 Jun 2025 17:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p4hyrQAc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539A81DF270;
	Wed, 11 Jun 2025 17:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749661248; cv=none; b=QuOD6OJDrhZGkIQP7EU7vPujU/NsulAP0pcIc2IVrGTFaxbvxtSlGAZW9wxGzoztlEr22aWWMHHxP5SXouojiqub7uR/7ds6ajN4xKNGqSUgVNT2F1IADZFBDVEGQ7Bbbx5n8ra9u8Bnzn7bPKcHcNF/l/zDQPEH5s0JJZuWF6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749661248; c=relaxed/simple;
	bh=U1j6kxoyOkjl28igDCJYe1I9pHNhofmpnBeLH4TWCQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SIrkoFkdVB/LXxYRVSrqCwkYvst2HYvvrtEiNzaB050qG+tqQKwsg84f1q8qB7y6loDZlr5jI+dTUCk+8KDFpMKRQaoNuGaNIZ8WOzuFIe8IalUG/0A5h/zLRrrm+hhWzxqcdcNkOpsQQ2yhsf1ZzbV2zSn1XOb+vu1CgtJZhto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p4hyrQAc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9913C4CEE3;
	Wed, 11 Jun 2025 17:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749661247;
	bh=U1j6kxoyOkjl28igDCJYe1I9pHNhofmpnBeLH4TWCQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p4hyrQAc8dlu8sBj0gfIHVVSY23CT2QtlWEWzvD0M2Qj2hHkJPXAttqrZi3+K4NDA
	 iw0OOgYL4nWtf1rVe8qMXcYbUvJyhcr9CIbR6CVPNEIg9wtwiEFh7K4oigJpqfFiUg
	 66BA3kLROOgmVH7/msza3brqfhI0FquXuo1AP5C5U1RGGPVLCDs+W9NeHu17xHW7rX
	 HbYYcRCh0jtU594VHerq02a3wArk7izJddstZ2Zayyh78mP6YfIiA+5ur/eYJ62kK2
	 3wd9XBinClLcxbS46XGqnXMsYngs/660tSYA3foSTNh80FHylIivcdInuU+H8c+xX9
	 Ol48rnLqpg3QA==
Date: Wed, 11 Jun 2025 22:30:38 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: =?utf-8?B?5a2Z5Yip5paMX0Rpbw==?= <dio.sun@enflame-tech.com>
Cc: "mahesh@linux.ibm.com" <mahesh@linux.ibm.com>, 
	"oohall@gmail.com" <oohall@gmail.com>, "bhelgaas@google.com" <bhelgaas@google.com>, 
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, =?utf-8?B?572X5a6JX0Fu?= <an.luo@enflame-tech.com>, 
	=?utf-8?B?6IOh5reuX0Zlcm5hbmRv?= <fernando.hu@enflame-tech.com>, =?utf-8?B?5ZC055qT552/X0JpbGw=?= <bill.wu@enflame-tech.com>, 
	=?utf-8?B?546L6ZGrX1hpbg==?= <xin.wang@enflame-tech.com>
Subject: Re: [PATCH] AER: PCIE CTO recovery handle fix
Message-ID: <6gs5cvpqbbkudnlr7v57odgaxjyrare6nigrf2lkq22yljult2@z5jklzlmsdcq>
References: <BJXPR01MB0614C01A9523786117B1F1CBCEC8A@BJXPR01MB0614.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BJXPR01MB0614C01A9523786117B1F1CBCEC8A@BJXPR01MB0614.CHNPR01.prod.partner.outlook.cn>

On Tue, Mar 04, 2025 at 07:07:05AM +0000, 孙利斌_Dio wrote:
> [EXTERNAL EMAIL]
> 
> From 5fc7b1a9e0f0bcfa14068c6358019ed1e3ffc6c6 Mon Sep 17 00:00:00 2001
> From: "dio.sun" <dio.sun@enflame-tech.com>
> Date: Wed, 26 Feb 2025 08:54:49 +0000
> Subject: [PATCH] AER: PCIE CTO recovery handle fix
> 

Looks like you forwarded this patch instead of submitting directly. Please fix
it.

>  - Non-fatal PCIe CTO is reportted to PCIE RC and it will be convertted to
>    AdvNonFatalErr automatically
>  - according to PCIE SPEC 6.2.3.2.4.4 Requester with Completion Timeout(
>    If the severity of the CTO is non-fatal, and the Requester elects to
>    attempt recovery by issuing a new request, the Requester must
>    first handle the currecnt error case as an Advisory Non-Fatal Error.).
>  - Current Kernel code does nothing when receiving an AdvNonFatalErr(
>    Correctable Error) and the device driver has no chance to handle this
>    error.
>  - Under this situation, sometimes system will hang when more
>    AdvNonFatalErr coming.
> 
> Signed-off-by: dio.sun <dio.sun@enflame-tech.com>
> ---
> drivers/pci/pcie/aer.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 508474e17183..5ddc990c6f42 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1154,7 +1154,21 @@ static void aer_recover_work_func(struct work_struct *work)
>                 ghes_estatus_pool_region_free((unsigned long)entry.regs,
>                                             sizeof(struct aer_capability_regs));
> 
> -               if (entry.severity == AER_NONFATAL)
> +               if (entry.severity == AER_CORRECTABLE) {
> +                       if (entry.regs->cor_status & PCI_ERR_COR_ADV_NFAT) {
> +                               pci_err(pdev, "%04x:%02x:%02x:%x advisory non-fatal error\n",
> +                                               entry.domain, entry.bus, PCI_SLOT(entry.devfn),
> +                                               PCI_FUNC(entry.devfn));
> +                               if (entry.regs->uncor_status & PCI_ERR_UNC_COMP_TIME) {
> +                                       pci_err(pdev, "%04x:%02x:%02x:%x completion timeout\n",
> +                                                       entry.domain, entry.bus,
> +                                                       PCI_SLOT(entry.devfn),
> +                                                       PCI_FUNC(entry.devfn));
> +                                       pcie_do_recovery(pdev, pci_channel_io_frozen,
> +                                                                        aer_root_reset);
> +                               }
> +                       }

Why the error is handled in aer_recover_work_func()? This looks like only gets
triggered from ghes_handle_aer() in drivers/acpi/apei/ghes.c.

I think it should be handled in pci_aer_handle_error(). Also, the error prints
should be sneaked into aer_print_error().

- Mani

-- 
மணிவண்ணன் சதாசிவம்

