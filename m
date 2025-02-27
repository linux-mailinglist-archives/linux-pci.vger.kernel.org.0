Return-Path: <linux-pci+bounces-22485-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B02EA471D2
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 02:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AB9B7B0EE6
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 01:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B30E545;
	Thu, 27 Feb 2025 01:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DdXc+Zfc"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3E6139E
	for <linux-pci@vger.kernel.org>; Thu, 27 Feb 2025 01:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740621389; cv=none; b=Ei7yyOJg2vnxC/x60PW5wzZeupwRdwtYKW9c/hpa8psXXOfpta0MWVpgb6VIbRVR4V0NcoJscLExGK1BjfsOj1VHwjeRnBoxyXg5gPBtqg7VtEgpreGTtgnXps/xqJQA3AXda31ZT687CoAWYJUqR3HlioOik/V8vDCYohE4x5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740621389; c=relaxed/simple;
	bh=HkHraSNkBG0witB908xHe0iMTt4llSRgcLm0R2xs0F0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X8RnyQzwpBbKgrXx4e3ML92I90R0bdf66Cx+JcLD338hpRBA6PQfrqMUAT0/JbK54+YVLvCh5R06M5QMEsrKKvC9DgLo9yt9Dp32jE+rtIdGfCjrBLKgA8Llt4RpbX4WvFUtSBUzxG9/gYlOJbHj6xuBNjOlJluFY92psoIexa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DdXc+Zfc; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=hsf0wAjs1LaFSCmM6zgmkK97GrKVUc4D69YQ6tjwaFo=;
	b=DdXc+ZfcIp0yXkUngKGDPHwJr4hvSWft0exLI5eF1knp+KsDxPl6DCcgg/NQDP
	xujCQcSIm8u8HjiKmn31koXBjbQgntkkJDkbR8PcHqkzX74Ho3Li/4OtSzTn1scB
	uafoBWcerC30Lg4OHcBUA3h8LJeRRBM5+WKd4mU0vA7ZY=
Received: from [192.168.34.52] (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD335wmxr9nCFchPA--.27859S2;
	Thu, 27 Feb 2025 09:55:52 +0800 (CST)
Message-ID: <ef04f32a-593f-437d-8465-1634c12567ae@163.com>
Date: Thu, 27 Feb 2025 09:55:48 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [pci:controller/dwc 6/8]
 drivers/pci/controller/dwc/pcie-designware-debugfs.c:561:undefined reference
 to `dw_ltssm_sts_string'
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
References: <202502270336.4xpaTVPE-lkp@intel.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <202502270336.4xpaTVPE-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD335wmxr9nCFchPA--.27859S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZFWrKr15AFW7AF13Zr17trb_yoW8KrW7pa
	yrJay0ya10yr4fXa9rAas5uF15tanrZ3yUGayDCw17uFy2vFWxWF1fKFW3Jry7Xr4kKr45
	Ka1YvF15JF4jyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UeWl9UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWwwBo2e-wgALggABsn


On 2025/2/27 04:09, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc
> head:   b9d6619b0c3ef6ac25764ff29b08e8c1953ea83f
> commit: d4dc748566221bfdd0345c282ec82d3eee457f39 [6/8] PCI: dwc: Add debugfs property to provide LTSSM status of the PCIe link
> config: sparc64-randconfig-001-20250227 (https://download.01.org/0day-ci/archive/20250227/202502270336.4xpaTVPE-lkp@intel.com/config)

Hi Krzysztof,

sparc64-randconfig-001-20250227:

#
# DesignWare-based PCIe controllers
#
CONFIG_PCIE_DW=y
CONFIG_PCIE_DW_DEBUGFS=y
CONFIG_PCIE_DW_EP=y


Since this config is not configured with CONFIG_PCIE_DW_HOST, and the 
dw_ltssm_sts_string function is in the pci-designware-host.c, the 
following compilation error occurs.

Can you help move the dw_ltssm_sts_string function to pci-designware.c 
or pci-designware-debugfs.c?

Or should I resubmit v6 patch?

Best regards
Hans


> compiler: sparc64-linux-gcc (GCC) 14.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250227/202502270336.4xpaTVPE-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202502270336.4xpaTVPE-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>     sparc64-linux-ld: drivers/pci/controller/dwc/pcie-designware-debugfs.o: in function `dwc_pcie_ltssm_status_show':
>>> drivers/pci/controller/dwc/pcie-designware-debugfs.c:561:(.text+0x125c): undefined reference to `dw_ltssm_sts_string'
>>> sparc64-linux-ld: drivers/pci/controller/dwc/pcie-designware-debugfs.c:561:(.text+0x12c4): undefined reference to `dw_ltssm_sts_string'
> 
> 
> vim +561 drivers/pci/controller/dwc/pcie-designware-debugfs.c
> 
>     554	
>     555	static int dwc_pcie_ltssm_status_show(struct seq_file *s, void *v)
>     556	{
>     557		struct dw_pcie *pci = s->private;
>     558		enum dw_pcie_ltssm val;
>     559	
>     560		val = dw_pcie_get_ltssm(pci);
>   > 561		seq_printf(s, "%s (0x%02x)\n", dw_ltssm_sts_string(val), val);
>     562	
>     563		return 0;
>     564	}
>     565	
> 


