Return-Path: <linux-pci+bounces-26384-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB10EA967EC
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 13:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69F0A3BD3C8
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 11:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DDB27C14C;
	Tue, 22 Apr 2025 11:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lxq+6wdb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1097927BF85;
	Tue, 22 Apr 2025 11:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745321992; cv=none; b=JUtvd3EP8kvQGBWoWZ5xDlNkVyuUsnalOHpTaMTpjaGZWJnY+qdJ4iwbl7NEDH8yhNzpiXt/DjiqKLZXIvee0uUwa93q1IW+XUKq/e/p8tnPHE7dKv0YLKl+aOe7Ecom+I02JSTmJZziMsl86toyv6aGEiwke3fcuLY6TdNt8yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745321992; c=relaxed/simple;
	bh=LvVe3mABaUW4+b16EtPFOLNobUI0Izc6wjH25SG4f3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZTy46PFgxutH1x05RCFWd1hzn/Pr4+7VvzgZrXloqYElmc2FyuJYHpLNkF5WDIV80+6WhbyFyEhJx8idSf3l2YAXmC2ujQISzHTYDm9WvTVohcIVMaW8bjQqK7PwvX+x9rD+xu6jxCk4TySM++1h2azUruXc906LWrH5VxsD4ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lxq+6wdb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEC25C4CEE9;
	Tue, 22 Apr 2025 11:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745321991;
	bh=LvVe3mABaUW4+b16EtPFOLNobUI0Izc6wjH25SG4f3k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lxq+6wdbVCOSDSPGRxd2NJJi8at9gu0uT3YEYGZcGvaLp4Hkw7gqYT926bcNdFBsO
	 ZJES5SwEOCu1cE7wHVqNq9FYZM96sUKQIZWHPX5lSMhCANM4jTX0gRBWfSdgv/WRaw
	 0pEZaBS35Ja5OcQ2a8C4yq1wUziyx+T/MhrUJc6dgAVZq1/DUZFbyaC32dk93K588E
	 4U/5ERv3zZbwRz0Z6wMQTCtuEulkVD1v06qHOubA3OrRYgcwBlVJPgCgg5U+bJM2hw
	 tshbHzNrqMxBU4eeaUJMevxt9rpE7XqAz2JN8gpRzS2DEvqx6jedihlYxi/QkxS35t
	 uoEB6B2JL+PDQ==
Date: Tue, 22 Apr 2025 13:39:46 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
	heiko@sntech.de, manivannan.sadhasivam@linaro.org, robh@kernel.org,
	jingoohan1@gmail.com, shawn.lin@rock-chips.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 3/3] PCI: dw-rockchip: Unify link status checks with
 FIELD_GET
Message-ID: <aAeAAhb4R8ya_mBO@ryzen>
References: <20250422112830.204374-1-18255117159@163.com>
 <20250422112830.204374-4-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422112830.204374-4-18255117159@163.com>

On Tue, Apr 22, 2025 at 07:28:30PM +0800, Hans Zhang wrote:
> Link-up detection manually checked PCIE_LINKUP bits across RC/EP modes,
> leading to code duplication. Centralize the logic using FIELD_GET. This
> removes redundancy and abstracts hardware-specific bit masking, ensuring
> consistent link state handling.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index cdc8afc6cfc1..2b26060af5c2 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -196,10 +196,7 @@ static int rockchip_pcie_link_up(struct dw_pcie *pci)
>  	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
>  	u32 val = rockchip_pcie_get_ltssm(rockchip);
>  
> -	if ((val & PCIE_LINKUP) == PCIE_LINKUP)
> -		return 1;
> -
> -	return 0;
> +	return FIELD_GET(PCIE_LINKUP_MASK, val) == 3;

While I like the idea of your patch, here you are replacing something that
is easy to read (PCIE_LINKUP) with a magic value, which IMO is a step in
the wrong direction.


>  }
>  
>  static void rockchip_pcie_enable_l0s(struct dw_pcie *pci)
> @@ -499,7 +496,7 @@ static irqreturn_t rockchip_pcie_rc_sys_irq_thread(int irq, void *arg)
>  	struct dw_pcie *pci = &rockchip->pci;
>  	struct dw_pcie_rp *pp = &pci->pp;
>  	struct device *dev = pci->dev;
> -	u32 reg, val;
> +	u32 reg;
>  
>  	reg = rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_INTR_STATUS_MISC);
>  	rockchip_pcie_writel_apb(rockchip, reg, PCIE_CLIENT_INTR_STATUS_MISC);
> @@ -508,8 +505,7 @@ static irqreturn_t rockchip_pcie_rc_sys_irq_thread(int irq, void *arg)
>  	dev_dbg(dev, "LTSSM_STATUS: %#x\n", rockchip_pcie_get_ltssm(rockchip));
>  
>  	if (reg & PCIE_RDLH_LINK_UP_CHGED) {
> -		val = rockchip_pcie_get_ltssm(rockchip);
> -		if ((val & PCIE_LINKUP) == PCIE_LINKUP) {
> +		if (rockchip_pcie_link_up(pci)) {
>  			dev_dbg(dev, "Received Link up event. Starting enumeration!\n");
>  			/* Rescan the bus to enumerate endpoint devices */
>  			pci_lock_rescan_remove();
> @@ -526,7 +522,7 @@ static irqreturn_t rockchip_pcie_ep_sys_irq_thread(int irq, void *arg)
>  	struct rockchip_pcie *rockchip = arg;
>  	struct dw_pcie *pci = &rockchip->pci;
>  	struct device *dev = pci->dev;
> -	u32 reg, val;
> +	u32 reg;
>  
>  	reg = rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_INTR_STATUS_MISC);
>  	rockchip_pcie_writel_apb(rockchip, reg, PCIE_CLIENT_INTR_STATUS_MISC);
> @@ -540,8 +536,7 @@ static irqreturn_t rockchip_pcie_ep_sys_irq_thread(int irq, void *arg)
>  	}
>  
>  	if (reg & PCIE_RDLH_LINK_UP_CHGED) {
> -		val = rockchip_pcie_get_ltssm(rockchip);
> -		if ((val & PCIE_LINKUP) == PCIE_LINKUP) {
> +		if (rockchip_pcie_link_up(pci)) {
>  			dev_dbg(dev, "link up\n");
>  			dw_pcie_ep_linkup(&pci->ep);
>  		}
> -- 
> 2.25.1
> 

