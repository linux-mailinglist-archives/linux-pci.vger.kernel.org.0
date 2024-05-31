Return-Path: <linux-pci+bounces-8141-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BC18D6B8E
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2024 23:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5714A1C2299C
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2024 21:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5CD182B9;
	Fri, 31 May 2024 21:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ot5gG8qO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69A63BB48;
	Fri, 31 May 2024 21:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717191113; cv=none; b=hHBf1gBAeCleLjiCwB5k7e+ByPSPky2wHJ3dYJKrgCd6Q7GA543AjjjhZT3IeGa1cOaRKW/XBSsAO6o6CFhZH+o5kVvTNFN4UwZTmhzNmBc3cbaM2hSrtpszVKshD0rS2VYDGhrcY7awKoldIOqTpYF+Qbgz+RJ4uQtd/GtqEww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717191113; c=relaxed/simple;
	bh=Y4JTAxkif2RvujwXQwJRcx4QqiSA7BolRpswLRLTKW4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=fx6rb+BMcnONytEPYsZzCiqAM7s9yelIQORdfW1tt4/BFBxNQaOb2ZgIIzLBTAe7c7LBnmmfDCmnd2JW9oSRahBGXtu5ChJzb9MtagAnygUtXteJf9sGircTLWkPioyenjNuPLj2OgbjmdftSJOGthgcB0/Em+0T2NyNMZTQnrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ot5gG8qO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D97ECC116B1;
	Fri, 31 May 2024 21:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717191113;
	bh=Y4JTAxkif2RvujwXQwJRcx4QqiSA7BolRpswLRLTKW4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Ot5gG8qOznFqV+Wy6MvSDblsFEk4vz/QVhep41+MtoTjjvX5fOffhvQKH/aazQamD
	 Gl/zsrGcLQ1/1bYhs9BDqjlLsl3JSlpcS9Z44Qt7fUewp1dhcZ/X1twLPYF2or8B/Z
	 19k0jJgSzuHBQUE2+m3lndrze9NxFtvrr0HOY1PfV8eK0YJkptlGkhN3JQHg0UTJPb
	 GEiQEiUPEqgimeoN16kEXMDuv1Qf3FVb2B4BxWofzgmWE2bh1J6GELDPwX62ERCDBa
	 vClSooIUmB7svSQHgadYWalAZlbVIIeXOuqmW0tJ9FLFiD1fiXOK5rPM909/IO7Amp
	 dZ/YB7xBKfNVA==
Date: Fri, 31 May 2024 16:31:50 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: bhelgaas@google.com, Dave Jiang <dave.jiang@intel.com>,
	Imre Deak <imre.deak@intel.com>,
	Jani Saarinen <jani.saarinen@intel.com>, linux-pci@vger.kernel.org,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 0/3] PCI: Revert / replace the cfg_access_lock lockdep
 mechanism
Message-ID: <20240531213150.GA610983@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171711745834.1628941.5259278474013108507.stgit@dwillia2-xfh.jf.intel.com>

On Thu, May 30, 2024 at 06:04:18PM -0700, Dan Williams wrote:
> Changes since v1 [1]:
> - split out the new warning into its own patch (Bjorn)
> - include the provisional fix to the pci_reset_bus() path
> 
> [1]: http://lore.kernel.org/r/171709637423.1568751.11773767969980847536.stgit@dwillia2-xfh.jf.intel.com
> 
> Hi Bjorn,
> 
> Here is the targeted revert of the cfg_access_lock lockdep
> infrastructure, but with the new proposed warning for catching "unlocked
> pci_bridge_secondary_bus_reset()" events broken out into its own change.
> I also included the proposed fix for at least one known case where
> pci_bridge_secondary_bus_reset() is being called without
> cfg_access_lock.
> 
> Given there may be more cases to unwind, and the fact that I am not
> convinced patch3 will be problem free I would, as you suggested,
> consider patch2 and patch3 v6.11 material. Patch1 is urgent for v6.10-rc
> to put out these lockdep false positive reports.
> 
> ---
> 
> Dan Williams (3):
>       PCI: Revert the cfg_access_lock lockdep mechanism
>       PCI: Warn on missing cfg_access_lock during secondary bus reset
>       PCI: Add missing bridge lock to pci_bus_lock()
> 
> 
>  drivers/pci/access.c    |    4 ----
>  drivers/pci/pci.c       |    8 +++++++-
>  drivers/pci/probe.c     |    3 ---
>  include/linux/lockdep.h |    5 -----
>  include/linux/pci.h     |    2 --
>  5 files changed, 7 insertions(+), 15 deletions(-)

Thanks, I applied the first to pci/for-linus for v6.10, and the others
to pci/reset for v6.11.

There will be a trivial conflict in -next and the v6.11 merge window
since pci/reset is based on v6.10-rc1 and contains some of the code
removed by the first patch.

Bjorn

