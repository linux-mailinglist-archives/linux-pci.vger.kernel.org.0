Return-Path: <linux-pci+bounces-34759-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CC1B36AD3
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 16:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2C1194E233F
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 14:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E6433439F;
	Tue, 26 Aug 2025 14:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="AO0hJOm8"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47EF2459F3;
	Tue, 26 Aug 2025 14:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756219084; cv=none; b=OCJUSkvo+3kvK3RDpFWnGiEG9apOgnlm3kcaxXT6aOp1kLQW8+FNRPer50kCYjjuvTq1ym6gmsoq+cPe9ajNdZLiPxtmPJ/T+Sg9wMld51/YLrUTeyGGQF81fU55h10lkX1gyYRCA1anbQQL65eiD7fdHAAwqJgVMdy36kPyFCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756219084; c=relaxed/simple;
	bh=hM+6gkzBaai1dWZ9Ob813J9OTCjHBpoCFayMGe7qMFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZJFUCkKL8vi4gQTLpSupG1iw92BgCCK1RAt8xgMzOtfWrNeSHqcOtxknHyctgYwtWpNvC09iJAiSRBXEUYq5fMY9QmjjNEiXdiSHupQAomGDM9AcoLH7J82XnwkRaMnqO7cxjpiwq584ZXtTMKGinHABoIzAg09HJzhU5GctxKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=AO0hJOm8; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=sqXckzOmh/68z4LcKwZVde4qr+TsF/S8+s2vaxQoMQk=;
	b=AO0hJOm8p0rqLxEt5iuTaRQbA/rggd3v09ib/r/eZFkVCJ9YDUemmcYo3VG6zE
	SWQlaOwx1wJjZBIuyXd5sOyTSYrwvLfHIWpDxxIaR66MaAnOI9dxjC0ZQY4QRlOM
	iXuWAP4L1Aobragt7LtWGPmvmZKpwcDTjiUIshLmCjLOg=
Received: from [IPV6:240e:b8f:919b:3100:3980:6173:5059:2d2a] (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wA3lqubxq1o6BoAEg--.2040S2;
	Tue, 26 Aug 2025 22:37:16 +0800 (CST)
Message-ID: <04d5380f-58fb-4146-a353-13c9f27f8af7@163.com>
Date: Tue, 26 Aug 2025 22:37:16 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: endpoint: Implement capability search using PCI
 core APIs
To: kernel test robot <lkp@intel.com>, lpieralisi@kernel.org,
 kwilczynski@kernel.org, bhelgaas@google.com, helgaas@kernel.org,
 jingoohan1@gmail.com, mani@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, robh@kernel.org,
 ilpo.jarvinen@linux.intel.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250819145828.438541-1-18255117159@163.com>
 <202508261929.5s2blqmA-lkp@intel.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <202508261929.5s2blqmA-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA3lqubxq1o6BoAEg--.2040S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuF1kWF1Utr45Gr1UJw1rXrb_yoW5Ww4Dpa
	y5JFyayrWkJr4rXanFq3ZYkw1ayFs8A3y3Ca95G3WxZF17ZF9rKr10kFy7KFy7tr4qgrWr
	KrW2qFn3urs8A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U5nYwUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWw61o2itwup5zwAAsY

Hi，

Please ignore it because there is no problem compiling in this branch. 
And it depends on this series.

https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=capability-search


Best regards,
Hans

On 2025/8/26 19:58, kernel test robot wrote:
> Hi Hans,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on 8742b2d8935f476449ef37e263bc4da3295c7b58]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Hans-Zhang/PCI-endpoint-Implement-capability-search-using-PCI-core-APIs/20250819-231353
> base:   8742b2d8935f476449ef37e263bc4da3295c7b58
> patch link:    https://lore.kernel.org/r/20250819145828.438541-1-18255117159%40163.com
> patch subject: [PATCH v2] PCI: endpoint: Implement capability search using PCI core APIs
> config: x86_64-randconfig-002-20250826 (https://download.01.org/0day-ci/archive/20250826/202508261929.5s2blqmA-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250826/202508261929.5s2blqmA-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202508261929.5s2blqmA-lkp@intel.com/
> 
> All error/warnings (new ones prefixed by >>):
> 
>     drivers/pci/controller/dwc/pcie-designware-ep.c: In function 'dw_pcie_ep_find_capability':
>>> drivers/pci/controller/dwc/pcie-designware-ep.c:74:16: error: implicit declaration of function 'PCI_FIND_NEXT_CAP' [-Werror=implicit-function-declaration]
>        74 |         return PCI_FIND_NEXT_CAP(dw_pcie_ep_read_cfg, PCI_CAPABILITY_LIST,
>           |                ^~~~~~~~~~~~~~~~~
>>> drivers/pci/controller/dwc/pcie-designware-ep.c:74:34: error: 'dw_pcie_ep_read_cfg' undeclared (first use in this function); did you mean 'dw_pcie_ep_read_dbi'?
>        74 |         return PCI_FIND_NEXT_CAP(dw_pcie_ep_read_cfg, PCI_CAPABILITY_LIST,
>           |                                  ^~~~~~~~~~~~~~~~~~~
>           |                                  dw_pcie_ep_read_dbi
>     drivers/pci/controller/dwc/pcie-designware-ep.c:74:34: note: each undeclared identifier is reported only once for each function it appears in
>>> drivers/pci/controller/dwc/pcie-designware-ep.c:76:1: warning: control reaches end of non-void function [-Wreturn-type]
>        76 | }
>           | ^
>     cc1: some warnings being treated as errors
> 
> 
> vim +/PCI_FIND_NEXT_CAP +74 drivers/pci/controller/dwc/pcie-designware-ep.c
> 
>      71	
>      72	static u8 dw_pcie_ep_find_capability(struct dw_pcie_ep *ep, u8 func_no, u8 cap)
>      73	{
>    > 74		return PCI_FIND_NEXT_CAP(dw_pcie_ep_read_cfg, PCI_CAPABILITY_LIST,
>      75					 cap, ep, func_no);
>    > 76	}
>      77	
> 


