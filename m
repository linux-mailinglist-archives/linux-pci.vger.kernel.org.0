Return-Path: <linux-pci+bounces-26056-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3928A913F7
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 08:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A4A91904763
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 06:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3F01F582C;
	Thu, 17 Apr 2025 06:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ng2Ma1fp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADFA1E1DE8
	for <linux-pci@vger.kernel.org>; Thu, 17 Apr 2025 06:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744871112; cv=none; b=ZICHOdX9nTN2Rv79jMZTLqcR2kL6BAuQ4gBf4vJw6u60xHynjr9/pKv3vht6bVm+cgfp5UELQoIpy8R0qNTbTQQZlM5vxu8vyh7WJaTU/GvdDsenCY6SLIAveCRLyZzZl3A1p20VRQ30j/n2c4Rg7/HYc/FDD+Dhe+NcMxrG5HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744871112; c=relaxed/simple;
	bh=CkcZHT9S/DrOH9gULoFqAN3BPOa15S+qzPUMMh9rsQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJ6264oxkyuaQpvB1xDNQLaVvozMf4C/TEskEOhWx51ntKPKH5ug0UmKGF1gY8uxAHMGXIWFcLiIdqxqJr2d1V2pDJhEwughip/hy1ybxQcQd+LSBL+dW52h4qk5wDDJlr76nadUCiedtUTpRZ7MfhznZcHw6bzpzqJaVwR23HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ng2Ma1fp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E896BC4CEE4;
	Thu, 17 Apr 2025 06:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744871112;
	bh=CkcZHT9S/DrOH9gULoFqAN3BPOa15S+qzPUMMh9rsQw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ng2Ma1fpZMD8295uxEY0tvRt6DA1jOxpOt4npjV08qFCdiq7M6flqMQC935JmBLZU
	 jiSEfy5t04UtIFPLA7POCceFmmb+ICU2bn0b4cmsQ/BqbQruWeNg8SsQWHPJeQ5ILO
	 DYrL8kQMZUdO2BFjG/bajIX/JC7IhBljpEzisexO+oBmACRl6s3ACkSNZnSE/8AoA1
	 LgB0yfkow0zFL1v8YwECCodalfiX+eMZhELRkpVLcxoG0QO5+WDhbAmpZBDtOtgAGE
	 IsXqBGwd1YMIrSc7/PzIKVgI5HVx0bVD0a4GcGF1L9b40Fa1uLh83aIt0hsCAwJRik
	 X72laD0f7RuOw==
Date: Thu, 17 Apr 2025 08:25:08 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v4 3/3] PCI: dw-rockchip: Move
 rockchip_pcie_ep_hide_broken_ats_cap_rk3588() to .init()
Message-ID: <aACexEN4wEv5fIMC@ryzen>
References: <1744850111-236269-1-git-send-email-shawn.lin@rock-chips.com>
 <1744850111-236269-3-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1744850111-236269-3-git-send-email-shawn.lin@rock-chips.com>

On Thu, Apr 17, 2025 at 08:35:11AM +0800, Shawn Lin wrote:
> There is no reason to call rockchip_pcie_ep_hide_broken_ats_cap_rk3588()
> from the pre_init() callback, instead of the normal init() callback.
> 
> Thus, move the rockchip_pcie_ep_hide_broken_ats_cap_rk3588() call from
> the pre_init() callback to the init() callback, as:
> 1) init() will still be called before link training is enabled, so the
>    quirk will still be applied before the host has can see our device.
> 2) This allows us to remove the pre_init() callback, as it is now unused.
> 3) It is a more robust design, as the init() callback is called by
>    dw_pcie_ep_init_registers(), which will always be called after a core
>    reset. The pre_init() callback is only called once, at probe time.
> 
> No functional changes.
> 
> Suggested-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---

Reviewed-by: Niklas Cassel <cassel@kernel.org>

