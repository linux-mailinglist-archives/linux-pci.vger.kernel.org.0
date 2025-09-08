Return-Path: <linux-pci+bounces-35651-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15723B489B3
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 12:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 718EF1B252F6
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 10:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0629B2F7AAC;
	Mon,  8 Sep 2025 10:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WWTv+UBG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C372F7AA1;
	Mon,  8 Sep 2025 10:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757326404; cv=none; b=ds8gpqJjdwJCr6JnialI6GoE91nMHl0K85i0eWwixVNucSA3hbWbEGIOuVu55cfPe8ZU+f94BndcvHzEkSmZXfJd1R34vBTWSSDU91oxeIvVh6x3nb0GP9iytjL6Zl7+PLXALpm4h7Qicpk8HvnpTx9xpj/JQYPBXc4W4ZGKV7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757326404; c=relaxed/simple;
	bh=Htdb7MbFsiO8xnlQadTDB0KA0YJ0enYxaWavM53erns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LPwE3FYJgzl+8KGTdOkB2R9dgSh2cXtde/kp1DWVo4YVU6b0StpBk3eVsfroB5oGIAQpBwPQzHlPFX8dfnhsD1rczc5ONO3eM+6VybalwtFu8v3zpKXzLY+8oEEMdlBCk1QaHdub1JtFkyC3CLHSxOrGBwhGcgvi9+aRBl08VaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WWTv+UBG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C867C4CEF1;
	Mon,  8 Sep 2025 10:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757326404;
	bh=Htdb7MbFsiO8xnlQadTDB0KA0YJ0enYxaWavM53erns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WWTv+UBGM52s4y5vBHoezulr1h2TBqaKEZo49ujN0Gx/0An4VRR4jgyL4zOO6t31/
	 SogUrQUUujfQ3Pil59yQEGyfNxEd9M9rwz1MXMud9+fVnEyvgoYbD//TeuV7aeRGPs
	 NwBm0pMOpy0BFzYC+885TzZzVutiS8Vfvf2vfmEpL/15+YACGyQswx69onE4wzRw7h
	 QyWl+rlmFLFb/B9MnoJ+cOq2YTUHiQvK6TN0MchPuj9WUKFOZi7PcrPr8DnrLuuk9F
	 27yqi1yOeeHkaD2+GwU6RFkYs48BZVLclCqaIT9AW9PWlwXzrpjWnv5UShdA5ACnEv
	 UFZJf9PYdJfiQ==
Date: Mon, 8 Sep 2025 15:43:17 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: daire.mcnamara@microchip.com, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, bhelgaas@google.com, robh@kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: plda: Remove the use of dev_err_probe()
Message-ID: <cl52jts26ulfcanbzz42w35g3bcjlwfhteph2oze4drveajzg3@a4kq3cxfzn2l>
References: <20250820085200.395578-1-zhao.xichao@vivo.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250820085200.395578-1-zhao.xichao@vivo.com>

On Wed, Aug 20, 2025 at 04:52:00PM GMT, Xichao Zhao wrote:
> The dev_err_probe() doesn't do anything when error is '-ENOMEM'.
> Therefore, remove the useless call to dev_err_probe(), and just
> return the value instead.
> 

Change is fine as it is. But I think devm_pci_alloc_host_bridge() should return
the actual error pointer instead of NULL and let the callers guess the errno.

Callers are using both -ENOMEM and -ENODEV, both of then will mask the actual
errno that caused the failure.

Cleanup task for someone interested :)

- Mani

> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
> ---
>  drivers/pci/controller/plda/pcie-plda-host.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/plda/pcie-plda-host.c b/drivers/pci/controller/plda/pcie-plda-host.c
> index 8e2db2e5b64b..3c2f68383010 100644
> --- a/drivers/pci/controller/plda/pcie-plda-host.c
> +++ b/drivers/pci/controller/plda/pcie-plda-host.c
> @@ -599,8 +599,7 @@ int plda_pcie_host_init(struct plda_pcie_rp *port, struct pci_ops *ops,
>  
>  	bridge = devm_pci_alloc_host_bridge(dev, 0);
>  	if (!bridge)
> -		return dev_err_probe(dev, -ENOMEM,
> -				     "failed to alloc bridge\n");
> +		return -ENOMEM;
>  
>  	if (port->host_ops && port->host_ops->host_init) {
>  		ret = port->host_ops->host_init(port);
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

