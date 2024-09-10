Return-Path: <linux-pci+bounces-13017-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8E697462C
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2024 00:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AF6A1F268C4
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2024 22:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0311ABED0;
	Tue, 10 Sep 2024 22:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJE+0r3Z"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CC01ABEC9;
	Tue, 10 Sep 2024 22:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726008919; cv=none; b=a1LpghCPL22AnbdyfTomUu0oR8IrQDUb3lKnmYFk/EmXDWEckFEeIAech7A/Uhl8mb9KaQN+U6/SZUl93XGEgRlh44bkyNHbDcV8LEcfCog4Fo+rH2KP0YcTjIVbWVYmmcGPnCwDtDxhK1FeZ5Aj/XdLnRjylwSQi5SwcUZ92Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726008919; c=relaxed/simple;
	bh=t9iMz9wNSHqr+SURxy3ErtsjWRNA/d+Fq4X23itdBD8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hBW9mGsIZmOdLWNk6fCcI1YVyit7seN6m5YTP3TbBB9FEwXl1XagN+89fMLVLOQAmEcvB+othFfppm7a/Kp1LpZqpjviKJfSqOw0AqbFyRi8WaKi2VS4evd8pKdbyjew06pSTRm5+asKipV/wxpKWRX40fdKUf1srpa4wbO4HLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJE+0r3Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6142C4CEC3;
	Tue, 10 Sep 2024 22:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726008919;
	bh=t9iMz9wNSHqr+SURxy3ErtsjWRNA/d+Fq4X23itdBD8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=lJE+0r3ZcidfYfB/twP0dgWGOPCf0vxkFSCWLQR7XuZYWdA6uoHQRuJhgvfcWOsXz
	 DObvXTFAdT0oDrlnkQEb7Sftd15erhbwfF7fjdQ+ak5DCPLi0qHCmMHX+wKYPDzo8X
	 IP8a0/9ErwJVaG91Q891rFe7JLeQp9rQuvf+vlQMYdo9EcOrwDMfKnmuVOD2KnGrET
	 rJbeklcfq9A+G60FPSmQLRn4ZFd8PuDUhQSzjHvZ2i68K9mtAoeI8bp5QUCM83rEPK
	 dTOSWxTZwOuYk6TVXB0MsA6Tc8hvC1O2RlbBvNrEFlpgtBwmFW+jdBJ9PxRdRBh9Zw
	 A7X4YJ5/p7ecw==
Date: Tue, 10 Sep 2024 17:55:16 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	"Maciej W . Rozycki" <macro@orcam.me.uk>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Duc Dang <ducdang@google.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [RFC PATCH 0/3] PCI: Use Configuration RRS to wait for device
 ready
Message-ID: <20240910225516.GA608142@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827234848.4429-1-helgaas@kernel.org>

On Tue, Aug 27, 2024 at 06:48:45PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> After a device reset, pci_dev_wait() waits for a device to become
> completely ready by polling the PCI_COMMAND register.  The spec envisions
> that software would instead poll for the device to stop responding to
> config reads with Completions with Request Retry Status (RRS).
> 
> Polling PCI_COMMAND leads to hardware retries that are invisible to
> software and the backoff between software retries doesn't work correctly.
> 
> Root Ports are not required to support the Configuration RRS Software
> Visibility feature that prevents hardware retries and makes the RRS
> Completions visible to software, so this series only uses it when available
> and falls back to PCI_COMMAND polling when it's not.
> 
> This is completely untested and posted for comments.
> 
> Bjorn Helgaas (3):
>   PCI: Wait for device readiness with Configuration RRS
>   PCI: aardvark: Correct Configuration RRS checking
>   PCI: Rename CRS Completion Status to RRS
> 
>  drivers/bcma/driver_pci_host.c             | 10 ++--
>  drivers/pci/controller/dwc/pcie-tegra194.c | 18 +++---
>  drivers/pci/controller/pci-aardvark.c      | 64 +++++++++++-----------
>  drivers/pci/controller/pci-xgene.c         |  6 +-
>  drivers/pci/controller/pcie-iproc.c        | 18 +++---
>  drivers/pci/pci-bridge-emul.c              |  4 +-
>  drivers/pci/pci.c                          | 41 +++++++++-----
>  drivers/pci/pci.h                          | 11 +++-
>  drivers/pci/probe.c                        | 33 +++++------
>  include/linux/bcma/bcma_driver_pci.h       |  2 +-
>  include/linux/pci.h                        |  1 +
>  include/uapi/linux/pci_regs.h              |  6 +-
>  12 files changed, 117 insertions(+), 97 deletions(-)

I provisionally applied this on pci/crs for v6.12.  Please let me know
of any concerns.  I do have one internal test report, but more would
be better since I know this affects many devices.

Bjorn

