Return-Path: <linux-pci+bounces-14909-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5B59A5058
	for <lists+linux-pci@lfdr.de>; Sat, 19 Oct 2024 20:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DED9286A89
	for <lists+linux-pci@lfdr.de>; Sat, 19 Oct 2024 18:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD63119005D;
	Sat, 19 Oct 2024 18:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BBYM7JQn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3182772A
	for <linux-pci@vger.kernel.org>; Sat, 19 Oct 2024 18:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729363375; cv=none; b=MxV6wfxGOE7ENvHj6g86Op19KEdpLao5zNrHx0zsvpnc0iRStHOtzroSXhkB8EJJildtB39ogQ1SKb1tq+PsMIrutr2F5Lp27uMrvAUisvFaNx98HrW8x0LAlRoatoDoNQIu9C1VIqhPppMhBpkhU4jpaWT33SpgkBZ1LTiNao8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729363375; c=relaxed/simple;
	bh=iOWMkyYCHu9/iYWudgKtSBAyT6uebvAGNlhFQDDsVrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a9K8Md9ixAKsfAQAyjcEBMc7vwME/xFNcR1VcZExrDfPhK6tmnTVk3t7U7rNz3H6ftFnppijCdtz6UKTX3sNEZ1sMHg2LpD/Pba9IYVwzkdjf/xprdH+f1bxJFEe+EUOdYd5Df/HkosBkTtoTN3KtNRAYlqXc/dJS3Je9tYRfig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BBYM7JQn; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729363373; x=1760899373;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=iOWMkyYCHu9/iYWudgKtSBAyT6uebvAGNlhFQDDsVrc=;
  b=BBYM7JQnwEjF7a8hpz8f8nxuZ+kpyhnCRDL9jMU7JHj5Ze+6rM/sV+LC
   NUgmCk7tP5g/lvGYFEHX09NYjPiKusi6kpT7tqXU9bcb1ufIpEDcyJko2
   88a149Rwu0GV4JWw5PnvVqfir2OjH0dJ8Qj+KmjhrSA/wiq9LrzCiHkot
   HtKUNExfNQtRTftBtUGe9mlHWnVWC42YJu4+FzjBsiYYgofGJO2wZ08JL
   /eGfs6+GdTgqzl7AhO2VrLKg7NjGcpx0kFExl3ub6CIt2GWC6vJc8e7XW
   0I3ED5bVw/LzJUqGeLTTiQz6afGavFBjJXO/qIqiPMyL90CSGyP4lUMnV
   w==;
X-CSE-ConnectionGUID: erluOKD1TPCulaQkSXHuwQ==
X-CSE-MsgGUID: q7L7F3xUTQi5lRZJl+J9+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11230"; a="28758444"
X-IronPort-AV: E=Sophos;i="6.11,217,1725346800"; 
   d="scan'208";a="28758444"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2024 11:42:52 -0700
X-CSE-ConnectionGUID: MuFzSFCvSGeB6JE3n5nc6g==
X-CSE-MsgGUID: qlOqLla4RSyFHZDK4kSIUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,217,1725346800"; 
   d="scan'208";a="79205483"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 19 Oct 2024 11:42:51 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t2EPZ-000PQD-0t;
	Sat, 19 Oct 2024 18:42:49 +0000
Date: Sun, 20 Oct 2024 02:41:51 +0800
From: kernel test robot <lkp@intel.com>
To: Guixin Liu <kanie@linux.alibaba.com>, bhelgaas@google.com
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: optimize proc sequential file read
Message-ID: <202410200211.RFdwjJSq-lkp@intel.com>
References: <20241018054728.116519-1-kanie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241018054728.116519-1-kanie@linux.alibaba.com>

Hi Guixin,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus linus/master v6.12-rc3 next-2024101=
8]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Guixin-Liu/PCI-optim=
ize-proc-sequential-file-read/20241018-135026
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20241018054728.116519-1-kanie%40li=
nux.alibaba.com
patch subject: [PATCH] PCI: optimize proc sequential file read
config: loongarch-randconfig-r062-20241019 (https://download.01.org/0day-ci=
/archive/20241020/202410200211.RFdwjJSq-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archive=
/20241020/202410200211.RFdwjJSq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new versio=
n of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410200211.RFdwjJSq-lkp@i=
ntel.com/

All errors (new ones prefixed by >>):

   loongarch64-linux-ld: drivers/pci/probe.o: in function `.L549=021':
>> probe.c:(.text+0x2ff8): undefined reference to `pci_seq_tree_add_dev'
   loongarch64-linux-ld: drivers/pci/remove.o: in function `.LBB262':
>> drivers/pci/remove.c:56:(.text+0x398): undefined reference to `pci_seq_t=
ree_remove_dev'

--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

