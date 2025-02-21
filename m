Return-Path: <linux-pci+bounces-22052-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C43CA4038D
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 00:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CFC13B7378
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 23:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9BF253B6D;
	Fri, 21 Feb 2025 23:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5fX07bn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AC218DB0B;
	Fri, 21 Feb 2025 23:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740181003; cv=none; b=PEvu0+mV+cbpvX6NM/oCoZlox6QcJBqirQcrs3wR/BXJ0s/7df2eEuH73yKHBHNiIWTF326NBD3SXrOZ7redygaAUZdkPD7aSrYcyQUpVJ6ij4ELPqYsT9Q4fMTDfM1T+jo1XyGRv0yeV81Uc9sjN27mA9/81JIboPI/Y/VX/Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740181003; c=relaxed/simple;
	bh=SjESwENVnWgYJ0MUOGBAyfyIRNDQRBm3rm93k+YwaWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KU9xOduusbf2vXivkzdbFLEPNflwVqeDc+8YBRnTkbBSaefq6qVrhLOi0dg75Gs3Umiv5VqEeLDqRxUsVx+coc6cfBd+kiKh1ah3i832tCKt2hqpDXjCJiCKq/nMASKXKfhFQXD8ixiRyA0X75ngdI8fC4RU6U5DrfETyRhuzR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5fX07bn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60FF8C4CED6;
	Fri, 21 Feb 2025 23:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740181002;
	bh=SjESwENVnWgYJ0MUOGBAyfyIRNDQRBm3rm93k+YwaWQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=f5fX07bnD7HFmEbABZI8ZpxJKvoAbxeYdI7XXSiyCgbDuCb3Rg/inP855rtpQNZHG
	 LTQVtXxyEScvsiFJ8Z2c4Zi6Vgc4yytP5Es38qFs1Jexwai1jx/cHIccvh4N/WgpYQ
	 zhWaUD+M5t5lXbjb2uBQCi7RzZvunSMntj+0yNi17qjD3UeOeN87Fv8MH/p3qRiz7z
	 HZwPQB3BirdyOWe6GaxQk1JagR7YNOamRJBa4WD4jEVZ9CXqzptipJMBsmyWIK0I3B
	 TW6I7hQUEdkMuQdEuCjPXe7xtN40gnH/Ug8uPI+d2FU2x346RU81CP/LfKpY9yKA2M
	 lg0XUiYEevpLQ==
Date: Fri, 21 Feb 2025 17:36:40 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
	linux-edac@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH v2 0/2] PCI: Add support for logging Flit Mode TLPs
 (PCIe6)
Message-ID: <20250221233640.GA372744@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250207161836.2755-1-ilpo.jarvinen@linux.intel.com>

On Fri, Feb 07, 2025 at 06:18:34PM +0200, Ilpo Järvinen wrote:
> This series adds support for Flit Mode (PCIe6).
> 
> v2:
> - Rebased
> 
> Ilpo Järvinen (2):
>   PCI: Track Flit Mode Status & print it with link status
>   PCI: Handle TLP Log in Flit mode
> 
>  drivers/pci/hotplug/pciehp_hpc.c |  5 +--
>  drivers/pci/pci.c                | 12 ++++---
>  drivers/pci/pci.h                |  6 ++--
>  drivers/pci/pcie/aer.c           |  1 +
>  drivers/pci/pcie/dpc.c           | 18 ++++++++--
>  drivers/pci/pcie/tlp.c           | 56 ++++++++++++++++++++++----------
>  drivers/pci/probe.c              |  5 +--
>  include/linux/aer.h              | 12 +++++--
>  include/linux/pci.h              |  1 +
>  include/ras/ras_event.h          | 12 +++----
>  include/uapi/linux/pci_regs.h    |  6 +++-
>  11 files changed, 94 insertions(+), 40 deletions(-)

Applied to pci/aer for v6.15, thanks!

