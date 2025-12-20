Return-Path: <linux-pci+bounces-43480-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CA773CD35E8
	for <lists+linux-pci@lfdr.de>; Sat, 20 Dec 2025 20:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 072D43009FE2
	for <lists+linux-pci@lfdr.de>; Sat, 20 Dec 2025 19:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C18221FCF;
	Sat, 20 Dec 2025 19:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="laZwxkX2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751634D8CE
	for <linux-pci@vger.kernel.org>; Sat, 20 Dec 2025 19:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766258205; cv=none; b=R8xPZECDZspiis/5BhODJymDtaViibLBKzA0I14QlaJgvotkflCPuuAmKdD7Q2b7ohw8VcMzeQgeH/Aonh49tbUNDdRDdaBhJQqMOi9ZQdCoJ+wk4s3vCETSEnfUbJTxBb4WWyU1t6jS+Egvcu4z1MRpURZss/vZ5X1yfatjJ2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766258205; c=relaxed/simple;
	bh=AlMwsGmQJqjTpP8Waf1AWz8+E74NODaB1nv1e3+CC4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EPOXBU4p2JJPnWXqd/kOm+3dvqBS9vbwIp3tP/hqQSi7EY9Vj8708Lk0rU5IJPBzXD/vLRW7jrt9wxZ+7/GwhUL91jaqFX0yP5vUI3Y1IkWwgjERMM1MYmCnV3BN/MCmwUGbCU+MJs2A/pYy7fyx6QeQe0Q0G9y0T9Qvqvpfjeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=laZwxkX2; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766258203; x=1797794203;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AlMwsGmQJqjTpP8Waf1AWz8+E74NODaB1nv1e3+CC4c=;
  b=laZwxkX2t0mzfRPpqQ7xrF2Uz1ts8nMw3sflRAvFt+sCRACTOHNlKF4e
   O+aThucfiQzvYY6/CwdW01E3Fb8XtUUWc8dZurQ47tJQJBBR8l/lvd/zk
   vRRcTxZv098viQYQfbZCOndqUyqZh8xXwE3aTCXSvHLLclwpvcd2WuHC8
   k+8jUJBJOYK2otQyuoR9EcDCe5BYYt14kaE9umezmIs41Nh+5Jbj9ecFL
   zOHp077v/MS3Jniw5uYFdZp7KrQjCo5F6lkTj1M2/6iG9fc6ceOK0Jpnl
   7boSby9wn9+RVrpj/Y+rjNh+1VF+HG7pCLt3z/GUH1fY3uHhLFHtmkZ+h
   Q==;
X-CSE-ConnectionGUID: HyHDhFVLQzi/9GENNKtALg==
X-CSE-MsgGUID: /fvPdF7yQaWBYC0bhncT0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11648"; a="78900173"
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="78900173"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2025 11:16:43 -0800
X-CSE-ConnectionGUID: 4Q5kjRgEQXywYdRJjysyfA==
X-CSE-MsgGUID: hTo/PrToSV60xdeH1gSTmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="199068930"
Received: from lkp-server01.sh.intel.com (HELO 0d09efa1b85f) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 20 Dec 2025 11:16:41 -0800
Received: from kbuild by 0d09efa1b85f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vX2RS-0000000053p-30Cm;
	Sat, 20 Dec 2025 19:16:38 +0000
Date: Sun, 21 Dec 2025 03:16:16 +0800
From: kernel test robot <lkp@intel.com>
To: Roman Shlyakhov <roman.shlyakhov.rs@gmail.com>,
	Bjorn Helgaas <helgaas@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci: extend pci-stub to support explicit binding by PCI
 BUSID
Message-ID: <202512210236.u7vwB62h-lkp@intel.com>
References: <20251219131038.21052-1-roman.shlyakhov.rs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251219131038.21052-1-roman.shlyakhov.rs@gmail.com>

Hi Roman,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus linus/master v6.19-rc1 next-20251219]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Roman-Shlyakhov/pci-extend-pci-stub-to-support-explicit-binding-by-PCI-BUSID/20251219-211130
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20251219131038.21052-1-roman.shlyakhov.rs%40gmail.com
patch subject: [PATCH] pci: extend pci-stub to support explicit binding by PCI BUSID
config: openrisc-allmodconfig (https://download.01.org/0day-ci/archive/20251221/202512210236.u7vwB62h-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251221/202512210236.u7vwB62h-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512210236.u7vwB62h-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> drivers/pci/pci-stub.c:220:13: error: expected declaration specifiers or '...' before string constant
     220 | early_param("pci_stub_busid", pci_stub_early_param);
         |             ^~~~~~~~~~~~~~~~
>> drivers/pci/pci-stub.c:220:31: error: expected declaration specifiers or '...' before 'pci_stub_early_param'
     220 | early_param("pci_stub_busid", pci_stub_early_param);
         |                               ^~~~~~~~~~~~~~~~~~~~
>> drivers/pci/pci-stub.c:210:19: warning: 'pci_stub_early_param' defined but not used [-Wunused-function]
     210 | static int __init pci_stub_early_param(char *str)
         |                   ^~~~~~~~~~~~~~~~~~~~


vim +220 drivers/pci/pci-stub.c

   206	
   207	/**
   208	 * early_param "pci_stub_busid" handler for the built-in module.
   209	 */
 > 210	static int __init pci_stub_early_param(char *str)
   211	{
   212		if (!str)
   213			return 0;
   214	
   215		pr_info("pci-stub: parsing early busid param: %s\n", str);
   216		strscpy(busid_param, str, sizeof(busid_param));
   217		return 0;
   218	}
   219	
 > 220	early_param("pci_stub_busid", pci_stub_early_param);
   221	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

