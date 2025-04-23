Return-Path: <linux-pci+bounces-26450-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECC9A97BE2
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 03:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E83B03BDBF2
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 01:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3FD2745C;
	Wed, 23 Apr 2025 01:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="h9tOvoj3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m3288.qiye.163.com (mail-m3288.qiye.163.com [220.197.32.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEB72F41;
	Wed, 23 Apr 2025 01:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745370048; cv=none; b=L1SnvYPBFwHZIO5TMKR7Y6JR+jfXWaMi3mB07VklPwdFlrG+4YC+Lu7NYGJ93nYYk5nYd80l2b2brSZJV7sHqJcJmxP7uVXk6quSoRzHa+E8fvVT+KVYjaFq6QG2UZCpYAo8M/W529ZUfNJNOC/4ULIzqoE78elaIbRc4Nm03OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745370048; c=relaxed/simple;
	bh=wWF2vmfT5YKSI7GFAZGvlLniJyUBVqutiphSMk+mWe4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ja/lTZwdKtGnS7P9csFVUnIUTjoqNlkujTK1oe1qgSBtZ/KJJckDwXTzvgeqaG4arlP0xLlMw8csRhXt723Xt0BiSVSKg7ACnaFCOlQh9dVkDq0MSh4x8HtzWyseJPdITk0VheRcDS76C1aWUNqO+HNfuJOmfK6Z9+ms7+QDlzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=h9tOvoj3; arc=none smtp.client-ip=220.197.32.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.129] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 12c84bfa6;
	Wed, 23 Apr 2025 09:00:33 +0800 (GMT+08:00)
Message-ID: <4c00fce8-f148-c222-e0c1-e932f04bead0@rock-chips.com>
Date: Wed, 23 Apr 2025 09:00:32 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Cc: shawn.lin@rock-chips.com, Dragan Simic <dsimic@manjaro.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Rob Herring <robh@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] PCI: dw-rockchip: Fix function call sequence in
 rockchip_pcie_phy_deinit
To: Diederik de Haas <didi.debian@cknow.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>
References: <20250417142138.1377451-1-didi.debian@cknow.org>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20250417142138.1377451-1-didi.debian@cknow.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGhhMSVYdH0NJTU9LT0hJQ0NWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9660292c4d09cckunm12c84bfa6
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MxA6MQw4NjJDS0g4KRBOPgkr
	DzoKCQ1VSlVKTE9OSExLS0hPTExOVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUlITUg3Bg++
DKIM-Signature:a=rsa-sha256;
	b=h9tOvoj3hPT5WazN6NPH16KOTyYFb7W7Mubm3RWn2bfWOK9GADUVp15NwbrISzsiN+Ip3ufHh/zwQ9bg/lWixhRSBE8+fi4aPKJ9olJJKjTihi2IQ/+CTPJ5ZK5i1glMnRlWWDqGR5hDO9PVZPupk4VWVLnyNDff0BAlxu0rAIc=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=2QkUHWrrRsbgwVuGJvlBbxO6cfRY8uSV95tNc6tCSZw=;
	h=date:mime-version:subject:message-id:from;

在 2025/04/17 星期四 22:21, Diederik de Haas 写道:
> The documentation for the phy_power_off() function explicitly says
> 
>    Must be called before phy_exit().
> 
> So let's follow that instruction.

Thanks for this fixing.

Acked-by: Shawn Lin <shawn.lin@rock-chips.com>

> 
> Fixes: 0e898eb8df4e ("PCI: rockchip-dwc: Add Rockchip RK356X host controller driver")
> Cc: stable@vger.kernel.org	# v5.15+
> Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
> ---
>   drivers/pci/controller/dwc/pcie-dw-rockchip.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index c624b7ebd118..4f92639650e3 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -410,8 +410,8 @@ static int rockchip_pcie_phy_init(struct rockchip_pcie *rockchip)
>   
>   static void rockchip_pcie_phy_deinit(struct rockchip_pcie *rockchip)
>   {
> -	phy_exit(rockchip->phy);
>   	phy_power_off(rockchip->phy);
> +	phy_exit(rockchip->phy);
>   }
>   
>   static const struct dw_pcie_ops dw_pcie_ops = {

