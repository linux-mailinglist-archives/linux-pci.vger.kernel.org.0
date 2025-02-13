Return-Path: <linux-pci+bounces-21391-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFD5A3510C
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 23:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68C211885B48
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 22:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD18266B74;
	Thu, 13 Feb 2025 22:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJpkEmBT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B9C266B59;
	Thu, 13 Feb 2025 22:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739484883; cv=none; b=SdmjxV9qFm123hYTwxsLidRtR6NXLrsmKxOUTmIemMJJRKv6S4abLjjItrdz9AzmxTUogmY6X+OwZLSbMl6fSaBVMdOIseTrAxtasOHX6PvI7rUyhecmDauUBI+HOL/hKKJNrUW1bTwlf3wWFcEByxYom62B2aTPVYOGebpmOTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739484883; c=relaxed/simple;
	bh=2mCO7TSVY9WnU7z7mJv7Hzum3SA2OJA2XG1d+rd36Zs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QdE2bggqpLCDgp57CLo0IWrIKAd+t1TY7AD40UHwyxBSLAu5bYfI4SSiqYFTWrosm53c1hwcbSChQyY1cW0joZ7MzaJsR+vGPIj/LILbNbDUCHFb1xPdVL65CRyl4PIIgnTGYQjw11utUPxGprDXSqs9d9CZ/ZQmTUdgOKJTtbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJpkEmBT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B9DDC4CED1;
	Thu, 13 Feb 2025 22:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739484882;
	bh=2mCO7TSVY9WnU7z7mJv7Hzum3SA2OJA2XG1d+rd36Zs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=BJpkEmBTGtABjVaHBzB+u5PWOMtiEpWZKoKGu8EeS+/la1wEHNCz/SaV4QpBr5ELe
	 Ktzkp1ahxbWY6mIdQUsvih1Zeco/nj5HM43csN8v7FBwPh2tpnBLjIMahaEbwEVmyP
	 wMkTSeUqHYF1RrNb3dkl1laq1ulMv+ooCufsocK4qqautwNvMpg3CPDS8kQLA03cHT
	 DzImEux1NDyBJRAm8R+Mfjv8dPM6ySTCB4BozjpJeUpjMvkN1OJHYOyhpSmdeO/ZZ5
	 MBMRPC3yQJf8o7Zs5T41pR/dUW4FrrvN+HO2TvZa6QuMj9kmG05EzY4G9g/bfiF5kf
	 DHCnvlbPlaZug==
Date: Thu, 13 Feb 2025 16:14:41 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>
Subject: Re: [PATCH 0/4] PCI: pci_printk() removal (+ related cleanups)
Message-ID: <20250213221441.GA136775@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241216161012.1774-1-ilpo.jarvinen@linux.intel.com>

On Mon, Dec 16, 2024 at 06:10:08PM +0200, Ilpo Järvinen wrote:
> include/linux/pci.h provides pci_printk() which is a low-level
> interface with level that is only useful for AER due to error severity
> variations.
> 
> This series cleans up shpchp logging wrappers to avoid using low-level
> pci_printk() unnecessarily and replaces pci_printk() with aer_printk().
> 
> Ilpo Järvinen (4):
>   PCI: shpchp: Remove logging from module init/exit functions
>   PCI: shpchp: Change dbg() -> ctrl_dbg()

I applied the above to pci/hotplug for v6.15, thanks!

>   PCI: shpchp: Cleanup logging and debug wrappers
>   PCI: Descope pci_printk() to aer_printk()
> 
>  drivers/pci/hotplug/shpchp.h      | 18 +-----------------
>  drivers/pci/hotplug/shpchp_core.c | 13 +------------
>  drivers/pci/hotplug/shpchp_hpc.c  |  2 +-
>  drivers/pci/pcie/aer.c            | 10 +++++++---
>  include/linux/pci.h               |  3 ---
>  5 files changed, 10 insertions(+), 36 deletions(-)
> 
> -- 
> 2.39.5
> 

