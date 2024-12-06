Return-Path: <linux-pci+bounces-17823-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BDC9E6562
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 05:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 978021637E8
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 04:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E6014AD0D;
	Fri,  6 Dec 2024 04:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KVbQD37q"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3143118E057
	for <linux-pci@vger.kernel.org>; Fri,  6 Dec 2024 04:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733459028; cv=none; b=Ib5Vd+yi0ufxc7/sgI6nd6CHZAaf7E49dMgylx8S/GYSP+gd7hv2qDBMrrUqPap4/1OOdwq2QtrZ8phyvp21q0zL9wYjtwdgga48joOZyeElF+/SHHfGNgCa5djWpfL6h6V0VktJv3syYyxgcr9oGS/PpT/sGLtgkfhoE0dS1Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733459028; c=relaxed/simple;
	bh=1LAUqr6JVKFrcaMn88Pba9Cgc2UpWDmAHRTj5oibo8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXSWD46O1y7voVRF39drjcqdOJkESiyweMKDP2pM4On9tbojqIq81mKMLKQZyaCygOHr3Fi2ZOOmsjzX3s5G8SQDPfVtUvVC4MncxXR4G64bu7PJUuPARQTB5ywK3v0JlefkUw2HZhcRp4Xw1bdQMc8WDKqd4VHN9KSqht7wjVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KVbQD37q; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733459026; x=1764995026;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1LAUqr6JVKFrcaMn88Pba9Cgc2UpWDmAHRTj5oibo8E=;
  b=KVbQD37qtL+nTEReuq9Q1H1M0tWHU5LV5RrPc5eKVNpnjJRE4iW9KRvn
   24poK7wNgK8UooyH7oNemL5wteGUsOIRFkQIl8rLjj9tgqNMzUQcKHk0O
   d8YBEkEPnXVhESoPN+H66a7XjehfnmphX5jAMxVRYw45am38CC0ana9bl
   BaL9BJunmxCgIr7SrCJsnzXrZyuUhdlqk61g9t8DMexhbkAgIwT8WOq2f
   ExySiBFuxSqWvKlaPpVB1yjpwT1SWybINoYnf8PHjZUd14pQjTCS7FD3K
   IZrDcOHjK3NWY9/CqoNx9jdY5pv3Ddowtoas6ylAfvEM5TeHsVWg0ZNL6
   w==;
X-CSE-ConnectionGUID: vLRXWH/lRRK78/zlEWzyJw==
X-CSE-MsgGUID: N4fcEQ5yR/a2i17b/XRrIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="33716004"
X-IronPort-AV: E=Sophos;i="6.12,212,1728975600"; 
   d="scan'208";a="33716004"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 20:23:45 -0800
X-CSE-ConnectionGUID: IzwPzyCZSGun3oSW+zInEg==
X-CSE-MsgGUID: uPFNLp11S/aUlnUjPXgbvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,212,1728975600"; 
   d="scan'208";a="94657550"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 05 Dec 2024 20:23:42 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tJPsR-0000hD-2K;
	Fri, 06 Dec 2024 04:23:39 +0000
Date: Fri, 6 Dec 2024 12:23:34 +0800
From: kernel test robot <lkp@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, Bjorn Helgaas <helgaas@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, linux-pci@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH 06/11] samples/devsec: PCI device-security bus / endpoint
 sample
Message-ID: <202412061214.KMe4sOrh-lkp@intel.com>
References: <173343743095.1074769.17985181033044298157.stgit@dwillia2-xfh.jf.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173343743095.1074769.17985181033044298157.stgit@dwillia2-xfh.jf.intel.com>

Hi Dan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 40384c840ea1944d7c5a392e8975ed088ecf0b37]

url:    https://github.com/intel-lab-lkp/linux/commits/Dan-Williams/configfs-tsm-Namespace-TSM-report-symbols/20241206-064224
base:   40384c840ea1944d7c5a392e8975ed088ecf0b37
patch link:    https://lore.kernel.org/r/173343743095.1074769.17985181033044298157.stgit%40dwillia2-xfh.jf.intel.com
patch subject: [PATCH 06/11] samples/devsec: PCI device-security bus / endpoint sample
config: i386-kismet-CONFIG_TSM-CONFIG_SAMPLE_DEVSEC-0-0 (https://download.01.org/0day-ci/archive/20241206/202412061214.KMe4sOrh-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20241206/202412061214.KMe4sOrh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412061214.KMe4sOrh-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for TSM when selected by SAMPLE_DEVSEC
   WARNING: unmet direct dependencies detected for TSM
     Depends on [n]: VIRT_DRIVERS [=n]
     Selected by [y]:
     - SAMPLE_DEVSEC [=y] && SAMPLES [=y] && PCI [=y] && X86 [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

