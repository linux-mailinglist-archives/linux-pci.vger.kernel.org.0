Return-Path: <linux-pci+bounces-24474-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB574A6D2C5
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 02:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E619D3B34E0
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 01:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E851F10A1E;
	Mon, 24 Mar 2025 01:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fj2K1Ird"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0B02E3381;
	Mon, 24 Mar 2025 01:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742778528; cv=none; b=nE4BBSCCaUKtM2DrN9AKSyprMLpZV0sLvSh8BH1kpkwnMQxIjXbmMEfq+Ahh3KxXId5ef1mlaDllJ7hZcd5nRIMONAqP7JRaeBt51wmawVk3yZ0IzyX4cZh7pN1NFj8bUa4c9D+FzNQ/qD++hJSMpOb2xRmyQWsv4nQlhHF8jws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742778528; c=relaxed/simple;
	bh=rgmtBTnzh1ceyqsqRwWoTSQ+sUMDcNbyOfiW4wJqB5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fAY1VCcLI9zAUhVjdIBgcF3FYpOQ8qRPeqH1OfeV1bZiCUVkyZM6qNNczDYciCdy6RBiLqTrH33di5Hwf9Gjo90veyhIAlkTiNcUm2JFipBE3iZ/At2y6tJO/k65ZuJCx4PEf2H5Xh7/pOa0DYfKoYHDWXzIm70S666gvCEx5Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=fj2K1Ird; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=G6I9P6QCc47jtfwU5ksYG+HIisCgBIvjY+35/NMOzyQ=;
	b=fj2K1IrdwWdwln4mFQJ1ioGjtoxFQ4ypTTozC1XmBL16cOdp+uf1sPBNJeqN/V
	zYr//sVlhSNJyPBZ9NV18WxgkDEgy/I31r8VezbNfOmglteQwtPfRx+9peOL4vnj
	jwuNQcSOPC1/4M/SLVUhfZg90F/epfRyBZOxdp4C/MIAQ=
Received: from [192.168.60.52] (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3v9BKsOBnhljKBQ--.19616S2;
	Mon, 24 Mar 2025 09:07:24 +0800 (CST)
Message-ID: <2aea0d1e-6bad-4b82-8a4c-2b855a9446f5@163.com>
Date: Mon, 24 Mar 2025 09:07:22 +0800
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
Cc: oe-kbuild-all@lists.linux.dev, kw@linux.com,
 manivannan.sadhasivam@linaro.org, robh@kernel.org, bhelgaas@google.com,
 jingoohan1@gmail.com, thomas.richard@bootlin.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250323164852.430546-4-18255117159@163.com>
 <202503240212.GtZsXgoK-lkp@intel.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <202503240212.GtZsXgoK-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3v9BKsOBnhljKBQ--.19616S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAr17tF17ur1kAFy7KF17ZFb_yoW5Wr4kpa
	48A347KFyrXr42qwn7AF1Yvw13Kr98J347A3y8Cw13ZF47uFyqgFZ2kFy5KF1akrsrKrya
	qFW7JF9YyrnYyaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uy5l8UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDwUao2fgq5HZKAAAs-



On 2025/3/24 02:33, kernel test robot wrote:
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
> config: csky-randconfig-001-20250324 (https://download.01.org/0day-ci/archive/20250324/202503240212.GtZsXgoK-lkp@intel.com/config)
> compiler: csky-linux-gcc (GCC) 14.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250324/202503240212.GtZsXgoK-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202503240212.GtZsXgoK-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>     drivers/pci/controller/cadence/pcie-cadence.c: In function 'cdns_pcie_find_capability':
>>> drivers/pci/controller/cadence/pcie-cadence.c:28:16: error: implicit declaration of function 'pci_host_bridge_find_capability'; did you mean 'cdns_pcie_find_capability'? [-Wimplicit-function-declaration]
>        28 |         return pci_host_bridge_find_capability(pcie, cdns_pcie_read_cfg, cap);
>           |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>           |                cdns_pcie_find_capability
>     drivers/pci/controller/cadence/pcie-cadence.c: In function 'cdns_pcie_find_ext_capability':
>>> drivers/pci/controller/cadence/pcie-cadence.c:33:16: error: implicit declaration of function 'pci_host_bridge_find_ext_capability'; did you mean 'cdns_pcie_find_ext_capability'? [-Wimplicit-function-declaration]
>        33 |         return pci_host_bridge_find_ext_capability(pcie, cdns_pcie_read_cfg, cap);
>           |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>           |                cdns_pcie_find_ext_capability
> 

Missing header file: #include "... /.. /pci.h". Will change.

Best regards,
Hans

> vim +28 drivers/pci/controller/cadence/pcie-cadence.c
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


