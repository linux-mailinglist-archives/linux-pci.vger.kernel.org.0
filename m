Return-Path: <linux-pci+bounces-6914-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A638B8295
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 00:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9F401C2292C
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 22:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2691BED9F;
	Tue, 30 Apr 2024 22:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C4a23aUH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC271BED90;
	Tue, 30 Apr 2024 22:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714514886; cv=none; b=g0fHHYiUIOgdWKyaCT1qX7gP3Vk4ahk2nmx4CWWTHZV8c317GMDtxDAoT1cnXTh80HZZhcCgwiCGIBpslIc7clII85Ddq0nuuxSYIunLz4xWkQc+/5jHjqU+L//neTP3S4jtXgEoGGPXnenbTSzVb8soDEclx45h+bLmAkzDZGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714514886; c=relaxed/simple;
	bh=2EjHvnib8nIL73tYT8O0yQJd84dh54YMSzAvf3H8Fns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yhd3QpwDv9K/yXeA8/WqOI67OdOhLLvruP0iCmdqSzwn3FStzQnVq9dW+RovfYjvUgHD8TZI7QezrRMazT5tpdKinj7m28o+h/JJT/W8O+4uIGfKst4bg1PReWzoqJJ1GF4J5QUqYrpIF9iczOb7wSVXgBpz26FBUqpmQrZitO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C4a23aUH; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714514885; x=1746050885;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2EjHvnib8nIL73tYT8O0yQJd84dh54YMSzAvf3H8Fns=;
  b=C4a23aUH5iNrqdD9DQRovFy9lWEcxwxXZZK6zv2QlKzNp9ijTn/8l8yj
   2AwJ5RgSRTv+MJsStg4uZI5MxVcTLciDGw9tfs546oaEA8XtW7ejIo2iT
   P5breemTvfD8rOQdCbYmuEUTZhiU5KcOzBFosMqF2aVfOPx+FNHw/O8Fx
   RyX3eKOjp/znYVBqoES1GatdHT1CCGqROd3uA6YTLboNhigq3331JGmgk
   dKqvfbTg832cdPCotHXn9AKifEkkfkEqG7H+a4NMGFq8xcJoifbC0YCpp
   YI8gYILQWE9q2kOVZz5DtlGfETv1OgrbeicPXvtLo9RyIvKrsNM5B/P3N
   Q==;
X-CSE-ConnectionGUID: s6F63s9VS6SwWByOkmRnMA==
X-CSE-MsgGUID: rPRkletIQHmUDc2v5RT82A==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="27766915"
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="27766915"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 15:08:04 -0700
X-CSE-ConnectionGUID: bF8HwEflShu++COMqEawgA==
X-CSE-MsgGUID: OuoGHfjjTI6TiDd1H+p1vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="26692707"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 30 Apr 2024 15:07:58 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s1vdj-0008eG-1o;
	Tue, 30 Apr 2024 22:07:55 +0000
Date: Wed, 1 May 2024 06:07:38 +0800
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
Message-ID: <202405010513.GHoo4Vwg-lkp@intel.com>
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
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20240501/202405010513.GHoo4Vwg-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240501/202405010513.GHoo4Vwg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405010513.GHoo4Vwg-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/net/can/c_can/c_can_platform.c:36:
>> include/linux/mfd/syscon.h:76:15: error: expected ';' before 'void'
      76 | static intline void syscon_put_regmap(struct regmap *regmap)
         |               ^~~~~
         |               ;
   include/linux/mfd/syscon.h:76:21: warning: no previous prototype for 'syscon_put_regmap' [-Wmissing-prototypes]
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

