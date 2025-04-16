Return-Path: <linux-pci+bounces-26015-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 771D9A90861
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 18:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3E1B5A24AF
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 16:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E3B211A33;
	Wed, 16 Apr 2025 16:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SQn0Q1aG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC7C2080DC;
	Wed, 16 Apr 2025 16:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744819774; cv=none; b=jNIdtyHWZ5L8StHCOt/G6Om4ZYvUytNtnl7+BrFO+gPaVnwR7ExkX132KNMFecuQBvFWK/a8Y7hM+cjDG8r4v4oQCbxMn27A1DF0IUo9gY0Ayot4RJ4PeSEcH2OLJ3o8XGigXAhNhN3TCT0BMpfBy9CRfSeAGxhE56csvongAPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744819774; c=relaxed/simple;
	bh=U7P2TGZ5fr63R15j09YKCXfc3v5/LTxm9/PgE0QkYo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GmGmX2KsPMj2ja9AdDouUB2epLn2b2LPH2w0xWyNqWX3ZeWbt2OnzKLa37a29j9JCY1Yqmp8zSBlV+jvL9bqlJSh1KS5VaKNOiqkqD9P5kxLTA+rljCYDLQqWJ85PL5tVW7cuXqzL8YX84wR3ZUx9VizXTJQAHd6NmXaqxnwpZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SQn0Q1aG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22063C4CEE2;
	Wed, 16 Apr 2025 16:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744819773;
	bh=U7P2TGZ5fr63R15j09YKCXfc3v5/LTxm9/PgE0QkYo8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SQn0Q1aGbAPz748YwfXAz9D93nNWeEZgCu6+egkUlR7PxNRSMs9oH/bbOR/hYTxdc
	 9kEIrraTpp1+CvVwihkrJvrssr1EP139FUCNRXcWkUJXoHF2YoG/nE8rirCZzCmdcA
	 1UID/9Op1jYOL4HNEdgksKoin3dnJxr2PXSWIAzlgM/h2vwCr0TtiNqDUwpXLaePk4
	 SIUdTeDAEf9XxZ6xcaO+M5XhcXqrRM0SECsdLLBj4rHozWV1clk+CwNvo/6BiFozPk
	 JlZFtXumJFebgv9TzyGY0H7GOSG8KHqjd52A3LXfAIPpt6jZzpcvW314uh/8teQTTj
	 Kbf0YLAEyly4g==
Date: Wed, 16 Apr 2025 18:09:27 +0200
From: Niklas Cassel <cassel@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Vidya Sagar <vidyas@nvidia.com>, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, treding@nvidia.com,
	jonathanh@nvidia.com, kthota@nvidia.com, mmaddireddy@nvidia.com,
	sagar.tv@gmail.com
Subject: Re: [PATCH V2] PCI: dwc: tegra194: Broaden architecture dependency
Message-ID: <Z__WN_nTCsNNFgi6@ryzen>
References: <20250410194552.944818-1-vidyas@nvidia.com>
 <202504162332.fwaFxVrL-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202504162332.fwaFxVrL-lkp@intel.com>

On Wed, Apr 16, 2025 at 11:43:25PM +0800, kernel test robot wrote:
> Hi Vidya,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on pci/next]
> [also build test WARNING on pci/for-linus linus/master v6.15-rc2 next-20250416]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Vidya-Sagar/PCI-dwc-tegra194-Broaden-architecture-dependency/20250411-035134
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
> patch link:    https://lore.kernel.org/r/20250410194552.944818-1-vidyas%40nvidia.com
> patch subject: [PATCH V2] PCI: dwc: tegra194: Broaden architecture dependency
> config: arm64-kismet-CONFIG_PHY_TEGRA194_P2U-CONFIG_PCIE_TEGRA194_EP-0-0 (https://download.01.org/0day-ci/archive/20250416/202504162332.fwaFxVrL-lkp@intel.com/config)
> reproduce: (https://download.01.org/0day-ci/archive/20250416/202504162332.fwaFxVrL-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202504162332.fwaFxVrL-lkp@intel.com/
> 
> kismet warnings: (new ones prefixed by >>)
> >> kismet: WARNING: unmet direct dependencies detected for PHY_TEGRA194_P2U when selected by PCIE_TEGRA194_EP
>    WARNING: unmet direct dependencies detected for PHY_TEGRA194_P2U
>      Depends on [n]: ARCH_TEGRA_194_SOC [=n] || ARCH_TEGRA_234_SOC [=n] || COMPILE_TEST [=n]
>      Selected by [y]:
>      - PCIE_TEGRA194_EP [=y] && PCI [=y] && ARCH_TEGRA [=y] && (ARM64 [=y] || COMPILE_TEST [=n]) && PCI_ENDPOINT [=y]
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

My guess is that the easiest fix is to change
drivers/phy/tegra/Kconfig

config PHY_TEGRA194_P2U
to
depends on ARCH_TEGRA || COMPILE_TEST


Kind regards,
Niklas

