Return-Path: <linux-pci+bounces-12156-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE46B95DCD8
	for <lists+linux-pci@lfdr.de>; Sat, 24 Aug 2024 10:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C125B22CBE
	for <lists+linux-pci@lfdr.de>; Sat, 24 Aug 2024 08:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE54C43AAE;
	Sat, 24 Aug 2024 08:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XrxHxbwd"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8559717C64;
	Sat, 24 Aug 2024 08:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724486601; cv=none; b=mliGkhdBIUI1GzASeK1etW2LOZ5NZsWDHGWczro6gKERiN81W8tAmGTZgjSqmqpHpuew5nOFOV7P4re6EhxZyDo1P5ywJy6mgqKShmoTkmSku9KeKwh/2rqOKxr7DQ3HpKQx9CNdKnSbhsVADCDCmsoc11x1kB1isGdmysPFfdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724486601; c=relaxed/simple;
	bh=Oonr6zAF6H9aEQKo/F4fPRZWoC89oZI3itd6rXfNKy8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dbo6vVQOJWPAX2nQBHsbuSGF3mSIrsrr1hDm2t/KeGxg/t93QgtVYoVfr4RSCiaECFW2KuCimiqPQt1Ti4elTuC01Z/n5C98ftsm7VdRrZw12w309S1roq0xBuub0USlvAXKtAZmm4+YzR8clXEWclpA34NUaK+Y54gPWNOr3DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=XrxHxbwd; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47O834rj007492;
	Sat, 24 Aug 2024 03:03:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724486584;
	bh=JjIU+fG3i8/0ImnUk4UN7EPAzC6Ypf67afrlG+gIa8k=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=XrxHxbwdCKCphGT9RLb2r3JYIA71L59IGC0TgvyFhe0e8g2QT4WWHXYsGs9DOG45v
	 xowY/FcG1XotawIWCz8EaeqBU9ztrkSjaALnkx9zWNT4T1zlZRxdLj7Fdl2V4f6QN3
	 oSXe2j+BcbgiBhenW+E1hACrV5g9q2NQhiI0YRig=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47O834VC055259
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 24 Aug 2024 03:03:04 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 24
 Aug 2024 03:03:04 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 24 Aug 2024 03:03:03 -0500
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47O832rQ022960;
	Sat, 24 Aug 2024 03:03:03 -0500
Date: Sat, 24 Aug 2024 13:33:02 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <vigneshr@ti.com>, <kishon@kernel.org>,
        <manivannan.sadhasivam@linaro.org>
CC: <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <stable@vger.kernel.org>, <u-kumar1@ti.com>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: Re: [PATCH] PCI: dra7xx: Fix threaded IRQ handler registration
Message-ID: <d4789281-7eb3-4cde-aa1f-35f979484575@ti.com>
References: <20240824072135.9691-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240824072135.9691-1-s-vadapalli@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Sat, Aug 24, 2024 at 12:51:35PM +0530, Siddharth Vadapalli wrote:

Kindly ignore this patch. Sorry for the noise. I was debugging an issue
and this patch fixed it. But the cause of the issue is probably a race
condition.

Regards,
Siddharth.

> Commit da87d35a6e51 ("PCI: dra7xx: Use threaded IRQ handler for
> "dra7xx-pcie-main" IRQ") switched from devm_request_irq() to
> devm_request_threaded_irq(). In this process, the "handler" and the
> "thread_fn" parameters were erroneously interchanged, with "NULL" being
> passed as the "handler" and "dra7xx_pcie_irq_handler()" being registered
> as the function to be called in a threaded interrupt context.
> 
> Fix this by interchanging the "handler" and "thread_fn" parameters.
> While at it, correct the indentation.
> 
> Fixes: da87d35a6e51 ("PCI: dra7xx: Use threaded IRQ handler for "dra7xx-pcie-main" IRQ")
> Cc: <stable@vger.kernel.org>
> Reported-by: Udit Kumar <u-kumar1@ti.com>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> 
> Hello,
> 
> This patch is based on commit
> d2bafcf224f3 Merge tag 'cgroup-for-6.11-rc4-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup
> of Mainline Linux.
> 
> Regards,
> Siddharth.
> 
>  drivers/pci/controller/dwc/pci-dra7xx.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
> index 4fe3b0cb72ec..4c64ac27af40 100644
> --- a/drivers/pci/controller/dwc/pci-dra7xx.c
> +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
> @@ -849,8 +849,9 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
>  	}
>  	dra7xx->mode = mode;
>  
> -	ret = devm_request_threaded_irq(dev, irq, NULL, dra7xx_pcie_irq_handler,
> -			       IRQF_SHARED, "dra7xx-pcie-main", dra7xx);
> +	ret = devm_request_threaded_irq(dev, irq, dra7xx_pcie_irq_handler, NULL,
> +					IRQF_SHARED, "dra7xx-pcie-main",
> +					dra7xx);
>  	if (ret) {
>  		dev_err(dev, "failed to request irq\n");
>  		goto err_gpio;
> -- 
> 2.40.1
> 

