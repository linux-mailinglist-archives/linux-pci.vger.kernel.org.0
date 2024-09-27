Return-Path: <linux-pci+bounces-13603-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3675998899A
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2024 19:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C6341C20CB5
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2024 17:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EB4143C41;
	Fri, 27 Sep 2024 17:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kfdeflmq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650D99443
	for <linux-pci@vger.kernel.org>; Fri, 27 Sep 2024 17:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727457445; cv=none; b=KIiEkde3QAODPCYUeBqLcvxUOR8MVT6Zt6mZXPtWCtfCXfrWLCrJICPz6LYRSX+VTwQ3ZPtODEUjgnDdqLsBKaHIgLIVKtKisEcUWGidOAM6wUU+qqZ+zAMGl3DX8eHdmRYW2gGs/GCSWBBEfF9KnlXLoNteIEX3/ompvABz5ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727457445; c=relaxed/simple;
	bh=ur/fJaZE3HsVZvzX/qsZTZT6GG/Kvx09HfbAzsfi/mc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=fnVQGg8ZgM9kNdfEPLAi/zkLC9mbKSId/DJFZ203C9BCX9IjHUge1GdGFs4kEHMgp7Ftr0aiu6EMP729NRRHTj679fuStraJLOEXx0O1Ipjjsge1m6Ka5JDXJFGkJpJZxgtpIQmRhk+YnYk1B14l/+aPXd5xcLQcEwS1xlYvthE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kfdeflmq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C073CC4CEC4;
	Fri, 27 Sep 2024 17:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727457445;
	bh=ur/fJaZE3HsVZvzX/qsZTZT6GG/Kvx09HfbAzsfi/mc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=KfdeflmqHivTgzwfe6hlgPZ89vpVjFBgPco/YDZEtfGR8QxbMsHhd7FopmfG/JI3D
	 a9xoO4kiFohPpftknlAXvBXh4pz7/jgDbQ3bMT9QX2Lwt1TA9pqZrMav6JoUsVJzUm
	 KLHRtEzEdX4mbx+3VkPlki3bs2oMvie3uHsHXS0NZVf4WUC4E8TuJSJJA69k7gOSJB
	 8mxis0L+sXHEeN2cHTenX2S6gpGsJUHNgleZQD5dqBVZ7SEr9zbgXcnWtvkRNMyrkx
	 btpZD9kNacE1PyzyFODEp2nZPx4SgjqVEpR3mwttnMBsEhUtNSvnPDgJSjrmlZfNhc
	 1lOOA6mkc8CiA==
Date: Fri, 27 Sep 2024 12:17:22 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Maverickk 78 <maverickk1778@gmail.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: pcie hotplug driver probe is not getting called
Message-ID: <20240927171722.GA84699@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALfBBTthgTJKZ+49rW7XKDp2xP6pDhSqPAgDsxczV_s00-Ov1A@mail.gmail.com>

On Fri, Sep 27, 2024 at 08:50:41PM +0530, Maverickk 78 wrote:
> Hello
> 
> Debugging a downstream port with slot capabilities indicating hotplug
> capability is advertised in pci capability(id =0x10) .
> 
> None of the hotplug driver is getting invoked.
> 
> I assume pciehp_probe should've been called because its associated
> with ".port_type = PCIE_ANY_PORT," in the pcie_port_service_driver
> structure.
> 
> I assumed SHPC shpc_probe function would be called because the pci_id
> table has PCI_CLASS_BRIDGE_PCI_NORMAL, but nothing related to hotplug
> drivers is seen in the ftrace or dmesg.
> 
> Tried "pciehp.pciehp_force=1 pciehp.pciehp_debug=1" in the command
> line but no luck
> 
> As part of port initialization if the hotplug capability is indicated
> in the capability register the hotplug drivers should have been
> invoked, but looks like its not the case.

I would expect pciehp to work in this case, but there is some
negotiation between the OS and the firmware to figure out which
owns it.

I assume you have CONFIG_PCIEPORTBUS and CONFIG_HOTPLUG_PCI_PCIE
enabled?  Can you supply the dmesg log and output of "sudo lspci -vv"?

Bjorn

