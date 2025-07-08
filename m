Return-Path: <linux-pci+bounces-31661-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67404AFC47B
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 09:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71CBA164A09
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 07:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9E3298CB5;
	Tue,  8 Jul 2025 07:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mSb46+oP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F3429824E;
	Tue,  8 Jul 2025 07:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751960883; cv=none; b=diRwiIUyH5YVfs9IZcaXu58gYP9HsK2E6YTxk6xaMAAFWTKGyGporECTjxHnSIHMyuorSnB4vk4WQCFikpuraxYFiM9t5zaOkFHpYrvvH1iQxKQvWkiA2kJfcBfxIc3PQ0pfKX3XQ4BEQREExeOhAG7mzOlVuARaaHr7NYtbVJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751960883; c=relaxed/simple;
	bh=9Q5CXN9O5qwDOk34kVlNTKgsb2m3mLtmtiu6Wi3LFeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jtyl5sHcfr5TzX4vICeiG/WOR49h2EuqG9oJo5HD78i75CTgHn1K6wo32+qB0XvtoUZGJ4ME99F4Vk3MdIUUW5u1lqfDPXX9tXuxCkAeZH/bEWOR5un+rbT6yUqKvxdP4ZOSN6iu4q9G3ozsyGjseeTUBi3Ogawssfa36FHuCPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mSb46+oP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF64FC4CEED;
	Tue,  8 Jul 2025 07:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751960883;
	bh=9Q5CXN9O5qwDOk34kVlNTKgsb2m3mLtmtiu6Wi3LFeU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mSb46+oPCqcoSm83lDKYIiFXtSEU5ju6qkNzXxvK0zNaFIV3c3yK6gHdmp/goOiyB
	 UdhV32c8l3Zbf3fIlRqKhPBVlLCjFfPd6NQ6IVAhC8BE0+aR00NsNuVC2E8kpro/YD
	 0rFM96z9LxDLKKubisu4JMuwNZXcCRET+BaMpo3t7gqhk0yoWtskBOZuCuhCJWVjow
	 tEWs0iUp25u9cD2oxo28HpSxeJdqty7BFS0XDBCGU/bm5/fJPtI8JZZY0yUt+WRNX7
	 W4hXStNtBIWd5yj0LGeQuWXBLbChJhGTnRRrU4LUAiJU3kfi+dqa8iKD0GKwG/5XMd
	 eIvryi7xptaag==
Date: Tue, 8 Jul 2025 13:17:53 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] PCI: imx6: Align EP link start behavior with
 documentation
Message-ID: <klduv5ytcsxzs6nugiorajwxq4mwqfpmhkifl5wtjy6jiq4mha@mf4732u2xrtw>
References: <20250616085742.2684742-1-hongxing.zhu@nxp.com>
 <20250616085742.2684742-3-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250616085742.2684742-3-hongxing.zhu@nxp.com>

On Mon, Jun 16, 2025 at 04:57:42PM GMT, Richard Zhu wrote:
> According to PCI/endpoint/pci-endpoint-cfs.rst, the endpoint (EP) should
> only link up after `echo 1 > start` is executed.
> 
> To match the documented behavior, do not start the link automatically
> when adding the EP controller.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Fixes tag?

- Mani

> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index f5f2ac638f4b..fda03512944d 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1468,9 +1468,6 @@ static int imx_add_pcie_ep(struct imx_pcie *imx_pcie,
>  
>  	pci_epc_init_notify(ep->epc);
>  
> -	/* Start LTSSM. */
> -	imx_pcie_ltssm_enable(dev);
> -
>  	return 0;
>  }
>  
> -- 
> 2.37.1
> 

-- 
மணிவண்ணன் சதாசிவம்

