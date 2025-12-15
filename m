Return-Path: <linux-pci+bounces-43032-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D3097CBCCAC
	for <lists+linux-pci@lfdr.de>; Mon, 15 Dec 2025 08:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2750E300977F
	for <lists+linux-pci@lfdr.de>; Mon, 15 Dec 2025 07:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBA8313E1A;
	Mon, 15 Dec 2025 07:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kf2S0Cqb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F053E30C344;
	Mon, 15 Dec 2025 07:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765784279; cv=none; b=Xo4Qy7l4k+EpwdTLfq6+DjPLlJX6u/0qmYM+MSzSMIWy5m5Hu6eJi6dzMlUmbflO5oHxzeWTYGdepVZ142AiBoELWInJ/+qJr9UP500KjPTRH1YZne47GqY6NRt4fqX4/0nuru2VGtzqU99dHGGpagh2jO1UFrBPw5H1L+BxHp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765784279; c=relaxed/simple;
	bh=zj6ez14rUWdN0Mc8FMFftPnkpg+rLgHMVO0EWy29Unw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MWnqZK3cMtRKZgdiZWg1QiS46iz6zicbI7Xkd6eQpZ8ZmXPSc1QKeC2/8ObM9g8e77mn4sT4hUqxrhhOQH+0jnZanQWLyYNevU4g34/3nLv4jnChShNZAurRx6sWuZdE9cQETm23oKwS4M9pj6S5MWlYoBIFLVWhMejPiRm2GKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kf2S0Cqb; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765784277; x=1797320277;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zj6ez14rUWdN0Mc8FMFftPnkpg+rLgHMVO0EWy29Unw=;
  b=Kf2S0CqbZEWR1sexpuujKBCEpeGk9GfxYCepHFqiocuRizB5ly1DKECr
   E2Zirr3H0hwayHx8j55T5/QkQ3c7PzFM9vIbRTd5n/XV0UIsk2S2vxpD+
   8R+8YlunRHlmxDS9aJqLLbZvyARcOLSySlUGtSXuQgOIOSodfJPhpniBn
   PLdLHn7eRxvQJ1NaUGzWxic1SBvNzIPV6Tc6YqPxf4Iyvhm4sf/c8FuDU
   1oT3t+3ALivjNkvHqSkmDmoZtQdHw5r9cJM36RBLte05pYiu76bk6UOnY
   qWVgUKItLEU9SY6Lofks5b6jR+qfg9cgb1kZlJ9GaQVQZxftNtnsI2azn
   g==;
X-CSE-ConnectionGUID: rt7QE4LsSJm0XEHZ2hfKbA==
X-CSE-MsgGUID: ZMx3S/JeQ+KyjZX1D3PdmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11642"; a="78796247"
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; 
   d="scan'208";a="78796247"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2025 23:37:57 -0800
X-CSE-ConnectionGUID: JY08/7moSJ++G/pCIs3nvg==
X-CSE-MsgGUID: zBoLQ/XiRvGo7LJDHgeSPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; 
   d="scan'208";a="202157811"
Received: from igk-lkp-server01.igk.intel.com (HELO 8a0c053bdd2a) ([10.211.93.152])
  by orviesa004.jf.intel.com with ESMTP; 14 Dec 2025 23:37:55 -0800
Received: from kbuild by 8a0c053bdd2a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vV39U-000000002bO-3j1A;
	Mon, 15 Dec 2025 07:37:52 +0000
Date: Mon, 15 Dec 2025 08:37:16 +0100
From: kernel test robot <lkp@intel.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	Bjorn Helgaas <helgaas@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-doc@vger.kernel.org
Subject: [pci:trace 3/3] htmldocs: Documentation/trace/events-pci.rst:
 WARNING: document isn't included in any toctree [toc.not_included]
Message-ID: <202512150800.Vrs9LyvM-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git trace
head:   d1a2d5beb4d7fba6886df7f4a008707d4f85a71c
commit: d1a2d5beb4d7fba6886df7f4a008707d4f85a71c [3/3] Documentation: tracing: Add PCI tracepoint documentation
reproduce: (https://download.01.org/0day-ci/archive/20251215/202512150800.Vrs9LyvM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512150800.Vrs9LyvM-lkp@intel.com/

All warnings (new ones prefixed by >>):

   ERROR: Cannot find file ./include/linux/mutex.h
   WARNING: No kernel-doc for file ./include/linux/mutex.h
   ERROR: Cannot find file ./include/linux/fwctl.h
   WARNING: No kernel-doc for file ./include/linux/fwctl.h
   WARNING: ./include/uapi/linux/media/amlogic/c3-isp-config.h:199 #define c3_isp_params_block_header v4l2_isp_params_block_header; error: Cannot parse struct or union!
>> Documentation/trace/events-pci.rst: WARNING: document isn't included in any toctree [toc.not_included]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

