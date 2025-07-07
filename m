Return-Path: <linux-pci+bounces-31641-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 662F1AFBC79
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 22:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C6C0423BA6
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 20:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C005E21CA0E;
	Mon,  7 Jul 2025 20:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JYnkU6K+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255F2C2FB
	for <linux-pci@vger.kernel.org>; Mon,  7 Jul 2025 20:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751919928; cv=none; b=uWm+/T0lXooTFnlaHwEPZh1893RupQGxRqciJ+gZps035GBPUOctrAR4qGUM4IdYPdrXxfnCxUF0XD/wRK/x8lC0Z+w/pGOVGTHQCWn7ksT74YPpwRd5S4EYehMprn1uukVGZZ7Tgrbnwywz7fdgVT/cqFbrVj2WFxYjdA/24l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751919928; c=relaxed/simple;
	bh=VTyui1TD2+dBPQ4s3x5S6ne7GSTMKJOET/gdjfe+Qh0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UvWth9ALN5ff4RP5VAfF2wPvpWx1TZOqAUNsatW0LGcz2fRlUJdJjZxXH/hp1lrH11nNXNDFAABRsGmYqUaVvzcTdMTd/J6AdZsvB7kxlKveCvnU7QR5L0xNRuqJi4CY2863Fxgf2BWetDTdD9MCEoRQ7KLhsN4R+arEH40+F3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JYnkU6K+; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751919927; x=1783455927;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VTyui1TD2+dBPQ4s3x5S6ne7GSTMKJOET/gdjfe+Qh0=;
  b=JYnkU6K+dwgYsMMl4P0/Ca51ypVuR6fKyr1ChYstTCEu2UPNwttoncF6
   fj1OVOyTPuTwTMvnXJBAo1XS5pOnvBxYunPXHfHick/5ZG7eBsTXKsxyw
   7nHpqRdodqFZom3EqQfQXwCHhpaC0AP0Ca/+PdSWnkOr2kVvnOMxh1oCY
   G3cC3QslB7RDbh3uuGrpQlF+iSlF8ajZCxnqbGAj9k3TKL7T7qQoCaYsE
   u80dIi7nM85ha0mzfO2XIOJ8A2e+uYv7a9nrbdfoxLgv9dnNpWI3QR7g4
   7Wb/dQm7dWgM5/R8x1dp9nfqYKLX34tQm1R+wjXnFfuy32z1VcIfcPH+I
   Q==;
X-CSE-ConnectionGUID: 5LA3uMx8RmCMOLbliGx8rQ==
X-CSE-MsgGUID: y6buiXhzScKCQkH2z/ck7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="76700286"
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="76700286"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 13:25:27 -0700
X-CSE-ConnectionGUID: vtSEXlmcTmWRvzTPJoc/bg==
X-CSE-MsgGUID: /72SQADMTsSbs5JTeQG9kQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="155044367"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 07 Jul 2025 13:25:25 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uYsOw-0000iz-2w;
	Mon, 07 Jul 2025 20:25:22 +0000
Date: Tue, 8 Jul 2025 04:25:11 +0800
From: kernel test robot <lkp@intel.com>
To: Nam Cao <namcao@linutronix.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Subject: [pci:controller/msi-parent 6/15] Warning:
 drivers/pci/controller/pcie-iproc-msi.c:109 Excess struct member
 'msi_domain' description in 'iproc_msi'
Message-ID: <202507080437.HQuYK7x8-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/msi-parent
head:   8c0c598f3f217961103ab782da53a7b980fd68b3
commit: 52a8808de0060d87381147c7aecfd7153c1b72cb [6/15] PCI: iproc: Switch to msi_create_parent_irq_domain()
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20250708/202507080437.HQuYK7x8-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250708/202507080437.HQuYK7x8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507080437.HQuYK7x8-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/pci/controller/pcie-iproc-msi.c:109 Excess struct member 'msi_domain' description in 'iproc_msi'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

