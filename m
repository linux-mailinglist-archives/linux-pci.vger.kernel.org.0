Return-Path: <linux-pci+bounces-25142-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26822A78AFD
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 11:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8527E1894194
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 09:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798912356CE;
	Wed,  2 Apr 2025 09:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="ezHqbO70"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m15595.qiye.163.com (mail-m15595.qiye.163.com [101.71.155.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1689F2356C3;
	Wed,  2 Apr 2025 09:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743585768; cv=none; b=qsZx/xugdkmL0ctvHTz9UMPzEMgxOwktMj8Afa4P+FblBx9Tdf+RQwDKowsNBDCIA2io/DkhlemUsTit0kGleIoEbOCvrXA4CMGi+ZoJXMuWaufMOxhEzq4bNg9EOSQ0bWQd0SmdXhd8SaRaWfnNMzdDbZElj7dM8ggyBCP79LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743585768; c=relaxed/simple;
	bh=3bUvsKQx9rR3VdIidIu3W5+wjactKFssNxj9ejgwtzM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=F+c5tjzat0p1qC67NHvxyww/AJMTtQKqWPTjvItMk8MLyq07gTQZX8KX8Xl36G4+2F0fxuiGHT4wU/oAQlLltas4iBOY/h7hV7DN5JlTfeb7lvnkDgPeBNrapx88DjOpIYQ8/d2rYq36dVD97LC0qRrR2ikmabIysOi6LJ7nFbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=ezHqbO70; arc=none smtp.client-ip=101.71.155.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.129] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 10721275b;
	Wed, 2 Apr 2025 16:06:59 +0800 (GMT+08:00)
Message-ID: <e340a408-2e21-1bca-7267-46b84690f66f@rock-chips.com>
Date: Wed, 2 Apr 2025 16:06:55 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Cc: shawn.lin@rock-chips.com, =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?=
 <kwilczynski@kernel.org>, linux-pci@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: rockchip: Fix order of rockchip_pci_core_rsts
To: Jensen Huang <jensenhuang@friendlyarm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Heiko Stuebner <heiko@sntech.de>, Philipp Zabel <p.zabel@pengutronix.de>,
 Anand Moon <linux.amoon@gmail.com>
References: <20250328105822.3946767-1-jensenhuang@friendlyarm.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20250328105822.3946767-1-jensenhuang@friendlyarm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGh0aQ1YdTE4aSB1IGhhPQkhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a95f58a0bdb09cckunm10721275b
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NT46SDo*HTIBCw49PC8JDjEi
	PQsaFE1VSlVKTE9ITkNKSUlKTkxKVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUlMSkk3Bg++
DKIM-Signature:a=rsa-sha256;
	b=ezHqbO70EDBQxmzrLCl8NxYSVUIU6/oSSOrrNjkXlFPkG0MhWO2zqfrPwMD+crfahb9VQ1m3kShzgfpQbI8wgdNEnAHGAtsDOuLtpEIdG+1QMvlGT+S5LhC/FOXk1qrMY7NsgRhBCxRrvsvg0BnAuJl1ih/3WP2Qg3lLjEQY2yE=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=tNpsgBqjJ9UNRLTVKNe5wOYMfZoRUBD/vq55ueB1bPY=;
	h=date:mime-version:subject:message-id:from;

在 2025/03/28 星期五 18:58, Jensen Huang 写道:
> The order of rockchip_pci_core_rsts follows the previous comments suggesting
> to avoid reordering. However, reset_control_bulk_deassert() applies resets in
> reverse, which may lead to the link downgrading to 2.5 GT/s.
> 
> This patch restores the deassert order and comments for core_rsts, introduced in
> commit 58c6990c5ee7 ("PCI: rockchip: Improve the deassert sequence of four reset pins").
> 
> Tested on NanoPC-T4 with Samsung 970 Pro.

Acked-by:  Shawn Lin <shawn.lin@rock-chips.com>

> 
> Fixes: 18715931a5c0 ("PCI: rockchip: Simplify reset control handling by using reset_control_bulk*() function")
> Signed-off-by: Jensen Huang <jensenhuang@friendlyarm.com>
> ---
>   drivers/pci/controller/pcie-rockchip.h | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
> index 11def598534b..4f63a03d535c 100644
> --- a/drivers/pci/controller/pcie-rockchip.h
> +++ b/drivers/pci/controller/pcie-rockchip.h
> @@ -320,11 +320,15 @@ static const char * const rockchip_pci_pm_rsts[] = {
>   	"aclk",
>   };
>   
> +/*
> + * Please don't reorder the deassert sequence of the following
> + * four reset pins.
> + */
>   static const char * const rockchip_pci_core_rsts[] = {
> -	"mgmt-sticky",
> -	"core",
> -	"mgmt",
>   	"pipe",
> +	"mgmt",
> +	"core",
> +	"mgmt-sticky",
>   };
>   
>   struct rockchip_pcie {

