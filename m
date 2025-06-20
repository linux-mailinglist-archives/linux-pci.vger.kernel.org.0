Return-Path: <linux-pci+bounces-30260-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9B5AE1D30
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jun 2025 16:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89D653A68E0
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jun 2025 14:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D3128D844;
	Fri, 20 Jun 2025 14:19:12 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739F128B509;
	Fri, 20 Jun 2025 14:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750429152; cv=none; b=qrBXlcGg+UutE9kMwBSO7thtHmO4o/Isz3ywQuIRRG4Z2ztXdMfmdty++aXgyoS4m+CUQs/tpguiY1et5VtiAlfH7eCqgs5Z1d/KvoIY6XVO3YWG1dmNVDobTjGy4Un+MkaE41M7fZQv8EVCI7bF+lC1Gbfk6FF5s9nrdNfVabQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750429152; c=relaxed/simple;
	bh=s31c1vUtSPnwMf5Zn0fyULfPmAC/rnhHc8hsxG7+zPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yfr/oPccqqg1ZWwxvA5t/GziMqzUFa7/OjJ5VzpvPyQTgt9M1hUeyHFGaN5/S/wYFw3V/plG6sI/bKa57SMWlIur2XmlC6PslFpblhnmFvhG942MHo6qVhGzh3dWsQ1+Hdiiz58BADmLk0kLPhb7x7b7WNy6rlcJG7sSTz30JLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 483E816F2;
	Fri, 20 Jun 2025 07:18:51 -0700 (PDT)
Received: from [10.57.27.59] (unknown [10.57.27.59])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 795A33F58B;
	Fri, 20 Jun 2025 07:19:08 -0700 (PDT)
Message-ID: <d52fce68-d01e-4b92-825f-f7408df2ca18@arm.com>
Date: Fri, 20 Jun 2025 15:19:06 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 4/4] phy: rockchip-pcie: Adjust read mask and write
To: Geraldo Nascimento <geraldogabriel@gmail.com>,
 linux-rockchip@lists.infradead.org
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Rick wertenbroek <rick.wertenbroek@gmail.com>,
 linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1749833986.git.geraldogabriel@gmail.com>
 <7068a941037eca8ef37cc65e8e08a136c7aac924.1749833987.git.geraldogabriel@gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <7068a941037eca8ef37cc65e8e08a136c7aac924.1749833987.git.geraldogabriel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-06-13 6:04 pm, Geraldo Nascimento wrote:
> Section 17.6.10 of the RK3399 TRM "PCIe PIPE PHY registers Description"
> defines asynchronous strobe TEST_WRITE which should be enabled then
> disabled and seems to have been copy-pasted as of current. Adjust it.

FWIW that's a bit hard to make sense of, given that it bears no relation 
whatsoever to the naming used in the code :/

(Not least because the mapping of register fields to phy signals here is 
really a property of GRF_SOC_CON8 rather than the phy itself)

> While at it, adjust read mask which should be the same as write mask.

Which write mask? Certainly not PHY_CFG_WR_MASK... However as this 
definition is unused since 64cdc0360811 ("phy: rockchip-pcie: remove 
unused phy_rd_cfg function"), I don't see much point in touching it 
other than to remove it entirely. If it is the case that only the 
address field is significant for whatever a "read" operation actually 
means, well then that's just another job for ADDR_MASK (which I guess is 
what the open-coded business with PHY_CFG_PLL_LOCK is actually doing...)

Thanks,
Robin.

> Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
> ---
>   drivers/phy/rockchip/phy-rockchip-pcie.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/rockchip/phy-rockchip-pcie.c b/drivers/phy/rockchip/phy-rockchip-pcie.c
> index 48bcc7d2b33b..35d2523ee776 100644
> --- a/drivers/phy/rockchip/phy-rockchip-pcie.c
> +++ b/drivers/phy/rockchip/phy-rockchip-pcie.c
> @@ -30,9 +30,9 @@
>   #define PHY_CFG_ADDR_SHIFT    1
>   #define PHY_CFG_DATA_MASK     0xf
>   #define PHY_CFG_ADDR_MASK     0x3f
> -#define PHY_CFG_RD_MASK       0x3ff
> +#define PHY_CFG_RD_MASK       0x3f
>   #define PHY_CFG_WR_ENABLE     1
> -#define PHY_CFG_WR_DISABLE    1
> +#define PHY_CFG_WR_DISABLE    0
>   #define PHY_CFG_WR_SHIFT      0
>   #define PHY_CFG_WR_MASK       1
>   #define PHY_CFG_PLL_LOCK      0x10


