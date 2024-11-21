Return-Path: <linux-pci+bounces-17184-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 816C09D54E7
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 22:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 389881F21B02
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 21:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3351DC1B7;
	Thu, 21 Nov 2024 21:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KqaDG6Tf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7D21CB50C;
	Thu, 21 Nov 2024 21:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732225503; cv=none; b=RyvCp85aCQm50MOMfFD1Pb7QoVz3LuIHPF/CCKdfta8bXIDW/9exPLeX5KNJGzn0IWuqDC7GgeRzTUDHXivwMXAQXrit4bgxBeF1xA5uQXYg0UaJSQFBkJ3THI7n7OeNsp3ExhXH9FzXhENe4Si9VmonzSeP7AraIhdYfXvBXiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732225503; c=relaxed/simple;
	bh=z6SsQwO1xdocyqy0LDzeJjiSEosdlVjnlBC6wCHkbj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nys7BAKPM3ytKW06Qw4kP82i+l8tQ0RhX3zKumXweFb9IiWGdv39AkiOPZZIcyLLmgzDYmy/SZPhJBEyONEHtK6HEBNtA6ZOkbUjYZg0kSOOISIj3kpm8m0U2L4kIOf5loDWQqCZo8BxCgJ3I8WQU/Ce0NTzq9uN3Yzpx6IiA7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KqaDG6Tf; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732225502; x=1763761502;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z6SsQwO1xdocyqy0LDzeJjiSEosdlVjnlBC6wCHkbj8=;
  b=KqaDG6TfwQlzaGmIWeVg5y3QkMEpY2p+CZKJKkxfnIPxK6R4YZypeyy2
   gM1zrMgSb9DmD8yBIyI1ff0Af/NsYVpVLK4bKEqwBOMcD8MrcZ5fNIm6e
   ndhhatik81YpPtVINMEKGZrazHn/ihHWhGPrdBR3OEV29z6kg7Zi+zR1t
   sq71crsJBwHStHx9sBxw5TfbundtgzT+jIlsSlrBpt6V8jCEKNY0PX0Lx
   F0t4BGy7kLhUyA5iuCRSLSeVIM6UJ927vAv9j1xURRrSV/yEg2y/jUr6M
   Iz5Sx8WIl5G3L0hb8K2DFmVsE4QhdWSCmsk3fprZ5Ah8lBVAUvcdoTumm
   Q==;
X-CSE-ConnectionGUID: lxZavyciQ5qTVTcVJh5zUA==
X-CSE-MsgGUID: z6qs273vTWulcoqviPl/UQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="32514196"
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="32514196"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 13:45:01 -0800
X-CSE-ConnectionGUID: LSoy2AwmSsKRuXTWY52GvA==
X-CSE-MsgGUID: baquf0K4S/CXW5Q48ljBhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="90753181"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 21 Nov 2024 13:44:56 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tEEyr-0003Nz-16;
	Thu, 21 Nov 2024 21:44:53 +0000
Date: Fri, 22 Nov 2024 05:43:57 +0800
From: kernel test robot <lkp@intel.com>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	cros-qcom-dts-watchers@chromium.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?unknown-8bit?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <helgaas@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, quic_vbadigan@quicinc.com,
	quic_ramkri@quicinc.com, quic_nitegupt@quicinc.com,
	quic_skananth@quicinc.com, quic_vpernami@quicinc.com,
	quic_mrana@quicinc.com, mmareddy@quicinc.com,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: Re: [PATCH 2/3] PCI: dwc: Add ECAM support with iATU configuration
Message-ID: <202411220541.dAciinyb-lkp@intel.com>
References: <20241117-ecam-v1-2-6059faf38d07@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241117-ecam-v1-2-6059faf38d07@quicinc.com>

Hi Krishna,

kernel test robot noticed the following build errors:

[auto build test ERROR on 2f87d0916ce0d2925cedbc9e8f5d6291ba2ac7b2]

url:    https://github.com/intel-lab-lkp/linux/commits/Krishna-chaitanya-chundru/arm64-dts-qcom-sc7280-Increase-config-size-to-256MB-for-ECAM-feature/20241121-095614
base:   2f87d0916ce0d2925cedbc9e8f5d6291ba2ac7b2
patch link:    https://lore.kernel.org/r/20241117-ecam-v1-2-6059faf38d07%40quicinc.com
patch subject: [PATCH 2/3] PCI: dwc: Add ECAM support with iATU configuration
config: alpha-randconfig-r064-20241121 (https://download.01.org/0day-ci/archive/20241122/202411220541.dAciinyb-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241122/202411220541.dAciinyb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411220541.dAciinyb-lkp@intel.com/

All errors (new ones prefixed by >>):

   alpha-linux-ld: drivers/pci/controller/dwc/pcie-designware-host.o: in function `dw_pcie_host_deinit':
>> (.text+0x17a4): undefined reference to `pci_ecam_free'
>> alpha-linux-ld: (.text+0x17a8): undefined reference to `pci_ecam_free'
   alpha-linux-ld: drivers/pci/controller/dwc/pcie-designware-host.o: in function `dw_pcie_host_init':
>> (.text+0x21e4): undefined reference to `pci_generic_ecam_ops'
>> alpha-linux-ld: (.text+0x21e8): undefined reference to `pci_ecam_create'
   alpha-linux-ld: (.text+0x21f0): undefined reference to `pci_ecam_create'
>> alpha-linux-ld: (.text+0x2240): undefined reference to `pci_generic_ecam_ops'
   alpha-linux-ld: (.text+0x2834): undefined reference to `pci_ecam_free'
   alpha-linux-ld: (.text+0x2838): undefined reference to `pci_ecam_free'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

