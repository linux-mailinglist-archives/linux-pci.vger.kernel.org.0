Return-Path: <linux-pci+bounces-14408-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4C099B7FB
	for <lists+linux-pci@lfdr.de>; Sun, 13 Oct 2024 04:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74634282731
	for <lists+linux-pci@lfdr.de>; Sun, 13 Oct 2024 02:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6490C17FE;
	Sun, 13 Oct 2024 02:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WrGhdZ5A"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF6B231CB4;
	Sun, 13 Oct 2024 02:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728786519; cv=none; b=WZNJvP/XDC6z4S0P8ZPlkKLwc41VsmO18Jacuu2ydgyOk7OPbJApwa+zI09a4V5ED8v4gT2bul0TEM3nPt8Ylwg572Hb9dH31Zw/SY23rFa7ClQjzXQ4TlNg2FufbLenXrj5GIUocpFQvYk+K2VTvXW62SITUW0wPCSStZz56JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728786519; c=relaxed/simple;
	bh=kxw0/5KQqdN8nbP5+1lX3aIizA0MM7Ku7mcSHuuSt78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pfRNniVbwgyDqa9gsiW9kggoJNDalfkUrpa9MnT6DSqLcY5EEgyLVUad2xl4x2JlwgrahdFS4p9zEjAY5TTkqr39LszECLgg9zUixypzbmPU3+n37CbiBFzrFJA2yoJ/YkojGDnQarebqiDglGXu8PUVG1Z8Efn8QXXqtNN9fZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WrGhdZ5A; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728786517; x=1760322517;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kxw0/5KQqdN8nbP5+1lX3aIizA0MM7Ku7mcSHuuSt78=;
  b=WrGhdZ5AosXWjiZOSFaMtToHiFij0gvT1WZ4p2gR0ui5X1+7VztdCtae
   proKltb9ZHkdec2Lkpp+7nO3PXKEehyL3ZISX6TP6PIInjNG3+8Kbgkkn
   6DQn4WTucTt21rZvqFVciFESRTb4NlMgwslJflFITKxFXpGPnZrhSXKaE
   +WfBlreK82gMioCsQdSYKqaE5llbKInDKxH17AAv3r02Nyax+qJ4j3M9w
   CSJCThAy0z1FxxU8emEIiFihUO94WXMlec9v+8jDCjbnA8qqnSzfpXoU+
   JvnoemjKwTiZhd5ofU7qOak8TI25BP5bkyrJhAfKIA57mDiAJQa/jk//V
   g==;
X-CSE-ConnectionGUID: CS5TS9tHTUitzBFIhjFP7g==
X-CSE-MsgGUID: jv2in9R0S8uMllx732FifQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="38731315"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="38731315"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2024 19:28:37 -0700
X-CSE-ConnectionGUID: do3bFO2CTB68Q54myxA8Nw==
X-CSE-MsgGUID: pH9+hgyLT8y7Svldl/1AxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="77172345"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 12 Oct 2024 19:28:32 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1szoLN-000E0B-1Z;
	Sun, 13 Oct 2024 02:28:29 +0000
Date: Sun, 13 Oct 2024 10:27:32 +0800
From: kernel test robot <lkp@intel.com>
To: Wei Fang <wei.fang@nxp.com>, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, vladimir.oltean@nxp.com,
	claudiu.manoil@nxp.com, xiaoning.wang@nxp.com, Frank.Li@nxp.com,
	christophe.leroy@csgroup.eu, linux@armlinux.org.uk,
	bhelgaas@google.com
Cc: oe-kbuild-all@lists.linux.dev, imx@lists.linux.dev,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH net-next 05/11] net: enetc: add enetc-pf-common driver
 support
Message-ID: <202410131001.KjFCfYWr-lkp@intel.com>
References: <20241009095116.147412-6-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009095116.147412-6-wei.fang@nxp.com>

Hi Wei,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Wei-Fang/dt-bindings-net-add-compatible-string-for-i-MX95-EMDIO/20241009-181113
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241009095116.147412-6-wei.fang%40nxp.com
patch subject: [PATCH net-next 05/11] net: enetc: add enetc-pf-common driver support
config: powerpc-randconfig-r062-20241013 (https://download.01.org/0day-ci/archive/20241013/202410131001.KjFCfYWr-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241013/202410131001.KjFCfYWr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410131001.KjFCfYWr-lkp@intel.com/

All errors (new ones prefixed by >>):

   powerpc-linux-ld: drivers/net/ethernet/freescale/enetc/enetc_pf_common.o: in function `enetc_sriov_configure':
>> drivers/net/ethernet/freescale/enetc/enetc_pf_common.c:336:(.text+0x55c): undefined reference to `enetc_msg_psi_free'
>> powerpc-linux-ld: drivers/net/ethernet/freescale/enetc/enetc_pf_common.c:349:(.text+0x5e4): undefined reference to `enetc_msg_psi_init'
>> powerpc-linux-ld: drivers/net/ethernet/freescale/enetc/enetc_pf_common.c:365:(.text+0x658): undefined reference to `enetc_msg_psi_free'
   powerpc-linux-ld: drivers/net/ethernet/freescale/enetc/enetc_pf_common.o: in function `enetc_pf_netdev_setup':
   drivers/net/ethernet/freescale/enetc/enetc_pf_common.c:106:(.text+0xb00): undefined reference to `enetc_set_ethtool_ops'


vim +336 drivers/net/ethernet/freescale/enetc/enetc_pf_common.c

   324	
   325	int enetc_sriov_configure(struct pci_dev *pdev, int num_vfs)
   326	{
   327		struct enetc_si *si = pci_get_drvdata(pdev);
   328		struct enetc_pf *pf = enetc_si_priv(si);
   329		int err;
   330	
   331		if (!IS_ENABLED(CONFIG_PCI_IOV))
   332			return 0;
   333	
   334		if (!num_vfs) {
   335			pci_disable_sriov(pdev);
 > 336			enetc_msg_psi_free(pf);
   337			kfree(pf->vf_state);
   338			pf->num_vfs = 0;
   339		} else {
   340			pf->num_vfs = num_vfs;
   341	
   342			pf->vf_state = kcalloc(num_vfs, sizeof(struct enetc_vf_state),
   343					       GFP_KERNEL);
   344			if (!pf->vf_state) {
   345				pf->num_vfs = 0;
   346				return -ENOMEM;
   347			}
   348	
 > 349			err = enetc_msg_psi_init(pf);
   350			if (err) {
   351				dev_err(&pdev->dev, "enetc_msg_psi_init (%d)\n", err);
   352				goto err_msg_psi;
   353			}
   354	
   355			err = pci_enable_sriov(pdev, num_vfs);
   356			if (err) {
   357				dev_err(&pdev->dev, "pci_enable_sriov err %d\n", err);
   358				goto err_en_sriov;
   359			}
   360		}
   361	
   362		return num_vfs;
   363	
   364	err_en_sriov:
 > 365		enetc_msg_psi_free(pf);
   366	err_msg_psi:
   367		kfree(pf->vf_state);
   368		pf->num_vfs = 0;
   369	
   370		return err;
   371	}
   372	EXPORT_SYMBOL_GPL(enetc_sriov_configure);
   373	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

