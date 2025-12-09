Return-Path: <linux-pci+bounces-42865-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D2791CB0E46
	for <lists+linux-pci@lfdr.de>; Tue, 09 Dec 2025 19:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 65BAE301B278
	for <lists+linux-pci@lfdr.de>; Tue,  9 Dec 2025 18:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9058A3043C0;
	Tue,  9 Dec 2025 18:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m50s0uIZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0894303A2C;
	Tue,  9 Dec 2025 18:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765306689; cv=none; b=D3G6S6TN++2G7EjbGU2lkynY4q2j0X6aMGIjYdbqG44CP3sreX2qF04qtMEYtEtl+Boi5DjqFdbj4xcPlcn2GIJQqm8TNZJs74QkxihGzd8n5XqL+JuVgwvUhMofUo0K4VJWeDoG9vIQY6dXBylTpf5isFSLTjfDs3BetDdTn38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765306689; c=relaxed/simple;
	bh=/R2b+c2Djj+Nr/3dJwUquZPYWsnsbW4lIXCs17tYU+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YVOKALAJeb4pZvc4mKtL0z91or0X7wgWCc3Wkb/B1Bh7ilDtGB1+L1sbsB+uluqD/GIP1bKggTJ9lM0pPjohL/A4sEYcVq9MFfVWxO+7ZK7BXVRiaseF/9LobQEM0eXvTdcImSdcl5CE5h2z5EftlpKx/vKC8FWlHTvPkmZjtmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m50s0uIZ; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765306688; x=1796842688;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/R2b+c2Djj+Nr/3dJwUquZPYWsnsbW4lIXCs17tYU+w=;
  b=m50s0uIZZwRK8HOnFLlYBTgZbydaRXKKRhGNUZgpZZUSVhQTGaSshaP2
   Y1aXYyIpcvqw+hEk7ETO3q2KUSn+P1G7nIJUeuLAtrMvHKa9lxju2oYEd
   OPQNC8VJ4CY5cXdCu2C+VaDmL/aUWpKh7Gm0sSPcNBR5yhu2abAhtiD2t
   bOVmXLJp0n1KX1g+O+QGXITFM4xhtxEtgP2kbyDeg8/AAxlfNW6+UB1G+
   uL9EH5DoeV6dUz+mNc3YJP7D7Y8HoJvFKnR9bNPh1lbk0H4uT6WupAzwV
   j+Mmo83GPib7WSMmfotcEqHncRz3FZNXYgmWs1elENtVtp++m1D73LuuI
   A==;
X-CSE-ConnectionGUID: GX618YcpRz+OTSoRTlW79w==
X-CSE-MsgGUID: a9BR/y+FTEOtqSONrvsE3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11637"; a="67157901"
X-IronPort-AV: E=Sophos;i="6.20,262,1758610800"; 
   d="scan'208";a="67157901"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2025 10:58:07 -0800
X-CSE-ConnectionGUID: 4l+G88yhTlCH/s3aZiA6oQ==
X-CSE-MsgGUID: FnSylMOyQkeoz9f5+WcDLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,262,1758610800"; 
   d="scan'208";a="200727253"
Received: from lkp-server01.sh.intel.com (HELO d335e3c6db51) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 09 Dec 2025 10:58:03 -0800
Received: from kbuild by d335e3c6db51 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vT2uP-000000002B9-0SNj;
	Tue, 09 Dec 2025 18:58:01 +0000
Date: Wed, 10 Dec 2025 02:57:35 +0800
From: kernel test robot <lkp@intel.com>
To: Tony Hutter <hutter2@llnl.gov>, Lukas Wunner <lukas@wunner.de>,
	Bjorn Helgaas <helgaas@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, corey@minyard.net,
	alok.a.tiwari@oracle.com, mariusz.tkaczyk@linux.intel.com,
	minyard@acm.org, linux-pci@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7] Introduce Cray ClusterStor E1000 NVMe slot LED driver
Message-ID: <202512100217.dWKoNRzG-lkp@intel.com>
References: <d422a22c-a6fe-4543-ae16-67d64260e0cf@llnl.gov>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d422a22c-a6fe-4543-ae16-67d64260e0cf@llnl.gov>

Hi Tony,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus linus/master v6.18 next-20251209]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tony-Hutter/Introduce-Cray-ClusterStor-E1000-NVMe-slot-LED-driver/20251209-094846
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/d422a22c-a6fe-4543-ae16-67d64260e0cf%40llnl.gov
patch subject: [PATCH v7] Introduce Cray ClusterStor E1000 NVMe slot LED driver
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20251210/202512100217.dWKoNRzG-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251210/202512100217.dWKoNRzG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512100217.dWKoNRzG-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/pci/hotplug/pciehp_craye1k.c: In function 'craye1k_get_attention_status':
>> drivers/pci/hotplug/pciehp_craye1k.c:570:25: warning: variable 'craye1k' set but not used [-Wunused-but-set-variable]
     570 |         struct craye1k *craye1k;
         |                         ^~~~~~~


vim +/craye1k +570 drivers/pci/hotplug/pciehp_craye1k.c

   565	
   566	int craye1k_get_attention_status(struct hotplug_slot *hotplug_slot,
   567					 u8 *status)
   568	{
   569		int rc;
 > 570		struct craye1k *craye1k;
   571	
   572		if (mutex_lock_interruptible(&craye1k_lock) != 0)
   573			return -EINTR;
   574	
   575		if (!craye1k_global) {
   576			/* Driver isn't initialized yet */
   577			mutex_unlock(&craye1k_lock);
   578			return -EOPNOTSUPP;
   579		}
   580	
   581		craye1k = craye1k_global;
   582	
   583		rc =  __craye1k_get_attention_status(hotplug_slot, status, true);
   584	
   585		mutex_unlock(&craye1k_lock);
   586		return rc;
   587	}
   588	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

