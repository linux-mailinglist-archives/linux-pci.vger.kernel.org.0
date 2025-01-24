Return-Path: <linux-pci+bounces-20322-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5A3A1B279
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2025 10:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80A17188F919
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2025 09:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AA31DB144;
	Fri, 24 Jan 2025 09:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HeX8lRsg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B19B320B;
	Fri, 24 Jan 2025 09:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737710382; cv=none; b=rUE7sAd1QWsVEnj8e1vGYsIO8e9RvohQGcT1E/oZ0nOgZqV0sRPQYSfLk0G07T5uP1evthKYOtiJE0+sUYRxOehbtp0Ni0lSi2ReKnK16HYKrY3jGiywEZfp0dNXlxLrUuTAQNexrsNfHcn92PezsMHHrV+wN+Do03BcPesRTLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737710382; c=relaxed/simple;
	bh=A1cfsVXr7AvdNLQPHVsurlhZ45q/aSIpKhMicMhh7to=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hBeRRK6bog/FypPRxfBU20/O4iacuwOVDb40JQA+6+OE/v4oRpa7zjZzKQHY/JPoPorQqCQxalBZjh7THpU62JF/VSVYBiKBLLdlJuJFwMwgUV9KqSP1TJQXP1w/QQOZ77dgDaSVX+cc5PAePuPiJLXsi+9YVAOaw5vR5Cghg48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HeX8lRsg; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737710381; x=1769246381;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=A1cfsVXr7AvdNLQPHVsurlhZ45q/aSIpKhMicMhh7to=;
  b=HeX8lRsgAAH0VAkUifbfPuFCLlodCyfiDmjPU9MsKsKlqiSZjnaD+uif
   AD9kYhhZzD5P35uWNwQ5HDPd0UhbThfjjpVf/zFHlE2zecTJiBZ3Z4gyF
   pa6UGqjkoxEnAalmBQAZHxrFz2Ok+D1KakWdC0dIgDySbqUkdromMgVVQ
   2KLe4Lxz5ecF9FiQNnAQeYmLeP7gN/IJh/exBPLp1OFmTjQTW7H8o/E9E
   1Yu/UysEEEw0VAO2hAAfW4o03MeeLpGJAMI7cV+4c6Fpqw1WvDnMiOVLR
   1VVn/y1pOVevLEy4J8IrCFHuS0SUdpxGJLMCL6WlJvTksid9EG1oR3urE
   w==;
X-CSE-ConnectionGUID: rNEtfK/bRKe3l65v9K0WGQ==
X-CSE-MsgGUID: b1TevFXiTKG/K+T2wyQt6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="60704099"
X-IronPort-AV: E=Sophos;i="6.13,230,1732608000"; 
   d="scan'208";a="60704099"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 01:19:41 -0800
X-CSE-ConnectionGUID: 9Bu5H3ndR7CU2ohHg1dEtw==
X-CSE-MsgGUID: BhGLZww2S2OA64ZDYqJtpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,230,1732608000"; 
   d="scan'208";a="107842091"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.158])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 01:19:36 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 24 Jan 2025 11:19:33 +0200 (EET)
To: Ma Ke <make24@iscas.ac.cn>
cc: bhelgaas@google.com, yinghai@kernel.org, rafael.j.wysocki@intel.com, 
    akpm@linux-foundation.org, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2 RESEND] PCI: fix reference leak in
 pci_alloc_child_bus()
In-Reply-To: <20250119070550.2278800-1-make24@iscas.ac.cn>
Message-ID: <46c252b0-880c-aca1-f6e5-c78ebe28a7a0@linux.intel.com>
References: <20250119070550.2278800-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 19 Jan 2025, Ma Ke wrote:

> When device_register(&child->dev) failed, calling put_device() to
> explicitly release child->dev. Otherwise, it could cause double free
> problem.

While the code fix seem okay, this double free part in the problem 
description isn't. The reference is held w/o this fix so it's not getting 
freed at all, let alone freed twice.

> device_register() includes device_add(). As comment of device_add()
> says, 'if device_add() succeeds, you should call device_del() when you
> want to get rid of it. If device_add() has not succeeded, use only
> put_device() to drop the reference count'.
> 
> Found by code review.
> 
> Cc: stable@vger.kernel.org
> Fixes: 4f535093cf8f ("PCI: Put pci_dev in device tree as early as possible")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
> Changes in v2:
> - added the bug description about the comment of device_add();
> - fixed the patch as suggestions;
> - added Cc and Fixes table.
> ---
>  drivers/pci/probe.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 2e81ab0f5a25..ae12f92c6a9d 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1174,7 +1174,10 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
>  add_dev:
>  	pci_set_bus_msi_domain(child);
>  	ret = device_register(&child->dev);
> -	WARN_ON(ret < 0);
> +	if (WARN_ON(ret < 0)) {
> +		put_device(&child->dev);
> +		return NULL;
> +	}
>  
>  	pcibios_add_bus(child);
>  
> 

-- 
 i.


