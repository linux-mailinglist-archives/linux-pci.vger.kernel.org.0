Return-Path: <linux-pci+bounces-27275-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44333AAC285
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 13:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C2951C21896
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 11:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A622227AC29;
	Tue,  6 May 2025 11:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VvyW678R"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F5E27A457;
	Tue,  6 May 2025 11:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746530758; cv=none; b=gcQo0d7cEV44cC23fxapHW/1fUI+fdOliW0cFUXJJKZCPUOMOQN+fceeTbRXO9WYE/TF9rblWJwCY7acAkrKT6qr3T+07o0PtCsYQz8FAICJPouCHOnS8FQLB1o58karSMKzdQyYTjDi6Frwm7Po/Mt+nPzcf4bXacrpaFW0qco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746530758; c=relaxed/simple;
	bh=XgTcwR/r+H6X7/Vl3b1xNmXP3hP0XvRCLfIkPJ8BL94=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=V2PbV9dcFh5i7vrxaQ0lhjYA4C2Pr1/tRV+koooR+fMsGSu1m0klarPV5DrOoo9t1EkGtmWVEzgav4pwo6FXG5BB1e5laX+2EEsQtgazey1dJgXB6rc6D9PpkPkDpTJz1f28jRXOh0if54Jm2zgwGTxSDTJCFdzx8gFCvT1wtR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VvyW678R; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746530758; x=1778066758;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=XgTcwR/r+H6X7/Vl3b1xNmXP3hP0XvRCLfIkPJ8BL94=;
  b=VvyW678RCMmcVy+g9N6ul4LaULTWoBpIAYk4/jPaynTVJFwUNFl/TDWz
   Ghku7z8pqKDkueLDRhQ9m8zundcsxv4bGDtYIQESdxGm3I+kuJesv7LvH
   7skrcZJ4fT4X5RZJMSryz+gbaw4SPaSUHyc0eoT2POVe4Z3EERuOEuwWM
   AW6O3YAB55gDshgM3JSHPltG2H+GPy+E3SvRkkS/WsfJo+GUn3eZqcApz
   xOEKCuBZjFFfg16L+NUlzEVpduzKj5ejiJ3ryceGC53tPPe6t62gK6N1R
   wD1nRxxvv0nUsobKaXZz/kuIwo0gEjRjMtU7RVPX8wentZTpT7Q8LqZvU
   A==;
X-CSE-ConnectionGUID: UeJShn9IScWbG/+GOIq+sw==
X-CSE-MsgGUID: Ek9DgO0JQ165FY0VVIjEKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="48100769"
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; 
   d="scan'208";a="48100769"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 04:25:57 -0700
X-CSE-ConnectionGUID: qzo0UWuWQwK0jmC1MsNUog==
X-CSE-MsgGUID: 7/ub2ltuQVaMlzkbDRaidA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; 
   d="scan'208";a="135973628"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.207])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 04:25:54 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 6 May 2025 14:25:51 +0300 (EEST)
To: Randy Dunlap <rdunlap@infradead.org>
cc: Stephen Rothwell <sfr@canb.auug.org.au>, 
    Linux Next Mailing List <linux-next@vger.kernel.org>, 
    Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
    linux-pci@vger.kernel.org
Subject: Re: linux-next: Tree for May 5 (drivers/pci/pcie/bwctrl.c)
In-Reply-To: <0ab5fe5d-feda-4a3a-8803-92eb4e52e3b4@infradead.org>
Message-ID: <cbd7bfaf-613e-631b-db39-b63864049f4b@linux.intel.com>
References: <20250505184148.210cf0aa@canb.auug.org.au> <0ab5fe5d-feda-4a3a-8803-92eb4e52e3b4@infradead.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 5 May 2025, Randy Dunlap wrote:

> 
> 
> On 5/5/25 1:41 AM, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Changes since 20250502:
> > 
> 
> on x86_64:
> 
> drivers/pci/pcie/bwctrl.c:56:22: warning: 'pcie_bwctrl_lbms_rwsem' defined but not used [-Wunused-variable]
>    56 | static DECLARE_RWSEM(pcie_bwctrl_lbms_rwsem);
>       |                      ^~~~~~~~~~~~~~~~~~~~~~
> include/linux/rwsem.h:153:29: note: in definition of macro 'DECLARE_RWSEM'
>   153 |         struct rw_semaphore lockname = __RWSEM_INITIALIZER(lockname)
>       |                             ^~~~~~~~

Thank for the heads up, I don't know what I was thinking. I remove all 
code related to that rwsem but forgot to remove the rwsem itself. I'll 
send a patch once our build tester has had the opportunity to check it.

-- 
 i.


