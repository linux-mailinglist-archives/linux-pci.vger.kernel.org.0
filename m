Return-Path: <linux-pci+bounces-17817-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A44DF9E6260
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 01:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54610188227B
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 00:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC66C1DFFC;
	Fri,  6 Dec 2024 00:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cvWFuFIF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F834C9A
	for <linux-pci@vger.kernel.org>; Fri,  6 Dec 2024 00:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733445863; cv=none; b=cexeCwJA/sNWWXMcfkeLtRvUoOjbbx+bdT4VLaWw6mYVRk8pjoSZF+2dBs0h/8gMGyki9TcS4SpE4HIRi5c/WiRklrUIbtv5jwTz3UwL3GnskhURGlvpxiXnLcyYNgi8tFDDit1Yu3VFRSR41qWXUv4MfNyOKCwhjZc/NLMpSpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733445863; c=relaxed/simple;
	bh=Sidk4+WOsBrKg86yCRr3g4nK7EJBgB78VBra7RMrLzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WbJ43vOeoO2/57UIDgFQWJL4CexleOkk2tQ0uehIF9v8Writf6b/Nozmx4qzUL3P/pagF49UUFH/iOzD9d/IfDip38vQg9ApTbhEiAMRFSs4iBj8uJc1+eIg/Te2OYpGByohvxH023QLHeVVGY1k4+EOqhJfatHGa3dGUu/dhgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cvWFuFIF; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733445862; x=1764981862;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Sidk4+WOsBrKg86yCRr3g4nK7EJBgB78VBra7RMrLzc=;
  b=cvWFuFIF1xzkZPiEPHxuElDnMZYIITn5NO6lGaDoxm2J6cl/L5OAZnXB
   go9aTLd25ilofdYYQkNK5HFvOIH3zmQKupwqkjZGv4wzG1NI+j3GkCGik
   Tx78rTUAQVkaSONWYFPqZm5+E0GEmMEqTC3nBCApDWSb7cY5EhWeOuL8r
   G5pWEn5CWproATe7lv1T/VwRV+nhgPsY8XsPVXEd48AyyuchJ6hruxrpk
   iGadB3EJLcbPtWZqZNaqIgsH+cIxx4BhPfLiwZq6ZB9XU8rABH23oU2fZ
   yu0dLOUhsjElAvfmIg1fl9Je02Pp3QNYf4QINbPexIn1ScyXZDI2JvlRT
   g==;
X-CSE-ConnectionGUID: xdB3LSvDQpedIW2tw7gxaw==
X-CSE-MsgGUID: /8sGHrIaT8yZoUeZhWZk6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="44259049"
X-IronPort-AV: E=Sophos;i="6.12,211,1728975600"; 
   d="scan'208";a="44259049"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 16:44:22 -0800
X-CSE-ConnectionGUID: rDXGsGaSSxOrpoN+GxkWww==
X-CSE-MsgGUID: byBQqlKARMChaF7ZpjPhUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,211,1728975600"; 
   d="scan'208";a="99081065"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 05 Dec 2024 16:44:19 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tJMS9-0000Xn-0T;
	Fri, 06 Dec 2024 00:44:17 +0000
Date: Fri, 6 Dec 2024 08:43:40 +0800
From: kernel test robot <lkp@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, Bjorn Helgaas <helgaas@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, linux-pci@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH 09/11] PCI/IDE: Report available IDE streams
Message-ID: <202412060857.Kn0HyAFH-lkp@intel.com>
References: <173343744869.1074769.12345445223792172558.stgit@dwillia2-xfh.jf.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173343744869.1074769.12345445223792172558.stgit@dwillia2-xfh.jf.intel.com>

Hi Dan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 40384c840ea1944d7c5a392e8975ed088ecf0b37]

url:    https://github.com/intel-lab-lkp/linux/commits/Dan-Williams/configfs-tsm-Namespace-TSM-report-symbols/20241206-064224
base:   40384c840ea1944d7c5a392e8975ed088ecf0b37
patch link:    https://lore.kernel.org/r/173343744869.1074769.12345445223792172558.stgit%40dwillia2-xfh.jf.intel.com
patch subject: [PATCH 09/11] PCI/IDE: Report available IDE streams
config: i386-buildonly-randconfig-006 (https://download.01.org/0day-ci/archive/20241206/202412060857.Kn0HyAFH-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241206/202412060857.Kn0HyAFH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412060857.Kn0HyAFH-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pci/probe.c:597:33: warning: 'pci_host_bridge_type' defined but not used [-Wunused-const-variable=]
     597 | static const struct device_type pci_host_bridge_type = {
         |                                 ^~~~~~~~~~~~~~~~~~~~


vim +/pci_host_bridge_type +597 drivers/pci/probe.c

   596	
 > 597	static const struct device_type pci_host_bridge_type = {
   598		.groups = pci_host_bridge_groups,
   599		.release = pci_release_host_bridge_dev,
   600	};
   601	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

