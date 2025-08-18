Return-Path: <linux-pci+bounces-34205-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E5FB2ACDB
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 17:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D46B18A082A
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 15:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22A825A631;
	Mon, 18 Aug 2025 15:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4GwIKRv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723FB259CA3;
	Mon, 18 Aug 2025 15:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755531146; cv=none; b=F5Mx5XWhFrNGGGFFSiF07krKLVsuF5FoZi12nBEDhXBE8eJycC9ZZuCAgK0sGgwPj1mZGPBql1l4OLX/fVKHmVGxtNIDneOppTUVCXXZrsoKWi3rgZX7jvSuSSv+o5RzwW14Un8cbVuzsxv+zOvrtSGuYovX+IArZNRUOZfEgGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755531146; c=relaxed/simple;
	bh=dKQCX01Dgpw9dc/KO/HCmSw5Ji9XL1b1m8P0ZMz1jPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=mZsXkwAOkDDEe+0LuklY46dEgr5+f2agJgG9eLnzFtz8fwXwX56zr0QqMft4v0as5pD0dwkTE5cC3GqrXJ4oKCOE6XeZ5SVrNYecI/6uONDg9mkvIDHPmXrX79x7o8nVrDCj+nPCV+FlUB1zuqGIGucmuxpUGAUXY6Zd8bQuSow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i4GwIKRv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3DF8C4CEEB;
	Mon, 18 Aug 2025 15:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755531146;
	bh=dKQCX01Dgpw9dc/KO/HCmSw5Ji9XL1b1m8P0ZMz1jPQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=i4GwIKRvXxjZa4rtVFv3GPe+eKTHZRFSrtqyusSq+MuQuHgUtaQV4CG8/ZLcGjfqe
	 mbVBgHbeekUgLdChCoG7oxukfrmg/Qrpw+xXjBVXs2AkgoK9TShnzv35dbsP+DtOOz
	 g1/wDkxxdtijZLbTyqZKZkpfth4XrAuP5v1sGPQwgNVm/dmQkJ0yLAjOXZLAjlCLmy
	 J6o+FsD8UWqSTSRv3+4tZhDeDG80Vcmegt+cyDCx/w+q45AQxQdmUgZ1GLeFse1mwP
	 WKaWpyqCTQNh5ukob9V5r0XJrPzz8lAe7bNQFb7o+odmrt7qYLqqMI55cifKWuG1Zu
	 WfTl821z0bJiQ==
Date: Mon, 18 Aug 2025 10:32:24 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: frank.li@nxp.com, jingoohan1@gmail.com, l.stach@pengutronix.de,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, bhelgaas@google.com, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RESEND v3 5/5] PCI: dwc: Don't return error when wait for link
 up
Message-ID: <20250818153224.GA527775@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818073205.1412507-6-hongxing.zhu@nxp.com>

On Mon, Aug 18, 2025 at 03:32:05PM +0800, Richard Zhu wrote:
> When waiting for the PCIe link to come up, both link up and link down
> are valid results depending on the device state. Do not return an error,
> as the outcome has already been reported in dw_pcie_wait_for_link().

The reporting in dw_pcie_wait_for_link() is only a note in dmesg (and
the -EDTIMEDOUT return, which we're throwing away here).

We need an explanation here about why the caller of
dw_pcie_resume_noirq() doesn't need to know whether the link came up.
A short comment in the code would be useful as well.

> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 868e7db4e3381..e90fd34925702 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -1089,9 +1089,7 @@ int dw_pcie_resume_noirq(struct dw_pcie *pci)
>  	if (ret)
>  		return ret;
>  
> -	ret = dw_pcie_wait_for_link(pci);
> -	if (ret)
> -		return ret;
> +	dw_pcie_wait_for_link(pci);
>  
>  	return ret;

This should be "return 0" because if "ret" was non-zero, we returned
that earlier.

>  }
> -- 
> 2.37.1
> 

