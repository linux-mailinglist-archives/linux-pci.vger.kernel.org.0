Return-Path: <linux-pci+bounces-24796-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A86A720A6
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 22:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25D2C3BC975
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 21:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED3325DB14;
	Wed, 26 Mar 2025 21:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HuNnF2AR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF2F23AE79;
	Wed, 26 Mar 2025 21:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743023970; cv=none; b=bPVn0xNlALYhVJ+4tiIUFwjFHrngdOdhd2MN3KYS+JCjSaLkGeHwgc47q3xhWL8sfHTseGOQxM6udXJAoch886dN/bfIGR0f32+rcdCJizxssv+gJuz2a3CoS7bUtAChJo7ajWurkICNSn/aB4DId6wMX26tQz4dtQfzIrl0Tk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743023970; c=relaxed/simple;
	bh=Hu0LgRWcUyyVLEgb/8MX2IeiP6lnhn6n5T862wdMvuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eoSnmg2zFs3tltW3dGg3Ix3Ukdh46nDiCYZOd5rxjJ4ZEEtEUbKxPc5Vlu+pqmCl+BMMxv1ZxZTNsjW9mRtEHWUrSO1V4QU/uSKKa0vVYQzhRG5b3Is/WcteMP8zMSSRWKhHIfKaDtQfohF6I8+x2hpW/vHud/pFGJzmuZHOvK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HuNnF2AR; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743023968; x=1774559968;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Hu0LgRWcUyyVLEgb/8MX2IeiP6lnhn6n5T862wdMvuE=;
  b=HuNnF2ARVUlVzWu/FSv1lf7y0E1x3GrxrLxc4BbbB9CbW3MEuFZ6umqP
   U6yb2p49kkEybz0KJq/szB07N5AMlhgaiSp9WleNHtgISAmmo4rirWWRP
   CYGvJ80YE5Z/ljyUjGhc4X22hximsjrtCteq9gSXbcthZZf7u+UxeUQ22
   v6auqt7nCeq2UmsLo+bKvUgtKXLWpb7g6gMWaqZQTRX26LcB0mFfm+Gja
   z2HOcEXjudzSRcSPUttDoLaBLeoOHetZRh0rV3jB9OltSi3qTaLt7q6Jk
   vBC3wmW5ipPi3Y5REtUry5qq14cC//TG3/ciZH0aHi1WeUNngUp1TmvYH
   A==;
X-CSE-ConnectionGUID: 1RqD1yjsR2We1V6WXQGbnw==
X-CSE-MsgGUID: mnUewp2IRqSmcdsXtO1rYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="61731288"
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="scan'208";a="61731288"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 14:19:27 -0700
X-CSE-ConnectionGUID: 0hIXxHHJS0aD7ZcIevd12Q==
X-CSE-MsgGUID: mEhSnXkkRcK6U98OTXHazw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="scan'208";a="129075278"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 26 Mar 2025 14:19:24 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1txY9i-00065D-0V;
	Wed, 26 Mar 2025 21:19:22 +0000
Date: Thu, 27 Mar 2025 05:18:39 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v2 1/3] PCI: Add sysfs support for exposing PTM context
Message-ID: <202503270447.SYoXEBQd-lkp@intel.com>
References: <20250324-pcie-ptm-v2-1-c7d8c3644b4a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324-pcie-ptm-v2-1-c7d8c3644b4a@linaro.org>

Hi Manivannan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 1f5a69f1b3132054d8d82b8d7546d0af6a2ed4f6]

url:    https://github.com/intel-lab-lkp/linux/commits/Manivannan-Sadhasivam-via-B4-Relay/PCI-Add-sysfs-support-for-exposing-PTM-context/20250324-181039
base:   1f5a69f1b3132054d8d82b8d7546d0af6a2ed4f6
patch link:    https://lore.kernel.org/r/20250324-pcie-ptm-v2-1-c7d8c3644b4a%40linaro.org
patch subject: [PATCH v2 1/3] PCI: Add sysfs support for exposing PTM context
config: i386-randconfig-061-20250326 (https://download.01.org/0day-ci/archive/20250327/202503270447.SYoXEBQd-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250327/202503270447.SYoXEBQd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503270447.SYoXEBQd-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/pci/pcie/ptm.c:13:15: sparse: sparse: symbol 'ptm_device' was not declared. Should it be static?

vim +/ptm_device +13 drivers/pci/pcie/ptm.c

    12	
  > 13	struct device *ptm_device;
    14	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

