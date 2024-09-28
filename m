Return-Path: <linux-pci+bounces-13622-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 878989891E2
	for <lists+linux-pci@lfdr.de>; Sun, 29 Sep 2024 00:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 255651F2388C
	for <lists+linux-pci@lfdr.de>; Sat, 28 Sep 2024 22:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A745018734F;
	Sat, 28 Sep 2024 22:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZaRm8IAU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CBD1F5EA;
	Sat, 28 Sep 2024 22:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727562069; cv=none; b=XZ8htIDUnSxYHWClI/2HeDN8LIeyePyfgt8HSeKGHABywZqO4RfDOHYtLOYLxIrDJ/0r4i33OifGvSwfGnG3miQZSdygvg5dirQuTjnWtDS7crH9uN5xPJuUAPiiiV/tU67ROfxaaO+94Pm9jbjKFWtPIvoTOKYmiLaUlhksiUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727562069; c=relaxed/simple;
	bh=753n/HZnmHMAeAEp/81I+HWoLFnnpgyNJSj2QobhRAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t+8mcm98UiUJhk5ZWFVlbe7I6OsnDCKNaq8k1yaWsaQMBgZuslRuZY+mXTXVY2V4UB2BR+lKTksrS3WyJX3l4xdaQzalQbcKN+RdLy8juv0jTZ2UXPe4urGqeC4trC5kve3xAfUaXPd8KpEUkr0A6QbCxD5nZl9qjTUA2T+LLBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZaRm8IAU; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727562068; x=1759098068;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=753n/HZnmHMAeAEp/81I+HWoLFnnpgyNJSj2QobhRAI=;
  b=ZaRm8IAUdNKloL8n7zj6tQSWg5EGKegpjRY1f+Pe21X4JYfMm2sshBt8
   C391kDDtynyFuvgOxGLj/LLAfcoBJ4cFxH81gxAukC374vCfpFdaSH/Ds
   A8Lw5I+EN+PHKfmWrYMIin5FIKcYLeWWXuQ9uK9/VBLY4MYUm0AcLgeys
   VAFfhz3PtNxiCNAEsJM/6xrumZmnI1i65Y54VjsD8bgtcndEzzB3Jl+FC
   uptQ4NtBokAxyY0eJCnsU/Cbzk15pqsbKdgUyjegQ4bUgeNLeWwvXJofo
   G1PCF8ZDISGl0fALtVq7iOBqV758cbQlw4aviTw4XORTil031br7iLpCs
   w==;
X-CSE-ConnectionGUID: Wa6qfH7FSASG3jfRLf8ngQ==
X-CSE-MsgGUID: 6GHH03N7SmOVWOWc9Qo29Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11209"; a="37247974"
X-IronPort-AV: E=Sophos;i="6.11,162,1725346800"; 
   d="scan'208";a="37247974"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2024 15:21:07 -0700
X-CSE-ConnectionGUID: SZ77uNqsRS+YvGRrXkIpJQ==
X-CSE-MsgGUID: EF6fF7mjRKyzfeRhvubsoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,162,1725346800"; 
   d="scan'208";a="73183641"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 28 Sep 2024 15:21:01 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sufoA-000Nhj-2I;
	Sat, 28 Sep 2024 22:20:58 +0000
Date: Sun, 29 Sep 2024 06:20:01 +0800
From: kernel test robot <lkp@intel.com>
To: Wei Huang <wei.huang2@amd.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Jonathan.Cameron@huawei.com,
	helgaas@kernel.org, corbet@lwn.net, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	alex.williamson@redhat.com, gospo@broadcom.com,
	michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
	somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com,
	manoj.panicker2@amd.com, Eric.VanTassell@amd.com,
	wei.huang2@amd.com, vadim.fedorenko@linux.dev, horms@kernel.org,
	bagasdotme@gmail.com, bhelgaas@google.com, lukas@wunner.de,
	paul.e.luse@intel.com, jing2.liu@intel.com
Subject: Re: [PATCH V6 2/5] PCI/TPH: Add Steering Tag support
Message-ID: <202409290628.jR98LDA9-lkp@intel.com>
References: <20240927215653.1552411-3-wei.huang2@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927215653.1552411-3-wei.huang2@amd.com>

Hi Wei,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus linus/master next-20240927]
[cannot apply to v6.11]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wei-Huang/PCI-Add-TLP-Processing-Hints-TPH-support/20240928-055915
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20240927215653.1552411-3-wei.huang2%40amd.com
patch subject: [PATCH V6 2/5] PCI/TPH: Add Steering Tag support
config: sparc64-randconfig-r062-20240929 (https://download.01.org/0day-ci/archive/20240929/202409290628.jR98LDA9-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240929/202409290628.jR98LDA9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409290628.jR98LDA9-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pci/tph.c: In function 'write_tag_to_msix':
>> drivers/pci/tph.c:230:26: error: 'struct pci_dev' has no member named 'msix_base'; did you mean 'msix_cap'?
     230 |         vec_ctrl = pdev->msix_base + msix_idx * PCI_MSIX_ENTRY_SIZE;
         |                          ^~~~~~~~~
         |                          msix_cap


vim +230 drivers/pci/tph.c

   205	
   206	/* Write ST to MSI-X vector control reg - Return 0 if OK, otherwise -errno */
   207	static int write_tag_to_msix(struct pci_dev *pdev, int msix_idx, u16 tag)
   208	{
   209		struct msi_desc *msi_desc = NULL;
   210		void __iomem *vec_ctrl;
   211		u32 val, mask, st_val;
   212		int err = 0;
   213	
   214		msi_lock_descs(&pdev->dev);
   215	
   216		/* Find the msi_desc entry with matching msix_idx */
   217		msi_for_each_desc(msi_desc, &pdev->dev, MSI_DESC_ASSOCIATED) {
   218			if (msi_desc->msi_index == msix_idx)
   219				break;
   220		}
   221	
   222		if (!msi_desc) {
   223			err = -ENXIO;
   224			goto err_out;
   225		}
   226	
   227		st_val = (u32)tag;
   228	
   229		/* Get the vector control register (offset 0xc) pointed by msix_idx */
 > 230		vec_ctrl = pdev->msix_base + msix_idx * PCI_MSIX_ENTRY_SIZE;
   231		vec_ctrl += PCI_MSIX_ENTRY_VECTOR_CTRL;
   232	
   233		val = readl(vec_ctrl);
   234		mask = PCI_MSIX_ENTRY_CTRL_ST_LOWER | PCI_MSIX_ENTRY_CTRL_ST_UPPER;
   235		val &= ~mask;
   236		val |= FIELD_PREP(mask, st_val);
   237		writel(val, vec_ctrl);
   238	
   239		/* Read back to flush the update */
   240		val = readl(vec_ctrl);
   241	
   242	err_out:
   243		msi_unlock_descs(&pdev->dev);
   244		return err;
   245	}
   246	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

