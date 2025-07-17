Return-Path: <linux-pci+bounces-32351-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D70B084A0
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 08:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8032F4A1847
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 06:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3231FDE14;
	Thu, 17 Jul 2025 06:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="umAtp7Fi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E421FCD1F
	for <linux-pci@vger.kernel.org>; Thu, 17 Jul 2025 06:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752732651; cv=none; b=cvOlLEegMCqP8DV0d+wuzO0lS1gBwR3L8pV4WUG3zO0JZM7XPrVeKekgdmvv22Sz7oz82bStswOl/JxhAQcDk4eM4ppYGHBHXpP4vUGO5FMR0YEF08JvJgTQ3lRvyrBZoDx0Yl/DBX4gsieGT/6sFj0BN0yQm3zcjGOtqZ+OGIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752732651; c=relaxed/simple;
	bh=QG+48PXbmVszOQi4kb8cOkCE/o1MUnweXS1C0ATVUog=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qVq9cv1PyPGdnKVodpeAKovQuq4XQu0jAjSUDEpjKKSjnMhn5yd6ET73o7+9vUBsuRSVcFiYs+8EJbW1avmigIRfihiVG3m8ajEiZl3U9+s1x1vcmIGClBnU+psGaQxtqIfGMcHkOtGHrmjBNoOf76jMwtRIfNJcOF8uow6Fen8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=umAtp7Fi; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56H4okrg008376;
	Thu, 17 Jul 2025 08:10:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	NGJtRGnAtRzGy3yHMtC4eVuqs6SIVCU4GpRn1D/WfwE=; b=umAtp7Fid9WkgJV8
	inGQml9Z4JRTFTnIS1uvCcUKYqSH/nOkmNQ6zBatdwq2iY2T4vue2708MBauHI4U
	N/0hPRwTkeK462LJDCikhGJmUHCHh7cKxe47XJfNsDsvdtKCkE0mfC9/rknETVmA
	zAMOSvMCXnVZJYABkZ/70RgLEcankAoPvkvZIhERWM8iPmwggl3qWVuKbXE1c1v5
	pDE9bnA0qnAIUkaUpX5VZI4QiaJSvogVZlei11iNxbn+KBkdCV6WJaxKam/8KbaY
	pgUk/FMr/jJPJV42rrBtk1gNwu+Q0LD9kS3v8Ohy1YtCtHXrqD/4tO8k9ttECCdZ
	/aQAlw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 47v195kk9t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 08:10:31 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 20C8E40045;
	Thu, 17 Jul 2025 08:09:58 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AA6157CE0E9;
	Thu, 17 Jul 2025 08:09:44 +0200 (CEST)
Received: from [10.130.77.120] (10.130.77.120) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Jul
 2025 08:09:44 +0200
Message-ID: <5c3a9a27-f0d7-4f19-acd7-f93efefe3eff@foss.st.com>
Date: Thu, 17 Jul 2025 08:09:42 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [pci:controller/dwc-stm32] BUILD REGRESSION
 5a972a01e24b278f7302a834c6eaee5bdac12843
To: Bjorn Helgaas <helgaas@kernel.org>,
        Manivannan Sadhasivam
	<mani@kernel.org>
CC: <linux-pci@vger.kernel.org>
References: <20250716192418.GA2550861@bhelgaas>
From: Christian Bruel <christian.bruel@foss.st.com>
Content-Language: en-US
In-Reply-To: <20250716192418.GA2550861@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-16_02,2025-03-28_01

Hi Bjorn,

The fixing patch

https://lore.kernel.org/linux-pci/20250626181537.1872159-1-christian.bruel@foss.st.com/

is still pending for review, I will ping the pinctrl maintainer.

thank you

Christian

On 7/16/25 21:24, Bjorn Helgaas wrote:
> We have the pci/controller/dwc-stm32 branch pending, which currently
> looks like this:
> 
>    https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git/log/?h=controller/dwc-stm32&id=5a972a01e24b
> 
> which is identical to the 5a972a01e24b HEAD mentioned below.  This
> build error is why I haven't included pci/controller/dwc-stm32 in
> pci/next yet.
> 
> I would like to get this branch included for v6.17, but we need to
> resolve this somehow.
> 
> On Fri, Jun 27, 2025 at 06:10:31AM +0800, kernel test robot wrote:
>> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-stm32
>> branch HEAD: 5a972a01e24b278f7302a834c6eaee5bdac12843  MAINTAINERS: add entry for ST STM32MP25 PCIe drivers
>>
>> Error/Warning (recently discovered and may have been fixed):
>>
>>      https://lore.kernel.org/oe-kbuild-all/202506260920.bmQ9hQ9s-lkp@intel.com
>>
>>      drivers/pci/controller/dwc/pcie-stm32.c:96:23: error: incomplete definition of type 'struct dev_pin_info'
>>      drivers/pci/controller/dwc/pcie-stm32.c:96:30: error: invalid use of undefined type 'struct dev_pin_info'
>>
>> Error/Warning ids grouped by kconfigs:
>>
>> recent_errors
>> |-- alpha-allyesconfig
>> |   `-- drivers-pci-controller-dwc-pcie-stm32.c:error:invalid-use-of-undefined-type-struct-dev_pin_info
>> `-- um-allmodconfig
>>      `-- drivers-pci-controller-dwc-pcie-stm32.c:error:incomplete-definition-of-type-struct-dev_pin_info
>>
>> elapsed time: 1952m
>>
>> configs tested: 124
>> configs skipped: 2
>>
>> tested configs:
>> alpha                             allnoconfig    gcc-15.1.0
>> alpha                            allyesconfig    clang-19
>> alpha                            allyesconfig    gcc-15.1.0
>> arc                              allmodconfig    clang-19
>> arc                              allmodconfig    gcc-15.1.0
>> arc                               allnoconfig    gcc-15.1.0
>> arc                              allyesconfig    clang-19
>> arc                              allyesconfig    gcc-15.1.0
>> arc                   randconfig-001-20250626    clang-20
>> arc                   randconfig-001-20250626    gcc-12.4.0
>> arc                   randconfig-002-20250626    clang-20
>> arc                   randconfig-002-20250626    gcc-13.3.0
>> arm                              allmodconfig    clang-19
>> arm                              allmodconfig    gcc-15.1.0
>> arm                               allnoconfig    clang-21
>> arm                              allyesconfig    clang-19
>> arm                              allyesconfig    gcc-15.1.0
>> arm                   randconfig-001-20250626    clang-20
>> arm                   randconfig-001-20250626    clang-21
>> arm                   randconfig-002-20250626    clang-20
>> arm                   randconfig-003-20250626    clang-20
>> arm                   randconfig-003-20250626    gcc-10.5.0
>> arm                   randconfig-004-20250626    clang-20
>> arm                   randconfig-004-20250626    clang-21
>> arm64                            allmodconfig    clang-19
>> arm64                             allnoconfig    gcc-15.1.0
>> arm64                 randconfig-001-20250626    clang-20
>> arm64                 randconfig-001-20250626    clang-21
>> arm64                 randconfig-002-20250626    clang-17
>> arm64                 randconfig-002-20250626    clang-20
>> arm64                 randconfig-003-20250626    clang-20
>> arm64                 randconfig-003-20250626    gcc-8.5.0
>> arm64                 randconfig-004-20250626    clang-20
>> arm64                 randconfig-004-20250626    clang-21
>> csky                              allnoconfig    gcc-15.1.0
>> hexagon                          allmodconfig    clang-17
>> hexagon                          allmodconfig    clang-19
>> hexagon                           allnoconfig    clang-21
>> hexagon                          allyesconfig    clang-19
>> hexagon                          allyesconfig    clang-21
>> i386                             allmodconfig    clang-20
>> i386                             allmodconfig    gcc-12
>> i386                              allnoconfig    clang-20
>> i386                              allnoconfig    gcc-12
>> i386                             allyesconfig    clang-20
>> i386                             allyesconfig    gcc-12
>> i386        buildonly-randconfig-001-20250626    clang-20
>> i386        buildonly-randconfig-001-20250627    gcc-12
>> i386        buildonly-randconfig-002-20250626    clang-20
>> i386        buildonly-randconfig-002-20250627    gcc-12
>> i386        buildonly-randconfig-003-20250626    clang-20
>> i386        buildonly-randconfig-003-20250627    gcc-12
>> i386        buildonly-randconfig-004-20250626    clang-20
>> i386        buildonly-randconfig-004-20250627    gcc-12
>> i386        buildonly-randconfig-005-20250626    clang-20
>> i386        buildonly-randconfig-005-20250627    gcc-12
>> i386        buildonly-randconfig-006-20250626    clang-20
>> i386        buildonly-randconfig-006-20250627    gcc-12
>> i386                                defconfig    clang-20
>> loongarch                        allmodconfig    gcc-15.1.0
>> loongarch                         allnoconfig    gcc-15.1.0
>> m68k                             allmodconfig    gcc-15.1.0
>> m68k                              allnoconfig    gcc-15.1.0
>> m68k                             allyesconfig    gcc-15.1.0
>> microblaze                       allmodconfig    gcc-15.1.0
>> microblaze                        allnoconfig    gcc-15.1.0
>> microblaze                       allyesconfig    gcc-15.1.0
>> mips                              allnoconfig    gcc-15.1.0
>> nios2                             allnoconfig    gcc-14.2.0
>> nios2                             allnoconfig    gcc-15.1.0
>> openrisc                          allnoconfig    clang-21
>> openrisc                          allnoconfig    gcc-15.1.0
>> openrisc                         allyesconfig    gcc-15.1.0
>> parisc                           allmodconfig    gcc-15.1.0
>> parisc                            allnoconfig    clang-21
>> parisc                            allnoconfig    gcc-15.1.0
>> parisc                           allyesconfig    gcc-15.1.0
>> powerpc                          allmodconfig    gcc-15.1.0
>> powerpc                           allnoconfig    clang-21
>> powerpc                           allnoconfig    gcc-15.1.0
>> powerpc                          allyesconfig    gcc-15.1.0
>> riscv                            allmodconfig    gcc-15.1.0
>> riscv                             allnoconfig    clang-21
>> riscv                             allnoconfig    gcc-15.1.0
>> riscv                            allyesconfig    gcc-15.1.0
>> s390                             allmodconfig    clang-18
>> s390                             allmodconfig    gcc-15.1.0
>> s390                              allnoconfig    clang-21
>> s390                             allyesconfig    gcc-15.1.0
>> sh                               allmodconfig    gcc-15.1.0
>> sh                                allnoconfig    gcc-15.1.0
>> sh                               allyesconfig    gcc-15.1.0
>> sparc                            allmodconfig    gcc-15.1.0
>> sparc                             allnoconfig    gcc-15.1.0
>> um                               allmodconfig    clang-19
>> um                                allnoconfig    clang-21
>> um                               allyesconfig    clang-19
>> um                               allyesconfig    gcc-12
>> x86_64                            allnoconfig    clang-20
>> x86_64                           allyesconfig    clang-20
>> x86_64      buildonly-randconfig-001-20250626    clang-20
>> x86_64      buildonly-randconfig-001-20250627    clang-20
>> x86_64      buildonly-randconfig-002-20250626    clang-20
>> x86_64      buildonly-randconfig-002-20250627    clang-20
>> x86_64      buildonly-randconfig-003-20250626    clang-20
>> x86_64      buildonly-randconfig-003-20250627    clang-20
>> x86_64      buildonly-randconfig-004-20250626    clang-20
>> x86_64      buildonly-randconfig-004-20250627    clang-20
>> x86_64      buildonly-randconfig-005-20250626    clang-20
>> x86_64      buildonly-randconfig-005-20250627    clang-20
>> x86_64      buildonly-randconfig-006-20250626    clang-20
>> x86_64      buildonly-randconfig-006-20250627    clang-20
>> x86_64                              defconfig    clang-20
>> x86_64                              defconfig    gcc-11
>> x86_64                                  kexec    clang-20
>> x86_64                               rhel-9.4    clang-20
>> x86_64                           rhel-9.4-bpf    gcc-12
>> x86_64                          rhel-9.4-func    clang-20
>> x86_64                    rhel-9.4-kselftests    clang-20
>> x86_64                         rhel-9.4-kunit    gcc-12
>> x86_64                           rhel-9.4-ltp    gcc-12
>> x86_64                          rhel-9.4-rust    clang-18
>> x86_64                          rhel-9.4-rust    clang-20
>> xtensa                            allnoconfig    gcc-15.1.0
>>
>> --
>> 0-DAY CI Kernel Test Service
>> https://github.com/intel/lkp-tests/wiki

