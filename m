Return-Path: <linux-pci+bounces-2946-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47451845E18
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 18:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9041CB36A27
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 16:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1CD46A3;
	Thu,  1 Feb 2024 16:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pl+W0pkO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1DC4A2E;
	Thu,  1 Feb 2024 16:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706806228; cv=none; b=MM76LdZNgy1s1sQvTF5Hz8qiug6tkKUswlsy4lvPb9AIfmjEAzGnRxpsFeU2yju3ti2YxTb4QflhW0C07cFgkIcF2L/SxLUM2aiG+H6z22IryXIPy2pKfYJKNaCvvilTXgBzaWaVpSRlt132D0fmgpL7315F0hNSQQaNiE+RWsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706806228; c=relaxed/simple;
	bh=9noK8opVgPqGaHN9hN9yvsJ2bJf6zwggh7pEkAy13bo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=VlKZRKD0LD6q9cDiNm6Es/lCqpZCn71/Z8v2mDN7PByORTijbCUf0wvmCwLZe9kp1ImJHuYuAcg9PQXeYBDckeA784WoltiDuk3T/vx4cqyQy3er9VBQCgLJeWCcKZKcsgKiv4VrSxLM08luWqIU7dN0xeXXOmGmMIeJX6KWqNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pl+W0pkO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF6D9C433F1;
	Thu,  1 Feb 2024 16:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706806228;
	bh=9noK8opVgPqGaHN9hN9yvsJ2bJf6zwggh7pEkAy13bo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Pl+W0pkOEzU2WA+lrrXlssxS7tk1FrPRyMuIr2QxW4ybWPHZ2fq0u8JnW0Nxq6FF7
	 5HvNeWqOMZjbtw0B6U2wAb01lm2H+mFQgehHTeI+jb1korrjKesM7mDlucouhV4PSS
	 T57vP0PgxcAPodLjWwdN+sLCRSK8KcnjzWNviOhF2bO2qxbxrdaz933fSP4+7VI6BI
	 A4TRenzME0sCNdT5mp59iJmnl5RVGwoTaOg3d8YMvv0XKG1jBpCBQtzpyiirrdw7Q5
	 vEphZHusKx7VjImi3ITbTWVlEYrE56T9LSUGiijYORA5QBUfum5K+4RUAytQrLbT9V
	 QR825PYKa1hYg==
Date: Thu, 1 Feb 2024 10:50:25 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: bhelgaas@google.com, devicetree@vger.kernel.org,
	gustavo.pimentel@synopsys.com, imx@lists.linux.dev, kw@linux.com,
	leoyang.li@nxp.com, linux-arm-kernel@lists.infradead.org,
	linux-imx@nxp.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com,
	lpieralisi@kernel.org, mani@kernel.org,
	manivannan.sadhasivam@linaro.org, minghuan.lian@nxp.com,
	mingkai.hu@nxp.com, robh+dt@kernel.org, roy.zang@nxp.com,
	shawnguo@kernel.org, zhiqiang.hou@nxp.com
Subject: Re: [PATCH v12 2/3] PCI: dwc: Implement general suspend/resume
 functionality for L2/L3 transitions
Message-ID: <20240201165025.GA637154@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821184815.2167131-3-Frank.Li@nxp.com>

On Mon, Aug 21, 2023 at 02:48:14PM -0400, Frank Li wrote:
> Introduce helper function dw_pcie_get_ltssm() to retrieve SMLH_LTSS_STATE.
> ...

> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 615660640801..91d13f9b21b1 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h

> @@ -364,6 +375,7 @@ struct dw_pcie_ops {
>  	void    (*write_dbi2)(struct dw_pcie *pcie, void __iomem *base, u32 reg,
>  			      size_t size, u32 val);
>  	int	(*link_up)(struct dw_pcie *pcie);
> +	enum dw_pcie_ltssm (*get_ltssm)(struct dw_pcie *pcie);

This has already been applied as
https://git.kernel.org/linus/4774faf854f5 ("PCI: dwc: Implement
generic suspend/resume functionality"), but this .get_ltssm() pointer
doesn't seem to be used anywhere.  Should we remove it until we need
it?

> +static inline enum dw_pcie_ltssm dw_pcie_get_ltssm(struct dw_pcie *pci)
> +{
> +	u32 val;
> +
> +	if (pci->ops && pci->ops->get_ltssm)
> +		return pci->ops->get_ltssm(pci);
> +
> +	val = dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG0);
> +
> +	return (enum dw_pcie_ltssm)FIELD_GET(PORT_LOGIC_LTSSM_STATE_MASK, val);
> +}

