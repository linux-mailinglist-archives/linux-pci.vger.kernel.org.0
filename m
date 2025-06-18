Return-Path: <linux-pci+bounces-30069-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D463ADEFEC
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 16:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33A471892869
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 14:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8192E8E06;
	Wed, 18 Jun 2025 14:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHAFPWY+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76A62E06FC
	for <linux-pci@vger.kernel.org>; Wed, 18 Jun 2025 14:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750257616; cv=none; b=UostwbSS7xKd3RLgrZiQv0Lbt4N78rOAQKTHgCvroP/Y/3cdQ+PDxz/bSUYMtIHypYSJI74uZHjcyoXu4zi9ryHwIjZFQ19Deo0J3ZgvIoFuwkFyD1UfLv/lVAjoPOhRGo8dkZ+7xiqeew1YD2lOQpVZE0qV/TSrY1bOYeU2R84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750257616; c=relaxed/simple;
	bh=NZxcboNj0nuhBZTiZGcW1Uoh9H3u/i+DdNNtMO2BCiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CJq+j5xqs+eNRsg+9g7XgqsL+15ADgHOGeD7FIiQ3g6zT8dCi3qo0zbwlcsO4zZfjHqUx+XW3wOKZ/Jvdm1pb4gefVwnc/904GWOhb4wf8IY9BWszHW9rJBntUmyJqse08fI30VH6ytAkN1zC5oVDdxhMurN+lXQ88bGlKkNjes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHAFPWY+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03704C4AF09;
	Wed, 18 Jun 2025 14:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750257616;
	bh=NZxcboNj0nuhBZTiZGcW1Uoh9H3u/i+DdNNtMO2BCiw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fHAFPWY+bjZDxt88PVq4qICdy1RJi09dMFa8vOiWZGgCG0FvkQGsOWm1vvWeifh/y
	 4GxoSjdkIvCB5pIF3Ssu3kLb597vzXRBLBFPIn8CrT0FWDHg3tW2EDGElcRK+7/Wdd
	 D4f9blxctSSEh7VvHA0F391whCHN0kz+076R/CpLk0vzSCh75dLcJL86lRAv6ami0x
	 onyqMfNhrLZYU8ODll/pBG33p2rhancEWnop2WSLAFpXg6+401K4KID/IzMx7ldRc1
	 fgGQaQWRQK7zcnFkTJgFEVmGjXrC8JE4ReqzXpMSGF5UwMPIMHo5rn43VzGhK3KmFx
	 k9DdIMJHMye6Q==
Date: Wed, 18 Jun 2025 16:40:11 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2] PCI: dw-rockchip: Delay link training after hot reset
 in EP mode
Message-ID: <aFLPyxZD5lkAtw6b@ryzen>
References: <20250617220114.GA1156610@bhelgaas>
 <20250617220523.GA1157905@bhelgaas>
 <aFLL0vPFzxdVOR9a@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFLL0vPFzxdVOR9a@ryzen>

On Wed, Jun 18, 2025 at 04:23:19PM +0200, Niklas Cassel wrote:
> On Tue, Jun 17, 2025 at 05:05:23PM -0500, Bjorn Helgaas wrote:
> > On Tue, Jun 17, 2025 at 05:01:16PM -0500, Bjorn Helgaas wrote:
> > > On Fri, Jun 13, 2025 at 12:19:09PM +0200, Niklas Cassel wrote:
> > 
> > Oh, and this sets PCIE_LTSSM_ENABLE_ENHANCE | PCIE_LTSSM_APP_DLY2_EN
> > once at probe-time, but what about after a link-down/link-up cycle?
> > 
> > Don't we need to set PCIE_LTSSM_ENABLE_ENHANCE |
> > PCIE_LTSSM_APP_DLY2_EN again when the link comes up so we don't have
> > the same race when the link goes down again?
> 
> Nope, we don't.
> 
> To verify I used this patch:
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index be239254aacd..e79add5412b8 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -506,6 +506,8 @@ static irqreturn_t rockchip_pcie_ep_sys_irq_thread(int irq, void *arg)
>         if (reg & PCIE_LINK_REQ_RST_NOT_INT) {
>                 dev_dbg(dev, "hot reset or link-down reset\n");
>                 dw_pcie_ep_linkdown(&pci->ep);
> +               pr_info("PCIE_CLIENT_HOT_RESET_CTRL after reset: %#x\n",
> +                       rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_HOT_RESET_CTRL));
>                 /* Stop delaying link training. */
>                 val = HIWORD_UPDATE_BIT(PCIE_LTSSM_APP_DLY2_DONE);
>                 rockchip_pcie_writel_apb(rockchip, val,
> 
> 
> 
> 
> [   85.979567] rockchip-dw-pcie a40000000.pcie-ep: hot reset or link-down reset
> [   85.980210] PCIE_CLIENT_HOT_RESET_CTRL after reset: 0x12
> [   93.720413] rockchip-dw-pcie a40000000.pcie-ep: hot reset or link-down reset
> [   93.721074] PCIE_CLIENT_HOT_RESET_CTRL after reset: 0x12
> 
> 0x12 == bit 1 and bit 4 are set.
> 
> bit 1: app_dly2_en
> bit 4: app_ltssm_enable_enhance

Oh, and just to verify that the hardware does not clear the app_dly2_en bit
when we write the app_dly2_done bit, I ran the same test, but with the
prints in rockchip_pcie_ep_sys_irq_thread(), just after calling
dw_pcie_ep_linkup(&pci->ep); and got the same result:

[   57.176862] rockchip-dw-pcie a40000000.pcie-ep: link up
[   57.177338] PCIE_CLIENT_HOT_RESET_CTRL after linkup: 0x12
[   72.448052] rockchip-dw-pcie a40000000.pcie-ep: link up
[   72.448527] PCIE_CLIENT_HOT_RESET_CTRL after linkup: 0x12

So I think this patch is good as is.
(Except for the citation style in the commit message which you didn't like :))


Kind regards,
Niklas

