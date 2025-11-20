Return-Path: <linux-pci+bounces-41742-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBE6C72A9A
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 08:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B9660345C25
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 07:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BBF2D46A1;
	Thu, 20 Nov 2025 07:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICads1Dq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFDA27B349;
	Thu, 20 Nov 2025 07:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763625167; cv=none; b=dMqykpk7HiJZ6oU1rcNlZXDna3+tlb9iBxTyuR4lpZtNQIcYMjYzKPh7e6pGBK6r3q2BC8zsVvPxLyAGubji1VQh0bzkF2LP3IO0aoNfQydAZZ8Ho/k4sMXTDZYsgryqHQgElQEVMgjKzThUMNgYdJZSp8rkd20oZ/o+6S9PrQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763625167; c=relaxed/simple;
	bh=PCcS8iU+MQD7IjGPMGhvdSTgD9hnRAL2owebjIiNWS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s5750zsotrb3RO4cFxgL4LwW5ySZFA5IHYp/GWIyeTaqd42+uGPAQAi1mXk5AE7+4du2vFt0IStn8gV/5EB2g6A8sdttVIrtLllNMAr8cpEtBKfdUvfOn6YNGqwbG+7tB0BnZX+GPMbRAHy3ZW1mzOUwjcPpp52KGrw0c8IrpZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICads1Dq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43EE6C4CEF1;
	Thu, 20 Nov 2025 07:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763625167;
	bh=PCcS8iU+MQD7IjGPMGhvdSTgD9hnRAL2owebjIiNWS4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ICads1DqUmvuOZnOFex1dZonyIVaAiCKcFopkE5vgQTgNsmqyF9C4hlxGvSPvVhMJ
	 /ZWMz8QmJxGa5zbVBxEy//i/s6NCd+43+QiDg/7m4fAjeoI8Wct6hyvws2ZIXNrSpW
	 gxhwsUgO5UHfIEgAp7t/iCYAllfLLDgPkJE//v4IyTL5k2kXBdxrjvHqacy5bxDxGb
	 4TRb795eNwFrkgvLGAbAz/hthBW49c9W8ZjRgMGYpN+JNd+5bMr2zmdsgCWfYGhx4I
	 VZFH4I2GtjoQZf6EKCHf8FcyMoB8o/WrEnXoYL/5OpRjDHw7gIrDHnLcGzK+iGTQxl
	 psiNMSKa5dOEA==
Date: Thu, 20 Nov 2025 13:22:19 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	Shawn Lin <shawn.lin@rock-chips.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Kever Yang <kever.yang@rock-chips.com>, Simon Xue <xxm@rock-chips.com>, 
	Damien Le Moal <dlemoal@kernel.org>, Dragan Simic <dsimic@manjaro.org>, 
	FUKAUMI Naoki <naoki@radxa.com>, Diederik de Haas <diederik@cknow-tech.com>, 
	Richard Zhu <hongxing.zhu@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Conor Dooley <conor@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Hans Zhang <hans.zhang@cixtech.com>, linux-tegra@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, kernel@pengutronix.de, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 1/4] PCI: dwc: Advertise L1 PM Substates only if
 driver requests it
Message-ID: <lhunx3lpx3fgzyszf3librekhlrqtewcu664i7anj2s54j7kcr@52tt66auzpnr>
References: <20251118214312.2598220-1-helgaas@kernel.org>
 <20251118214312.2598220-2-helgaas@kernel.org>
 <aRz0ak6onKzZs2lY@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aRz0ak6onKzZs2lY@lizhi-Precision-Tower-5810>

On Tue, Nov 18, 2025 at 05:34:18PM -0500, Frank Li wrote:
> On Tue, Nov 18, 2025 at 03:42:15PM -0600, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> >
> > L1 PM Substates require the CLKREQ# signal and may also require
> > device-specific support.  If CLKREQ# is not supported or driver support is
> > lacking, enabling L1.1 or L1.2 may cause errors when accessing devices,
> > e.g.,
> >
> >   nvme nvme0: controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0x10
> >
> > If the kernel is built with CONFIG_PCIEASPM_POWER_SUPERSAVE=y or users
> > enable L1.x via sysfs, users may trip over these errors even if L1
> > Substates haven't been enabled by firmware or the driver.
> >
> > To prevent such errors, disable advertising the L1 PM Substates unless the
> > driver sets "dw_pcie.l1ss_support" to indicate that it knows CLKREQ# is
> > present and any device-specific configuration has been done.
> >
> > Set "dw_pcie.l1ss_support" in tegra194 (if DT includes the
> > "supports-clkreq' property) and qcom (for cfg_2_7_0, cfg_1_9_0, cfg_1_34_0,
> > and cfg_sc8280xp controllers) so they can continue to use L1 Substates.
> >
> > Based on Niklas's patch:
> > https://patch.msgid.link/20251017163252.598812-2-cassel@kernel.org
> >
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >  .../pci/controller/dwc/pcie-designware-ep.c   |  2 ++
> >  .../pci/controller/dwc/pcie-designware-host.c |  2 ++
> >  drivers/pci/controller/dwc/pcie-designware.c  | 24 +++++++++++++++++++
> >  drivers/pci/controller/dwc/pcie-designware.h  |  2 ++
> >  drivers/pci/controller/dwc/pcie-qcom.c        |  2 ++
> >  drivers/pci/controller/dwc/pcie-tegra194.c    |  3 +++
> >  6 files changed, 35 insertions(+)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > index 7f2112c2fb21..ad6c0fd67a65 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > @@ -966,6 +966,8 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
> >  	if (ep->ops->init)
> >  		ep->ops->init(ep);
> >
> > +	dw_pcie_hide_unsupported_l1ss(pci);
> > +
> 
> And, I don't think EP need clean L1SS CAP flags. If EP don't support L1SS,
> it should be force pull down #clkreq.
> 
> EP don't know if #clkreq connected in host boards, assume EP with same
> software, which can run at two difference host system, one host system
> connect #clkreq, the other system have not connect #clkreq.
> 
> otherwords, support-clkreq property should be only for RC side. not EP
> side. EP side l1ss support should depend on specific epf function and
> controller's capablity.
> 

'support-clkreq' DT property is only applicable to the RC as per dtschema. So
using it in the EP driver is wrong in the first place. We could add it to the EP
schema, but that should be done first before relying on it in the driver.

Also, I do think that the device capability should accurately reflect whether
L1ss is supported or not and not assume that the EP will pull the CLKREQ# low
when it is not supported. If the L1ss CAP is available on both RC and EP, host
software may enable L1ss and expect it to work.

But enabling/disabling the CAP for EP should be done later based on either the
DT property or controller specific flag.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

