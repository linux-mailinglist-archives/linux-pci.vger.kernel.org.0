Return-Path: <linux-pci+bounces-27089-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 092FBAA6E3C
	for <lists+linux-pci@lfdr.de>; Fri,  2 May 2025 11:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1AA44A72D1
	for <lists+linux-pci@lfdr.de>; Fri,  2 May 2025 09:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27AC722F75D;
	Fri,  2 May 2025 09:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AaddnoRa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401EA22E00E;
	Fri,  2 May 2025 09:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746178610; cv=none; b=ds1MHTETB566+/MNrPnVXgTd37VTQvcct6F3XI8n8QSkuC1pT6S4Zvmku3tzhqYvy3aI2V+VFbiHIUCPs6wtdxRESyRDlfsiChmUGmQY/FlBIwLrbs1p/Ikph759AjWehIl5cGiHUnFFuhRoABoPbrKGqmEp20ckJXk4wV2bYrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746178610; c=relaxed/simple;
	bh=qO5Uzrf4EcWUBp68VsfzP2cwci35gHFejxNmBHPXlpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RhPzZ+pDY2mnHLmtLdfbbxqiQLfurH62oa6EZ+uME2/JElx5PMQoYmTOVFlz6e88cH9aB7DpJwUQASd2rMkGt+D1aArps0/d/fG9LQoucWpyB0D/hdPhkBxxiSy7AYfzgoLWXpEWL2U0rmGINo4rLsla7Y3rQpVzlv8Aq0tOVWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AaddnoRa; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746178608; x=1777714608;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qO5Uzrf4EcWUBp68VsfzP2cwci35gHFejxNmBHPXlpw=;
  b=AaddnoRaxpGiRV3SnV6P/9BHBcp+3iwmUMKSdJ7kyVeb/VMqQTHLaApG
   6/8IxZP0hXD759UndlvqHRMe4qLEtQQYAvrzyLW8F73Eu+FBN7WJAXO1D
   o+XZ1aOMNcvyrs2+kOTIfUbgENwNE/howmQYKbJOQSWkV2uH8PJcf6OXC
   8JHmZOD8Mhwpzw/GMTYC1JVVLtMZLmKEJsxWYTf+ZsyYhBNvXg5/0fwkh
   H+mUFVAiPWpQrQMM7sXUpMeD3PGFML1HDULlEEyh60miYrrII6oAfeUOz
   AuX2XAOKHmDJGvmqagTQ4nPQdBZXaU8uEySyd/mWjUzkeVwspu/dgUUSc
   g==;
X-CSE-ConnectionGUID: StbgYm2aSLGzB8pb4FfnSA==
X-CSE-MsgGUID: +f1/i89MQryICylVpJeQoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11420"; a="59221032"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="59221032"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 02:36:47 -0700
X-CSE-ConnectionGUID: GyzI4gIgSUmLH4cFY4xw0w==
X-CSE-MsgGUID: 1BkqQ91nTsK5J39c28Uq0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="134497643"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 02 May 2025 02:36:44 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uAmp0-0004ev-1J;
	Fri, 02 May 2025 09:36:42 +0000
Date: Fri, 2 May 2025 17:36:36 +0800
From: kernel test robot <lkp@intel.com>
To: "Rob Herring (Arm)" <robh@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: Convert v3,v360epc-pci to DT schema
Message-ID: <202505021641.QEim367T-lkp@intel.com>
References: <20250502013447.3416581-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250502013447.3416581-1-robh@kernel.org>

Hi Rob,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus linus/master v6.15-rc4 next-20250501]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rob-Herring-Arm/dt-bindings-PCI-Convert-v3-v360epc-pci-to-DT-schema/20250502-093635
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20250502013447.3416581-1-robh%40kernel.org
patch subject: [PATCH] dt-bindings: PCI: Convert v3,v360epc-pci to DT schema
reproduce: (https://download.01.org/0day-ci/archive/20250502/202505021641.QEim367T-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505021641.QEim367T-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Warning: Documentation/translations/zh_CN/dev-tools/gdb-kernel-debugging.rst references a file that doesn't exist: Documentation/dev-tools/gdb-kernel-debugging.rst
   Warning: Documentation/translations/zh_TW/admin-guide/README.rst references a file that doesn't exist: Documentation/dev-tools/kgdb.rst
   Warning: Documentation/translations/zh_TW/dev-tools/gdb-kernel-debugging.rst references a file that doesn't exist: Documentation/dev-tools/gdb-kernel-debugging.rst
   Warning: Documentation/userspace-api/netlink/index.rst references a file that doesn't exist: Documentation/networking/netlink_spec/index.rst
   Warning: Documentation/userspace-api/netlink/specs.rst references a file that doesn't exist: Documentation/networking/netlink_spec/index.rst
>> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/pci/v3-v360epc-pci.txt
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/leds/backlight/ti,lp8864.yaml
   Can't build as 1 mandatory dependency is missing at ./scripts/sphinx-pre-install line 984.
   make[2]: *** [Documentation/Makefile:121: htmldocs] Error 255
   make[1]: *** [Makefile:1801: htmldocs] Error 2
   make: *** [Makefile:248: __sub-make] Error 2

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

