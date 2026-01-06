Return-Path: <linux-pci+bounces-44103-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE24CF86B1
	for <lists+linux-pci@lfdr.de>; Tue, 06 Jan 2026 14:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6021930A6E86
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jan 2026 12:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647EA32B9A8;
	Tue,  6 Jan 2026 12:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KN4oqz61"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A8E219A8E;
	Tue,  6 Jan 2026 12:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767704070; cv=none; b=Gkf6k4hVsD7X+PgwrQHMS4AEJcm09B2kBq1+bY6jUeSIqKWrDHl/6gku4Qq6RV1m6B7VYLs2/2laqC30nMvhRbBUTkmxTeKAOrtYe2Yp+ZngFu4JIU1vWTr45r1yZV0ECanOBZ1bfzJsFEWwvbGEXEdKa5w7ogSVqToBAKDCIIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767704070; c=relaxed/simple;
	bh=Oe82Dko28Elj2iz2dw44a9YNxq8NU/2D2uNU8P53OZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jyr3GKABrh0EpaOq0weZevxg73Tz/cEqGZj/ATI3EfFX8FDP/fujOCP4N5fRqbmFn3jK11cv98qQX5zU2CybPhsBYVh7sHgf6KbAwfH0baOeTMtMLEGjPHgzCjlqipCE7eNePpX+Zz1xWJZrpcdqXBUaZae/ij/D9jwXk5FyZoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KN4oqz61; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43702C116C6;
	Tue,  6 Jan 2026 12:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767704069;
	bh=Oe82Dko28Elj2iz2dw44a9YNxq8NU/2D2uNU8P53OZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KN4oqz610r/u6hH1tOaCgWtj2JyIk3YpqEs6IVXdlw5ZZserrRV2qnOUJAjhDeMN8
	 EA1973sY8RCkfakuEgJhX0g5rBystiIKEJkue0fUT59yOgCUnaKf/I+tvs24+F8Itg
	 xerfB9qu2s4y0MhlPlIXMd3IdIVq/t4UYxcNDF5sfbpVwloD+66FZvPR5jLkYnIJZC
	 V2KUnxAvW8q2fxiYkva91OfDw0TFX1xSN8TokROXvJCZlGUhhXv6IFgQ7mUeXWIFdw
	 LXks9wMYH/rc1LcnwIQEMD3+d8IH9kuvkIECy0I70YCL6uILhhIZsZOwJeehUCbslL
	 9PCvDC9tlkB6A==
Date: Tue, 6 Jan 2026 18:24:19 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	bhelgaas@google.com, shawnguo@kernel.org, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, festevam@gmail.com, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/11] PCI: imx6: Add a method to handle CLKREQ#
 override
Message-ID: <inzg46tc2fwsajxq4vzdyuiq7krzy6xtcg2mjaieninz7zsmgm@mtdjr4tuegpq>
References: <20251015030428.2980427-1-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251015030428.2980427-1-hongxing.zhu@nxp.com>

On Wed, Oct 15, 2025 at 11:04:17AM +0800, Richard Zhu wrote:
> Clock Request is a reference clock request signal as defined by the PCIe
> Mini CEM and M.2 specification; Also used by L1 PM Substates. But it's
> an optional signal added in PCIe CEM r4.0, sec 2. The CLKREQ# support is
> relied on the exact hardware board and device designs.
> 
> Add supports-clkreq property to i.MX PCIe M.2 port since the CLKREQ#
> signal would be driven active low on this M.2 connector by the add-in
> card to requtest reference clock. And, the host bridge driver can enable
> the ASPM L1 PM Substates support if this property present.
> 
> To support L1 PM Substates, add a callback to clear CLKREQ# override on
> the boards that support CLKREQ# in the hardware designs.
> 
> Main changes in v6:
> - Rebase to v6.18-rc1.
> - Add the dts changes into the v6 version patch-set.
> - Fix the i.MX95 refclk enable that was missed in the v5 series.
> - Make i.MX95 refclk enable parallel to the others.
> - Describe the potential CLKREQ# problem on i.MX95 19x19 EVK second
>   slot in the commit, and emphasis the CLKREQ# issue is caused by the
>   board and device hardware designs.
> 
> Main changes in v5:
> - New create imx8mm_pcie_clkreq_override() and keep the original
>   enable_ref_clk callback function.
> 
> Main changes in v4:
> - To align the function name when add the CLKREQ# override clear, rename
> imx8mm_pcie_enable_ref_clk(), clean up codes refer to Mani' suggestions.
> 
> Main changes in v3:
> - Rebase to v6.17-rc1.
> - Update the commit message refer to Bjorn's suggestions.
> 
> Main changes in v2:
> - Update the commit message, and collect the reviewed-by tag.
> 
> [PATCH v6 01/11] arm64: dts: imx95-15x15-evk: Add supports-clkreq
> [PATCH v6 02/11] arm64: dts: imx95-19x19-evk: Add supports-clkreq
> [PATCH v6 03/11] arm64: dts: imx8mm-evk: Add supports-clkreq property
> [PATCH v6 04/11] arm64: dts: imx8mp-evk: Add supports-clkreq property
> [PATCH v6 05/11] arm64: dts: imx8mq-evk: Add supports-clkreq property
> [PATCH v6 06/11] arm64: dts: imx8qm-mek: Add supports-clkreq property
> [PATCH v6 07/11] arm64: dts: imx8qxp-mek: Add supports-clkreq
> [PATCH v6 08/11] PCI: dwc: Invoke post_init in dw_pcie_resume_noirq()
> [PATCH v6 09/11] PCI: imx6: Add a new imx8mm_pcie_clkreq_override()
> [PATCH v6 10/11] PCI: imx6: Add CLKREQ# override to enable REFCLK for
> [PATCH v6 11/11] PCI: imx6: Add a callback to clear CLKREQ# override

Squashed patch 9 with 11 and applied to controller/dwc-imx6, thanks!

- Mani

> 
> arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi     |  1 +
> arch/arm64/boot/dts/freescale/imx8mp-evk.dts      |  1 +
> arch/arm64/boot/dts/freescale/imx8mq-evk.dts      |  2 ++
> arch/arm64/boot/dts/freescale/imx8qm-mek.dts      |  1 +
> arch/arm64/boot/dts/freescale/imx8qxp-mek.dts     |  1 +
> arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts |  1 +
> arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts |  1 +
> drivers/pci/controller/dwc/pci-imx6.c             | 50 +++++++++++++++++++++++++++++++++++++++++++++++++-
> drivers/pci/controller/dwc/pcie-designware-host.c |  3 +++
> 9 files changed, 60 insertions(+), 1 deletion(-)
> 

-- 
மணிவண்ணன் சதாசிவம்

