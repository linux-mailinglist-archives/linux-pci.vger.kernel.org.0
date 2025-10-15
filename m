Return-Path: <linux-pci+bounces-38288-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D394BE107C
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 01:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CC4374E5363
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 23:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD6F2D8796;
	Wed, 15 Oct 2025 23:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HS33/Hl0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A87F770FE;
	Wed, 15 Oct 2025 23:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760571056; cv=none; b=JOOK0vd3zBdBBmi7MSaaZVV/XkRoYjXVeyLAwbGcoPbdviXRHb8of4WkcCbR5r6WZAohXImPNtcmZ+jYLZ7dbv9CJj3okFQeGKEJpbAXTr3E11vE3FdVvVnny5goC4X/2a06adk1B+V7s7qnAtLTpSUxA74MQWEQNsXGN9nhB8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760571056; c=relaxed/simple;
	bh=CsaX5yV/NyN97x/Uv+a7QO8gQ+m7nJzsFw7FkgehTpc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=sWZCENAwNaluNUJAds9tpVuK0/W7Se1H/L/ppWXPMUBvKm6LNc0dbf9sgXXjHKXa9FTF7r3DbDyFGGenefCoQXd3G6IR1hhJVWrpgQYFTzLkAwvDr1HMZd/wepoN++yxDxiHtOGByFtLcq/1ZvernxHdxqb1iUU97dRLUZNQHis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HS33/Hl0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFE2CC4CEFE;
	Wed, 15 Oct 2025 23:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760571056;
	bh=CsaX5yV/NyN97x/Uv+a7QO8gQ+m7nJzsFw7FkgehTpc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=HS33/Hl0qqOw8/swBgeOP3dDkNTBpyNp7ObDbbRYh6tivu4eXAaBR3MzXFOmL40HI
	 YwXqvdC6LRf5pjpygmRMT23Afg7axVv5+vF75EEY23mK1TkHyCNpUuSot1eMd1GT7B
	 LTXA8EHpmtIsO2qao76wVCyQ6a044N5HEM9K8CBiHS+6sS4stLJgWw1nx9Fb0bWHeu
	 EgaeVlwpFahECt54rRgTY9EGrcn0DWfE8PTTmPPp4WRonW4xEvDlcYe4gvhRMkUQz1
	 qp0La8RrZJ/abACTTJDne396F0f9JgcKPdDHkOQcNiswTbx5yfNzqgRaF0Pwdp5pxf
	 i2QQXaCdcYXQA==
Date: Wed, 15 Oct 2025 18:30:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Niklas Cassel <cassel@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	manivannan.sadhasivam@oss.qualcomm.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	"David E. Box" <david.e.box@linux.intel.com>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Chia-Lin Kao <acelan.kao@canonical.com>,
	Dragan Simic <dsimic@manjaro.org>,
	linux-rockchip@lists.infradead.org, regressions@lists.linux.dev,
	FUKAUMI Naoki <naoki@radxa.com>
Subject: Re: [PATCH v2 1/2] PCI/ASPM: Override the ASPM and Clock PM states
 set by BIOS for devicetree platforms
Message-ID: <20251015233054.GA961172@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7df0bf91-8ab1-4e76-83fa-841a4059c634@rock-chips.com>

On Wed, Oct 15, 2025 at 09:00:41PM +0800, Shawn Lin wrote:
> ...

> For now, this is a acceptable option if default ASPM policy enable
> L1ss w/o checking if the HW could supports it... But how about
> adding supports-clkreq stuff to upstream host driver directly? That
> would help folks enable L1ss if the HW is ready and they just need
> adding property to the DT.
> ...

> The L1ss support is quite strict and need several steps to check, so we
> didn't add supports-clkreq for them unless the HW is ready to go...
> 
> For adding supports of L1ss,
> [1] the HW should support CLKREQ#, expecially for PCIe3.0 case on Rockchip
> SoCs , since both  CLKREQ# of RC and EP should connect to the
> 100MHz crystal generator's enable pin, as L1.2 need to disable refclk as
> well. If the enable pin is high active, the HW even need a invertor....
> 
> [2] define proper clkreq iomux to pinctrl of pcie node
> [3] make sure the devices work fine with L1ss.(It's hard to check the slot
> case with random devices in the wild )
> [4] add supports-clkreq to the DT and enable
> CONFIG_PCIEASPM_POWER_SUPERSAVE

I don't understand the details of the supports-clkreq issue.

If we need to add supports-clkreq to devicetree, I want to understand
why we need it there when we don't seem to need it for ACPI systems.

Generally the OS relies on what the hardware advertises, e.g., in Link
Capabilities and the L1 PM Substates Capability, and what is available
from firmware, e.g., the ACPI _DSM for Latency Tolerance Reporting.

On the ACPI side, I don't think we get any specific information about
CLKREQ#.  Can somebody explain why we do need it on the devicetree
side?

Bjorn

