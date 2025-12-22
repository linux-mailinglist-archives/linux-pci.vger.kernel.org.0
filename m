Return-Path: <linux-pci+bounces-43488-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 61280CD4B47
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 06:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B137C300AE8D
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 05:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BA52FF143;
	Mon, 22 Dec 2025 05:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yqt0W2cu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947641E4AB;
	Mon, 22 Dec 2025 05:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766379739; cv=none; b=kNRbZQO51ziN45xsN7hjowo6YNvpF3gFPECQb7KhMQK7k8tI4SkyoDwIJvrQ+QBVEPzdVE1+Kk2yintgTU7SaDcFvBuOZdJjzHXlAfBiw2EgCEBR8dup60mr+OctDaw0pSdS+SzLpGaoY7sc1KN1o+UTVfB4pPaucEZT9UNyl98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766379739; c=relaxed/simple;
	bh=blIjubQYIGL0QxI9JnbsbYFZJ3h5UaT7l5utd9UMyOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tzm46jAMvlS6GzyFZ4LXnPTjgdtXpwtFVbyADDuNGd8LY7qUfoLoU/FAZkjuWQTjK/sHNqXjPeS1QTWXXFlxaZdGFHPZwO5ce403xR9kblZk+GxNvteQPRE4/PIij+4yDFT7ammaMr71ALSie5G6U8ZHDz0hfPSOnKU3TjCpWrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yqt0W2cu; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766379737; x=1797915737;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=blIjubQYIGL0QxI9JnbsbYFZJ3h5UaT7l5utd9UMyOs=;
  b=Yqt0W2cuLwfsQ4mWF6cDaODvxaB4FxLK5Bv3+ieA9vKm/O821ntfQemu
   eW5ClMC6AAjD34cNPpiLqSRbp6H1AvTBf1WAgovvj0G9L0ZErrbl+GGg2
   5HfqaP9C8K5Cfdqs5H9yRX2lXh6GZAYbFw+DeSbfdVut96i5WR0nV7woG
   I144BMg/uG1iyAl14v1e5zzqIZUtezZVCUTGFqM7TB5WZjUo2vcESPOwN
   XuNfayOipRGVuMmk44m8h/cI354hLbNTDlky6PptDviKhfKMf2tCHdaVy
   5sWzf0gtBEfo69vRuLqBzl0XL6aIAixfOuxMZuraPvxvWEFOAfD/Rqv7Q
   Q==;
X-CSE-ConnectionGUID: euhhu8HkTkagiu+bXsnypw==
X-CSE-MsgGUID: dLtjXsXHTHeNZRJxEc3ylA==
X-IronPort-AV: E=McAfee;i="6800,10657,11649"; a="68281422"
X-IronPort-AV: E=Sophos;i="6.21,167,1763452800"; 
   d="scan'208";a="68281422"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2025 21:02:16 -0800
X-CSE-ConnectionGUID: OydS4gqHR6eRg2RqohbgaQ==
X-CSE-MsgGUID: 6tYC9+o0Rci+OI35D9v0VA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,167,1763452800"; 
   d="scan'208";a="230449177"
Received: from igk-lkp-server01.igk.intel.com (HELO 8a0c053bdd2a) ([10.211.93.152])
  by fmviesa001.fm.intel.com with ESMTP; 21 Dec 2025 21:02:13 -0800
Received: from kbuild by 8a0c053bdd2a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vXY3f-000000005MW-2555;
	Mon, 22 Dec 2025 05:02:11 +0000
Date: Mon, 22 Dec 2025 06:01:27 +0100
From: kernel test robot <lkp@intel.com>
To: Ziming Du <duziming2@huawei.com>, bhelgaas@google.com
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, chrisw@redhat.com,
	jbarnes@virtuousgeek.org, alex.williamson@redhat.com,
	liuyongqiang13@huawei.com, duziming2@huawei.com
Subject: Re: [PATCH 2/3] PCI/sysfs: Prohibit unaligned access to I/O port on
 non-x86
Message-ID: <202512220635.gFQlRFAa-lkp@intel.com>
References: <20251216083912.758219-3-duziming2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216083912.758219-3-duziming2@huawei.com>

Hi Ziming,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus linus/master v6.19-rc2 next-20251219]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ziming-Du/PCI-sysfs-fix-null-pointer-dereference-during-PCI-hotplug/20251216-163452
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20251216083912.758219-3-duziming2%40huawei.com
patch subject: [PATCH 2/3] PCI/sysfs: Prohibit unaligned access to I/O port on non-x86
config: s390-allnoconfig-bpf (https://download.01.org/0day-ci/archive/20251222/202512220635.gFQlRFAa-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251222/202512220635.gFQlRFAa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512220635.gFQlRFAa-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pci/pci-sysfs.c:1145:13: warning: 'is_unaligned' defined but not used [-Wunused-function]
    1145 | static bool is_unaligned(unsigned long port, size_t size)
         |             ^~~~~~~~~~~~


vim +/is_unaligned +1145 drivers/pci/pci-sysfs.c

  1143	
  1144	#if !defined(CONFIG_X86)
> 1145	static bool is_unaligned(unsigned long port, size_t size)
  1146	{
  1147		return port & (size - 1);
  1148	}
  1149	#endif
  1150	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

