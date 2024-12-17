Return-Path: <linux-pci+bounces-18580-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D899F45E5
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 09:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E650161A70
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 08:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73731D358F;
	Tue, 17 Dec 2024 08:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYxCNpij"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3F6155393;
	Tue, 17 Dec 2024 08:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734423572; cv=none; b=JiRTRW3aw2CAilC/CHT0XgSWapJ+ef+TMBG79ywz4jk5v1yeQHttWHMITqQ70UXOVQBOmRmtc54du1Kj6Qh8w7sqgA4l/ZKA+Gc0cweUkvtI8VWRE9fqnZ4SmjbmPZV2K7OPx69VYUUTitp5fZgB5lUxSfydwWMONy6oYqm05bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734423572; c=relaxed/simple;
	bh=aYa3RIWaGsSZmGLSGpEKECcp/S+cC/X2OhaJlWubKdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NqTcPG/vJJfV3FCgSln4ErS7L8XvyOmNlbxC5ytvyoNg/EPokC0iF1Vsgepag7V+2KLl5cZvwZ6JroOqeqkvDBR+AiEAvApDSM0RgpliAdh1/msKWyLd5lub2qDa47/TuZz1zMxjp8Xx6k9TroYcmo+FDGajrfOHCXk2sssyTfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYxCNpij; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D22BC4CED6;
	Tue, 17 Dec 2024 08:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734423572;
	bh=aYa3RIWaGsSZmGLSGpEKECcp/S+cC/X2OhaJlWubKdY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QYxCNpijNpOsz0L1m7C0o4M5LtA5HE4cTxtR8XlPORgm0xHFkDPzlYatP44Tz0q2o
	 TcbKj5g5mY/xUebBAvYr9lz51tOH+wH7rkIGPx4OtcIB/jcPzjiWT9uKUwGFTgvxLQ
	 +ISngo+lg/zUCFiJ54DPA0WfUlXdQp0HyZ7vg2BEeEZLzGAZIWjHCWKBNnrSCHQ4Bx
	 Pzgq319u//KoxYd+NIMOOnoYi/G7CWty2nldiyOoNJ2bS5643oi6i+sb5DWOIsqVEw
	 1+WgU6UR3qyTKhBRB+geKvpXp0XfKo4oZ1A/XH1sm2NJPM4mEb1ALzeYsJc9VlU+7T
	 G9Mt95lLNkdEQ==
Date: Tue, 17 Dec 2024 09:19:28 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?B?V2lsY3p577+977+977+9c2tp?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] misc: pci_endpoint_test: Set reserved BARs for each
 SoCs
Message-ID: <Z2E0EDC3tV76303d@ryzen>
References: <20241216073941.2572407-1-hayashi.kunihiko@socionext.com>
 <20241216073941.2572407-2-hayashi.kunihiko@socionext.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216073941.2572407-2-hayashi.kunihiko@socionext.com>

Hello Hayashisan,

On Mon, Dec 16, 2024 at 04:39:41PM +0900, Kunihiko Hayashi wrote:
> There are bar numbers that cannot be used on the endpoint.
> So instead of SoC-specific conditions, add "reserved_bar" bar number
> bitmap to the SoC data.

I think that it was mistake to put is_am654_pci_dev() checks in
pci_endpoint_test.c in the first place. However, let's not make the
situation worse by introducing a reserved_bar bitmap on the host side as
well.

IMO, we should not have any logic for this the host side at all.


Just like for am654, rk3588 has a BAR (BAR4) that should not be written by
pci_endpoint_test.c (as it exposes the ATU registers in BAR4, so if the
host writes this BAR, all address translation will be broken).

An EPC driver can mark a BAR as reserved and that is exactly was rk3588
does for BAR4:
https://github.com/torvalds/linux/blob/v6.13-rc3/drivers/pci/controller/dwc/pcie-dw-rockchip.c#L300

Marking a BAR as reserved means that an EPF driver should not touch that
BAR at all.

However, this by itself is not enough if the BAR is enabled by default,
in that case we also need to disable the BAR for the host side to not
be able to write to it:
https://github.com/torvalds/linux/blob/v6.13-rc3/drivers/pci/controller/dwc/pcie-dw-rockchip.c#L248-L249


If we look at am654, we can see that it does set BAR0 and BAR1 as reserved:
https://github.com/torvalds/linux/blob/v6.13-rc3/drivers/pci/controller/dwc/pci-keystone.c#L967-L968

The problem is that am654 does not also disable these BARs by default.


If you look at most DWC based EPC drivers:
drivers/pci/controller/dwc/pci-dra7xx.c:                dw_pcie_ep_reset_bar(pci, bar);
drivers/pci/controller/dwc/pci-imx6.c:          dw_pcie_ep_reset_bar(pci, bar);
drivers/pci/controller/dwc/pci-layerscape-ep.c:         dw_pcie_ep_reset_bar(pci, bar);
drivers/pci/controller/dwc/pcie-artpec6.c:              dw_pcie_ep_reset_bar(pci, bar);
drivers/pci/controller/dwc/pcie-designware-plat.c:              dw_pcie_ep_reset_bar(pci, bar);
drivers/pci/controller/dwc/pcie-dw-rockchip.c:          dw_pcie_ep_reset_bar(pci, bar);
drivers/pci/controller/dwc/pcie-qcom-ep.c:              dw_pcie_ep_reset_bar(pci, bar);
drivers/pci/controller/dwc/pcie-rcar-gen4.c:            dw_pcie_ep_reset_bar(pci, bar);
drivers/pci/controller/dwc/pcie-uniphier-ep.c:          dw_pcie_ep_reset_bar(pci, bar);

They call dw_pcie_ep_reset_bar() in EP init for all BARs.
(An EPF driver will be able to re-enable all BARs that are not marked as
reserved.)

am654 seems to be the exception here.


If you simply add code that disables all BARs by default in am654, you
should be able to remove these ugly is_am654_pci_dev() checks in the host
driver, and the host driver should not be able to write to these reserved
BARs, as they will never get enabled by pci-epf-test.c.


Kind regards,
Niklas

