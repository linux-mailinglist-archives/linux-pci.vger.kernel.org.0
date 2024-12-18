Return-Path: <linux-pci+bounces-18711-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E422F9F69CE
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 16:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73F1E18847F7
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 15:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6740C1BEF60;
	Wed, 18 Dec 2024 15:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LqGxlT6r"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890A81C5CCF;
	Wed, 18 Dec 2024 15:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734534786; cv=none; b=kbgZVl2aDIO0m8BJs0wTokN9MKyedFmrwSWlPeU/h/yJF1AG29sPUXhYU0iWijh0fIrXXhzgGSoQCX3aF2qewWbzW5JuN8gqhT2Eb5YQSAzQxQDbOmHe7r00iH2ywoSszWhsDIWo9UCWxGBWEAVYpbgFpd2iacYWvs404zKepNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734534786; c=relaxed/simple;
	bh=h/KTQvb5oy8GhiCfl5M3x0J5rQ6LFHeVg1+juvT60YA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=G6KvizvakjCpJe+b2MXQcL05hcGBWJKfQVvG+wu0CP162ENowUbWwFNMGtAGSsUibWzkPO6fNvS5Pk8VTmClNqg+ZPwq6CmOHVLAQiE4WH6OwZTwS4HKdDNfvUazaMegLHIhLivkpGtrGvHKcyUy/oZ6YcGWmSP9iHksXFvwals=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LqGxlT6r; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734534785; x=1766070785;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=h/KTQvb5oy8GhiCfl5M3x0J5rQ6LFHeVg1+juvT60YA=;
  b=LqGxlT6rfEh6v5Ir0Fp0zwJF7B8T3tMj53aKM8HiGllhANWIt4/c6m2f
   hhWRglOmtqXLZ3P8l2elgZIeENB4u2S4iYLJGYBGEQE0KH1E+CWSCdda3
   9/iMJHgrm/MHGbc/FsGSO/IVLaGTFtIhVZA7+67k6GLYeCle4mLKAxiUC
   azFJdZykSJPc5mXL/Hy/ogvhplbb6pY+174LKQcbCCsY/+kiKtLxTmIVK
   ckVX9EdhlsMijEmgfmiEofmDgqvRLz5oauinzSl1ShAfgK5h2A/NpMJ8O
   z1442S1nVAQqgVjVgC+6+NeBUiO3fCYINdkvUOoL2YlEL0Tcpgl3emBz0
   g==;
X-CSE-ConnectionGUID: 31plc68NS3uxHSijyD8EUw==
X-CSE-MsgGUID: diLb+T1KR7m7xLMT8eMMwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="35230281"
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; 
   d="scan'208";a="35230281"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 07:13:04 -0800
X-CSE-ConnectionGUID: Y3hNxbhRSJ6XXTWy45Gjgg==
X-CSE-MsgGUID: 3IhI7btwRpSc2lXMUFDbBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="102495180"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.138])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 07:13:01 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 18 Dec 2024 17:12:57 +0200 (EET)
To: Ma Ke <make_ruc2021@163.com>, Lukas Wunner <lukas@wunner.de>, 
    bhelgaas@google.com
cc: rafael.j.wysocki@intel.com, yinghai@kernel.org, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] PCI: fix reference leak in pci_alloc_child_bus()
In-Reply-To: <20241217035413.2892000-1-make_ruc2021@163.com>
Message-ID: <479bf618-187e-14f0-5319-c41f8b80faeb@linux.intel.com>
References: <20241217035413.2892000-1-make_ruc2021@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 17 Dec 2024, Ma Ke wrote:

> When device_register(&child->dev) failed, calling put_device() to
> explicitly release child->dev. Otherwise, it could cause double free
> problem.
> 
> Found by code review.
> 
> Cc: stable@vger.kernel.org
> Fixes: 4f535093cf8f ("PCI: Put pci_dev in device tree as early as possible")
> Signed-off-by: Ma Ke <make_ruc2021@163.com>
> ---
>  drivers/pci/probe.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 2e81ab0f5a25..d3146c588d7f 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1174,7 +1174,10 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
>  add_dev:
>  	pci_set_bus_msi_domain(child);
>  	ret = device_register(&child->dev);
> -	WARN_ON(ret < 0);
> +	if (ret) {
> +		WARN_ON(ret < 0);

The usual way is:

	if (WARN_ON(ret < 0))

> +		put_device(&child->dev);
> +	}
>  
>  	pcibios_add_bus(child);

But more serious problem here is that should this code even proceed as if 
nothing happened when an error occurs? pci_register_host_bridge() does 
proper rollback when device_register() fails but this function doesn't.

Into the same vein, is using WARN_ON() even correct here? Why should this 
print a stacktrace if device_register() fails instead of simply printing 
and error?

-- 
 i.


