Return-Path: <linux-pci+bounces-2397-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC55A833169
	for <lists+linux-pci@lfdr.de>; Sat, 20 Jan 2024 00:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65D881F23139
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 23:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3817A58AC8;
	Fri, 19 Jan 2024 23:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUPxmlZW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D39738E;
	Fri, 19 Jan 2024 23:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705706435; cv=none; b=i+Kiac5WdG3xx4+XQCk0Aujeh0Nxuhb33DVaiYa5AK7iR+7zk1ugkQWNG/s/IzK/a3pZ3pfdqAdFdMCyDJaWfkLW2KlMAEduZlm2edV1Ug9eFZ+bQlsGsoVcjgA8OlVtFM7d0A8XnLbJn/ELd6nhFeZwO4YxJJuEZvevMba2z+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705706435; c=relaxed/simple;
	bh=UdNTVVg961CwiMd5mYYDaAcvaTXvq85umlFhv66v4j0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=uP8bhYeSPuY0mWylgz81Cwv7h+MFaxZZrJNsBVDIP0/FE8ENCDEtnF9VBdE/H4anyoK9hdbj/eh1gg2XmvTQUjzDeu253yWXIdN6rHvekw9cqKVCR+IA0y/X9XAvEDWXs4q4+7xOKNN13o+o54zXOP47mQLU/QTvhO4FFb12tKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUPxmlZW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD33C433F1;
	Fri, 19 Jan 2024 23:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705706434;
	bh=UdNTVVg961CwiMd5mYYDaAcvaTXvq85umlFhv66v4j0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=iUPxmlZW3cYxAfpppMdb/zgUTSxrT57hkfXdY1Bqqne2bP3HJAVRqJOiMFAnyL2v2
	 mtgKFYVLsOyKU/dalbHacAlxKDtpxR9N8Q5kfXgSHOK2zKrnnMZavxopK0hx59O2fJ
	 X79zrj5r727bHZ5rh0hl4IM5p/N/KLBpODpDJWnac/BKfnvxgQsad4qrPxEbY1gMaw
	 uINgLmt6f+TwIEPaZHqUcIjgp5v18nnUVe+DYIby41w1eyaksUMIiE6xEnPhgv0Dpk
	 ELmGDni7xmhgYqefbWiO4MGBmT3omsQ5FZeqEW6wklkawAeNcbY62aTyfIL8TZElYi
	 G5eIbB/1TTkgg==
Date: Fri, 19 Jan 2024 17:20:32 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	ilpo.jarvinen@linux.intel.com, vigneshr@ti.com,
	r-gunasekaran@ti.com, srk@ti.com
Subject: Re: [PATCH v3] PCI: keystone: Fix race condition when initializing
 PHYs
Message-ID: <20240119232032.GA192245@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8dbbffd-c209-44bc-8d1e-42b6f1b08aef@ti.com>

On Wed, Jan 10, 2024 at 11:35:24AM +0530, Siddharth Vadapalli wrote:
> Hello Bjorn,
> 
> On 10/01/24 02:53, Bjorn Helgaas wrote:
> > On Wed, Sep 27, 2023 at 09:48:45AM +0530, Siddharth Vadapalli wrote:
> >> The PCI driver invokes the PHY APIs using the ks_pcie_enable_phy()
> >> function. The PHY in this case is the Serdes. It is possible that the
> >> PCI instance is configured for 2 lane operation across two different
> 
> ...
> 
> >>  
> >> +	/* Obtain reference(s) to the phy(s) */
> >> +	for (i = 0; i < num_lanes; i++)
> >> +		phy_pm_runtime_get_sync(ks_pcie->phy[i]);
> >> +
> >>  	ret = ks_pcie_enable_phy(ks_pcie);
> >> +
> >> +	/* Release reference(s) to the phy(s) */
> >> +	for (i = 0; i < num_lanes; i++)
> >> +		phy_pm_runtime_put_sync(ks_pcie->phy[i]);
> > 
> > This looks good and has already been applied, so no immediate action
> > required.
> > 
> > This is the only call to ks_pcie_enable_phy(), and these loops get and
> > put the PM references for the same PHYs initialized in
> > ks_pcie_enable_phy(), so it seems like maybe these loops could be
> > moved *into* ks_pcie_enable_phy().
> 
> Does the following look fine?
> ===============================================================================
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c
> b/drivers/pci/controller/dwc/pci-keystone.c
> index e02236003b46..6e9f9589d26c 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -962,6 +962,9 @@ static int ks_pcie_enable_phy(struct keystone_pcie *ks_pcie)
>         int num_lanes = ks_pcie->num_lanes;
> 
>         for (i = 0; i < num_lanes; i++) {
> +               /* Obtain reference to the phy */
> +               phy_pm_runtime_get_sync(ks_pcie->phy[i]);

I thought the point was that you needed to guarantee that all PHYs are
powered on and stay that way before initializing any of them.  If so,
you would need a separate loop, e.g.,

  for (i = 0; i < num_lanes; i++)
    phy_pm_runtime_get_sync(ks_pcie->phy[i]);

  for (i = 0; i < num_lanes; i++) {
    ret = phy_reset(ks_pcie->phy[i]);
    ...

>                 ret = phy_reset(ks_pcie->phy[i]);
>                 if (ret < 0)
>                         goto err_phy;
> @@ -977,12 +980,18 @@ static int ks_pcie_enable_phy(struct keystone_pcie *ks_pcie)
>                 }
>         }
> 
> +       /* Release reference(s) to the phy(s) */
> +       for (i = 0; i < num_lanes; i++)
> +               phy_pm_runtime_put_sync(ks_pcie->phy[i]);
> +
>         return 0;
> 
>  err_phy:
>         while (--i >= 0) {
>                 phy_power_off(ks_pcie->phy[i]);
>                 phy_exit(ks_pcie->phy[i]);
> +               /* Release reference to the phy */
> +               phy_pm_runtime_put_sync(ks_pcie->phy[i]);
>         }
> 
>         return ret;

