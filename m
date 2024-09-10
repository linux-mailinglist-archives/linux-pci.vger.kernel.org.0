Return-Path: <linux-pci+bounces-12967-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E73972671
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2024 02:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB4621F2400F
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2024 00:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A5C6A332;
	Tue, 10 Sep 2024 00:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZ1uMomO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE411E517;
	Tue, 10 Sep 2024 00:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725929947; cv=none; b=q5Q4Ra9l94gkSSzAenWEXjw84dzcCMeQqjpPBWy3hxM5NQ9z+AvjsihrFsyrnJRyvi7xSR4VnbeAkzQ+mbnkGM0/RJjre/tDNiWeka3HHfnOuxk3hO9eH9lZsI7Ob37gkFL3fVpaGSDJ2GkbLqgqndfXAe4DGLNkbwEl/52V+Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725929947; c=relaxed/simple;
	bh=sydz+h9nmbxLBTCWxoovArpmy54oWbC1/Aced3zaz/g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=EbnNFqQjYG7rfLlEfjDe3Gd7r9kpFQIhcojUJjYrvnIQG4G72SUVMG2ZAeg7+LEyxTKtOluaU5wy+zJMIstlGARUlcQ2l7AfU+l/ZGAqMZAZ51AlcF/fx9W0C5EOmusx/j5nRSVj8gE3Zqy/s/CMNvnlQlzTCKWZnREH+lZcV+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZ1uMomO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FCBBC4CEC5;
	Tue, 10 Sep 2024 00:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725929946;
	bh=sydz+h9nmbxLBTCWxoovArpmy54oWbC1/Aced3zaz/g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=NZ1uMomODqD4iDaeU8x59FuywF/1zl7ftdOgYdug2eS2rfaxAChRMozxbzADjiWf0
	 Fq9mIG9dSEeNE4PFYWd4nOqYdSt5YBJqS0jkWLNUCQSKsKNmehlSq+DZeya8GxfEdh
	 m68bifgyw/UXvQmFAA9Zspto2bUdsCSej4XZmX2tFsk2cpkwDeK/jhKhQ01+hKPG5p
	 MIvOKjxYY6okHvmkTWx0/qLRfwm63zLViZhvJfguwQmizSdkop6aO3YVO57pdrgZTW
	 3VQd4a1fuRpjQAeF85KLJHpU0G8lNoSLq8tg/2XUne4ueWjN0iZFsZOAhCFcEyieeo
	 U5jru9ZANtUFQ==
Date: Mon, 9 Sep 2024 19:59:04 -0500
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
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Stanislav Spassov <stanspas@amazon.com>
Subject: Re: [RFC PATCH 0/3] PCI: Use Configuration RRS to wait for device
 ready
Message-ID: <20240910005904.GA561263@bhelgaas>
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

I'd like to merge this unchanged (except for adding credit to
Stanislav in the [1/3] commit log) for v6.12.  Let me know if you
test, review, or object.

Bjorn

