Return-Path: <linux-pci+bounces-27518-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 238E9AB1B1D
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 18:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E17F5054AD
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 16:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882F9238171;
	Fri,  9 May 2025 16:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="KyCyLRU6"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3B023026D;
	Fri,  9 May 2025 16:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746809928; cv=none; b=AhhhRKMNLw7quxXC1I/zLcMCBYO/onu7sMDmdjSyLNM8+rS8bw7K3dcGa0T/ojhXGAsjVjysOoGl10AxG11q9EbsukrOJNHbjo+MTKRdE3Uo/HUaYYtP8+aRrzomqxdTnuuTPIjVp2na+oL58yWCrtPrGX1BmhTEg9o/EmR5JHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746809928; c=relaxed/simple;
	bh=7mAjBCwnH2ZUH875gXpsgSMs0EEgOEKXxWy4eLsWkVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j6UP8f7SPNGaRvOAAKDX+H4IzBfL1yGudWho0LN2fsudY9V4qEzlhyq013XDs8IFyj54I5EWY0DcnZofYSg7AMb8Hekute1tNs1FJSA5MjDYPIYFrEznkEkFZJYs8bwb5o55VAfa8ceJjR+Jv3QzEM+g1TZvXeChPTSyEq5T8Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=KyCyLRU6; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=fn7C/lj4+xfYek2/Hfb8+CYNC7tLiF8VaxxNp59+7qM=;
	b=KyCyLRU6oKTazgTwC9TaR1sBfqeEFCKk//28RC+ayN1WST1UZr2RSLZP+iAICY
	GaHbEUVCpw197BnPi84aITAyecl29CJxH6m/Q4Qe+scDvcFpIqwS01l5yXlmeQe5
	D4hdT1/Om1/lp4GMXiRS1Fmz4yUGTYj/o5BuaDQML/iMA=
Received: from [192.168.71.93] (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgDHdsYDNB5oCsJ+AA--.21817S2;
	Sat, 10 May 2025 00:57:41 +0800 (CST)
Message-ID: <4d77e199-8df8-4510-ad49-9a452a29c923@163.com>
Date: Sat, 10 May 2025 00:57:40 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 4/6] PCI: dwc: Use common PCI host bridge APIs for
 finding the capabilities
To: kernel test robot <lkp@intel.com>, lpieralisi@kernel.org,
 bhelgaas@google.com, manivannan.sadhasivam@linaro.org,
 ilpo.jarvinen@linux.intel.com, kw@linux.com
Cc: oe-kbuild-all@lists.linux.dev, cassel@kernel.org, robh@kernel.org,
 jingoohan1@gmail.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250505163420.198012-5-18255117159@163.com>
 <202505092036.Sw8SstSY-lkp@intel.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <202505092036.Sw8SstSY-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PCgvCgDHdsYDNB5oCsJ+AA--.21817S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAr17trWfAFW5uF48CrWkXrb_yoWrGFykpF
	W5Jry2yFWrJryfWF4vya98W3WYvFnxAas8CF93Cw1SvFyavayUKFy09FW3Kr9agF4q9FWf
	twsxGFWUArn8AF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U3Oz3UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWw9Io2geM5IYEwAAsj



On 2025/5/9 20:49, kernel test robot wrote:
> Hi Hans,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on ca91b9500108d4cf083a635c2e11c884d5dd20ea]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Hans-Zhang/PCI-Introduce-generic-bus-config-read-helper-function/20250506-004221
> base:   ca91b9500108d4cf083a635c2e11c884d5dd20ea
> patch link:    https://lore.kernel.org/r/20250505163420.198012-5-18255117159%40163.com
> patch subject: [PATCH v11 4/6] PCI: dwc: Use common PCI host bridge APIs for finding the capabilities
> config: parisc-randconfig-r063-20250509 (https://download.01.org/0day-ci/archive/20250509/202505092036.Sw8SstSY-lkp@intel.com/config)
> compiler: hppa-linux-gcc (GCC) 14.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250509/202505092036.Sw8SstSY-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202505092036.Sw8SstSY-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>     In function 'dw_pcie_read_cfg',
>         inlined from 'dw_pcie_find_capability' at drivers/pci/controller/dwc/pcie-designware.c:219:9:
>>> drivers/pci/controller/dwc/pcie-designware.c:212:14: warning: write of 32-bit data outside the bound of destination object, data truncated into 8-bit [-Wextra]
>       212 |         *val = dw_pcie_read_dbi(pci, where, size);
>           |         ~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> 
> vim +212 drivers/pci/controller/dwc/pcie-designware.c
> 
>     207	
>     208	static int dw_pcie_read_cfg(void *priv, int where, int size, u32 *val)
>     209	{
>     210		struct dw_pcie *pci = priv;
>     211	
>   > 212		*val = dw_pcie_read_dbi(pci, where, size);
>     213	
>     214		return PCIBIOS_SUCCESSFUL;
>     215	}
>     216	
> 

Dear Maintainers,

I don't know why the warning here is. I think the return value of 
dw_pcie_read_dbi, whether u8/u16, will be automatically and forcibly 
converted to u32.

The following files have similar uses:

drivers/pci/controller/dwc/pci-exynos.c
static int exynos_pcie_rd_own_conf(struct pci_bus *bus, unsigned int devfn,
				   int where, int size, u32 *val)
{
	struct dw_pcie *pci = to_dw_pcie_from_pp(bus->sysdata);

	if (PCI_SLOT(devfn))
		return PCIBIOS_DEVICE_NOT_FOUND;

	*val = dw_pcie_read_dbi(pci, where, size);
	return PCIBIOS_SUCCESSFUL;
}

drivers/pci/controller/dwc/pcie-histb.c
static int histb_pcie_rd_own_conf(struct pci_bus *bus, unsigned int devfn,
				  int where, int size, u32 *val)
{
	struct dw_pcie *pci = to_dw_pcie_from_pp(bus->sysdata);

	if (PCI_SLOT(devfn))
		return PCIBIOS_DEVICE_NOT_FOUND;

	*val = dw_pcie_read_dbi(pci, where, size);
	return PCIBIOS_SUCCESSFUL;
}

drivers/pci/controller/dwc/pcie-kirin.c
static int kirin_pcie_rd_own_conf(struct pci_bus *bus, unsigned int devfn,
				  int where, int size, u32 *val)
{
	struct dw_pcie *pci = to_dw_pcie_from_pp(bus->sysdata);

	if (PCI_SLOT(devfn))
		return PCIBIOS_DEVICE_NOT_FOUND;

	*val = dw_pcie_read_dbi(pci, where, size);
	return PCIBIOS_SUCCESSFUL;
}


drivers/pci/access.c
int pci_generic_config_read(struct pci_bus *bus, unsigned int devfn,
			    int where, int size, u32 *val)
{
	void __iomem *addr;

	addr = bus->ops->map_bus(bus, devfn, where);
	if (!addr)
		return PCIBIOS_DEVICE_NOT_FOUND;

	if (size == 1)
		*val = readb(addr);
	else if (size == 2)
		*val = readw(addr);
	else
		*val = readl(addr);

	return PCIBIOS_SUCCESSFUL;
}
EXPORT_SYMBOL_GPL(pci_generic_config_read);




May I ignore this warning? Could it be that I misunderstood something?


Best regards,
Hans




