Return-Path: <linux-pci+bounces-40655-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E10C44304
	for <lists+linux-pci@lfdr.de>; Sun, 09 Nov 2025 18:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55E833B0D86
	for <lists+linux-pci@lfdr.de>; Sun,  9 Nov 2025 17:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBFF2FFDC9;
	Sun,  9 Nov 2025 17:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKxieL0p"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3AF2E173B;
	Sun,  9 Nov 2025 17:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762707708; cv=none; b=n4urGldbQZ5NBZjUpFXol3rFkrsenHunReFRwOV9/wYLm5vsCWgMZeigw7jY3OrlWaFm90yNuno/3XMzFu5Cq1fBd/daM1ARg7t/MNw9xgqET/5Iq2PkKfwc7ro1LJzt1J1oLsjlBG5G6AlKeEP5DGe9mxIhXifjKAJyrCWX2gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762707708; c=relaxed/simple;
	bh=fo6RnCcC6+xCBiWx8ezB7q67nBjsPLn9NX71+SjOlmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DWsD3BdAOr4ivklSRIe73GEV2s3ZeUvxMiXyUpLq7AMjoJr+u0oSvie/IKr/ggY0yxcuiyhMrD7jmDrGCU7K0WJHV9Qsg4pWK9euqBgD7H4dnj07vbmMYhfM3SiIvaukP8ErOWKZMUQXf1u93LUAgYHvqG7LUL9kF7ua4gVPw5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKxieL0p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3A75C116B1;
	Sun,  9 Nov 2025 17:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762707706;
	bh=fo6RnCcC6+xCBiWx8ezB7q67nBjsPLn9NX71+SjOlmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jKxieL0psnA3JStnPdJ0GRnPuUwFlUYceI8t3CyNv5+hRse7IA1a8Z0uVjZWbJyld
	 bNn5B9Nj4/XVglF3vUC1cJDjrwDBq5F7wJlQahSMEHXUYYf8zh3HFpV+R1e0BnqfDd
	 Bb0JKXemnCW0vyk/3R1k7bvh5tftzwg85NlnkJ5F5yn8uGh0FNIcMz/nxQsu+FmaNZ
	 myCQxq6Hr4EcqgLFJJAm3TfkrirZ70nyVVUuNsyB6ZjSAxjeWElwJ/ubqWDAng2i+L
	 CO6xsB4+NiSvjryeIytRcT4AGauG5LzUZfeL83SRqsDGwROKwWUyWLsVJUyB7ZxtxZ
	 X1WLsHh6FunZQ==
Date: Sun, 9 Nov 2025 22:31:29 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: hans.zhang@cixtech.com, bhelgaas@google.com, helgaas@kernel.org, 
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, kwilczynski@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, oe-kbuild-all@lists.linux.dev, 
	mpillai@cadence.com, fugang.duan@cixtech.com, guoyin.chen@cixtech.com, 
	peter.chen@cixtech.com, cix-kernel-upstream@cixtech.com, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 03/10] PCI: cadence: Move PCIe RP common functions to
 a separate file
Message-ID: <xiaf3qvskwrqr7riradv6jnt5jmwcgenfr6mss5wtlddmxuwoa@ke2kdaq6adqz>
References: <20251108140305.1120117-4-hans.zhang@cixtech.com>
 <202511092106.mkNV0iyb-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202511092106.mkNV0iyb-lkp@intel.com>

On Sun, Nov 09, 2025 at 09:59:50PM +0800, kernel test robot wrote:
> Hi,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on 6146a0f1dfae5d37442a9ddcba012add260bceb0]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/hans-zhang-cixtech-com/PCI-cadence-Add-module-support-for-platform-controller-driver/20251108-220607
> base:   6146a0f1dfae5d37442a9ddcba012add260bceb0
> patch link:    https://lore.kernel.org/r/20251108140305.1120117-4-hans.zhang%40cixtech.com
> patch subject: [PATCH v11 03/10] PCI: cadence: Move PCIe RP common functions to a separate file
> config: i386-randconfig-014-20251109 (https://download.01.org/0day-ci/archive/20251109/202511092106.mkNV0iyb-lkp@intel.com/config)
> compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251109/202511092106.mkNV0iyb-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202511092106.mkNV0iyb-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/pci/controller/cadence/pcie-cadence-host-common.c: In function 'cdns_pcie_host_bar_config':
> >> drivers/pci/controller/cadence/pcie-cadence-host-common.c:188:23: warning: variable 'pci_addr' set but not used [-Wunused-but-set-variable]
>      188 |         u64 cpu_addr, pci_addr, size, winsize;
>          |                       ^~~~~~~~
> 
> 

No need to repost the series, just to fix this warning. If there are no more
comments, then I will fix it up while applying.

- Mani

> vim +/pci_addr +188 drivers/pci/controller/cadence/pcie-cadence-host-common.c
> 
>    183	
>    184	int cdns_pcie_host_bar_config(struct cdns_pcie_rc *rc,
>    185				      struct resource_entry *entry,
>    186				      cdns_pcie_host_bar_ib_cfg pci_host_ib_config)
>    187	{
>  > 188		u64 cpu_addr, pci_addr, size, winsize;
>    189		struct cdns_pcie *pcie = &rc->pcie;
>    190		struct device *dev = pcie->dev;
>    191		enum cdns_pcie_rp_bar bar;
>    192		unsigned long flags;
>    193		int ret;
>    194	
>    195		cpu_addr = entry->res->start;
>    196		pci_addr = entry->res->start - entry->offset;
>    197		flags = entry->res->flags;
>    198		size = resource_size(entry->res);
>    199	
>    200		while (size > 0) {
>    201			/*
>    202			 * Try to find a minimum BAR whose size is greater than
>    203			 * or equal to the remaining resource_entry size. This will
>    204			 * fail if the size of each of the available BARs is less than
>    205			 * the remaining resource_entry size.
>    206			 *
>    207			 * If a minimum BAR is found, IB ATU will be configured and
>    208			 * exited.
>    209			 */
>    210			bar = cdns_pcie_host_find_min_bar(rc, size);
>    211			if (bar != RP_BAR_UNDEFINED) {
>    212				ret = pci_host_ib_config(rc, bar, cpu_addr, size, flags);
>    213				if (ret)
>    214					dev_err(dev, "IB BAR: %d config failed\n", bar);
>    215				return ret;
>    216			}
>    217	
>    218			/*
>    219			 * If the control reaches here, it would mean the remaining
>    220			 * resource_entry size cannot be fitted in a single BAR. So we
>    221			 * find a maximum BAR whose size is less than or equal to the
>    222			 * remaining resource_entry size and split the resource entry
>    223			 * so that part of resource entry is fitted inside the maximum
>    224			 * BAR. The remaining size would be fitted during the next
>    225			 * iteration of the loop.
>    226			 *
>    227			 * If a maximum BAR is not found, there is no way we can fit
>    228			 * this resource_entry, so we error out.
>    229			 */
>    230			bar = cdns_pcie_host_find_max_bar(rc, size);
>    231			if (bar == RP_BAR_UNDEFINED) {
>    232				dev_err(dev, "No free BAR to map cpu_addr %llx\n",
>    233					cpu_addr);
>    234				return -EINVAL;
>    235			}
>    236	
>    237			winsize = bar_max_size[bar];
>    238			ret = pci_host_ib_config(rc, bar, cpu_addr, winsize, flags);
>    239			if (ret) {
>    240				dev_err(dev, "IB BAR: %d config failed\n", bar);
>    241				return ret;
>    242			}
>    243	
>    244			size -= winsize;
>    245			cpu_addr += winsize;
>    246		}
>    247	
>    248		return 0;
>    249	}
>    250	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 

-- 
மணிவண்ணன் சதாசிவம்

