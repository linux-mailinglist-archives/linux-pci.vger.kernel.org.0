Return-Path: <linux-pci+bounces-27154-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7267AA9515
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 16:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0877C3A1802
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 14:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BDE1FF7D7;
	Mon,  5 May 2025 14:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ck58iJmJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDE0192D6B
	for <linux-pci@vger.kernel.org>; Mon,  5 May 2025 14:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746454149; cv=none; b=QFECTrVGjcFW11RYRjQspcmIUScgxGtvEvVpsmP+bhk3hNWfWN6DhhHL7oiIy9rnyVmwWVEzy9OWERuLrMQeu/g1izqGXvlK6VumtPN6jKTJlnfb/rbnsCKN/ly5kpYScpGq8VqfrUXRZnWnDoIWR3OURoBJW4pvaFIYmntktaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746454149; c=relaxed/simple;
	bh=YRqrqVzFrmTsTKtBwgPOzHahPm+oOSbLg9my9ROL07Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DIPBtscnRDP/aJRccvZf0jJsTfF7s6cgM39a7rqL9C5XYsvNtb6hY7nSiUR+XQJwTV7wtaPdw7wcZWIfoPkIzfKabuhpBZcPOJoUfDL7ycmvYci7YE5IzMEXnn2bVZMkZ0TfDhbUK5tsyffDNO30siJhaP/o4wxwIu05HKTDgb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ck58iJmJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13493C4CEE4;
	Mon,  5 May 2025 14:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746454148;
	bh=YRqrqVzFrmTsTKtBwgPOzHahPm+oOSbLg9my9ROL07Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ck58iJmJrtnaf30+tBuDoR3naDrSQu+nMQiA1XTUGaFs7cGWxy8L7IsOyru0sQIXM
	 5HtkX3HKqm/omXrQ1PKtJcwz0mW6ZqNPM78l5VMQ5vIqfubolwoParG4qQ4I5DeDk4
	 jTgmlU9v/afSPLRLpyp78X3xKDdvgUB3K+Dm6AaMnAek99av7jFxhK1J0jcJP814B+
	 /HCsph8wDGk//DT1o+mze2+FTtQPeIKqYd/mSh07oM+Kj8HQp0AU/u7pG3ccMpmtpz
	 ZkiwUEBe7sIjVc9YOFGCNtCuFLrJhklam+oSJ4O/OaPPZlFhVQCoj5oOnlwnC8SpgW
	 VOYRp7CAbXUdg==
Date: Mon, 5 May 2025 16:09:03 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hans Zhang <18255117159@163.com>,
	Laszlo Fiat <laszlo.fiat@proton.me>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 1/4] PCI: dw-rockchip: Do not enumerate bus before
 endpoint devices are ready
Message-ID: <aBjGf8-mDrqOrm5-@ryzen>
References: <20250505092603.286623-6-cassel@kernel.org>
 <20250505092603.286623-7-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505092603.286623-7-cassel@kernel.org>

On Mon, May 05, 2025 at 11:26:05AM +0200, Niklas Cassel wrote:
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index 7a6a95dc877a..ed8e3dfe80e0 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -471,6 +471,7 @@ static irqreturn_t rockchip_pcie_rc_sys_irq_thread(int irq, void *arg)
>  	if (reg & PCIE_RDLH_LINK_UP_CHGED) {
>  		if (rockchip_pcie_link_up(pci)) {
>  			dev_dbg(dev, "Received Link up event. Starting enumeration!\n");
> +			msleep(PCIE_T_RRS_READY_MS);
>  			/* Rescan the bus to enumerate endpoint devices */
>  			pci_lock_rescan_remove();
>  			pci_rescan_bus(pp->bridge->bus);
> -- 
> 2.49.0
> 

Bah.. this patch is missing
+#include "../../pci.h"

missed during rebase.

(pcie-qcom.c already includes this.)

Will send a V2.


Kind regards,
Niklas

