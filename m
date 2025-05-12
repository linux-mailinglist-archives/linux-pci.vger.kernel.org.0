Return-Path: <linux-pci+bounces-27573-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D552AB34D8
	for <lists+linux-pci@lfdr.de>; Mon, 12 May 2025 12:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AF013BB299
	for <lists+linux-pci@lfdr.de>; Mon, 12 May 2025 10:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCAAE2641D1;
	Mon, 12 May 2025 10:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cBcoFfOY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2332525A32A;
	Mon, 12 May 2025 10:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747045434; cv=none; b=EkePP+9Jv6AID20JeO6VYtVD/QRlw/2KsMREy/Ask1rDvDlSdc51KFGgvMuPscY5cysNY/gX2/zw9wEcDK7EIdpH2raetPHEf8MRl2DsCCELog+nRSmzSqR+MpnUMtEzrabFIWN07CFB5rGltWtaz/249hh59noiwLbqiL6Yil4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747045434; c=relaxed/simple;
	bh=bUjI6qlVAAceceFnl6Zz3aGArQVeBhgk7QdxtcLy908=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d9lXuzXCSVb06YgWbhJt4JWM4upAkGmWMirfSODYxNCxXjLyhbOfDzQanbMjZY+BqCVKokmqkMS/WadiKnXlJvmcks+Nw4PcgqceUmf/7+uQRKsO514gNGSaiWFXIru3RKRuVP8tr/0DpFgNKPl5o9Zok+oDIUh3Xuu5nA2agAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cBcoFfOY; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747045434; x=1778581434;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bUjI6qlVAAceceFnl6Zz3aGArQVeBhgk7QdxtcLy908=;
  b=cBcoFfOYqh5cCJ4hwInI/hiEpbcCVCbs1u6F3HmY6/oh86VdZlnwFNFe
   QChOpsFCQCdf6c3TenTNGeXxvi/EpGW8EIXVZZ0+GYkAfkjIzF7un1E5G
   OrKpZBGEo2Qj06bFwr9L+0vJANTfEK3TFk3j5B89anJM1Y84f95bssDEh
   LpszC20IpXst92ftKsq0ZCUY9E1dlxsNNPEFFHGsBnC42CCwQlyQTUm3L
   vibXKrql2BWS45Wiy3+eCifoPoAYn70azeVLzZF6Y1RhMNgy9Cdv711fd
   xqX+a6P5kW6FuvOcqflf2iorebAZ03TTa2EKifvHPRgkfVEWKZ/DY+/qN
   Q==;
X-CSE-ConnectionGUID: W5q2ocv9SCqgTgiBWd1KSQ==
X-CSE-MsgGUID: RI1wjHKQRfiK6Fjfc3C+dg==
X-IronPort-AV: E=McAfee;i="6700,10204,11430"; a="48529605"
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; 
   d="scan'208";a="48529605"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 03:23:53 -0700
X-CSE-ConnectionGUID: 2dtO5S7tRveWfCh3fJCTig==
X-CSE-MsgGUID: /AnlC+2hQCG/f2eqCdUuGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; 
   d="scan'208";a="138297538"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 03:23:50 -0700
Date: Mon, 12 May 2025 13:23:47 +0300
From: Raag Jadav <raag.jadav@intel.com>
To: rafael@kernel.org, mahesh@linux.ibm.com, oohall@gmail.com,
	bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com, lukas@wunner.de,
	aravind.iddamsetty@linux.intel.com
Subject: Re: [PATCH v3] PCI: Prevent power state transition of erroneous
 device
Message-ID: <aCHMM7YMqT8onaKl@black.fi.intel.com>
References: <20250504090444.3347952-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250504090444.3347952-1-raag.jadav@intel.com>

On Sun, May 04, 2025 at 02:34:44PM +0530, Raag Jadav wrote:
> If error flags are set on an AER capable device, most likely either the
> device recovery is in progress or has already failed. Neither of the
> cases are well suited for power state transition of the device, since
> this can lead to unpredictable consequences like resume failure, or in
> worst case the device is lost because of it. Leave the device in its
> existing power state to avoid such issues.
> 
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> ---
> 
> v2: Synchronize AER handling with PCI PM (Rafael)
> v3: Move pci_aer_in_progress() to pci_set_low_power_state() (Rafael)
>     Elaborate "why" (Bjorn)
> 
> More discussion on [1].
> [1] https://lore.kernel.org/all/CAJZ5v0g-aJXfVH+Uc=9eRPuW08t-6PwzdyMXsC6FZRKYJtY03Q@mail.gmail.com/

Bump. Anything I can do to move this forward?

Raag

