Return-Path: <linux-pci+bounces-40544-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB59C3DF53
	for <lists+linux-pci@lfdr.de>; Fri, 07 Nov 2025 01:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F33C24E7142
	for <lists+linux-pci@lfdr.de>; Fri,  7 Nov 2025 00:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637C62236E3;
	Fri,  7 Nov 2025 00:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j1C2LwBM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F4D20E334;
	Fri,  7 Nov 2025 00:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762474417; cv=none; b=o7hIdCMIHATt09A2Nt0PqCQ05BAPwG/riQtWI/eTleEUz0E/2vaTAIEfMgM/G77FZXfxF5Lc5MzU9fjv77jNDbnKooO7W82ArgCb2Mme1aMdHjadH0BRAt4AY+9qbTRgFNodGOY34dWU9ZhVVo+DQCwqjp0/U4z6eENg0DenUc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762474417; c=relaxed/simple;
	bh=2u4onrW1UIHYO/vrNYmY+JJnCXuAk11e42H3y3FcxMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WMW9ZEdTFsw/WFM/1PbHV+tTSe1YkIdLS1vpyh0ZctABxqJRqlK4HTQzTJhfb+EqKyC+rr97Z9hpjVzyckH8kVcQZci/GSL3CGLmeZubUPw7H7ZROTLtg6GJ2umZDPUuwlkao0Q9ZkAymIAVzo9WTBH1zDMqboNiGhr21xj3J30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j1C2LwBM; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762474415; x=1794010415;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2u4onrW1UIHYO/vrNYmY+JJnCXuAk11e42H3y3FcxMs=;
  b=j1C2LwBMmlhNrJ9yBt5UHP+Jhkh6vPg/U/689JBlItToqW9aukGyP4o+
   t8FGAEOOyB71dFEhOT3X4GdYkIcQps6QZElhcfg18hwuyIVYbGIM0E1/e
   QySAORTGX49qgrD2oWFY8v/WpW8y8F7pn6Uf08pcso0rJV8XQ1jbYooQr
   AFAxlvuPD6mx1GACi6EZO+DRgPqw53TiMSf0NMhL1+cduz/u7Vogf35fw
   ULxisVJ+zEiCBKH94EiJ5JKO6V8uF5JIuGg/ubU89S+4cIIndh8+PMeXi
   P0BSVdsq9V+ToOb5TlqAazlE0A3giv76CvGwHC4f5XTLbzqV/jWIins6G
   Q==;
X-CSE-ConnectionGUID: JoT5F7r1ScqRPVX8lYWBeQ==
X-CSE-MsgGUID: jknhkFozRzamKIKtn/Z1mg==
X-IronPort-AV: E=McAfee;i="6800,10657,11605"; a="64323423"
X-IronPort-AV: E=Sophos;i="6.19,285,1754982000"; 
   d="scan'208";a="64323423"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 16:13:34 -0800
X-CSE-ConnectionGUID: DUnYCn2xS7uSIeOWmK2iaA==
X-CSE-MsgGUID: tpitvUBxSmGAnfkDhSxq3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,285,1754982000"; 
   d="scan'208";a="188060916"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 06 Nov 2025 16:13:32 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vHA6B-000UUS-36;
	Fri, 07 Nov 2025 00:13:12 +0000
Date: Fri, 7 Nov 2025 08:12:38 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	bhelgaas@google.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, will@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	robh@kernel.org, linux-arm-msm@vger.kernel.org,
	zhangsenchuan@eswincomputing.com,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: Re: [PATCH 1/3] PCI: host-common: Add an API to check for any device
 under the Root Ports
Message-ID: <202511070717.PZBzRyQO-lkp@intel.com>
References: <20251106061326.8241-2-manivannan.sadhasivam@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106061326.8241-2-manivannan.sadhasivam@oss.qualcomm.com>

Hi Manivannan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus linus/master v6.18-rc4 next-20251106]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Manivannan-Sadhasivam/PCI-host-common-Add-an-API-to-check-for-any-device-under-the-Root-Ports/20251106-141822
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20251106061326.8241-2-manivannan.sadhasivam%40oss.qualcomm.com
patch subject: [PATCH 1/3] PCI: host-common: Add an API to check for any device under the Root Ports
config: arm-randconfig-001-20251107 (https://download.01.org/0day-ci/archive/20251107/202511070717.PZBzRyQO-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251107/202511070717.PZBzRyQO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511070717.PZBzRyQO-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/pci/controller/pci-host-common.c:27 function parameter 'root_bus' not described in 'pci_root_ports_have_device'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

