Return-Path: <linux-pci+bounces-27505-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C28CAB13CA
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 14:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5390C3A9931
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 12:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E533128FFC9;
	Fri,  9 May 2025 12:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XKPz6Mj1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA56139B;
	Fri,  9 May 2025 12:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746795018; cv=none; b=jwDFJq8u9I4pEos8bri2klLl7U3oOBmnv/hn2xqx/jLf9P+mVponYhBOQlJe1CrjF0QFVnJiFcY3YjVg3FEq3SlPUWENuI0n0XruEA5hkpM+4vYUw8nz8uVCxVUQ9WusPoI+qxVVib1nOgrfoerve1ug8+9RBoG3r3sEGsRjVE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746795018; c=relaxed/simple;
	bh=fnDyeYcUpoqrbSOCi2sjTmd6cIjqVA+Zh5TB8SQPjQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kg4nKiS1kVPpcSkD+EXJJoasNs3SjnXpQksGla7MF0fyAPwk6aQRcdvOExPIdK5bSVHEP5QeBg9V3C3L2BqzRo3q8BA2agPJVthzBW2xA2hJgnF2ZzCQzjm8avzbDjH8oOB+8mKURJmarjx96VmQTjElecuaEo8f5rjxn8xAXEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XKPz6Mj1; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746795017; x=1778331017;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fnDyeYcUpoqrbSOCi2sjTmd6cIjqVA+Zh5TB8SQPjQI=;
  b=XKPz6Mj1fjIPZ79M+EZzMTZLpyY/EM34tbmcjTRjLaRHLSB1SpjNf+yI
   MbRUbix1IwUci25QhU5DnTk6E2sp2YoSed2hG6ym/oqoP6YVHfO4K6YBC
   7Y+XUa9jsW/822EyxkkSIajMTI2YdTq4LcELzj6Bp7aC9cn+/8uVVE1bS
   u8YZSidvj3LSFYcyvqoMu2Hgrq3uJcC8wzHrRjU7Lur/2oQYFb2zpG7t+
   KzJnjtY2JV7FT5s27XclcUgUPysVYUOE9eM2TnXYVIURwUyVqevd19lFo
   83z/953RBBe4w1DmNIdhhX3kceo8UIB21MHlOF+6wsuhFXE3i0LPkB4CF
   w==;
X-CSE-ConnectionGUID: M93uQD7lSwWeRrJKp22bPw==
X-CSE-MsgGUID: t79fLzXPQ2GoELf4JmYkAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="52273402"
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="52273402"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 05:50:17 -0700
X-CSE-ConnectionGUID: MvJmEGOHRk+FrunGlOFqxg==
X-CSE-MsgGUID: knNqLrorTzWFiC1IS8AnwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="136631082"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 09 May 2025 05:50:13 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uDNB4-000C5f-2p;
	Fri, 09 May 2025 12:50:10 +0000
Date: Fri, 9 May 2025 20:49:34 +0800
From: kernel test robot <lkp@intel.com>
To: Hans Zhang <18255117159@163.com>, lpieralisi@kernel.org,
	bhelgaas@google.com, manivannan.sadhasivam@linaro.org,
	ilpo.jarvinen@linux.intel.com, kw@linux.com
Cc: oe-kbuild-all@lists.linux.dev, cassel@kernel.org, robh@kernel.org,
	jingoohan1@gmail.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hans Zhang <18255117159@163.com>
Subject: Re: [PATCH v11 4/6] PCI: dwc: Use common PCI host bridge APIs for
 finding the capabilities
Message-ID: <202505092036.Sw8SstSY-lkp@intel.com>
References: <20250505163420.198012-5-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505163420.198012-5-18255117159@163.com>

Hi Hans,

kernel test robot noticed the following build warnings:

[auto build test WARNING on ca91b9500108d4cf083a635c2e11c884d5dd20ea]

url:    https://github.com/intel-lab-lkp/linux/commits/Hans-Zhang/PCI-Introduce-generic-bus-config-read-helper-function/20250506-004221
base:   ca91b9500108d4cf083a635c2e11c884d5dd20ea
patch link:    https://lore.kernel.org/r/20250505163420.198012-5-18255117159%40163.com
patch subject: [PATCH v11 4/6] PCI: dwc: Use common PCI host bridge APIs for finding the capabilities
config: parisc-randconfig-r063-20250509 (https://download.01.org/0day-ci/archive/20250509/202505092036.Sw8SstSY-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250509/202505092036.Sw8SstSY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505092036.Sw8SstSY-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In function 'dw_pcie_read_cfg',
       inlined from 'dw_pcie_find_capability' at drivers/pci/controller/dwc/pcie-designware.c:219:9:
>> drivers/pci/controller/dwc/pcie-designware.c:212:14: warning: write of 32-bit data outside the bound of destination object, data truncated into 8-bit [-Wextra]
     212 |         *val = dw_pcie_read_dbi(pci, where, size);
         |         ~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +212 drivers/pci/controller/dwc/pcie-designware.c

   207	
   208	static int dw_pcie_read_cfg(void *priv, int where, int size, u32 *val)
   209	{
   210		struct dw_pcie *pci = priv;
   211	
 > 212		*val = dw_pcie_read_dbi(pci, where, size);
   213	
   214		return PCIBIOS_SUCCESSFUL;
   215	}
   216	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

