Return-Path: <linux-pci+bounces-32319-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F23B07D8C
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 21:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B2767A5705
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 19:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8AD2BD024;
	Wed, 16 Jul 2025 19:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SRrm+3LU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C412BCF5C
	for <linux-pci@vger.kernel.org>; Wed, 16 Jul 2025 19:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752693861; cv=none; b=U1DwOkMDdjHaK7seOUpm7V+61rWTuCdGjtXn/uLizUlG5PUwVKldJZGux4hO5l/wOBh7gbvkrxaKK6HpXNvB6mulY1fY21zM+9nlPeD/5/r0a5H2wbZ7HPGZPPdJLCVL9vuBG93Ixny1qCiDUuI4AMYixFyne1AASZBWkSBt5pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752693861; c=relaxed/simple;
	bh=bP+oPNEanx8WKxjx5DJ0i3sRJ6Y6YRIFjQPI7zSnyas=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=I0RkibiX5dFMkd4L65GxjtH6Cz+mHcUT7X3KKwvjdPHsa5va+vEFAl8Bbhbyrk41fwoZ7tJoWYzhiNakdtTSugbtvUXd7IOBpAlL17c0Axv7Nvdeqz+VqXRknVuvzZNeJiqqUgPsZ67b1oslA/xu7nq+JatdVVuhq9Gm16lpfaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SRrm+3LU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7862EC4CEE7;
	Wed, 16 Jul 2025 19:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752693859;
	bh=bP+oPNEanx8WKxjx5DJ0i3sRJ6Y6YRIFjQPI7zSnyas=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=SRrm+3LUjydW0FiPSFDj1cVxoAY0wUCILaT5DZ9eA8vA6IUbKV709vvBUZ4TdD/Wd
	 BvKnThYR2rkOHmRcd7PELAnxoODcWg5LJ8q85E3eVy2k2GjQ41nJ6zmf6asNKe8M90
	 f5jjS8wjFp3kc1f/mYrN3SE8fduiowQW/Rze/r6IiyBgoffSp/n9rfYCN5Yi6+U/wT
	 ESZtQjeYP+wBFhbhuj7ZGMBHKlrd7wbYATcHGRq2JHaX+pvtb/3J3nScSD1KBbltrq
	 fmN/9v9FsaLK7F0u9iVzk23QvKjkq212mSR2jK/Ybt3BmsgDmu12RnhUyFJPfZGYLp
	 gmqWT/Lg1D6lg==
Date: Wed, 16 Jul 2025 14:24:18 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christian Bruel <christian.bruel@foss.st.com>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: Re: [pci:controller/dwc-stm32] BUILD REGRESSION
 5a972a01e24b278f7302a834c6eaee5bdac12843
Message-ID: <20250716192418.GA2550861@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202506270620.sf6EApJY-lkp@intel.com>

We have the pci/controller/dwc-stm32 branch pending, which currently
looks like this:

  https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git/log/?h=controller/dwc-stm32&id=5a972a01e24b

which is identical to the 5a972a01e24b HEAD mentioned below.  This
build error is why I haven't included pci/controller/dwc-stm32 in
pci/next yet.

I would like to get this branch included for v6.17, but we need to
resolve this somehow.

On Fri, Jun 27, 2025 at 06:10:31AM +0800, kernel test robot wrote:
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-stm32
> branch HEAD: 5a972a01e24b278f7302a834c6eaee5bdac12843  MAINTAINERS: add entry for ST STM32MP25 PCIe drivers
> 
> Error/Warning (recently discovered and may have been fixed):
> 
>     https://lore.kernel.org/oe-kbuild-all/202506260920.bmQ9hQ9s-lkp@intel.com
> 
>     drivers/pci/controller/dwc/pcie-stm32.c:96:23: error: incomplete definition of type 'struct dev_pin_info'
>     drivers/pci/controller/dwc/pcie-stm32.c:96:30: error: invalid use of undefined type 'struct dev_pin_info'
> 
> Error/Warning ids grouped by kconfigs:
> 
> recent_errors
> |-- alpha-allyesconfig
> |   `-- drivers-pci-controller-dwc-pcie-stm32.c:error:invalid-use-of-undefined-type-struct-dev_pin_info
> `-- um-allmodconfig
>     `-- drivers-pci-controller-dwc-pcie-stm32.c:error:incomplete-definition-of-type-struct-dev_pin_info
> 
> elapsed time: 1952m
> 
> configs tested: 124
> configs skipped: 2
> 
> tested configs:
> alpha                             allnoconfig    gcc-15.1.0
> alpha                            allyesconfig    clang-19
> alpha                            allyesconfig    gcc-15.1.0
> arc                              allmodconfig    clang-19
> arc                              allmodconfig    gcc-15.1.0
> arc                               allnoconfig    gcc-15.1.0
> arc                              allyesconfig    clang-19
> arc                              allyesconfig    gcc-15.1.0
> arc                   randconfig-001-20250626    clang-20
> arc                   randconfig-001-20250626    gcc-12.4.0
> arc                   randconfig-002-20250626    clang-20
> arc                   randconfig-002-20250626    gcc-13.3.0
> arm                              allmodconfig    clang-19
> arm                              allmodconfig    gcc-15.1.0
> arm                               allnoconfig    clang-21
> arm                              allyesconfig    clang-19
> arm                              allyesconfig    gcc-15.1.0
> arm                   randconfig-001-20250626    clang-20
> arm                   randconfig-001-20250626    clang-21
> arm                   randconfig-002-20250626    clang-20
> arm                   randconfig-003-20250626    clang-20
> arm                   randconfig-003-20250626    gcc-10.5.0
> arm                   randconfig-004-20250626    clang-20
> arm                   randconfig-004-20250626    clang-21
> arm64                            allmodconfig    clang-19
> arm64                             allnoconfig    gcc-15.1.0
> arm64                 randconfig-001-20250626    clang-20
> arm64                 randconfig-001-20250626    clang-21
> arm64                 randconfig-002-20250626    clang-17
> arm64                 randconfig-002-20250626    clang-20
> arm64                 randconfig-003-20250626    clang-20
> arm64                 randconfig-003-20250626    gcc-8.5.0
> arm64                 randconfig-004-20250626    clang-20
> arm64                 randconfig-004-20250626    clang-21
> csky                              allnoconfig    gcc-15.1.0
> hexagon                          allmodconfig    clang-17
> hexagon                          allmodconfig    clang-19
> hexagon                           allnoconfig    clang-21
> hexagon                          allyesconfig    clang-19
> hexagon                          allyesconfig    clang-21
> i386                             allmodconfig    clang-20
> i386                             allmodconfig    gcc-12
> i386                              allnoconfig    clang-20
> i386                              allnoconfig    gcc-12
> i386                             allyesconfig    clang-20
> i386                             allyesconfig    gcc-12
> i386        buildonly-randconfig-001-20250626    clang-20
> i386        buildonly-randconfig-001-20250627    gcc-12
> i386        buildonly-randconfig-002-20250626    clang-20
> i386        buildonly-randconfig-002-20250627    gcc-12
> i386        buildonly-randconfig-003-20250626    clang-20
> i386        buildonly-randconfig-003-20250627    gcc-12
> i386        buildonly-randconfig-004-20250626    clang-20
> i386        buildonly-randconfig-004-20250627    gcc-12
> i386        buildonly-randconfig-005-20250626    clang-20
> i386        buildonly-randconfig-005-20250627    gcc-12
> i386        buildonly-randconfig-006-20250626    clang-20
> i386        buildonly-randconfig-006-20250627    gcc-12
> i386                                defconfig    clang-20
> loongarch                        allmodconfig    gcc-15.1.0
> loongarch                         allnoconfig    gcc-15.1.0
> m68k                             allmodconfig    gcc-15.1.0
> m68k                              allnoconfig    gcc-15.1.0
> m68k                             allyesconfig    gcc-15.1.0
> microblaze                       allmodconfig    gcc-15.1.0
> microblaze                        allnoconfig    gcc-15.1.0
> microblaze                       allyesconfig    gcc-15.1.0
> mips                              allnoconfig    gcc-15.1.0
> nios2                             allnoconfig    gcc-14.2.0
> nios2                             allnoconfig    gcc-15.1.0
> openrisc                          allnoconfig    clang-21
> openrisc                          allnoconfig    gcc-15.1.0
> openrisc                         allyesconfig    gcc-15.1.0
> parisc                           allmodconfig    gcc-15.1.0
> parisc                            allnoconfig    clang-21
> parisc                            allnoconfig    gcc-15.1.0
> parisc                           allyesconfig    gcc-15.1.0
> powerpc                          allmodconfig    gcc-15.1.0
> powerpc                           allnoconfig    clang-21
> powerpc                           allnoconfig    gcc-15.1.0
> powerpc                          allyesconfig    gcc-15.1.0
> riscv                            allmodconfig    gcc-15.1.0
> riscv                             allnoconfig    clang-21
> riscv                             allnoconfig    gcc-15.1.0
> riscv                            allyesconfig    gcc-15.1.0
> s390                             allmodconfig    clang-18
> s390                             allmodconfig    gcc-15.1.0
> s390                              allnoconfig    clang-21
> s390                             allyesconfig    gcc-15.1.0
> sh                               allmodconfig    gcc-15.1.0
> sh                                allnoconfig    gcc-15.1.0
> sh                               allyesconfig    gcc-15.1.0
> sparc                            allmodconfig    gcc-15.1.0
> sparc                             allnoconfig    gcc-15.1.0
> um                               allmodconfig    clang-19
> um                                allnoconfig    clang-21
> um                               allyesconfig    clang-19
> um                               allyesconfig    gcc-12
> x86_64                            allnoconfig    clang-20
> x86_64                           allyesconfig    clang-20
> x86_64      buildonly-randconfig-001-20250626    clang-20
> x86_64      buildonly-randconfig-001-20250627    clang-20
> x86_64      buildonly-randconfig-002-20250626    clang-20
> x86_64      buildonly-randconfig-002-20250627    clang-20
> x86_64      buildonly-randconfig-003-20250626    clang-20
> x86_64      buildonly-randconfig-003-20250627    clang-20
> x86_64      buildonly-randconfig-004-20250626    clang-20
> x86_64      buildonly-randconfig-004-20250627    clang-20
> x86_64      buildonly-randconfig-005-20250626    clang-20
> x86_64      buildonly-randconfig-005-20250627    clang-20
> x86_64      buildonly-randconfig-006-20250626    clang-20
> x86_64      buildonly-randconfig-006-20250627    clang-20
> x86_64                              defconfig    clang-20
> x86_64                              defconfig    gcc-11
> x86_64                                  kexec    clang-20
> x86_64                               rhel-9.4    clang-20
> x86_64                           rhel-9.4-bpf    gcc-12
> x86_64                          rhel-9.4-func    clang-20
> x86_64                    rhel-9.4-kselftests    clang-20
> x86_64                         rhel-9.4-kunit    gcc-12
> x86_64                           rhel-9.4-ltp    gcc-12
> x86_64                          rhel-9.4-rust    clang-18
> x86_64                          rhel-9.4-rust    clang-20
> xtensa                            allnoconfig    gcc-15.1.0
> 
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

