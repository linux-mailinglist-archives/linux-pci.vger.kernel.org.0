Return-Path: <linux-pci+bounces-19086-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CD29FDDAE
	for <lists+linux-pci@lfdr.de>; Sun, 29 Dec 2024 07:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90F6E7A12D3
	for <lists+linux-pci@lfdr.de>; Sun, 29 Dec 2024 06:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC983BBC9;
	Sun, 29 Dec 2024 06:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eMVBGo2R"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C982AD0F
	for <linux-pci@vger.kernel.org>; Sun, 29 Dec 2024 06:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735455247; cv=none; b=A8oPRxiXwTJlGDbdc/MS+4L5BAmbhm2R2B8Z4J3kD5J35/ojOV48ITlR9uvGzDb48bv9HymkuEOj4OZJFj1TSV/zZqGAvryWot48x7f4XpFRHkwpzuRfwuWGhE8u7or692MuS8LA8LhYnRSjeyGa39xVk2tPyCsbHByf9BDoOzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735455247; c=relaxed/simple;
	bh=W4tnXakf0kq3vxryWjAQNS8a3zjroqDKu75yuKQsQlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CIBd9Ffk3SW9h9DCYgbNR3zfCGqk8uxW6+yuTzTLuX3uv9LddEV5+McuzR7I3XPOtxQr5Snp6kNltQDjJ/syZcpHzJ0OsPN51witnKBFc8D7lK6o0oDGD7NTDamAYFMNhWdgr7FR15Cco4l77EBELkP8Zk7gnWhXsrMVETSoFPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eMVBGo2R; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735455246; x=1766991246;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W4tnXakf0kq3vxryWjAQNS8a3zjroqDKu75yuKQsQlU=;
  b=eMVBGo2R8D2pOu2QBZMki9PbcCFtO/lVJoFTNJ/+XKvkySjFBs+eLGBP
   7A/kI1bolDCjPnfBSW22KiTmSr0TkFjMa0XjYszsg4q87EklPY3AJuyOy
   DRQ75t5BgywowVJuGEwnsQnk5fINoujowp4sXeHCAJFzfwfP8SkvaONh8
   1nH+hLQ9k12h1OqmdYzCP1sWlyipQNOoNCUc0Zi7Ds+u9cSNTdYFryDTy
   oKNMAIDO+m0mJaXwlkLcqMXrXqsY0U0PqSFbd7L4qIq7pASdKBbUDiuId
   +tgSrfttA8Pme6F/Ujqp7Jq43j1KGD5pbEiBUnZPpM5geymxmphhkegWW
   Q==;
X-CSE-ConnectionGUID: KhPrsPZPRO+qPEcOpGZrnw==
X-CSE-MsgGUID: rMuKDq/lS/Gemzk/DqX/Ng==
X-IronPort-AV: E=McAfee;i="6700,10204,11299"; a="39466502"
X-IronPort-AV: E=Sophos;i="6.12,273,1728975600"; 
   d="scan'208";a="39466502"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2024 22:54:05 -0800
X-CSE-ConnectionGUID: 5tXAXnFMTt+Crm/OSuw3TQ==
X-CSE-MsgGUID: KKO77kzwQG28faSx55L2Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,273,1728975600"; 
   d="scan'208";a="105358263"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 28 Dec 2024 22:54:01 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tRnBX-0004XY-2U;
	Sun, 29 Dec 2024 06:53:59 +0000
Date: Sun, 29 Dec 2024 14:53:18 +0800
From: kernel test robot <lkp@intel.com>
To: Damien Le Moal <dlemoal@kernel.org>, linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v8 17/18] nvmet: New NVMe PCI endpoint function target
 driver
Message-ID: <202412291432.nDgfmkwD-lkp@intel.com>
References: <20241225082956.96650-18-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241225082956.96650-18-dlemoal@kernel.org>

Hi Damien,

kernel test robot noticed the following build errors:

[auto build test ERROR on 4bbf9020becbfd8fc2c3da790855b7042fad455b]

url:    https://github.com/intel-lab-lkp/linux/commits/Damien-Le-Moal/nvme-Move-opcode-string-helper-functions-declarations/20241225-163855
base:   4bbf9020becbfd8fc2c3da790855b7042fad455b
patch link:    https://lore.kernel.org/r/20241225082956.96650-18-dlemoal%40kernel.org
patch subject: [PATCH v8 17/18] nvmet: New NVMe PCI endpoint function target driver
config: alpha-randconfig-r072-20241228 (https://download.01.org/0day-ci/archive/20241229/202412291432.nDgfmkwD-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241229/202412291432.nDgfmkwD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412291432.nDgfmkwD-lkp@intel.com/

All errors (new ones prefixed by >>):

   alpha-linux-ld: drivers/nvme/target/pci-epf.o: in function `nvmet_pci_epf_complete_iod':
>> (.text+0x2a38): undefined reference to `nvme_get_opcode_str'
>> alpha-linux-ld: (.text+0x2a3c): undefined reference to `nvme_get_opcode_str'
>> alpha-linux-ld: (.text+0x2b24): undefined reference to `nvme_get_admin_opcode_str'
   alpha-linux-ld: (.text+0x2b28): undefined reference to `nvme_get_admin_opcode_str'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

