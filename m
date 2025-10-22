Return-Path: <linux-pci+bounces-38990-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C56BFB6D0
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 12:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5A0355079DB
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 10:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E72323411;
	Wed, 22 Oct 2025 10:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WM1bOkdE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4350C3126A3
	for <linux-pci@vger.kernel.org>; Wed, 22 Oct 2025 10:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761129287; cv=none; b=tlZFpe4eHhzgYHeScqeO3oZpwZGC4LiNtgOb2pZE2yrR4XbKBe3rQaQjVOL+aUe09Mn0lLSeUXxfDtUeDThhl5ZWtcwCDllSJC1g90HSN0R1dz7G+zrW8TpL2OB8EdSOwJxd20mwP+F/gYoK7TbQHtVJ0SC7PY1G/vcbIEZe9dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761129287; c=relaxed/simple;
	bh=iKWiMpS9yTCF4CtP/NLjnVV5K6hlJ5vqcnHI8mOLdOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CyKbcD56ZT0OLiN1bE1aJjoFZzU67fKtEZN9ezwWLfR8FBsxpLd83onKgcoJGuclyiIB55ARqASdJ23tM1ElI2qFjZz24b/VIOuNgREaaB/4XItZlAvQIHInQgu2xC92FWXSN9mfgj0SQvBugEAx58+aiYgFhfDDFpTcdY7E0qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WM1bOkdE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1DA9C4CEE7;
	Wed, 22 Oct 2025 10:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761129285;
	bh=iKWiMpS9yTCF4CtP/NLjnVV5K6hlJ5vqcnHI8mOLdOc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WM1bOkdEO88jpwHE8e3Wc2/cgVD6fKDGNIRJFpA4M/1gBOLq97UD5sPDidwl0pUgn
	 W9769V/pe5b2+D16DLfxBQvlgwYW5Kd0NHA8iaaUCG8nyJnWPP6U3UmnIpW5LJq4ID
	 7XbbNZwD9OtvKuD1+M4Fm2UorJ2SGZBd4K+zDjibhOCbu5J5Kw0BMhAOUgIWaQAu80
	 1YSFHe+p5Qu10V2kO5mSJar/9RYJdNWhGkhqTQtNgxRO92rfSoznLikuigXnIArXYr
	 FdZ6PHbiKOUCpjTn7L6Oxry5s+YzeCJbQhhpqO4mI9DSQZaKE73ynVmjtdkUgTk1Oe
	 BdLfryxjvcZ6g==
Date: Wed, 22 Oct 2025 16:04:29 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Hans Zhang <hans.zhang@cixtech.com>, 
	Thierry Reding <thierry.reding@gmail.com>, linux-rockchip@lists.infradead.org, 
	Niklas Cassel <cassel@kernel.org>, linux-pci@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>, 
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 3/4] PCI: dw-rockchip: Add L1sub support
Message-ID: <bjfh7hwjswbk2paqlsmwby3g6dpmheyyjni32x3ywgxgdlwre6@6m4uifvjdkos>
References: <1761032907-154829-1-git-send-email-shawn.lin@rock-chips.com>
 <1761032907-154829-4-git-send-email-shawn.lin@rock-chips.com>
 <3f90b0f9-06bb-44d3-97a3-a13ced9b1c3a@cixtech.com>
 <162e1af2-7de3-4aed-93d1-fa7120254e69@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <162e1af2-7de3-4aed-93d1-fa7120254e69@rock-chips.com>

On Tue, Oct 21, 2025 at 04:42:52PM +0800, Shawn Lin wrote:
> 
> 在 2025/10/21 星期二 16:01, Hans Zhang 写道:
> > 
> > 
> > On 10/21/2025 3:48 PM, Shawn Lin wrote:
> > > EXTERNAL EMAIL
> > > 
> > > The driver should set app_clk_req_n(clkreq ready) of
> > > PCIE_CLIENT_POWER reg
> > > to support L1sub. Otherwise, unset app_clk_req_n and pull down CLKREQ#.
> > > 
> > > Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> > > ---
> > >   drivers/pci/controller/dwc/pcie-dw-rockchip.c | 31 ++++++++++++++-----
> > >   1 file changed, 23 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > > b/drivers/ pci/controller/dwc/pcie-dw-rockchip.c
> > > index 87dd2dd188b4..8a52ff73ec46 100644
> > > --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > > +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > > @@ -62,6 +62,12 @@
> > >   /* Interrupt Mask Register Related to Miscellaneous Operation */
> > >   #define PCIE_CLIENT_INTR_MASK_MISC     0x24
> > > 
> > > +/* Power Management Control Register */
> > > +#define PCIE_CLIENT_POWER              0x2c
> > > +#define  PCIE_CLKREQ_READY             0x10001
> > > +#define  PCIE_CLKREQ_NOT_READY         0x10000
> > > +#define  PCIE_CLKREQ_PULL_DOWN         0x30001000
> > > +
> > >   /* Hot Reset Control Register */
> > >   #define PCIE_CLIENT_HOT_RESET_CTRL     0x180
> > >   #define  PCIE_LTSSM_APP_DLY2_EN                BIT(1)
> > > @@ -84,6 +90,7 @@ struct rockchip_pcie {
> > >          struct gpio_desc *rst_gpio;
> > >          struct irq_domain *irq_domain;
> > >          const struct rockchip_pcie_of_data *data;
> > > +       bool supports_clkreq;
> > >   };
> > > 
> > >   struct rockchip_pcie_of_data {
> > > @@ -199,15 +206,21 @@ static bool rockchip_pcie_link_up(struct
> > > dw_pcie *pci)
> > >          return FIELD_GET(PCIE_LINKUP_MASK, val) == PCIE_LINKUP;
> > >   }
> > > 
> > > -/*
> > > - * See e.g. section '11.6.6.4 L1 Substate' in the RK3588 TRM V1.0
> > > for the steps
> > > - * needed to support L1 substates. Currently, not a single rockchip
> > > platform
> > > - * performs these steps, so disable L1 substates until there is
> > > proper support.
> > > - */
> > > -static void rockchip_pcie_disable_l1sub(struct dw_pcie *pci)
> > 
> > Hi,
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?
> > h=controller/dw-rockchip&id=40331c63e7901a2cc75ce6b5d24d50601efb833d
> > 
> > Mani has already placed this part in the above branch. Can it be removed?
> > 
> 
> I think it's better to apply the changes on top of Niklas's commit rather
> than removing it, out of respect for Niklas's credit.
> 

There is no point in removing a feature in one patch and adding it back in
another patch in the same release. Once this series materializes, I'll drop the
patch from Niklas.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

