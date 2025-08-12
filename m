Return-Path: <linux-pci+bounces-33868-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5EB0B22DA2
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 18:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0C9750671C
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 16:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4742F90DA;
	Tue, 12 Aug 2025 16:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BD1X9zBY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD15D2F90C9;
	Tue, 12 Aug 2025 16:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755015867; cv=none; b=kUhu/voN3F3+hDEc2Z542qoipYJeQ5RKARUNDx3r+XikfwTQZtfIZQhagz75LbE2/gWCkgyKJHsCST/rIi1TrqRrSnWVXsSFcYdQbHculPymyP8CzfAw1jK1HKm2cJO73CQYZI8gQqmEmZ/4IM/9XlCZ2NR7CrCiOKeGAnZB42A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755015867; c=relaxed/simple;
	bh=q3ATWwbJnmhEV0tER11ue3lL09n8bcsLC90p1qBToR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PKm94dsritkodVsglInj+fFxXgGvW2ppUKtQYAgwT+H+6v3rkiQVD4zMKDBGvKKgehhwX7QQWv7jMi2fdt50aN5HoIreY7jaK25sP00SRGG5HCVEvnyZMLtSCG0cwivsOEB3bNdq8FXKebUorSjoQYbZnQ9lsX1Y3wW7KvsenS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BD1X9zBY; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755015866; x=1786551866;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q3ATWwbJnmhEV0tER11ue3lL09n8bcsLC90p1qBToR0=;
  b=BD1X9zBY/U8VTu6XBGOF+2j5ZS+oYGAFfCZ2DRzPcFrXtKpD5jJ8tjr8
   io2l5JKHeNrE74PDPjEK+GAnQRnFwlkjknkFwBCNLki11WJIDxKdqmGdF
   fyhrUtR9lRKxCw1wu7wnjeQ65Rpce8rs+AyFqSVtSblhu/XDoqJ382iz8
   UD/kEVeVc7zbZdk1Bb6pdhCgMnxE+1Fs6JBbmvZVG5sv7jfgmpLt/GGpp
   Yu3VZF3Y9Xs2bES32TiIAbzgIbt98L7rFPcRQ4jYq/mSE0EYgaR2YFh/F
   wsqTZH5nZPBjkX50VecjG20kO75pue5U077Qk/obrQCxu4Xxpx5Ay7G7M
   Q==;
X-CSE-ConnectionGUID: agXSYFprReS5hKqseFr7kQ==
X-CSE-MsgGUID: 8ZOqbmgpR1O/YgbrijuX8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="57378392"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="57378392"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 09:24:25 -0700
X-CSE-ConnectionGUID: yC4pQlA5TSWMd4+9pje4Aw==
X-CSE-MsgGUID: aWFQrDsnQvqkjbg6wiAiLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="170457391"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 12 Aug 2025 09:24:20 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ulrnN-0006zD-1K;
	Tue, 12 Aug 2025 16:24:17 +0000
Date: Wed, 13 Aug 2025 00:23:28 +0800
From: kernel test robot <lkp@intel.com>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Pavel Machek <pavel@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	"(open list:HIBERNATION (aka Software Suspend, aka swsusp))" <linux-pm@vger.kernel.org>,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	AceLan Kao <acelan.kao@canonical.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Merthan =?utf-8?Q?Karaka=C5=9F?= <m3rthn.k@gmail.com>,
	Eric Naim <dnaim@cachyos.org>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: Re: [PATCH v5 04/11] USB: Pass PMSG_POWEROFF event to
 suspend_common() for poweroff with S4 flow
Message-ID: <202508130049.aA2DXgHW-lkp@intel.com>
References: <20250811194102.864225-5-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811194102.864225-5-superm1@kernel.org>

Hi Mario,

kernel test robot noticed the following build errors:

[auto build test ERROR on 8f5ae30d69d7543eee0d70083daf4de8fe15d585]

url:    https://github.com/intel-lab-lkp/linux/commits/Mario-Limonciello-AMD/PM-Introduce-new-PMSG_POWEROFF-event/20250812-034228
base:   8f5ae30d69d7543eee0d70083daf4de8fe15d585
patch link:    https://lore.kernel.org/r/20250811194102.864225-5-superm1%40kernel.org
patch subject: [PATCH v5 04/11] USB: Pass PMSG_POWEROFF event to suspend_common() for poweroff with S4 flow
config: i386-randconfig-013-20250812 (https://download.01.org/0day-ci/archive/20250813/202508130049.aA2DXgHW-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250813/202508130049.aA2DXgHW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508130049.aA2DXgHW-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/usb/core/hcd-pci.c:650:27: error: 'hcd_pci_poweroff' undeclared here (not in a function); did you mean 'hcd_pci_poweroff_late'?
     650 |         .poweroff       = hcd_pci_poweroff,
         |                           ^~~~~~~~~~~~~~~~
         |                           hcd_pci_poweroff_late


vim +650 drivers/usb/core/hcd-pci.c

   640	
   641	const struct dev_pm_ops usb_hcd_pci_pm_ops = {
   642		.suspend	= hcd_pci_suspend,
   643		.suspend_noirq	= hcd_pci_suspend_noirq,
   644		.resume_noirq	= hcd_pci_resume_noirq,
   645		.resume		= hcd_pci_resume,
   646		.freeze		= hcd_pci_freeze,
   647		.freeze_noirq	= check_root_hub_suspended,
   648		.thaw_noirq	= NULL,
   649		.thaw		= hcd_pci_resume,
 > 650		.poweroff	= hcd_pci_poweroff,
   651		.poweroff_late	= hcd_pci_poweroff_late,
   652		.poweroff_noirq	= hcd_pci_suspend_noirq,
   653		.restore_noirq	= hcd_pci_resume_noirq,
   654		.restore	= hcd_pci_restore,
   655		.runtime_suspend = hcd_pci_runtime_suspend,
   656		.runtime_resume	= hcd_pci_runtime_resume,
   657	};
   658	EXPORT_SYMBOL_GPL(usb_hcd_pci_pm_ops);
   659	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

