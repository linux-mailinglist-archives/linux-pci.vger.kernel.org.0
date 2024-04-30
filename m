Return-Path: <linux-pci+bounces-6912-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E5A8B822D
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 23:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2948B20D3E
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 21:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB841BED8A;
	Tue, 30 Apr 2024 21:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lzdxmG8G"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A531BED7A;
	Tue, 30 Apr 2024 21:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714514167; cv=none; b=IU042oAgtqkU9uU7zzOE8dAKZpTfXgxfE5BvJ5QQ57i/y8+I7OguNLdjSb1nMm2dxAd/RHlpqt0wfh9MQAIBKjnzg8RZ/kfaKbMm5bNNc2ixJiM2YBGE3x58+qTwE/XNet6QHi0gVH0h9AN0s8Mbb41tgwvTPHi5fCBBmpY12Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714514167; c=relaxed/simple;
	bh=oYOaHTepb15vC/qSY7PChf6EcjxS4EQy7wPC86gJYgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jHMcU9kz5gsizRhcinDn7Gm1hoMGOdwm7FXYkiy0+v4kZak2eAo+cftFN5/c2sVLl3JIfDNSYCFIj7ff9g+qg9ot6TSKhej7+NcXCgvVq6EsTE2yNHrO/xPo96CzR6+DYnkFuTykr4jM01UG3IZU5JcnCJhUKFrM41qwb/NhE90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lzdxmG8G; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714514166; x=1746050166;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oYOaHTepb15vC/qSY7PChf6EcjxS4EQy7wPC86gJYgQ=;
  b=lzdxmG8Gf0UKJFe6YNJAO7VJbQEYOK42XMxWEJXTZ4w51TSDsRdJo1OZ
   CbND7GgD8XBoY39yHAFPXYEZsBuQ2rN4kIMCeyMV8mObIzWKj0EoP55I9
   9Bdtpmc051At0RNEbjBnQOUfyp5U37/xFIZnISMBqo4n0UBJ+zFEarEhp
   5+T6CJFFcMweA7RDGli/Xf7kQcrdttnXTmGzYfHe2X4pRDlcdcfT+zXlf
   pn9984WFrKxJ6QQNLjJ5PZqAYk/rhpyfLZDoy264qAFLDhOUiytvBoP8T
   YZ4AnComArcGg1xDRoSs4BRz2b48PHnRXRpkhd2AZkG1Sh8h1yTPqfJC9
   A==;
X-CSE-ConnectionGUID: yxm2rrDhQBisaa+vZ3FskA==
X-CSE-MsgGUID: EN/uX/m7SlqNp/u1mSGEsQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="20933056"
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="20933056"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 14:56:04 -0700
X-CSE-ConnectionGUID: TchCh7r0TamQ1OVH80sp0A==
X-CSE-MsgGUID: CC2GUAhDQjiPXwvl7epyew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="26609008"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 30 Apr 2024 14:55:58 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s1vS7-0008df-0v;
	Tue, 30 Apr 2024 21:55:55 +0000
Date: Wed, 1 May 2024 05:55:38 +0800
From: kernel test robot <lkp@intel.com>
To: Herve Codina <herve.codina@bootlin.com>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lee Jones <lee@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH 01/17] mfd: syscon: Add reference counting and device
 managed support
Message-ID: <202405010521.dW27hHxi-lkp@intel.com>
References: <20240430083730.134918-2-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430083730.134918-2-herve.codina@bootlin.com>

Hi Herve,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/irq/core]
[also build test ERROR on lee-mfd/for-mfd-next pza/reset/next linus/master v6.9-rc6 next-20240430]
[cannot apply to lee-mfd/for-mfd-fixes pza/imx-drm/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Herve-Codina/mfd-syscon-Add-reference-counting-and-device-managed-support/20240430-164912
base:   tip/irq/core
patch link:    https://lore.kernel.org/r/20240430083730.134918-2-herve.codina%40bootlin.com
patch subject: [PATCH 01/17] mfd: syscon: Add reference counting and device managed support
config: i386-buildonly-randconfig-005-20240501 (https://download.01.org/0day-ci/archive/20240501/202405010521.dW27hHxi-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240501/202405010521.dW27hHxi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405010521.dW27hHxi-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from drivers/misc/sram.c:18:
>> include/linux/mfd/syscon.h:76:15: error: expected ';' before 'void'
      76 | static intline void syscon_put_regmap(struct regmap *regmap)
         |               ^~~~~
         |               ;
>> include/linux/mfd/syscon.h:76:21: warning: no previous prototype for 'syscon_put_regmap' [-Wmissing-prototypes]
      76 | static intline void syscon_put_regmap(struct regmap *regmap)
         |                     ^~~~~~~~~~~~~~~~~


vim +76 include/linux/mfd/syscon.h

    75	
  > 76	static intline void syscon_put_regmap(struct regmap *regmap)
    77	{
    78	}
    79	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

