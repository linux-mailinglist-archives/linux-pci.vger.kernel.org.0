Return-Path: <linux-pci+bounces-5528-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2351D894EE2
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 11:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F919B20F11
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 09:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A0F58235;
	Tue,  2 Apr 2024 09:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MjfO+tX0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8B79454;
	Tue,  2 Apr 2024 09:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712050867; cv=none; b=LJPcpNpcXfF58Sg3iCm/z757w+we48101aIRCxnqhA+rnck4YBktHFZmB65tF4g33C9qtwyqJV05dsepSP7q83i4FtDDiGwxs4eAYWZaI6qS0IQiUdZ2fYJ2ba6NoFh0Mzp2QUQAP0mP6nLt6dMA4Scg1WPbVPr/QurF9BXY9Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712050867; c=relaxed/simple;
	bh=1+JbQzvwocmkPZJ25oUBQdFuhjuvVbr9C5IUSGthFBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zf/U+lRY2bd7mvrb8n6RygBagRjixogQDbgMSfQHzDi3SKShtuSHrCpT68V0TDOz2uTN0jEtj172y1F4/BUUetsbpFJ0P4v6Dj037eFiaAtk/n7raWxZHLNBaIGbeFHD80gQXzbEmu+K73cYB7kr8rZWP/uZYP8JV3eEPJ2+lUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MjfO+tX0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1F73C433C7;
	Tue,  2 Apr 2024 09:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712050866;
	bh=1+JbQzvwocmkPZJ25oUBQdFuhjuvVbr9C5IUSGthFBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MjfO+tX0nuoKKP8XrPY8G8F08OlHHBr687YgRsWjw+KGshvwv+s7vv1nuxoh0Emt+
	 1sB7jtbaP6R8XX6kjWyXpHozaPQ68IhvOxtsGqtq7lpx+cv+BG7rDUgp5FRsyMNJlf
	 KuvkwCTDtGI/H7tf0bjtmDnNXDCgPWRjDKdgGdojXK1+S3bZ1h22u4BkwB9lBoxShJ
	 KlBPIvuF3cKN4UrBldFxW0tWsOHzsL5RVKJhyxl17GHEkBAtZpi3fnwJff5YnKxhP+
	 /6579sVQ9Lfj4Ss7v+K28yicNQ9gT0rq3tw5LIUD6eiiWKt3dcW/nprJIVrORHSUbe
	 cWIZm61BAmyyw==
Date: Tue, 2 Apr 2024 11:41:00 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	mhi@lists.linux.dev, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 00/10] PCI: endpoint: Make host reboot handling more
 robust
Message-ID: <ZgvSrLpvChG4jqQl@ryzen>
References: <20240401-pci-epf-rework-v2-0-970dbe90b99d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401-pci-epf-rework-v2-0-970dbe90b99d@linaro.org>

On Mon, Apr 01, 2024 at 09:20:26PM +0530, Manivannan Sadhasivam wrote:
> Hello,
> 
> This is the follow up series of [1], to improve the handling of host reboot in
> the endpoint subsystem. This involves refining the PERST# and Link Down event
> handling in both the controller and function drivers.
> 
> Testing
> =======
> 
> This series is tested on Qcom SM8450 based development board with both MHI_EPF
> and EPF_TEST function drivers.
> 
> Dependency
> ==========
> 
> This series depends on [1] and [2].
> 
> - Mani

Hello Mani,

> [1] https://lore.kernel.org/linux-pci/20240314-pci-dbi-rework-v10-0-14a45c5a938e@linaro.org/
> [2] https://lore.kernel.org/linux-pci/20240320113157.322695-1-cassel@kernel.org/

AFAICT both these series [1] (DBI rework v12, not v10) and [2] are fully
reviewed and seem to be ready to go.

Considering that we have patches depending on [1] and [2],
namely the series in $subject, but also:
https://lore.kernel.org/linux-pci/20240330041928.1555578-1-dlemoal@kernel.org/T/#t

I think it would be a good idea if you could apply [1] and [2] to the
pci/endpoint branch.

(It is not easy for people to know that they will need to rebase their work on
these (fully reviewed) series, when they have not been applied.)


Kind regards,
Niklas


> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
> Changes in v2:
> - Dropped the {start/stop}_link rework patches
> - Incorporated comments from Niklas
> - Collected review tags
> - Rebased on top of v6.9-rc1 and https://lore.kernel.org/linux-pci/20240320113157.322695-1-cassel@kernel.org/
> - Link to v1: https://lore.kernel.org/r/20240314-pci-epf-rework-v1-0-6134e6c1d491@linaro.org
> 
> ---
> Manivannan Sadhasivam (10):
>       PCI: qcom-ep: Disable resources unconditionally during PERST# assert
>       PCI: endpoint: Decouple EPC and PCIe bus specific events
>       PCI: endpoint: Rename core_init() callback in 'struct pci_epc_event_ops' to init()
>       PCI: epf-test: Refactor pci_epf_test_unbind() function
>       PCI: epf-{mhi/test}: Move DMA initialization to EPC init callback
>       PCI: endpoint: Introduce EPC 'deinit' event and notify the EPF drivers
>       PCI: dwc: ep: Add a generic dw_pcie_ep_linkdown() API to handle Link Down event
>       PCI: qcom-ep: Use the generic dw_pcie_ep_linkdown() API to handle Link Down event
>       PCI: epf-test: Handle Link Down event
>       PCI: qcom: Implement shutdown() callback to properly reset the endpoint devices
> 
>  drivers/pci/controller/dwc/pcie-designware-ep.c |  99 ++++++++++++++---------
>  drivers/pci/controller/dwc/pcie-designware.h    |   5 ++
>  drivers/pci/controller/dwc/pcie-qcom-ep.c       |   9 +--
>  drivers/pci/controller/dwc/pcie-qcom.c          |   8 ++
>  drivers/pci/controller/dwc/pcie-tegra194.c      |   1 +
>  drivers/pci/endpoint/functions/pci-epf-mhi.c    |  47 ++++++++---
>  drivers/pci/endpoint/functions/pci-epf-test.c   | 103 +++++++++++++++++-------
>  drivers/pci/endpoint/pci-epc-core.c             |  53 ++++++++----
>  include/linux/pci-epc.h                         |   1 +
>  include/linux/pci-epf.h                         |  27 +++++--
>  10 files changed, 248 insertions(+), 105 deletions(-)
> ---
> base-commit: e6377605ca734126533a0f8e4de2b4bac881f076
> change-id: 20240314-pci-epf-rework-a6e65b103a79
> 
> Best regards,
> -- 
> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 

