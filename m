Return-Path: <linux-pci+bounces-25159-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F45A78E15
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 14:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 862A77A1DAE
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 12:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA041F3B96;
	Wed,  2 Apr 2025 12:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="p3QW2AVX"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF10E239094;
	Wed,  2 Apr 2025 12:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743596356; cv=none; b=J2xjMBDYvOX4eeA9Tf+haHeSNcBERN/Kvdqv2F0qXA8PX6gpcePoZ/W4LqnMDMfY5ud3wdPvW5LsKbyrlL/lsxzWK7eBkDqf0l+kerWMssX9rgg2owqux+YgWuIlYZ5hcSk//j+b6s94P4AhWJ/K5tiMjUjVtasKqihvjuJ6tc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743596356; c=relaxed/simple;
	bh=v9o/0GsG9hlpEVMILiuT/UXu6Gay+7R0EoqjQXNBKw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cYRkt1EL7QjRD4hwxtGNS+FAnMIfOaF505hMZUMSy/iJaBA1x+ccTPG5zqFGe/EXUnvJbQC4P3RGQDVmiNVBCx6o/MIyXRLiZ0LbnHp5SIqqxJ05lBxVPmRuvzOCMitxO6R1UWJaZZs6r/X1AlaZjLzJPudqBNP3iTsBj5yxz2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=p3QW2AVX; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=1K93p+jfwwbKax5M8o/f4XaPFLFEtqliG2k63r4obes=;
	b=p3QW2AVXL9zWuzV1dY8TkMfEAeCT3p/8khNHcr/3YBtVlrVNnqbA56Uk5aGT8c
	L8KLxkvlKSjEWI2udr55Nf9//va0LYD8e3GKX0FDOUq7/tPwo01etlwR0S3Bc/Ch
	ZEaFxorIdTmey363pUQpg/7N4d4YAuePZD+//XgyXQBDQ=
Received: from [192.168.60.52] (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3t9gUK+1nh2qGDg--.42426S2;
	Wed, 02 Apr 2025 20:18:30 +0800 (CST)
Message-ID: <ad119d32-0755-4ca1-9db8-28f6a8f17c43@163.com>
Date: Wed, 2 Apr 2025 20:18:28 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v7 3/5] PCI: dwc: Use common PCI host bridge APIs for finding
 the capabilities
To: kernel test robot <lkp@intel.com>, lpieralisi@kernel.org,
 bhelgaas@google.com
Cc: oe-kbuild-all@lists.linux.dev, kw@linux.com,
 manivannan.sadhasivam@linaro.org, ilpo.jarvinen@linux.intel.com,
 robh@kernel.org, jingoohan1@gmail.com, thomas.richard@bootlin.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250402042020.48681-4-18255117159@163.com>
 <202504021958.YeTPCsW1-lkp@intel.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <202504021958.YeTPCsW1-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3t9gUK+1nh2qGDg--.42426S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAr17tF17urW5tr1rZw13Arb_yoW5Cr4xpa
	yUAa13ZFyrJF4Sgw48t3WF93WaqF1DAry7G3ykG3W7WFy7Zry5GryIkFyagFy7tw4qgrya
	kryqq3Z7Ars8AaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07ULyCXUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDwQjo2ftJx1vAgAAsW



On 2025/4/2 19:58, kernel test robot wrote:
> Hi Hans,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on acb4f33713b9f6cadb6143f211714c343465411c]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Hans-Zhang/PCI-Refactor-capability-search-into-common-macros/20250402-122544
> base:   acb4f33713b9f6cadb6143f211714c343465411c
> patch link:    https://lore.kernel.org/r/20250402042020.48681-4-18255117159%40163.com
> patch subject: [v7 3/5] PCI: dwc: Use common PCI host bridge APIs for finding the capabilities
> config: loongarch-randconfig-001-20250402 (https://download.01.org/0day-ci/archive/20250402/202504021958.YeTPCsW1-lkp@intel.com/config)
> compiler: loongarch64-linux-gcc (GCC) 14.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250402/202504021958.YeTPCsW1-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202504021958.YeTPCsW1-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>     In file included from drivers/pci/controller/dwc/pcie-designware.c:23:
>     drivers/pci/controller/dwc/pcie-designware.c: In function 'dw_pcie_find_capability':
>>> drivers/pci/controller/dwc/pcie-designware.c:218:38: error: 'pcie' undeclared (first use in this function); did you mean 'pci'?
>       218 |                                      pcie);
>           |                                      ^~~~
>     drivers/pci/controller/dwc/../../pci.h:114:18: note: in definition of macro 'PCI_FIND_NEXT_CAP_TTL'
>       114 |         read_cfg(args, __pos, 1, (u32 *)&__pos);                        \
>           |                  ^~~~
>     drivers/pci/controller/dwc/pcie-designware.c:218:38: note: each undeclared identifier is reported only once for each function it appears in
>       218 |                                      pcie);
>           |                                      ^~~~
>     drivers/pci/controller/dwc/../../pci.h:114:18: note: in definition of macro 'PCI_FIND_NEXT_CAP_TTL'
>       114 |         read_cfg(args, __pos, 1, (u32 *)&__pos);                        \
>           |                  ^~~~
>     drivers/pci/controller/dwc/pcie-designware.c: In function 'dw_pcie_find_ext_capability':
>     drivers/pci/controller/dwc/pcie-designware.c:224:71: error: 'pcie' undeclared (first use in this function); did you mean 'pci'?
>       224 |         return PCI_FIND_NEXT_EXT_CAPABILITY(dw_pcie_read_cfg, 0, cap, pcie);
>           |                                                                       ^~~~
>     drivers/pci/controller/dwc/../../pci.h:156:34: note: in definition of macro 'PCI_FIND_NEXT_EXT_CAPABILITY'
>       156 |                 __ret = read_cfg(args, __pos, 4, &__header);                    \
>           |                                  ^~~~
> 

Copy the errors carried over. Will change.

Best regards,
Hans

> 
> vim +218 drivers/pci/controller/dwc/pcie-designware.c
> 
>     214	
>     215	u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap)
>     216	{
>     217		return PCI_FIND_NEXT_CAP_TTL(dw_pcie_read_cfg, PCI_CAPABILITY_LIST, cap,
>   > 218					     pcie);
>     219	}
>     220	EXPORT_SYMBOL_GPL(dw_pcie_find_capability);
>     221	
> 


