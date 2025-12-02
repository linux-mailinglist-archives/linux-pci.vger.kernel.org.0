Return-Path: <linux-pci+bounces-42519-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB3AC9C998
	for <lists+linux-pci@lfdr.de>; Tue, 02 Dec 2025 19:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1D63A347554
	for <lists+linux-pci@lfdr.de>; Tue,  2 Dec 2025 18:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1079E2222B2;
	Tue,  2 Dec 2025 18:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nYbClQdq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B3129AAF8;
	Tue,  2 Dec 2025 18:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764699619; cv=none; b=TOsf3v5sxC0Q+aecGwzo88bO6/DL2aMaTXbgLUtt4Hss1rFRAC9GZRPuuc99xjSwjO69ot8Kx4+Sltgx9xqmCLXSqGVVxQRpiA8rRCEV2gUbshsZzlWcOQ/lkUjXtEbVLkcrMuOpCX+XW1HpZKWAxXnSVtROYInYzZoeIBKH5MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764699619; c=relaxed/simple;
	bh=Q1pnpMycPTcfUBPrUUt1S0MCLc06h5h2ic7QM5UwDMU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=NtSCOjWRBVDNtRGgJBHEsjKIDDBo2VEo2AKO/npf/XPwZLFtJt0IaUbLNR7W0IOW0OQtCmvcdM85l21rx6TMW+8tMAeIeEx581TWX5FcxXIpiESOdiNHRtUxNFKqeZx7/FP9vDOXQkji7rVdL4Pi1eb7qC+z/VF28kKZjELinkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nYbClQdq; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764699617; x=1796235617;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=Q1pnpMycPTcfUBPrUUt1S0MCLc06h5h2ic7QM5UwDMU=;
  b=nYbClQdqhWJLQ7VDRnKDwcd2Bx9NgBbu1WUFVlOHZGJXPg4Elhh6GssY
   2a5u9efk39XyKsUKLvCqPNjdwClAvJmx0nayMNMG+i50orjaMqEX9mMix
   nlS10Ps0ngVyf/bdsu+BZSIECXZ9RBPvc09Rt8Kz/JcjcIjlvZq15wXYx
   M3n0cQs47gT9vwIfa0JV0Un8qPdWszx73k6hVoYi7cUMt8SOYfbW2QXn7
   1uzLkGF94gmqNVyOh9QQs/P7e+iIPt+9W1z1o97wpSixnT33FvITo8ner
   nL4ifNvDJdUVAN5vUO06kxM66tXu8UaeGrWSjXW0cCRlbqkhr+lUiYfJf
   w==;
X-CSE-ConnectionGUID: zZdGOV6sTU2gNbO53kzpWw==
X-CSE-MsgGUID: apxscksHQfarMicWaeauxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="92159530"
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; 
   d="scan'208";a="92159530"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 10:20:16 -0800
X-CSE-ConnectionGUID: 2xn5FmLkT4ikwkZSgEiHlg==
X-CSE-MsgGUID: GeChwnoGSt6s7OxVZMtTeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; 
   d="scan'208";a="194867394"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.183])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 10:20:12 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 2 Dec 2025 20:20:09 +0200 (EET)
To: =?ISO-8859-15?Q?Ren=E9_Rebe?= <rene@exactco.de>
cc: glaubitz@physik.fu-berlin.de, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, bhelgaas@google.com, 
    riccardo.mottola@libero.it
Subject: PCI bridge window issue (Was: Re: [PATCH] PCI: Fix PCI bridges not
 to go to D3Hot on older RISC systems)
In-Reply-To: <20251202.180451.409161725628042305.rene@exactco.de>
Message-ID: <9c120cee-dadf-e5e4-3e27-f817499d27ec@linux.intel.com>
References: <20251202.174007.745614442598214100.rene@exactco.de> <05c588754dcb83badaec6930499392fdd26be539.camel@physik.fu-berlin.de> <20251202.180451.409161725628042305.rene@exactco.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1607897649-1764699147=:974"
Content-ID: <c00fa278-07a9-58c5-466a-d13444b01a29@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1607897649-1764699147=:974
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <ef412106-8bbf-2d77-2407-a88cc0729b81@linux.intel.com>

On Tue, 2 Dec 2025, Ren=E9 Rebe wrote:

> s390x. Maybe users of those want to allow list after testing? Now that
> I think about it I was wondering why ALSA RAD1 audio is not longer
> working in my Sgi Octane with the PCI window not being enabled. Would
> not suprise me it was some change like this, too. Should bisect next

Hi Ren=E9,

Could you please send me a dmesg and contents of the /proc/iomem (taken=20
with root right so it shows the real addresses) so I can look at this PCI=
=20
bridge window issue. If you know a working kernel, having logs from=20
working and broken case would be very helpful to easily locate the=20
differences.

At this point, no need to bisect as I might be able to figure it out even=
=20
without pinpointing the commit. To avoid spending on issues that are=20
already know and have a fix, please check you're not running somewhat old=
=20
kernel as I've already fixed a few things that have gotten broken due to=20
recent made PCI bridge window fitting and assignment algorithm changes.


--=20
 i.
--8323328-1607897649-1764699147=:974--

