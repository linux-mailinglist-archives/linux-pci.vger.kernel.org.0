Return-Path: <linux-pci+bounces-17866-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 339EE9E77A7
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 18:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2CC3280CFB
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 17:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F641FD7A7;
	Fri,  6 Dec 2024 17:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f6J3Ene0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493501F3D35;
	Fri,  6 Dec 2024 17:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733507106; cv=none; b=blC9Cf1KbK6s2WrMXMSa1OQYg17oo5AwsWUE5rfvKHe0wTlRF8PMU03l2JnsN8K+3etpb8cVgz09uzZQCV48XQCyhIKW0p9+Zi6MDJCMqTA77mA1G3FfSBXQtPoYAgeyJjKTFH3D9t1pMErogfQLC1lQZHIDIwCGDSToSl9E5Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733507106; c=relaxed/simple;
	bh=vlNGMkQtRJVFoqeWyR5VVwsR/4xTRvRmeXtD9OqxIFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YnIVOiY2w06crmO2FnqfLcSQGrZhS6s1dNxvun2j4YyLTWd4Rd6XQcw9kefC+FA9f36hMQ5q+tqKLPBqndX5oABWuXO4zV9JPreOwtbFtvc8O8d8XY1QWdYBlZ1ykUKMUAckIQXPedfgMlT3BXFFMvmcV394m9mJDS+0LMExiGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f6J3Ene0; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733507105; x=1765043105;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vlNGMkQtRJVFoqeWyR5VVwsR/4xTRvRmeXtD9OqxIFc=;
  b=f6J3Ene0XOhgd1UbxGHztvWS0haF8C2/tUA65Q2g797QHx1CEa+0K8yG
   3aDUO2UPhaL77FdmdWg3tTuLIkgIRlO48kB0gcjhrqwB9sSJqxteWUcfZ
   q5oRFBojO4MijPV7vU6gkraCzUUu+BwkfPzp0kTvlKGTBAo8ebynOzLmm
   eEIm5WM+bjWrsm5XDnSRjVKGTt4z3OQ0E1KJa24bmgLBqkfqLpcZfKXf8
   /V1xuXp5PQk5LPc+KXCMMpqTbS07QYgYarcl2s6TXDfMkxMZj67FmDQ7i
   zQBiwhvv0GKfWFZnVD5qPoFBCEU58zW65hCHO5zZrTdnrKLfzXStmT7s8
   A==;
X-CSE-ConnectionGUID: OCGKikhiQEGF5L4qMngljQ==
X-CSE-MsgGUID: sx2NcFAPRXOEpdUMVcM1bg==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="33999112"
X-IronPort-AV: E=Sophos;i="6.12,213,1728975600"; 
   d="scan'208";a="33999112"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 09:45:04 -0800
X-CSE-ConnectionGUID: +7LaT3YuQJqTnzuTU58faA==
X-CSE-MsgGUID: YHtzXtNUQxC1JwVHbSM5Sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,213,1728975600"; 
   d="scan'208";a="95272272"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 06 Dec 2024 09:44:59 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tJcNt-00028N-0z;
	Fri, 06 Dec 2024 17:44:57 +0000
Date: Sat, 7 Dec 2024 01:44:51 +0800
From: kernel test robot <lkp@intel.com>
To: Frank Li <Frank.Li@nxp.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?unknown-8bit?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
	Frank <Li@nxp.com>,
	"open list:PCI DRIVER FOR NXP LAYERSCAPE GEN4 CONTROLLER" <linux-pci@vger.kernel.org>,
	"moderated list:PCI DRIVER FOR NXP LAYERSCAPE GEN4 CONTROLLER" <linux-arm-kernel@lists.infradead.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: PCI: mobiveil: convert
 mobiveil-pcie.txt to yaml format
Message-ID: <202412070127.BkBJhnZ4-lkp@intel.com>
References: <20241205201423.3430862-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205201423.3430862-1-Frank.Li@nxp.com>

Hi Frank,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus linus/master v6.13-rc1 next-20241206]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Frank-Li/dt-bindings-PCI-mobiveil-convert-mobiveil-pcie-txt-to-yaml-format/20241206-041830
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20241205201423.3430862-1-Frank.Li%40nxp.com
patch subject: [PATCH 1/1] dt-bindings: PCI: mobiveil: convert mobiveil-pcie.txt to yaml format
reproduce: (https://download.01.org/0day-ci/archive/20241207/202412070127.BkBJhnZ4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412070127.BkBJhnZ4-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Warning: Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
   Warning: Documentation/hwmon/g762.rst references a file that doesn't exist: Documentation/devicetree/bindings/hwmon/g762.txt
   Warning: Documentation/hwmon/isl28022.rst references a file that doesn't exist: Documentation/devicetree/bindings/hwmon/isl,isl28022.yaml
   Warning: Documentation/translations/ja_JP/SubmittingPatches references a file that doesn't exist: linux-2.6.12-vanilla/Documentation/dontdiff
>> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
>> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/pci/layerscape-pcie-gen4.txt
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
   Warning: lib/Kconfig.debug references a file that doesn't exist: Documentation/dev-tools/fault-injection/fault-injection.rst
   Using alabaster theme

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

