Return-Path: <linux-pci+bounces-24387-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC3CA6C1F2
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 19:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1B4517EB4D
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 18:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FBD22FAC3;
	Fri, 21 Mar 2025 18:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLglyo++"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC5F22F39B;
	Fri, 21 Mar 2025 18:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742580006; cv=none; b=Edq2F3I2hi/HAIA41A2/TGW8G8Quekh9GT70ZvFVKWkrjFH5v24WRVdZL6lVe45uOClu22HEefbXGKViLPePR68V0rcPWUngX0qAhCFoHPCyeCqtlsA6U4rT6ff4yLleQmRr+N+Ze8gVbo70XmO/JRBqMfKcwfVOf0JGrU9CxUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742580006; c=relaxed/simple;
	bh=vcKg9mUL/fqkuJAa8zyGDeR10PBY1F77gvgDIiwTnuI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=b81sdsmKCpat/+wjDdALbrNIIgAtOHfW4b8jbuMs2XSDPY0qYoMnzMkz/txyPPXaSNE0bATlpzNt0kMoqV9A1IMULGB46VQbzhuAT0C/fKQXswMTJlqo1aOLoxyugKcJ8ABz5YjuIrK2MmqjnZmdHJAEbPiAXLqo3LHG3C7vUUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLglyo++; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7CC1C4CEE3;
	Fri, 21 Mar 2025 18:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742580005;
	bh=vcKg9mUL/fqkuJAa8zyGDeR10PBY1F77gvgDIiwTnuI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=BLglyo++Qy4r32e03DryRPT4rN1ZUJGSJXeEc4lN3+tcE1wAOl9V8/zav6GYRfoi3
	 CW7mfiX8psWPnU7nknj83od/FflUo0qF7MBs8CMosU6+Pr1RRRXPMpOJTpexgbm6be
	 J1+OvnZKhtEqHaNp9iDMS7Rcx7mrY0BI1XWge29sRVk57DKnwioa1yPnd+AJNYmRh8
	 M8nRE2LjncxVa6PHy0oJZYmtTT2+QB7h3KjEqCVXNDJm1QHlSLwqI/JtrdscDMjFGl
	 vHgna5VkQ8ilHWGYZ0tdXUFn9MoWmxpiNaah0x3FQFVMjydIQOoOLEHf96WjgAAol+
	 GYh4j0uqz8uTw==
Date: Fri, 21 Mar 2025 13:00:04 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Frank Li <Frank.Li@nxp.com>, oe-kbuild-all@lists.linux.dev,
	linux-pci@vger.kernel.org, Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: Re: [pci:controller/dwc-cpu-addr-fixup 6/14]
 drivers/pci/controller/dwc/pcie-designware.c:1130:55: sparse: sparse: Using
 plain integer as NULL pointer
Message-ID: <20250321180004.GA1137242@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202503210649.lau9JEgG-lkp@intel.com>

On Fri, Mar 21, 2025 at 06:56:55AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-cpu-addr-fixup
> head:   94d1d26431c0e4c845e9e9ee5f23bcc9a53d95ec
> commit: c1154a3218325a03cd07df51a7076a353a723589 [6/14] PCI: dwc: Add dw_pcie_parent_bus_offset() checking and debug
> config: alpha-randconfig-r121-20250321 (https://download.01.org/0day-ci/archive/20250321/202503210649.lau9JEgG-lkp@intel.com/config)
> compiler: alpha-linux-gcc (GCC) 12.4.0
> reproduce: (https://download.01.org/0day-ci/archive/20250321/202503210649.lau9JEgG-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202503210649.lau9JEgG-lkp@intel.com/
> 
> sparse warnings: (new ones prefixed by >>)
> >> drivers/pci/controller/dwc/pcie-designware.c:1130:55: sparse: sparse: Using plain integer as NULL pointer

> vim +1130 drivers/pci/controller/dwc/pcie-designware.c
> 
>   1109	
>   1110	resource_size_t dw_pcie_parent_bus_offset(struct dw_pcie *pci,
>   1111						  const char *reg_name,
>   1112						  resource_size_t cpu_phy_addr)
>   1113	{

> > 1130		fixup = pci->ops ? pci->ops->cpu_addr_fixup : 0;

Replaced with

    fixup = pci->ops ? pci->ops->cpu_addr_fixup : NULL;

