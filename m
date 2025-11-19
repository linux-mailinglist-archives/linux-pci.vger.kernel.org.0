Return-Path: <linux-pci+bounces-41599-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 843D3C6E2E3
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 12:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0643C4F274B
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 11:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED26135295D;
	Wed, 19 Nov 2025 11:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFbkS3It"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B770634F473;
	Wed, 19 Nov 2025 11:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763550533; cv=none; b=XHwMbva5SX693dvO+0EgevxzMzB5IQfBSjTsSJMOJFHRxaYCJ11Nt+izdddee3/t+jK/DgJ4ULcvWTuz52nkDyJRwrUoCv8PH6idAsc0fTZ8Nu60id0XZ3mdGhxfxmz3dnfl9/kwzWBTdKPGnC4YwmfKVdeLp9Y551I42TEAiQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763550533; c=relaxed/simple;
	bh=i9B40rXvO4To44vDLCPvVcioheN0Q6vh2sMRTqdfAAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tClt16QEbomgSwCIySxK/aSYGIy81lVJddMqDjwdA+RJtwuzcaMzCwxc4i9iCv9jVp6HjpaW0uC5MhkVKn+y8hXASD6okv5cDwpnYazpBCq5bKuK/m2qDVRWv4TGkjBALK++ZYLFOjwR9srVFeBPw0ERRlHjyxUHb4ET6zYvK/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFbkS3It; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5474FC19421;
	Wed, 19 Nov 2025 11:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763550533;
	bh=i9B40rXvO4To44vDLCPvVcioheN0Q6vh2sMRTqdfAAs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gFbkS3ItMYkCvXQBowRYIX3QCL4BzIbk1Z/T4w+vthqVM7dO2duydfViADLoc+28z
	 jAVLswki+uqnYk3baXc1/xCPjJfR5AAVkweeYyd74OzQFAuRatReJpfNOMwr6OrSsn
	 t/ukjM48syDrh5wEAKKvmTrwPM3rKHGZu1DKQYu8DoEMLmPge4Ramv+COrtVKAQOnQ
	 60K0dMSN27vkVmSXH4FkMkxJrjSJtmT8xMAoBi8xerAfNemTyR9dy2nc17hKwr6vOF
	 p+m7U5E5v86hrPOipyimgLTfy261+7s1J3d77Xp1583aHJiGVx6/zZ2JYwCMv2/V0O
	 wf1kQrOefETjg==
Date: Wed, 19 Nov 2025 12:08:41 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
	Kever Yang <kever.yang@rock-chips.com>,
	Simon Xue <xxm@rock-chips.com>, Damien Le Moal <dlemoal@kernel.org>,
	Dragan Simic <dsimic@manjaro.org>, FUKAUMI Naoki <naoki@radxa.com>,
	Diederik de Haas <diederik@cknow-tech.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Conor Dooley <conor@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Hans Zhang <hans.zhang@cixtech.com>, linux-tegra@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, kernel@pengutronix.de,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 1/4] PCI: dwc: Advertise L1 PM Substates only if
 driver requests it
Message-ID: <aR2lOZDBEdGVd9On@ryzen>
References: <20251118214312.2598220-1-helgaas@kernel.org>
 <20251118214312.2598220-2-helgaas@kernel.org>
 <aRz0ak6onKzZs2lY@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

I think the problem is that we cannot force pull down CLKREQ# in a generic
DWC function. That would have to be done in glue driver specific callbacks.

Bjorn, perhaps we should simply drop the dw_pcie_hide_unsupported_l1ss()
call from dw_pcie_ep_init_registers(), and consider hiding L1ss for EPs to
be out of scope for this series.

That way, we could still queue this series up for 6.19.

Thoughts from everyone?



Kind regards,
Niklas

