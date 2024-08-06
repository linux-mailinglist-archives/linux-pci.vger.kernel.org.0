Return-Path: <linux-pci+bounces-11362-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E668F94943C
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 17:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B18D286415
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 15:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03AF11EA0D1;
	Tue,  6 Aug 2024 15:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WPNAYG0Q"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102CE1BC08F;
	Tue,  6 Aug 2024 15:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722957104; cv=none; b=SI4CaY3+hwMGe2agu4722+uyW5LA5buuHZWOuZDEhZzSa3DN3GqUuWOLyS3CSgt7lOaKvDyo1xK/svhYWhsWjpPfE8Bwxv8+lr3kzgWuoKr4J1RkSHv7qJnY/HX5ta05HeGE8ZOf+8E8saLOZh06pI50u3dJJmKGExdq9i/89yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722957104; c=relaxed/simple;
	bh=7iqHXjjCeAj+TidcvK4r77b9VBp1itlsXMImcsXnbgk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gXzhKYuWjODQLQSK3C/u1DxGJytv7j7SAPoJcG3XoWR0svAOWDK1ac+V0ThzX/Phkz5xfm6MpS7qyfLpXhyIrIJ+TekhFSD5MIwqyUFcEFuJU4/0c1EjWmM41YChJlkGLzeKkf7TeBRzWPz+3ZyMS4UH5QdCDAvONJFA+XVvT0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WPNAYG0Q; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722957103; x=1754493103;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=7iqHXjjCeAj+TidcvK4r77b9VBp1itlsXMImcsXnbgk=;
  b=WPNAYG0QbuQkXEENa+kOmzEWj+/5MIHjnm4bSnUj63ID56/4Z9UHEN53
   XYfS8oxpIjL2ISrxR9XeAYz1SSzqvkLriEcX/LHJ83plpOeVL/7Pa4eLZ
   dLNjllVG5Uo+0dawVNxqISA1CAG/D/hqTm6k0WHiK0VEjUqrSiNr25Pzj
   nLzE7YWzUG0yri7+KjLhR9lSYxpl0NNp4q9icFdXDkc3ofEBlymI9hKDe
   x3eMnIg4YJMEE85YKiasPIcX94MGmPuhtZNE/ztUBScBjiw+TLe+mgiji
   mFYufkHFl22DIUONGwv5O/GhRMPricceMwJhhyU5rb4fz8Nm7uQzuvC7f
   w==;
X-CSE-ConnectionGUID: zPChqGqET6i92bjDy63JdQ==
X-CSE-MsgGUID: /bxfriooQ5WvIpuyb9bIwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="31650052"
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="31650052"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 08:11:42 -0700
X-CSE-ConnectionGUID: rsCG6K4CSa+HqeDrtlkZUg==
X-CSE-MsgGUID: 3Q9OiXZJSfCaScnoTt5eJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="60650645"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.72])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 08:11:40 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 6 Aug 2024 18:11:36 +0300 (EEST)
To: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
cc: bhelgaas@google.com, linux-pci@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: remove type return
In-Reply-To: <20240803140443.23036-1-trintaeoitogc@gmail.com>
Message-ID: <a7f0433d-11ab-b404-31a6-944cf9637472@linux.intel.com>
References: <20240803140443.23036-1-trintaeoitogc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 3 Aug 2024, Guilherme Giacomo Simoes wrote:

> I can see that the function pci_hp_add_brigde have a int return propagation.

typo in function name. Add parenthesis after function names like this:
pci_hp_add_bridge()

> But in the drivers that pci_hp_add_bridge is called, your return never is
> cheked.

checked.

> This make me a think that the add bridge for pci hotplug drivers is not crucial
> for functionaly and your failed only should show a message in logs.

functionality

> 
> Then, I maked this patch for remove your return propagation for this moment.

Please write the commit message using imperative tone. Don't use "I", 
"me", "you", "your", or "we" at all.

Also, you need to signoff your patches (please read 
Documentation/process/submitting-patches.rst).

The lack of return value checking seems to be on the list in
pci_hp_add_bridge(). So perhaps the right course of action would be to 
handle return values correctly.

-- 
 i.

> ---
>  drivers/pci/pci.h   | 2 +-
>  drivers/pci/probe.c | 7 +++----
>  2 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 79c8398f3938..a35dbfd89961 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -189,7 +189,7 @@ static inline int pci_proc_detach_bus(struct pci_bus *bus) { return 0; }
>  #endif
>  
>  /* Functions for PCI Hotplug drivers to use */
> -int pci_hp_add_bridge(struct pci_dev *dev);
> +void pci_hp_add_bridge(struct pci_dev *dev);
>  
>  #if defined(CONFIG_SYSFS) && defined(HAVE_PCI_LEGACY)
>  void pci_create_legacy_files(struct pci_bus *bus);
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index b14b9876c030..b13c4c912eb1 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -3352,7 +3352,7 @@ void __init pci_sort_breadthfirst(void)
>  	bus_sort_breadthfirst(&pci_bus_type, &pci_sort_bf_cmp);
>  }
>  
> -int pci_hp_add_bridge(struct pci_dev *dev)
> +void pci_hp_add_bridge(struct pci_dev *dev)
>  {
>  	struct pci_bus *parent = dev->bus;
>  	int busnr, start = parent->busn_res.start;
> @@ -3365,7 +3365,7 @@ int pci_hp_add_bridge(struct pci_dev *dev)
>  	}
>  	if (busnr-- > end) {
>  		pci_err(dev, "No bus number available for hot-added bridge\n");
> -		return -1;
> +		return;
>  	}
>  
>  	/* Scan bridges that are already configured */
> @@ -3381,8 +3381,7 @@ int pci_hp_add_bridge(struct pci_dev *dev)
>  	pci_scan_bridge_extend(parent, dev, busnr, available_buses, 1);
>  
>  	if (!dev->subordinate)
> -		return -1;
> +		pci_err(dev, "No bus subordinate");
>  
> -	return 0;
>  }
>  EXPORT_SYMBOL_GPL(pci_hp_add_bridge);
> 

