Return-Path: <linux-pci+bounces-24475-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D25A6D2C7
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 02:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDA397A6DA4
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 01:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5AE78F45;
	Mon, 24 Mar 2025 01:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="p8UX+9Qu"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F35208D0;
	Mon, 24 Mar 2025 01:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742778533; cv=none; b=J2GlaMjnIE38AydV2Y4KktrGLqOMMnklSKSgycQ3gQ1tY7ui5mcCFqqyjrZpiGhqM+lVBlM5kO9AkIrs0ITkfZQZYNDyIjLwgN3r65M6IEYwdFhFf8OG+1Q+GRZwwctqmQwSq25Chqtma8EveaBphY8m964tII//gw9F7iy+Z08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742778533; c=relaxed/simple;
	bh=xZ+pCej0n1telaaFuyKirVR02AyDzrdLROxI4LOfeZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FrtnH2kTBLbYFuAJQMMurbULQOaCDOSIMLjoIQKpetWUAzxKc3yBN9GnYaKNN0VgASZCm+aZyovNC4hi7bHjdgHOdFZ2dqPqEZ/BRl/FVt49uxvi+3Xb4Y8vB4YJfSNGJnS5dDiVW8JLBNG1wBceR658ByBSKHOzeXSMGEErY7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=p8UX+9Qu; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=HiL7gVC8MkjxpZ/3L5U1u+10daiFFSGKHJFX7rM/5xU=;
	b=p8UX+9QuFFIz3z2j97q+WvXuqAa6Ug8CrFUkDXU5RvugmBXeXQeEkgDoo82kCp
	EYT0wn5h5zoonj0BN4E/aMaAsCzncMusF6Kdl8HPZXUEmwSAAbu6CPv8FOqGGe7z
	fJTFZzkMAXQ5kwnaPoAw5s3/TsZLAUg+ROfbBsrd2lOFs=
Received: from [192.168.60.52] (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wAnFXB1sOBnVXrKBQ--.19964S2;
	Mon, 24 Mar 2025 09:08:07 +0800 (CST)
Message-ID: <5bb50ad5-5eb4-40e5-86d0-7645eab78e2b@163.com>
Date: Mon, 24 Mar 2025 09:08:05 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v6 3/5] PCI: cadence: Use common PCI host bridge APIs for
 finding the capabilities
To: kernel test robot <lkp@intel.com>, lpieralisi@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, kw@linux.com,
 manivannan.sadhasivam@linaro.org, robh@kernel.org, bhelgaas@google.com,
 jingoohan1@gmail.com, thomas.richard@bootlin.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250323164852.430546-4-18255117159@163.com>
 <202503240338.N37HXlm9-lkp@intel.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <202503240338.N37HXlm9-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wAnFXB1sOBnVXrKBQ--.19964S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAr17tF17ur1kAFy7uF4fuFg_yoWrGr48pa
	48C347GFyrXr4avwn7A3Wjvw15Kr98J347A3ykCw17ZF47ua4qgF4IyFW5KFsxCrsrKr1a
	qFW7JFyvyr1FyaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UqiihUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOhIao2fgq4vhpAABsy



On 2025/3/24 03:26, kernel test robot wrote:
> Hi Hans,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on a1cffe8cc8aef85f1b07c4464f0998b9785b795a]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Hans-Zhang/PCI-Introduce-generic-capability-search-functions/20250324-005300
> base:   a1cffe8cc8aef85f1b07c4464f0998b9785b795a
> patch link:    https://lore.kernel.org/r/20250323164852.430546-4-18255117159%40163.com
> patch subject: [v6 3/5] PCI: cadence: Use common PCI host bridge APIs for finding the capabilities
> config: riscv-randconfig-001-20250324 (https://download.01.org/0day-ci/archive/20250324/202503240338.N37HXlm9-lkp@intel.com/config)
> compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project c2692afc0a92cd5da140dfcdfff7818a5b8ce997)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250324/202503240338.N37HXlm9-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202503240338.N37HXlm9-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>     drivers/pci/controller/cadence/pcie-cadence.c:20:11: warning: variable 'val' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
>        20 |         else if (size == 1)
>           |                  ^~~~~~~~~
>     drivers/pci/controller/cadence/pcie-cadence.c:23:9: note: uninitialized use occurs here
>        23 |         return val;
>           |                ^~~
>     drivers/pci/controller/cadence/pcie-cadence.c:20:7: note: remove the 'if' if its condition is always true
>        20 |         else if (size == 1)
>           |              ^~~~~~~~~~~~~~
>        21 |                 val = readb(pcie->reg_base + where);
>     drivers/pci/controller/cadence/pcie-cadence.c:14:9: note: initialize the variable 'val' to silence this warning
>        14 |         u32 val;
>           |                ^
>           |                 = 0

Will change. u32 val = 0;

>>> drivers/pci/controller/cadence/pcie-cadence.c:28:9: error: call to undeclared function 'pci_host_bridge_find_capability'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>        28 |         return pci_host_bridge_find_capability(pcie, cdns_pcie_read_cfg, cap);
>           |                ^
>>> drivers/pci/controller/cadence/pcie-cadence.c:33:9: error: call to undeclared function 'pci_host_bridge_find_ext_capability'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>        33 |         return pci_host_bridge_find_ext_capability(pcie, cdns_pcie_read_cfg, cap);
>           |                ^
>     drivers/pci/controller/cadence/pcie-cadence.c:33:9: note: did you mean 'cdns_pcie_find_ext_capability'?
>     drivers/pci/controller/cadence/pcie-cadence.c:31:5: note: 'cdns_pcie_find_ext_capability' declared here
>        31 | u16 cdns_pcie_find_ext_capability(struct cdns_pcie *pcie, u8 cap)
>           |     ^
>        32 | {
>        33 |         return pci_host_bridge_find_ext_capability(pcie, cdns_pcie_read_cfg, cap);
>           |                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>           |                cdns_pcie_find_ext_capability
>     1 warning and 2 errors generated.
> 
> 
> vim +/pci_host_bridge_find_capability +28 drivers/pci/controller/cadence/pcie-cadence.c
> 
>      25	
>      26	u8 cdns_pcie_find_capability(struct cdns_pcie *pcie, u8 cap)
>      27	{
>    > 28		return pci_host_bridge_find_capability(pcie, cdns_pcie_read_cfg, cap);
>      29	}
>      30	
>      31	u16 cdns_pcie_find_ext_capability(struct cdns_pcie *pcie, u8 cap)
>      32	{
>    > 33		return pci_host_bridge_find_ext_capability(pcie, cdns_pcie_read_cfg, cap);
>      34	}
>      35	
> 


