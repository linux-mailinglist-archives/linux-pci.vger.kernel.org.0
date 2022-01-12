Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B07A848CA65
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jan 2022 18:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344154AbiALRvM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jan 2022 12:51:12 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:44828 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344144AbiALRvJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jan 2022 12:51:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DEEE61975
        for <linux-pci@vger.kernel.org>; Wed, 12 Jan 2022 17:51:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49401C36AEA;
        Wed, 12 Jan 2022 17:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642009868;
        bh=QDGZfNC3i2DMkb2WUL1XWYJx93nHOBR4R7mQIG2RD5o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=i3EU2wPBpyZZukiMdv9HCZEmO/kWWfVRPwf+3HXc9uc3sHRmIxnjPRASDuqV5AdNw
         qXTP0k13qc3zJzSKVNKgco2LsK/IWLv0ikj/XqgwFTdJxROddvFXmEdtxsQotjTKk/
         noAEbm5zwz2S6ZZv29kHOenuvYtHp8LccZPWJrLkPuJmc8b6gyVEtDn6NwABU19xr/
         9Ny9ZYTGMrrH/JfLp8rc0qhuLWbYbHG+8SaeMsPehcu8Xbb45948KL9Vcjwlj5v43i
         s1WtQFpXRo4YfN2UD736CHkMmYh16+gmRD7jm84k5dY9NQGGIIt2HroCag3jDd6ltJ
         l/G3klSCn2Hbg==
Date:   Wed, 12 Jan 2022 11:51:06 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        james.quinlan@broadcom.com, linux-pci@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH] fixup! PCI: brcmstb: Add control of subdevice voltage
 regulators
Message-ID: <20220112175106.GA267550@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220112013100.48029-1-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 11, 2022 at 08:31:00PM -0500, Jim Quinlan wrote:

What's this connected to?  Is this a fix for a patch that has already
been merged?  If so, which one?  If it's a standalone thing, it needs
a commit log and a Signed-off-by.  Actually, that would be good in any
case.  Maybe a lore link to the relevant patch?

> ---
>  drivers/pci/controller/pcie-brcmstb.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 8a3321314b74..4134f01acd87 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -1392,7 +1392,8 @@ static int brcm_pcie_resume(struct device *dev)
>  err_reset:
>  	reset_control_rearm(pcie->rescal);
>  err_regulator:
> -	regulator_bulk_disable(pcie->sr->num_supplies, pcie->sr->supplies);
> +	if (pcie->sr)
> +		regulator_bulk_disable(pcie->sr->num_supplies, pcie->sr->supplies);
>  err_disable_clk:
>  	clk_disable_unprepare(pcie->clk);
>  	return ret;
> -- 
> 2.17.1
> 
