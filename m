Return-Path: <linux-pci+bounces-36893-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBADB9BBF3
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 21:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBE4F4C433A
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 19:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FE427604E;
	Wed, 24 Sep 2025 19:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jsiLHm1g"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16BC273FD;
	Wed, 24 Sep 2025 19:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758743098; cv=none; b=d3UppKA9QnSBL7LB0AuEQ3WJn8zHP4pg49fQE4k3nPnZh1D8S8M+ldo0fcqsSWkGm7/qkJED5E/H+eJ1vC+VWwnceHs4E8KjZ8m+bt7Eo2pwvjwcSrsgtnsjJRw6SttB3PXPfgvPw1LrFnhggZvUXUsK4cO3K5xuaPpYGwVVd6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758743098; c=relaxed/simple;
	bh=s3G5vm8zNI9Bmh0+IwNormIltha1LWLe8EQ0HF8XNg8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=J0tLx4haDPpEFAt2ZzHZQg+18LexfWFc7lLz/cZA2GJoIz0HAv0DM+42S5E1kKp8mAR1gQiEGvFi1LTV7j5CMNmy+/HYUfSnGxnTerMMyfe/Kr+5g7oPZ/mVRIYNOP+57E91gQGfNmEDLGAxGTQS2oyd2FuKAVr1YulIK5UFiOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jsiLHm1g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF3FC4CEE7;
	Wed, 24 Sep 2025 19:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758743098;
	bh=s3G5vm8zNI9Bmh0+IwNormIltha1LWLe8EQ0HF8XNg8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=jsiLHm1g1QiReRZ2bgB0YtliwwFwoN+e+oaIAu3dl0OQEVC8EYSWKb72Z8DBkotNn
	 UlPsOGVNmhgdUetimifm62ggR3xW/r67CXD6SKlGGiPMKiPAxdIY7knttQ8dwlNEo4
	 68g3P4yowkvC4j9LB/HtxJA8ue+mVRgNiZXDgrMjvDCH3yh6whip9HGbGpVcKXHUxD
	 VCEGegoeAQ0lEPOdcYTF1Bt0WY5wfiUoaNp+X5qZRiiJddnRjfdBPaqBPzu1TkUHYV
	 CHD7spFuFvOP4q3tE69VKKO2EIZBqoG12gll6j738zvjaFsMMj3CTm1hgEHq30DYFC
	 RIoA8xMXyy2Bw==
Date: Wed, 24 Sep 2025 14:44:57 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: frank.li@nxp.com, jingoohan1@gmail.com, l.stach@pengutronix.de,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, bhelgaas@google.com, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v6 1/4] PCI: dwc: Remove the L1SS check before putting
 the link into L2
Message-ID: <20250924194457.GA2131297@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924072324.3046687-2-hongxing.zhu@nxp.com>

On Wed, Sep 24, 2025 at 03:23:21PM +0800, Richard Zhu wrote:
> The ASPM configuration shouldn't leak out here. Remove the L1SS check
> during L2 entry.

I'm all in favor of removing this code if possible, but we need to
explain why this is safe.  The L1SS check was added for some reason,
and we need to explain why that reason doesn't apply.

> Cc: stable@vger.kernel.org
> Fixes: 4774faf854f5 ("PCI: dwc: Implement generic suspend/resume functionality")
> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 952f8594b501..9d46d1f0334b 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -1005,17 +1005,9 @@ static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
>  
>  int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>  {
> -	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>  	u32 val;
>  	int ret;
>  
> -	/*
> -	 * If L1SS is supported, then do not put the link into L2 as some
> -	 * devices such as NVMe expect low resume latency.
> -	 */
> -	if (dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL) & PCI_EXP_LNKCTL_ASPM_L1)
> -		return 0;
> -
>  	if (pci->pp.ops->pme_turn_off) {
>  		pci->pp.ops->pme_turn_off(&pci->pp);
>  	} else {
> -- 
> 2.37.1
> 

