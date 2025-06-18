Return-Path: <linux-pci+bounces-30065-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44245ADEF1B
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 16:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B3011BC320D
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 14:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88372EBB98;
	Wed, 18 Jun 2025 14:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QdAUprYK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46C22EBB96
	for <linux-pci@vger.kernel.org>; Wed, 18 Jun 2025 14:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750256599; cv=none; b=VHeiyDDGCEHzM074gydDQaxF4iDvsOPEQ0Cjw0tJu1cyuduNbT7N3nvzWLirJFJuQ6J2w9fUtWqEHiw6fxiziHGe1OqWUToCCW0NqIuttKIPZwDZICyQFYUfmP9jo3resuRTDGIxEoSTRkQOKUaB4EfJejjY1tcbkDMrQsoSO+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750256599; c=relaxed/simple;
	bh=Tw82APBfnc8betE49fdk4f7dJxLN1BXDSLLXI9UwX7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZryt01zoEiARafhdC9fl7ZbwAFObLHRM12RSPDhPU7DBTX4XkBHdQXYVFAypa5vz4xqtLtjJaMhYEst0DfYQ1SaE2USYnnmgWv0xPewCbYQ61xjbVd0wFQzmhkhAE+rOts+EPTio14MdhWERMHeEmG7QAkFgnzDhkGIid0daEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QdAUprYK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF084C4CEEE;
	Wed, 18 Jun 2025 14:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750256599;
	bh=Tw82APBfnc8betE49fdk4f7dJxLN1BXDSLLXI9UwX7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QdAUprYKJiSnsrJGpXN4Wmdq8DXkBhrJMF/FEGPXR2QnvW9p3H5kK1elO6+oQ5zP1
	 XWfCiGXzCXewJYibrQhrnn9YbF4K8CXWAjkxTaK94+H+HqVsWFvD32lh1WptSPnOXp
	 yLUkrvU/uomcQPTVq2Y1HpLub6VBB64WZILuuqiHz2dOxVw+MpxQEKcdKorBw1VXLz
	 gx7FoLEG/ELzuaYl5dzpzz8k/8C0WuLqq56KxebvN8Nov7JpBZL2qnZqq9waTzqBCs
	 61XHUF4Y/CmTLy+LXFmqFy2rPVd0ExD28khi6AoUdXa4nPx9R2gvLrqPYk2J4fkUws
	 hJDkGdgT+BDxQ==
Date: Wed, 18 Jun 2025 16:23:14 +0200
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
Message-ID: <aFLL0vPFzxdVOR9a@ryzen>
References: <20250617220114.GA1156610@bhelgaas>
 <20250617220523.GA1157905@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617220523.GA1157905@bhelgaas>

On Tue, Jun 17, 2025 at 05:05:23PM -0500, Bjorn Helgaas wrote:
> On Tue, Jun 17, 2025 at 05:01:16PM -0500, Bjorn Helgaas wrote:
> > On Fri, Jun 13, 2025 at 12:19:09PM +0200, Niklas Cassel wrote:
> 
> Oh, and this sets PCIE_LTSSM_ENABLE_ENHANCE | PCIE_LTSSM_APP_DLY2_EN
> once at probe-time, but what about after a link-down/link-up cycle?
> 
> Don't we need to set PCIE_LTSSM_ENABLE_ENHANCE |
> PCIE_LTSSM_APP_DLY2_EN again when the link comes up so we don't have
> the same race when the link goes down again?

Nope, we don't.

To verify I used this patch:

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index be239254aacd..e79add5412b8 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -506,6 +506,8 @@ static irqreturn_t rockchip_pcie_ep_sys_irq_thread(int irq, void *arg)
        if (reg & PCIE_LINK_REQ_RST_NOT_INT) {
                dev_dbg(dev, "hot reset or link-down reset\n");
                dw_pcie_ep_linkdown(&pci->ep);
+               pr_info("PCIE_CLIENT_HOT_RESET_CTRL after reset: %#x\n",
+                       rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_HOT_RESET_CTRL));
                /* Stop delaying link training. */
                val = HIWORD_UPDATE_BIT(PCIE_LTSSM_APP_DLY2_DONE);
                rockchip_pcie_writel_apb(rockchip, val,




[   85.979567] rockchip-dw-pcie a40000000.pcie-ep: hot reset or link-down reset
[   85.980210] PCIE_CLIENT_HOT_RESET_CTRL after reset: 0x12
[   93.720413] rockchip-dw-pcie a40000000.pcie-ep: hot reset or link-down reset
[   93.721074] PCIE_CLIENT_HOT_RESET_CTRL after reset: 0x12

0x12 == bit 1 and bit 4 are set.

bit 1: app_dly2_en
bit 4: app_ltssm_enable_enhance



I also looked at the downstream driver and they also only set it once
during probe().


When running the controller EP mode, we (the Linux driver) currently never
reset the whole core after probe(), and as we can see above, the hardware
itself also does not reset the app_dly2_en bit during a hot reset signal.


Kind regards,
Niklas

