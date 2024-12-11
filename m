Return-Path: <linux-pci+bounces-18153-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A32B99ECFCA
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 16:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBD4C1670CE
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 15:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7BB13C8E8;
	Wed, 11 Dec 2024 15:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UDMFaj5w"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95B313B5AE
	for <linux-pci@vger.kernel.org>; Wed, 11 Dec 2024 15:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733931205; cv=none; b=Twu1EejwVvnNpWbihFr8xZpfwn9ifI0TGOoVac8lJWnc8Q5gWbTCJuORKCDKYnkCb/28TS1TiczPsvWUEM+vqyrksDX//z/RIrtw2uvBRKtZY/iSYyFZlEwPRLpclnMYoW0If/mPXlWc9URGjbhNLHqGHJqGRqtYGsMbkxSJVyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733931205; c=relaxed/simple;
	bh=eX9tYjMf8PVgk1Kntv2I21r8w/dOQxwnYgzCNfeVSRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T8PSr44JbA380FcEPnaAwijP4mzKVZjm+i9zxRiK1zi61EgsvQLnhZgCidZNViXoh5ptkJFg2U06PMLiwWWgOnl82t04NDM5iwEwqH93BWEKI4DgKZZdj7M9ttLhOey4CnlxWdzofuoMiZQvt1sv0p03UUDhGTykfdJlV4Z4whE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UDMFaj5w; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733931202; x=1765467202;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eX9tYjMf8PVgk1Kntv2I21r8w/dOQxwnYgzCNfeVSRw=;
  b=UDMFaj5w7UHSpJm14Xk5RqlbvGYa59kMHtTrFlPUSlKl4Jp72H6Bqm6e
   veU86HrAYT6KB8cAuwgnz9j2+MjiTK4tblIia/NM6bzBARQ8kABUWh5ZC
   Q03meSxC4h1fTyTArouuAKzzAelCTloJ0QZJ4JfRGdexiOjOWv7hBM/hX
   sS0gcffwe7UItF2KKgwoHiHzaACIRr5Ndx4zjfTm8Yv9yLZI2QII7jFOL
   lLZ4qH5pN7Y218n82S6bEdpx+HOIgYaNjAqvKWVjZBtT0lMb0SVTP8jPp
   3wXaJS6TRDLZbyocIKQxf8+oFiQrUT5iTPIMGKbOqjI9OgAintYGKUgZy
   g==;
X-CSE-ConnectionGUID: 4p2zFAjGRtKi/t9i1IzOTg==
X-CSE-MsgGUID: n20gohFPTBykVZa1ChCT0w==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="44986100"
X-IronPort-AV: E=Sophos;i="6.12,226,1728975600"; 
   d="scan'208";a="44986100"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 07:33:21 -0800
X-CSE-ConnectionGUID: /cd+RTSiT+SCBCAGJYCUWA==
X-CSE-MsgGUID: 41lWl8bQTumt/0R2Mj+x6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="133230725"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 11 Dec 2024 07:33:18 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tLOiB-0006oT-1R;
	Wed, 11 Dec 2024 15:33:15 +0000
Date: Wed, 11 Dec 2024 23:32:52 +0800
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
Subject: Re: [PATCH v3 16/17] nvmet: New NVMe PCI endpoint target driver
Message-ID: <202412112307.uOdX4fWx-lkp@intel.com>
References: <20241210093408.105867-17-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210093408.105867-17-dlemoal@kernel.org>

Hi Damien,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus linus/master v6.13-rc2 next-20241211]
[cannot apply to hch-configfs/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Damien-Le-Moal/nvmet-Add-vendor_id-and-subsys_vendor_id-subsystem-attributes/20241210-174321
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20241210093408.105867-17-dlemoal%40kernel.org
patch subject: [PATCH v3 16/17] nvmet: New NVMe PCI endpoint target driver
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20241211/202412112307.uOdX4fWx-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241211/202412112307.uOdX4fWx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412112307.uOdX4fWx-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/nvme/target/pci-ep.c: In function 'nvmet_pciep_iod_name':
>> drivers/nvme/target/pci-ep.c:658:16: error: implicit declaration of function 'nvme_opcode_str'; did you mean 'nvme_opcode_name'? [-Wimplicit-function-declaration]
     658 |         return nvme_opcode_str(iod->sq->qid, iod->cmd.common.opcode);
         |                ^~~~~~~~~~~~~~~
         |                nvme_opcode_name
>> drivers/nvme/target/pci-ep.c:658:16: error: returning 'int' from a function with return type 'const char *' makes pointer from integer without a cast [-Wint-conversion]
     658 |         return nvme_opcode_str(iod->sq->qid, iod->cmd.common.opcode);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +658 drivers/nvme/target/pci-ep.c

   655	
   656	static inline const char *nvmet_pciep_iod_name(struct nvmet_pciep_iod *iod)
   657	{
 > 658		return nvme_opcode_str(iod->sq->qid, iod->cmd.common.opcode);
   659	}
   660	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

