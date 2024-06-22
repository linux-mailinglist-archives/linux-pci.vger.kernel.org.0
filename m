Return-Path: <linux-pci+bounces-9118-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F49913435
	for <lists+linux-pci@lfdr.de>; Sat, 22 Jun 2024 15:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F5D028466F
	for <lists+linux-pci@lfdr.de>; Sat, 22 Jun 2024 13:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0349D16C445;
	Sat, 22 Jun 2024 13:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YRyrbmEZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD39B82492;
	Sat, 22 Jun 2024 13:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719063587; cv=none; b=U1m8kSiie3QcBp+38xvlvbO8J3MuBngo+dUhqmljBkL0vNDi12R36K7brarfTiPX52RkC3ltlrX/tjKe3kzzUpmQoJVq9cWkeULfcBsEElpUJ9HrFruxqpE6NInfgN2Lt1QISJtS6D7mqHdO0NH4TJaqymHVCVirU7owVeZ/l5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719063587; c=relaxed/simple;
	bh=XoDceAdXs9z6NeEt0iuTL63LGCFyCmlS+FZp9Eo478A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XfmLfb14kNFBkamwkDTiiT6uWm7R8+YVbaUiImXEAIniKutHG8rNWxdNDGc7BMoEhRqS20dT5O1jviDJW8yw30SEgBOfK1f8stW8nVgkePHLUBhS4KTYNdei/n8iRCAeiM5X2hExAuBybdy81XGVnaCVlNAIGje0mP7KqgZbE5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YRyrbmEZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 864CAC3277B;
	Sat, 22 Jun 2024 13:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719063587;
	bh=XoDceAdXs9z6NeEt0iuTL63LGCFyCmlS+FZp9Eo478A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YRyrbmEZwPVx6Kq3OX7UakomyMBYMbHvJTJWNzDVbmFr345rfZhNmE7m4YjIa8tDK
	 xC9peBlGek6Jcrn1zrUk0ZGyeLcLQLLn/qClDZu01loSvm75xV+jyr6m/OL9mJY/51
	 1wxxr+qwdWiTwydzXO4rV8hgvgqea39BlGxSmUDlQVcu3CIf4VWPveUPwdm0jNlHU8
	 c4yrHGfrfcbWhWY+aXlLx+qILyqelFr4X1aSa0IygbEE8FPjk1+PdpDp/B8sC6+xHw
	 yd4D4xccgu3mC+4iXTc2Ak/X8Kh/rI3ANFjiq3RmiCS+Bw2ZQK+tmRa3solRgU435U
	 7SfU2RPtQnP2A==
Date: Sat, 22 Jun 2024 15:39:40 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Damien Le Moal <dlemoal@kernel.org>,
	Jon Lin <jon.lin@rock-chips.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Simon Xue <xxm@rock-chips.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v5 00/13] PCI: dw-rockchip: Add endpoint mode support
Message-ID: <ZnbUHI5GEMCmaK2V@ryzen.lan>
References: <20240607-rockchip-pcie-ep-v1-v5-0-0a042d6b0049@kernel.org>
 <Zm_tGknJe5Ttj9mC@ryzen.lan>
 <20240621193937.GB3008482@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240621193937.GB3008482@rocinante>

On Sat, Jun 22, 2024 at 04:39:37AM +0900, Krzysztof Wilczyński wrote:
> Hello,
>
> [...]
> > If there is anything more I can do to get this picked up, please tell me.
>
> Looks good! As such...
>
> Applied to controller/rockchip, thank you!
>
> [01/04] PCI: dw-rockchip: Fix weird indentation
>         https://git.kernel.org/pci/pci/c/e7e8872191af
>
> [02/04] PCI: dw-rockchip: Add rockchip_pcie_get_ltssm() helper
>         https://git.kernel.org/pci/pci/c/cbb2d4ae3fdc
>
> [03/04] PCI: dw-rockchip: Add endpoint mode support
>         https://git.kernel.org/pci/pci/c/67fe449bcd85
>
> [04/04] PCI: dw-rockchip: Refactor the driver to prepare for EP mode
>         https://git.kernel.org/pci/pci/c/ecdc98a3a912

Krzysztof,

unfortunately, the controller/rockchip branch currently doesn't build:

drivers/pci/controller/dwc/pcie-dw-rockchip.c: In function ‘rockchip_pcie_ep_sys_irq_thread’:
drivers/pci/controller/dwc/pcie-dw-rockchip.c:407:17: error: implicit declaration of function ‘dw_pcie_ep_linkdown’;
	did you mean ‘dw_pcie_ep_linkup’? [-Wimplicit-function-declaration]
  407 |                 dw_pcie_ep_linkdown(&pci->ep);
      |                 ^~~~~~~~~~~~~~~~~~~
      |                 dw_pcie_ep_linkup


Could you possibly include the commit:
3d2e425263e2 ("PCI: dwc: ep: Add a generic dw_pcie_ep_linkdown() API to handle Link Down event")
from the controller/dwc branch in the controller/rockchip as well,
or rebase the controller/rockchip branch on top of the controller/dwc branch,
or merge the controller/dwc branch to the controller/rockchip branch?



Additionally, since you picked up Mani's series which removes
dw_pcie_ep_init_notify() on the controller/dwc branch:
9eba2f70362f ("PCI: dwc: ep: Remove dw_pcie_ep_init_notify() wrapper")

You will need to pick up this patch as well:
https://lore.kernel.org/linux-pci/20240622132024.2927799-2-cassel@kernel.org/T/#u
Otherwise there will be a build error when merging the controller/dwc
and the controller/rockchip branch to for-next.
The patch that I sent out can be picked up to the controller/rockchip right
now (since the API that Mani is switching to already exists in Linus's tree).



May I ask why all the branches for the different DWC glue drivers are not
based on the controller/dwc branch?
They are obviously going to be tightly related.


Kind regards,
Niklas

