Return-Path: <linux-pci+bounces-8918-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 102A890D7E2
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 17:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4337AB32130
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 15:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E241ED299;
	Tue, 18 Jun 2024 15:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W12CaZsp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4FB41A80
	for <linux-pci@vger.kernel.org>; Tue, 18 Jun 2024 15:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718725505; cv=none; b=Rpx9/Qn6AOym2tUsWUEyTm/Gsn9j3T2VYvrQRwlu4zu/TefkguuL6EohK1xD9PrIqKteEHt8TRpzVCT//jquA92lg/+qDgOuxoQcSyaC/0W+OI5rMRsHXFFozJP0sgFYh+wPJxBoWNcoHxNDMMM6oEMDq4T0VcdDuaTtXexhd0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718725505; c=relaxed/simple;
	bh=mmoTWxV90KQj/71X22t7f4wuhUs5l86oq3BZTL4AQyU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PsvGo6NNiBOhCGlkbO3CPulDm3oNi5yj7LBLcfxpf8mOp1zHSVLeaarkNUsJwV8ep1rylBZoJuzhRrxHh6KSQRU8oQioHOz5jJbJoO8dWwLbjvopYZwK5OhrkRCJdSRotCgSkNq9txibHORi1fod4P4D215JXwMizoe+nr7exHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W12CaZsp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0832AC3277B;
	Tue, 18 Jun 2024 15:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718725505;
	bh=mmoTWxV90KQj/71X22t7f4wuhUs5l86oq3BZTL4AQyU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=W12CaZsp7O7N9viiYbImc9E4h4JS+2bX5MYzvePXEi22L9H2Y4a62iBZr1AXSE65H
	 HSimZKMaI0EcxMvHK4vCDChP8nv10TioST1f6Lqr/ukbeUSpQa6DVdg42xFkNMwjbn
	 IL4V2tVfnZmC8V0XCQfhDv50OtW6TKyKpsab/5pldxTZgdOkniGbegFKen/fgQusvu
	 mKdyw9FXZQogK8vkDI6NEXYpOSJH8drxf/Bl3Mod7sblHp3Dw2M1bGbsvqOpC1NSSO
	 NQb/3DcSqda3Ao2bnDqV06fHCvYheY+Av+m41T0xaVKQYciNuf0qGg4k2qXzg4WT+L
	 aAZvFA6yNknIw==
Date: Tue, 18 Jun 2024 10:45:03 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org
Subject: Re: [pci:endpoint] BUILD REGRESSION
 1b2ccd0341a6124d964211bae2ec378fafd0c8b2
Message-ID: <20240618154503.GA1257212@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202406141054.rqus0osg-lkp@intel.com>

On Fri, Jun 14, 2024 at 10:32:57AM +0800, kernel test robot wrote:
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git endpoint
> branch HEAD: 1b2ccd0341a6124d964211bae2ec378fafd0c8b2  PCI: endpoint: Make pci_epc_class struct constant
> 
> Error/Warning ids grouped by kconfigs:
> 
> gcc_recent_errors
> `-- sparc-randconfig-002-20240614
>     `-- (.head.text):relocation-truncated-to-fit:R_SPARC_WDISP22-against-init.text

Is there any further information about this?  I don't see the config
file to be able to reproduce this failure.

> elapsed time: 1692m
> 
> configs tested: 109
> configs skipped: 3
> 
> tested configs:
> alpha                             allnoconfig   gcc-13.2.0
> alpha                            allyesconfig   gcc-13.2.0
> alpha                               defconfig   gcc-13.2.0
> arc                               allnoconfig   gcc-13.2.0
> arc                                 defconfig   gcc-13.2.0
> arc                   randconfig-001-20240614   gcc-13.2.0
> arc                   randconfig-002-20240614   gcc-13.2.0
> arm                               allnoconfig   clang-19
> arm                                 defconfig   clang-14
> arm                   randconfig-001-20240614   gcc-13.2.0
> arm                   randconfig-002-20240614   gcc-13.2.0
> arm                   randconfig-003-20240614   gcc-13.2.0
> arm                   randconfig-004-20240614   clang-19
> arm64                             allnoconfig   gcc-13.2.0
> arm64                               defconfig   gcc-13.2.0
> arm64                 randconfig-001-20240614   gcc-13.2.0
> arm64                 randconfig-002-20240614   clang-19
> arm64                 randconfig-003-20240614   gcc-13.2.0
> arm64                 randconfig-004-20240614   clang-19
> csky                              allnoconfig   gcc-13.2.0
> csky                                defconfig   gcc-13.2.0
> csky                  randconfig-001-20240614   gcc-13.2.0
> csky                  randconfig-002-20240614   gcc-13.2.0
> hexagon                          allmodconfig   clang-19
> hexagon                           allnoconfig   clang-19
> hexagon                          allyesconfig   clang-19
> hexagon                             defconfig   clang-19
> hexagon               randconfig-001-20240614   clang-19
> hexagon               randconfig-002-20240614   clang-19
> i386         buildonly-randconfig-001-20240613   gcc-9
> i386         buildonly-randconfig-002-20240613   clang-18
> i386         buildonly-randconfig-003-20240613   clang-18
> i386         buildonly-randconfig-004-20240613   clang-18
> i386         buildonly-randconfig-005-20240613   gcc-7
> i386         buildonly-randconfig-006-20240613   clang-18
> i386                  randconfig-001-20240613   gcc-7
> i386                  randconfig-002-20240613   gcc-11
> i386                  randconfig-003-20240613   gcc-13
> i386                  randconfig-004-20240613   clang-18
> i386                  randconfig-005-20240613   gcc-13
> i386                  randconfig-006-20240613   gcc-13
> i386                  randconfig-011-20240613   gcc-13
> i386                  randconfig-012-20240613   clang-18
> i386                  randconfig-013-20240613   clang-18
> i386                  randconfig-014-20240613   gcc-12
> i386                  randconfig-015-20240613   gcc-8
> i386                  randconfig-016-20240613   gcc-13
> loongarch                         allnoconfig   gcc-13.2.0
> loongarch                           defconfig   gcc-13.2.0
> loongarch             randconfig-001-20240614   gcc-13.2.0
> loongarch             randconfig-002-20240614   gcc-13.2.0
> m68k                              allnoconfig   gcc-13.2.0
> m68k                                defconfig   gcc-13.2.0
> microblaze                        allnoconfig   gcc-13.2.0
> microblaze                          defconfig   gcc-13.2.0
> mips                              allnoconfig   gcc-13.2.0
> nios2                             allnoconfig   gcc-13.2.0
> nios2                               defconfig   gcc-13.2.0
> nios2                 randconfig-001-20240614   gcc-13.2.0
> nios2                 randconfig-002-20240614   gcc-13.2.0
> openrisc                          allnoconfig   gcc-13.2.0
> openrisc                            defconfig   gcc-13.2.0
> parisc                            allnoconfig   gcc-13.2.0
> parisc                              defconfig   gcc-13.2.0
> parisc                randconfig-001-20240614   gcc-13.2.0
> parisc                randconfig-002-20240614   gcc-13.2.0
> parisc64                            defconfig   gcc-13.2.0
> powerpc                           allnoconfig   gcc-13.2.0
> powerpc               randconfig-001-20240614   gcc-13.2.0
> powerpc               randconfig-002-20240614   clang-19
> powerpc               randconfig-003-20240614   gcc-13.2.0
> powerpc64             randconfig-001-20240614   clang-19
> powerpc64             randconfig-002-20240614   gcc-13.2.0
> powerpc64             randconfig-003-20240614   gcc-13.2.0
> riscv                             allnoconfig   gcc-13.2.0
> riscv                               defconfig   clang-19
> riscv                 randconfig-001-20240614   gcc-13.2.0
> riscv                 randconfig-002-20240614   clang-19
> s390                              allnoconfig   clang-19
> s390                                defconfig   clang-19
> s390                  randconfig-001-20240614   gcc-13.2.0
> s390                  randconfig-002-20240614   clang-19
> sh                               allmodconfig   gcc-13.2.0
> sh                                allnoconfig   gcc-13.2.0
> sh                                  defconfig   gcc-13.2.0
> sh                    randconfig-001-20240614   gcc-13.2.0
> sh                    randconfig-002-20240614   gcc-13.2.0
> sparc                             allnoconfig   gcc-13.2.0
> sparc                               defconfig   gcc-13.2.0
> sparc64                             defconfig   gcc-13.2.0
> sparc64               randconfig-001-20240614   gcc-13.2.0
> sparc64               randconfig-002-20240614   gcc-13.2.0
> um                               allmodconfig   clang-19
> um                                allnoconfig   clang-17
> um                               allyesconfig   gcc-13
> um                                  defconfig   clang-19
> um                             i386_defconfig   gcc-13
> um                    randconfig-001-20240614   gcc-13
> um                    randconfig-002-20240614   gcc-13
> um                           x86_64_defconfig   clang-15
> x86_64       buildonly-randconfig-001-20240614   clang-18
> x86_64       buildonly-randconfig-002-20240614   gcc-8
> x86_64       buildonly-randconfig-003-20240614   clang-18
> x86_64       buildonly-randconfig-004-20240614   gcc-8
> x86_64       buildonly-randconfig-005-20240614   gcc-10
> x86_64       buildonly-randconfig-006-20240614   clang-18
> xtensa                            allnoconfig   gcc-13.2.0
> xtensa                randconfig-001-20240614   gcc-13.2.0
> xtensa                randconfig-002-20240614   gcc-13.2.0
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

