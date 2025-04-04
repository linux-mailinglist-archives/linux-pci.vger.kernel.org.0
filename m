Return-Path: <linux-pci+bounces-25273-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA4CA7B722
	for <lists+linux-pci@lfdr.de>; Fri,  4 Apr 2025 07:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F07A189CC77
	for <lists+linux-pci@lfdr.de>; Fri,  4 Apr 2025 05:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D0816CD33;
	Fri,  4 Apr 2025 05:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VNsr+gX2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63E315B54C;
	Fri,  4 Apr 2025 05:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743744408; cv=none; b=l+58h9PsgcmvwBESvJXOF/B4n3Oe5oEd1L3NjMGl3dkg6iwlokzRF5oFJoiM9H/7TpctyFVdDytceQO77USyobuammhIXvLhAenPcR3vwbgz+Ph7gGIt8hLO+ilAKiTiGwbOwqlqafxPygQaYCEMIcKtpfU7qKZ2+WZT5MXZ3ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743744408; c=relaxed/simple;
	bh=68FORm/+PAAItJTs4YIhRng8DnrbZQIOdG8zHsV6wKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8lkL39Yn56u11Pm5dw2sLNhg7VWIN0aaNg3sYsCyvpYxSIUxerYvToPgP0bJhoEp/YQuedwzkcRWD+p9diSUVb79aOY402nEREVaXu+J8gfLlLJNo2Pv9ViGm/XfcdAGKYQEqFgyoxATksVlJ4jUm67fE7lAei6NXh0l/Nske0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VNsr+gX2; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743744407; x=1775280407;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=68FORm/+PAAItJTs4YIhRng8DnrbZQIOdG8zHsV6wKI=;
  b=VNsr+gX2g/31RqBWheIzvWp5UAtySBKpZtzlAMJfjFNIlL43D/WobhMI
   rkuQr3KwwHcIyltunDIw5gYEB1QMl+nfbrvDaHZDIXTfZrKB1MngLaMcH
   aGlRHkM9yOxQTQtpQ6qBep3iOd9bmLb3b0nKrf79E3nIrgItsckaw33Yr
   wpTuq2lao+YPp+Vw3TnD+P5PrX7ZhtDqtrAUfJ3cDqhMmzYLc8Vw+nkNG
   3xi4u5FSrXyPextWjBqMH1QbP6u/s2Cx2lRcN5CluG5ZhNThopLviji1l
   OGOabXqv9+mnG7OjSHeI0tGg73YmS/AQ+z7gHvp4WAUL2Ju+FG9Oh3Oyd
   A==;
X-CSE-ConnectionGUID: RY8en1KpSlC30iS+DaF+ww==
X-CSE-MsgGUID: 5mxGN99ZQx6f00fQqJ7Pfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11393"; a="62573985"
X-IronPort-AV: E=Sophos;i="6.15,187,1739865600"; 
   d="scan'208";a="62573985"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 22:26:47 -0700
X-CSE-ConnectionGUID: O1D/mr/XQ1enVuDDicwQOQ==
X-CSE-MsgGUID: 9OYiK1wPTfC5piPRJw+0PA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,187,1739865600"; 
   d="scan'208";a="128072246"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 22:26:44 -0700
Date: Fri, 4 Apr 2025 08:26:41 +0300
From: Raag Jadav <raag.jadav@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: mahesh@linux.ibm.com, oohall@gmail.com, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com, lukas.wunner@intel.com
Subject: Re: [PATCH v1] PCI/AER: Avoid power state transition during system
 suspend
Message-ID: <Z-9tkV_iPntpROn-@black.fi.intel.com>
References: <20250403074425.1181053-1-raag.jadav@intel.com>
 <CAJZ5v0gtUHbYPk-dFRwEZMnPv0gQG8+J+bwf8bahUskcDkw9HA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gtUHbYPk-dFRwEZMnPv0gQG8+J+bwf8bahUskcDkw9HA@mail.gmail.com>

On Thu, Apr 03, 2025 at 08:35:45PM +0200, Rafael J. Wysocki wrote:
> On Thu, Apr 3, 2025 at 9:45 AM Raag Jadav <raag.jadav@intel.com> wrote:
> >
> > If an error is triggered while system suspend is in progress, any bus
> > level power state transition will result in unpredictable error handling.
> > Mark skip_bus_pm flag as true to avoid this.
> 
> This needs to be synchronized with the skip_bus_pm clearing in pci_pm_suspend().

I'm wondering if we can have something like aer_in_progress flag
that we can use in PCI PM for this? ...

> Also, skip_bus_pm is only used in the _noirq phases, so if a driver
> calls pci_set_power_state() from its ->suspend() callback, this change
> won't help.

... and perhaps skip these if it is set?

Raag

