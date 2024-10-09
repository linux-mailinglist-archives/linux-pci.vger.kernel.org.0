Return-Path: <linux-pci+bounces-14096-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EAD997103
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 18:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D33A728598C
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 16:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721D31A2567;
	Wed,  9 Oct 2024 16:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UD980E8A"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C65161313;
	Wed,  9 Oct 2024 16:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728489695; cv=none; b=d6lyyFvMYYsFZDJMIQrBAhgbnEa38gvcxq1r5mgMyoO9RiBrqy6BPrdS4SI2VSVK74ZUToWrmgLVaGWnFH7pMc/U53A/Iad925IeH0XetZsR9WIXySbkh3NC0YO1Y/Gn/Xlfu9Nga0a1/Iw61Z3dx7iFyzW9xry0hj/z3X5sC7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728489695; c=relaxed/simple;
	bh=aPf5UiYG1vsp/Il+DJSTs1K8163OCruXIBTQfDcJnk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sp/g+g2u43ldo8jG8+ICh/YrMUTACP2lSItf5jdny17KkbJz+lR+G5Prj6bz00aIWZ1m6AY/TpUWNWbwnunOepmnBc6ExO8B59iz4Xtpvin6p4mIsv72D2F5LhStqHuEWh1M/Qgd00hMdgqRJsRUhSX1elAucWNnSycO0lLYrh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UD980E8A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D56CC4CEC3;
	Wed,  9 Oct 2024 16:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728489694;
	bh=aPf5UiYG1vsp/Il+DJSTs1K8163OCruXIBTQfDcJnk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UD980E8ANwBR8CV6W0r545AsFquNd6VQJLZAhzv03kH/2722yJVUfx2XR5s9jc9Wc
	 AUV5IbyCzTe3Coa25RIdrCecLNl0dL1/4PhErHS0znpmrtwWfuAMeKgbM+GXln8oI9
	 wUmpInMKAAcNs4mTA6YGMM9+PyyOM6pz5XyU+lN2uzAffaKOG9V0OvZ3BjUvrIGGPU
	 3cs3lX6bGTBCIgzzCH/8c+ZJ22OzxMpevAA0YLfuVThtbrF1cAezHQ8WwvwisbXVg/
	 +7tZqaCl31FNmzpnYGWSPo/4SPE7bDk16U78rzvUaGoglXbgaUj8yNtEcg4w8M05r7
	 +lwC1rbHYVY2g==
Date: Wed, 9 Oct 2024 18:01:27 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: manivannan.sadhasivam@linaro.org, aisheng.dong@nxp.com,
	bhelgaas@google.com, devicetree@vger.kernel.org, festevam@gmail.com,
	imx@lists.linux.dev, jdmason@kudzu.us, kernel@pengutronix.de,
	kishon@kernel.org, kw@linux.com,
	linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	lorenzo.pieralisi@arm.com, lpieralisi@kernel.org, maz@kernel.org,
	s.hauer@pengutronix.de, shawnguo@kernel.org, tglx@linutronix.de,
	dlemoal@kernel.org
Subject: Re: [PATCH v2 0/5] Add RC-to-EP doorbell with platform MSI controller
Message-ID: <Zwao1x7m3MTT98NT@ryzen.lan>
References: <20230911220920.1817033-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230911220920.1817033-1-Frank.Li@nxp.com>

On Mon, Sep 11, 2023 at 06:09:15PM -0400, Frank Li wrote:
> ┌────────────┐   ┌───────────────────────────────────┐   ┌────────────────┐
> │            │   │                                   │   │                │
> │            │   │ PCI Endpoint                      │   │ PCI Host       │
> │            │   │                                   │   │                │
> │            │◄──┤ 1.platform_msi_domain_alloc_irqs()│   │                │
> │            │   │                                   │   │                │
> │ MSI        ├──►│ 2.write_msi_msg()                 ├──►├─BAR<n>         │
> │ Controller │   │   update doorbell register address│   │                │
> │            │   │   for BAR                         │   │                │
> │            │   │                                   │   │ 3. Write BAR<n>│
> │            │◄──┼───────────────────────────────────┼───┤                │
> │            │   │                                   │   │                │
> │            ├──►│ 4.Irq Handle                      │   │                │
> │            │   │                                   │   │                │
> │            │   │                                   │   │                │
> └────────────┘   └───────────────────────────────────┘   └────────────────┘
> 
> This patches based on old https://lore.kernel.org/imx/20221124055036.1630573-1-Frank.Li@nxp.com/
> 
> Original patch only target to vntb driver. But actually it is common
> method.
> 
> This patches add new API to pci-epf-core, so any EP driver can use it.
> 
> The key point is comments from Thomas Gleixner, who suggest use new
> PCI/IMS. But arm platform change still not be merged yet.
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git devmsi-v2-arm
> 
> So I still use existed method implement RC to EP doorbell.
> 
> If Thomas Gleixner want to continue work on devmsi-v2-arm, I can help test
> and update this patch.
> 
> Change from v1 to v2
> - Add missed patch for endpont/pci-epf-test.c
> - Move alloc and free to epc driver from epf.
> - Provide general help function for EPC driver to alloc platform msi irq.
> - Fixed manivannan's comments.
> 
> Frank Li (5):
>   PCI: endpoint: Add RC-to-EP doorbell support using platform MSI
>     controller
>   PCI: dwc: add doorbell support by use MSI controller
>   PCI: endpoint: pci-epf-test: add doorbell test
>   misc: pci_endpoint_test: Add doorbell test case
>   tools: PCI: Add 'B' option for test doorbell
> 
>  drivers/misc/pci_endpoint_test.c              |  48 +++++
>  .../pci/controller/dwc/pcie-designware-ep.c   |   2 +
>  drivers/pci/endpoint/functions/pci-epf-test.c |  59 +++++-
>  drivers/pci/endpoint/pci-epc-core.c           | 192 ++++++++++++++++++
>  drivers/pci/endpoint/pci-epf-core.c           |  44 ++++
>  include/linux/pci-epc.h                       |   6 +
>  include/linux/pci-epf.h                       |   7 +
>  include/uapi/linux/pcitest.h                  |   1 +
>  tools/pci/pcitest.c                           |  16 +-
>  9 files changed, 373 insertions(+), 2 deletions(-)
> 
> -- 
> 2.34.1
> 

Hello Frank,

Thank you for your work on this.
This series is very interesting.

As you probably know, IMS support was ripped out of the kernel a few
months ago:
b966b1102871 ("Revert "PCI/MSI: Provide IMS (Interrupt Message Store) support"")

So this series seems as relevant as ever.

Are you considering continuing work on this series any time soon?


Kind regards,
Niklas

