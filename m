Return-Path: <linux-pci+bounces-20563-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90011A226CA
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jan 2025 00:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03DCF16363F
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 23:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A561B4F02;
	Wed, 29 Jan 2025 23:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGm9/Paj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3BC42A92;
	Wed, 29 Jan 2025 23:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738192781; cv=none; b=WJsTqW+i5dgFfmUoPyilvnQycLx34/ln69oTWQT9cqgDXkBYrs71vqhfqjMyM9tkfX3D9Wx5JW2Bp/xgtVqZioqT2940UmxG8mFVJ+92vQHKDcaBRTA2jOUwv2YYxaFqF8GnIGWxJK2T3iIABRdC2FrJEr+Owx2OT6LnPcE8OXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738192781; c=relaxed/simple;
	bh=Zlz47JZTSZjs6GkXMUpoX5Ar7Yt8/Hbx6Ol2UOf5Ut4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=eUVuC4+2iZ9Dyv/H3vPXn7+ALFjtdlEKH3oJJAhKT1Uczf1M5Yz82PRwTlNfzluZ9qL8ESa+nZ3lfje2/sHqWVuXqyjGSkSonmJQeWrFMIwZuDu8M+8TMRH7emNlGz4yeQjngQTJxejYEH8Tf8b6FVNAfeeI1RZlZtpydst6yIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGm9/Paj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 357B5C4CED1;
	Wed, 29 Jan 2025 23:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738192779;
	bh=Zlz47JZTSZjs6GkXMUpoX5Ar7Yt8/Hbx6Ol2UOf5Ut4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ZGm9/PajtiH2zlIiysQmjQCT7xD11s1wJMreoSshovuRxFLol+F3KFa0BK2JBM+xJ
	 xbYOoBhA7v6SsT362GM/xdQlTb8xggGVdrb7WlAoGCGsVOwnfKeaDIvZ9KkJbbo/f6
	 /85E1yTqT1++PIOhDftZIkwJBlM0ucyGyrZSQvpDYChQ81fcdx8DiJQxurnDd56k+s
	 FH8yRHzpjlPMMn88MsgnhzUL274aKyT9kuwCz2glvRwxpXyLSpCfgHbSZUiSf/5KuP
	 EsRm3iJJWlIgw/eCzA/SvixQW7ZW6opr8ZYqIzOhlyshWBqOuZN0kSs/xGUtnnxe46
	 e+ABxRyncP5XA==
Date: Wed, 29 Jan 2025 17:19:37 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v9 1/7] PCI: dwc: Use resource start as iomap() input in
 dw_pcie_pme_turn_off()
Message-ID: <20250129231937.GA523281@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128-pci_fixup_addr-v9-1-3c4bb506f665@nxp.com>

On Tue, Jan 28, 2025 at 05:07:34PM -0500, Frank Li wrote:
> Pass resource start as the input argument to iomap() instead of
> atu.cpu_address in dw_pcie_pme_turn_off(). While atu.cpu_address happens to
> be the same here, it actually represents the parent bus address before ATU,
> which may not always align with the CPU address. Using resource start
> ensures correctness and clarity.

1) "atu.cpu_address happens to be the same here" is currently true
   but only because this function is buggy and assumes the ATU input
   address is the same as a CPU physical address.

2) We're trying to make a correctness fix, not a clarity fix.  This
   patch by itself isn't a functional change because of the cpu_addr
   bug, but without this patch, fixing the cpu_addr bug would break
   the iomap.

3) "Pass resource start as the input to iomap()" just restates the
   patch.  We should say *why* this is important.  Something like
   this:

     The msg_res region translates writes into PCIe Message TLPs.
     Previously we mapped this region using atu.cpu_addr, the input
     address programmed into the ATU.

     "cpu_addr" is a misnomer because when a bus fabric translates
     addresses between the CPU and the ATU, the ATU input address is
     different from the CPU address.  A future patch will rename
     "cpu_addr" and correct the value to be the ATU input address
     instead of the CPU physical address.

     Map the msg_res region before writing to it using the msg_res
     resource start, a CPU physical address.

> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> change from v9 to v10
> - new patch
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index ffaded8f2df7b..ae3fd2a5dbf85 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -908,7 +908,7 @@ static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
>  	if (ret)
>  		return ret;
>  
> -	mem = ioremap(atu.cpu_addr, pci->region_align);
> +	mem = ioremap(pci->pp.msg_res->start, pci->region_align);
>  	if (!mem)
>  		return -ENOMEM;
>  
> 
> -- 
> 2.34.1
> 

