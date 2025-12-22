Return-Path: <linux-pci+bounces-43492-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6B5CD4C92
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 07:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC2C030084CE
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 06:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8B33019D8;
	Mon, 22 Dec 2025 06:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QUOZEoyJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114031FE45D;
	Mon, 22 Dec 2025 06:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766384233; cv=none; b=WhmaDRW+tRIpgWrX4JdMAszkoUdPAoWlctVAO4RruW/eEV18BDwWmj6iX5Z7ShealgHe04hk8nMdxevDy4z6HpMhJ6v2T9o2oesV2K4Xh7av76M/bo2fE/b93wWNp+yJqJXdBENKSR2bgQWxEd/fBsaEuO1jZt+2kNpNdnfZw0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766384233; c=relaxed/simple;
	bh=+PJJrLUZuuvwo/YknxXQIYCxBgkPwh5ViNEYKOPqGLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J1I4tohj1m1s9mwRSsmobjZDLk9scGEs8PzF7jFrbmBUI6uFNCapOrhxHfgZTStXZWHvH06ZP5Ea85Bbvq4P4vlhhjvMZduLUaOA5DI61ROwK8aPifCGRHn9erRTYden11l3gTj4UQtjIjT4iNxwAN7FnDhMMGmwcKP9F0MRG1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QUOZEoyJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C65A7C4CEF1;
	Mon, 22 Dec 2025 06:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766384232;
	bh=+PJJrLUZuuvwo/YknxXQIYCxBgkPwh5ViNEYKOPqGLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QUOZEoyJQstFde3gfBLzzzrHX16nHgjhjNRxUJoGVckt+cwXYFKX/8s0ahpHkJUJ0
	 wIvfxGJHOOxDkc7YqDXyD+Strd6UBqCkUddyT1eRF9MDsQGkSFjaY4wARRp1BKuM+Y
	 0EdF87kTzSxmv8tWQr9bc5VWFdr8qyflO/sqUUm8+FAmm6eH4McKZHH/C5IstKkLlL
	 jWj9I2HXicWC4Wv7JAk3x1wrwNA482sN7AZFQaYXm0R9aCkl7rzb7HHYzscZMTMSda
	 RWKysMjOX0UO+6Z4iku0esn/gWAH/turVg2PCS10ycK93qiTQ5g1bBAhwezZ6NmrJ5
	 Xt5Oz4xn7AbJw==
Date: Mon, 22 Dec 2025 11:46:57 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Heiko Stuebner <heiko@sntech.de>, Shawn Lin <shawn.lin@rock-chips.com>, 
	FUKAUMI Naoki <naoki@radxa.com>, Krishna chaitanya chundru <quic_krichai@quicinc.com>, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 0/6] PCI: dwc: Revert Link Up IRQ support
Message-ID: <cngg5kifjqmrmb5ufyrv4k6dwo5tgatqssaeoog5aqpe7m253c@krov7axlplkw>
References: <20251111105100.869997-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251111105100.869997-8-cassel@kernel.org>

On Tue, Nov 11, 2025 at 11:51:00AM +0100, Niklas Cassel wrote:
> Revert all patches related to pcie-designware Root Complex Link Up IRQ
> support.
> 
> While this fake hotplugging was a nice idea, it has shown that this feature
> does not handle PCIe switches correctly:
> pci_bus 0004:43: busn_res: can not insert [bus 43-41] under [bus 42-41] (conflicts with (null) [bus 42-41])
> pci_bus 0004:43: busn_res: [bus 43-41] end is updated to 43
> pci_bus 0004:43: busn_res: can not insert [bus 43] under [bus 42-41] (conflicts with (null) [bus 42-41])
> pci 0004:42:00.0: devices behind bridge are unusable because [bus 43] cannot be assigned for them
> pci_bus 0004:44: busn_res: can not insert [bus 44-41] under [bus 42-41] (conflicts with (null) [bus 42-41])
> pci_bus 0004:44: busn_res: [bus 44-41] end is updated to 44
> pci_bus 0004:44: busn_res: can not insert [bus 44] under [bus 42-41] (conflicts with (null) [bus 42-41])
> pci 0004:42:02.0: devices behind bridge are unusable because [bus 44] cannot be assigned for them
> pci_bus 0004:45: busn_res: can not insert [bus 45-41] under [bus 42-41] (conflicts with (null) [bus 42-41])
> pci_bus 0004:45: busn_res: [bus 45-41] end is updated to 45
> pci_bus 0004:45: busn_res: can not insert [bus 45] under [bus 42-41] (conflicts with (null) [bus 42-41])
> pci 0004:42:06.0: devices behind bridge are unusable because [bus 45] cannot be assigned for them
> pci_bus 0004:46: busn_res: can not insert [bus 46-41] under [bus 42-41] (conflicts with (null) [bus 42-41])
> pci_bus 0004:46: busn_res: [bus 46-41] end is updated to 46
> pci_bus 0004:46: busn_res: can not insert [bus 46] under [bus 42-41] (conflicts with (null) [bus 42-41])
> pci 0004:42:0e.0: devices behind bridge are unusable because [bus 46] cannot be assigned for them
> pci_bus 0004:42: busn_res: [bus 42-41] end is updated to 46
> pci_bus 0004:42: busn_res: can not insert [bus 42-46] under [bus 41] (conflicts with (null) [bus 41])
> pci 0004:41:00.0: devices behind bridge are unusable because [bus 42-46] cannot be assigned for them
> pcieport 0004:40:00.0: bridge has subordinate 41 but max busn 46
> 
> During the initial scan, PCI core doesn't see the switch and since the Root
> Port is not hot plug capable, the secondary bus number gets assigned as the
> subordinate bus number. This means, the PCI core assumes that only one bus
> will appear behind the Root Port since the Root Port is not hot plug
> capable.
> 
> This works perfectly fine for PCIe endpoints connected to the Root Port,
> since they don't extend the bus. However, if a PCIe switch is connected,
> then there is a problem when the downstream busses starts showing up and
> the PCI core doesn't extend the subordinate bus number after initial scan
> during boot.
> 
> The long term plan is to migrate this driver to the pwrctrl framework,
> once it adds proper support for powering up and enumerating PCIe switches.
> 

Could you please rebase this series on top of pci/controller/dwc branch and
repost?

- Mani

> Niklas Cassel (6):
>   Revert "PCI: dw-rockchip: Don't wait for link since we can detect Link
>     Up"
>   Revert "PCI: dw-rockchip: Enumerate endpoints based on dll_link_up
>     IRQ"
>   Revert "PCI: qcom: Don't wait for link if we can detect Link Up"
>   Revert "PCI: qcom: Enable MSI interrupts together with Link up if
>     'Global IRQ' is supported"
>   Revert "PCI: qcom: Enumerate endpoints based on Link up event in
>     'global_irq' interrupt"
>   Revert "PCI: dwc: Don't wait for link up if driver can detect Link Up
>     event"
> 
>  .../pci/controller/dwc/pcie-designware-host.c | 10 +--
>  drivers/pci/controller/dwc/pcie-designware.h  |  1 -
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 60 +-----------------
>  drivers/pci/controller/dwc/pcie-qcom.c        | 63 +------------------
>  4 files changed, 6 insertions(+), 128 deletions(-)
> 
> -- 
> 2.51.1
> 

-- 
மணிவண்ணன் சதாசிவம்

