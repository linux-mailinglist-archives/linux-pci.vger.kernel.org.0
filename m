Return-Path: <linux-pci+bounces-38370-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 722C5BE48C6
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 18:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21F535E5B25
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 16:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B903329C7E;
	Thu, 16 Oct 2025 16:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jSagYZ9i"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DF72FCC16
	for <linux-pci@vger.kernel.org>; Thu, 16 Oct 2025 16:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760631520; cv=none; b=qZbTl1jMyGwAG86WxPA0x+lWyshvl3VKLQkTxhM49TSqACFlwohtKM0QjowOph8R8+a7K2ORdiNn8m32nWMu//fvbl6Z2oQBq/En5sQeg291sZrvsFmBpdbP+gDUW/zZux7H5NxU7mZxNNhDkC7tQoHJakx/qSw99tjWAmaaEdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760631520; c=relaxed/simple;
	bh=kMjPTqPwlxPMHc8okI3f8OS2q6+Mz4OxOXVtaQKco6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K6S4ckgaZKwH20rkJWme6LbTf8kpia4DR96uW8IoEzzw498S5Sh84N8pkhxZOvagcHsdkd6cN5AzToGqySlF0JBUhzwEpr9+xP6+flg6dcL5upzfzYmhEe+sCWd4+BRrIOOVxEE57P6xRcqYXB6dxXyxMqwv0rPbyn7v05qadFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jSagYZ9i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9FDEC4CEF1;
	Thu, 16 Oct 2025 16:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760631520;
	bh=kMjPTqPwlxPMHc8okI3f8OS2q6+Mz4OxOXVtaQKco6s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jSagYZ9ifJ++z84wP4NTG++RZ9mmOshrH+P7gSf6hzKpsLX54ZHONIk0GylZxq/RN
	 m1s2FJq898nadLihEhgTRuntazxcEZTcCwDdSqtY1cruAUchH5Z2T15SNiS96u2Qgd
	 kRMMQUIfyZSzOGNQ5v1NMBt1FqBTxRWIaGPjuT4JtCcqEwMf4UE+K2rBx7dNO158PF
	 gCNMoIpQsHntecW8Su+SakcEyI4NtRE6nXoeCQQmdNcaqL+PP6osB93qVwhchiS/hr
	 hRk5cM0z49Yiy19ATxLbv8mPueZ0cKpWMmaTftC0Ni4/kVKS7tJ6QSMoIc86BLCNTj
	 g6nnEUB+NZBwA==
Message-ID: <5d12ecd5-bbda-4d85-a9aa-a19078796695@kernel.org>
Date: Thu, 16 Oct 2025 11:18:38 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [pci:for-linus] BUILD REGRESSION
 f0bfeb2c51e44bee7876f2a0eda3518bd2c30a01
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20251016161559.GA987757@bhelgaas>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20251016161559.GA987757@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/16/25 11:15 AM, Bjorn Helgaas wrote:
> On Thu, Oct 16, 2025 at 07:26:50AM +0800, kernel test robot wrote:
>> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
>> branch HEAD: f0bfeb2c51e44bee7876f2a0eda3518bd2c30a01  PCI/VGA: Select SCREEN_INFO on X86
> 
> Just making sure you've seen this, Mario.  

I didn't see this, thanks for including me.
> I *think* f0bfeb2c51e4 is
> the most recent version, and it was on pci/for-linus, so I'll drop it
> for now.

Are you sure the failure is caused by "PCI/VGA: Select SCREEN_INFO on X86"?

I wouldn't expect the below error to be:

> 
>> Error/Warning ids grouped by kconfigs:
>>
>> recent_errors
>> `-- mips-allyesconfig
>>      |-- (.head.text):relocation-truncated-to-fit:R_MIPS_26-against-kernel_entry
>>      `-- (.ref.text):relocation-truncated-to-fit:R_MIPS_26-against-start_secondary
>>
>> elapsed time: 1447m
>>
>> configs tested: 297
>> configs skipped: 5
>>
>> tested configs:
>> alpha                             allnoconfig    clang-22
>> alpha                             allnoconfig    gcc-15.1.0
>> alpha                            allyesconfig    clang-19
>> alpha                            allyesconfig    gcc-15.1.0
>> alpha                               defconfig    clang-19
>> arc                              allmodconfig    clang-19
>> arc                              allmodconfig    gcc-15.1.0
>> arc                               allnoconfig    clang-22
>> arc                               allnoconfig    gcc-15.1.0
>> arc                              allyesconfig    clang-19
>> arc                              allyesconfig    gcc-15.1.0
>> arc                                 defconfig    clang-19
>> arc                   randconfig-001-20251015    gcc-8.5.0
>> arc                   randconfig-001-20251016    clang-22
>> arc                   randconfig-002-20251015    gcc-8.5.0
>> arc                   randconfig-002-20251016    clang-22
>> arm                              allmodconfig    clang-19
>> arm                              allmodconfig    gcc-15.1.0
>> arm                               allnoconfig    clang-22
>> arm                              allyesconfig    clang-19
>> arm                              allyesconfig    gcc-15.1.0
>> arm                       aspeed_g5_defconfig    clang-22
>> arm                        clps711x_defconfig    gcc-15.1.0
>> arm                                 defconfig    clang-19
>> arm                          ep93xx_defconfig    clang-22
>> arm                             mxs_defconfig    clang-22
>> arm                          pxa168_defconfig    gcc-15.1.0
>> arm                   randconfig-001-20251015    clang-22
>> arm                   randconfig-001-20251015    gcc-8.5.0
>> arm                   randconfig-001-20251016    clang-22
>> arm                   randconfig-002-20251015    clang-22
>> arm                   randconfig-002-20251015    gcc-8.5.0
>> arm                   randconfig-002-20251016    clang-22
>> arm                   randconfig-003-20251015    gcc-8.5.0
>> arm                   randconfig-003-20251016    clang-22
>> arm                   randconfig-004-20251015    clang-22
>> arm                   randconfig-004-20251015    gcc-8.5.0
>> arm                   randconfig-004-20251016    clang-22
>> arm64                            allmodconfig    clang-19
>> arm64                             allnoconfig    clang-22
>> arm64                             allnoconfig    gcc-15.1.0
>> arm64                               defconfig    clang-19
>> arm64                 randconfig-001-20251015    clang-22
>> arm64                 randconfig-001-20251015    gcc-8.5.0
>> arm64                 randconfig-001-20251016    clang-22
>> arm64                 randconfig-002-20251015    gcc-13.4.0
>> arm64                 randconfig-002-20251015    gcc-8.5.0
>> arm64                 randconfig-002-20251016    clang-22
>> arm64                 randconfig-003-20251015    clang-22
>> arm64                 randconfig-003-20251015    gcc-8.5.0
>> arm64                 randconfig-003-20251016    clang-22
>> arm64                 randconfig-004-20251015    clang-22
>> arm64                 randconfig-004-20251015    gcc-8.5.0
>> arm64                 randconfig-004-20251016    clang-22
>> csky                              allnoconfig    clang-22
>> csky                              allnoconfig    gcc-15.1.0
>> csky                                defconfig    clang-19
>> csky                  randconfig-001-20251015    clang-22
>> csky                  randconfig-001-20251015    gcc-15.1.0
>> csky                  randconfig-002-20251015    clang-22
>> csky                  randconfig-002-20251015    gcc-9.5.0
>> hexagon                          allmodconfig    clang-17
>> hexagon                          allmodconfig    clang-19
>> hexagon                           allnoconfig    clang-22
>> hexagon                          allyesconfig    clang-19
>> hexagon                          allyesconfig    clang-22
>> hexagon                             defconfig    clang-19
>> hexagon               randconfig-001-20251015    clang-22
>> hexagon               randconfig-002-20251015    clang-19
>> hexagon               randconfig-002-20251015    clang-22
>> i386                             allmodconfig    clang-20
>> i386                             allmodconfig    gcc-14
>> i386                              allnoconfig    clang-20
>> i386                              allnoconfig    gcc-14
>> i386                             allyesconfig    clang-20
>> i386                             allyesconfig    gcc-14
>> i386        buildonly-randconfig-001-20251015    clang-20
>> i386        buildonly-randconfig-001-20251015    gcc-13
>> i386        buildonly-randconfig-001-20251016    clang-20
>> i386        buildonly-randconfig-002-20251015    clang-20
>> i386        buildonly-randconfig-002-20251015    gcc-14
>> i386        buildonly-randconfig-002-20251016    clang-20
>> i386        buildonly-randconfig-003-20251015    clang-20
>> i386        buildonly-randconfig-003-20251016    clang-20
>> i386        buildonly-randconfig-004-20251015    clang-20
>> i386        buildonly-randconfig-004-20251016    clang-20
>> i386        buildonly-randconfig-005-20251015    clang-20
>> i386        buildonly-randconfig-005-20251016    clang-20
>> i386        buildonly-randconfig-006-20251015    clang-20
>> i386        buildonly-randconfig-006-20251016    clang-20
>> i386                                defconfig    clang-20
>> i386                  randconfig-001-20251015    clang-20
>> i386                  randconfig-001-20251016    clang-20
>> i386                  randconfig-002-20251015    clang-20
>> i386                  randconfig-002-20251016    clang-20
>> i386                  randconfig-003-20251015    clang-20
>> i386                  randconfig-003-20251016    clang-20
>> i386                  randconfig-004-20251015    clang-20
>> i386                  randconfig-004-20251016    clang-20
>> i386                  randconfig-005-20251015    clang-20
>> i386                  randconfig-005-20251016    clang-20
>> i386                  randconfig-006-20251015    clang-20
>> i386                  randconfig-006-20251016    clang-20
>> i386                  randconfig-007-20251015    clang-20
>> i386                  randconfig-007-20251016    clang-20
>> i386                  randconfig-011-20251015    clang-20
>> i386                  randconfig-011-20251016    gcc-14
>> i386                  randconfig-012-20251015    clang-20
>> i386                  randconfig-012-20251016    gcc-14
>> i386                  randconfig-013-20251015    clang-20
>> i386                  randconfig-013-20251016    gcc-14
>> i386                  randconfig-014-20251015    clang-20
>> i386                  randconfig-014-20251016    gcc-14
>> i386                  randconfig-015-20251015    clang-20
>> i386                  randconfig-015-20251016    gcc-14
>> i386                  randconfig-016-20251015    clang-20
>> i386                  randconfig-016-20251016    gcc-14
>> i386                  randconfig-017-20251015    clang-20
>> i386                  randconfig-017-20251016    gcc-14
>> loongarch                        allmodconfig    clang-19
>> loongarch                         allnoconfig    clang-22
>> loongarch                           defconfig    clang-19
>> loongarch             randconfig-001-20251015    clang-22
>> loongarch             randconfig-001-20251015    gcc-15.1.0
>> loongarch             randconfig-002-20251015    clang-22
>> loongarch             randconfig-002-20251015    gcc-15.1.0
>> m68k                             allmodconfig    clang-19
>> m68k                             allmodconfig    gcc-15.1.0
>> m68k                              allnoconfig    gcc-15.1.0
>> m68k                             allyesconfig    clang-19
>> m68k                             allyesconfig    gcc-15.1.0
>> m68k                                defconfig    clang-19
>> microblaze                       allmodconfig    clang-19
>> microblaze                       allmodconfig    gcc-15.1.0
>> microblaze                        allnoconfig    gcc-15.1.0
>> microblaze                       allyesconfig    clang-19
>> microblaze                       allyesconfig    gcc-15.1.0
>> microblaze                          defconfig    gcc-15.1.0
>> mips                              allnoconfig    gcc-15.1.0
>> nios2                             allnoconfig    gcc-11.5.0
>> nios2                             allnoconfig    gcc-15.1.0
>> nios2                               defconfig    gcc-11.5.0
>> nios2                               defconfig    gcc-15.1.0
>> nios2                 randconfig-001-20251015    clang-22
>> nios2                 randconfig-001-20251015    gcc-8.5.0
>> nios2                 randconfig-002-20251015    clang-22
>> nios2                 randconfig-002-20251015    gcc-8.5.0
>> openrisc                          allnoconfig    clang-22
>> openrisc                          allnoconfig    gcc-15.1.0
>> openrisc                         allyesconfig    gcc-15.1.0
>> openrisc                            defconfig    gcc-14
>> parisc                           allmodconfig    gcc-15.1.0
>> parisc                            allnoconfig    clang-22
>> parisc                            allnoconfig    gcc-15.1.0
>> parisc                           allyesconfig    gcc-15.1.0
>> parisc                              defconfig    gcc-15.1.0
>> parisc                randconfig-001-20251015    clang-22
>> parisc                randconfig-001-20251015    gcc-9.5.0
>> parisc                randconfig-002-20251015    clang-22
>> parisc                randconfig-002-20251015    gcc-8.5.0
>> parisc64                            defconfig    gcc-15.1.0
>> powerpc                    adder875_defconfig    gcc-15.1.0
>> powerpc                          allmodconfig    gcc-15.1.0
>> powerpc                           allnoconfig    clang-22
>> powerpc                           allnoconfig    gcc-15.1.0
>> powerpc                          allyesconfig    clang-22
>> powerpc                          allyesconfig    gcc-15.1.0
>> powerpc                   currituck_defconfig    clang-22
>> powerpc                     mpc83xx_defconfig    clang-22
>> powerpc               randconfig-001-20251015    clang-22
>> powerpc               randconfig-001-20251015    gcc-15.1.0
>> powerpc               randconfig-002-20251015    clang-22
>> powerpc               randconfig-002-20251015    gcc-12.5.0
>> powerpc               randconfig-003-20251015    clang-22
>> powerpc                 xes_mpc85xx_defconfig    clang-22
>> powerpc64                        alldefconfig    gcc-15.1.0
>> powerpc64             randconfig-001-20251015    clang-22
>> powerpc64             randconfig-002-20251015    clang-22
>> powerpc64             randconfig-003-20251015    clang-22
>> powerpc64             randconfig-003-20251015    gcc-13.4.0
>> riscv                            allmodconfig    clang-22
>> riscv                            allmodconfig    gcc-15.1.0
>> riscv                             allnoconfig    clang-22
>> riscv                             allnoconfig    gcc-15.1.0
>> riscv                            allyesconfig    clang-16
>> riscv                            allyesconfig    gcc-15.1.0
>> riscv                               defconfig    gcc-14
>> riscv             nommu_k210_sdcard_defconfig    clang-22
>> riscv                 randconfig-001-20251015    clang-22
>> riscv                 randconfig-001-20251015    gcc-10.5.0
>> riscv                 randconfig-001-20251016    gcc-10.5.0
>> riscv                 randconfig-002-20251015    clang-22
>> riscv                 randconfig-002-20251016    gcc-10.5.0
>> s390                             allmodconfig    clang-18
>> s390                             allmodconfig    gcc-15.1.0
>> s390                              allnoconfig    clang-22
>> s390                             allyesconfig    gcc-15.1.0
>> s390                                defconfig    gcc-14
>> s390                  randconfig-001-20251015    clang-22
>> s390                  randconfig-001-20251015    gcc-12.5.0
>> s390                  randconfig-001-20251016    gcc-10.5.0
>> s390                  randconfig-002-20251015    clang-22
>> s390                  randconfig-002-20251016    gcc-10.5.0
>> sh                               allmodconfig    gcc-15.1.0
>> sh                                allnoconfig    gcc-15.1.0
>> sh                               allyesconfig    gcc-15.1.0
>> sh                                  defconfig    gcc-14
>> sh                          landisk_defconfig    gcc-15.1.0
>> sh                    randconfig-001-20251015    clang-22
>> sh                    randconfig-001-20251015    gcc-11.5.0
>> sh                    randconfig-001-20251016    gcc-10.5.0
>> sh                    randconfig-002-20251015    clang-22
>> sh                    randconfig-002-20251015    gcc-11.5.0
>> sh                    randconfig-002-20251016    gcc-10.5.0
>> sh                          rsk7269_defconfig    gcc-15.1.0
>> sh                           sh2007_defconfig    clang-22
>> sparc                            allmodconfig    gcc-15.1.0
>> sparc                             allnoconfig    gcc-15.1.0
>> sparc                               defconfig    gcc-15.1.0
>> sparc                 randconfig-001-20251015    clang-22
>> sparc                 randconfig-001-20251015    gcc-8.5.0
>> sparc                 randconfig-001-20251016    gcc-10.5.0
>> sparc                 randconfig-002-20251015    clang-22
>> sparc                 randconfig-002-20251015    gcc-13.4.0
>> sparc                 randconfig-002-20251016    gcc-10.5.0
>> sparc64                             defconfig    gcc-14
>> sparc64               randconfig-001-20251015    clang-22
>> sparc64               randconfig-001-20251016    gcc-10.5.0
>> sparc64               randconfig-002-20251015    clang-22
>> sparc64               randconfig-002-20251015    gcc-11.5.0
>> sparc64               randconfig-002-20251016    gcc-10.5.0
>> um                               allmodconfig    clang-19
>> um                                allnoconfig    clang-22
>> um                               allyesconfig    clang-19
>> um                               allyesconfig    gcc-14
>> um                                  defconfig    gcc-14
>> um                             i386_defconfig    gcc-14
>> um                    randconfig-001-20251015    clang-22
>> um                    randconfig-001-20251016    gcc-10.5.0
>> um                    randconfig-002-20251015    clang-22
>> um                    randconfig-002-20251016    gcc-10.5.0
>> um                           x86_64_defconfig    gcc-14
>> x86_64                            allnoconfig    clang-20
>> x86_64                           allyesconfig    clang-20
>> x86_64      buildonly-randconfig-001-20251015    clang-20
>> x86_64      buildonly-randconfig-001-20251015    gcc-13
>> x86_64      buildonly-randconfig-002-20251015    gcc-13
>> x86_64      buildonly-randconfig-002-20251015    gcc-14
>> x86_64      buildonly-randconfig-003-20251015    clang-20
>> x86_64      buildonly-randconfig-003-20251015    gcc-13
>> x86_64      buildonly-randconfig-004-20251015    clang-20
>> x86_64      buildonly-randconfig-004-20251015    gcc-13
>> x86_64      buildonly-randconfig-005-20251015    gcc-13
>> x86_64      buildonly-randconfig-005-20251015    gcc-14
>> x86_64      buildonly-randconfig-006-20251015    gcc-13
>> x86_64                              defconfig    clang-20
>> x86_64                              defconfig    gcc-14
>> x86_64                                  kexec    clang-20
>> x86_64                randconfig-001-20251015    clang-20
>> x86_64                randconfig-001-20251016    clang-20
>> x86_64                randconfig-002-20251015    clang-20
>> x86_64                randconfig-002-20251016    clang-20
>> x86_64                randconfig-003-20251015    clang-20
>> x86_64                randconfig-003-20251016    clang-20
>> x86_64                randconfig-004-20251015    clang-20
>> x86_64                randconfig-004-20251016    clang-20
>> x86_64                randconfig-005-20251015    clang-20
>> x86_64                randconfig-005-20251016    clang-20
>> x86_64                randconfig-006-20251015    clang-20
>> x86_64                randconfig-006-20251016    clang-20
>> x86_64                randconfig-007-20251015    clang-20
>> x86_64                randconfig-007-20251016    clang-20
>> x86_64                randconfig-008-20251015    clang-20
>> x86_64                randconfig-008-20251016    clang-20
>> x86_64                randconfig-071-20251015    gcc-14
>> x86_64                randconfig-072-20251015    gcc-14
>> x86_64                randconfig-073-20251015    gcc-14
>> x86_64                randconfig-074-20251015    gcc-14
>> x86_64                randconfig-075-20251015    gcc-14
>> x86_64                randconfig-076-20251015    gcc-14
>> x86_64                randconfig-077-20251015    gcc-14
>> x86_64                randconfig-078-20251015    gcc-14
>> x86_64                               rhel-9.4    clang-20
>> x86_64                           rhel-9.4-bpf    gcc-14
>> x86_64                          rhel-9.4-func    clang-20
>> x86_64                    rhel-9.4-kselftests    clang-20
>> x86_64                         rhel-9.4-kunit    gcc-14
>> x86_64                           rhel-9.4-ltp    gcc-14
>> x86_64                          rhel-9.4-rust    clang-20
>> xtensa                            allnoconfig    gcc-15.1.0
>> xtensa                randconfig-001-20251015    clang-22
>> xtensa                randconfig-001-20251015    gcc-9.5.0
>> xtensa                randconfig-001-20251016    gcc-10.5.0
>> xtensa                randconfig-002-20251015    clang-22
>> xtensa                randconfig-002-20251015    gcc-15.1.0
>> xtensa                randconfig-002-20251016    gcc-10.5.0
>> xtensa                    xip_kc705_defconfig    gcc-15.1.0
>>
>> --
>> 0-DAY CI Kernel Test Service
>> https://github.com/intel/lkp-tests/wiki


