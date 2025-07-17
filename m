Return-Path: <linux-pci+bounces-32463-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DC7B096D9
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 00:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D28EA1C40989
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 22:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514F2238C2B;
	Thu, 17 Jul 2025 22:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4KbMzq0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255671EF092;
	Thu, 17 Jul 2025 22:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752790431; cv=none; b=JRrcdX+QqgmGz11I+j+kluHt2T8w+WWFt0RHcsEP/f1MS7oeJLeovCN0Z2mNMNvES8KRsW5CH4lxxl9GLygSTQjPHQWiIMPRhTO4xneA5tS9mP3tC59DHq5x5WXJsQTLPkyyGnPu6FvFBLlAXeo33emBSlgTMLXBvkDwF/y9aZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752790431; c=relaxed/simple;
	bh=6mM0rO+4DYmDGvRNLjroQJwJas0gjJn+LevbX/1O6Rs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=oB/uuG5dN65QGGN/J04gWA2XexdJxcE56jFtLDzlQBloyk6XnQJO6VwDJ4PN4hPtfztStMi9B7UaNDLx6X2IcIKJ98i3usfptPZ6aun4ueTIxKYkV7UJo6+pKB83Cba9jLz0HlTwN49wlsgQQzno5ymShQIG/mPoTMetvD7JbKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m4KbMzq0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C03C4CEE3;
	Thu, 17 Jul 2025 22:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752790430;
	bh=6mM0rO+4DYmDGvRNLjroQJwJas0gjJn+LevbX/1O6Rs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=m4KbMzq0ycGjt/kp3z7LsAoa5H7Wja/Cf/qU5pIPyJvKxdfT69r5Vqz+7ntWj7GUx
	 nekj3iH+v9NZcUe8ku/nO2TcT9aDUpsdPAxueFPpw9gNkQhyZjs2LyroG6KjUnAs0Q
	 kOMQ0NvE0EpYfvddD2O1NTHYaeKV/4qm1WH2Ya/4TW+5ySUJ3Z571GM6cAyTpI7avp
	 cDgL1swGfXOhBEf6h0de3kqcAwBmvjDOsaaJoMznK57yp2Hb6Konn8IlG51m5FVlIs
	 J1uceLPOBmA4jrWNDpCXsjm9swI8POzFWFiWlbQAYrjH0oCCHjt14HjORZq8j0tqBI
	 OkVkv+aJXLLGQ==
Date: Thu, 17 Jul 2025 17:13:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, lukas@wunner.de,
	linux-kernel@vger.kernel.org, Jonathan.Cameron@huawei.com,
	Dexuan Cui <decui@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Rob Herring <robh@kernel.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH 0/3] PCI: Unify domain emulation and misc documentation
 update
Message-ID: <20250717221349.GA2658363@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716160835.680486-1-dan.j.williams@intel.com>

On Wed, Jul 16, 2025 at 09:08:32AM -0700, Dan Williams wrote:
> Bjorn,
> 
> This is a small collection of miscellaneous updates that originated in
> the PCI/TSM work, but are suitable to go ahead in v6.17. It is a
> documentation update and a new pci_bus_find_emul_domain_nr() helper.
> 
> First, the PCI/TSM work (Trusted Execution Environment Security Manager
> (PCI device assignment for confidential guests)) wants to add some
> additional PCI host bridge sysfs attributes. In preparation for that,
> document what is already there.
> 
> Next, the PCI/TSM effort proposes samples/devsec/ as a reference and
> test implementation of all the TSM infrastructure. It is implemented via
> host bridge emulation and aims to be cross-architecture compatible. It
> stumbled over the current state of PCI domain number emulation being
> arch and driver specific. Remove some of that differentiation and unify
> the existing x86 host bridge emulators (hyper-v and vmd) on a common
> pci_bus_find_emul_domain_nr() helper.
> 
> Dan Williams (3):
>   PCI: Establish document for PCI host bridge sysfs attributes
>   PCI: Enable host bridge emulation for PCI_DOMAINS_GENERIC platforms
>   PCI: vmd: Switch to pci_bus_find_emul_domain_nr()
> 
>  .../ABI/testing/sysfs-devices-pci-host-bridge | 19 +++++++
>  MAINTAINERS                                   |  1 +
>  drivers/pci/controller/pci-hyperv.c           | 53 ++-----------------
>  drivers/pci/controller/vmd.c                  | 33 ++++--------
>  drivers/pci/pci.c                             | 43 ++++++++++++++-
>  drivers/pci/probe.c                           |  8 ++-
>  include/linux/pci.h                           |  4 ++
>  7 files changed, 86 insertions(+), 75 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-devices-pci-host-bridge

Seems OK to me, modulo the conversation with Michael.  Would like a
Reviewed-by from the owners of pci-hyperv.c and vmd.c, of course.

Bjorn

