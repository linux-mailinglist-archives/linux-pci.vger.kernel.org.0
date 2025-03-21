Return-Path: <linux-pci+bounces-24404-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B671A6C49C
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 21:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 527A17A85B9
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 20:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1845231A3F;
	Fri, 21 Mar 2025 20:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYDpoUPw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995A11D5AD4;
	Fri, 21 Mar 2025 20:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742590276; cv=none; b=ZLP9xbRhHn6xLU9I4nV/P7FfjonzauK5BAf5FpQTP22jKE9uLMfN0olWh1mISIu9fMv9NT3RStfZ4iW7C/Fm5+RyGdCRe1ACRHONzhy6WRWEX1WCIogzUhdKfTUzmAx5/yfeIRXOvOjUfWm8gNpz2mJdi3avVTLvu5Q5IuOD/Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742590276; c=relaxed/simple;
	bh=9kXERGWJ4IUeqTQtzLrow766M6oxKrGWyKs4LWZ3fcg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=oR58YyTEA0y1reglu8Z8p9TpSEIIJAfjGE2y9NQTsB7Gs0S4t3T6LJP3yRdqe9P502nc68TLySvyoUji8ifacQun6I5i5J1SWtel1fcosMd+d4FKg8BXfs7Xjl89GkD8TS8q20lDvSjsKaeryAmFdW3lz8wJzc7U76HsYbS10t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYDpoUPw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9E62C4CEE3;
	Fri, 21 Mar 2025 20:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742590276;
	bh=9kXERGWJ4IUeqTQtzLrow766M6oxKrGWyKs4LWZ3fcg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=VYDpoUPwm57JKvJzx9SpOY9FXlFPRs+uvWK99/l0kOdhFgHFghQKSVvrrX+feECey
	 ID4fRjF6uRWn1LRVHCuXiR1EqhmI7Ha4aR9qSBRz8s6KV6TA+KfqV+U9vJP3MOwKS7
	 mINVok465d0tSZxSGZPhR0u5xRPWpLohmwjLQu73KnsVZ7wa4MqeabVAaBOYy69SWd
	 b4k5Tl0g7xr4zegYTfko/GHFl2A4OB1E4vYiic3Ovl6POGFxQk1npTHhVi1B7H2TWT
	 uWPvXqBqlm1FZyskVB+Qjvld4Cx4bC+0+ii+iV0ZVT732ceuVDCMplYYb25Q7O04+U
	 0In4/6lhztAWA==
Date: Fri, 21 Mar 2025 15:51:14 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] PCI/hotplug: Don't enable HPIE in poll mode
Message-ID: <20250321205114.GA1144421@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z92q84PdWVtftxI4@wunner.de>

On Fri, Mar 21, 2025 at 07:07:47PM +0100, Lukas Wunner wrote:
> On Fri, Mar 21, 2025 at 12:09:19PM -0500, Bjorn Helgaas wrote:
> ...

> >   - It's annoying that pcie_enable_interrupt() and
> >     pcie_disable_interrupt() are global symbols, a consequence of
> >     pciehp being split across five files instead of being one, which
> >     is also a nuisance for code browsing.
> 
> Roughly,
> pciehp_core.c contains the interface to the PCI hotplug core
>   (registering the hotplug_slot_ops etc),
> pciehp_hpc.c contains the interaction with hardware registers,
> pciehp_core.c contains the state machine,
> pciehp_pci.c contains the interaction with the PCI core
>   (enumeration / de-enumeration of devices on slot bringup / bringdown).
> 
> The only reason I've refrained from making major adjustments to this
> structure in the past was that it would make "git blame" a little more
> difficult and applying fixes to stable kernels would also become somewhat
> more painful as it would require backporting.

Yeah, that's the main reason I haven't tried to do anything either.
On the other hand, the browsing nuisance is an everyday thing forever
if we leave it as-is.  I did consolidate portdrv.c a couple years ago
and don't regret it.  But moving things definitely makes "git blame" a
bit of a hassle; my notes are full of things like this:

  a1ccd3d91138 ("PCI/portdrv: Squash into portdrv.c")
    squash drivers/pci/pcie/portdrv_pci.c and portdrv_core.c into portdrv.c
  950bf6388bc2 ("PCI: Move DesignWare IP support to new drivers/pci/dwc/ directory")
    mv drivers/pci/host/pci-imx6.c drivers/pci/dwc/pci-imx6.c
  6e0832fa432e ("PCI: Collect all native drivers under drivers/pci/controller/")
    mv drivers/pci/dwc/pci-imx6.c drivers/pci/controller/dwc/pci-imx6.c

> >   - I forgot why we have both pcie_write_cmd() and
> >     pcie_write_cmd_nowait() and how to decide which to use.
> 
> pcie_write_cmd_nowait() is the "fire and forget" variant,
> whereas pcie_write_cmd() can be thought of as the "_sync" variant,
> i.e. the control flow doesn't continue until the command has been
> processed by the slot.
> 
> E.g. pciehp_power_on_slot() waits for the slot command to complete
> before making sure the Link Disable bit is clear.  It wouldn't make
> much sense to do the latter when the former hasn't been completed yet.

Right, I know what the difference is; I guess I just don't know how to
figure out when pcie_write_cmd_nowait() is safe.

Bjorn

