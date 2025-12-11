Return-Path: <linux-pci+bounces-42973-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E275CB6E11
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 19:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBA293014DA4
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 18:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C561314B6B;
	Thu, 11 Dec 2025 18:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U0pMKs9O"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2351F03EF;
	Thu, 11 Dec 2025 18:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765476847; cv=none; b=sZH2ZSO6rk6PEM26HG+DDawSD/hencc4+XmdvWI+0tLNGIgSUHy6/nuX6I4QTyGYkcOF0GotYKjrgRA4eq5pt1tYMQhVVjYLwVgfkighrULLT7ZtdunB0e3LNXir/NFcWGC/sGaazVumi8sfu39S7w8K5YcuKAxRC5SbyjOL5Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765476847; c=relaxed/simple;
	bh=cGxYwCPDE5A+p8ufzsc2mUrMM0eBI6JaL3ahMzhCjH4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=LABLK9aiIPVAAXEMuCx62PtdrzxHvZ2onUvrwEaO7TFZha+ahvVCkwb/wab49zGbPQJyiXC2bEmyf5Mbmox60dwDsFbm5aMbc+RANOr50us75wnQzsOiEoKpe+uCgZBCXsTRkzgrOgKaHMFRSWjAoGjoRuzSmlgD2w3KXHNh11I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U0pMKs9O; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765476846; x=1797012846;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=cGxYwCPDE5A+p8ufzsc2mUrMM0eBI6JaL3ahMzhCjH4=;
  b=U0pMKs9OMWGL6PZMlJydUOwMyfY/R43v+FZQYsT7qka4x8zQohtKJT25
   Oxp4MQFxA6GMjrP+CjecSpVre5lcmxET/Dwl+45QplAzmrPtEcqJSsP0T
   UQ2VdJEEUIG/SQAvBCsZwL9Yi3cv4HtYNuVXZ1jEPIZ2ZyI4NNSnuCQTx
   fN6gN/nRa2UjcxpseqHxvDCsieVjR1F1G+nc57rJlCRlx4Hfx4Iejiokb
   nu1w4e7CVQtlwhNOd5u9uIHmW+dNH1G6jc3lYGIPnb2eLX7bvQgf/CssL
   8INN8lGx+RndNnzUpKwCCVIqkKBG7fCZiT8J2d31ldLWxnFAN1HjnRqp3
   Q==;
X-CSE-ConnectionGUID: 8D5vK2M2T7KvTzN8rj4NyQ==
X-CSE-MsgGUID: 6kMBb/weRmGvoCPp7wSyZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="90118651"
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; 
   d="scan'208";a="90118651"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 10:14:06 -0800
X-CSE-ConnectionGUID: fUi1pl5ATuCvc0+Cu3HmKQ==
X-CSE-MsgGUID: W6cWJJyYSMOAKQ0qyD39wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; 
   d="scan'208";a="197684375"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.219])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 10:14:02 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 11 Dec 2025 20:13:59 +0200 (EET)
To: Jinhui Guo <guojinhui.liam@bytedance.com>
cc: bhelgaas@google.com, kbusch@kernel.org, dave.jiang@intel.com, 
    dan.j.williams@intel.com, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] PCI: Remove redundant pci_dev_unlock() in
 pci_slot_trylock()
In-Reply-To: <20251211123635.2215-1-guojinhui.liam@bytedance.com>
Message-ID: <360c5c8e-dfc7-a88b-fa20-a157da87ea74@linux.intel.com>
References: <20251211123635.2215-1-guojinhui.liam@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 11 Dec 2025, Jinhui Guo wrote:

> Commit a4e772898f8b ("PCI: Add missing bridge lock to pci_bus_lock()")
> delegates the bridge device's pci_dev_trylock() to pci_bus_trylock()
> in pci_slot_trylock(), but it leaves a redundant pci_dev_unlock() when
> pci_bus_trylock() fails.
> 
> Remove the redundant bridge-device pci_dev_unlock() in pci_slot_trylock(),
> since that lock is no longer taken there.

Doesn't it cause issues if trying to unlock something that wasn't locked 
so saying its "redundant" seem a bit an understatement?

> Fixes: a4e772898f8b ("PCI: Add missing bridge lock to pci_bus_lock()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
> ---
>  drivers/pci/pci.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 13dbb405dc31..75a98819db6f 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5347,7 +5347,6 @@ static int pci_slot_trylock(struct pci_slot *slot)
>  			continue;
>  		if (dev->subordinate) {
>  			if (!pci_bus_trylock(dev->subordinate)) {
> -				pci_dev_unlock(dev);
>  				goto unlock;
>  			}
>  		} else if (!pci_dev_trylock(dev))
> 

-- 
 i.


