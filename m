Return-Path: <linux-pci+bounces-36897-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB9BB9BC9F
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 22:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B1A3164197
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 20:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2062727E2;
	Wed, 24 Sep 2025 19:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IU8Blo7g"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A80263899;
	Wed, 24 Sep 2025 19:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758743997; cv=none; b=t2x0tA0Q9/9JnrTz/bKJxPRUJdH/fovcN2xLzk3qLpLx+t7EUXhlil4YfaGMZW4B61k/Q1kj+1d3I5hXE74FI5axHZqceeqd6jPA8GBrCaAOrvoVYcaaadIRtXV5XZiYLXynYUbCqvKLHGN/3eUBi0/2xkC8i1itFVAHoEMewE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758743997; c=relaxed/simple;
	bh=73wTCutzdqB7e3bMkutV3dF3j841Mh5OPxmNu0G40w4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=FXAMyFZlMz6ClEVaqFel3wFGDTZ3PP9v8YLGa0G4+qDj0tU+10E9SyJSkSnKj0C0MbHcg3Tcjdn+5swqp/vyFaQBLt0XdVyWcfqJinM9pnXuX92Seexc7PGgS9Y0St/6VzL7blFRWw0By1deP7N/gvO/OMOOpSXKYWOx6Za3WrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IU8Blo7g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E9FC4CEE7;
	Wed, 24 Sep 2025 19:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758743996;
	bh=73wTCutzdqB7e3bMkutV3dF3j841Mh5OPxmNu0G40w4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=IU8Blo7g52ooQwvBxy9BqSMyKa1yhskXxlBQZWapZs9L4jgfF+jYxe8s4zDSSkv8p
	 rvAPMNRzeor6O33mrqQteJy1N3XUCe6+wsRvf23JNzDW5KHZNPxC4KywGBleuC6pc/
	 19KnPI1p3LU1bc/+AxF8pEJTRnh3sd17QL0XxlkHutS7UjWYQ9J/a6rr9lx1qdPkTN
	 84t5puB/CDJYsv+80qGLHgO1jBHRtEVewq2NLuRlcVBbXqXDi8H47KzePEpOeKEbV1
	 WDdr5/uKYVlj+Utdt0GXLNOGRoiTZiOyMWBgeKvjhFxuwRoi6doarYX5Xj7DTA9pgv
	 B4uA1cPkg/xCQ==
Date: Wed, 24 Sep 2025 14:59:55 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: frank.li@nxp.com, jingoohan1@gmail.com, l.stach@pengutronix.de,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, bhelgaas@google.com, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v6 3/4] PCI: dwc: Skip PME_Turn_Off message if there is
 no endpoint connected
Message-ID: <20250924195955.GA2132329@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924072324.3046687-4-hongxing.zhu@nxp.com>

On Wed, Sep 24, 2025 at 03:23:23PM +0800, Richard Zhu wrote:
> A chip freeze is observed on i.MX7D when PCIe RC kicks off the PM_PME
> message and no any devices are connected on the port.

s/no any/no/

> To workaroud such kind of issue, skip PME_Turn_Off message if there is
> no endpoint connected.

s/workaroud/work around/

> Cc: stable@vger.kernel.org
> Fixes: 4774faf854f5 ("PCI: dwc: Implement generic suspend/resume functionality")
> Fixes: a528d1a72597 ("PCI: imx6: Use DWC common suspend resume method")
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 57a1ba08c427..b303a74b0fd7 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -1008,12 +1008,15 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>  	u32 val;
>  	int ret;
>  
> -	if (pci->pp.ops->pme_turn_off) {
> -		pci->pp.ops->pme_turn_off(&pci->pp);
> -	} else {
> -		ret = dw_pcie_pme_turn_off(pci);
> -		if (ret)
> -			return ret;
> +	/* Skip PME_Turn_Off message if there is no endpoint connected */
> +	if (dw_pcie_get_ltssm(pci) > DW_PCIE_LTSSM_DETECT_WAIT) {

This looks racy and it sounds like this is a workaround for an i.MX7D
defect.  Should it be some kind of quirk just for i.MX7D?

> +		if (pci->pp.ops->pme_turn_off) {
> +			pci->pp.ops->pme_turn_off(&pci->pp);
> +		} else {
> +			ret = dw_pcie_pme_turn_off(pci);
> +			if (ret)
> +				return ret;
> +		}
>  	}
>  
>  	if (dwc_quirk(pci, QUIRK_NOL2POLL_IN_PM)) {
> -- 
> 2.37.1
> 
> 

