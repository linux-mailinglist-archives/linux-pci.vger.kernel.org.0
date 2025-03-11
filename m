Return-Path: <linux-pci+bounces-23411-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0D0A5BB9D
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 10:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B00518907C8
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 09:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53242222D3;
	Tue, 11 Mar 2025 09:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lgeoWLy9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3454D1EB199;
	Tue, 11 Mar 2025 09:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741684004; cv=none; b=pQvRbpfexm0qcnaSliUv8y9Y03fsf67zmKuAOf0eXgL9lX+mP7bsf0/BdQO0YCSxKB3JOJTcRoW4CWq3tYq0jWReMp55fnxrR4O11gAbOP2OBLF48fKwkieIhmtLXXpIOswuSYw6WFzPxNrQxy6m91jXuILuSuPgcAzLJOD+CRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741684004; c=relaxed/simple;
	bh=Lf1ll/w54v7N4pMRqpFCRX6LM4srEfAQ8cYdNV9dHR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AL7tR3kNS0Y9RJQouXDEILv6+pqoJU2FeZYXb9nUO2xFTEc3Wdj2VJKkrSSvkgN0zNBMErR/lAl2FkYn5z7hCZWyVBowlBHG7o+Le0pf+FscGjEPPlXZdKvOP/DLBDeSOc6FLDMmwCyxe6VGHNcsX6ViUbYxK0ZVgAcaCJHrvqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lgeoWLy9; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741684003; x=1773220003;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Lf1ll/w54v7N4pMRqpFCRX6LM4srEfAQ8cYdNV9dHR0=;
  b=lgeoWLy9sCM28FPgdkFGoaz+thmUXWyuVD+MWef5AxXjLw9cqyH4zOG5
   XGeadQLzuT4N6+4qxpdT20mvhB2kS8n1Dpy/IhTNqWomxMvrjCiHgG/he
   hnyQc0b7xRzDTDPZQO8U7vM1M2GeED973s12R5B7tOHqqQ5iLJweOhl7r
   yZhcv10+rKsoScPmo1drobg/oYhPQFHsRkGwX+h8DtF7N+Um36MktXCqi
   341ul1lza9I9Bz2+uNW8e4+f0Elx9a1x8H4CeIRyK9bU5PlL3BIyiziet
   RFtrD5/EDjr/s0oUTwN5Log6DmJnqudZW+p8CM9Pd9CVqHABbYv1x2iBJ
   w==;
X-CSE-ConnectionGUID: mp5oBq+4Qh21NPZutmkN6g==
X-CSE-MsgGUID: B0bxsHQ1RsyjBmYeKYmdiw==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="42427740"
X-IronPort-AV: E=Sophos;i="6.14,238,1736841600"; 
   d="scan'208";a="42427740"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 02:06:42 -0700
X-CSE-ConnectionGUID: QYf9xl73QsWOniN1NCeshQ==
X-CSE-MsgGUID: RvshfzS+QI+d6Cp3vR22QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,238,1736841600"; 
   d="scan'208";a="120484207"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 11 Mar 2025 02:06:36 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1trvZK-0006Vq-0G;
	Tue, 11 Mar 2025 09:06:34 +0000
Date: Tue, 11 Mar 2025 17:06:00 +0800
From: kernel test robot <lkp@intel.com>
To: Ziyue Zhang <quic_ziyuzhan@quicinc.com>, bhelgaas@google.com,
	lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, vkoul@kernel.org,
	kishon@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
	dmitry.baryshkov@linaro.org, neil.armstrong@linaro.org,
	abel.vesa@linaro.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	quic_ziyuzhan@quicinc.com, quic_qianyu@quicinc.com,
	quic_krichai@quicinc.com, johan+linaro@kernel.org,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v3 3/4] arm64: dts: qcom: qcs615-ride: Enable PCIe
 interface
Message-ID: <202503111654.Uo5Nw44p-lkp@intel.com>
References: <20250310065613.151598-4-quic_ziyuzhan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310065613.151598-4-quic_ziyuzhan@quicinc.com>

Hi Ziyue,

kernel test robot noticed the following build errors:

[auto build test ERROR on c674aa7c289e51659e40dda0f954886ef7f80042]

url:    https://github.com/intel-lab-lkp/linux/commits/Ziyue-Zhang/dt-bindings-PCI-qcom-Document-the-QCS615-PCIe-Controller/20250310-145902
base:   c674aa7c289e51659e40dda0f954886ef7f80042
patch link:    https://lore.kernel.org/r/20250310065613.151598-4-quic_ziyuzhan%40quicinc.com
patch subject: [PATCH v3 3/4] arm64: dts: qcom: qcs615-ride: Enable PCIe interface
config: arm64-randconfig-003-20250311 (https://download.01.org/0day-ci/archive/20250311/202503111654.Uo5Nw44p-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250311/202503111654.Uo5Nw44p-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503111654.Uo5Nw44p-lkp@intel.com/

All errors (new ones prefixed by >>):

>> Error: arch/arm64/boot/dts/qcom/qcs8300-ride.dts:288.1-6 Label or path pcie not found
>> Error: arch/arm64/boot/dts/qcom/qcs8300-ride.dts:298.1-10 Label or path pcie_phy not found
   FATAL ERROR: Syntax error parsing input tree

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

