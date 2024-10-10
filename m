Return-Path: <linux-pci+bounces-14194-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFA999895F
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 16:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4D7B1C24065
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 14:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF871CBE80;
	Thu, 10 Oct 2024 14:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AUTjORlr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D601CF5CD;
	Thu, 10 Oct 2024 14:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728569841; cv=none; b=U3diJC4I71zY03eACO85g75JSBg9rdRKDpxj0b/JR/MoXS/ylu5/H9Ui+q9CjifzYfQ6slfl8YM1GHoyjGyaLVGSbqZFdMc3FelRvcHzIsKOMAI44w+KiOm1328KIim0OmV4wARwO2+cXVf5LHA4BgMQnNXY+skMBqWZyMA93jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728569841; c=relaxed/simple;
	bh=1PjyvsczcSZkLe66VAcgR3YAMDFQk4KexMDCjSwoyms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AR6uff4ZcKc1erfz4SRqw184jcAtOmVvIn47/hgHVx++1F8PgYxHH2WsliVFyu9bteM3t5OXRlHXvx5MP3ouyp/853g6n2bf4MOaRkJp/XhSvweHRUR+dipkGMGDUveLG7PDRbeZVvMZQMmaEkUhNl0v1aBr0vjbFuJdyjOriK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AUTjORlr; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728569840; x=1760105840;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1PjyvsczcSZkLe66VAcgR3YAMDFQk4KexMDCjSwoyms=;
  b=AUTjORlrSUFekQIVL6S1+dH9Um86untBaO6qG64zMhmYNppPmFkpw3Zh
   0ualb9Iyr67BddJoXR5agbktnmIt1ZyCKzRpvmjPpfiKMnYD4VZfkY9yS
   YjxfkTmKRABn/ZwXKYagshrmQCAXWate7ZRbkKic+a8i3ACF1ixtHO6xR
   pYy3TpadyFCddxylUYuXOXavxhjbNlevLeW0sZP5sfB1hT720d74E7BjW
   iWNXrT5UChOvwDdhGBBueMv16cEUSdaADRG0cwfjXAfpbHQ9mad5pGj/2
   JIDXQ5wqVrMKLh1+yvGQoxBKZsMladJEGTqDbkQOwg6azfeyBBJoiMSRU
   w==;
X-CSE-ConnectionGUID: BprFDYv0SLyqm0vqo6W2lg==
X-CSE-MsgGUID: guNXru2YQwuopl2wvkgNPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="27401180"
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="27401180"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 07:17:19 -0700
X-CSE-ConnectionGUID: 4SQEOs7RRGOFSVe0M1xdRg==
X-CSE-MsgGUID: f58R46SvTY27ZWTBzSxC5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="107331102"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 10 Oct 2024 07:17:14 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sytya-000Aq9-1E;
	Thu, 10 Oct 2024 14:17:12 +0000
Date: Thu, 10 Oct 2024 22:16:35 +0800
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
Message-ID: <202410102136.jQHZOcS4-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Wei-Fang/dt-bindings-net-add-compatible-string-for-i-MX95-EMDIO/20241009-181113
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241009095116.147412-6-wei.fang%40nxp.com
patch subject: [PATCH net-next 05/11] net: enetc: add enetc-pf-common driver support
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20241010/202410102136.jQHZOcS4-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241010/202410102136.jQHZOcS4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410102136.jQHZOcS4-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/ethernet/freescale/enetc/enetc_pf_common.c:3:
>> include/linux/fsl/enetc_mdio.h:62:18: warning: no previous prototype for 'enetc_hw_alloc' [-Wmissing-prototypes]
      62 | struct enetc_hw *enetc_hw_alloc(struct device *dev, void __iomem *port_regs)
         |                  ^~~~~~~~~~~~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [m]:
   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]


vim +/enetc_hw_alloc +62 include/linux/fsl/enetc_mdio.h

6517798dd3432a Claudiu Manoil 2020-01-06  49  
80e87442e69ba8 Andrew Lunn    2023-01-12  50  static inline int enetc_mdio_read_c22(struct mii_bus *bus, int phy_id,
80e87442e69ba8 Andrew Lunn    2023-01-12  51  				      int regnum)
6517798dd3432a Claudiu Manoil 2020-01-06  52  { return -EINVAL; }
80e87442e69ba8 Andrew Lunn    2023-01-12  53  static inline int enetc_mdio_write_c22(struct mii_bus *bus, int phy_id,
80e87442e69ba8 Andrew Lunn    2023-01-12  54  				       int regnum, u16 value)
80e87442e69ba8 Andrew Lunn    2023-01-12  55  { return -EINVAL; }
80e87442e69ba8 Andrew Lunn    2023-01-12  56  static inline int enetc_mdio_read_c45(struct mii_bus *bus, int phy_id,
80e87442e69ba8 Andrew Lunn    2023-01-12  57  				      int devad, int regnum)
80e87442e69ba8 Andrew Lunn    2023-01-12  58  { return -EINVAL; }
80e87442e69ba8 Andrew Lunn    2023-01-12  59  static inline int enetc_mdio_write_c45(struct mii_bus *bus, int phy_id,
80e87442e69ba8 Andrew Lunn    2023-01-12  60  				       int devad, int regnum, u16 value)
6517798dd3432a Claudiu Manoil 2020-01-06  61  { return -EINVAL; }
6517798dd3432a Claudiu Manoil 2020-01-06 @62  struct enetc_hw *enetc_hw_alloc(struct device *dev, void __iomem *port_regs)
6517798dd3432a Claudiu Manoil 2020-01-06  63  { return ERR_PTR(-EINVAL); }
6517798dd3432a Claudiu Manoil 2020-01-06  64  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

