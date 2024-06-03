Return-Path: <linux-pci+bounces-8206-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 850F88DAED9
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jun 2024 23:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 823A71C2404D
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jun 2024 21:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23A813B5B7;
	Mon,  3 Jun 2024 21:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VU87A+5N"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AC05028C;
	Mon,  3 Jun 2024 21:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717449708; cv=none; b=OwvMhvaljS4Gs6NXCX6XzrlcSCrHjReEBmLodC0e3hWOT22WmNZ5hvWYFrLD9ykJ6eVbkvj/F4pBPVpgiUHdSR5scBgvmIaydLiWXX834pVsMxZ50ckHwuc0VMLhXceYwnXCfYpE862o+/fLvrYy8CE85JfZtMT/FYbqbYw4gvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717449708; c=relaxed/simple;
	bh=CfAuGO3L+Vmv0KFuM50pHrpSRbJ4K3M/mg7Isem5BlM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ZgFvu2zlMoapYLhp4HrgtA9a86diQpdE7aLtNkkvl1P9H893yX4N6DIJvsl4l3Cmk5Yt65NY3BeAEYYhDNcXPgGk8v16chwHOju9Ilxo8r5GFUsy2zDCs6r/4pF4RXchRVqR/GJSC4Pb2tZiaJQVOmlzKLnAgSYB5qKfW4+OOzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VU87A+5N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF7EDC2BD10;
	Mon,  3 Jun 2024 21:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717449708;
	bh=CfAuGO3L+Vmv0KFuM50pHrpSRbJ4K3M/mg7Isem5BlM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=VU87A+5NyGjsW9oK77Dglj+NU97HaHx43IJY3gjN3hfDu22jmFaa9A6/mvVhB6/pq
	 RBSbMSyyUWQFKKqIXz7/VDamsFA77LFpuw6wtLNh7bKnE1M7FxoTvKdR58QrWjY7w5
	 bnK9l6X1JB9NEeCO/GugKGdphJJXXwyj7dVlRCZQFpA6bzZJGNrD+NE0HPrinfqBTK
	 /Kd1aEauJ7+NwkFMLHjQRsxHMdCworsm8Gjz3V3qCwMuGKLvLB/YBaOLsgEvXA/BRk
	 WXCqnKKcoPBp6YoDvsbklHTXEYSqWfrDS/UaF8wN9JmZb+JvvOQj1ncdJarFqkx7BI
	 VhNkeLtoWpAUw==
Date: Mon, 3 Jun 2024 16:21:46 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vidya Sagar <vidyas@nvidia.com>
Cc: bhelgaas@google.com, rafael@kernel.org, lenb@kernel.org,
	will@kernel.org, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, frowand.list@gmail.com, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	treding@nvidia.com, jonathanh@nvidia.com, kthota@nvidia.com,
	mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V7 0/4] PCI: Add support for preserving boot configuration
Message-ID: <20240603212146.GA697762@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508174138.3630283-1-vidyas@nvidia.com>

On Wed, May 08, 2024 at 11:11:34PM +0530, Vidya Sagar wrote:
> Add support for preserving the boot configuration done by the
> platform firmware per host bridge basis, based on the presence of
> 'linux,pci-probe-only' property in the respective PCI host bridge
> device-tree node. It also unifies the ACPI and DT based boot flows
> in this regard.
> 
> This patch series is a complete version of the incomplete series
> ( https://lore.kernel.org/linux-pci/20240421190914.374399-1-helgaas@kernel.org/ )
> posted by Bjorn which in turn was an attempted split work of the single V6 patch
> ( https://lore.kernel.org/linux-pci/20240418174043.3750240-1-vidyas@nvidia.com/ )
> posted by me.
> 
> Vidya Sagar (4):
>   PCI: Move PRESERVE_BOOT_CONFIG _DSM evaluation to
>     pci_register_host_bridge()
>   PCI: of: Add of_pci_preserve_config() for per-host bridge support
>   PCI: Unify ACPI and DT 'preserve config' support
>   PCI: Use preserve_config in place of pci_flags
> 
>  drivers/acpi/pci_root.c                  | 12 ------
>  drivers/pci/controller/pci-host-common.c |  4 --
>  drivers/pci/of.c                         | 54 +++++++++++++++++++-----
>  drivers/pci/pci-acpi.c                   | 22 ++++++++++
>  drivers/pci/pci.h                        | 12 ++++++
>  drivers/pci/probe.c                      | 34 ++++++++++-----
>  6 files changed, 101 insertions(+), 37 deletions(-)

Applied to pci/enumeration for v6.11, thanks!

