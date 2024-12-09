Return-Path: <linux-pci+bounces-17896-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F829E89E2
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 04:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A0BC1616EF
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 03:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AC815573D;
	Mon,  9 Dec 2024 03:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hJfOyi9s"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E7415665D
	for <linux-pci@vger.kernel.org>; Mon,  9 Dec 2024 03:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733715667; cv=none; b=rIgcuDZNoCL0JKtXohGiKV1oa/QwoK26nSf6+SLfR3F/7xzI27Ws8jJvAEXInHBy9VRKaJTyw40ZlrIPnIc22brcqYi0sg8f9b0qUMrSLabLDKKz5BjQ+9+GBa6umN0fEsfPSx9Vjp1k797g+X50UPwFfWE8i01JSOcfEVGI5XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733715667; c=relaxed/simple;
	bh=uTNZqUf0pQn0sEQrdm6iDAs3Wxr8P+TD55zoNhMtirs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rn8XU/QJFApoVB4BiyNK0POGgfVobuZhfLjSk7aPK1B4I0RY+BEhdvHrburDkd8UScw5hKJsJu1f1KVmIbqxojq3F6IxpfPDy/j+xlJsh70MKMG33ROHZUlKL3HnzQTGM+yAoCKyhDgHaWvzPOz3HSVNXNxgt901p6KTFF2rQsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hJfOyi9s; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733715665; x=1765251665;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uTNZqUf0pQn0sEQrdm6iDAs3Wxr8P+TD55zoNhMtirs=;
  b=hJfOyi9sKwftQeeFFOPJunelHcU9tFayxzJn+Wyvo0cYLP54GYzwCOTT
   n+k0kxiMb8qNqefhX+swC7e2kPXxW9QMyefldLPUSI6/9MCEAor4yfEcD
   WLhw0k/sqNTa4VHiBufyCLFHZjF1s5KDO8c54fEfZ57g3dl/Uvzo5js+y
   MOChlNOxGaVTa4pMLf0DE7rwtHciEVtpKS2yFtujqMezj6AZBl/hXIi6Y
   K/Ldqqpj8NNWpHEumr5wcjbVdrW/nyubuY6Te+zV+tQHurT1ZTppJa9bL
   cUEnxbW8jk7B/TuVBlJqg+0w29iamyEZSPsWT41M+ag9LUKyol9CHNZYA
   g==;
X-CSE-ConnectionGUID: JKrOw+NhQJyGAviuGYJIBA==
X-CSE-MsgGUID: bfYJqTTGQfqgUGll/1o14w==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="59400868"
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="59400868"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 19:41:04 -0800
X-CSE-ConnectionGUID: r2ecLHP2Tx+V7jisDXIsfQ==
X-CSE-MsgGUID: 6gJ3FpjhQjW8LbqAi4o5JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="99895657"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 08 Dec 2024 19:41:01 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tKUdn-0003k9-0E;
	Mon, 09 Dec 2024 03:40:59 +0000
Date: Mon, 9 Dec 2024 11:40:32 +0800
From: kernel test robot <lkp@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, Bjorn Helgaas <helgaas@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, linux-pci@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH 06/11] samples/devsec: PCI device-security bus / endpoint
 sample
Message-ID: <202412070726.Au4TQYYS-lkp@intel.com>
References: <173343743095.1074769.17985181033044298157.stgit@dwillia2-xfh.jf.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173343743095.1074769.17985181033044298157.stgit@dwillia2-xfh.jf.intel.com>

Hi Dan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 40384c840ea1944d7c5a392e8975ed088ecf0b37]

url:    https://github.com/intel-lab-lkp/linux/commits/Dan-Williams/configfs-tsm-Namespace-TSM-report-symbols/20241206-064224
base:   40384c840ea1944d7c5a392e8975ed088ecf0b37
patch link:    https://lore.kernel.org/r/173343743095.1074769.17985181033044298157.stgit%40dwillia2-xfh.jf.intel.com
patch subject: [PATCH 06/11] samples/devsec: PCI device-security bus / endpoint sample
config: i386-randconfig-r123-20241206 (https://download.01.org/0day-ci/archive/20241207/202412070726.Au4TQYYS-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241207/202412070726.Au4TQYYS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412070726.Au4TQYYS-lkp@intel.com/

All warnings (new ones prefixed by >>):

   samples/devsec/bus.c: In function 'doe_process':
>> samples/devsec/bus.c:172:18: warning: variable 'index' set but not used [-Wunused-but-set-variable]
     172 |         u8 type, index;
         |                  ^~~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for TSM
   Depends on [n]: VIRT_DRIVERS [=n]
   Selected by [y]:
   - SAMPLE_DEVSEC [=y] && SAMPLES [=y] && PCI [=y] && X86 [=y]

sparse warnings: (new ones prefixed by >>)
>> samples/devsec/bus.c:539:37: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] subsystem_vendor_id @@     got restricted __le16 [usertype] @@
   samples/devsec/bus.c:539:37: sparse:     expected unsigned short [usertype] subsystem_vendor_id
   samples/devsec/bus.c:539:37: sparse:     got restricted __le16 [usertype]
>> samples/devsec/bus.c:546:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] devcap @@     got restricted __le16 [usertype] @@
   samples/devsec/bus.c:546:34: sparse:     expected restricted __le32 [usertype] devcap
   samples/devsec/bus.c:546:34: sparse:     got restricted __le16 [usertype]
>> samples/devsec/bus.c:609:59: sparse: sparse: cast truncates bits from constant value (1000000000 becomes 0)

vim +/index +172 samples/devsec/bus.c

   168	
   169	/* just indicate support for CMA */
   170	static void doe_process(struct devsec_dev_doe *doe)
   171	{
 > 172		u8 type, index;
   173		u16 vid;
   174	
   175		vid = FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_VID, doe->req[0]);
   176		type = FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_TYPE, doe->req[0]);
   177	
   178		if (vid != PCI_VENDOR_ID_PCI_SIG) {
   179			doe->read_ttl = -1;
   180			return;
   181		}
   182	
   183		if (type != PCI_DOE_PROTOCOL_DISCOVERY) {
   184			doe->read_ttl = -1;
   185			return;
   186		}
   187	
   188		index = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX, doe->req[2]);
   189	
   190		doe->rsp[0] = doe->req[0];
   191		doe->rsp[1] = FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH, 3);
   192		doe->read_ttl = 3;
   193		doe->rsp[2] = FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_RSP_3_VID,
   194					 PCI_VENDOR_ID_PCI_SIG) |
   195			      FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL,
   196					 PCI_DOE_FEATURE_CMA) |
   197			      FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX, 0);
   198	}
   199	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

