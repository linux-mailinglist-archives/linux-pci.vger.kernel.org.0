Return-Path: <linux-pci+bounces-22839-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0A2A4DFAB
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 14:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41E2B1899461
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 13:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D302868B;
	Tue,  4 Mar 2025 13:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P33avndS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEA82045AD
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 13:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741096203; cv=none; b=QM+eBvF1aXTfAeGW4fVi2Oqdo7+eWV/ZgzquJg6t+b2Utkq/34BziS0Hkcg1UN80Rv5MgPUMpKISoAFWYA9+6jwdaMEiSJSJa3eFXiDVwYiOXeaMQcpozaj1M88geFUOlZoG8I5ax9I51ZqwSOSvGLjownfKORQtKvyJp/zRsno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741096203; c=relaxed/simple;
	bh=5V2n4Ol/YIaFL/sIsn93eGOv7WmD2P0SaXmJke6dwPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ic5Lrkz0yyl3hvESK6hN6jfBO3+0sDAmGeEjVLv8UFBm8zMT6tWQ4EpbV5qst8+bn0BdLnVHXHIFjfG11/RAFDo9+gxDPvoZAzSCacl6/j+HyODzSa70P31KtvDf2lGn/q3KZwMtnz0azvTmsbzYyNRTKK0aacCo0QKkpjpvLKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P33avndS; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741096201; x=1772632201;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5V2n4Ol/YIaFL/sIsn93eGOv7WmD2P0SaXmJke6dwPw=;
  b=P33avndSnf4QQTCxtJ4/rQvEBY1MkrDn3ZRjZLSuPT2ejupU1qmnnQ+7
   TpEmyCHnK0QirJ5uhnip13SpiGkDZ8RV/e0dgsqn4TrVhPuGTjmfeDqUe
   ldXcBPFfoVlaGhGCi9b2ozHx1dpNpFWOHTCucqqs5hZOINtBR4DhgBbC2
   80AgsoJQA2KNl4Olv4Unw0xv1CRsah648YWu9oGwxn3X6c/0Z50hQR/MP
   7t+QicEU2rr5Xqb8E0TFSV3eBLb+kb63mZ6Izb1chNsTvlglNzBgKtb6O
   mRpSSRT7U/HrJy5smsezxNyEwiVm6Rk0ORx+mf927NTB5NM2TyVQOxL2d
   w==;
X-CSE-ConnectionGUID: o1jLNQ2pTwe1AoXnTWyD7A==
X-CSE-MsgGUID: tWHcT1wDQJGxjL52ptZRPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="29601817"
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="29601817"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 05:50:00 -0800
X-CSE-ConnectionGUID: NQv5HN7TQtKaJ9A2l20c7g==
X-CSE-MsgGUID: CZMr/zzmRdmHoTwZxAX8RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="123317663"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 04 Mar 2025 05:49:58 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tpSeh-000JpW-14;
	Tue, 04 Mar 2025 13:49:55 +0000
Date: Tue, 4 Mar 2025 21:49:07 +0800
From: kernel test robot <lkp@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, Bjorn Helgaas <helgaas@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, gregkh@linuxfoundation.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 09/11] PCI/IDE: Report available IDE streams
Message-ID: <202503042126.FUEGx8dD-lkp@intel.com>
References: <174107250696.1288555.15924775074966673629.stgit@dwillia2-xfh.jf.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174107250696.1288555.15924775074966673629.stgit@dwillia2-xfh.jf.intel.com>

Hi Dan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 7eb172143d5508b4da468ed59ee857c6e5e01da6]

url:    https://github.com/intel-lab-lkp/linux/commits/Dan-Williams/configfs-tsm-Namespace-TSM-report-symbols/20250304-152958
base:   7eb172143d5508b4da468ed59ee857c6e5e01da6
patch link:    https://lore.kernel.org/r/174107250696.1288555.15924775074966673629.stgit%40dwillia2-xfh.jf.intel.com
patch subject: [PATCH v2 09/11] PCI/IDE: Report available IDE streams
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20250304/202503042126.FUEGx8dD-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250304/202503042126.FUEGx8dD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503042126.FUEGx8dD-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pci/ide.c:495: warning: expecting prototype for pci_init_nr_ide_streams(). Prototype was for pci_ide_init_nr_streams() instead


vim +495 drivers/pci/ide.c

   480	
   481	/**
   482	 * pci_init_nr_ide_streams() - size the pool of IDE Stream resources
   483	 * @hb: host bridge boundary for the stream pool
   484	 * @nr: number of streams
   485	 *
   486	 * Enable IDE Stream establishment by setting the number of stream
   487	 * resources available at the host bridge. Platform init code must set
   488	 * this before the first pci_ide_stream_alloc() call.
   489	 *
   490	 * The "PCI_IDE" symbol namespace is required because this is typically
   491	 * a detail that is settled in early PCI init, i.e. only an expert or
   492	 * test module should consume this export.
   493	 */
   494	void pci_ide_init_nr_streams(struct pci_host_bridge *hb, int nr)
 > 495	{

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

