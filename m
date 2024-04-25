Return-Path: <linux-pci+bounces-6672-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CFB8B2636
	for <lists+linux-pci@lfdr.de>; Thu, 25 Apr 2024 18:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A2A21F238D1
	for <lists+linux-pci@lfdr.de>; Thu, 25 Apr 2024 16:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5CA14D294;
	Thu, 25 Apr 2024 16:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i3wi4UNr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318A014D281;
	Thu, 25 Apr 2024 16:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714062022; cv=none; b=VnCqgzPd7PiBY/BMX6OJ3stL/Hh71oCct2MCNSR0cd1AZ0jzUHQoU/udHi4ZCNkHS8skowftBWcBlSDNvTPZTf5LpC9wyuBJwnNTi+fegyWJovZc2vLHTMsLVLdq7OAM6g5Ni/nw6uif3fVSC84b3zUGbL50Sx5ecOQI04CrvBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714062022; c=relaxed/simple;
	bh=rwsM3i04LbhwVLUCa72hPszIQ6ASQXF3hyZn6D35G3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/e6HJY1KH8FYpqwGtsPpWn6UGztuTf5eni68vCnKpBJU2P2JXZfONvZlhUWzWdiTwgqRUGJ9uXY+ZmsdJmHl9hI0XKIi8sDAZJK5dLDdrzwh0vqmhTHxZc6goHQsvTxqREVsjzK+KarghmKx/JMsB49Jw9z8KOK6IRZDEKHNeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i3wi4UNr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88598C113CC;
	Thu, 25 Apr 2024 16:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714062021;
	bh=rwsM3i04LbhwVLUCa72hPszIQ6ASQXF3hyZn6D35G3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i3wi4UNrntxXihjyFAvmrFIpLsJU1Bs6tt+OYwG9NWAYn7Enlt1kzVJjgIlOnRCTo
	 OESkUb/MIs4BLtdxgZW7vjUf4ES8HY/ku3R8Yxr7JLn01uw+jc6+lsVOlDanfv9CoI
	 xeJp+gwgIQiy23LFijnYRsesV+ggaWE7lQkfxf6HqT+DJjrp+nV00160QoP51giFSM
	 vrp2lrk6h5siKhd60tpCUxdyQ0UB5ppWqAkFyerLuJsiZ2DmJLkvoS6TzuO/JjdHn1
	 6V413pjt89uiinhiE1nlNorMsWco7UxrtGTSMFC+emQtZVgQGfeubS/f6cX3yC2QYM
	 cqvrSXMxXkEfA==
Date: Thu, 25 Apr 2024 11:20:19 -0500
From: Rob Herring <robh@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-pci@vger.kernel.org, Simon Xue <xxm@rock-chips.com>,
	linux-rockchip@lists.infradead.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, Arnd Bergmann <arnd@arndb.de>,
	Jon Lin <jon.lin@rock-chips.com>
Subject: Re: [PATCH 03/12] dt-bindings: PCI: snps,dw-pcie-ep: Add
 tx_int{a,b,c,d} legacy irqs
Message-ID: <171406054785.2613758.8157419905998918218.robh@kernel.org>
References: <20240424-rockchip-pcie-ep-v1-v1-0-b1a02ddad650@kernel.org>
 <20240424-rockchip-pcie-ep-v1-v1-3-b1a02ddad650@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424-rockchip-pcie-ep-v1-v1-3-b1a02ddad650@kernel.org>


On Wed, 24 Apr 2024 17:16:21 +0200, Niklas Cassel wrote:
> The DWC core has four interrupt signals: tx_inta, tx_intb, tx_intc, tx_intd
> that are triggered when the PCIe controller (when running in Endpoint mode)
> has sent an Assert_INTA Message to the upstream device.
> 
> Some DWC controllers have these interrupt in a combined interrupt signal.
> 
> Add the description of these interrupts to the device tree binding.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


