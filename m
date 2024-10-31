Return-Path: <linux-pci+bounces-15714-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A859B7C7D
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 15:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35034B21A88
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 14:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B002D1A01C6;
	Thu, 31 Oct 2024 14:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AX/Jvp8M"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6143B1993B2;
	Thu, 31 Oct 2024 14:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730383954; cv=none; b=NsrUxYELOmeGl7d6wW6eqO93Wf7JpFY8Od51d2UJCdeyl9qv6ys8rrAjIxB4/PQF+tlcs7c0cNTVYil7fr6SBtV+/ilpoY92+M/0R+oK0eu1hJE07yUJ0ue8JVROIeMr4I3NAk/rpIw38n2CA/kpZ5M/QvLKMofz+anrE9g1SIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730383954; c=relaxed/simple;
	bh=A3ycCJbTERSDiBEUqrjApoZ6yv8BBa5XIMOLrpaNGik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XBLKer9/F4chcNAjJ16N5PVXC+CWSA42j2Otnj+AEPFVFfQq6YBQNxEKP6AEgrxeEt9AzGK+Pnf0vrIiNk4Auo0lobrw5c+5qRzIVgvoqfM0JQzkfmGK1BSejTuwp+S9XOjUw33lZi+dmdE2euDwipXvLRyB0U3PUJEiX9OWs64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AX/Jvp8M; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730383953; x=1761919953;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=A3ycCJbTERSDiBEUqrjApoZ6yv8BBa5XIMOLrpaNGik=;
  b=AX/Jvp8MsrpnfbTUVexsVPjliCkL91H2mFafbxLCXjY8GeE04MT641/T
   uH8a+k5Hcv2oPJWCIHXcLbSd4fzoBKCYIYgsXUvcCtBXyQ5G9duMMQeCf
   4yjWiT991mh7blfZKUaYiY1xe6ddJzJHVcDZATbGW8eefL3ZtyIdxq6J5
   aylc547rFzodPnRA0y1CDa5tsse2k8Iw+PV4hBAxR19u6dc/hF1vsz7yF
   VnB+SMu3V7x7lV3MXZ/hAvEXxUcG19VE64GauPsic770scAsSuZvBa03l
   E73KZT89pYLSlg3OmuX5DgpoNiVBMdTjvcp0b038T1+HK2m5+fhjp0zVA
   g==;
X-CSE-ConnectionGUID: hVAbKjLNQWKuSiQG6j0Aww==
X-CSE-MsgGUID: s9VeSMnETgGCVZ3UwTqkpw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="52679354"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="52679354"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 07:12:32 -0700
X-CSE-ConnectionGUID: CkchJSSSRamoQEo9lN09jQ==
X-CSE-MsgGUID: OdlONHy/Q9mJuz9JbSaeHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="86560456"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 31 Oct 2024 07:12:25 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t6VuR-000gH7-13;
	Thu, 31 Oct 2024 14:12:23 +0000
Date: Thu, 31 Oct 2024 22:12:18 +0800
From: kernel test robot <lkp@intel.com>
To: Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczynski <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saravana Kannan <saravanak@google.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v3 07/12] clk: rp1: Add support for clocks provided by RP1
Message-ID: <202410312134.vf7iY2Sz-lkp@intel.com>
References: <c20e3d6d87c71691b149cdeeafc94009953346b2.1730123575.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c20e3d6d87c71691b149cdeeafc94009953346b2.1730123575.git.andrea.porta@suse.com>

Hi Andrea,

kernel test robot noticed the following build errors:

[auto build test ERROR on clk/clk-next]
[also build test ERROR on char-misc/char-misc-testing char-misc/char-misc-next char-misc/char-misc-linus robh/for-next linus/master v6.12-rc5]
[cannot apply to next-20241031]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrea-della-Porta/dt-bindings-clock-Add-RaspberryPi-RP1-clock-bindings/20241028-221122
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
patch link:    https://lore.kernel.org/r/c20e3d6d87c71691b149cdeeafc94009953346b2.1730123575.git.andrea.porta%40suse.com
patch subject: [PATCH v3 07/12] clk: rp1: Add support for clocks provided by RP1
config: sparc-allmodconfig (https://download.01.org/0day-ci/archive/20241031/202410312134.vf7iY2Sz-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241031/202410312134.vf7iY2Sz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410312134.vf7iY2Sz-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/clk/clk-rp1.c: In function 'rp1_pll_set_rate':
>> drivers/clk/clk-rp1.c:399:19: error: implicit declaration of function 'FIELD_PREP'; did you mean 'FIELD_SET'? [-Wimplicit-function-declaration]
     399 |         (_reg) |= FIELD_PREP(mask, (_val));     \
         |                   ^~~~~~~~~~
   drivers/clk/clk-rp1.c:621:9: note: in expansion of macro 'FIELD_SET'
     621 |         FIELD_SET(prim, PLL_PRIM_DIV1_MASK, prim_div1);
         |         ^~~~~~~~~


vim +399 drivers/clk/clk-rp1.c

   394	
   395	#define FIELD_SET(_reg, _mask, _val)		\
   396	do {						\
   397		u32 mask = (_mask);			\
   398		(_reg) &= ~mask;			\
 > 399		(_reg) |= FIELD_PREP(mask, (_val));	\
   400	} while (0)
   401	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

