Return-Path: <linux-pci+bounces-19590-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C5DA06FB7
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2025 09:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A599188900C
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2025 08:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1676F214819;
	Thu,  9 Jan 2025 08:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mB+C8Sz2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA8310A3E;
	Thu,  9 Jan 2025 08:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736410069; cv=none; b=JsTzVSodFSUVckY+ZBUbSX/onmBez4nfDg0DnEICAlTqnbEfPGyqECEwPdidqwV+5GM1WTY4YznQohraklL+mSuAp9kOuvjufCojpUw7iGnnmtR8EiyL1ok2B6dt7MXQBeLi2R9NOIzuvJOCybcnQBpf6IdjsDNvhOyPfW7oZkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736410069; c=relaxed/simple;
	bh=B2yoJq6pKJpHj/MqGKeZtQFZAWjREci13lLhyUBacuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OO5ae0PcpiH7WfvUDdsIQneSBwh66H+zfwrY5LbAdOEEib0m5/VCARfnIbGgB3dQ+TV41C3nNRFNFhIGh4uNoDFwsIF0eQ8iWtzhTlovDvwuQdrdO8ZwD1bB0/tLpvEziW5+JD2FSVvU7N3QLlec4YrAkbYN/0FkL+4ctV1quOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mB+C8Sz2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FD2BC4CEDF;
	Thu,  9 Jan 2025 08:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736410068;
	bh=B2yoJq6pKJpHj/MqGKeZtQFZAWjREci13lLhyUBacuo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mB+C8Sz2tSXvTKvPfuJsGUFL7ArL6jt7VRSWoyZFLnro5PLQcdE2l5JJXVF+6ZLBD
	 xsApdJBRyArxWyvL6IB5BFv2dry33odbPDPqid2mL7bh50cZ/zbCRCm9DWLAP5XXkK
	 q5xsW8uxL8Av4CRJSdHca2OAPLXnxPKCUAEEyzzkMG/AIWCfQ+V+TVuC5pV5w7V5Ax
	 vgwVV4RljpUyqnmBn9EiqZ4sLKwmr5qG7UuaeCrhBA6EElIb07j2HKUddlLDGa/kkz
	 fMA0m6/K+DlY3KlJ5BFEWRvVcdFtGUbVaAWCTCapTBh9CPTQCA1aaGuW2vEcTXInxb
	 WrXd69qmsYkoQ==
Date: Thu, 9 Jan 2025 09:07:43 +0100
From: Niklas Cassel <cassel@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 3/6] PCI: dwc: endpoint: Add support for BAR type
 BAR_RESIZABLE
Message-ID: <Z3-Dz42s7uYoNCuV@ryzen>
References: <20250107181450.3182430-11-cassel@kernel.org>
 <202501090927.zMSzHORM-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202501090927.zMSzHORM-lkp@intel.com>

On Thu, Jan 09, 2025 at 10:22:07AM +0800, kernel test robot wrote:
> Hi Niklas,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on pci/next]
> [also build test WARNING on next-20250108]
> [cannot apply to pci/for-linus linus/master v6.13-rc6]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Niklas-Cassel/PCI-endpoint-Add-BAR-type-BAR_RESIZABLE/20250108-021844
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
> patch link:    https://lore.kernel.org/r/20250107181450.3182430-11-cassel%40kernel.org
> patch subject: [PATCH 3/6] PCI: dwc: endpoint: Add support for BAR type BAR_RESIZABLE
> config: arm-randconfig-003-20250109 (https://download.01.org/0day-ci/archive/20250109/202501090927.zMSzHORM-lkp@intel.com/config)
> compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 096551537b2a747a3387726ca618ceeb3950e9bc)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250109/202501090927.zMSzHORM-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202501090927.zMSzHORM-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from drivers/pci/controller/dwc/pcie-designware-ep.c:14:
>    In file included from drivers/pci/controller/dwc/pcie-designware.h:17:
>    In file included from include/linux/dma-mapping.h:8:
>    In file included from include/linux/scatterlist.h:8:
>    In file included from include/linux/mm.h:2223:
>    include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
>      518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
>          |                               ~~~~~~~~~~~ ^ ~~~
> >> drivers/pci/controller/dwc/pcie-designware-ep.c:259:27: warning: result of comparison of constant 140737488355328 with expression of type 'size_t' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
>      259 |         if (size < SZ_1M || size > (SZ_128G * 1024))
>          |                             ~~~~ ^ ~~~~~~~~~~~~~~~~
>    2 warnings generated.
>

The compiler is correct that this condition can never happen on 32-bit,
but the code is correct, and the compiler will be able to optimize the
check away on 32-bit, so I will simply add a cast to shut up the warning.


Kind regards,
Niklas

> 
> vim +259 drivers/pci/controller/dwc/pcie-designware-ep.c
> 
>    249	
>    250	static u32 dw_pcie_ep_bar_size_to_rebar_cap(size_t size)
>    251	{
>    252		u32 val;
>    253	
>    254		/*
>    255		 * According to PCIe base spec, min size for a resizable BAR is 1 MB,
>    256		 * thus disallow a requested BAR size smaller than 1 MB.
>    257		 * Disallow a requested BAR size larger than 128 TB.
>    258		 */
>  > 259		if (size < SZ_1M || size > (SZ_128G * 1024))
>    260			return 0;
>    261	
>    262		val = ilog2(size);
>    263		val -= 20;
>    264	
>    265		/* Sizes in REBAR_CAP start at BIT(4). */
>    266		return BIT(val + 4);
>    267	}
>    268	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

