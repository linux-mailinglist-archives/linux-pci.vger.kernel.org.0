Return-Path: <linux-pci+bounces-40217-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DB1C31C3C
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 16:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3D74A4FCE2B
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 15:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076F7246BB0;
	Tue,  4 Nov 2025 15:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EpYT4giR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13872522BA;
	Tue,  4 Nov 2025 15:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762268415; cv=none; b=rjIYp4CrC/WTvu+Z4xZi5FrgADbkGIJo8dI/X4A8njplkM4XKX5Lww9JsEZc4fD9HW+04R9mGUTA3LDPadpllfoKD5KORbVxzxlu4sU4ExH4VTZ1sRH8iXSU9tgLOTVQxHKXEiiy13CpDbKVVef5jf6VQfNL9fTyDhUYBs/a/jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762268415; c=relaxed/simple;
	bh=ebMwlcOllEAmVux6uigBYvOvQ1U699pEuwenpk8GAa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NcGr79xvNcTw9qByREPDi2Lh6v0gBea/7m1x+Dx/BLlWmAVzqa/r12n8DvoDX2+RfsIz+k7+RElZxoIJRBBy+iVVhL7DEVUYIq2JdvUVwm4B29YldcHMEMwSVzFYmxvY9RwZ+2E1oCd6r0d3B57CkJoXrL4HAAKEOQ6yud8As7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EpYT4giR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B73C4CEF7;
	Tue,  4 Nov 2025 15:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762268415;
	bh=ebMwlcOllEAmVux6uigBYvOvQ1U699pEuwenpk8GAa8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EpYT4giRowe6c94+e/O49vmTAnRcdfwZ9BkTVxBfzSYWtXoUvG0xiGmllObuw0CNI
	 EWg1qvF9vAw9LLzr4AzKDAQTb0tnnGHgF7sZdQxK+PreK1mJU+YuTq1V9/ZOIXyNjX
	 IEQF+GTYmE1SqYnyCgBu1p4ddfaFlecE6gfs+FWa/2yNX4x4gmMs2YJNPF7sskkzEN
	 KT7Qou+0EQoMyafMIgLxtuitNanOeADgO2OnfkM+wLpdc9HSCdMl2agtwE8Z9lk8oB
	 72RWkrV0w50Nv5xXUezTyrjbwSjP/T4DyqAlmcmOiqexhD/wxPXJHekqTkTxGuJRtz
	 bdqr3E09iK3yw==
Date: Tue, 4 Nov 2025 16:00:08 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Hans Zhang <18255117159@163.com>, lpieralisi@kernel.org,
	kwilczynski@kernel.org, bhelgaas@google.com, heiko@sntech.de,
	mani@kernel.org, yue.wang@amlogic.com, pali@kernel.org,
	neil.armstrong@linaro.org, robh@kernel.org, jingoohan1@gmail.com,
	khilman@baylibre.com, jbrunet@baylibre.com,
	martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v5 1/2] PCI: Configure root port MPS during host probing
Message-ID: <aQoU-JhWz6IYTpGi@ryzen>
References: <20250620155507.1022099-2-18255117159@163.com>
 <20250902174828.GA1165373@bhelgaas>
 <aLlmV8Qiaph1PHFY@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLlmV8Qiaph1PHFY@ryzen>

Hello Hans,

Any chance that you have time to re-spin this series?

I've seen some new DWC based drivers like NXP that also want to
configure MPS.

Most likely we know the reason... The PCI core does not change it
without this series.


Kind regards,
Niklas

On Thu, Sep 04, 2025 at 12:13:43PM +0200, Niklas Cassel wrote:
> On Tue, Sep 02, 2025 at 12:48:28PM -0500, Bjorn Helgaas wrote:
> > On Fri, Jun 20, 2025 at 11:55:06PM +0800, Hans Zhang wrote:
> > > Current PCIe initialization logic may leave root ports operating with
> > > non-optimal Maximum Payload Size (MPS) settings. While downstream device
> > > configuration is handled during bus enumeration, root port MPS values
> > > inherited from firmware or hardware defaults ...
> > 
> > Apparently Root Port MPS configuration is different from that for
> > downstream devices?
> 
> pci_host_probe() will call pci_scan_root_bus_bridge(), which will call
> pci_scan_single_device(), which will call pci_device_add(), which will
> call pci_configure_device(), which will call pci_configure_mps().
> 
> This will be done for both bridges and endpoints.
> 
> The bridge will be scanned/added first, before devices behind the bridge.
> 
> 
> While pci_configure_device()/pci_configure_mps() will be called for both
> bridges and endpoints, pci_configure_mps() will do an early return for
> devices where pci_upstream_bridge() returns NULL, i.e. for devices where
> that does not have an upstream bridge, i.e. for the root bridge itself:
> https://github.com/torvalds/linux/blob/v6.17-rc4/drivers/pci/probe.c#L2181-L2182
> 
> So MPS will not be touched for root bridges.
> 
> This patch ensures that MPS for root bridges gets initialized to MPSS
> (Max supported MPS).
> 
> Later, when pci_configure_device()/pci_configure_mps() is called for a
> device behind the bridge, if the MPSS of the device behind the bridge is
> smaller than the MPS of the bridge, the code reduces the MPS of the bridge:
> https://github.com/torvalds/linux/blob/v6.17-rc4/drivers/pci/probe.c#L2205
> 
> 
> My only question with this patch is if there is a bridge behind a bridge,
> will the bridge behind the bridge still have pci_pcie_type() ==
> PCI_EXP_TYPE_ROOT_PORT ?
> 
> If so, perhaps we should modify this patch from:
> 
> +       if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT &&
> +           pcie_bus_config != PCIE_BUS_TUNE_OFF) {
> +               pcie_write_mps(dev, 128 << dev->pcie_mpss);
> +       }
> +
>         if (!bridge || !pci_is_pcie(bridge))
>                 return;
> 
> 
> to:
> 
> +       if (!bridge && pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT &&
> +           pcie_bus_config != PCIE_BUS_TUNE_OFF) {
> +               pcie_write_mps(dev, 128 << dev->pcie_mpss);
> +       }
> +
>         if (!bridge || !pci_is_pcie(bridge))
>                 return;
> 
> 
> 
> > > During host controller probing phase, when PCIe bus tuning is enabled,
> > > the implementation now configures root port MPS settings to their
> > > hardware-supported maximum values. Specifically, when configuring the MPS
> > > for a PCIe device, if the device is a root port and the bus tuning is not
> > > disabled (PCIE_BUS_TUNE_OFF), the MPS is set to 128 << dev->pcie_mpss to
> > > match the Root Port's maximum supported payload size. The Max Read Request
> > > Size (MRRS) is subsequently adjusted through existing companion logic to
> > > maintain compatibility with PCIe specifications.
> > > 
> > > Note that this initial setting of the root port MPS to the maximum might
> > > be reduced later during the enumeration of downstream devices if any of
> > > those devices do not support the maximum MPS of the root port.
> > > 
> > > Explicit initialization at host probing stage ensures consistent PCIe
> > > topology configuration before downstream devices perform their own MPS
> > > negotiations. This proactive approach addresses platform-specific
> > > requirements where controller drivers depend on properly initialized
> > > root port settings, while maintaining backward compatibility through
> > > PCIE_BUS_TUNE_OFF conditional checks. Hardware capabilities are fully
> > > utilized without altering existing device negotiation behaviors.
> > 
> > This last paragraph seems kind of like marketing without any real
> > content.  Is there something important in there?
> > 
> > Nits:
> > s/root port/Root Port/
> > 
> > Reword "implementation now configures" to be clear about whether "now"
> > refers to before this patch or after.
> > 
> > Update the MRRS "to maintain compatibility" part.  I'm dubious about
> > there being a spec compatibility issue with respect to MRRS.  Cite the
> > relevant section if there is an issue.
> 
> I'm not sure why the commit message mentions MRRS at all.
> 
> Sure, pcie_write_mrrs() might set MRRS to MPS, but that is existing logic
> and not really related to the change in this patch IMO.
> 
> 
> Kind regards,
> Niklas

