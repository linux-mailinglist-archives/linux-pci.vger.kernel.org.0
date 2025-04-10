Return-Path: <linux-pci+bounces-25612-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D355CA83A09
	for <lists+linux-pci@lfdr.de>; Thu, 10 Apr 2025 08:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E89A1B68307
	for <lists+linux-pci@lfdr.de>; Thu, 10 Apr 2025 06:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E3B204859;
	Thu, 10 Apr 2025 06:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="L6VhcyBo"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181D920468C;
	Thu, 10 Apr 2025 06:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744268265; cv=none; b=WXpMJsJNJg9mjaVIu+ami/sSTWJGhZgpIWmD4W5CyvvVrhF8Y2BofaNPyNTGh2TMA/856XJN3tezGZnYvnvI9zyMsX8lmtOp6Oi+w4+1Hvy0mntpCI9G9pGOPT/YHIw6eQa7tZjVTJDtozp9Er4/uwPpDkeKPybzag1LhVPV0Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744268265; c=relaxed/simple;
	bh=oyIr5iTfb5YM9mIuiyQYpeUKyglx6GScjq9LoFWefQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EFGNuCfgh8UU5oCamFCpEdFKPt6I14XjUBrQkQGSlEppdb30KLH321ZDTUicdslSfjTTX6RFJRfHKiv5e7TyLRBOECJ9vpT9rAShwm2Mv/siIpj0Q1SckaXqLDUwjgnHK1ZsOs4mM+kn9bzGiF4hEg4hwWjmfPKxbf2SvvBAH5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=L6VhcyBo; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=37p8BZ/65Jkyek9wSY796hP1q62D7VjD6me8lvqHT1s=;
	b=L6VhcyBoKkGDBvZcAGTYPoDplpksaObP0Jt7OPZVGnj3eh+AnwOeNUizpjW4/n
	esKJAcTqIWFm1y+LrkNNZ/mZOVYKVoIIf5tRzpKx7TJ75+ka+oponZ93k8K8P6R1
	PjiVpaVatP/dM8HCdrTME/cb6FZO73fy32ysRt2XGms+k=
Received: from [192.168.142.52] (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDnVwmwa_dnW6O2FQ--.53411S2;
	Thu, 10 Apr 2025 14:56:49 +0800 (CST)
Message-ID: <085d0e48-436d-46af-8bdf-8477169e8939@163.com>
Date: Thu, 10 Apr 2025 14:56:48 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 4/6] PCI: dwc: Use common PCI host bridge APIs for
 finding the capabilities
To: kernel test robot <lkp@intel.com>, lpieralisi@kernel.org,
 bhelgaas@google.com
Cc: oe-kbuild-all@lists.linux.dev, kw@linux.com,
 manivannan.sadhasivam@linaro.org, ilpo.jarvinen@linux.intel.com,
 robh@kernel.org, jingoohan1@gmail.com, thomas.richard@bootlin.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250409034156.92686-5-18255117159@163.com>
 <202504101228.CX8tAgfW-lkp@intel.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <202504101228.CX8tAgfW-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wDnVwmwa_dnW6O2FQ--.53411S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAr17tF17ur17Xr4fWrW3Wrg_yoW5tFy7pr
	W7Jr1DAFyrGFn0gws7ZFy2vw17JFsrGw13AF4rW34fCFW7uryqk34F9Fy5GrnrCF1ak3W5
	urWDtas5tw4xZaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UQYFAUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOgwro2f3WO-kyAABs0



On 2025/4/10 14:02, kernel test robot wrote:
> Hi Hans,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on a24588245776dafc227243a01bfbeb8a59bafba9]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Hans-Zhang/PCI-Introduce-generic-bus-config-read-helper-function/20250409-115839
> base:   a24588245776dafc227243a01bfbeb8a59bafba9
> patch link:    https://lore.kernel.org/r/20250409034156.92686-5-18255117159%40163.com
> patch subject: [PATCH v9 4/6] PCI: dwc: Use common PCI host bridge APIs for finding the capabilities
> config: arc-randconfig-001-20250410 (https://download.01.org/0day-ci/archive/20250410/202504101228.CX8tAgfW-lkp@intel.com/config)
> compiler: arc-linux-gcc (GCC) 14.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250410/202504101228.CX8tAgfW-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202504101228.CX8tAgfW-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>     drivers/pci/controller/dwc/pcie-designware.c: In function '__dw_pcie_find_vsec_capability':
>>> drivers/pci/controller/dwc/pcie-designware.c:239:24: error: implicit declaration of function 'dw_pcie_find_next_ext_capability'; did you mean 'pci_find_next_ext_capability'? [-Wimplicit-function-declaration]
>       239 |         while ((vsec = dw_pcie_find_next_ext_capability(pci, vsec,
>           |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>           |                        pci_find_next_ext_capability
> 
> 
> vim +239 drivers/pci/controller/dwc/pcie-designware.c
> 
> 5b0841fa653f6c Vidya Sagar  2019-08-13  229
> efaf16de43f599 Shradha Todi 2025-02-21  230  static u16 __dw_pcie_find_vsec_capability(struct dw_pcie *pci, u16 vendor_id,
> efaf16de43f599 Shradha Todi 2025-02-21  231  					  u16 vsec_id)
> efaf16de43f599 Shradha Todi 2025-02-21  232  {
> efaf16de43f599 Shradha Todi 2025-02-21  233  	u16 vsec = 0;
> efaf16de43f599 Shradha Todi 2025-02-21  234  	u32 header;
> efaf16de43f599 Shradha Todi 2025-02-21  235
> efaf16de43f599 Shradha Todi 2025-02-21  236  	if (vendor_id != dw_pcie_readw_dbi(pci, PCI_VENDOR_ID))
> efaf16de43f599 Shradha Todi 2025-02-21  237  		return 0;
> efaf16de43f599 Shradha Todi 2025-02-21  238
> efaf16de43f599 Shradha Todi 2025-02-21 @239  	while ((vsec = dw_pcie_find_next_ext_capability(pci, vsec,
> efaf16de43f599 Shradha Todi 2025-02-21  240  						       PCI_EXT_CAP_ID_VNDR))) {
> efaf16de43f599 Shradha Todi 2025-02-21  241  		header = dw_pcie_readl_dbi(pci, vsec + PCI_VNDR_HEADER);
> efaf16de43f599 Shradha Todi 2025-02-21  242  		if (PCI_VNDR_HEADER_ID(header) == vsec_id)
> efaf16de43f599 Shradha Todi 2025-02-21  243  			return vsec;
> efaf16de43f599 Shradha Todi 2025-02-21  244  	}
> efaf16de43f599 Shradha Todi 2025-02-21  245
> efaf16de43f599 Shradha Todi 2025-02-21  246  	return 0;
> efaf16de43f599 Shradha Todi 2025-02-21  247  }
> efaf16de43f599 Shradha Todi 2025-02-21  248
> 
I'm terribly sorry. The latest 6.15 rc1 merge 
__dw_pcie_find_vsec_capability, which uses 
dw_pcie_find_next_ext_capability. This should be replaced with 
PCI_FIND_NEXT_CAP_TTL.

This will be changed in the next version.

Best regards,
Hans


