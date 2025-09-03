Return-Path: <linux-pci+bounces-35400-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D520B42808
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 19:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EA177A203E
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 17:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6AB274FDF;
	Wed,  3 Sep 2025 17:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sOZUP0mp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72A14C92;
	Wed,  3 Sep 2025 17:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756920916; cv=none; b=WB4BA2C17OS7nbyuXbh+SdrtAuU1cbSJNVGmYReW7VfZrmtru7E+xShbI4VmjrH7kk3m6vWmcN9myiopPlw72BXLlKePHHS6YwX4i6PupT58QXZVCgbqYtLazqHH20rxWU/cIPK+zRP90kMP0WMWe22BF7Bxjfkb/QRzfpRCmLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756920916; c=relaxed/simple;
	bh=q6ydgpRA1n1VIVTSnFUEGYa1rwgxWt3LP1v3p67itsg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ZHCndFxyjWgM5Wkh/YiJeb4S4u098Qu1DYquuQ4iBYjW4d8UKSUeWMhiYLu10G+GjPtFggehFazZ7oB6GFUDYenrkwZe8UYaYSp76VghoWcgGVUKf2cVhJ9/oOJbyYW0H0klhvJgDgTZREKcDeGW14mDGglggglLZwDoOwIhZiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sOZUP0mp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19105C4CEE7;
	Wed,  3 Sep 2025 17:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756920916;
	bh=q6ydgpRA1n1VIVTSnFUEGYa1rwgxWt3LP1v3p67itsg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=sOZUP0mp3NJ6r81IFD9cb54V0EIXSHPX4quWZcx7vduX1mse2py9qfzIn+h5zuWlv
	 IGIC8P0JLeQCX7+F9zxFxViT/V0bbbGHfszPFQCw3zic8XAUhHytPYFc0Fxn/E0xtL
	 qep8q3Ow1ncZvuj/xkcI5usGLSfQF8fAyLDdHx6wdbfKmeXfcBPL2e3n71Gipez7HM
	 LvU6ILGBUSCQd53RY2UApho63BbVysdM2MY263lNWtLOgxkLLk/DcTYCNJx2DeT9Bh
	 X9nDUEjFog3CwA+rj3KD4PuZBQM9JxKXdruBrmZ6kg59MR2SetrlWmH39myq1Zqtjh
	 A1fPV98oJ59HA==
Date: Wed, 3 Sep 2025 12:35:14 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
	heiko@sntech.de, mani@kernel.org, yue.wang@amlogic.com,
	pali@kernel.org, neil.armstrong@linaro.org, robh@kernel.org,
	jingoohan1@gmail.com, khilman@baylibre.com, jbrunet@baylibre.com,
	martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v5 1/2] PCI: Configure root port MPS during host probing
Message-ID: <20250903173514.GA1207260@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76cdf841-2c72-4faa-b2b9-7b2098337de0@163.com>

On Thu, Sep 04, 2025 at 01:11:22AM +0800, Hans Zhang wrote:
> On 2025/9/3 01:48, Bjorn Helgaas wrote:
> > On Fri, Jun 20, 2025 at 11:55:06PM +0800, Hans Zhang wrote:
> > > Current PCIe initialization logic may leave root ports operating with
> > > non-optimal Maximum Payload Size (MPS) settings. While downstream device
> > > configuration is handled during bus enumeration, root port MPS values
> > > inherited from firmware or hardware defaults ...
> > 
> > Apparently Root Port MPS configuration is different from that for
> > downstream devices?

> Yes, at the very beginning, the situation I tested was like the previous
> reply:
> https://lore.kernel.org/linux-pci/bb40385c-6839-484c-90b2-d6c7ecb95ba9@163.com/

I meant that this commit log suggests the *code path* is different for
Root Ports than other devices.

> > > might not utilize the full
> > > capabilities supported by the controller hardware. This can result in
> > > suboptimal data transfer efficiency across the PCIe hierarchy.
> > > 
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

> > Update the MRRS "to maintain compatibility" part.  I'm dubious about
> > there being a spec compatibility issue with respect to MRRS.  Cite the
> > relevant section if there is an issue.
> 
> The description is inaccurate. I will correct it.
> 
> I plan to modify the commit message as follows:
> If there are any incorrect descriptions, please correct them. Thank you very
> much.
> 
> Current PCIe initialization logic may leave Root Ports operating with
> non-optimal Maximum Payload Size (MPS) settings. While downstream device
> configuration is handled during bus enumeration, Root Port MPS values
> inherited from firmware or hardware defaults might not utilize the full
> capabilities supported by the controller hardware. This can result in
> suboptimal data transfer efficiency across the PCIe hierarchy.
> 
> With this patch, during the host controller probing phase and when PCIe
> bus tuning is enabled, the implementation configures Root Port MPS
> settings to their hardware-supported maximum values. Specifically, when
> configuring the MPS for a PCIe device, if the device is a Root Port and
> the bus tuning is not disabled (PCIE_BUS_TUNE_OFF), the MPS is set to
> 128 << dev->pcie_mpss to match the Root Port's maximum supported payload
> size. The Max Read Request Size (MRRS) is subsequently adjusted by
> existing logic in pci_configure_mps() to ensure it is not less than the
> MPS, maintaining compliance with PCIe specifications (see PCIe r7.0,
> sec 7.5.3.4).

AFAICS, sec 7.5.3.4 doesn't say anything about a relationship between
MRRS and MPS.  MPS is a constraint on the payload size of TLPs with
data (Memory Writes, Completions with Data, etc).  MRRS is a
constraint on the Length field in a Memory Read Request.  A single
Memory Read can be satisified with several Completions.  MPS is one of
the things that determines how many Completions are required.

This has more details and a lot of good discussion:
https://www.xilinx.com/support/documentation/white_papers/wp350.pdf

