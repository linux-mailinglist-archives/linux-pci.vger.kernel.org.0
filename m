Return-Path: <linux-pci+bounces-44597-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B3157D17E54
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 11:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2BD4E3003860
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 10:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53725389E01;
	Tue, 13 Jan 2026 10:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TR1n3nxe"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB98343D7B;
	Tue, 13 Jan 2026 10:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768299190; cv=none; b=G4TK+JRCZZI66p5qXk74KGpH9b0edMr+yZiOm08rk1ua1oOYgsJe5K4Gsxam1CNdHiHFkYnlTtuboi6huu6i17VEoVVH3ze1LkFn2KWoppGqhEJXtvd/9/16TyG0RaZFg9ih0Ex6Gct12s+8rcl4NYtMSxG3yFzDsi1Xwxq8A30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768299190; c=relaxed/simple;
	bh=B60Fgt62EI+KMFzznTOtUxbSOZ4bl9cL8ytB20WIh18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MaehaiuR4gzZoefHKFNXfcAPqFlAolryYuJPDK+Pc0P3Pd3imCRcsHdQ1y2HoJdWg7PP6uF8MiU1ivFb7/wwwMaWvkAHBr2jEeOgfqTJEKe+GYiCi/d7fZnz45DP8TJZ+gJMa+eKEvrRBOkenUJbdYa54+CuAJ0JGeiJ/Ws4E7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TR1n3nxe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED356C19423;
	Tue, 13 Jan 2026 10:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768299189;
	bh=B60Fgt62EI+KMFzznTOtUxbSOZ4bl9cL8ytB20WIh18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TR1n3nxeNYKPBju7jSmTmUvHf2B07hvvjuClTqXpglYDTqUIy3Qc+ayTSIQ67kdIW
	 M0dogUadKwpI8h4jvgScUNLHuPpfbDt72RggjaLhTMNJ7ilAdcNOaFZ7DP4BB8L3iQ
	 pxtiM+2rAxz/7nXY1Gfa4Lf/sua6WJYBRwQl3QgHhT9y7zjGrl8I21BrlhCOtmeZ7M
	 j/QK2RGJUmXm/TWFHY1viLqWV/1cRQnveztEjn7wZpPxhcp3HkUUE5GqdpNOtWv+Z3
	 JSgAtsbANLy8Foi9gAgpkGw7D1b7Q4uu7lOrRkXsdRH4iHGFcjMTZa2D+8nBwldlOa
	 l9AGfTdUR8RjQ==
Date: Tue, 13 Jan 2026 11:12:57 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com,
	vigneshr@ti.com, s-vadapalli@ti.com, hongxing.zhu@nxp.com,
	l.stach@pengutronix.de, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, minghuan.Lian@nxp.com,
	mingkai.hu@nxp.com, roy.zang@nxp.com, jesper.nilsson@axis.com,
	heiko@sntech.de, srikanth.thokala@intel.com,
	marek.vasut+renesas@gmail.com, yoshihiro.shimoda.uh@renesas.com,
	geert+renesas@glider.be, magnus.damm@gmail.com,
	christian.bruel@foss.st.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, thierry.reding@gmail.com,
	jonathanh@nvidia.com, hayashi.kunihiko@socionext.com,
	mhiramat@kernel.org, kishon@kernel.org, jirislaby@kernel.org,
	rongqianfeng@vivo.com, 18255117159@163.com,
	shawn.lin@rock-chips.com, nicolas.frattaroli@collabora.com,
	linux.amoon@gmail.com, vidyas@nvidia.com, Frank.Li@nxp.com,
	linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@axis.com, linux-rockchip@lists.infradead.org,
	linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v6 3/5] PCI: endpoint: Add dynamic_inbound_mapping EPC
 feature
Message-ID: <aWYaqZLhNVHof4BW@ryzen>
References: <20260113023715.3463724-1-den@valinux.co.jp>
 <20260113023715.3463724-4-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113023715.3463724-4-den@valinux.co.jp>

On Tue, Jan 13, 2026 at 11:37:13AM +0900, Koichiro Den wrote:
> Introduce a new EPC feature bit (dynamic_inbound_mapping) that indicates
> whether an Endpoint Controller can update the inbound address
> translation for a BAR without requiring the EPF driver to clear/reset
> the BAR first.
> 
> Endpoint Function drivers (e.g. vNTB) can use this information to decide
> whether it really is safe to call pci_epc_set_bar() multiple times to
> update inbound mappings for the BAR.
> 
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Since your new feature depends on this feature, this patch should be first
in the series.

With that fixed:
Reviewed-by: Niklas Cassel <cassel@kernel.org>

