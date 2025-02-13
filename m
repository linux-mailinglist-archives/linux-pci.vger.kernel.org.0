Return-Path: <linux-pci+bounces-21354-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B62E9A3433D
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 15:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6554818943F5
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 14:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDE7221552;
	Thu, 13 Feb 2025 14:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RiQZxLbQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE779281349;
	Thu, 13 Feb 2025 14:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739457707; cv=none; b=UGHYJypGVxPj/MTdBs0HKQX7S1U0IIto/i2bpTPs8Zot4oWSZUqFC8O8EwA9LIoceKzIsRDTK1+fqEZtDu/rOY/VZrf/hYb7cM+IynM5Zx/goIBCh2HdMg+s0E3awmjFn5VotUy2viqqMRMyqS1/4z8rc/nkeIXFHgpMtEPfe38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739457707; c=relaxed/simple;
	bh=Rq8fIdQMi+gnpDfTYBDiGG6pp7bH7+BqFv+HH8CSRNw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=mrfRhgDbD90rluUPjjsElHP74WubEIo9/S+TsEZXvJAwJkDvu15ZUAloc7fqCQrH6p0uue4fqim1f1+yeqBxS5BTNeUtP0UtveRtvN7fSPIYrjooBG0ztz28HZyKlal+ylHTXEax02dOd7f+Yjz0oyHHRZB36WJ4jQTzVdGA2WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RiQZxLbQ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739457706; x=1770993706;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Rq8fIdQMi+gnpDfTYBDiGG6pp7bH7+BqFv+HH8CSRNw=;
  b=RiQZxLbQzT9IqwD/AgvdXGwEeEJq7mxxEiNPPOHCQ6fo8QAhuVPT6Ik8
   gyLjATPqG74riQHgpb/Q0tBbk9/6j5hmAq50229jj9bnlH1mNFhsA6GIl
   PJEUkwsPYZ0yZDqIYJpWTEB1sVvj7W79ySh/xAqo92xZ1Yq1FrNJwDaBI
   Y+PbKdxyMfZrqR33puCyY4ClDF1pDEuRz6+wzXfudU+p1arRe/yRfF6Wk
   /xE5CDx7mQhGF4hD4mlp0pKFmMZjxkE/t7cfGTT5Jw8AGLTg2wkXhGPYg
   SkIJckjSTT3c1JA0LVUMbS7FeanogWyJ4Ka4/D5feY0qe4GseN5SmTjXw
   A==;
X-CSE-ConnectionGUID: jBWUGsTHR9yYAUVcN7DH7g==
X-CSE-MsgGUID: 3sVzZBzZQGK/G4S1iiaqUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="40312991"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="40312991"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 06:41:45 -0800
X-CSE-ConnectionGUID: MsVKU+nDRKmcoXBn6D4PcQ==
X-CSE-MsgGUID: urJ9zrrDSRqSGVKzwWhNTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="113826355"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.48])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 06:41:43 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 13 Feb 2025 16:41:40 +0200 (EET)
To: Keith Busch <kbusch@kernel.org>
cc: Bjorn Helgaas <helgaas@kernel.org>, Purva Yeshi <purvayeshi550@gmail.com>, 
    bhelgaas@google.com, skhan@linuxfoundation.org, linux-pci@vger.kernel.org, 
    linux-kernel@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] drivers: pci: Fix flexible array usage
In-Reply-To: <Z6u-pwlktLnPZNF-@kbusch-mbp>
Message-ID: <ccdd2c39-1b28-551f-decf-e0d7609f2464@linux.intel.com>
References: <Z6qFvrf1gsZGSIGo@kbusch-mbp> <20250211210235.GA54524@bhelgaas> <Z6u-pwlktLnPZNF-@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 11 Feb 2025, Keith Busch wrote:

> On Tue, Feb 11, 2025 at 03:02:35PM -0600, Bjorn Helgaas wrote:
> > This is kind of a complicated data structure.  IIUC, a struct
> > pci_saved_state is allocated only in pci_store_saved_state(), where
> > the size is determined by the sum of the sizes of all the entries in
> > the dev->saved_cap_space list.
> > 
> > The pci_saved_state is filled by copying from entries in the
> > dev->saved_cap_space list.  The entries need not be all the same size
> > because we copy each entry manually based on its size.
> > 
> > So cap[] is really just the base of this buffer of variable-sized
> > entries.  Maybe "struct pci_cap_saved_data cap[]" is not the best
> > representation of this, but *cap (a pointer) doesn't seem better.
> 
> The original code is actually correct despite using a flexible array of
> a struct that contains a flexible array. That arrangement just means you
> can't index into it, but the code is only doing pointer arithmetic, so
> should be fine.
> 
> With this struct:
> 
> struct pci_saved_state {
>  	u32 config_space[16];
> 	struct pci_cap_saved_data cap[];
> };
> 
> Accessing "cap" field returns the address right after the config_space[]
> member. When it's changed to a pointer type, though, it needs to be
> initialized to *something* but the code doesn't do that. The code just
> expects the cap to follow right after the config.
> 
> Anyway, to silence the warning we can just make it an anonymous member
> and add 1 to the state to get to the same place in memory as before.
> 
> ---
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 869d204a70a37..e562037644fd0 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1929,7 +1929,6 @@ EXPORT_SYMBOL(pci_restore_state);
>  
>  struct pci_saved_state {
>  	u32 config_space[16];
> -	struct pci_cap_saved_data cap[];

Can't just [] be dropped from it (and removed from the size calculation)?

It's not a real flex array because the second pci_cap_saved_data is not at 
->cap[1] but calculated by the loop by adding in the data in between. But 
there's one entry at ->cap[0] which is same as ->cap, no need to make it 
a flex array at all, IMO.

>  };
>  
>  /**
> @@ -1961,7 +1960,7 @@ struct pci_saved_state *pci_store_saved_state(struct pci_dev *dev)
>  	memcpy(state->config_space, dev->saved_config_space,
>  	       sizeof(state->config_space));
>  
> -	cap = state->cap;
> +	cap = (void *)(state + 1);
>  	hlist_for_each_entry(tmp, &dev->saved_cap_space, next) {
>  		size_t len = sizeof(struct pci_cap_saved_data) + tmp->cap.size;
>  		memcpy(cap, &tmp->cap, len);
> @@ -1991,7 +1990,7 @@ int pci_load_saved_state(struct pci_dev *dev,
>  	memcpy(dev->saved_config_space, state->config_space,
>  	       sizeof(state->config_space));
>  
> -	cap = state->cap;
> +	cap = (void *)(state + 1);
>  	while (cap->size) {
>  		struct pci_cap_saved_state *tmp;
>  
> --
> 

-- 
 i.


