Return-Path: <linux-pci+bounces-29860-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B00ADB05E
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 14:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 240F21889074
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 12:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C45285CAB;
	Mon, 16 Jun 2025 12:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7yKd6Kx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD85279351;
	Mon, 16 Jun 2025 12:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750077477; cv=none; b=jThCpFCZVwU2HZFeV/SXxWXcQA6Ny57+psDsyr2pM6ILuUxLDYYsa00XIj+wM3JdhLKKt09RrvtfzaD3dcVQg+b2SUEVxFh52xdGL1RjRDk4k53Kdrb+XtfBQ930wiZOTI9A7nTm0b84duYCQIDQKy0eUWesXTclVfr7IjKVE3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750077477; c=relaxed/simple;
	bh=9xhdxfhzoQ/5X+95wOEApU8fYRXZ5GgsA2b5WjXT9Wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m8NkVdzy83dOoz0hlsu4KkmU/gzYDhJCm7hgzyDjA6a+DpfVaCVpzql/xEJy3MUGeu0LO9MwjN6zbH/srjYl0AYwBaDPzJAx7Auhge7Vx6SXL4jI4SMuddbTFh0LoJEINK+MBZS544rYlZxS66ygLsJXz3Aev39FX0uyo2RpYF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7yKd6Kx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2BA0C4CEEA;
	Mon, 16 Jun 2025 12:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750077476;
	bh=9xhdxfhzoQ/5X+95wOEApU8fYRXZ5GgsA2b5WjXT9Wc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F7yKd6KxlmNZb3CHcSM2TPCeJOZRsDbUPFXbqWs7ecixydGgSwHDgdtF3AJh1G8Cg
	 EEd1tDEXMzyFgrEIWnCrUZAVxlxqtt/6AhtEhiQOoNj4xj7N1aqUwduA8VBmeEITpu
	 lEe5XWB9aPL/jvcG1M182IH/ruT0P+TJF3gHoTo2e20BI904hGqzmmIy9jGC8qAfJE
	 zKwq5eqi802a6kdHmVKBIzCwtjRzl8pUH79eNZNz5StbU8io0MG1Dj10B6CNyWHxa4
	 oFjoR4n3OrMmGaiuoubNfZ6nmx0SzERBpOWlmw5Wj9dFYHitysslbTXNAhOJga1PV6
	 1uEkCr2V6d2rg==
Date: Mon, 16 Jun 2025 18:07:48 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: brgl@bgdev.pl, kernel test robot <lkp@intel.com>
Cc: bhelgaas@google.com, oe-kbuild-all@lists.linux.dev, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, lukas@wunner.de, 
	Jim Quinlan <james.quinlan@broadcom.com>, Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v3] PCI/pwrctrl: Move pci_pwrctrl_create_device()
 definition to drivers/pci/pwrctrl/
Message-ID: <ji3pexgvdkfho6mnby5jumkeaxdbzom574kbiyfy4dcqumtgz2@h4nmwjvox7nl>
References: <20250616053209.13045-1-mani@kernel.org>
 <202506162013.go7YyNYL-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202506162013.go7YyNYL-lkp@intel.com>

On Mon, Jun 16, 2025 at 08:21:20PM +0800, kernel test robot wrote:
> Hi Manivannan,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on pci/next]
> [also build test ERROR on pci/for-linus linus/master v6.16-rc2 next-20250616]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Manivannan-Sadhasivam/PCI-pwrctrl-Move-pci_pwrctrl_create_device-definition-to-drivers-pci-pwrctrl/20250616-133314
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
> patch link:    https://lore.kernel.org/r/20250616053209.13045-1-mani%40kernel.org
> patch subject: [PATCH v3] PCI/pwrctrl: Move pci_pwrctrl_create_device() definition to drivers/pci/pwrctrl/
> config: i386-buildonly-randconfig-001-20250616 (https://download.01.org/0day-ci/archive/20250616/202506162013.go7YyNYL-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250616/202506162013.go7YyNYL-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202506162013.go7YyNYL-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    ld: drivers/pci/probe.o: in function `pci_scan_single_device':
> >> probe.c:(.text+0x2400): undefined reference to `pci_pwrctrl_create_device'

Hmm, so we cannot have a built-in driver depend on a module...

Bartosz, should we make CONFIG_PCI_PWRCTRL bool then? We can still allow the
individual pwrctrl drivers be tristate.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

