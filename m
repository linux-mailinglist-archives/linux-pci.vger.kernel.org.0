Return-Path: <linux-pci+bounces-44765-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B62D1FEC1
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 16:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65B15305845E
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 15:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F3C3A0B03;
	Wed, 14 Jan 2026 15:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t6H+7e2d"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713DB39E6F9
	for <linux-pci@vger.kernel.org>; Wed, 14 Jan 2026 15:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768405440; cv=none; b=j+AxAzDNCQTXoD/AEnOk6xNdF9CfENSH+KHCdxm+6X+sx3/aCN34YitO70Wxp95xl6GX7cDGXe1qpbYrF2uQHH460MQYY6pwFUD6Wgw5ZPbFbjriUHwuREfj+yabjxDAgVdzxx7Vonu9pC/v2Fzzv0i1hHACtDZzx8jFoL1cTAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768405440; c=relaxed/simple;
	bh=ReVz6cPlRsm4lE4yj8qgNYX22f2C5+7rwEPvVzG9M+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XybR1Cwu7OwYvakc6jqqVFrEgQxNWG2EJpGsFKucMm9mdWHiNNAoyaq4Y5UDiV3Q1vg0XXQWxpxH3rsK21WApISRx2tWexzTKE7P9Q1cnLOM0UpwlS57klM70Y6fBa6SXsiHDrro+3fipAWMetUy8D953WO4SwFNG4+4Mkp2Re0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t6H+7e2d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3155BC16AAE;
	Wed, 14 Jan 2026 15:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768405440;
	bh=ReVz6cPlRsm4lE4yj8qgNYX22f2C5+7rwEPvVzG9M+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t6H+7e2dbK9gQEvEZJKxd76IWSbrl5frhABmypwBkBSe9/hSV1JA+4/TRUsjzkl5w
	 XQEZ1EISjXhn47N72nETB4OFNxb7Lsio8Sz0v77iL/NIBXmw4NRPzMMKcBkmee+gzp
	 UuJZakX/7QiK0Jto7I52nmYYQUgT7XroBKqdcNCmSVRUM56w1rTDGIm3d9tNZ/wdan
	 Ds5w84/WQgFGuxoEYkU0ORjWDlKOBID7SYhI6+PAvnT0xOG+wxCIOtA9r7h0AnNA8+
	 PkMGMTv8WY0Tgb7nY7IsVGFeDpSht3jygHKnLmdBhkyM5alXbV4JdzK270X3LyXATw
	 vM8Uz3eOiZcVA==
Date: Wed, 14 Jan 2026 16:43:53 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Vinod Koul <vkoul@kernel.org>,
	linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
	linux-phy@lists.infradead.org, Heiko Stuebner <heiko@sntech.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH 0/5] Add calibration for Synopsys PCIe PHY and Controller
Message-ID: <aWe5s5mqFt26lRGL@ryzen>
References: <1766560210-100883-1-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1766560210-100883-1-git-send-email-shawn.lin@rock-chips.com>

On Wed, Dec 24, 2025 at 03:10:05PM +0800, Shawn Lin wrote:
> 
> Currently, when pcie-dw-rockchip uses the Synopsys PHY, it relies on
> the phy_init() callback of the phy-rockchip-snps-pcie3 driver to
> perform calibration. This is incorrect because the controller is
> still held in reset at that time, preventing the PHY from accurately
> reflecting the actual PLL lock and calibration status.

Hello Shawn,

I can see that you move the calibration code from .phy_init() to
.phy_calibrate().

And I understandthat the controller is still held in reset.

I understand that the the PHY calibration is supposed to be done
when the controller is not held in reset, and that alone is
enough to warrant a fix.

The Synopsys Gen3 PHY is used in e.g. Rock5b, and link training
currently works fine with this PHY, so what is the actual
implications of performing the PHY calibration when the controller
is held in reset?

Will it somehow it improve signal integrity?


Kind regards,
Niklas

> 
> To fix this, this series:
> 1. Calls phy_calibrate() in the pcie-dw-rockchip driver (if supported)
>    after the controller is out of reset, ensuring the PHY can
>    properly synchronize with the controller state.
> 2. Adds the necessary calibration support in the Synopsys PHY driver
>    to implement this callback.

