Return-Path: <linux-pci+bounces-45094-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DFCD38EDB
	for <lists+linux-pci@lfdr.de>; Sat, 17 Jan 2026 14:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D4F3E300518C
	for <lists+linux-pci@lfdr.de>; Sat, 17 Jan 2026 13:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF07E19CC28;
	Sat, 17 Jan 2026 13:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gHKeSqUH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853691990A7;
	Sat, 17 Jan 2026 13:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768658228; cv=none; b=Tn8hhORs/BWWNzkZAjwxmbIffay1naqyCnh6peydar5SFBYyEjoVigTnHujwbVCF57Et0nFDXxwuDf+e6uzN5FHs1sa0A8rQ6Dl9WDz+GlDiJCmMts7EBFpsJG8AOsjJEpeHC9Kyx2HbgX3n0WxcEwVAMG7A1dSNOAMnvL1xNsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768658228; c=relaxed/simple;
	bh=YJ7zKp24yxcA833nmxYEzAZPfVYu9D9cUMfZcNNLGms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bxpSBfbUZ7DKOgm7RBDGS4Fc8pzjYn8BGdoreQyLvSs9nU76nJu4UgypYQtC8Yun5nH9Cx720e2GiIm7zomG1oxM+M4IGDltVXpr1SkH+Y6UdO9PlQLfIxQcINpA44J7gZa/U7O++ieTRENGSoGH8LGsDjqPhcjFjK8ZGdeYrsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gHKeSqUH; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768658227; x=1800194227;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YJ7zKp24yxcA833nmxYEzAZPfVYu9D9cUMfZcNNLGms=;
  b=gHKeSqUHsqTr6cx6drdW0l6r6HZiVenV1T+mrkohvLuQ9AyXP3+k/yyK
   LPsmRzqMv+kQczre9asPR+00ZXOH4/LjrX6jBk59816PczOH2FetZhfYw
   7Iy+RBvM2H8/49vyyRV+R+aHy0OOdq9Ebp+3/udz2Q4xfobe6FQxNqgKA
   YkM6fTBH2vtm9f/hd/aNUro9pkzbSbSpVH+gSNqmzZE5ATahJiyvcmXpg
   n5NdGAj2qLJ3dT7+97ox60tf9xgzzjwh2+EjgvVMP7OIhM/ijTrvv++DH
   st+cJxxXRBjBznKrxpSxIRBRgHmRXtLKfS31MvXW/EtaOP0BXijlanyhv
   A==;
X-CSE-ConnectionGUID: 0gn7CyAaTbCFyhXPzxTrSw==
X-CSE-MsgGUID: Y4sQ1zN1QJGSvO68ZnH/Pw==
X-IronPort-AV: E=McAfee;i="6800,10657,11674"; a="87519923"
X-IronPort-AV: E=Sophos;i="6.21,234,1763452800"; 
   d="scan'208";a="87519923"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2026 05:57:06 -0800
X-CSE-ConnectionGUID: tA6KAEBgSBefhdpuAXrKzQ==
X-CSE-MsgGUID: 6WJWbdXpQxuXOG2JgptCEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,234,1763452800"; 
   d="scan'208";a="204706258"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 17 Jan 2026 05:57:00 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vh6nR-00000000Lu4-0mQ3;
	Sat, 17 Jan 2026 13:56:57 +0000
Date: Sat, 17 Jan 2026 21:56:38 +0800
From: kernel test robot <lkp@intel.com>
To: smadhavan@nvidia.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, bhelgaas@google.com, ming.li@zohomail.com,
	rrichter@amd.com, Smita.KoralahalliChannabasappa@amd.com,
	huaisheng.ye@intel.com, linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, smadhavan@nvidia.com, vaslot@nvidia.com,
	vsethi@nvidia.com, sdonthineni@nvidia.com, vidyas@nvidia.com,
	mochs@nvidia.com, jsequeira@nvidia.com,
	Srirangan Madhavan <smsadhavan@nvidia.com>
Subject: Re: [PATCH v3 4/10] PCI: add CXL reset method
Message-ID: <202601172149.u8U2DH7L-lkp@intel.com>
References: <20260116014146.2149236-5-smadhavan@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116014146.2149236-5-smadhavan@nvidia.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus linus/master v6.19-rc5]
[cannot apply to next-20260116]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/smadhavan-nvidia-com/cxl-move-DVSEC-defines-to-cxl-pci-header/20260116-094457
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20260116014146.2149236-5-smadhavan%40nvidia.com
patch subject: [PATCH v3 4/10] PCI: add CXL reset method
config: alpha-allnoconfig (https://download.01.org/0day-ci/archive/20260117/202601172149.u8U2DH7L-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260117/202601172149.u8U2DH7L-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601172149.u8U2DH7L-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/pci/pci.c: In function 'cxl_reset':
>> drivers/pci/pci.c:4979:17: warning: suggest parentheses around comparison in operand of '&' [-Wparentheses]
    4979 |         if (reg & CXL_DVSEC_CXL_RST_CAPABLE == 0)
         |                 ^
--
   alpha-linux-ld: drivers/pci/pci.o: in function `cxl_reset':
>> (.text+0x6cec): undefined reference to `cxl_is_type2_device'
>> alpha-linux-ld: (.text+0x6cf4): undefined reference to `cxl_is_type2_device'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

