Return-Path: <linux-pci+bounces-32809-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73182B0F34C
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 15:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1E0A1CC1B96
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 13:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DF22E6122;
	Wed, 23 Jul 2025 13:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BUhKhcYW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7CF2E7178;
	Wed, 23 Jul 2025 13:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753276071; cv=none; b=j2cDmpxsXBqSZt54vDAh8DrS9z+Ti/Pl6LlRG7N1Q8f74LagUhuH7vdkPwBFSbcknquyqXSYH8mhNDIQAzRN43G+/jB62k2sFoD9RW+H5xJ+oUSvEWHOzVgJ123rkROahLvPQ7m8LYu2wCKDMnPx1He8VW5Wahs2ZqucsrsGEgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753276071; c=relaxed/simple;
	bh=7Du2L0T3SVybkl85Z6KCUzEyx9a63ggI4T9qg2gyfzQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Yeuy/MOShpTZyFi9Vty2C9yrMI00kN5snT+zwGWcupM2PCftF9VzhXAzNVM5/8ot6c/GGyaSi8n41WaRvO3Zy6f63hEq/k3cvDGQTiQfR5E2FAQMAi6Wh39nt7b7NN9f2GkBwR81o2KOhcmAq/c5DctUZCi/Jq7a2X567ZZTcv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BUhKhcYW; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753276070; x=1784812070;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=7Du2L0T3SVybkl85Z6KCUzEyx9a63ggI4T9qg2gyfzQ=;
  b=BUhKhcYWdnYlnAGzgyBTkEwmMPPHin/VAtCPqzTCD1gS7KYy6xQ3wo6O
   2gYyQxrpF61/U2bzUx2MvTlecLgSMcIKdAbXHxmwOG1aXhu2OOFNFcAr0
   oFgFEoG2SOckjcOQ1svxBjVnedNayLCmFdj7T9z0axbRWCAAOMFD/fi6E
   2lidJ7wVYeYTJetuzNHqF2We6C4BHV/zZ29z/fwm5pnbCo12KF4pmZBy7
   KviGg6F8V/YOG9/rhNLe6hGHU9tMqNtw/U9j2ykhku1QRoAN73RBBdK3T
   Wn4PtCDkc+2jSJTetjVNfefeT5mHdrff/wTquE+YXElAs4tH+oMydK0RL
   w==;
X-CSE-ConnectionGUID: dct0+td5RISZwh9c5wvKIA==
X-CSE-MsgGUID: BPTur83iQGev1yQ05uqNuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="58171581"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="58171581"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 06:07:49 -0700
X-CSE-ConnectionGUID: pFVCqFc8T9yJHrgjqVPxxg==
X-CSE-MsgGUID: Hifib099TaSmTxr8qjpa6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="159253874"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.90])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 06:07:47 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 23 Jul 2025 16:07:42 +0300 (EEST)
To: Bjorn Helgaas <bhelgaas@google.com>
cc: linux-pci@vger.kernel.org, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    Tudor Ambarus <tudor.ambarus@linaro.org>, Rio <rio@r26.me>, 
    D Scott Phillips <scott@os.amperecomputing.com>, 
    LKML <linux-kernel@vger.kernel.org>, 
    =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH v2 0/3] PCI: Resource fitting algorith fixes
In-Reply-To: <20250630142641.3516-1-ilpo.jarvinen@linux.intel.com>
Message-ID: <9d141c1d-9cc0-30b4-e345-b3d458ccb1fc@linux.intel.com>
References: <20250630142641.3516-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-42418399-1753276062=:928"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-42418399-1753276062=:928
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 30 Jun 2025, Ilpo J=C3=A4rvinen wrote:

> This series addresses three issues in the PCI resource fitting and
> assignment algorithm.
>=20
> v2:
> - Add fix to resize problem (new patch)
>=20
> Ilpo J=C3=A4rvinen (3):
>   PCI: Relaxed tail alignment should never increase min_align
>   PCI: Fix pdev_resources_assignable() disparity
>   PCI: Fix failure detection during resource resize
>=20
>  drivers/pci/setup-bus.c | 38 ++++++++++++++++++++++++++------------
>  1 file changed, 26 insertions(+), 12 deletions(-)

Hi Bjorn,

You might have perhaps forgotten this series that addresses issues people=
=20
have reported over the last few months.

--=20
 i.

--8323328-42418399-1753276062=:928--

