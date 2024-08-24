Return-Path: <linux-pci+bounces-12161-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F325D95DEF3
	for <lists+linux-pci@lfdr.de>; Sat, 24 Aug 2024 18:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EC4B1F21E31
	for <lists+linux-pci@lfdr.de>; Sat, 24 Aug 2024 16:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F15B39FCF;
	Sat, 24 Aug 2024 16:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQkTiIup"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A7729422;
	Sat, 24 Aug 2024 16:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724516445; cv=none; b=t58FvluxJ8IV3uQBO2uQGF5t6wAC8ueTqFWOXAp2E7IudBrYHuT/9AndSdyQAQQSl8qSe7SAYPp4eDWcH3bbD66zlCVMNEa9sgQoQbVt+Kouf8CCZYt4+6aRny+/G0rBDhCJ81siH0BYjM+O+2U/Uu50cXpUiOvrjZ9O53Rh1ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724516445; c=relaxed/simple;
	bh=4rNI7CjGB+bnr4YbBzsADFxzkV0n2pJVKnmY1DUCoX4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=X/b07ZxlI3zt9jlcXuAxcJzX6pLkzglXpN5u8G9ybjsbbjPqNVb8xlNJ5nJv8SjgfhUkbHPQ+8gxmx75K9lJGBzVY+Bvbwr99kvMNr0JAHCTT/fAP+fY5uJCW4X6HYlG6Ge6OJx5u7Q1O0wvfKcVRDjb3SVs4LzhF619DqW1ec0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQkTiIup; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 430E5C32781;
	Sat, 24 Aug 2024 16:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724516444;
	bh=4rNI7CjGB+bnr4YbBzsADFxzkV0n2pJVKnmY1DUCoX4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=GQkTiIupJPchZZootglVD2UK/QSNanVaEIqCHfjcuHYBIch8WDBZJKvxq6zjkh7PO
	 vx9ygHGVOMWl/k8Anvf9rCZlvke0zbJDTtWZtOEKkv4vwAWnciC9Mvw0tbdMSokgbT
	 d1OGeDfy54m/3bfVYvu+SppuytFD21Bzo/Kd0AP/3iPLZy89PMjEbxXbmJstfSWMfS
	 GMiRFqalQUuFha1MqzxEYyTZzOHeTAydNfgsao/y35O/JmDObOE4FRB8YvLPHWSIsy
	 TjgiJ5JBWloaFqpknbYunxW+pUv+S8maIfWKEYsZlPM1olEHaxTgDLozx4ObaGqasz
	 +XanfGedfSL6g==
Date: Sat, 24 Aug 2024 11:20:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Esther Shimanovich <eshimanovich@chromium.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rajat Jain <rajatja@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	iommu@lists.linux.dev, Lukas Wunner <lukas@wunner.de>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] PCI: Detect and trust built-in Thunderbolt chips
Message-ID: <20240824162042.GA411509@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240824042635.GM1532424@black.fi.intel.com>

On Sat, Aug 24, 2024 at 07:26:35AM +0300, Mika Westerberg wrote:
> On Fri, Aug 23, 2024 at 04:12:54PM -0500, Bjorn Helgaas wrote:
> > On Fri, Aug 23, 2024 at 04:53:16PM +0000, Esther Shimanovich wrote:
> > > Some computers with CPUs that lack Thunderbolt features use discrete
> > > Thunderbolt chips to add Thunderbolt functionality. These Thunderbolt
> > > chips are located within the chassis; between the root port labeled
> > > ExternalFacingPort and the USB-C port.
> > 
> > Is this a firmware defect?  I asked this before, and I interpret your
> > answer of "ExternalFacingPort is not 100% accurate all of the time" as
> > "yes, this is a firmware defect."  That should be part of the commit
> > log and code comments.
> > 
> > We (of course) have to work around firmware defects, but workarounds
> > need to be labeled as such instead of masquerading as generic code.
> > 
> > > These Thunderbolt PCIe devices should be labeled as fixed and trusted,
> > > as they are built into the computer. Otherwise, security policies that
> > > rely on those flags may have unintended results, such as preventing
> > > USB-C ports from enumerating.
> > > 
> > > Detect the above scenario through the process of elimination.
> > > 
> > > 1) Integrated Thunderbolt host controllers already have Thunderbolt
> > >    implemented, so anything outside their external facing root port is
> > >    removable and untrusted.
> > > 
> > >    Detect them using the following properties:
> > > 
> > >      - Most integrated host controllers have the usb4-host-interface
> > >        ACPI property, as described here:
> > > Link: https://learn.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#mapping-native-protocols-pcie-displayport-tunneled-through-usb4-to-usb4-host-routers
> > > 
> > >      - Integrated Thunderbolt PCIe root ports before Alder Lake do not
> > >        have the usb4-host-interface ACPI property. Identify those with
> > >        their PCI IDs instead.
> > > 
> > > 2) If a root port does not have integrated Thunderbolt capabilities, but
> > >    has the ExternalFacingPort ACPI property, that means the manufacturer
> > >    has opted to use a discrete Thunderbolt host controller that is
> > >    built into the computer.
> > 
> > Unconvincing.  If a Root Port has an external connector, is it
> > impossible to plug in a Thunderbolt device to that connector?  I
> > assume the wires from a Root Port could be traces on a PCB to a
> > soldered-down Thunderbolt controller, OR could be wires to a connector
> > where a Thunderbolt controller could be plugged in.  How could we tell
> > the difference?
> 
> You are talking about soldered down controller vs. add-in card (e.g PCIe
> slot)? We don't really distinguish those.

That's kind of my point.  We're depending on the platform using
ExternalFacingPort to tell us whether there's an external connector,
and in this case it sounds like the platform is lying to us.

What about PCI_EXP_FLAGS_SLOT?  If a discrete Thunderbolt controller
is built into the platform, maybe there would be no reason for the
Root Port to set Slot Implemented and provide the Slot Capabilities/
Control/Status registers.

Bjorn

