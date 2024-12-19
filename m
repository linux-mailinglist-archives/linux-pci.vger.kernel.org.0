Return-Path: <linux-pci+bounces-18817-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4829F8629
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 21:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D212416CD01
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 20:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFC41D88D1;
	Thu, 19 Dec 2024 20:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmJnD9Qe"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E371D86C3;
	Thu, 19 Dec 2024 20:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734641002; cv=none; b=R/F9iQaQShFsrTNUqJrVuK/G3HYpAGCuF1RpXagLATB58cr0CHN8upJQhEj7TTc1yPJdi1XN2klJKygNhaSsh+Z6qY8i3jCEl3dHqa6Hz3d4j42G17Y5zCLU2iqSjb4eASSDCjkmv/huUfpkgLBg6HS73nAvoLZQ9HndDll9PuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734641002; c=relaxed/simple;
	bh=G6bMfexz+wArkOSIy0OifiSOvN5KLKUMvRsykmliEsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lbEcbqYh7d4WOxaRc+hsYzpfz+0jWLmSFyjNzAsBHLdSlDJih5Y5UKeo9PZDOLc24WH7ALrhK362iefk7I800q1rlf4KlEGYdYcBbxrvkqfd4Gboc0HOx0QsYq5kHoWLbLC1m2vyJHDADtDcyxWo4r9O3ZYI8X3ulAXr+eVDkCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmJnD9Qe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52CA6C4CEE2;
	Thu, 19 Dec 2024 20:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734641001;
	bh=G6bMfexz+wArkOSIy0OifiSOvN5KLKUMvRsykmliEsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dmJnD9Qex8zb76MkRSNV8w/pleJc7agAVHdZmk37esuv92MR/LJ+YtapO71KAsR0K
	 wI3cyZvGyyTX+/6RA4VqzLlu+fUanKgjXDCTfoym6JUz68cONpDKiG/kSGOXPILz3l
	 2Tf4LrHcWE5FwJkGTRDWsetCsD9NcdIc36xzqIiDYA7Amva1d4tyqeCndgAhBOl2gz
	 TQZgJmAXO52yqjkMX32XiSaIEJStw5vpBgqRuyPniwP5pJsKFxF1lILwVSYhlbhhQj
	 OBt8J9DpejQAFpBEkfRqxCr6Gsf+4lHvWpWO0Am/Ge3EQUcPF6lbjHf98AVS6Wowq7
	 bkXmD0fjJMD/w==
Date: Thu, 19 Dec 2024 21:43:15 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Marc Zyngier <maz@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anup Patel <apatel@ventanamicro.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, imx@lists.linux.dev, dlemoal@kernel.org,
	jdmason@kudzu.us, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v13 4/9] irqchip/gic-v3-its: Add
 DOMAIN_BUS_DEVICE_PCI_EP_MSI support
Message-ID: <Z2SFYwC7KC-qiZD2@ryzen>
References: <20241218-ep-msi-v13-0-646e2192dc24@nxp.com>
 <20241218-ep-msi-v13-4-646e2192dc24@nxp.com>
 <868qscq70x.wl-maz@kernel.org>
 <Z2RRimPlT41Ru281@lizhi-Precision-Tower-5810>
 <Z2R9qPmAyTcc5mtg@ryzen>
 <Z2R/S4y3fF2Dw4Ye@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2R/S4y3fF2Dw4Ye@lizhi-Precision-Tower-5810>

On Thu, Dec 19, 2024 at 03:17:15PM -0500, Frank Li wrote:
> 
> Thank you very much. I update msi part, so endpoint controller node align
> host controller node.
> 
> It should be
> msi-map = <0x0000 &its1 0x0000 0x1000>;
> 
> So if your hardware support multi physical function, your can create more
> than one pci_test func. Previous version only support one EP func.

I see. That seems like an improvement.
I will need to ask Rockchip maintainer to drop my msi-parent patch for PCIe
EP node then. (Which is currently queued up in for-6.14)

However, for the PCIe host node, rk3588 has:
iommu-map = <0x0000 &mmu600_pcie 0x0000 0x1000>;

For the PCIe endpoint node, rk3588 has:
iommus = <&mmu600_pcie 0x0000>;

https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git/commit/?h=v6.14-armsoc/dts64&id=da92d3dfc871e821a1bface3ba5afcf8cda19805

Is it fine that for the PCIe EP node, we specify iommu mapping using:
iommus = <&mmu600_pcie 0x0000>;
but the ITS/MSI map will be:
msi-map = <0x0000 &its1 0x0000 0x1000>;

isn't this a bit inconsistent?

The physical function is the "F" in the BDF.
Does this mean that:
iommus = <&mmu600_pcie 0x0000>;
the IOMMU will not be able to distinguish different PCI physical functions
from the same PCI device? So two different physical functions on the same
PCI device share the same IOMMU mappings?


Kind regards,
Niklas

