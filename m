Return-Path: <linux-pci+bounces-44166-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C2DCFD16A
	for <lists+linux-pci@lfdr.de>; Wed, 07 Jan 2026 11:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4BA553019370
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jan 2026 10:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CAB3009CB;
	Wed,  7 Jan 2026 10:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AAowDILE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A252F6574;
	Wed,  7 Jan 2026 10:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767780203; cv=none; b=sffDsAVpYCKOnBbF5g3k0Kuts4G9nftIsopHRBWU4T4+LtZU0Pm1hxZbDPjJoMT4pV+8fwUYDVWkzmc2uNo5ALWxwNDgBQ+hTmbd3JlOf3rhnFDBwzG7yY3VNpIarEYlg46jg27rKt43ccJnM2FzrONtnr8rk8mn5aeI1Q23VA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767780203; c=relaxed/simple;
	bh=aGZNsRq6iMUStbzb49O2/+lRO2eS1WP+UQOJsgeuc/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rqQuxe1RJG2XGrSQ0HmHikIRKRxQh5Me1qJkf1Zjdw6Drhq0tEl6qQyL12TeklcAXMHbrmpWSt6LHYzPx2jYYB6UwPFasyRZTUA/sM/rLlW0W25UkwqIH/2TN3WFbOVz+Rws5PGU0BKnnUqG9A5fiYnYsyCyomoYzFdqSU9fBKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AAowDILE; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767780201; x=1799316201;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=aGZNsRq6iMUStbzb49O2/+lRO2eS1WP+UQOJsgeuc/I=;
  b=AAowDILEbTyeDOxz73HLEuaQh9ohrEqfqQpBv7UTeMfPLACwjFj1SKnl
   vv2exCHJAVpv8Yk2bAio3c6pO4ljqbm+iwKX4pxda1j2aTPBWXBFoWjMb
   3lu6S/KdFt0zZXfdPB1nsMGtEbGfH9XydQcD7fG3LCuOCLOEq+eusoO4j
   EU4YLZMInkl67o+56q2rnrD9aFxyrKy/iWJQyUngQYL3OuvxtpYD7Naqg
   CXlsAAqqCJaeTHcSUEJuJLRanJc7b4tWzjTWmReeT4oNM7zAokDewPzDa
   hD/h7aXyGaJIMeSi6g0AXD+7AlUh9389Lh5ca3YK+fslFrST2HJdiYLqj
   A==;
X-CSE-ConnectionGUID: BCUB/IL1S0WVfnSqMMKweg==
X-CSE-MsgGUID: KCzngi4QTFyWojN7k5s+EA==
X-IronPort-AV: E=McAfee;i="6800,10657,11663"; a="69306991"
X-IronPort-AV: E=Sophos;i="6.21,207,1763452800"; 
   d="scan'208";a="69306991"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 02:03:20 -0800
X-CSE-ConnectionGUID: 1vzy2TJkSyqoiLlIaF1o0A==
X-CSE-MsgGUID: +i1fO7aWT7S/ww7fqeWjag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,207,1763452800"; 
   d="scan'208";a="234028651"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa001.fm.intel.com with ESMTP; 07 Jan 2026 02:02:30 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id B844398; Wed, 07 Jan 2026 11:02:17 +0100 (CET)
Date: Wed, 7 Jan 2026 11:02:17 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Cc: YehezkelShB@gmail.com, andreas.noever@gmail.com, bhelgaas@google.com,
	dave.jiang@intel.com, feng.tang@linux.alibaba.com,
	helgaas@kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-usb@vger.kernel.org,
	lukas@wunner.de, sathyanarayanan.kuppuswamy@linux.intel.com,
	westeri@kernel.org
Subject: Re: [PATCH] PCI/portdev: Disable AER for Titan Ridge 4C 2018
Message-ID: <20260107100217.GP2275908@black.igk.intel.com>
References: <20260107093021.GN2275908@black.igk.intel.com>
 <20260107095435.1390-1-atharvatiwarilinuxdev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260107095435.1390-1-atharvatiwarilinuxdev@gmail.com>

On Wed, Jan 07, 2026 at 09:54:33AM +0000, Atharva Tiwari wrote:
> I’ve been using the mainline kernel
> (which I compiled about two weeks ago),
> and the problem still isn’t fixed,
> so PTM is most likely not the root cause.

Okay, what device you have connected there?

Can you provide full dmesg and output of 'sudo lspci -vv') when that device
is connected?

