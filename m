Return-Path: <linux-pci+bounces-35441-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E23B43879
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 12:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58071A009D0
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 10:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9212FB988;
	Thu,  4 Sep 2025 10:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HbaN6Yjz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04222F83C0;
	Thu,  4 Sep 2025 10:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756980830; cv=none; b=aS2fCvOOo5422Edg3/onw89J2+uTiqz9Fc2yOIYIX8KFqaGyE2bFMxWojexbst6n+q28thf8cp2YloY+9LHuS5J1JJKjNLCy1z1TQ/+75mQdWMKdDhlJXA3q9gqq50XuJVC0lkalafL1njncU7POcYLCw35UkY/bifzhMZQw6pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756980830; c=relaxed/simple;
	bh=TaCx2xdJ0PkyIQESevtrNgnqTCDtw2YcyYY/Mn7haVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VjdxU73xUAXL0e9OPTL56/fWqGZGURtYJSuAw71h8KAd3sUvirMFkZ4Ypu3bI4Wni1Vh4OPO6hWGbkeDKmr6khdEbitU6U5GthEzHHYVQJwS4FdayryuzRpg2jWm8cAMAJnzrc3kc8YtNLvkuJH5gE6y8UDyzgP8FLq8wP/ofO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HbaN6Yjz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3A65C4CEF0;
	Thu,  4 Sep 2025 10:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756980830;
	bh=TaCx2xdJ0PkyIQESevtrNgnqTCDtw2YcyYY/Mn7haVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HbaN6Yjznr5n3Gogxrsx99hUcU54nZ3/fhnW5jw8827xmZUpTdL0M+x2zcrkKwdSr
	 trKtFHUXICoR0Xtx3Wbnyr5gw63yTDdUsLaUsHsVCp7HunCjNBGw/MB5D+pb1lpr5G
	 wMBAHcGyWwaUHK1j8FAbAVsfuDRbUjmc16AiEWPvPSb21XPNUNlCPL+h8f9sV6Joqw
	 NDiK8o1f1BuiCRt7RsPXBmzmB6YyWWEquxW3QZAMneehJos4WyLbIVxIAgLfcgW8Zy
	 TSB/mkGN5d2iXf0RkLf7zYyD/C7Z68NpUDPcWEKUrY/jDeyFfWcM59N1y8QeTidVnP
	 JcmXOFrYFRL2w==
Date: Thu, 4 Sep 2025 12:13:43 +0200
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
Message-ID: <aLlmV8Qiaph1PHFY@ryzen>
References: <20250620155507.1022099-2-18255117159@163.com>
 <20250902174828.GA1165373@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902174828.GA1165373@bhelgaas>

On Tue, Sep 02, 2025 at 12:48:28PM -0500, Bjorn Helgaas wrote:
> On Fri, Jun 20, 2025 at 11:55:06PM +0800, Hans Zhang wrote:
> > Current PCIe initialization logic may leave root ports operating with
> > non-optimal Maximum Payload Size (MPS) settings. While downstream device
> > configuration is handled during bus enumeration, root port MPS values
> > inherited from firmware or hardware defaults ...
> 
> Apparently Root Port MPS configuration is different from that for
> downstream devices?

pci_host_probe() will call pci_scan_root_bus_bridge(), which will call
pci_scan_single_device(), which will call pci_device_add(), which will
call pci_configure_device(), which will call pci_configure_mps().

This will be done for both bridges and endpoints.

The bridge will be scanned/added first, before devices behind the bridge.


While pci_configure_device()/pci_configure_mps() will be called for both
bridges and endpoints, pci_configure_mps() will do an early return for
devices where pci_upstream_bridge() returns NULL, i.e. for devices where
that does not have an upstream bridge, i.e. for the root bridge itself:
https://github.com/torvalds/linux/blob/v6.17-rc4/drivers/pci/probe.c#L2181-L2182

So MPS will not be touched for root bridges.

This patch ensures that MPS for root bridges gets initialized to MPSS
(Max supported MPS).

Later, when pci_configure_device()/pci_configure_mps() is called for a
device behind the bridge, if the MPSS of the device behind the bridge is
smaller than the MPS of the bridge, the code reduces the MPS of the bridge:
https://github.com/torvalds/linux/blob/v6.17-rc4/drivers/pci/probe.c#L2205


My only question with this patch is if there is a bridge behind a bridge,
will the bridge behind the bridge still have pci_pcie_type() ==
PCI_EXP_TYPE_ROOT_PORT ?

If so, perhaps we should modify this patch from:

+       if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT &&
+           pcie_bus_config != PCIE_BUS_TUNE_OFF) {
+               pcie_write_mps(dev, 128 << dev->pcie_mpss);
+       }
+
        if (!bridge || !pci_is_pcie(bridge))
                return;


to:

+       if (!bridge && pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT &&
+           pcie_bus_config != PCIE_BUS_TUNE_OFF) {
+               pcie_write_mps(dev, 128 << dev->pcie_mpss);
+       }
+
        if (!bridge || !pci_is_pcie(bridge))
                return;



> > During host controller probing phase, when PCIe bus tuning is enabled,
> > the implementation now configures root port MPS settings to their
> > hardware-supported maximum values. Specifically, when configuring the MPS
> > for a PCIe device, if the device is a root port and the bus tuning is not
> > disabled (PCIE_BUS_TUNE_OFF), the MPS is set to 128 << dev->pcie_mpss to
> > match the Root Port's maximum supported payload size. The Max Read Request
> > Size (MRRS) is subsequently adjusted through existing companion logic to
> > maintain compatibility with PCIe specifications.
> > 
> > Note that this initial setting of the root port MPS to the maximum might
> > be reduced later during the enumeration of downstream devices if any of
> > those devices do not support the maximum MPS of the root port.
> > 
> > Explicit initialization at host probing stage ensures consistent PCIe
> > topology configuration before downstream devices perform their own MPS
> > negotiations. This proactive approach addresses platform-specific
> > requirements where controller drivers depend on properly initialized
> > root port settings, while maintaining backward compatibility through
> > PCIE_BUS_TUNE_OFF conditional checks. Hardware capabilities are fully
> > utilized without altering existing device negotiation behaviors.
> 
> This last paragraph seems kind of like marketing without any real
> content.  Is there something important in there?
> 
> Nits:
> s/root port/Root Port/
> 
> Reword "implementation now configures" to be clear about whether "now"
> refers to before this patch or after.
> 
> Update the MRRS "to maintain compatibility" part.  I'm dubious about
> there being a spec compatibility issue with respect to MRRS.  Cite the
> relevant section if there is an issue.

I'm not sure why the commit message mentions MRRS at all.

Sure, pcie_write_mrrs() might set MRRS to MPS, but that is existing logic
and not really related to the change in this patch IMO.


Kind regards,
Niklas

