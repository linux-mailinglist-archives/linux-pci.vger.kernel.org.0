Return-Path: <linux-pci+bounces-34765-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59093B36F7A
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 18:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 634784639E2
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 16:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2493164CF;
	Tue, 26 Aug 2025 16:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q9ZTeb6I"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C280E30FC3E;
	Tue, 26 Aug 2025 16:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756224043; cv=none; b=MpQUUb1fe3y+/OljInHVGhHEEwYqBt4LVpBp6OKXGMERH+AfzT+i7OvYM2/zPlEY2STBND2Z5KzzkFOoifdwVSyNKfMB+yfPYNXgeexLaoG+FbvG7zKPer1A63oz4P3Ui4CZX04TtwCuT21LZqVktWyER2u2chDexxweyoXhK4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756224043; c=relaxed/simple;
	bh=MvazfRK55Y+YfphRl006UAxhYW9WAxvC/vVYPiYdSR4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=GvdFX+DOaYgRbmzCYdqjIesPaXJtCcJ7Z7ciZSMMEoXwRig/jp3ZvPEW5IadoGtqPcWqvvO89cwVLdRKse09Aacx+cOWVc84zb8JaVDzK2vcQvaINrCBpjwJMuOLo+w6oXDGKa8cD70DBfYw1NaPmjd+1uE2rVx2zj6JejA8S3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q9ZTeb6I; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756224042; x=1787760042;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=MvazfRK55Y+YfphRl006UAxhYW9WAxvC/vVYPiYdSR4=;
  b=Q9ZTeb6I4ya61jsZXZMsSmBKNN0A0HE5a5ywSSr6VIvkca3zjazxIJ3P
   rE6rLRec7H0IQ8aPj9Wrx2nRG2d3tNFz691DT4uHfpyGgNwYas1gjrlJ9
   dkrNdYn5w1B2QKXiD/ctOya6aZH/c9Wvp2DfHoN/BZ6tUv6mXxA/9Pkvd
   aMTrr5fZru/1L8/iuKB79LYfUFiVKlJScA5cwrq8rP5n3zHZB186ebPAj
   taCHqWCTXRJ5sxPxZ41J/YQ6Rq1aTm86L0XN0nItrMQGPdnMxIDGQkDO7
   B8X17gb52tSzEP/2MeNJlqbGd3UGioBlWlsT1ySGNpWj633TAS3HE417V
   w==;
X-CSE-ConnectionGUID: MO0TTCxlT/uRxa7XDxz2vw==
X-CSE-MsgGUID: pv8PHRpeTQKqBBvtIaaJ7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="61099302"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="61099302"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 09:00:41 -0700
X-CSE-ConnectionGUID: zv1x8OSWQXeJW9G/Mr2ptw==
X-CSE-MsgGUID: saIygWOLRJWUlK7H39/AOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="169519770"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.4])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 09:00:29 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 26 Aug 2025 19:00:25 +0300 (EEST)
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
cc: manivannan.sadhasivam@oss.qualcomm.com, 
    Bjorn Helgaas <bhelgaas@google.com>, 
    Manivannan Sadhasivam <mani@kernel.org>, 
    Lorenzo Pieralisi <lpieralisi@kernel.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kwilczynski@kernel.org>, 
    Rob Herring <robh@kernel.org>, Nirmal Patel <nirmal.patel@linux.intel.com>, 
    Jonathan Derrick <jonathan.derrick@linux.dev>, 
    Jeff Johnson <jjohnson@kernel.org>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org, 
    linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, 
    ath11k@lists.infradead.org, ath10k@lists.infradead.org, 
    =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
    "Rafael J. Wysocki" <rafael@kernel.org>, 
    Qiang Yu <qiang.yu@oss.qualcomm.com>
Subject: Re: [PATCH v2 6/8] wifi: ath12k: Use pci_{enable/disable}_link_state()
 APIs to enable/disable ASPM states
In-Reply-To: <2fab10a7-8758-4a5c-95ff-2bb9a6dea6bf@oss.qualcomm.com>
Message-ID: <705a4fe5-658e-25ac-9e4d-6b8089abca46@linux.intel.com>
References: <20250825-ath-aspm-fix-v2-0-61b2f2db7d89@oss.qualcomm.com> <20250825-ath-aspm-fix-v2-6-61b2f2db7d89@oss.qualcomm.com> <2fab10a7-8758-4a5c-95ff-2bb9a6dea6bf@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 26 Aug 2025, Jeff Johnson wrote:

> On 8/25/2025 10:44 AM, Manivannan Sadhasivam via B4 Relay wrote:
> > --- a/drivers/net/wireless/ath/ath12k/Kconfig
> > +++ b/drivers/net/wireless/ath/ath12k/Kconfig
> > @@ -1,7 +1,7 @@
> >  # SPDX-License-Identifier: BSD-3-Clause-Clear
> >  config ATH12K
> >  	tristate "Qualcomm Technologies Wi-Fi 7 support (ath12k)"
> > -	depends on MAC80211 && HAS_DMA && PCI
> > +	depends on MAC80211 && HAS_DMA && PCI && PCIEASPM
> 
> As you point out in patch 1/8, PCIEASPM is protected by EXPERT.
> 
> Won't this prevent the driver from being built (or even showing up in
> menuconfig) if EXPERT is not enabled?

It doesn't work that way, PCIEASPM defaults to y:

$ sed -i -e 's|CONFIG_PCIEASPM=y|CONFIG_PCIEASPM=n|g' .config && make oldconfig && grep -e 'CONFIG_EXPERT ' -e 'CONFIG_PCIEASPM=' .config
#
# configuration written to .config
#
# CONFIG_EXPERT is not set
CONFIG_PCIEASPM=y

> Should we consider having a separate CONFIG item that is used to protect just
> the PCI ASPM interfaces? And then we could split out the ath12k_pci_aspm
> functions into a separate file that is conditionally built based upon that
> config item?
> 
> Or am I too paranoid since everyone enables EXPERT?

One just cannot control PCIEASPM value if EXPERT is not set. ASPM is 
expected to be enabled, or "experts" get to keep the pieces.

-- 
 i.


